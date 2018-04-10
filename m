Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbeDJETo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 00:19:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeDJETm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 00:19:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6738E60540
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 5/7] arm64: dts: msm8996: Add rpmpd device node
To: Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-6-rnayak@codeaurora.org>
 <152328979897.180276.15963925877442657158@swboyd.mtv.corp.google.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <37ec8f55-8726-1ce1-70f6-3dfac7198158@codeaurora.org>
Date: Tue, 10 Apr 2018 09:49:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <152328979897.180276.15963925877442657158@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2018 09:33 PM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2018-03-15 21:08:22)
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 0a6f7952bbb1..43757a078146 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -297,6 +297,52 @@
>>                                 #clock-cells = <1>;
>>                         };
>>  
>> +                       rpmpd: qcom,rpmpd {
> 
> power-controller? power-domain-controller? power-domains? Or something
> like that.
> 
>> +                               compatible = "qcom,rpmpd-msm8996";
>> +                               #power-domain-cells = <1>;
>> +                               operating-points-v2 = <&rpmpd_opp_table>, /* cx */
>> +                                                     <&rpmpd_opp_table>, /* cx_ao */
>> +                                                     <&rpmpd_opp_table>, /* cx_vfc */
>> +                                                     <&rpmpd_opp_table>, /* mx */
>> +                                                     <&rpmpd_opp_table>, /* mx_ao */
>> +                                                     <&rpmpd_opp_table>, /* sscx */
>> +                                                     <&rpmpd_opp_table>; /* sscx_vfc */
>> +                       };
>> +
>> +                       rpmpd_opp_table: opp-table {
> 
> This should go into the root of the tree? Otherwise it may be populated
> by the RPMh platform populate code which would be odd. We should go and
> update the platform populate code to always ignore operating-points-v2
> compatible nodes too.
> 
>> +                               compatible = "operating-points-v2", "operating-points-v2-qcom";
> 
> This is backwards? I thought more specific compatible went first.

thanks for the review, will fixup all of these when I respin.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
