Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29EC204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUW+3Ifl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29EC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeIJLiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:38:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43036 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJLiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:38:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id m84-v6so16870608lje.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKjI7OcPAZOLqTChtXk7dZaNfTGdof+2cOxnYItM/cI=;
        b=uUW+3Ifl6rrGeOahvbH/47NoTbhDg1cg8e9UQeyr4EBWmY+dVLM4gWK4qfE+5fVuKQ
         ybRjJ2ModJ5kkCO+AqjAgaPO7f0qn4o2Cf/tjoQ8p1g+CZs7DMpb4TJ6e30noyVWG51n
         M5CPy9t4iQnhvZntmenuhK5JM7UlKaKLzWNk+0yipFBzIQO6WFCxhrRYjMiW4h3FUp0e
         8vvNLni4SfGhexucSUxBd4vX0fyX+6qB+io0nbV8bk8xmKJ7LZ5+JlanNSbmLtfO5uml
         phDivg0pdXrpBmRWbnKrIWT6oPXS1L6g10LAL/2T1s1E8Bbu8FL634tB0B0ZK6B6Te63
         MEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKjI7OcPAZOLqTChtXk7dZaNfTGdof+2cOxnYItM/cI=;
        b=n+2hNyJJv1tuLdF7FSWe7ZpF7LLLNTPIDwas4pGSBBOUZ612OxpTsbbzn+k07LFqOj
         w/vNeCktKm4loWZ5A7YY8TDCqC7Tj/56E5XZgg600R1H7bU0n75/dNgrWXLHGGu41kcU
         df5e+10ebGitXT5frLGEiAuyhdFPZe+jvuMZjhzCm+sDb4QQjvE5nM9uUP0rsHO+OfHi
         wy3BqmjP1kVd6G/iAEALLimS+AdKvunHAAf3M35QRQQhtnF9/iSyKrC/xtByjVFn6CUE
         1gp+5pGEuumUXQTyZMxihgDz+CUFQceyD9XOT+tPg/eg/YtUqzWu34ELNFt5uByy6WSa
         V2ug==
X-Gm-Message-State: APzg51CDpHOzQL0nudc1gEWkb6e422fkNa3pf/H5d2cv7mwbWg1G9qmT
        PKfqIv911Wk5ykyjju5M7aEJJzZFQZaY/WTRpYdJsQ==
X-Google-Smtp-Source: ANB0VdbdYBAlNBgKVGupayP9mV/JcoB6QCqE2U3zN7cv0Q5KChMWKHHYBsuj8jJnqgvRyE7Dk/2UA+RuCslSmbS1r6o=
X-Received: by 2002:a2e:4619:: with SMTP id t25-v6mr12005428lja.96.1536561936146;
 Sun, 09 Sep 2018 23:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180808161641.GA20483@jordon-HP-15-Notebook-PC>
In-Reply-To: <20180808161641.GA20483@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 10 Sep 2018 12:15:24 +0530
Message-ID: <CAFqt6zYn_kf+sQ0Dih83CH7hVR2f6ZW-ANVRm9+MX54KcMk=jQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tilcdc: Convert drm_atomic_helper_suspend/resume()
To:     jsarha@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 9:43 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>
> saved_state in tilcdc_drm_private will not be used
> anymore, so it can be removed.

Any comment on this patch ?
>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 14 ++++----------
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h |  3 ---
>  2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index 0fb300d..33e5332 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -554,29 +554,23 @@ static int tilcdc_debugfs_init(struct drm_minor *minor)
>  static int tilcdc_pm_suspend(struct device *dev)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
> -       struct tilcdc_drm_private *priv = ddev->dev_private;
> +       int ret = 0;
>
> -       priv->saved_state = drm_atomic_helper_suspend(ddev);
> +       ret = drm_mode_config_helper_suspend(ddev);
>
>         /* Select sleep pin state */
>         pinctrl_pm_select_sleep_state(dev);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int tilcdc_pm_resume(struct device *dev)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
> -       struct tilcdc_drm_private *priv = ddev->dev_private;
> -       int ret = 0;
>
>         /* Select default pin state */
>         pinctrl_pm_select_default_state(dev);
> -
> -       if (priv->saved_state)
> -               ret = drm_atomic_helper_resume(ddev, priv->saved_state);
> -
> -       return ret;
> +       return  drm_mode_config_helper_resume(ddev);
>  }
>  #endif
>
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
> index ead5122..62cea5f 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
> @@ -70,9 +70,6 @@ struct tilcdc_drm_private {
>         const uint32_t *pixelformats;
>         uint32_t num_pixelformats;
>
> -       /* The context for pm susped/resume cycle is stored here */
> -       struct drm_atomic_state *saved_state;
> -
>  #ifdef CONFIG_CPU_FREQ
>         struct notifier_block freq_transition;
>  #endif
> --
> 1.9.1
>
