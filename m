Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E4820899
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E4820899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbeG0LjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:39:09 -0400
Received: from foss.arm.com ([217.140.101.70]:41094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbeG0LjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:39:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96C7215AD;
        Fri, 27 Jul 2018 03:17:54 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45E9E3F575;
        Fri, 27 Jul 2018 03:17:54 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 9ED3F6801CC; Fri, 27 Jul 2018 11:17:52 +0100 (BST)
Date:   Fri, 27 Jul 2018 11:17:52 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, coresight@lists.linaro.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, al.grant@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 9/9] dts: juno: Update coresight bindings
Message-ID: <20180727101752.GB28995@e110455-lin.cambridge.arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
 <1532686537-12380-10-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532686537-12380-10-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:15:37AM +0100, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for Juno platforms.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Looks good to me.

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> Changes since V2:
>   - Update to new format.
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi    | 161 +++++++++++++++---------------
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  52 ++++------
>  arch/arm64/boot/dts/arm/juno.dts          |  13 +--
>  3 files changed, 105 insertions(+), 121 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index ce56a4a..a418193 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -115,22 +115,17 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  
> -			/* input port */
> -			port@0 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				etf0_in_port: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&main_funnel_out_port>;
>  				};
>  			};
> +		};
>  
> -			/* output port */
> -			port@1 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				etf0_out_port: endpoint {
>  				};
>  			};
> @@ -144,10 +139,11 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			tpiu_in_port: endpoint {
> -				slave-mode;
> -				remote-endpoint = <&replicator_out_port0>;
> +		in-ports {
> +			port {
> +				tpiu_in_port: endpoint {
> +					remote-endpoint = <&replicator_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -160,31 +156,29 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
>  
> -			/* output port */
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				main_funnel_out_port: endpoint {
>  					remote-endpoint = <&etf0_in_port>;
>  				};
>  			};
> +		};
>  
> -			/* input ports */
> -			port@1 {
> +		main_funnel_in_ports: in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				main_funnel_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&cluster0_funnel_out_port>;
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				main_funnel_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&cluster1_funnel_out_port>;
>  				};
>  			};
> @@ -199,10 +193,11 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			etr_in_port: endpoint {
> -				slave-mode;
> -				remote-endpoint = <&replicator_out_port1>;
> +		in-ports {
> +			port {
> +				etr_in_port: endpoint {
> +					remote-endpoint = <&replicator_out_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -216,8 +211,10 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			stm_out_port: endpoint {
> +		out-ports {
> +			port {
> +				stm_out_port: endpoint {
> +				};
>  			};
>  		};
>  	};
> @@ -238,9 +235,11 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			cluster0_etm0_out_port: endpoint {
> -				remote-endpoint = <&cluster0_funnel_in_port0>;
> +		out-ports {
> +			port {
> +				cluster0_etm0_out_port: endpoint {
> +					remote-endpoint = <&cluster0_funnel_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -252,29 +251,28 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				cluster0_funnel_out_port: endpoint {
>  					remote-endpoint = <&main_funnel_in_port0>;
>  				};
>  			};
> +		};
>  
> -			port@1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				cluster0_funnel_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&cluster0_etm0_out_port>;
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				cluster0_funnel_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&cluster0_etm1_out_port>;
>  				};
>  			};
> @@ -297,9 +295,11 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			cluster0_etm1_out_port: endpoint {
> -				remote-endpoint = <&cluster0_funnel_in_port1>;
> +		out-ports {
> +			port {
> +				cluster0_etm1_out_port: endpoint {
> +					remote-endpoint = <&cluster0_funnel_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -320,9 +320,11 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			cluster1_etm0_out_port: endpoint {
> -				remote-endpoint = <&cluster1_funnel_in_port0>;
> +		out-ports {
> +			port {
> +				cluster1_etm0_out_port: endpoint {
> +					remote-endpoint = <&cluster1_funnel_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -334,43 +336,40 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				cluster1_funnel_out_port: endpoint {
>  					remote-endpoint = <&main_funnel_in_port1>;
>  				};
>  			};
> +		};
>  
> -			port@1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				cluster1_funnel_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&cluster1_etm0_out_port>;
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				cluster1_funnel_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&cluster1_etm1_out_port>;
>  				};
>  			};
> -			port@3 {
> +			port@2 {
>  				reg = <2>;
>  				cluster1_funnel_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&cluster1_etm2_out_port>;
>  				};
>  			};
> -			port@4 {
> +			port@3 {
>  				reg = <3>;
>  				cluster1_funnel_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&cluster1_etm3_out_port>;
>  				};
>  			};
> @@ -393,9 +392,11 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			cluster1_etm1_out_port: endpoint {
> -				remote-endpoint = <&cluster1_funnel_in_port1>;
> +		out-ports {
> +			port {
> +				cluster1_etm1_out_port: endpoint {
> +					remote-endpoint = <&cluster1_funnel_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -416,9 +417,11 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			cluster1_etm2_out_port: endpoint {
> -				remote-endpoint = <&cluster1_funnel_in_port2>;
> +		out-ports {
> +			port {
> +				cluster1_etm2_out_port: endpoint {
> +					remote-endpoint = <&cluster1_funnel_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -439,9 +442,11 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		port {
> -			cluster1_etm3_out_port: endpoint {
> -				remote-endpoint = <&cluster1_funnel_in_port3>;
> +		out-ports {
> +			port {
> +				cluster1_etm3_out_port: endpoint {
> +					remote-endpoint = <&cluster1_funnel_in_port3>;
> +				};
>  			};
>  		};
>  	};
> @@ -454,7 +459,7 @@
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> @@ -472,12 +477,10 @@
>  					remote-endpoint = <&etr_in_port>;
>  				};
>  			};
> -
> -			/* replicator input port */
> -			port@2 {
> -				reg = <0>;
> +		};
> +		in-ports {
> +			port {
>  				replicator_in_port0: endpoint {
> -					slave-mode;
>  				};
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> index 0c43fb3..cf28515 100644
> --- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> @@ -7,23 +7,16 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* output port */
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				csys1_funnel_out_port: endpoint {
>  					remote-endpoint = <&etf1_in_port>;
>  				};
>  			};
> -
> -			/* input port */
> -			port@1 {
> -				reg = <0>;
> +		};
> +		in-ports {
> +			port {
>  				csys1_funnel_in_port0: endpoint {
> -					slave-mode;
>  				};
>  			};
>  
> @@ -37,22 +30,15 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* input port */
> -			port@0 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				etf1_in_port: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&csys1_funnel_out_port>;
>  				};
>  			};
> -
> -			/* output port */
> -			port@1 {
> -				reg = <0>;
> +		};
> +		out-ports {
> +			port {
>  				etf1_out_port: endpoint {
>  					remote-endpoint = <&csys2_funnel_in_port1>;
>  				};
> @@ -67,20 +53,18 @@
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
>  		power-domains = <&scpi_devpd 0>;
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* output port */
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				csys2_funnel_out_port: endpoint {
>  					remote-endpoint = <&replicator_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* input ports */
> -			port@1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			port@0 {
>  				reg = <0>;
>  				csys2_funnel_in_port0: endpoint {
>  					slave-mode;
> @@ -88,7 +72,7 @@
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				csys2_funnel_in_port1: endpoint {
>  					slave-mode;
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index 2b2bf39..eb55c2f 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -257,14 +257,11 @@
>  	remote-endpoint = <&main_funnel_in_port2>;
>  };
>  
> -&main_funnel {
> -	ports {
> -		port@3 {
> -			reg = <2>;
> -			main_funnel_in_port2: endpoint {
> -				slave-mode;
> -				remote-endpoint = <&stm_out_port>;
> -			};
> +&main_funnel_in_ports {
> +	port@2 {
> +		reg = <2>;
> +		main_funnel_in_port2: endpoint {
> +			remote-endpoint = <&stm_out_port>;
>  		};
>  	};
>  };
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
