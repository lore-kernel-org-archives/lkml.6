Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC444C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773552082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9C0GWeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773552082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJZC6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:58:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46721 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeJZC6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:58:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id i4-v6so10295413wrr.13;
        Thu, 25 Oct 2018 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTfnVu+HhfRJVwMWkB68Hz4tsFpDxb1yq1ep7I7iCGs=;
        b=j9C0GWeSTmpukELzCcZP5I7A9EDgPrePbvO2GC+Uy+YVcsXeLJXrExQ3GKqJbdLlsD
         wEef9XABUjF4QKd2xysS8SDc4in1hzd66FqPhllnnEH533T+1AFJc21NxnvGGb1g83pK
         uHxoKleBXeedmnrgAWOpglumSrMKOJUWUd6IFN847S0ZETkepX8+vIqVkZqiaksddwH/
         NkN8VJymlQ6Amqur4qX2i+dhSlF0jbr399YDRE2XIXYo1KrhpZa9m9fsPQtkyWdV6DDz
         4Qu5eqbYEro+52eOVjVFw+Y3rUpNXz1+FL6KEBESLTxXmP8QFrqqnSaIut/6fwasiC66
         aHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTfnVu+HhfRJVwMWkB68Hz4tsFpDxb1yq1ep7I7iCGs=;
        b=UYMRWeo2dPctMeX9Z/W6NxE27ocwwyMfByYocrxE0LG8aV708i9oPBgWKuvU7ycKaG
         EjWML8dPXTfQ4x5Z1USXSpRhAzqkG64j7FscGczfnBMfjxZLfgzo1mgCwlFVGN7jdZwn
         IVjO7nySqUWGK9zljE8ogAYKMWLXxbGDi3+8QH9h2gaM+wv5HBNXdyL2Auqf6QPbj4Wt
         kdcjsck7L45jQKKNyZ2YfOd7n9OHaTZkxynyJC8BDFI6MiMpJY8+SD5JuF2RzdEmjPpv
         uNHjIM5Cy8v4oZZMAyfXWT7znCezkRxaeeu4Hiq3C0J506FZqrPy8qZJma9flEPZsHH5
         D1Gw==
X-Gm-Message-State: AGRZ1gIiySPf1ECZmgAO/b0lsy8Ih2HAT7fxV1yzThhTymqm0YaBP4Fb
        YuCLCYvj4AI6RcQXzuf7qXL/Ottai/9ADx0B2wE=
X-Google-Smtp-Source: AJdET5ddw4H6Z7qGcHpDzny09xgaUCeycKwPo1WmeZxPQMgVQws7DUV6ogkzGr9BDK5I13M31PM3vT8HOzn9sD+HxE0=
X-Received: by 2002:adf:9589:: with SMTP id p9-v6mr3064566wrp.270.1540491869751;
 Thu, 25 Oct 2018 11:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <1540116359-164086-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1540116359-164086-1-git-send-email-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Oct 2018 14:24:17 -0400
Message-ID: <CADnq5_OSqxu_e88dmh57eiq2y78jKrQkarDXNYpeSWCe066DrA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/radeon/kms: remove set but not used variable 'pll'
To:     yuehaibing@huawei.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 11:32 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/radeon/radeon_legacy_tv.c: In function 'radeon_legacy_tv_init_restarts':
> drivers/gpu/drm/radeon/radeon_legacy_tv.c:435:21: warning:
>  variable 'pll' set but not used [-Wunused-but-set-variable]
>   struct radeon_pll *pll;
>
> It never used since introduction in commit
> 4ce001abafaf ("drm/radeon/kms: add initial radeon tv-out support.")
> Also remove related variables 'dev, rdev, radeon_crtc'
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_legacy_tv.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_tv.c b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> index 4278272..3dae2c4 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_tv.c
> @@ -421,24 +421,14 @@ static void radeon_legacy_write_tv_restarts(struct radeon_encoder *radeon_encode
>
>  static bool radeon_legacy_tv_init_restarts(struct drm_encoder *encoder)
>  {
> -       struct drm_device *dev = encoder->dev;
> -       struct radeon_device *rdev = dev->dev_private;
>         struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
>         struct radeon_encoder_tv_dac *tv_dac = radeon_encoder->enc_priv;
> -       struct radeon_crtc *radeon_crtc;
>         int restart;
>         unsigned int h_total, v_total, f_total;
>         int v_offset, h_offset;
>         u16 p1, p2, h_inc;
>         bool h_changed;
>         const struct radeon_tv_mode_constants *const_ptr;
> -       struct radeon_pll *pll;
> -
> -       radeon_crtc = to_radeon_crtc(radeon_encoder->base.crtc);
> -       if (radeon_crtc->crtc_id == 1)
> -               pll = &rdev->clock.p2pll;
> -       else
> -               pll = &rdev->clock.p1pll;
>
>         const_ptr = radeon_legacy_tv_get_std_mode(radeon_encoder, NULL);
>         if (!const_ptr)
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
