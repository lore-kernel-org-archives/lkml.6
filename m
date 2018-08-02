Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED048C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE64208E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIPeV/vY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE64208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeHBIPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:15:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36284 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeHBIPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:15:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so907908lji.3;
        Wed, 01 Aug 2018 23:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YF3f3L/vrih68cvl3jbgFpFkHPlFnhqE6Mc5/JLh8ws=;
        b=RIPeV/vY5eELawh6qHNrr71i71U7iPXaUruwynOefHcI3zh/EYMsSZ127hsOv6e33w
         XdymZ2D+afTVztkS7Z4V5RR22iH6YxqBIkZBbwBb5aXGGC5BzCDdB0v8N8znquxxW089
         kxGgYcvMNdJANXVIDDueVUC09n7sgcWpAjVpStwZ/ow15kULGdfeX6URF1X8smEXXZbl
         Ih2Go9RipHnNlmYV8gJ6SKYD6go0Zg/+fDBec+Mb+8gYvrW8jnv0K73oYZIKWDArM5Cu
         GIT5wdEdiI2d0zRvwLYh+kkcmbPf0ZzDdbOzPQ9xLwvA1ENizU0apEtUoZvtssuCkr0a
         aDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YF3f3L/vrih68cvl3jbgFpFkHPlFnhqE6Mc5/JLh8ws=;
        b=YRx3POQIkcT64p2s1DCyEt0eLgupTtWqjeL6DgnE6MV7cwdUWMlfamzBQBrdKiOBTp
         tukVHum3Vjh3/MsNCQhCkjAlOrFweswvT4VvmaU2PoZw1hv9xrOAdxdn3cIANhJpK/YP
         3+nN0++ZgRY6kHnCa6h7WqUVUboRcIbzADOWyvNZ6fAnftLpp9S3baIResOzn22RdAEW
         IHmQPsGfyw0kITm641JCBWu8m6WndouKoo3nebdBeKxddHb4DMFzSu68ZZgJu0eMxx4q
         ZezOjCu/ShLUSCWd05hE8ZyDHzfy/ZPsQA/15RgHcoWd1ufvrcxZHvIdcOvIPAU70cAE
         j2pw==
X-Gm-Message-State: AOUpUlHno6xkINyfIpS6t1IWTnL/hGznAaPGEsUOIlmrQtXn9uzv0R+A
        uNyUJq3P4iD0ktRKetNsg7ALnOTQFo7mQUoD3KY=
X-Google-Smtp-Source: AAOMgpfeInyxMjkbzJsb50plSbiD5u1LDrcDP6uYE9rd/YkdoaqapNXcRCzL2+JrLLYr434cbzEzW0qi5ThwWXgCAJk=
X-Received: by 2002:a2e:4619:: with SMTP id t25-v6mr1053838lja.96.1533191157067;
 Wed, 01 Aug 2018 23:25:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 23:25:56 -0700 (PDT)
In-Reply-To: <20180726155459.GA30138@jordon-HP-15-Notebook-PC>
References: <20180726155459.GA30138@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 2 Aug 2018 11:55:56 +0530
Message-ID: <CAFqt6zY6vcqrmztcEf9QYMXoHr08oTirSTNA7X6+5YvvoHRR4A@mail.gmail.com>
Subject: Re: [PATCH v2] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
To:     Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 9:24 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>
> exynos_drm_fbdev_suspend/resume can be removed
> as drm_mode_config_helper_suspend/resume has
> implement the same in generic way.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---
> v2: Address Inki Dae's comment. Remove
>     ret variable from both suspend/resume
>     function.
>

Any further comment on this patch ?

>  drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++++----------------------
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>  3 files changed, 4 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> index a81b4a5..46d28cd 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -151,39 +151,21 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>  static int exynos_drm_suspend(struct device *dev)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> -       struct exynos_drm_private *private;
>
> -       if (pm_runtime_suspended(dev) || !drm_dev)
> +       if (pm_runtime_suspended(dev))
>                 return 0;
>
> -       private = drm_dev->dev_private;
> -
> -       drm_kms_helper_poll_disable(drm_dev);
> -       exynos_drm_fbdev_suspend(drm_dev);
> -       private->suspend_state = drm_atomic_helper_suspend(drm_dev);
> -       if (IS_ERR(private->suspend_state)) {
> -               exynos_drm_fbdev_resume(drm_dev);
> -               drm_kms_helper_poll_enable(drm_dev);
> -               return PTR_ERR(private->suspend_state);
> -       }
> -
> -       return 0;
> +       return drm_mode_config_helper_suspend(drm_dev);
>  }
>
>  static int exynos_drm_resume(struct device *dev)
>  {
>         struct drm_device *drm_dev = dev_get_drvdata(dev);
> -       struct exynos_drm_private *private;
>
> -       if (pm_runtime_suspended(dev) || !drm_dev)
> +       if (pm_runtime_suspended(dev))
>                 return 0;
>
> -       private = drm_dev->dev_private;
> -       drm_atomic_helper_resume(drm_dev, private->suspend_state);
> -       exynos_drm_fbdev_resume(drm_dev);
> -       drm_kms_helper_poll_enable(drm_dev);
> -
> -       return 0;
> +       return drm_mode_config_helper_resume(drm_dev);
>  }
>  #endif
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index 132dd52..918dd2c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>         private->fb_helper = NULL;
>  }
>
> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
> -{
> -       struct exynos_drm_private *private = dev->dev_private;
> -
> -       console_lock();
> -       drm_fb_helper_set_suspend(private->fb_helper, 1);
> -       console_unlock();
> -}
> -
> -void exynos_drm_fbdev_resume(struct drm_device *dev)
> -{
> -       struct exynos_drm_private *private = dev->dev_private;
> -
> -       console_lock();
> -       drm_fb_helper_set_suspend(private->fb_helper, 0);
> -       console_unlock();
> -}
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> index b338472..6840b6a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> @@ -19,8 +19,6 @@
>
>  int exynos_drm_fbdev_init(struct drm_device *dev);
>  void exynos_drm_fbdev_fini(struct drm_device *dev);
> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>
>  #else
>
> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>
>  #define exynos_drm_output_poll_changed (NULL)
>
> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
> -{
> -}
> -
> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
> -{
> -}
> -
>  #endif
>
>  #endif
> --
> 1.9.1
>
