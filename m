Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E08206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWVXdaF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E08206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeK2BxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:53:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42802 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeK2BxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:53:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so23684836lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 06:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ajHurSNRwtNrFtV6PIPueDAKLX7oClZwfNaHBmZLEm8=;
        b=dWVXdaF4xoPiK4bRpMfxF1z7310rWKfT/o5rL2uML0A2a/4wGq62Blo/FuRl6YKKlG
         cHazFpwCukY/AuDxZ65sHJl09cOH/6yiYLSL/AWKhQjLQ10CCEVwrs32mWY/gylExWDy
         K8d063yrWPj/s4CAqM+bHZnah5tBJlTrHXaNTG/z8h0uNBD90NnEIuSl+iiAFdhGupUs
         r5e9NS8d3atHIx9BMbTIqiUE1FByUnaHSwtTqEguFzBvY4L5SNaD8zn9pEgf3KNWyDnI
         /j1ptPGheKIcWfxbyUL1hmgM53UiqxrM7pQ3rrdhxKFFbsMkG4XH4y49Fw2cVa07C/Nh
         eQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ajHurSNRwtNrFtV6PIPueDAKLX7oClZwfNaHBmZLEm8=;
        b=cv8OBJr+FLaDt22S1Kd3qkN48yqCpz+DWcG2KZZ5LGccZX3uGxGMbuGbH3rUje3gj0
         0Qu5+/3yJSvnQRc4T7Ao3ZaMVcTS+lQQagHbVciw/hGy5kNwhtRbB6UDY/hCclTiy2HD
         JL4PEbK700t6K1bXkNCtwxhWdo8UzrQip5xsg3NainZFHyPqpfCnaUfYjJk6GKQUnEJU
         pnPlPv/TwuDdF92zKlAq/sGzLAnWwboZDHKszkMjnmvAjZPZDNq5jDDhta5qi6txjzge
         1Z2aJ/mGeMw2zVDxue6OTOW6vIqvYk7s45cMEgk1dwIYrhocpT4HoUY527roiH1punk9
         TVLA==
X-Gm-Message-State: AGRZ1gLwb07lWk/NuJTey/WN8OepfKALX0u6ZEjTYp0rVBXLax5dZYZ/
        c4RjxGzaFhdAdazpw3QKMwOUrCbpGHrn+QU4ErI=
X-Google-Smtp-Source: AFSGD/Vjs69wQyxBZEnf8N+MJY6qmVp/lKO9ODvai2sRgVZXq4U75EnCvpJ5ccx5rsbXvbdMkH250ObVL4gLOPhWVm0=
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr22830722lja.24.1543416680181;
 Wed, 28 Nov 2018 06:51:20 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181115050724eucas1p169b2046c03e108035199a4481a82a560@eucas1p1.samsung.com>
 <1542258430-19885-1-git-send-email-huijin.park@samsung.com> <20181115102921.5117af90@xps13>
In-Reply-To: <20181115102921.5117af90@xps13>
From:   Huijin Park <bbanghj.park@gmail.com>
Date:   Wed, 28 Nov 2018 23:51:06 +0900
Message-ID: <CAMy0x0=H0pwHN09Bp_eKkHFHwbURFLt3MKJvBNC51TyqiZJyGA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: change len type from signed to unsigned type
To:     miquel.raynal@bootlin.com
Cc:     huijin.park@samsung.com, boris.brezillon@bootlin.com,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,

On Thu, Nov 15, 2018 at 6:29 PM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Huijin,
>
> Huijin Park <huijin.park@samsung.com> wrote on Thu, 15 Nov 2018
> 00:07:10 -0500:
>
> > From: "huijin.park" <huijin.park@samsung.com>
> >
> > This patch casts the "len" parameter to an unsigned int.
> > The callers of erase_write() pass the "len" parameter as unsigned int.
>
> Indeed. Perhaps it is worth backporting this patch to a stable releases?
>

It doesn't need backporting.
Because this patch is for enforcing code correctness.

> >
> > Signed-off-by: huijin.park <huijin.park@samsung.com>
> > ---
> >  drivers/mtd/mtdblock.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
> > index a5b1933..b2d5ed1 100644
> > --- a/drivers/mtd/mtdblock.c
> > +++ b/drivers/mtd/mtdblock.c
> > @@ -56,7 +56,7 @@ struct mtdblk_dev {
> >   */
> >
> >  static int erase_write (struct mtd_info *mtd, unsigned long pos,
> > -                     int len, const char *buf)
> > +                     unsigned int len, const char *buf)
> >  {
> >       struct erase_info erase;
> >       size_t retlen;
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
>
> Thanks,
> Miqu=C3=A8l

Thanks,
Huijin
