Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeCPEiH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:38:07 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33663 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPEiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:38:05 -0400
X-Google-Smtp-Source: AG47ELumBldx/wdIodsHucaCkSxksaDHgAgmq3ZmTvFPu12fPyuSmxFHLz91d91z/BsBd/QzTr7apg==
Date: Fri, 16 Mar 2018 10:08:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: msm8996: Add rpmpd device node
Message-ID: <20180316043802.GR15832@vireshk-i7>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-6-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316040824.21472-6-rnayak@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-18, 09:38, Rajendra Nayak wrote:
> Add rpmpd device node and its OPP table
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 46 +++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 0a6f7952bbb1..43757a078146 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -297,6 +297,52 @@
>  				#clock-cells = <1>;
>  			};
>  
> +			rpmpd: qcom,rpmpd {
> +				compatible = "qcom,rpmpd-msm8996";
> +				#power-domain-cells = <1>;
> +				operating-points-v2 = <&rpmpd_opp_table>, /* cx */
> +						      <&rpmpd_opp_table>, /* cx_ao */
> +						      <&rpmpd_opp_table>, /* cx_vfc */
> +						      <&rpmpd_opp_table>, /* mx */
> +						      <&rpmpd_opp_table>, /* mx_ao */
> +						      <&rpmpd_opp_table>, /* sscx */
> +						      <&rpmpd_opp_table>; /* sscx_vfc */
> +			};
> +
> +			rpmpd_opp_table: opp-table {
> +				compatible = "operating-points-v2", "operating-points-v2-qcom";
> +
> +				rpmpd_opp1: opp@1 {
> +					opp-hz = /bits/ 64 <1>;

Actually this (magic values) isn't allowed right now. I will send a
patchset to make this property optional later on separately (once the
other series is accepted).

> +					qcom,level = <1>;
> +				};
> +
> +				rpmpd_opp2: opp@2 {
> +					opp-hz = /bits/ 64 <2>;
> +					qcom,level = <2>;
> +				};
> +
> +				rpmpd_opp3: opp@3 {
> +					opp-hz = /bits/ 64 <3>;
> +					qcom,level = <3>;
> +				};
> +
> +				rpmpd_opp4: opp@4 {
> +					opp-hz = /bits/ 64 <4>;
> +					qcom,level = <4>;
> +				};
> +
> +				rpmpd_opp5: opp@5 {
> +					opp-hz = /bits/ 64 <5>;
> +					qcom,level = <5>;
> +				};
> +
> +				rpmpd_opp6: opp@6 {
> +					opp-hz = /bits/ 64 <6>;
> +					qcom,level = <6>;
> +				};
> +			};
> +
>  			pm8994-regulators {
>  				compatible = "qcom,rpm-pm8994-regulators";
>  

Everything else is fine. After you remove the opp-hz property from
this table:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
