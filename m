Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681ABC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3161720850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIRXKeXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3161720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937172AbeFSCNS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937005AbeFSCNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:13:17 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBBBB2083A;
        Tue, 19 Jun 2018 02:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529374396;
        bh=vM1jmOxGPlNG7JR9nyFBkGrA4M6gC3SgSLUiEojXY0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIRXKeXTFZW4Vz/Rzrd9awp4P4/XajcgKY0Gj7esY58AsEcjxfnGcuNALPynjmtK1
         dt3TfRF+CXcDQScsWA9srLQwZ6jjZalAsHbiUu5S5dRf5lJW6IKEG5+vVUbJWkB+Ef
         GaKyCwUtrx/j3BS7ba4RHkcznQigF3uE5NCPoYaw=
Date:   Tue, 19 Jun 2018 10:12:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        robh@kernel.org, frowand.list@gmail.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, arm@kernel.org, linux-kernel@vger.kernel.org,
        matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 15/20] dts: arm: imx7{d,s}: Update coresight binding for
 hardware ports
Message-ID: <20180619021218.GV16091@dragon>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-16-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-16-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Can you take a look at the patch?  Thanks.

Shawn

On Tue, Jun 05, 2018 at 10:43:26PM +0100, Suzuki K Poulose wrote:
> Switch to the updated coresight bindings.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm/boot/dts/imx7d.dtsi |  5 ++++-
>  arch/arm/boot/dts/imx7s.dtsi | 41 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 200714e..5faff17 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -87,7 +87,9 @@
>  
>  			port {
>  				etm1_out_port: endpoint {
> +					direction = <1>;
>  					remote-endpoint = <&ca_funnel_in_port1>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  		};
> @@ -174,8 +176,9 @@
>  	port@1 {
>  		reg = <1>;
>  		ca_funnel_in_port1: endpoint {
> -			slave-mode;
> +			direction = <0>;
>  			remote-endpoint = <&etm1_out_port>;
> +			coresight,hwid = <1>;
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 4d42335..8e90915 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -151,23 +151,28 @@
>  			port@0 {
>  				reg = <0>;
>  				replicator_out_port0: endpoint {
> +					direction = <1>;
>  					remote-endpoint = <&tpiu_in_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			port@1 {
>  				reg = <1>;
>  				replicator_out_port1: endpoint {
> +					direction = <1>;
>  					remote-endpoint = <&etr_in_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  
>  			/* replicator input port */
>  			port@2 {
> -				reg = <0>;
> +				reg = <2>;
>  				replicator_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&etf_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  		};
> @@ -203,16 +208,19 @@
>  				port@0 {
>  					reg = <0>;
>  					ca_funnel_in_port0: endpoint {
> -						slave-mode;
> +						direction = <0>;
>  						remote-endpoint = <&etm0_out_port>;
> +						coresight,hwid = <0>;
>  					};
>  				};
>  
>  				/* funnel output port */
>  				port@2 {
> -					reg = <0>;
> +					reg = <2>;
>  					ca_funnel_out_port0: endpoint {
> +						direction = <1>;
>  						remote-endpoint = <&hugo_funnel_in_port0>;
> +						coresight,hwid = <0>;
>  					};
>  				};
>  
> @@ -229,7 +237,9 @@
>  
>  			port {
>  				etm0_out_port: endpoint {
> +					direction = <1>;
>  					remote-endpoint = <&ca_funnel_in_port0>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  		};
> @@ -248,22 +258,26 @@
>  				port@0 {
>  					reg = <0>;
>  					hugo_funnel_in_port0: endpoint {
> -						slave-mode;
> +						direction = <0>;
>  						remote-endpoint = <&ca_funnel_out_port0>;
> +						coresight,hwid = <0>;
>  					};
>  				};
>  
>  				port@1 {
>  					reg = <1>;
>  					hugo_funnel_in_port1: endpoint {
> -						slave-mode; /* M4 input */
> +						direction = <0>; /* M4 input */
> +						coresight,hwid = <1>;
>  					};
>  				};
>  
>  				port@2 {
> -					reg = <0>;
> +					reg = <2>;
>  					hugo_funnel_out_port0: endpoint {
> +						direction = <1>;
>  						remote-endpoint = <&etf_in_port>;
> +						coresight,hwid = <0>;
>  					};
>  				};
>  
> @@ -284,15 +298,18 @@
>  				port@0 {
>  					reg = <0>;
>  					etf_in_port: endpoint {
> -						slave-mode;
> +						direction = <0>;
>  						remote-endpoint = <&hugo_funnel_out_port0>;
> +						coresight,hwid = <0>;
>  					};
>  				};
>  
>  				port@1 {
> -					reg = <0>;
> +					reg = <1>;
>  					etf_out_port: endpoint {
> +						direction = <1>;
>  						remote-endpoint = <&replicator_in_port0>;
> +						coresight,hwid = <0>;
>  					};
>  				};
>  			};
> @@ -306,8 +323,9 @@
>  
>  			port {
>  				etr_in_port: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&replicator_out_port1>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  		};
> @@ -320,8 +338,9 @@
>  
>  			port {
>  				tpiu_in_port: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&replicator_out_port1>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  		};
> -- 
> 2.7.4
> 
