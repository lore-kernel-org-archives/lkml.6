Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932086AbeDZXWC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:22:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34932 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754716AbeDZXWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:22:01 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: tc358767: fix mode_valid's return type
Date: Fri, 27 Apr 2018 02:22:14 +0300
Message-ID: <14260440.xDKvmdEgPi@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180424131453.1961-1-luc.vanoostenryck@gmail.com>
References: <20180424131453.1961-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

Thank you for the patch.

On Tuesday, 24 April 2018 16:14:52 EEST Luc Van Oostenryck wrote:
> The method struct drm_connector_helper_funcs::mode_valid is defined
> as returning an 'enum drm_mode_status' but the driver implementation
> for this method uses an 'int' for it.
> 
> Fix this by using 'enum drm_mode_status' in the driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/tc358767.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c
> b/drivers/gpu/drm/bridge/tc358767.c index 08ab7d6ae..0fd9cf275 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -1102,7 +1102,7 @@ static bool tc_bridge_mode_fixup(struct drm_bridge
> *bridge, return true;
>  }
> 
> -static int tc_connector_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status tc_connector_mode_valid(struct drm_connector
> *connector, struct drm_display_mode *mode)
>  {
>  	/* DPI interface clock limitation: upto 154 MHz */

-- 
Regards,

Laurent Pinchart
