Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36507C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD97021547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD97021547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeI0RjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:39:08 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:50075 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeI0RjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:39:08 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50732 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1g5UMB-0004sC-8W; Thu, 27 Sep 2018 13:21:19 +0200
Subject: Re: [PATCH] drm/imx: fix build failure without
 CONFIG_DRM_FBDEV_EMULATION
To:     Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180926193846.2490574-1-arnd@arndb.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <70957313-2ec1-048f-d262-5ae8f96d9b8a@tronnes.org>
Date:   Thu, 27 Sep 2018 13:21:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926193846.2490574-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 26.09.2018 21.38, skrev Arnd Bergmann:
> The variable is declared in an #ifdef section, but the user is
> now unconditional, which leads to a build failure:
>
> drivers/gpu/drm/imx/imx-drm-core.c: In function 'imx_drm_bind':
> drivers/gpu/drm/imx/imx-drm-core.c:264:6: error: 'legacyfb_depth' undeclared (first use in this function); did you mean 'lockdep_depth'?
>
> Remove the remaining #ifdef as well.
>
> Fixes: f53705fd9803 ("drm/imx: Use drm_fbdev_generic_setup()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for fixing my mistakes Arnd.
Applied to drm-misc-next.

Noralf.

>   drivers/gpu/drm/imx/imx-drm-core.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
> index a70f3131a377..0e6942f21a4e 100644
> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> @@ -35,10 +35,8 @@
>   
>   #define MAX_CRTC	4
>   
> -#if IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION)
>   static int legacyfb_depth = 16;
>   module_param(legacyfb_depth, int, 0444);
> -#endif
>   
>   DEFINE_DRM_GEM_CMA_FOPS(imx_drm_driver_fops);
>   

