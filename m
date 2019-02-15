Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D3D21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAGgJMQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbfBOT6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:58:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33233 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOT6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:58:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so5334021pfb.0;
        Fri, 15 Feb 2019 11:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouOsaD2yvbHYJu6XT2SnIQFXfqdWR5DyARa34t5/lAs=;
        b=KAGgJMQpty/sQmDzblWhfFvNFrsUexCPr/hAyIrZWqizkbNnELJ3pesOq0zgzkXr7m
         UYjRjxR5nHRB9mA9hmmxwnWPWKGLM0FuGvtuhgt1a5HsTvS5A48fsNC+IyrQbHtj2Xis
         roAgbd6RvYjuFPXAg30GIv2WBQZ0McZv00+SQXU11tvmSSMGZh8N/fdQQ447umiJwfnF
         xHQGaxuA1Vgef7weHoszDdhXt5qBZFcNX1FMnIaZ1aFUieOUIXrlk8iO9sEjXqdgztfX
         2P3ZRDY4ozsmkAbwZYpEQDA7xWRJAWH5XIKlsKNnNZU4M8O0jS71CeGv2Uu3QRSWgQdZ
         260g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouOsaD2yvbHYJu6XT2SnIQFXfqdWR5DyARa34t5/lAs=;
        b=G5zFhHLe0UqU/l4VpHvzt1IqIS2IzHZJjm1TkqKjYHNRPturd6wl29UJE7CTQ1Aoso
         V3neb3Em1U5Etc+mGCxDxPA8IQhdovYFYqE4aLor/EEMjwnd4PIOHu3J8M43Tg055SDl
         3YoS1JvmmNgaw9RQF560mcVHls5xpwuHq4m8W6NglG7tJs2hJvzy/I3rhuilX6HJrteD
         mqJ2ivbYBaPSJdnE1lFcRljpPojjv7NRzvqenYDaRSJTveHHXrf83xdzLPSeoThUkgvX
         5TZLmuS9YsxzhwcFbffiSeiYnC536InoNjemup1XGDx4Yu9TNvdxHYQlFVekKjfO8gmc
         Em+g==
X-Gm-Message-State: AHQUAubAhYng7DNX7KYSU3c/JYQDX9PwFHTWMRsmu+/VMJ+n7UB8J3XK
        UyQI4YGJrY89y3+DD6z5rrdfNIQNy/A/MCPcblrcWgnx
X-Google-Smtp-Source: AHgI3IZj56+NK8D0lmKFq88/G+arhGPB/Nttfep56i0yiDK7qUpDFn5NoyozOAlvb3kW/C0vndM7RLQI9XUnd38se8s=
X-Received: by 2002:a63:f148:: with SMTP id o8mr7004923pgk.337.1550260683290;
 Fri, 15 Feb 2019 11:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20190211130940.28206-1-hch@lst.de> <8d8a1ad0-2192-5293-9073-21d1916778ff@gmail.com>
In-Reply-To: <8d8a1ad0-2192-5293-9073-21d1916778ff@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Feb 2019 21:57:51 +0200
Message-ID: <CAHp75Vc3cBcCb7Rsd1S3LX32_ZrCCPMcrtMtqPioadowrhh-0w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell_rbu: fix lock imbalance in img_update_realloc
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 5:56 AM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
>
>
> On 2/11/2019 7:09 AM, Christoph Hellwig wrote:
> > We need to ensure rbu_data.lock is always held on return.
> >

Pushed to my review and testing queue, thanks!

> > Fixes: 289790a3ea94 ("platform/x86: dell_rbu: stop abusing the DMA API")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/platform/x86/dell_rbu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
> > index 8104ca0c44ca..031c68903583 100644
> > --- a/drivers/platform/x86/dell_rbu.c
> > +++ b/drivers/platform/x86/dell_rbu.c
> > @@ -436,6 +436,7 @@ static int img_update_realloc(unsigned long size)
> >       ordernum = get_order(size);
> >       image_update_buffer =
> >               (unsigned char *)__get_free_pages(GFP_DMA32, ordernum);
> > +     spin_lock(&rbu_data.lock);
> >       if (!image_update_buffer) {
> >               pr_debug("Not enough memory for image update:"
> >                       "size = %ld\n", size);
> > @@ -446,7 +447,6 @@ static int img_update_realloc(unsigned long size)
> >       if (WARN_ON_ONCE(img_buf_phys_addr > BIOS_SCAN_LIMIT))
> >               return -EINVAL; /* can't happen per definition */
> >
> > -     spin_lock(&rbu_data.lock);
> >       rbu_data.image_update_buffer = image_update_buffer;
> >       rbu_data.image_update_buffer_size = size;
> >       rbu_data.bios_image_size = rbu_data.image_update_buffer_size;
> >
>
> Acked-by: Stuart Hayes <stuart.w.hayes@gmail.com>



-- 
With Best Regards,
Andy Shevchenko
