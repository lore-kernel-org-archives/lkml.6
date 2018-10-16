Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7E1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD8920869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqzoC60s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD8920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJPUbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:31:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40026 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeJPUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:31:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so17889622oib.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vENAup6evfpT5UsjzZe6Xq6qPlB8onFIu1ydE2f8DG0=;
        b=VqzoC60s9nUHLrwgWUXEbvN02wNcCbsPzNSgZwf6ftHyauXHINBT5MVoPYO7e4+jIX
         36WOY2sfcfuEqQVcpZydw5vsf2VanS3ubXX3lO8bU7GdLgmkebZMkjlSAaORntLMzBLT
         bCng8MvEwuhnveveCpgYli5syProAvp2ZSyrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vENAup6evfpT5UsjzZe6Xq6qPlB8onFIu1ydE2f8DG0=;
        b=pegAvL56u2KeXUH4A+bqWnhYB2c7Usag/OTGVYZzNXqitT34o3S/OI/q2Nw4X1XREk
         PzHmLApGIWVqDB2ky8qKtiVG/BNhWZHWzENVx1ag+YxA4YDBsfw8YDfL7xsWfRDxZiEb
         d2URB125r7+VV316ghw13lZQgVgz2li6jrFgK/MX9LH4QIpA7A0w1u2NaizUtQKY3AVo
         RQCggOz3noM1l1hjz76TktmM2AzvGPfHR6cHUbYw/FzWocPiK4bv9gm4xfEUYgtMgVd6
         5pHFuzU2hfos3l2jZL3fz0JfBCXzA5+OVkpEzzBRptC171S29K669aXe1ON17ry3dNsB
         hUUw==
X-Gm-Message-State: ABuFfoj3CEKHn86py8gL19N7tP1K+IitXROCROVnny2mciy1CWXSu3sm
        RygrP7qIQTRwDEiZBQANoyOjgQOjrryt/ebqUU7Afg==
X-Google-Smtp-Source: ACcGV62uircI7R4QGdAhVSUSsPx4rSK7/xqFC1lkU/MjjCYOyJT1ibb9HzQF+5jhGc8BW1YwTQ+K36p3MkVDfm2axxk=
X-Received: by 2002:aca:dd08:: with SMTP id u8-v6mr10837712oig.94.1539693694647;
 Tue, 16 Oct 2018 05:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-7-hch@lst.de>
 <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
In-Reply-To: <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 16 Oct 2018 14:41:23 +0200
Message-ID: <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 15 oct. 2018 =C3=A0 11:12, Benjamin Gaignard
<benjamin.gaignard@linaro.org> a =C3=A9crit :
>
> Le sam. 13 oct. 2018 =C3=A0 17:17, Christoph Hellwig <hch@lst.de> a =C3=
=A9crit :
> >
> > The DMA API does its own zone decisions based on the coherent_dma_mask.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Christoph do you plan to merge this patch on your own tree ? or would
like I put it directly in drm-misc-next branch ?

Regards,
Benjamin
>
> > ---
> >  drivers/gpu/drm/sti/sti_gdp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gd=
p.c
> > index c32de6cbf061..cdf0a1396e00 100644
> > --- a/drivers/gpu/drm/sti/sti_gdp.c
> > +++ b/drivers/gpu/drm/sti/sti_gdp.c
> > @@ -517,7 +517,7 @@ static void sti_gdp_init(struct sti_gdp *gdp)
> >         /* Allocate all the nodes within a single memory page */
> >         size =3D sizeof(struct sti_gdp_node) *
> >             GDP_NODE_PER_FIELD * GDP_NODE_NB_BANK;
> > -       base =3D dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL | G=
FP_DMA);
> > +       base =3D dma_alloc_wc(gdp->dev, size, &dma_addr, GFP_KERNEL);
> >
> >         if (!base) {
> >                 DRM_ERROR("Failed to allocate memory for GDP node\n");
> > --
> > 2.19.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Benjamin Gaignard
>
> Graphic Study Group
>
> Linaro.org =E2=94=82 Open source software for ARM SoCs
>
> Follow Linaro: Facebook | Twitter | Blog



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
