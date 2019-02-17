Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A26BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C78C2089F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTFPrkKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfBQRkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:40:42 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39639 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfBQRkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:40:42 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so22863894iti.4;
        Sun, 17 Feb 2019 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoqIo9qVci7Fr14maI1o0dWrQxbnZ3dOSXtkch7SjK0=;
        b=MTFPrkKZRaHAUIAPl6Cw304AYsY5bJxNwmnHpLqwTLyjtoNJvjUV40Z/tVmZoZ4jwu
         4PRBcuwxSKYkifB0cCWzcVGd9fCVNdafOJPfmy0Ts8nJvNgU3p8wPQmG1rL/KAJoU5Ap
         TQXKZYQdbSOBy3SwnwD62bfv4UKJAifFEPFa32Jg6Qnes3b/VqsYS4oPc9ZL2jNLMPMu
         OmIZMeaRtXnECS7T7xQ2KkhDfiUfRFn1my/zDJs3JvrPr5hv3iJft5aa7hLkQjaZXVKt
         4tW52eEvTe5+9XRc5Sqg7cjcaHG0x80JyifJn7zTwujvWGMUQpvrtH1BuELeqlY4D5/5
         /4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoqIo9qVci7Fr14maI1o0dWrQxbnZ3dOSXtkch7SjK0=;
        b=e3WiGxc18gGpvnTPw+OQnFk358S4dmTlCxPg3EhWpehl8W8LSUR+/aP7BFpBErOP50
         wvPjMKYQuL/JxLEgQ1pwpq4mcUOCqKiT6wNCfOdtFJKRxUajuUHLlKFpC7HdGqZ3jA9B
         K1/DdhO6QzxeXj5eIFPC3zDVrMhnCS5iWAF3iAn6sIzO0PvplF7hMrWHZ8xdFE9VBWhZ
         JgNovVw18RGvU8MMxBDXE0jCOsN8x26CcHtXgF9C4KDb/nme9oVpWe0sVT83DjDn9n7T
         nwipxSwqgluc0V9wUokTQAT11cPY8Jphw5NiEbc/saMYy2Q1Q+9Mr6FyNvuztU5WSgWo
         cCXQ==
X-Gm-Message-State: AHQUAuburjTI1gGIy4JCTGM5AtJXTK7VkcyExj0HbiHbYqbth6iqx5fK
        z/lAw3UcBjwkQYHtfRWyR3Ip65VF8hmRzRA3PHU=
X-Google-Smtp-Source: AHgI3IaajAJWZ+CH+DDOekY2yjtecFxkJqmo++QKa3YAIXtEbjiMRvv8yWbpDnWUhjiIqLXnH2ubgdGIjnRdO7B98vQ=
X-Received: by 2002:a6b:dd04:: with SMTP id f4mr11071044ioc.248.1550425240858;
 Sun, 17 Feb 2019 09:40:40 -0800 (PST)
MIME-Version: 1.0
References: <1548241960-7412-1-git-send-email-jshekhar@codeaurora.org>
In-Reply-To: <1548241960-7412-1-git-send-email-jshekhar@codeaurora.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 17 Feb 2019 12:40:27 -0500
Message-ID: <CAF6AEGs_SvZ=Ttu3pQgMGbQb=3K5Bqj2TOfqf-V4RjjVLJOCaA@mail.gmail.com>
Subject: Re: [v1] drm/msm: Remove clock and bandwidth votes in mdss pm suspend
To:     Jayant Shekhar <jshekhar@codeaurora.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        chandanu@codeaurora.org, nganji@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 6:12 AM Jayant Shekhar <jshekhar@codeaurora.org> wrote:
>
> MDSS PM suspend is dependent on runtime suspend for disabling
> clocks and removing bandwidth votes. In case of pm_suspend
> triggered, dpm_prepare hold a refcount on power usage of device
> and hence runtime suspend is never triggered during pm_suspend.
> As runtime suspend is not triggered, clocks and bandwidth votes
> remain. Hence explicitly trigger mdss disable in msm_pm_suspend
> to disable clocks and remove the votes.
>
> Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 5c60bb3..ffe3a25 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1068,12 +1068,16 @@ static int msm_pm_suspend(struct device *dev)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct msm_drm_private *priv = ddev->dev_private;
> +       struct msm_mdss *mdss = priv->mdss;
>
>         if (!IS_ERR_OR_NULL(priv->pm_state))
>                 return 0;
>
>         priv->pm_state = drm_atomic_helper_suspend(ddev);
>
> +       if (mdss && mdss->funcs)
> +               mdss->funcs->disable(mdss);
> +

This patch doesn't actually seem to apply, I guess it has a dependency
on some other missing patch?

That said, shouldn't the refcount aquired in _prepare() be dropped
somewhere?  It seems like if all planes/crtcs/etc are disabled, we
should also disable power (or at least as much as we can while still
having hotplug work), so ideally drm_atomic_helper_suspend() should be
enough.

BR.
-R

>         return IS_ERR(priv->pm_state) ? PTR_ERR(priv->pm_state) : 0;
>  }
>
> @@ -1081,11 +1085,15 @@ static int msm_pm_resume(struct device *dev)
>  {
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct msm_drm_private *priv = ddev->dev_private;
> +       struct msm_mdss *mdss = priv->mdss;
>         int ret;
>
>         if (IS_ERR_OR_NULL(priv->pm_state))
>                 return 0;
>
> +       if (mdss && mdss->funcs)
> +               mdss->funcs->enable(mdss);
> +
>         ret = drm_atomic_helper_resume(ddev, priv->pm_state);
>         if (ret == 0)
>                 priv->pm_state = NULL;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
