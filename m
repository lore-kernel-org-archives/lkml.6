Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCB4C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DE720883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ZPurgHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DE720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeILHZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 03:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbeILHZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 03:25:48 -0400
Received: from dragon (unknown [180.108.213.97])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79AD220839;
        Wed, 12 Sep 2018 02:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536719017;
        bh=8d3/e9Tb3PxkMEznEOOowuQlXVbp9HKJOKD1BTzJMlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ZPurgHSJx6XOuSvcR4f5UFO7VxN4j7IANW5+k0WhxUBA7jDUfB5R9flHHyg3iwEb
         sQYKDrBuDjTkERhgZSMGbNnS0G86wL6vBGi2eK4YVBjEBZBYLN7Es9tXZeyxun/zJb
         RL+WMfSth5rqeIaDrqI3ReasYgDMn+n3rTINGBis=
Date:   Wed, 12 Sep 2018 10:21:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        arm@kernel.org, sudeep.holla@arm.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 06/11] dts: arm: imx7{d,s}: Update coresight binding for
 hardware ports
Message-ID: <20180912022152.GG28469@dragon>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-7-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536661032-30481-7-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:17:07AM +0100, Suzuki K Poulose wrote:
> Switch to the updated coresight bindings.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

As per the convention we use for subject prefix, I suggest you use

  'ARM: dts: imx7: ...'

Shawn

> ---
>  arch/arm/boot/dts/imx7d.dtsi | 11 ++++---
>  arch/arm/boot/dts/imx7s.dtsi | 78 ++++++++++++++++++++++++++------------------
>  2 files changed, 53 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 7cbc2ff..4ced17c 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -63,9 +63,11 @@
>  			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>  			clock-names = "apb_pclk";
>  
> -			port {
> -				etm1_out_port: endpoint {
> -					remote-endpoint = <&ca_funnel_in_port1>;
> +			out-ports {
> +				port {
> +					etm1_out_port: endpoint {
> +						remote-endpoint = <&ca_funnel_in_port1>;
> +					};
>  				};
>  			};
>  		};
> @@ -148,11 +150,10 @@
>  	};
>  };
>  
> -&ca_funnel_ports {
> +&ca_funnel_in_ports {
>  	port@1 {
>  		reg = <1>;
>  		ca_funnel_in_port1: endpoint {
> -			slave-mode;
>  			remote-endpoint = <&etm1_out_port>;
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index a052198..9176885 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -106,7 +106,7 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  				/* replicator output ports */
> @@ -123,12 +123,15 @@
>  					remote-endpoint = <&etr_in_port>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port@2 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				replicator_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&etf_out_port>;
>  				};
>  			};
> @@ -168,28 +171,31 @@
>  			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>  			clock-names = "apb_pclk";
>  
> -			ca_funnel_ports: ports {
> +			ca_funnel_in_ports: in-ports {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  
> -				/* funnel input ports */
>  				port@0 {
>  					reg = <0>;
>  					ca_funnel_in_port0: endpoint {
> -						slave-mode;
>  						remote-endpoint = <&etm0_out_port>;
>  					};
>  				};
>  
> -				/* funnel output port */
> -				port@2 {
> +				/* the other input ports are not connect to anything */
> +			};
> +
> +			out-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
>  					reg = <0>;
>  					ca_funnel_out_port0: endpoint {
>  						remote-endpoint = <&hugo_funnel_in_port0>;
>  					};
>  				};
>  
> -				/* the other input ports are not connect to anything */
>  			};
>  		};
>  
> @@ -200,9 +206,11 @@
>  			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>  			clock-names = "apb_pclk";
>  
> -			port {
> -				etm0_out_port: endpoint {
> -					remote-endpoint = <&ca_funnel_in_port0>;
> +			out-ports {
> +				port {
> +					etm0_out_port: endpoint {
> +						remote-endpoint = <&ca_funnel_in_port0>;
> +					};
>  				};
>  			};
>  		};
> @@ -213,15 +221,13 @@
>  			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> +			in-ports {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  
> -				/* funnel input ports */
>  				port@0 {
>  					reg = <0>;
>  					hugo_funnel_in_port0: endpoint {
> -						slave-mode;
>  						remote-endpoint = <&ca_funnel_out_port0>;
>  					};
>  				};
> @@ -229,18 +235,22 @@
>  				port@1 {
>  					reg = <1>;
>  					hugo_funnel_in_port1: endpoint {
> -						slave-mode; /* M4 input */
> +						/* M4 input */
>  					};
>  				};
> +				/* the other input ports are not connect to anything */
> +			};
>  
> -				port@2 {
> +			out-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
>  					reg = <0>;
>  					hugo_funnel_out_port0: endpoint {
>  						remote-endpoint = <&etf_in_port>;
>  					};
>  				};
> -
> -				/* the other input ports are not connect to anything */
>  			};
>  		};
>  
> @@ -250,19 +260,23 @@
>  			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> +			in-ports {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  
>  				port@0 {
>  					reg = <0>;
>  					etf_in_port: endpoint {
> -						slave-mode;
>  						remote-endpoint = <&hugo_funnel_out_port0>;
>  					};
>  				};
> +			};
>  
> -				port@1 {
> +			out-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
>  					reg = <0>;
>  					etf_out_port: endpoint {
>  						remote-endpoint = <&replicator_in_port0>;
> @@ -277,10 +291,11 @@
>  			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>  			clock-names = "apb_pclk";
>  
> -			port {
> -				etr_in_port: endpoint {
> -					slave-mode;
> -					remote-endpoint = <&replicator_out_port1>;
> +			in-ports {
> +				port {
> +					etr_in_port: endpoint {
> +						remote-endpoint = <&replicator_out_port1>;
> +					};
>  				};
>  			};
>  		};
> @@ -291,10 +306,11 @@
>  			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
>  			clock-names = "apb_pclk";
>  
> -			port {
> -				tpiu_in_port: endpoint {
> -					slave-mode;
> -					remote-endpoint = <&replicator_out_port0>;
> +			in-ports {
> +				port {
> +					tpiu_in_port: endpoint {
> +						remote-endpoint = <&replicator_out_port0>;
> +					};
>  				};
>  			};
>  		};
> -- 
> 2.7.4
> 
