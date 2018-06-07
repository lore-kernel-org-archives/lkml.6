Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i80kHtnaGFvcXQAAmS7hNA
	; Thu, 07 Jun 2018 07:20:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0A2EC608BF; Thu,  7 Jun 2018 07:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528356043;
	bh=XrpKnSRgMFcmvj0dG+4r0tA2InDRnAmRx4zEQJOUxDY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=KO+mnmeHU6mkeDxYP5l5T2UewVzKvfZqyIngvYs/oYuy6zWJhxmm8+RjFRyhW04If
	 W0qS8Lrzq8eINQgxkvjnp5h3U4jpZ52nnXn2YFFoG7ggfkzg89cEqu0GVcSX0guUwe
	 PtodOEirMNJ709CTW0I5fgh7yUaD7qEDnuiMx6iI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 70679607DC;
	Thu,  7 Jun 2018 07:20:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FmfZl9/6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FmfZl9/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70679607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeFGHUk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:20:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37432 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbeFGHUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:20:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2B3C607E7; Thu,  7 Jun 2018 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528356038;
        bh=XrpKnSRgMFcmvj0dG+4r0tA2InDRnAmRx4zEQJOUxDY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FmfZl9/6HP8qDGCmtDIwGvgOS6fh0i5g6sysBmWA5OUn0eaIgIHTFkJXTPJjshZlD
         0o7o0+QTQGcGVBWfadkwxOYOR91mwwhKAHNBVxJBxJA3wqYSkczI/uQONfskZsPHP3
         VzKoME6asM/pEybl+e2nIvdbH4S7R/ztv3s9BBOY=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FEAB607DC;
        Thu,  7 Jun 2018 07:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528356038;
        bh=XrpKnSRgMFcmvj0dG+4r0tA2InDRnAmRx4zEQJOUxDY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FmfZl9/6HP8qDGCmtDIwGvgOS6fh0i5g6sysBmWA5OUn0eaIgIHTFkJXTPJjshZlD
         0o7o0+QTQGcGVBWfadkwxOYOR91mwwhKAHNBVxJBxJA3wqYSkczI/uQONfskZsPHP3
         VzKoME6asM/pEybl+e2nIvdbH4S7R/ztv3s9BBOY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FEAB607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW
 bindings
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, robh@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-2-git-send-email-tdas@codeaurora.org>
 <20180604105531.GB13977@e107155-lin>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <17e458c1-872a-08f0-c67d-15bc8352055b@codeaurora.org>
Date: Thu, 7 Jun 2018 12:50:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604105531.GB13977@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudeep,

Thanks for the review comments.

On 6/4/2018 4:25 PM, Sudeep Holla wrote:
> On Mon, Jun 04, 2018 at 04:16:33PM +0530, Taniya Das wrote:
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
>> +- reg-names
>> +	Usage:		required
>> +	Value type:	<stringlist>
>> +	Definition:	Address names. Must be "perf", "lut", "enable".
>> +			Must be specified in the same order as the reg property.
>> +
> 
> [...]
> 
>> +
>> +	qcom,cpufreq-fw {
>> +		compatible = "qcom,cpufreq-fw";
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		freq_domain_table0 : freq_table0 {
>> +			reg = <0x17d43920 0x4>, <0x17d43110 0x500>,
>> +				 <0x17d41000 0x4>;
> 
> Are "perf", "lut", "enable" registers part of single IP block / share memory ?
> I am just trying to understand the reason for separate entries in this fashion
> as part of DT register property. I am wondering if there will be multiple
> entries that fall with the page size.
> 

They are part of the same IP block and these are the only register 
offsets which is required to be accessed by HLOS.

> --
> Regards,
> Sudeep
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
