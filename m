Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28303C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17182083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGY0bEbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17182083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeGZJXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:23:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38082 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeGZJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:23:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so713987ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mz3VZmOItD1/GUj8UaM9it317ha8HmzvsMXhcVg2YmA=;
        b=rGY0bEbCll8ABIBPRPg6XO2t6gkgU7Zk2+kpX46KrOlK1ydZ4Bjvbnb4aXHd7lRX4B
         dcQ7ayhiv4rDYZjmnytN/zipBaOsSZF+YJ7JzaaEvQEHMxVWcAtB/BKFhZmLkvZrsXfC
         peEC4ciXlLg+or5ZVvwkflRLaE0WipvYooU/3koJF0/hFvubjvm/7SgpoO/OTaWS1VM2
         Chg5Mrtgl9EvVlZH3LoaIhRB5UHbH4iFSjEl+bHB3Zb2ccfvUdB0naqKDrub63iiEmOz
         wSCh4MAQmf1gKRkesp3B5EMdOykKg3sjJHlE4yns8xmZ1pAyO3JYpregaLM7ckoslQCK
         nodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mz3VZmOItD1/GUj8UaM9it317ha8HmzvsMXhcVg2YmA=;
        b=kPFskZtJQ+zt48ZNYIeC59EeNLpUC+t20OkrY5riPewwohi2G7qjpOE4LX3SFtXo/v
         PPi3LZJZKg3+/IVpeaD7E3t3nFfSE7bT3l5DKybwb0HTFp158c4h7hUp7NbVVE5c+uEC
         HHIpyQk/jHnQlpisytoj5ALn37lbuylIF7xGUMwovAfH45Rh3DwsKD3CI5sJNw7mg/Lm
         VKxQvpnZEhq1NIVbcFG6nQU9UUUphacjI4h/BNAWgAxXx48WhdJWxEHsprTmnWmZTzHE
         lfI89AL0NQeXLsBIm4rOL/98NOUEMbyn1k0IUtO6C3gz5bOmzQJ7603Q2nWaU/Vbgd97
         gN8g==
X-Gm-Message-State: AOUpUlHopmMb6JdXt56rlj8EcGzAU23UveYiDAfyffec8+agIff/+W8k
        3EpSQ6KOoI07HDXVWZVvIUIZ/Ojyo/riJCpC4lg=
X-Google-Smtp-Source: AAOMgpdPvCUtVeqbLkq6iyxw3etxvH5BnRSOTILUd3N5bzfwhr9GaZvLCk8CJJRMCuZTDqdkzFCoB+P6v9hZlZsA7Kc=
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr785896ljf.36.1532592451834;
 Thu, 26 Jul 2018 01:07:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 01:07:31
 -0700 (PDT)
In-Reply-To: <20180719160426.GA21958@jordon-HP-15-Notebook-PC>
References: <20180719160426.GA21958@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 26 Jul 2018 13:37:31 +0530
Message-ID: <CAFqt6zY_KUx0RgRiuTt6x6xmtfwD=iR8xR6665eZYmKmXKgDNA@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/hisilicon: Convert drm_atomic_helper_suspend/resume()
To:     z.liuxinliang@hisilicon.com, Zou Rongrong <zourongrong@gmail.com>,
        kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com,
        airlied@linux.ie, noralf@tronnes.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 9:34 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
>
> Fixed one sparse warning by making hibmc_drm_interrupt
> static.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---

Any comment on this patch ?

>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index d4f6f1f..2261676 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -37,7 +37,7 @@
>         .llseek         = no_llseek,
>  };
>
> -irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
> +static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
>  {
>         struct drm_device *dev = (struct drm_device *)arg;
>         struct hibmc_drm_private *priv =
> @@ -74,30 +74,22 @@ static int __maybe_unused hibmc_pm_suspend(struct device *dev)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
>         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> -       struct hibmc_drm_private *priv = drm_dev->dev_private;
> -
> -       drm_kms_helper_poll_disable(drm_dev);
> -       priv->suspend_state = drm_atomic_helper_suspend(drm_dev);
> -       if (IS_ERR(priv->suspend_state)) {
> -               DRM_ERROR("drm_atomic_helper_suspend failed: %ld\n",
> -                         PTR_ERR(priv->suspend_state));
> -               drm_kms_helper_poll_enable(drm_dev);
> -               return PTR_ERR(priv->suspend_state);
> -       }
> +       int ret = 0;
>
> -       return 0;
> +       ret = drm_mode_config_helper_suspend(drm_dev);
> +
> +       return ret;
>  }
>
>  static int  __maybe_unused hibmc_pm_resume(struct device *dev)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
>         struct drm_device *drm_dev = pci_get_drvdata(pdev);
> -       struct hibmc_drm_private *priv = drm_dev->dev_private;
> +       int ret = 0;
>
> -       drm_atomic_helper_resume(drm_dev, priv->suspend_state);
> -       drm_kms_helper_poll_enable(drm_dev);
> +       ret = drm_mode_config_helper_resume(drm_dev);
>
> -       return 0;
> +       return ret;
>  }
>
>  static const struct dev_pm_ops hibmc_pm_ops = {
> --
> 1.9.1
>
