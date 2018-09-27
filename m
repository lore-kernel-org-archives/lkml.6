Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51782C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E398F2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E398F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeI0OeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:34:11 -0400
Received: from foss.arm.com ([217.140.101.70]:58650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeI0OeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:34:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F08C7A9;
        Thu, 27 Sep 2018 01:17:09 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33183F5B3;
        Thu, 27 Sep 2018 01:17:05 -0700 (PDT)
Subject: Re: [PATCH v2 05/11] arm64: dts: msm8916: Update coresight bindings
 for hardware ports
To:     linux-arm-kernel@lists.infradead.org,
        Andy Gross <andy.gross@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, coresight@lists.linaro.org,
        leo.yan@linaro.org, David Brown <david.brown@linaro.org>,
        "Ivan T . Ivanov" <ivan.ivanov@linaro.org>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-6-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8ada229a-49ca-95ff-dc31-df459aaa7196@arm.com>
Date:   Thu, 27 Sep 2018 09:18:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180912135352.19722-6-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for hw ports
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1:
>   - Fixed TPIU port direction
>   - Use better subject tag for the patch
> ---


Please could you pull this and the patch for ARM (Patch 9/11)  ?

Suzuki



>   arch/arm64/boot/dts/qcom/msm8916.dtsi | 95 ++++++++++++++-------------
>   1 file changed, 51 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 7b32b8990d62..fe375a9c218e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1099,10 +1099,11 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			port {
> -				tpiu_in: endpoint {
> -					slave-mode;
> -					remote-endpoint = <&replicator_out1>;
> +			in-ports {
> +				port {
> +					tpiu_in: endpoint {
> +						remote-endpoint = <&replicator_out1>;
> +					};
>   				};
>   			};
>   		};
> @@ -1114,7 +1115,7 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			ports {
> +			in-ports {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -1132,12 +1133,13 @@
>   				port@4 {
>   					reg = <4>;
>   					funnel0_in4: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&funnel1_out>;
>   					};
>   				};
> -				port@8 {
> -					reg = <0>;
> +			};
> +
> +			out-ports {
> +				port {
>   					funnel0_out: endpoint {
>   						remote-endpoint = <&etf_in>;
>   					};
> @@ -1152,7 +1154,7 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			ports {
> +			out-ports {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> @@ -1168,10 +1170,11 @@
>   						remote-endpoint = <&tpiu_in>;
>   					};
>   				};
> -				port@2 {
> -					reg = <0>;
> +			};
> +
> +			in-ports {
> +				port {
>   					replicator_in: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etf_out>;
>   					};
>   				};
> @@ -1185,19 +1188,16 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +			in-ports {
> +				port {
>   					etf_in: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&funnel0_out>;
>   					};
>   				};
> -				port@1 {
> -					reg = <0>;
> +			};
> +
> +			out-ports {
> +				port {
>   					etf_out: endpoint {
>   						remote-endpoint = <&replicator_in>;
>   					};
> @@ -1212,10 +1212,11 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			port {
> -				etr_in: endpoint {
> -					slave-mode;
> -					remote-endpoint = <&replicator_out0>;
> +			in-ports {
> +				port {
> +					etr_in: endpoint {
> +						remote-endpoint = <&replicator_out0>;
> +					};
>   				};
>   			};
>   		};
> @@ -1227,40 +1228,38 @@
>   			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>   			clock-names = "apb_pclk", "atclk";
>   
> -			ports {
> +			in-ports {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
>   				port@0 {
>   					reg = <0>;
>   					funnel1_in0: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etm0_out>;
>   					};
>   				};
>   				port@1 {
>   					reg = <1>;
>   					funnel1_in1: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etm1_out>;
>   					};
>   				};
>   				port@2 {
>   					reg = <2>;
>   					funnel1_in2: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etm2_out>;
>   					};
>   				};
>   				port@3 {
>   					reg = <3>;
>   					funnel1_in3: endpoint {
> -						slave-mode;
>   						remote-endpoint = <&etm3_out>;
>   					};
>   				};
> -				port@4 {
> -					reg = <0>;
> +			};
> +
> +			out-ports {
> +				port {
>   					funnel1_out: endpoint {
>   						remote-endpoint = <&funnel0_in4>;
>   					};
> @@ -1309,9 +1308,11 @@
>   
>   			cpu = <&CPU0>;
>   
> -			port {
> -				etm0_out: endpoint {
> -				remote-endpoint = <&funnel1_in0>;
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint = <&funnel1_in0>;
> +					};
>   				};
>   			};
>   		};
> @@ -1325,9 +1326,11 @@
>   
>   			cpu = <&CPU1>;
>   
> -			port {
> -				etm1_out: endpoint {
> -					remote-endpoint = <&funnel1_in1>;
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint = <&funnel1_in1>;
> +					};
>   				};
>   			};
>   		};
> @@ -1341,9 +1344,11 @@
>   
>   			cpu = <&CPU2>;
>   
> -			port {
> -				etm2_out: endpoint {
> -					remote-endpoint = <&funnel1_in2>;
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint = <&funnel1_in2>;
> +					};
>   				};
>   			};
>   		};
> @@ -1357,9 +1362,11 @@
>   
>   			cpu = <&CPU3>;
>   
> -			port {
> -				etm3_out: endpoint {
> -					remote-endpoint = <&funnel1_in3>;
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint = <&funnel1_in3>;
> +					};
>   				};
>   			};
>   		};
> 

