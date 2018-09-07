Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B23E204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B23E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIGKPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:15:18 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:48579 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbeIGKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:15:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BA783611A;
        Fri,  7 Sep 2018 05:36:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sleep49_51b2dea0c4855
X-Filterd-Recvd-Size: 3030
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri,  7 Sep 2018 05:36:01 +0000 (UTC)
Message-ID: <4d74256435a71cdb7ec8d114b1c3cb640f29c267.camel@perches.com>
Subject: Re: [PATCH v4 2/6] drm/nouveau: Add NV_PRINTK_ONCE and variants
From:   Joe Perches <joe@perches.com>
To:     Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Sep 2018 22:35:59 -0700
In-Reply-To: <20180906214328.24012-3-lyude@redhat.com>
References: <20180906214328.24012-1-lyude@redhat.com>
         <20180906214328.24012-3-lyude@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-06 at 17:43 -0400, Lyude Paul wrote:
> Since we're about to use this in nouveau_backlight.c. Same thing as
> DRM_WARN_ONCE, DRM_INFO_ONCE, etc...

Can you redefine this in terms of the patches I submitted
instead?

https://lore.kernel.org/patchwork/patch/979598/
https://lore.kernel.org/patchwork/patch/979601/


> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drv.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
> index 6e1acaec3400..d9d687916553 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -244,10 +244,12 @@ void nouveau_drm_device_remove(struct drm_device *dev);
>  	struct nouveau_cli *_cli = (c);                                        \
>  	dev_##l(_cli->drm->dev->dev, "%s: "f, _cli->name, ##a);                \
>  } while(0)
> +
>  #define NV_FATAL(drm,f,a...) NV_PRINTK(crit, &(drm)->client, f, ##a)
>  #define NV_ERROR(drm,f,a...) NV_PRINTK(err, &(drm)->client, f, ##a)
>  #define NV_WARN(drm,f,a...) NV_PRINTK(warn, &(drm)->client, f, ##a)
>  #define NV_INFO(drm,f,a...) NV_PRINTK(info, &(drm)->client, f, ##a)
> +
>  #define NV_DEBUG(drm,f,a...) do {                                              \
>  	if (unlikely(drm_debug & DRM_UT_DRIVER))                               \
>  		NV_PRINTK(info, &(drm)->client, f, ##a);                       \
> @@ -257,6 +259,12 @@ void nouveau_drm_device_remove(struct drm_device *dev);
>  		NV_PRINTK(info, &(drm)->client, f, ##a);                       \
>  } while(0)
>  
> +#define NV_PRINTK_ONCE(l,c,f,a...) NV_PRINTK(l##_once,c,f, ##a)
> +
> +#define NV_ERROR_ONCE(drm,f,a...) NV_PRINTK_ONCE(err, &(drm)->client, f, ##a)
> +#define NV_WARN_ONCE(drm,f,a...) NV_PRINTK_ONCE(warn, &(drm)->client, f, ##a)
> +#define NV_INFO_ONCE(drm,f,a...) NV_PRINTK_ONCE(info, &(drm)->client, f, ##a)
> +
>  extern int nouveau_modeset;
>  
>  #endif
