Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AA4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232822154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232822154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390223AbeIUTzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:55:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389434AbeIUTzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:55:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D64DBEE061EE;
        Fri, 21 Sep 2018 22:06:48 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 22:06:42 +0800
Subject: Re: [PATCH v2 03/11] arm64: dts: hi6220: Update coresight bindings
 for hardware ports
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-4-suzuki.poulose@arm.com>
CC:     <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <coresight@lists.linaro.org>,
        <leo.yan@linaro.org>, <lipengcheng8@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5BA4FAEA.3010502@hisilicon.com>
Date:   Fri, 21 Sep 2018 15:06:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180912135352.19722-4-suzuki.poulose@arm.com>
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
> Switch to updated coresight bindings for hw ports.
> 
> Cc: xuwei5@hisilicon.com
> Cc: lipengcheng8@huawei.com
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  .../boot/dts/hisilicon/hi6220-coresight.dtsi  | 181 +++++++++---------
>  1 file changed, 86 insertions(+), 95 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> index 7afee5d5087b..68c52f1149be 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> @@ -20,22 +20,18 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +			out-ports {
> +				port {
>  					soc_funnel_out: endpoint {
>  						remote-endpoint =
>  							<&etf_in>;
>  					};
>  				};
> +			};
>  
> -				port@1 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					soc_funnel_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&acpu_funnel_out>;
>  					};
> @@ -49,21 +45,17 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					etf_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&soc_funnel_out>;
>  					};
>  				};
> +			};
>  
> -				port@1 {
> -					reg = <0>;
> +			out-ports {
> +				port {
>  					etf_out: endpoint {
>  						remote-endpoint =
>  							<&replicator_in>;
> @@ -77,20 +69,20 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					replicator_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etf_out>;
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
>  					replicator_out0: endpoint {
>  						remote-endpoint =
> @@ -98,7 +90,7 @@
>  					};
>  				};
>  
> -				port@2 {
> +				port@1 {
>  					reg = <1>;
>  					replicator_out1: endpoint {
>  						remote-endpoint =
> @@ -114,14 +106,9 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					etr_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&replicator_out0>;
>  					};
> @@ -135,14 +122,9 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>  					tpiu_in: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&replicator_out1>;
>  					};
> @@ -156,85 +138,78 @@
>  			clocks = <&acpu_sctrl HI6220_ACPU_SFT_AT_S>;
>  			clock-names = "apb_pclk";
>  
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +			out-ports {
> +				port {
>  					acpu_funnel_out: endpoint {
>  						remote-endpoint =
>  							<&soc_funnel_in>;
>  					};
>  				};
> +			};
>  
> -				port@1 {
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
>  					reg = <0>;
>  					acpu_funnel_in0: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm0_out>;
>  					};
>  				};
>  
> -				port@2 {
> +				port@1 {
>  					reg = <1>;
>  					acpu_funnel_in1: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm1_out>;
>  					};
>  				};
>  
> -				port@3 {
> +				port@2 {
>  					reg = <2>;
>  					acpu_funnel_in2: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm2_out>;
>  					};
>  				};
>  
> -				port@4 {
> +				port@3 {
>  					reg = <3>;
>  					acpu_funnel_in3: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm3_out>;
>  					};
>  				};
>  
> -				port@5 {
> +				port@4 {
>  					reg = <4>;
>  					acpu_funnel_in4: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm4_out>;
>  					};
>  				};
>  
> -				port@6 {
> +				port@5 {
>  					reg = <5>;
>  					acpu_funnel_in5: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm5_out>;
>  					};
>  				};
>  
> -				port@7 {
> +				port@6 {
>  					reg = <6>;
>  					acpu_funnel_in6: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm6_out>;
>  					};
>  				};
>  
> -				port@8 {
> +				port@7 {
>  					reg = <7>;
>  					acpu_funnel_in7: endpoint {
> -						slave-mode;
>  						remote-endpoint =
>  							<&etm7_out>;
>  					};
> @@ -251,10 +226,12 @@
>  
>  			cpu = <&cpu0>;
>  
> -			port {
> -				etm0_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in0>;
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in0>;
> +					};
>  				};
>  			};
>  		};
> @@ -268,10 +245,12 @@
>  
>  			cpu = <&cpu1>;
>  
> -			port {
> -				etm1_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in1>;
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in1>;
> +					};
>  				};
>  			};
>  		};
> @@ -285,10 +264,12 @@
>  
>  			cpu = <&cpu2>;
>  
> -			port {
> -				etm2_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in2>;
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in2>;
> +					};
>  				};
>  			};
>  		};
> @@ -302,10 +283,12 @@
>  
>  			cpu = <&cpu3>;
>  
> -			port {
> -				etm3_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in3>;
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in3>;
> +					};
>  				};
>  			};
>  		};
> @@ -319,10 +302,12 @@
>  
>  			cpu = <&cpu4>;
>  
> -			port {
> -				etm4_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in4>;
> +			out-ports {
> +				port {
> +					etm4_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in4>;
> +					};
>  				};
>  			};
>  		};
> @@ -336,10 +321,12 @@
>  
>  			cpu = <&cpu5>;
>  
> -			port {
> -				etm5_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in5>;
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in5>;
> +					};
>  				};
>  			};
>  		};
> @@ -353,10 +340,12 @@
>  
>  			cpu = <&cpu6>;
>  
> -			port {
> -				etm6_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in6>;
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in6>;
> +					};
>  				};
>  			};
>  		};
> @@ -370,10 +359,12 @@
>  
>  			cpu = <&cpu7>;
>  
> -			port {
> -				etm7_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in7>;
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in7>;
> +					};
>  				};
>  			};
>  		};
> 

