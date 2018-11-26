Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97961C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F44B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SOlg9kF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F44B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeKZUTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:19:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57416 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:19:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ9PlSK089825;
        Mon, 26 Nov 2018 03:25:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543224347;
        bh=MIvkMBc3waK8DEmSAax1euhoyMj0PUNmXrOCnHi6nSg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SOlg9kF6eJ2nrQIUpK2NGm1hngFOHJ0txechRE+y2yK9kNYH+p51U7IpyOVXGR7/R
         l8Z/UM5rukqEf8ungrBzfhOKeoRxdhe1Qh2TdSWXi0wRl0vWvzWcLishgkYWGkxzhT
         3W3gy+1j3D9AM4IysFFa69kZT+HbKECvR8fF2gm4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ9Pkqj005122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 03:25:47 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 03:25:46 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 03:25:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ9Pimb028820;
        Mon, 26 Nov 2018 03:25:44 -0600
Subject: Re: [PATCHv5 1/6] drm/omap: use DRM_DEBUG_DRIVER instead of CORE
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <20181121160916.22017-2-sebastian.reichel@collabora.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <e9462358-30a8-a1a3-87ec-8c120e6f101b@ti.com>
Date:   Mon, 26 Nov 2018 11:25:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181121160916.22017-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/18 18:09, Sebastian Reichel wrote:
> This macro is only used by omapdrm, which should print
> debug messages using the DRIVER category instead of the
> default CORE category.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_drv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
> index bd7f2c227a25..3b4af517c92b 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.h
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.h
> @@ -38,8 +38,8 @@
>  #include "omap_irq.h"
>  #include "omap_plane.h"
>  
> -#define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
> -#define VERB(fmt, ...) if (0) DRM_DEBUG(fmt, ##__VA_ARGS__) /* verbose debug */
> +#define DBG(fmt, ...) DRM_DEBUG_DRIVER(fmt"\n", ##__VA_ARGS__)
> +#define VERB(fmt, ...) if (0) DRM_DEBUG_DRIVER(fmt, ##__VA_ARGS__) /* verbose debug */
>  
>  #define MODULE_NAME     "omapdrm"
>  
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
