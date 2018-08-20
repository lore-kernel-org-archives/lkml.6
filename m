Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DF5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A5A21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="r1uRI8QZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A5A21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeHTTTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:19:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45646 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeHTTTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:19:08 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3056CD;
        Mon, 20 Aug 2018 18:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534780974;
        bh=Rcm/FHAxKQH5t/9766LlgPkPnXZQYrwu5Ct4GQ/ER5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r1uRI8QZiEdHtnsycisdf4TYXTLNcEUUAc+iDYnE0PZTTnV++b3rSJ0drXyDMmSgg
         OMCCNcIHWXCzzWQg+Z8o3teO84UBG8+zAj11ZTA+dpmqttM4olATpJWdnDkj1UOz8x
         jSIWj6zI+euTfElGIWCglXxwheYWCrxANZIitpX4=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: rcar-du: Refactor Feature and Quirk definitions
Date:   Mon, 20 Aug 2018 19:03:49 +0300
Message-ID: <1564177.rmXuzezsgn@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180820160044.15783-2-kieran.bingham+renesas@ideasonboard.com>
References: <20180820160044.15783-1-kieran.bingham+renesas@ideasonboard.com> <20180820160044.15783-2-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Monday, 20 August 2018 19:00:43 EEST Kieran Bingham wrote:
> These flags are represented by bit fields. To make this clear, utilise
> the BIT() macro.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> This patch fails checkpatch's 80-char limit, due to the line comments
> extending across the 80-char boundary on RCAR_DU_FEATURE_EXT_CTRL_REGS
> 
> To preserve formatting - this warning has been ignored.
> 
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.h index b3a25e8e07d0..78ea20abfb30
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> @@ -27,11 +27,11 @@ struct drm_device;
>  struct drm_fbdev_cma;
>  struct rcar_du_device;
> 
> -#define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	(1 << 0)	/* Per-CRTC IRQ and clock
> */ -#define RCAR_DU_FEATURE_EXT_CTRL_REGS	(1 << 1)	/* Has extended control
> registers */ -#define RCAR_DU_FEATURE_VSP1_SOURCE	(1 << 2)	/* Has inputs
> from VSP1 */ +#define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	BIT(0)	/* Per-CRTC IRQ
> and clock */ +#define RCAR_DU_FEATURE_EXT_CTRL_REGS	BIT(1)	/* Has extended
> control registers */ +#define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(2)	/* Has
> inputs from VSP1 */
> 
> -#define RCAR_DU_QUIRK_ALIGN_128B	(1 << 0)	/* Align pitches to 128 bytes 
*/
> +#define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)	/* Align pitches to 128 bytes */
> 
>  /*
>   * struct rcar_du_output_routing - Output routing specification


-- 
Regards,

Laurent Pinchart



