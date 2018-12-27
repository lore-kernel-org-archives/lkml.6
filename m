Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F871C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0805E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545946052;
	bh=mRCwVgpvNgPzVnNE9s+Ppg8cCv2JNDUe76ZneGaedfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k/cKlDUy5NuSktErZSXVaz7UMy4If+u3a7yTODSbQfsZkdp3INeP1kULGSh1E2/qY
	 oH96jbC74CQiFc8q6iAFGHThgEZr0pZSiuHdbMs0xdWJuJTkyQKx50O2KhAkQXOx07
	 fbenrUs5o6ri9T0ojo9/bOvnEAph7KgOenoyHSj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbeL0V1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:27:31 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54336 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbeL0V1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:27:30 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so26091693ita.4;
        Thu, 27 Dec 2018 13:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wcIs0jYxaDCY9d5DGstg8bzmeo8EqvUv156DAybiExA=;
        b=Y517z1opTWLjTLVDJ8gRcmHL8eIHuFzUpyIueMsp7SiLLRH7SxRdPOyOM3BvH6wJ2B
         EqM+20vaUPRtCl9ciHpezbjB7+jxs2MAeaHnjnkZTdty6M0zgHUD69H1ftcC0ck6j5qF
         ZjTt+x5Y2ZiVVPAj/g4tUrw7gfJU9OtUSVStGAhMRk2V3jLzrx0Slv2twzisBvCtDGDy
         dZ6SHBkDUoG+AwtRQ2VOfeEWXfeD51ZCJqZyWjSo1Z0Ep6Ezzv8vNtyLHuKNkZIjDuAL
         n0fw7icyiwWBEzrqf5dX1YwP08l4aq8zjECI2e5usPnjFGz1HkZEiCurtpbesOi7lzRG
         1KqQ==
X-Gm-Message-State: AA+aEWZCb4W4AOP7S34kUZSYTNieAvyjSWNiMj1F2lPLPvbNOsoiZf7K
        a/v+mgwoCBCEBjMcZoh9zA==
X-Google-Smtp-Source: AFSGD/WBs3kczPmcFE3CcpRglv3rIzEpEUHQsSKP/Xe9Z+It2VD/bFaYjO1JpTIzkWsUf5bNdf4A1g==
X-Received: by 2002:a02:590:: with SMTP id 16mr16861160jal.48.1545946049135;
        Thu, 27 Dec 2018 13:27:29 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id c2sm17688610ioh.29.2018.12.27.13.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:27:28 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:27:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@lysator.liu.se>
Cc:     linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: bridge: fork out
 ti,ds90c185 from lvds-transmitter
Message-ID: <20181227212727.GA26893@bogus>
References: <20181219130449.31641-1-peda@lysator.liu.se>
 <20181219130449.31641-2-peda@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219130449.31641-2-peda@lysator.liu.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:04:47PM +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
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
> +- compatible: Must be "lvds-encoder"
>  
>  Required nodes:
>  
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> new file mode 100644
> index 000000000000..a13e778503e6
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
> +- pwdn-gpios: Power down control GPIO (the PDB pin, active-low)

powerdown-gpios is the standard name.

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
> +	pwdn-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
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
