Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E251D2174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E251D2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbeHCM2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:28:10 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:36000 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730783AbeHCM2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:28:10 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 4BBA8634C7F;
        Fri,  3 Aug 2018 13:32:26 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1flXNi-0000tC-2N; Fri, 03 Aug 2018 13:32:26 +0300
Date:   Fri, 3 Aug 2018 13:32:25 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v6 2/3] dt-bindings: display: atmel: optional
 video-interface of endpoints
Message-ID: <20180803103225.xkwqe3wiv2gwdo5g@valkosipuli.retiisi.org.uk>
References: <20180803101124.4622-1-peda@axentia.se>
 <20180803101124.4622-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803101124.4622-3-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for cc'ing me.

On Fri, Aug 03, 2018 at 12:11:23PM +0200, Peter Rosin wrote:
> With bus-type/bus-width properties in the endpoint nodes, the video-
> interface of the connection can be specified for cases where the
> heuristic fails to select the correct output mode. This can happen
> e.g. if not all RGB pins are routed on the PCB; the driver has no
> way of knowing this, and needs to be told explicitly.
> 
> This is critical for the devices that have the "conflicting output
> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> RGB bits move around depending on the selected output mode. For
> devices that do not have the "conflicting output formats" issue
> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> 
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> index 82f2acb3d374..10e8707d1443 100644
> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> @@ -15,6 +15,14 @@ Required children nodes:
>   to external devices using the OF graph reprensentation (see ../graph.txt).
>   At least one port node is required.
>  
> +Optional properties in grandchild nodes:
> + Any endpoint grandchild node may specify a desired video interface
> + according to ../../media/video-interfaces.txt, specifically
> + - bus-type: must be <0>.

bus-type won't tell anything in this case, you could simply drop it. If
your hardware only supports parallel or Bt.656 bus then the code parsing
the properties can (and should) know the bus type as well.

Looking at your implementation, bus-type is not being used. This supports
the suggestion.

The V4L2 implementation is about to change as well and there's a bit of
discussion ongoing related to the bus-type property:

<URL:https://www.spinics.net/lists/linux-media/msg137980.html>
<URL:https://www.spinics.net/lists/linux-media/msg137979.html>

> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> +   override any output mode selection heuristic, forcing "rgb444",
> +   "rgb565", "rgb666" and "rgb888" respectively.
> +
>  Example:
>  
>  	hlcdc: hlcdc@f0030000 {
> @@ -50,3 +58,25 @@ Example:
>  			#pwm-cells = <3>;
>  		};
>  	};
> +
> +Example 2: With a video interface override to force rgb565; as above
> +but with these changes/additions:
> +
> +	&hlcdc {
> +		hlcdc-display-controller {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> +
> +			port@0 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0>;
> +
> +				hlcdc_panel_output: endpoint@0 {
> +					reg = <0>;
> +					bus-type = <0>;
> +					bus-width = <16>;
> +				};
> +			};
> +		};
> +	};

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
