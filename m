Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeDZUSA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:18:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59352 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeDZUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:17:59 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/17] drm: rcar-du: Use the correct naming for ODPM fields in DEFR6
Date: Thu, 26 Apr 2018 23:18:12 +0300
Message-ID: <1962449.rfF5AqLB98@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180426165346.494-5-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com> <20180426165346.494-5-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:33 EEST Kieran Bingham wrote:
> The naming of the fields for the ODPM signals in the DU extensional
> function control register 6 (DEFR6) is incorrect against the data sheets
> for both R-Car Gen2 and R-Car Gen3.
> 
> Rename the fields to match the datasheet.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and taken in my tree.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_group.c |  4 ++--
>  drivers/gpu/drm/rcar-du/rcar_du_regs.h  | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c
> b/drivers/gpu/drm/rcar-du/rcar_du_group.c index 2f37ea901873..eead202c95c7
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
> @@ -46,10 +46,10 @@ void rcar_du_group_write(struct rcar_du_group *rgrp, u32
> reg, u32 data)
> 
>  static void rcar_du_group_setup_pins(struct rcar_du_group *rgrp)
>  {
> -	u32 defr6 = DEFR6_CODE | DEFR6_ODPM12_DISP;
> +	u32 defr6 = DEFR6_CODE | DEFR6_ODPM02_DISP;
> 
>  	if (rgrp->num_crtcs > 1)
> -		defr6 |= DEFR6_ODPM22_DISP;
> +		defr6 |= DEFR6_ODPM12_DISP;
> 
>  	rcar_du_group_write(rgrp, DEFR6, defr6);
>  }
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
> b/drivers/gpu/drm/rcar-du/rcar_du_regs.h index d5bae99d3cfe..9dfd220ceda1
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
> @@ -187,14 +187,14 @@
> 
>  #define DEFR6			0x000e8
>  #define DEFR6_CODE		(0x7778 << 16)
> -#define DEFR6_ODPM22_DSMR	(0 << 10)
> -#define DEFR6_ODPM22_DISP	(2 << 10)
> -#define DEFR6_ODPM22_CDE	(3 << 10)
> -#define DEFR6_ODPM22_MASK	(3 << 10)
> -#define DEFR6_ODPM12_DSMR	(0 << 8)
> -#define DEFR6_ODPM12_DISP	(2 << 8)
> -#define DEFR6_ODPM12_CDE	(3 << 8)
> -#define DEFR6_ODPM12_MASK	(3 << 8)
> +#define DEFR6_ODPM12_DSMR	(0 << 10)
> +#define DEFR6_ODPM12_DISP	(2 << 10)
> +#define DEFR6_ODPM12_CDE	(3 << 10)
> +#define DEFR6_ODPM12_MASK	(3 << 10)
> +#define DEFR6_ODPM02_DSMR	(0 << 8)
> +#define DEFR6_ODPM02_DISP	(2 << 8)
> +#define DEFR6_ODPM02_CDE	(3 << 8)
> +#define DEFR6_ODPM02_MASK	(3 << 8)
>  #define DEFR6_TCNE1		(1 << 6)
>  #define DEFR6_TCNE0		(1 << 4)
>  #define DEFR6_MLOS1		(1 << 2)

-- 
Regards,

Laurent Pinchart
