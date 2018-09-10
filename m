Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC013C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DABE2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cuf85D8B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BKx5QfeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DABE2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeIJXvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:51:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:51:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1A7EE607F4; Mon, 10 Sep 2018 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536605733;
        bh=iLFiD2rB6F1cyAn9MumVrjZ5wy2opDM2NFBEpdrMnCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cuf85D8Bryk8j6GjJwYkGVXz4ir8S/dpUiEE7sQJmM3VHSDyiKVQGHb1bTvJA5mzH
         FsXSJlhKJHt3HDFsmCitcM0q72c+F2M1qT+fBhY/p4j9lizIL3MBMuf0Q5TL92nEkG
         bZsFwx+OWDdgyxTbWZBG6MnseQiCbbpvRgzfZKpw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A001D60452;
        Mon, 10 Sep 2018 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536605732;
        bh=iLFiD2rB6F1cyAn9MumVrjZ5wy2opDM2NFBEpdrMnCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BKx5QfeDZOt4TcvXjlwsrp+ePVCrAyQiG6N4b8Owx6R1YiMTgVEdDXBLaW6Ax/cte
         lAHfUMzd2SuLvCayrFKk3MfWW2RnTFCiGp36jFIgYa3ykI1l595xyoIu69QWfWTlVQ
         OqWjrtrhJxxh2tnRjgMb/ApG9onGknNhu/8L7Y5I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Sep 2018 00:25:32 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Saravana Kannan <skannan@codeaurora.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
In-Reply-To: <4fcac639-cba9-1a71-9b78-326ebb9242da@linaro.org>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
 <4fcac639-cba9-1a71-9b78-326ebb9242da@linaro.org>
Message-ID: <904fb7d5f96a0c02bd57f21c50549192@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

This driver uses of_icc_get which is very likely to fail if it probes
before the interconnect provider. Would it be possible for icc_get to
return/differentiate both -EPROBE_DEFER and other errors to prevent the
driver to continually probe defer if the path doesn't actually exist
or just error out if it probes before the interconnect provider.

On 2018-08-23 18:30, Georgi Djakov wrote:
> Hi Saravana,
> 
> On 08/02/2018 03:57 AM, Saravana Kannan wrote:
>> This driver registers itself as a devfreq device that allows devfreq
>> governors to make bandwidth votes for an interconnect path. This 
>> allows
>> applying various policies for different interconnect paths using 
>> devfreq
>> governors.
>> 
>> Example uses:
>> * Use the devfreq performance governor to set the CPU to DDR 
>> interconnect
>>   path for maximum performance.
>> * Use the devfreq performance governor to set the GPU to DDR 
>> interconnect
>>   path for maximum performance.
>> * Use the CPU frequency to device frequency mapping governor to scale 
>> the
>>   DDR frequency based on the needs of the CPUs' current frequency.
> 
> Usually CPUs and GPUs have dedicated cpufreq/devfreq drivers and i was
> wondering if the interconnect support could be put into these drivers
> directly?
> 
>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/devfreq/icbw.txt |  21 ++++
>>  drivers/devfreq/Kconfig                            |  13 +++
>>  drivers/devfreq/Makefile                           |   1 +
>>  drivers/devfreq/devfreq_icbw.c                     | 116 
>> +++++++++++++++++++++
>>  4 files changed, 151 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>>  create mode 100644 drivers/devfreq/devfreq_icbw.c
>> 
>> diff --git a/Documentation/devicetree/bindings/devfreq/icbw.txt 
>> b/Documentation/devicetree/bindings/devfreq/icbw.txt
>> new file mode 100644
>> index 0000000..36cf045
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/icbw.txt
>> @@ -0,0 +1,21 @@
>> +Interconnect bandwidth device
>> +
>> +icbw is a device that represents an interconnect path that connects 
>> two
>> +devices. This device is typically used to vote for BW requirements 
>> between
>> +two devices. Eg: CPU to DDR, GPU to DDR, etc
>> +
>> +Required properties:
>> +- compatible:		Must be "devfreq-icbw"
>> +- interconnects:	Pairs of phandles and interconnect provider 
>> specifier
>> +			to denote the edge source and destination ports of
>> +			the interconnect path. See also:
>> +		Documentation/devicetree/bindings/interconnect/interconnect.txt
>> +- interconnect-names:	Must have one entry with the name "path".
>> +
>> +Example:
>> +
>> +	qcom,cpubw {
>> +		compatible = "devfreq-icbw";
>> +		interconnects = <&snoc MASTER_APSS_1 &bimc SLAVE_EBI_CH0>;
>> +		interconnect-names = "path";
> 
> interconnect-names is optional when there is only a single path.
> 
>> +	};
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 3d9ae68..590370e 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -121,6 +121,19 @@ config ARM_RK3399_DMC_DEVFREQ
>>            It sets the frequency for the memory controller and reads 
>> the usage counts
>>            from hardware.
>> 
>> +config DEVFREQ_ICBW
>> +	bool "DEVFREQ device for making bandwidth votes on interconnect 
>> paths"
> 
> Can this be a module?
> 
>> +	select DEVFREQ_GOV_PERFORMANCE
>> +	select DEVFREQ_GOV_POWERSAVE
>> +	select DEVFREQ_GOV_USERSPACE
>> +	default n
> 
> There's no need to specify this default. It is 'n' by default anyway.
> Also maybe you want to add something like:
> 	depends on INTERCONNECT=y
> 
> Thanks,
> Georgi
> 
>> +	help
>> +	  Different devfreq governors use this devfreq device to make
>> +	  bandwidth votes for interconnect paths between different devices
>> +	  (Eg: CPU to DDR, GPU to DDR, etc). This driver provides a generic
>> +	  interface so that the devfreq governors can be shared across SoCs
>> +	  and architectures.
>> +
>>  source "drivers/devfreq/event/Kconfig"

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
