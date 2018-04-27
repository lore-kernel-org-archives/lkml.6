Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeD0KpP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:45:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeD0KpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:45:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49C7960390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v4 1/5] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
To: Philipp Zabel <p.zabel@pengutronix.de>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180425150843.26657-1-sibis@codeaurora.org>
 <20180425150843.26657-2-sibis@codeaurora.org>
 <1524824650.17614.4.camel@pengutronix.de>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <9e5ed0e1-e397-68f4-281b-6df09c8c125e@codeaurora.org>
Date: Fri, 27 Apr 2018 16:15:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1524824650.17614.4.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thanks for the review

On 04/27/2018 03:54 PM, Philipp Zabel wrote:
> Hi Sibi,
> 
> On Wed, 2018-04-25 at 20:38 +0530, Sibi Sankar wrote:
>> Add SDM845 AOSS (always on subsystem) reset controller binding
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   .../bindings/reset/qcom,aoss-reset.txt        | 52 +++++++++++++++++++
>>   include/dt-bindings/reset/qcom,sdm845-aoss.h  | 17 ++++++
>>   2 files changed, 69 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>>   create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>> new file mode 100644
>> index 000000000000..e5201de9a314
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>> @@ -0,0 +1,52 @@
>> +Qualcomm AOSS Reset Controller
>> +======================================
>> +
>> +This binding describes a reset-controller found on AOSS (always on subsystem)
>> +for Qualcomm SDM845 SoCs.
>> +
>> +Required properties:
>> +- compatible:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: must be:
>> +		    "qcom,sdm845-aoss-reset"
>> +
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must specify the base address and size of the register
>> +	            space.
>> +
>> +- #reset-cells:
>> +	Usage: required
>> +	Value type: <uint>
>> +	Definition: must be 1; cell entry represents the reset index.
>> +
>> +Example:
>> +
>> +aoss_reset: qcom,reset-controller@b2e0100 {
> 
> The node name should be "reset-controller", not "qcom,reset-controller"
> 
>> +	compatible = "qcom,sdm845-aoss-reset";
>> +	reg = <0xc2b0000 0x21000>;
> 
> The address here should match the address part of the node name above.
> 

sure will change them

> Apart from those two nitpicks, the binding looks good to me.
>
> regards
> Philipp
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
