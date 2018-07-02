Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E54C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EF825E07
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpqMjcC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EF825E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeGBNr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:47:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52349 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbeGBNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:47:55 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so12206751itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtkf3Ac5mP825DrN6ghIWyLNMVzY4EjUjhDpzkRFs64=;
        b=bpqMjcC5ElRxni/Hvq2loo7pJA+1TNo/1xgNIzyXzW7c314XFEd9FFKd4tq/87QIrb
         fRJqZQK3+ZgoUmtiwRnEBmmkFKym/8i5atkg7huslEMvBISbme56/P6yynvHaHHTzscX
         0Z7b01RrshvDp4AMhhAABi6o6YiZcvjMxkbss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtkf3Ac5mP825DrN6ghIWyLNMVzY4EjUjhDpzkRFs64=;
        b=GUeYfTMB/LcRhzkGDrLu2LqgoNB5VX1zasULTGpTGhX/FZ9NQVJWQxYphq6qxkwt9c
         OCoj5j8YHqMa+WYUly4PHQ5lU2TsPja9uWQKzyehoLz3nyvHqyZUeYHjGoOyzLKo22FY
         L97JWfl+armMOEttv3zKYQxP7VoBu13YH4hAQGPa/uvR56CivkmCiFW/SIVzxiv3V6qA
         NblLHmXbOSlkPxP9WqcAvbe/6TeKgyllXi0Dkh3meR51sQGBvKKBpXsByO55OlD//Fym
         mSMF9aOAXArztVZPC2eVdF3UaoS3BHD39B1kO+FRmzHXNHMsGaj3oM+yaUtMWoFYZ2VU
         4gpA==
X-Gm-Message-State: APt69E2CnHPH1XRMlUgjQltTKFp3LjNGy7tkmp4JN/azRtSvtjAklgEK
        jPfQZyRPq2ZqMVMyu1FdiBRawa6hPb+dNWIzYKVVIA==
X-Google-Smtp-Source: AAOMgpex6l4M/rEMfJHuJJkpO4Oj4SQUm6deXKUiB/OnFcXSXyhxicaa3gFF048fsvxXcO6HXmI/H3nWVAiSVo0Rx+A=
X-Received: by 2002:a02:c007:: with SMTP id y7-v6mr3798228jai.87.1530539274572;
 Mon, 02 Jul 2018 06:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdaEsEAiGpieJK1AA8HHLzZc7Tdc932rhdayg06rFU1hNA@mail.gmail.com>
 <MWHPR02MB26232270DED605627B2CF22FAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <CACRpkdZb6NMHtai1DBa+7m2ieZJZiAB7d1vSuP376rHQKpOf+A@mail.gmail.com> <MWHPR02MB26239876530B0F5C95289A56AF4E0@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB26239876530B0F5C95289A56AF4E0@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Jul 2018 15:47:42 +0200
Message-ID: <CACRpkdZp+8ZFRF2c+pAy47ZSWjavu3Qo5fz6A41zDty444MWCg@mail.gmail.com>
Subject: Re: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
To:     nagasure@xilinx.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>, ada@thorsis.com,
        honghui.zhang@mediatek.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 6:15 AM Naga Sureshkumar Relli
<nagasure@xilinx.com> wrote:
> > On Thu, Jun 28, 2018 at 2:13 PM Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
> >
> >
> > > > This driver has the same problem as the other patches:
> > > > use the ARM_AMBA primecell magic numbers detection, and the PrimeCell bus.
> > >
> > > Here the child is NAND controller and the parent is PL353 SMC, so do
> > > we need to update this also as AMBA driver?
> >
> > No, sorry. The parent is spawning another device and you should indeed use a platform device
> > for that.
> >
> Ok, you mean platform driver model is sufficient for both pl353-smc.c and pl353_nand.c drivers?
> Or AMBA model is for pl353-smc and platform driver model is for pl353-nand?

The latter, AMBA primecell bus for pl353-smc and platform device for the
nand subdevice.

Platform device is for anything that cannot be autodetected with e.g.
magic hardare numbers, and the first device can be autodetected as a
prime cell but not the subdevice.

Yours,
Linus Walleij
