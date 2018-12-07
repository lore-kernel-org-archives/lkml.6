Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F32FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493D920882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRM0pdPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493D920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLGJGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:06:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42970 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:06:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so2461696lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyXZyVuWln+FdXPiecX+T10AQ2cJw5gUw8z/Ol4PoIE=;
        b=YRM0pdPLEKA+vMe1fhSjlT0OpGG/UGHoHDVCwLK+eviLNEyVYrgrAhzdMEnPQhAmK4
         AFy67dSKjZeq+XIdlj9Jzh/UXK3HjnJuVQsBPxLFKmY30DqiXNB03iFhZxvj8aIjLIrz
         QfvjOFHGElvWQCIbRzLVVftc2tGNq2271ZUzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyXZyVuWln+FdXPiecX+T10AQ2cJw5gUw8z/Ol4PoIE=;
        b=jiYMlM5mvnVGc7zbLz/AGflUxnYSVPpS9d9b4voDQbzX7gP2gTnIdTdY1dXHY4fNuw
         J/DrlX5ZAxRxrXJCum9yNrHFI5kksAZb0Y8uvzctlbdBFlmkHFWXdbu997aZFnpkDhBt
         SDNbl2gO4ZH6QD7OPl54XqndJWnim4ET+kPDmfpKG+rsgCcMzYdajEkyep0skQfbL6++
         JPEPdqmw0/+AUtLWfP8tQs907NuwyITegaB7uhZFhAOdSo/itrUsvbu6RpKvlwGRBqKP
         1zwRR6nVK32le8NpqQ9WSNbD19ZcprVDUJqAMsSNTVD81PeZs3x5TKf8V9fllvyH6J9E
         75Ow==
X-Gm-Message-State: AA+aEWabGS3FYxEIAJCJ0pxznRx48+vWWLieq1pHnC8d9PFOAgO9ccek
        LswJ/eaWEP4dSsfWXyRxCe1k6f2sye1aSxNKAKvUpQ==
X-Google-Smtp-Source: AFSGD/X6TeJUBQHzd6/o4w3mj3tWYptk2S6rlSUXlW1/9HVUxK3pmo/lL1MIESdT2u3Tae5ChsVtqJNH27f6tU7BwdY=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr756490lfd.149.1544173576434;
 Fri, 07 Dec 2018 01:06:16 -0800 (PST)
MIME-Version: 1.0
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com> <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
In-Reply-To: <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 10:06:03 +0100
Message-ID: <CACRpkdb83-kEwrip+t8g2VVFiREXspfWKQa2=Zd1ah1sSLNHjQ@mail.gmail.com>
Subject: Re: [ v3 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
To:     christophe.kerello@st.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Thu, Nov 29, 2018 at 5:42 PM Christophe Kerello
<christophe.kerello@st.com> wrote:

> +/* FMC2 Controller Registers */
> +#define FMC2_BCR1                      0x0
> +#define FMC2_PCR                       0x80
(...)
> +/* Register: FMC2_BCR1 */
> +#define FMC2_BCR1_FMC2EN               BIT(31)

Well this looks like an especially clever register map and a specific choice
of bit 31 in the fist register to activate FMC2. Registers 0x04 thru
0x7c are completely unused save for one bit.

It's almost like this is the good old FSMC integrated in parallel with FMC2,
so that if you don't set bit 31, this becomes something that can be used
with drivers/mtd/nand/raw/fsmc_nand.c, and FMC2 mode is activated
by setting this bit, activating all the new registers.

It wouldn't surprise me given how HW designers like to work.

Is this the case?

If that is the case I think it should at least be mentioned in commit
logs and DT bindings and possibly in a comment on the driver
itself.

Yours,
Linus Walleij
