Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB6FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DCE219E3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9LVor35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DCE219E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeHFIOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:14:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35840 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHFIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:14:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id b22-v6so8186785lfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 23:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b2vUD+bjlZKHRmpZKu8iY+N7Jvw+6zVGxrGiY2pM2ag=;
        b=i9LVor35np7wzJPU+tzJ9wMZV1cpn+VjElqDb6vLuyrh9TYU7CJKMLwRIpiQzrWYg/
         gaSKlksiEjtcpQyd/8rPv115dW58HxCuEL+ZHdzh3mczSRwxFWudUAg4t98UL2EsM53K
         E7PemBANJuuyW0yf2JzMN2WPisIScgjApxfrUgHF7S8ec9gxYm0W02canyY+Dsm0WvN0
         ye7qjyACsyQP9JHf01yXiXq3C0YKl+L8TfQS3AR3jrsw0LyNsRuWeIRSw4wXZLFuwHDn
         u2lLIIR6uA4rtXZRNxCk2uX+qUwLjbpc3kh5zjAnE3gJVY9Xm3IpPeVI0nW31OBAhuXL
         P81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b2vUD+bjlZKHRmpZKu8iY+N7Jvw+6zVGxrGiY2pM2ag=;
        b=Kw5VHfrl8RGD+jRE07JdONoxZu2lExKbcNJQrdTA/C6Cqyf71qwod5YQ7SRSlpFGR+
         C5P00PeZpHMsnw3xcaUsKmPz0WR4E4Y2Qk0mLNxX52to/YLbgTlAxdWpW30Kw9ONHKt+
         lu5f+zwR5RxQFfEhL4BGezeL49R9V6W6PuHgEMo3yf0oh1zU+HzXZkT8cdVGB3GlBVtT
         6GUb/o0TYQZa2twfNRSaTKXoYJkmrcY9G4u0+fWeoVu8OJx7fJild40SaFxEL5MIlCIE
         wEgCsgJI5KdmSIx7xfyPNOEtB/dSq+f6WQM0g1k8te21NtHvuNg0ILBWsgLMq796RXYY
         Fl0A==
X-Gm-Message-State: AOUpUlF2kRj5aspGKvobiewryqUTOeXPrDfSryytDsJqaisxKRfV+1Pj
        2P5OWrxrc3snmYnrtRAAerqcVQpyTNAAIDq6I6Q=
X-Google-Smtp-Source: AAOMgpcQ/ceiOlUe4Xa5t2IBWnB11jycMcOZPTdEh0KGqGymdRISZu0P3QeMc1NkoP3MB1IidwRgkTWk1EwN+QZ6eIs=
X-Received: by 2002:a19:ebd7:: with SMTP id f84-v6mr9898403lfk.18.1533535635184;
 Sun, 05 Aug 2018 23:07:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 23:07:14 -0700 (PDT)
In-Reply-To: <20180730192326.GA31354@jordon-HP-15-Notebook-PC>
References: <20180730192326.GA31354@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 6 Aug 2018 11:37:14 +0530
Message-ID: <CAFqt6zbMsOUXrBPc0_Xmvq_Wg-m+LfGnPy6f6u-ogO2OYdKRMQ@mail.gmail.com>
Subject: Re: [PATCH] drm: Remove drm_fbdev_cma_set_suspend()
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:53 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> drm_fbdev_cma_set_suspend() is not getting called from
> any other places. If there is no plan to use it in future
> we can remove this API.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---

Any comment on this patch ?

>  drivers/gpu/drm/drm_fb_cma_helper.c | 15 ---------------
>  include/drm/drm_fb_cma_helper.h     |  1 -
>  2 files changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index 186d00a..4c283d9 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -516,21 +516,6 @@ void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma)
>  EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
>
>  /**
> - * drm_fbdev_cma_set_suspend - wrapper around drm_fb_helper_set_suspend
> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> - * @state: desired state, zero to resume, non-zero to suspend
> - *
> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> - * fb_set_suspend implemented by fbdev core.
> - */
> -void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state)
> -{
> -       if (fbdev_cma)
> -               drm_fb_helper_set_suspend(&fbdev_cma->fb_helper, state);
> -}
> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend);
> -
> -/**
>   * drm_fbdev_cma_set_suspend_unlocked - wrapper around
>   *                                      drm_fb_helper_set_suspend_unlocked
>   * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
> index d532f88a..52f09dc 100644
> --- a/include/drm/drm_fb_cma_helper.h
> +++ b/include/drm/drm_fb_cma_helper.h
> @@ -32,7 +32,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
>
>  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
>  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
> -void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state);
>  void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
>                                         bool state);
>
> --
> 1.9.1
>
