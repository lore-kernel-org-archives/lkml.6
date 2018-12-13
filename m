Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D291C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0CE20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9ai8p7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0CE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeLMKpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:45:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34338 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbeLMKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:45:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so1369248ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aD3bEl1PLw1O4JrMCu6VZVQZdsTElDNWitfxMX/UKmw=;
        b=E9ai8p7dOY/KX2c4Ww7/mbnGfRQl37+LgPy3extQdKaCFh6ongTgu0yN4FNkggK7Mm
         Kqtft2KOl5kdlhsFDN+lyNr9GU6yn3sAfGnPWwqrYO14FnLw2GmOLNC6t7j22SvTQZQ7
         l9ed+F78G8frilyOuSUnARBgAgjBpnfpJ/nZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aD3bEl1PLw1O4JrMCu6VZVQZdsTElDNWitfxMX/UKmw=;
        b=S5SwnE2/tl5jnm2DFfBy0kLxJq7prJAx/zDVv7cVOz3ooMsK6+02MXTvLKrBGARQd5
         cvTTCM6QnwleNCCgsYLKtyQwbjqGS5ymO6qaybmSduyLAt5nlU3L6hPLfKy/bAw1XRRG
         CUIBbek/3CAQNNp/oFUM/kWM6UV6NrA/G711PL9j6KiT1Sfnzd1PTed+QI3qhgZULUBG
         RucrIgI1rgj1+sbPb1F61fYhrWls7okvGEa+dyJeF+/l923qe+/i5zzRC/r7TmIJnX7/
         KKlaxf3Hk7zZ24uOPNrRZgdZBZRs164hj+447Ln3riFlxVb2i9LagNJYFq9KwRBcF06+
         H14A==
X-Gm-Message-State: AA+aEWbg9QsaozDuMaVXTm/E+kM5t/hZqGSuR157ugz8z/MM1SavTEv/
        UI3GmATcXG7uk8o1NLGcMxkhzY2sRdG2E9p8Aaq29w==
X-Google-Smtp-Source: AFSGD/WNq1DAeZX/a1ozEjGMsLXDfsmhBGji1XmppXNKBfgxV2w9EURqNVdKOZ9uO7qf0x/wIbJENgvHxUB0fgrTUBk=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr14313631ljp.12.1544697947555;
 Thu, 13 Dec 2018 02:45:47 -0800 (PST)
MIME-Version: 1.0
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com>
 <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
 <CACRpkdb83-kEwrip+t8g2VVFiREXspfWKQa2=Zd1ah1sSLNHjQ@mail.gmail.com> <7c295246-8756-9363-a891-856ddf7af92b@st.com>
In-Reply-To: <7c295246-8756-9363-a891-856ddf7af92b@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Dec 2018 11:45:35 +0100
Message-ID: <CACRpkdbiX=9tDnE+tR7Jj-QEY_=_MvS9v8Jg8X7MzQcX7aPp-Q@mail.gmail.com>
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

On Fri, Dec 7, 2018 at 5:53 PM Christophe Kerello
<christophe.kerello@st.com> wrote:
> On 12/7/18 10:06 AM, Linus Walleij wrote:

> Based on FMC2 datasheet,
> The FMC2 controller includes 2 memory controllers:
>   - the NOR/PSRAM memory controller
>   - the NAND memory controller
>
> The NOR/PSRAM controller mapping is starting at 0.
> The NAND controller mapping is starting at 0x80.
>
> We have only planned to develop a driver for the NAND memory controller.
> There is currently no customer request to develop the NOR/PSRAM memory
> controller.

OK I get it, so there is no FSMC (v1), but a NOR controller, thanks!

If people need to access the NOR controller I think they can just patch
your driver to handle both or have a second driver on the side
(I suspect the pins are anyways set up such that you can just
use either NOR or NAND.)

Yours,
Linus Walleij
