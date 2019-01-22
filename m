Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08362C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFE3217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LcevONuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfAVUzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:55:50 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:55534 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfAVUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:55:49 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89B00575;
        Tue, 22 Jan 2019 21:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548190547;
        bh=bGDAsoUre/I1SrQbWolGK7zOF4Po2t/ixbKoSqBCS54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcevONuv92s+8me0dd4ZhF2K7O+VdprlRn7Z5Mekl6ckHISh+L2MeRxcDMkhgMa4D
         GHxEq9eOI1RkbKfzX/WVxFdo1JuSrlyolAPAn0E4Bql0yET0H6GIVao5S/giHe9QNC
         Cp80RQQfqy0O5oF0//oZnNH7GiO+lFbZS78txN1M=
Date:   Tue, 22 Jan 2019 22:55:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] drm/bridge: lvds-encoder: add dev helper variable
 in .probe()
Message-ID: <20190122205547.GH3264@pendragon.ideasonboard.com>
References: <20181229070649.21308-1-peda@axentia.se>
 <20181229070649.21308-5-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181229070649.21308-5-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Sat, Dec 29, 2018 at 07:07:37AM +0000, Peter Rosin wrote:
> Make the code easier to read and modify.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/lvds-encoder.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
> index 75b0d3f6e4de..f6770e83d49d 100644
> --- a/drivers/gpu/drm/bridge/lvds-encoder.c
> +++ b/drivers/gpu/drm/bridge/lvds-encoder.c
> @@ -34,48 +34,47 @@ static struct drm_bridge_funcs funcs = {
>  
>  static int lvds_encoder_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct device_node *port;
>  	struct device_node *endpoint;
>  	struct device_node *panel_node;
>  	struct drm_panel *panel;
>  	struct lvds_encoder *lvds_encoder;
>  
> -	lvds_encoder = devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
> -				    GFP_KERNEL);
> +	lvds_encoder = devm_kzalloc(dev, sizeof(*lvds_encoder), GFP_KERNEL);
>  	if (!lvds_encoder)
>  		return -ENOMEM;
>  
>  	/* Locate the panel DT node. */
> -	port = of_graph_get_port_by_id(pdev->dev.of_node, 1);
> +	port = of_graph_get_port_by_id(dev->of_node, 1);
>  	if (!port) {
> -		dev_dbg(&pdev->dev, "port 1 not found\n");
> +		dev_dbg(dev, "port 1 not found\n");
>  		return -ENXIO;
>  	}
>  
>  	endpoint = of_get_child_by_name(port, "endpoint");
>  	of_node_put(port);
>  	if (!endpoint) {
> -		dev_dbg(&pdev->dev, "no endpoint for port 1\n");
> +		dev_dbg(dev, "no endpoint for port 1\n");
>  		return -ENXIO;
>  	}
>  
>  	panel_node = of_graph_get_remote_port_parent(endpoint);
>  	of_node_put(endpoint);
>  	if (!panel_node) {
> -		dev_dbg(&pdev->dev, "no remote endpoint for port 1\n");
> +		dev_dbg(dev, "no remote endpoint for port 1\n");
>  		return -ENXIO;
>  	}
>  
>  	panel = of_drm_find_panel(panel_node);
>  	of_node_put(panel_node);
>  	if (!panel) {
> -		dev_dbg(&pdev->dev, "panel not found, deferring probe\n");
> +		dev_dbg(dev, "panel not found, deferring probe\n");
>  		return -EPROBE_DEFER;
>  	}
>  
>  	lvds_encoder->panel_bridge =
> -		devm_drm_panel_bridge_add(&pdev->dev,
> -					  panel, DRM_MODE_CONNECTOR_LVDS);
> +		devm_drm_panel_bridge_add(dev, panel, DRM_MODE_CONNECTOR_LVDS);
>  	if (IS_ERR(lvds_encoder->panel_bridge))
>  		return PTR_ERR(lvds_encoder->panel_bridge);
>  
> @@ -83,7 +82,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
>  	 * but we need a bridge attached to our of_node for our user
>  	 * to look up.
>  	 */
> -	lvds_encoder->bridge.of_node = pdev->dev.of_node;
> +	lvds_encoder->bridge.of_node = dev->of_node;
>  	lvds_encoder->bridge.funcs = &funcs;
>  	drm_bridge_add(&lvds_encoder->bridge);
>  
> -- 
> 2.11.0
> 

-- 
Regards,

Laurent Pinchart
