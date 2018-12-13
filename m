Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D69DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5333F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gALpfuqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5333F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeLMVhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:37:18 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:47542 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeLMVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:37:16 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9201568;
        Thu, 13 Dec 2018 22:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1544737034;
        bh=pJuggsQlPjbL3Z++i+ivLcW7/VIhMWc3WpafDdKKukw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gALpfuqIWDY3QLDWJuRKXk80Av2MR6pjm1qP72LdddxUCISK68ogHyCNbWxlWzgjx
         A4nuPK3gZrjlYP6ZQPJq2kXV++x9pmet7LL9ztULLQG2NL4GrapGphdQmdG6ejD6Ff
         I3YuZxJikO5SkzmhHGQujyuu83hHwJ7v3ziTzKmU=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] drm: rcar-du: Add r8a774c0 device support
Date:   Thu, 13 Dec 2018 23:38:01 +0200
Message-ID: <4856258.rJnt87OIyb@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1544732607-7277-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1544732607-7277-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Thursday, 13 December 2018 22:23:27 EET Fabrizio Castro wrote:
> Add support for the RZ/G2E (R8A774C0) SoC to the R-Car DU driver.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 9caff39..ac32510 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -104,6 +104,33 @@ static const struct rcar_du_device_info
> rzg1_du_r8a77470_info = { },
>  };
> 
> +static const struct rcar_du_device_info rcar_du_r8a774c0_info = {
> +	.gen = 3,
> +	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
> +		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
> +		  | RCAR_DU_FEATURE_VSP1_SOURCE,
> +	.channels_mask = BIT(1) | BIT(0),
> +	.routes = {
> +		/*
> +		 * R8A774C0 has one RGB output and two LVDS outputs
> +		 */
> +		[RCAR_DU_OUTPUT_DPAD0] = {
> +			.possible_crtcs = BIT(0) | BIT(1),
> +			.port = 0,
> +		},
> +		[RCAR_DU_OUTPUT_LVDS0] = {
> +			.possible_crtcs = BIT(0),
> +			.port = 1,
> +		},
> +		[RCAR_DU_OUTPUT_LVDS1] = {
> +			.possible_crtcs = BIT(1),
> +			.port = 2,
> +		},
> +	},
> +	.num_lvds = 2,
> +	.lvds_clk_mask =  BIT(1) | BIT(0),
> +};
> +
>  static const struct rcar_du_device_info rcar_du_r8a7779_info = {
>  	.gen = 2,
>  	.features = RCAR_DU_FEATURE_INTERLACED
> @@ -371,6 +398,7 @@ static const struct of_device_id rcar_du_of_table[] = {
>  	{ .compatible = "renesas,du-r8a7744", .data = &rzg1_du_r8a7743_info },
>  	{ .compatible = "renesas,du-r8a7745", .data = &rzg1_du_r8a7745_info },
>  	{ .compatible = "renesas,du-r8a77470", .data = &rzg1_du_r8a77470_info },
> +	{ .compatible = "renesas,du-r8a774c0", .data = &rcar_du_r8a774c0_info },
>  	{ .compatible = "renesas,du-r8a7779", .data = &rcar_du_r8a7779_info },
>  	{ .compatible = "renesas,du-r8a7790", .data = &rcar_du_r8a7790_info },
>  	{ .compatible = "renesas,du-r8a7791", .data = &rcar_du_r8a7791_info },


-- 
Regards,

Laurent Pinchart



