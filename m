Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B038C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64686204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 17:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64686204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaishalithakkar.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeG1TRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 15:17:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39404 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbeG1TRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 15:17:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so7082595lji.6;
        Sat, 28 Jul 2018 10:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3GcIO9hKtjhadE1Llxdyg8z8qPIe/5kLRcz8pQLRkgs=;
        b=ZD1y7jcSL0FtKpOyBLUBoKseLAf04/sabnWoKbaUN/9v5fOvCRMPCFHC93aJ9G+dEs
         rr0zER4VH9FV/oZ+qri/hB+J4HV+p/sjjpcHHAKFqpUNAdGH6YmXn8hG3HUj3rYUuPbN
         FbaysFqMcImL1S3uKmki8b7MAu9cK3ulLTWm5zr/pRWnfZFREoWbmI+twEcAysbBzxGc
         h9GXMCk+ac+XIWFvgxIJ3aFq+C1t4ifmkm7DdbPgcNIoHDYn58oNnZPE6DxtebX0jOHO
         XnMsC1FfNujZ/aI/bHJNPoJE8PWiOtOwjWdyFo7B0XPlGHfZ2Fpi4yLzM1iYwPHLhQaU
         8xew==
X-Gm-Message-State: AOUpUlFkBINwBkvJeg/1IjQ+DY3beIMZeL8gmcT1rmGHckEj/mZ8B0r/
        In47TfJ4Yrds4fh+YOvVjEYmGg5L3fI=
X-Google-Smtp-Source: AAOMgpewKxrdjn+Tqq2M8dO+zjcDqOi+O/dBe4aPeJkppFgKOLUBIDjKg8hFSZ3w21K0xeFC2uJeVQ==
X-Received: by 2002:a2e:21d5:: with SMTP id h82-v6mr8088146lji.46.1532800205947;
        Sat, 28 Jul 2018 10:50:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id i1-v6sm1226953ljg.43.2018.07.28.10.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 10:50:05 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id w16-v6so3483167ljh.12;
        Sat, 28 Jul 2018 10:50:05 -0700 (PDT)
X-Received: by 2002:a2e:3313:: with SMTP id d19-v6mr498331ljc.25.1532800205493;
 Sat, 28 Jul 2018 10:50:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:88c2:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 10:50:05
 -0700 (PDT)
In-Reply-To: <20180728154007.GA28426@jordon-HP-15-Notebook-PC>
References: <20180728154007.GA28426@jordon-HP-15-Notebook-PC>
From:   Vaishali Thakkar <vthakkar@vaishalithakkar.in>
Date:   Sat, 28 Jul 2018 23:20:05 +0530
X-Gmail-Original-Message-ID: <CAK-LDbKqU4Yub5H0_6tRpED4DLN8D+XrsUaNT5SN9Oq0sEpBNg@mail.gmail.com>
Message-ID: <CAK-LDbKqU4Yub5H0_6tRpED4DLN8D+XrsUaNT5SN9Oq0sEpBNg@mail.gmail.com>
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        airlied@linux.ie, ajitn.linux@gmail.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 9:10 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().

Hi Souptick,

Thanks for your patch.

> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 02aee6c..288220f 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device *dev)
>  static int rcar_du_pm_suspend(struct device *dev)
>  {
>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> -       struct drm_atomic_state *state;
>
> -       drm_kms_helper_poll_disable(rcdu->ddev);
> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> -
> -       state = drm_atomic_helper_suspend(rcdu->ddev);
> -       if (IS_ERR(state)) {
> -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);

I don't think we can use drm_mode_config_helper_(suspend/resume)
API here as this file uses CMA functions. And from git grep it seems that
there are very few drivers using it at the moment, so not sure if introducing
new API functions similar to  drm_mode_config will make sense or not.

Thanks.

> -               drm_kms_helper_poll_enable(rcdu->ddev);
> -               return PTR_ERR(state);
> -       }
> -
> -       rcdu->suspend_state = state;
> -
> -       return 0;
> +       return drm_mode_config_helper_suspend(rcdu->ddev);
>  }
>
>  static int rcar_du_pm_resume(struct device *dev)
>  {
>         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
>
> -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
> -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> -       drm_kms_helper_poll_enable(rcdu->ddev);
> -
> -       return 0;
> +       return drm_mode_config_helper_resume(rcdu->ddev);
>  }
>  #endif
>
> --
> 1.9.1
>
