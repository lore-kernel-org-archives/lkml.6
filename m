Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2C8F5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F85208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="or11UwaY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="or11UwaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F85208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935119AbeFMSNw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:13:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934975AbeFMSNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:13:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BDDF6606DB; Wed, 13 Jun 2018 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528913629;
        bh=BLgOhgrSwgpHxk9jwvX4EfyIvWIX5xA1XzV8AVHc0cs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=or11UwaYrfPpKC5mC1i8eOFHeyr9o4wk2ucNuV2wYoTM2T+hUl2iYGkoKebvkfx9/
         IK9/OAkmHumOx55jS+faozpjF7EidDDtHdlzC6N29/akxFC+X1/bHBXxVwJFG5AL5F
         ht+D3ZUOtHbwh5+Ip+pKxdKPA5gTmeZqNGNXkzW4=
Received: from [10.79.169.25] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 210B3606DB;
        Wed, 13 Jun 2018 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528913629;
        bh=BLgOhgrSwgpHxk9jwvX4EfyIvWIX5xA1XzV8AVHc0cs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=or11UwaYrfPpKC5mC1i8eOFHeyr9o4wk2ucNuV2wYoTM2T+hUl2iYGkoKebvkfx9/
         IK9/OAkmHumOx55jS+faozpjF7EidDDtHdlzC6N29/akxFC+X1/bHBXxVwJFG5AL5F
         ht+D3ZUOtHbwh5+Ip+pKxdKPA5gTmeZqNGNXkzW4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 210B3606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-2-git-send-email-tdas@codeaurora.org>
 <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <7abb2da6-c130-117a-5404-d07bb132d915@codeaurora.org>
Date:   Wed, 13 Jun 2018 23:43:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0f3f0223-3539-dc66-5300-8f30d827445d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep,

Thanks for review comments.

On 6/13/2018 4:56 PM, Sudeep Holla wrote:
> 
> 
> On 12/06/18 12:02, Taniya Das wrote:
>> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
>> SoCs. This is required for managing the cpu frequency transitions which are
>> controlled by firmware.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   .../bindings/cpufreq/cpufreq-qcom-fw.txt           | 173 +++++++++++++++++++++
>>   1 file changed, 173 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>> new file mode 100644
>> index 0000000..e3087ec
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-fw.txt
>> @@ -0,0 +1,173 @@
>> +Qualcomm Technologies, Inc. CPUFREQ Bindings
>> +
>> +CPUFREQ FW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
>> +SoCs to manage frequency in hardware. It is capable of controlling frequency
>> +for multiple clusters.
>> +
> 
> You are bit inconsistent on the wordings. Some places you refer this as
> hardware engine. If so, please drop all references to firmware/FW. If
> it's firmware then update accordingly.
> 

It is a hardware engine which has a firmware to take care of the
managing the frequency request from OS. That is reason to refer it as a 
firmware.

>> +Properties:
>> +- compatible
>> +	Usage:		required
>> +	Value type:	<string>
>> +	Definition:	must be "qcom,cpufreq-fw".
>> +
>> +* Property qcom,freq-domain
>> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
>> +phandle to a freq_domain_table in their DT node.
>> +
>> +* Frequency Domain Table Node
>> +
>> +This describes the frequency domain belonging to a device.
>> +This node can have following properties:
>> +
>> +- reg
>> +	Usage:		required
>> +	Value type:	<prop-encoded-array>
>> +	Definition:	Addresses and sizes for the memory of the perf
>> +			, lut and enable bases.
>> +			perf - indicates the base address for the desired
>> +			performance state to be set.
>> +			lut - indicates the look up table base address for the
>> +			cpufreq	driver to read frequencies.
>> +			enable - indicates the enable register for firmware.
> 
> 
> You still didn't answer my earlier question.
> 
> OS might touch one or 2 registers in lots of IP blocks. I am not sure
> why those are any different from these. Are you trying to align with any
> other bindings or specification. Are you trying to make this binding
> generic here ? I understand if it was trying to generalize the firmware
> interface, but you also state it's a hardware engine. So I fail to see
> the need for such specificity here. Why not define the whole IP block
> and the driver knows where to access these specific ones as they are
> specific to this hardware block. In that way if you decide to add more
> data, it's extensible easily without the need for patching DT.
> 

Sorry Sudeep I missed replying to your earlier query.
The High level OS(HLOS) would require to access only these specific 
registers from this IP block and just mapping the whole block(huge 
region) is unnecessary from the OS point of View. As of now it is a 
generic binding for all using this IP block to manage frequency 
requests. The OS would only have to know the frequencies supported i.e 
to read the lookup table registers and put across the OS request using 
the performance state register.

> Eg. Suppose you need some information on power curve for EAS energy
> model, I really hate to update DT for that or even do a mix with DT just
> because f/w is no longer modifiable.
> 

For now we are safe.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
