Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeDCCmG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 22:42:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32828 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeDCCmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 22:42:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 205A9607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v4 13/14] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
From: Sricharan R <sricharan@codeaurora.org>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-14-git-send-email-ilialin@codeaurora.org>
 <20180402093018.GC3572@vireshk-i7>
 <7ca35b7a-6078-620b-4772-091e53ef6790@codeaurora.org>
Message-ID: <06308b25-14ea-8d8b-6f95-f05c101a617b@codeaurora.org>
Date: Tue, 3 Apr 2018 08:11:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7ca35b7a-6078-620b-4772-091e53ef6790@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 4/2/2018 8:37 PM, Sricharan R wrote:
> Hi Viresh,
> 
> On 4/2/2018 3:00 PM, Viresh Kumar wrote:
>> +Sricharan,
>>
>> On 30-03-18, 00:26, Ilia Lin wrote:
>>> In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
>>> that have KRYO processors, the CPU ferequencies subset and voltage value
>>> of each OPP varies based on the silicon variant in use.
>>> Qualcomm Technologies, Inc. Process Voltage Scaling Tables
>>> defines the voltage and frequency value based on the msm-id in SMEM
>>> and speedbin blown in the efuse combination.
>>> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
>>> to provide the OPP framework with required information.
>>> This is used to determine the voltage and frequency value for each OPP of
>>> operating-points-v2 table when it is parsed by the OPP framework.
>>>
>>> This change adds documentation.
>>>
>>> Change-Id: I1953f652a48249fb516d175f0e965a9510cd4209
>>> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
>>> ---
>>>  .../devicetree/bindings/cpufreq/kryo-cpufreq.txt   | 693 +++++++++++++++++++++
>>>  1 file changed, 693 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/kryo-cpufreq.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/cpufreq/kryo-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/kryo-cpufreq.txt
>>
>> This should really go in opp directory.
>>
>>> new file mode 100644
>>> index 0000000..20cef9d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/kryo-cpufreq.txt
>>> @@ -0,0 +1,693 @@
>>> +Qualcomm Technologies, Inc. KRYO CPUFreq and OPP bindings
>>> +===================================
>>> +
>>> +In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
>>> +that have KRYO processors, the CPU ferequencies subset and voltage value
>>> +of each OPP varies based on the silicon variant in use.
>>> +Qualcomm Technologies, Inc. Process Voltage Scaling Tables
>>> +defines the voltage and frequency value based on the msm-id in SMEM
>>> +and speedbin blown in the efuse combination.
>>> +The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
>>> +to provide the OPP framework with required information (existing HW bitmap).
>>> +This is used to determine the voltage and frequency value for each OPP of
>>> +operating-points-v2 table when it is parsed by the OPP framework.
>>> +
>>> +Required properties:
>>> +--------------------
>>> +In 'cpus' nodes:
>>> +- operating-points-v2: Phandle to the operating-points-v2 table to use.
>>> +
>>> +In 'operating-points-v2' table:
>>> +- compatible: Should be
>>> +	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
>>> +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>>> +		efuse registers that has information about the
>>> +		speedbin that is used to select the right frequency/voltage
>>> +		value pair.
>>> +		Please refer the for nvmem-cells
>>> +		bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
>>> +		and also examples below.
>>
>> Sricharan is also working on adding these, just make sure you guys do the same
>> thing..
>>
 Right, i was adding a similar one for krait cores [1]. There is code common in the
 init sequence across both (little). Do you suggest to make them common ?

Regards,
 Sricharan

 [1] https://patchwork.kernel.org/patch/10261873/

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
