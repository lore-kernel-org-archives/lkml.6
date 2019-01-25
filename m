Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B232DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75012218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="YIbo7Dhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAYRZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:25:33 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:38475 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=b39L/vjtLb5q8xMCKHGxH4LoqdFYGuwB6tLXlSE3EJg=;
        b=YIbo7Dhp+8fUd7IC3Y8r5C89fV7OLORtryE5Qg4kR0JwQO4iUe3Uda0gcyW3UrQU3g6vApAKjjLlU8fL+xmdYRsZvoZtyGnqE96FyX+hOXwwxT0mSLKVQVmdOIFAh/LgR0GtpRqCuCOHgQ4mwDzVRh5o+jWHKhAYsJxwBlHWqdSt7S/ErLwdGJaRYjmp7i5yTytoWyF/qbxXyrgdVpK3k8HYOPg0Gd5USpNZh1UMNOR2J0LohTt+cs+SIry+wKi5S1gvR/A07DDdHLnQmueNfFvwnh3/ykIUkOWpc9CdWTr1mwRpGKknnActpaLXU6dkDgiqisrAmGBPgugGzvNRfA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50460 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn5EQ-0003eg-JZ; Fri, 25 Jan 2019 18:25:30 +0100
Subject: Re: [PATCH v3 17/23] drm/qxl: use generic fbdev emulation
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-18-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <e31c0fdd-315a-59cf-e7fe-dfd6a064f6ee@tronnes.org>
Date:   Fri, 25 Jan 2019 18:25:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-18-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> Switch qxl over to the new generic fbdev emulation.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 7 -------
>  drivers/gpu/drm/qxl/qxl_drv.c     | 2 ++
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index ef832f98ab..9c751f01e3 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1221,18 +1221,11 @@ int qxl_modeset_init(struct qxl_device *qdev)
>  	qxl_display_read_client_monitors_config(qdev);
>  
>  	drm_mode_config_reset(&qdev->ddev);
> -
> -	/* primary surface must be created by this point, to allow
> -	 * issuing command queue commands and having them read by
> -	 * spice server. */
> -	qxl_fbdev_init(qdev);
>  	return 0;
>  }
>  
>  void qxl_modeset_fini(struct qxl_device *qdev)
>  {
> -	qxl_fbdev_fini(qdev);
> -
>  	qxl_destroy_monitors_object(qdev);
>  	drm_mode_config_cleanup(&qdev->ddev);
>  }
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 13c8a662f9..3fce7d16df 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -93,6 +93,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		goto modeset_cleanup;
>  
> +	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");

I couldn't find that this was part of old fbdev code, so it would be
nice to mention it in the commit message.

Acked-by: Noralf Trønnes <noralf@tronnes.org>


> +	drm_fbdev_generic_setup(&qdev->ddev, 32);
>  	return 0;
>  
>  modeset_cleanup:
> 
