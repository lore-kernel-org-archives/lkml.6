Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC8420868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/bmBIMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC8420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeLGMrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:47:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46700 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLGMri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:47:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so3402910ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEpBVELC5d0uvQAti1WsPo6Q3cQyeZwtDnWcvc9xcIY=;
        b=f/bmBIMs+YjZ5ZYr9OZfr8bdmvM+kG2+hw3ZuX9r/rWxoAt+Bkq4z4kgmZfulPI4YI
         j44xwDn5V6jwzulffRiP4tJbPxc+o/0tzu2afLzfKmO/N7degQ7kvS9b22vxOJ89Tf5D
         KzKHlfoFK04hVFVCs229PDjpktOLVBdNcUBs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEpBVELC5d0uvQAti1WsPo6Q3cQyeZwtDnWcvc9xcIY=;
        b=cQbJadch3YqxL9VRR1vbCgBC1xlN65Q3S3B2CIYtx2mhreDTcT01fo8NU9SBXbt4WV
         XVAg3n44rPl1Bdm/upjbYGu6iE6JptwXc5LPP614RoxHpSAwoVxyAMLiYIwIw0FQkcNA
         uSxKgsjRW5v5eTo3g/h1LsRLsTNU0WWKBwxrj8XOdrwLynL43BLVqDOSdijd0fQCs5kJ
         /EPeug6BIUQT3yMc4BSHfBngfN/cBbLc9ojvl0i7g1i5LCtr8kKEbPQXN0NXh2xVdJOI
         KLmlEGpVW5qzIZCRJsiKAIyQpyJm7e4W6yaL7IAeX1oZxmkK4MU8GiOmECx1Y4+xqsRe
         TpWw==
X-Gm-Message-State: AA+aEWYCOrI7VtHP80pMIDWxX1H9V3xff3k4oPX+Dp7ktqsxRsOJIeI3
        qcgMh5frQZIkxy3532cCe2wxV9jFp6RPJsMIsSXpCQ==
X-Google-Smtp-Source: AFSGD/WiqcswWHJVTZiPCrEkDaskDJ+Co5uz6pc1SNMJGdL7R+PrD7K4iuZLE8y6Y8Rk6M/eimNzsv4SFpULmWx+U7Y=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr1303399ljk.4.1544186856136;
 Fri, 07 Dec 2018 04:47:36 -0800 (PST)
MIME-Version: 1.0
References: <1543509663-26128-1-git-send-email-christophe.kerello@st.com>
 <1543509663-26128-3-git-send-email-christophe.kerello@st.com>
 <CACRpkdb83-kEwrip+t8g2VVFiREXspfWKQa2=Zd1ah1sSLNHjQ@mail.gmail.com> <dafcda21-fceb-1577-7f1c-41f1009b99a7@st.com>
In-Reply-To: <dafcda21-fceb-1577-7f1c-41f1009b99a7@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 13:47:24 +0100
Message-ID: <CACRpkdbim9o+3n-hvtVT-ybfHfYF38xQ_V3utf9adbTNMYOhRg@mail.gmail.com>
Subject: Re: [Linux-stm32] [ v3 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2
 NAND flash controller driver
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     christophe.kerello@st.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 11:22 AM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
> On 12/7/18 10:06 AM, Linus Walleij wrote:
> > Hi Christophe,
> >
> > On Thu, Nov 29, 2018 at 5:42 PM Christophe Kerello
> > <christophe.kerello@st.com> wrote:
> >
> >> +/* FMC2 Controller Registers */
> >> +#define FMC2_BCR1                      0x0
> >> +#define FMC2_PCR                       0x80
> > (...)
> >> +/* Register: FMC2_BCR1 */
> >> +#define FMC2_BCR1_FMC2EN               BIT(31)
> > Well this looks like an especially clever register map and a specific choice
> > of bit 31 in the fist register to activate FMC2. Registers 0x04 thru
> > 0x7c are completely unused save for one bit.
> >
> > It's almost like this is the good old FSMC integrated in parallel with FMC2,
> > so that if you don't set bit 31, this becomes something that can be used
> > with drivers/mtd/nand/raw/fsmc_nand.c, and FMC2 mode is activated
> > by setting this bit, activating all the new registers.
> >
> > It wouldn't surprise me given how HW designers like to work.
> >
> > Is this the case?
>
> No, it is the same story than for stmfx driver, it looks to be the same
> from registers
>
> point of view but internal hardware block design is completely different.

I'm not saying FMC2 is the same, just that it seems they have
duct-taped both IP-blocks (FSMC and FMC2) together at some point.

It just looks so extremely odd to leave all registers below 0x80 unused
except for 0x0 where a single bit is used.

Maybe there is no FSMC there, but it sure looks like the hardware
engineers planned for old+new FSM[C] block coexistence in the
same address space.

Yours,
Linus Walleij
