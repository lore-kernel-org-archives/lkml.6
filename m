Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425335AbeE1QZR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:25:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932473AbeE1QZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:25:11 -0400
Subject: Re: [PATCH 08/12] drm/bridge: tc358764: Add DSI to LVDS bridge driver
To: Maciej Purski <m.purski@samsung.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <CGME20180528094728eucas1p128e8a44fa6c3bcb29d056a8191c039af@eucas1p1.samsung.com>
 <1527500833-16005-9-git-send-email-m.purski@samsung.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <153d1f8c-a0b4-b189-34b5-42a81d15f66b@infradead.org>
Date: Mon, 28 May 2018 09:24:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527500833-16005-9-git-send-email-m.purski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 02:47 AM, Maciej Purski wrote:
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index fa2c799..58e19af 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -110,6 +110,13 @@ config DRM_THINE_THC63LVD1024
>  	---help---
>  	  Thine THC63LVD1024 LVDS/parallel converter driver.
>  
> +config DRM_TOSHIBA_TC358764
> +	tristate "TC358764 DSI/LVDS bridge"
> +	depends on DRM && DRM_PANEL
> +	depends on OF
> +	select DRM_MIPI_DSI
> +	select VIDEOMODE_HELPERS
> +

Kconfig symbols with "prompt strings" should also have help text.

I expected checkpatch to catch that, but I tested it and there was no warning
from checkpatch about help text.  OTOH, there was a warning that there are
2 lines in this patch that end with whitespace, so that should be fixed.

Did you use checkpatch (scripts/checkpatch.pl)?

>  config DRM_TOSHIBA_TC358767
>  	tristate "Toshiba TC358767 eDP bridge"
>  	depends on OF

thanks,
-- 
~Randy
