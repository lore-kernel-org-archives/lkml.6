Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qczWHc0rGVsPHAAAmS7hNA
	; Thu, 07 Jun 2018 12:57:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5E061608B8; Thu,  7 Jun 2018 12:57:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C61FE60115;
	Thu,  7 Jun 2018 12:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C61FE60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbeFGM5r (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:57:47 -0400
Received: from foss.arm.com ([217.140.101.70]:51284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932100AbeFGM5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:57:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C272480D;
        Thu,  7 Jun 2018 05:57:44 -0700 (PDT)
Received: from [10.1.210.28] (e107155-lin.cambridge.arm.com [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 036183F59D;
        Thu,  7 Jun 2018 05:57:42 -0700 (PDT)
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, robh@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To: Taniya Das <tdas@codeaurora.org>
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-2-git-send-email-tdas@codeaurora.org>
 <20180604105531.GB13977@e107155-lin>
 <17e458c1-872a-08f0-c67d-15bc8352055b@codeaurora.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <4128f86b-5d03-a0e1-b483-8acc7417b190@arm.com>
Date: Thu, 7 Jun 2018 13:57:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <17e458c1-872a-08f0-c67d-15bc8352055b@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/18 08:20, Taniya Das wrote:
> Hello Sudeep,
> 
> Thanks for the review comments.
> 
> On 6/4/2018 4:25 PM, Sudeep Holla wrote:
>> On Mon, Jun 04, 2018 at 04:16:33PM +0530, Taniya Das wrote:
>>> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
>>> SoCs. This is required for managing the cpu frequency transitions
>>> which are
>>> controlled by firmware.
>>>
>>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>>> ---
>>>   .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173
>>> +++++++++++++++++++++
>>>   1 file changed, 173 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>> b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>> new file mode 100644
>>> index 0000000..e3087ec
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>> @@ -0,0 +1,173 @@
>>> +Qualcomm Technologies, Inc. CPUFREQ Bindings
>>> +
>>> +CPUFREQ FW is a hardware engine used by some Qualcomm Technologies,
>>> Inc. (QTI)
>>> +SoCs to manage frequency in hardware. It is capable of controlling
>>> frequency
>>> +for multiple clusters.
>>> +
>>> +Properties:
>>> +- compatible
>>> +    Usage:        required
>>> +    Value type:    <string>
>>> +    Definition:    must be "qcom,cpufreq-fw".
>>> +
>>> +* Property qcom,freq-domain
>>> +Devices supporting freq-domain must set their "qcom,freq-domain"
>>> property with
>>> +phandle to a freq_domain_table in their DT node.
>>> +
>>> +* Frequency Domain Table Node
>>> +
>>> +This describes the frequency domain belonging to a device.
>>> +This node can have following properties:
>>> +
>>> +- reg
>>> +    Usage:        required
>>> +    Value type:    <prop-encoded-array>
>>> +    Definition:    Addresses and sizes for the memory of the perf
>>> +            , lut and enable bases.
>>> +            perf - indicates the base address for the desired
>>> +            performance state to be set.
>>> +            lut - indicates the look up table base address for the
>>> +            cpufreq    driver to read frequencies.
>>> +            enable - indicates the enable register for firmware.
>>> +- reg-names
>>> +    Usage:        required
>>> +    Value type:    <stringlist>
>>> +    Definition:    Address names. Must be "perf", "lut", "enable".
>>> +            Must be specified in the same order as the reg property.
>>> +
>>
>> [...]
>>
>>> +
>>> +    qcom,cpufreq-fw {
>>> +        compatible = "qcom,cpufreq-fw";
>>> +
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        freq_domain_table0 : freq_table0 {
>>> +            reg = <0x17d43920 0x4>, <0x17d43110 0x500>,
>>> +                 <0x17d41000 0x4>;
>>
>> Are "perf", "lut", "enable" registers part of single IP block / share
>> memory ?
>> I am just trying to understand the reason for separate entries in this
>> fashion
>> as part of DT register property. I am wondering if there will be multiple
>> entries that fall with the page size.
>>
> 
> They are part of the same IP block and these are the only register
> offsets which is required to be accessed by HLOS.
> 

HLOS ?

Anyways, OS might touch one or 2 registers in lots of IP blocks. I am
not sure why those are any different from these. Are you trying to align
with any other bindings or specification. Are you trying to make this
binding generic here ? I understand if it was trying to generalize the
firmware interface, but you state it's a hardware engine. So I fail to
see the need for such specificity here. Why not define the whole IP
block and the driver knows where to access these specific ones as they
are specific to this hardware block.

-- 
Regards,
Sudeep
