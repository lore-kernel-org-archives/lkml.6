Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0243FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B508622419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9QMNLq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B508622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbeKMCG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:06:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36539 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeKMCG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:06:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id h192so6586515lfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRGD8zhWkHchDC7PtnDjUMIqDk/KRXDdmAqSruj1iLw=;
        b=d9QMNLq3cmEL9CJrN/2CUAK05loDMefJA0Ng4yQG1UH+KlJukkbQBoyeFna1nAvMmG
         Pcl54xW7DyKCO0+RRBeZ0mk2cxLhljXRmd7C9w1fSuks9Iu68WhCU5Yb0BYFaBormdzD
         QP3eGQ+tbnMk62sQcvb3CxJFpxK35pdK92XeS4p1vBhloXShbP9rxU2rbHxLtup8V9/Z
         TJhzf5kCBgOt6B0u0xoyyqp9g7DiLSM339ybognmK22cUod17Y2whA45B0E9RN87S+xD
         2vitrbUvqon7+7MGEc0oyKtAs8iTzkWym0k3APmBLYzJZAAWVitUxLlwfKIoKkq3sl5R
         NuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRGD8zhWkHchDC7PtnDjUMIqDk/KRXDdmAqSruj1iLw=;
        b=RmVIzdhVZcyO/V7D4Ps5vH3a986Yhp29UPycMzLG51htxa7YfNTj6ZU6c4pzVcNW/O
         4XC7boTiwAmtel4DPEwG3uKKTftiDlzBMcCUc8mTiXfgb3WVrhgL3TG4b9RFKtlWamv0
         u+wTo0JQlTomkJOn5edScwtgR4fRLAb6VHviqn1Kblu23jyYP3PR34x4KsUlYJZZRpu5
         BTia2jGyutAZTPy94GnGPDZyuJTr2f7aRDZ/50GrW90IyD5JiUPtVdbALjHh1zPm7NgZ
         pa2GePbUlRxSF9JC3AKzrfhQYjvRhPGUr903jaH6bGWq5+axAazLEgethWcv9rkBG+wG
         5xdw==
X-Gm-Message-State: AGRZ1gIYyDFikTavugUOAAwt3i60D4Bus7MoRKMZtN1XfOPqnkE3f64r
        cPk9iDGO58CPhxnPelp14JWWpbBXklvV7Nb61Uw=
X-Google-Smtp-Source: AJdET5fbvqplKPxURfxXQPuGjQFie79/hCzricrhYMwZPYNZRoileyv+NP21wX0mV4LETs+8xXpbPXsDfpiKu7jAUyY=
X-Received: by 2002:a19:ae03:: with SMTP id f3mr1048624lfc.86.1542039180489;
 Mon, 12 Nov 2018 08:13:00 -0800 (PST)
MIME-Version: 1.0
References: <CGME20180823072813eucas1p2a534b4be94a3a2bc3480adcefca2ca22@eucas1p2.samsung.com>
 <1535009282-1480-1-git-send-email-huijin.park@samsung.com> <20181031145505.6b034b84@bbrezillon>
In-Reply-To: <20181031145505.6b034b84@bbrezillon>
From:   Huijin Park <bbanghj.park@gmail.com>
Date:   Tue, 13 Nov 2018 01:12:48 +0900
Message-ID: <CAMy0x0ngjNugPO0aN0c0hACsw3qQE0rgLwfuMaX5+L7+DhXp2w@mail.gmail.com>
Subject: Re: [PATCH] mtd: cast to u64 to avoid unexpected error
To:     boris.brezillon@bootlin.com
Cc:     huijin.park@samsung.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

Thanks for review.
I will send patch again.

On Wed, Oct 31, 2018 at 10:55 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Hi Huijin,
>
> Subject prefix should be "mtd: spi-nor: ...", and please replace
> "unexpected error" by "unsigned int overflows".
>
> On Thu, 23 Aug 2018 03:28:02 -0400
> Huijin Park <huijin.park@samsung.com> wrote:
>
> > From: "huijin.park" <huijin.park@samsung.com>
> >
> > the params->size is defined as "u64"
> > and, "info->sector_size" and "info->n_sectors" is defined as unsgined and u16
>
>                                                  ^ are          ^ unsigned
>
> > thus, u64 data might have strange data(loss data) if data is overflow.
>
>                                                     ^ if the result
> overflows an unsigned int.
>
> > this patch cast it to u64.
>
>              ^casts info->sector_size to an u64.
>
> >
> > Signed-off-by: huijin.park <huijin.park@samsung.com>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> > index d9c368c..527f281 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
> >       memset(params, 0, sizeof(*params));
> >
> >       /* Set SPI NOR sizes. */
> > -     params->size = info->sector_size * info->n_sectors;
> > +     params->size = (u64)info->sector_size * (u64)info->n_sectors;
>
>                                                 ^ this cast is not needed.
>
> BTW, I doubt we'll ever have to deal with NORs that are more than 4GB,
> but making static code analysis tools happy and enforcing code
> correctness is important too.
>

I agree that enforcing code correctness is important as your said too.

> >       params->page_size = info->page_size;
> >
> >       /* (Fast) Read settings. */
>
> Regards,
>
> Boris

Thanks & best regards,

Huijin
