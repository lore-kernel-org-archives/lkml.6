Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeDNCD0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 22:03:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeDNCDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 22:03:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06FC26081A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [[PATCH v2] 2/2] dt-bindings: clock: Introduce QCOM RPMh clock
 bindings
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1523183533-23171-1-git-send-email-tdas@codeaurora.org>
 <1523183533-23171-3-git-send-email-tdas@codeaurora.org>
 <20180409225853.GM453@tuxbook-pro>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <63dbb808-ba93-e5ae-329d-de34184019b5@codeaurora.org>
Date: Sat, 14 Apr 2018 07:33:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409225853.GM453@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,

Thanks for your review comments.

On 4/10/2018 4:28 AM, Bjorn Andersson wrote:
> On Sun 08 Apr 03:32 PDT 2018, Taniya Das wrote:
> 
>> From: Amit Nischal <anischal@codeaurora.org>
>>
>> Add RPMh clock device bindings for Qualcomm Technology Inc's SoCs. These
>> devices would be used for communicating resource state requests to control
>> the clocks managed by RPMh.
>>
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   .../devicetree/bindings/clock/qcom,rpmh-clk.txt    | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
>> new file mode 100644
>> index 0000000..4ade82b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmh-clk.txt
>> @@ -0,0 +1,22 @@
>> +Qualcomm Technologies, Inc. RPMh Clocks
>> +-------------------------------------------------------
>> +
>> +Resource Power Manager Hardened (RPMh) manages shared resources on
>> +some Qualcomm Technologies Inc. SoCs. It accepts clock requests from
>> +other hardware subsystems via RSC to control clocks.
>> +
>> +Required properties :
>> +- compatible : shall contain "qcom,rpmh-clk-sdm845"
> 
> We have a chance to fix this to Rob's liking, so please make this
> "qcom,sdm845-rpmh-clock" (or maybe "qcom,sdm845-rpmhcc"?)

I would fix  it to "qcom,sdm845-rpmh-clk".

> 
>> +
>> +- #clock-cells : must contain 1
>> +
>> +Example :
>> +
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +
>> +	&apps_rsc {
>> +		rpmh: clock-controller {
> 
> I believe the clock-controller, the power-domain and the bus-scaler are
> equal contenders of the label "rpmh", so please make it more specific.
> How about "rpmhcc" to mimic previous platforms?
> 

Would update it "rpmhcc".

>> +			compatible = "qcom,rpmh-clk-sdm845";
>> +			#clock-cells = <1>;
>> +		};
>> +	};
> 
> Regards,
> Bjorn
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
