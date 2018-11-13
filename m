Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3068C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEA8223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9TbVBp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEA8223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeKMVG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:06:58 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46355 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeKMVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:06:58 -0500
Received: by mail-ot1-f50.google.com with SMTP id w25so10192121otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4YJFATsFVNa+JpUMbBsVkqVbvYHE+WeYf5fsB5ihjU0=;
        b=U9TbVBp3bCixNFBXNewLHkOBMRW9mCJFsiRfuelHeeykbl13KRVEK+6jbvjQDf0w9t
         4Og89Cn347syfzbPBM8Qpx3F4I+sexcm+XFxOhPJhi6UPK9zNyW2n3Wa9XpPVxR6Yb2d
         3N/gH6X9b/tw6ZJZs4Zr1b3Lj5ki/A+65CWYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4YJFATsFVNa+JpUMbBsVkqVbvYHE+WeYf5fsB5ihjU0=;
        b=pGvQEEKDuzKQqs4ptj56iJ4SI92/lEV7e17VRaYuvhomwgg2A+AfMaEWEdjqWuoTkX
         LiKaclOStG55ZjBAwafxNA98t+WBNLKLHa8d1IMsl1kQIIINeMoQe797U6HmV34r6l+S
         YLz7BnqaE+PaufWWDTNp22Oej7RnVyTUAkPWBjs0+0LYhrm5PYynZgJe1C6dXIUWbtAz
         Ns7IlAWz5yYJebk82tqzWewJpteWvnhTe7AWL6IuFI6D3CfsFc+JeiVcvtBgcr52rDOU
         7xzoAWAbrvDgzJJuh3T2POXtf6atbRbrnGWTmieeYFtTRymkKCfa0ulxJxVBIyOXdm+M
         UvGA==
X-Gm-Message-State: AGRZ1gJ8bJwUjvHdLJy46SQaKKl5aH4ecSUKpmhe6NPEKO4Tt3R8iVM8
        8cwoGsmYzdi+EFXCYvk9T9ouQvk2No3TvgRlbq/kcg==
X-Google-Smtp-Source: AJdET5c+ykImzImHmq41FarHFB2YLyqeIFkBIUZ9L21Bz4LI1ZoWEKyTS+YysoFaHEzugX9UBS59zTM8UXe1JWaqV28=
X-Received: by 2002:a9d:26a1:: with SMTP id l30mr2679124otb.344.1542107361527;
 Tue, 13 Nov 2018 03:09:21 -0800 (PST)
MIME-Version: 1.0
References: <1541818660-37168-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1541818660-37168-1-git-send-email-yuehaibing@huawei.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 13 Nov 2018 12:09:10 +0100
Message-ID: <CA+M3ks56PBoH3_H4a-DPKooGwx41T=K9XW5KhdRSTwRCYyOXGw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/sti: remove set but not used variable 'priv'
To:     yuehaibing@huawei.com
Cc:     Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 10 nov. 2018 =C3=A0 03:48, YueHaibing <yuehaibing@huawei.com> a =C3=
=A9crit :
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/sti/sti_crtc.c: In function 'sti_crtc_vblank_cb':
> drivers/gpu/drm/sti/sti_crtc.c:255:22: warning:
>  variable 'priv' set but not used [-Wunused-but-set-variable]
>
> It never used since introduction in
>   9e1f05b28009 ("drm/sti: rename files and functions")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied on drm-misc-next.

Thanks,
Benjamin

> ---
>  drivers/gpu/drm/sti/sti_crtc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crt=
c.c
> index 61c2379..ed76e52e 100644
> --- a/drivers/gpu/drm/sti/sti_crtc.c
> +++ b/drivers/gpu/drm/sti/sti_crtc.c
> @@ -252,10 +252,8 @@ int sti_crtc_vblank_cb(struct notifier_block *nb,
>         struct sti_compositor *compo;
>         struct drm_crtc *crtc =3D data;
>         struct sti_mixer *mixer;
> -       struct sti_private *priv;
>         unsigned int pipe;
>
> -       priv =3D crtc->dev->dev_private;
>         pipe =3D drm_crtc_index(crtc);
>         compo =3D container_of(nb, struct sti_compositor, vtg_vblank_nb[p=
ipe]);
>         mixer =3D compo->mixer[pipe];
>
>
>
