Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8C4ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8921523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD8921523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390320AbeIUT4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:56:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46489 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389547AbeIUT4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:56:18 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0C42A28F3A31D;
        Fri, 21 Sep 2018 22:07:08 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 22:07:06 +0800
Subject: Re: [PATCH v2 06/11] arm: dts: hip04: Update coresight bindings for
 hardware ports
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-7-suzuki.poulose@arm.com>
CC:     <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <coresight@lists.linaro.org>,
        <leo.yan@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5BA4FB02.1000607@hisilicon.com>
Date:   Fri, 21 Sep 2018 15:06:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180912135352.19722-7-suzuki.poulose@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2018/9/12 14:53, Suzuki K Poulose wrote:
> Switch to the new the hardware port bindings.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm/boot/dts/hip04.dtsi | 346 ++++++++++++++++++-----------------
>  1 file changed, 176 insertions(+), 170 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> index 44044f275115..0f917b272ff3 100644
> --- a/arch/arm/boot/dts/hip04.dtsi
> +++ b/arch/arm/boot/dts/hip04.dtsi
> @@ -277,10 +277,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb0_in_port: endpoint@0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator0_out_port0>;
> +		in-ports {
> +			port {
> +				etb0_in_port: endpoint@0 {
> +					remote-endpoint = <&replicator0_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -291,10 +292,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb1_in_port: endpoint@0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator1_out_port0>;
> +		in-ports {
> +			port {
> +				etb1_in_port: endpoint@0 {
> +					remote-endpoint = <&replicator1_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -305,10 +307,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb2_in_port: endpoint@0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator2_out_port0>;
> +		in-ports {
> +			port {
> +				etb2_in_port: endpoint@0 {
> +					remote-endpoint = <&replicator2_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -319,10 +322,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb3_in_port: endpoint@0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator3_out_port0>;
> +		in-ports {
> +			port {
> +				etb3_in_port: endpoint@0 {
> +					remote-endpoint = <&replicator3_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -333,10 +337,11 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		port {
> -			tpiu_in_port: endpoint@0 {
> -				slave-mode;
> -				remote-endpoint = <&funnel4_out_port0>;
> +		in-ports {
> +			port {
> +				tpiu_in_port: endpoint@0 {
> +					remote-endpoint = <&funnel4_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -347,7 +352,7 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> @@ -365,12 +370,11 @@
>  					remote-endpoint = <&funnel4_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port@2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator0_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel0_out_port0>;
>  				};
>  			};
> @@ -383,7 +387,7 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> @@ -401,12 +405,11 @@
>  					remote-endpoint = <&funnel4_in_port1>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port@2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator1_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel1_out_port0>;
>  				};
>  			};
> @@ -419,11 +422,10 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			/* replicator output ports */
>  			port@0 {
>  				reg = <0>;
>  				replicator2_out_port0: endpoint {
> @@ -437,12 +439,11 @@
>  					remote-endpoint = <&funnel4_in_port2>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port@2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator2_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel2_out_port0>;
>  				};
>  			};
> @@ -455,11 +456,10 @@
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			/* replicator output ports */
>  			port@0 {
>  				reg = <0>;
>  				replicator3_out_port0: endpoint {
> @@ -473,12 +473,11 @@
>  					remote-endpoint = <&funnel4_in_port3>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port@2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator3_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel3_out_port0>;
>  				};
>  			};
> @@ -491,48 +490,43 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel0_out_port0: endpoint {
>  					remote-endpoint =
>  						<&replicator0_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port@1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				funnel0_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm0_out_port>;
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				funnel0_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm1_out_port>;
>  				};
>  			};
>  
> -			port@3 {
> +			port@2 {
>  				reg = <2>;
>  				funnel0_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm2_out_port>;
>  				};
>  			};
>  
> -			port@4 {
> +			port@3 {
>  				reg = <3>;
>  				funnel0_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm3_out_port>;
>  				};
>  			};
> @@ -545,48 +539,43 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel1_out_port0: endpoint {
>  					remote-endpoint =
>  						<&replicator1_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port@1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				funnel1_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm4_out_port>;
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				funnel1_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm5_out_port>;
>  				};
>  			};
>  
> -			port@3 {
> +			port@2 {
>  				reg = <2>;
>  				funnel1_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm6_out_port>;
>  				};
>  			};
>  
> -			port@4 {
> +			port@3 {
>  				reg = <3>;
>  				funnel1_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm7_out_port>;
>  				};
>  			};
> @@ -599,48 +588,43 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel2_out_port0: endpoint {
>  					remote-endpoint =
>  						<&replicator2_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port@1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				funnel2_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm8_out_port>;
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				funnel2_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm9_out_port>;
>  				};
>  			};
>  
> -			port@3 {
> +			port@2 {
>  				reg = <2>;
>  				funnel2_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm10_out_port>;
>  				};
>  			};
>  
> -			port@4 {
> +			port@3 {
>  				reg = <3>;
>  				funnel2_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm11_out_port>;
>  				};
>  			};
> @@ -653,48 +637,43 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel3_out_port0: endpoint {
>  					remote-endpoint =
>  						<&replicator3_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port@1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				funnel3_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm12_out_port>;
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				funnel3_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm13_out_port>;
>  				};
>  			};
>  
> -			port@3 {
> +			port@2 {
>  				reg = <2>;
>  				funnel3_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm14_out_port>;
>  				};
>  			};
>  
> -			port@4 {
> +			port@3 {
>  				reg = <3>;
>  				funnel3_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm15_out_port>;
>  				};
>  			};
> @@ -707,50 +686,45 @@
>  
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port@0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel4_out_port0: endpoint {
>  					remote-endpoint = <&tpiu_in_port>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port@1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
>  				reg = <0>;
>  				funnel4_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint =
>  						<&replicator0_out_port1>;
>  				};
>  			};
>  
> -			port@2 {
> +			port@1 {
>  				reg = <1>;
>  				funnel4_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint =
>  						<&replicator1_out_port1>;
>  				};
>  			};
>  
> -			port@3 {
> +			port@2 {
>  				reg = <2>;
>  				funnel4_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint =
>  						<&replicator2_out_port1>;
>  				};
>  			};
>  
> -			port@4 {
> +			port@3 {
>  				reg = <3>;
>  				funnel4_in_port3: endpoint {
> -					slave-mode;
>  					remote-endpoint =
>  						<&replicator3_out_port1>;
>  				};
> @@ -765,9 +739,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU0>;
> -		port {
> -			ptm0_out_port: endpoint {
> -				remote-endpoint = <&funnel0_in_port0>;
> +		out-ports {
> +			port {
> +				ptm0_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -779,9 +755,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU1>;
> -		port {
> -			ptm1_out_port: endpoint {
> -				remote-endpoint = <&funnel0_in_port1>;
> +		out-ports {
> +			port {
> +				ptm1_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -793,9 +771,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU2>;
> -		port {
> -			ptm2_out_port: endpoint {
> -				remote-endpoint = <&funnel0_in_port2>;
> +		out-ports {
> +			port {
> +				ptm2_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -807,9 +787,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU3>;
> -		port {
> -			ptm3_out_port: endpoint {
> -				remote-endpoint = <&funnel0_in_port3>;
> +		out-ports {
> +			port {
> +				ptm3_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port3>;
> +				};
>  			};
>  		};
>  	};
> @@ -821,9 +803,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU4>;
> -		port {
> -			ptm4_out_port: endpoint {
> -				remote-endpoint = <&funnel1_in_port0>;
> +		out-ports {
> +			port {
> +				ptm4_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -835,9 +819,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU5>;
> -		port {
> -			ptm5_out_port: endpoint {
> -				remote-endpoint = <&funnel1_in_port1>;
> +		out-ports {
> +			port {
> +				ptm5_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -849,9 +835,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU6>;
> -		port {
> -			ptm6_out_port: endpoint {
> -				remote-endpoint = <&funnel1_in_port2>;
> +		out-ports {
> +			port {
> +				ptm6_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -863,9 +851,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU7>;
> -		port {
> -			ptm7_out_port: endpoint {
> -				remote-endpoint = <&funnel1_in_port3>;
> +		out-ports {
> +			port {
> +				ptm7_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port3>;
> +				};
>  			};
>  		};
>  	};
> @@ -877,9 +867,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU8>;
> -		port {
> -			ptm8_out_port: endpoint {
> -				remote-endpoint = <&funnel2_in_port0>;
> +		out-ports {
> +			port {
> +				ptm8_out_port: endpoint {
> +					remote-endpoint = <&funnel2_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -890,9 +882,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU9>;
> -		port {
> -			ptm9_out_port: endpoint {
> -				remote-endpoint = <&funnel2_in_port1>;
> +		out-ports {
> +			port {
> +				ptm9_out_port: endpoint {
> +					remote-endpoint = <&funnel2_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -904,9 +898,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU10>;
> -		port {
> -			ptm10_out_port: endpoint {
> -				remote-endpoint = <&funnel2_in_port2>;
> +		out-ports {
> +			port {
> +				ptm10_out_port: endpoint {
> +					remote-endpoint = <&funnel2_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -918,9 +914,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU11>;
> -		port {
> -			ptm11_out_port: endpoint {
> -				remote-endpoint = <&funnel2_in_port3>;
> +		out-ports {
> +			port {
> +				ptm11_out_port: endpoint {
> +					remote-endpoint = <&funnel2_in_port3>;
> +				};
>  			};
>  		};
>  	};
> @@ -932,9 +930,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU12>;
> -		port {
> -			ptm12_out_port: endpoint {
> -				remote-endpoint = <&funnel3_in_port0>;
> +		out-ports {
> +			port {
> +				ptm12_out_port: endpoint {
> +					remote-endpoint = <&funnel3_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -946,9 +946,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU13>;
> -		port {
> -			ptm13_out_port: endpoint {
> -				remote-endpoint = <&funnel3_in_port1>;
> +		out-ports {
> +			port {
> +				ptm13_out_port: endpoint {
> +					remote-endpoint = <&funnel3_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -960,9 +962,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU14>;
> -		port {
> -			ptm14_out_port: endpoint {
> -				remote-endpoint = <&funnel3_in_port2>;
> +		out-ports {
> +			port {
> +				ptm14_out_port: endpoint {
> +					remote-endpoint = <&funnel3_in_port2>;
> +				};
>  			};
>  		};
>  	};
> @@ -974,9 +978,11 @@
>  		clocks = <&clk_375m>;
>  		clock-names = "apb_pclk";
>  		cpu = <&CPU15>;
> -		port {
> -			ptm15_out_port: endpoint {
> -				remote-endpoint = <&funnel3_in_port3>;
> +		out-ports {
> +			port {
> +				ptm15_out_port: endpoint {
> +					remote-endpoint = <&funnel3_in_port3>;
> +				};
>  			};
>  		};
>  	};
> 

