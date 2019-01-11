Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EBCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4B02063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218150;
	bh=YLobwEjBadq0DVtEDFj3zfoYD/c4Lf1OfoVgLGY4aUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nEpIbtNRuWaBqKAahnx/OepxEhMOsBEhRapw6P6FOn2TBPzRYTrzaDlu88Ot94GvD
	 SPbCJT8/Ad+EfuI56apolwf7WlvgET5Gy5q8h2I3kgGPg17CeOla5705aJGK00sxJz
	 BzyqYBs0Ov30UI/BrUo36pwaWT1/Xj+YSyoIFwcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391563AbfAKOtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:49:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46294 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390588AbfAKOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:49:07 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so12352468oif.13;
        Fri, 11 Jan 2019 06:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SIPdx1HAsZRsvph0eZMR6v07pA/jnpTy7e7w+WEoxts=;
        b=ivS1Xm+OA5lArE5Y3tqFKwUl+dnR+sBd3FquZebNN0auhUyiVaDWmgJO3U0gCd7scP
         biBExIgefYCd1Nqa+LDERTMtPnIVQo7dN2ZkbxWeZCoTBoK5Vv4447QTefEFukC+SgZn
         s2QmG9gnrnVYYSms7IbuU3tMcvlVPfnyfY5j/jT6Mmg8RKQYVWFRU52WCQ89GmzPakwp
         0LHgTHyFZgsDQ1rwiSQFqhMiy9fxpuOr3vsTqu9GdIjL4/5bKSG364pfwZTTRe+qFgVQ
         YpAf0061bL3OXTsrpp21xZvuU5mtU54soGlfmbgm73AoEwoEk6zv2nVfssv7gLt6ozIC
         FyCA==
X-Gm-Message-State: AJcUukcCehBysXY3jySUupJQ3r4SAMg2xRUHk5Ho8sUNuVlQ0bsPNuqE
        0xjECpJoAdi70QZZwMkfXw==
X-Google-Smtp-Source: ALg8bN77ZAY0JivJCtUfM9C5FOyALXB5CxO6pcEdphsMjI6nHgaEcWGXpufLcuMTNmlM1Ymaz1GPKQ==
X-Received: by 2002:aca:ef0b:: with SMTP id n11mr9053611oih.116.1547218145338;
        Fri, 11 Jan 2019 06:49:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm59184088otj.19.2019.01.11.06.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:49:04 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:49:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: display: bridge: fork out
 ti,ds90c185 from lvds-transmitter
Message-ID: <20190111144904.GA5052@bogus>
References: <20181229070649.21308-1-peda@axentia.se>
 <20181229070649.21308-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229070649.21308-2-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 07:07:19AM +0000, Peter Rosin wrote:
> DS90C185 has a shutdown pin which does not fit in the lvds-transmitter
> binding, which is meant to be generic.
> 
> The sister chip DS90C187 is similar to DS90C185, describe it here as well.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/display/bridge/lvds-transmitter.txt   |  8 +---
>  .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> index 50220190c203..fd39ad34c383 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
> @@ -22,13 +22,7 @@ among others.
>  
>  Required properties:
>  
> -- compatible: Must be one or more of the following
> -  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
> -  - "lvds-encoder" for a generic LVDS encoder device
> -
> -  When compatible with the generic version, nodes must list the
> -  device-specific version corresponding to the device first
> -  followed by the generic version.

I think you should keep something here. I'd reword it to say any encoder 
with additional properties must have a device specific compatible in 
addition.

> +- compatible: Must be "lvds-encoder"
>  
>  Required nodes:
>  
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> new file mode 100644
> index 000000000000..e575f996959a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> @@ -0,0 +1,55 @@
> +Texas Instruments FPD-Link (LVDS) Serializer
> +--------------------------------------------
> +
> +The DS90C185 and DS90C187 are low-power serializers for portable
> +battery-powered applications that reduces the size of the RGB
> +interface between the host GPU and the display.
> +
> +Required properties:
> +
> +- compatible: Should be
> +  "ti,ds90c185", "lvds-encoder"  for the TI DS90C185 FPD-Link Serializer
> +  "ti,ds90c187", "lvds-encoder"  for the TI DS90C187 FPD-Link Serializer
> +
> +Optional properties:
> +
> +- powerdown-gpios: Power down control GPIO (the PDB pin, active-low)
> +
> +Required nodes:
> +
> +The devices have two video ports. Their connections are modeled using the OF
> +graph bindings specified in Documentation/devicetree/bindings/graph.txt.
> +
> +- Video port 0 for parallel input
> +- Video port 1 for LVDS output
> +
> +
> +Example
> +-------
> +
> +lvds-encoder {
> +	compatible = "ti,ds90c185", "lvds-encoder";
> +
> +	powerdown-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			lvds_enc_in: endpoint {
> +				remote-endpoint = <&lcdc_out_rgb>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			lvds_enc_out: endpoint {
> +				remote-endpoint = <&lvds_panel_in>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.11.0
> 
