Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BECC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B672172A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KgKk+UiJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WVADr44B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B672172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbeHGVxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:53:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGVxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:53:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6936760C54; Tue,  7 Aug 2018 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533670628;
        bh=x32cLoUzAhHh4YJWWCdV+79WK7g5P0XiA3T2VC1UBXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KgKk+UiJiBEVC1V/CCZULMgWyoQDP7mfYPWX1QdvJVvZfHX4bvvyhQWP8EAFYi+R6
         Nd5FzSCXY8fAWfl7BoRs2oX1F/+UOq3FAnwMd0yTjK0p0w/d4K72rV/TpTYe8EEdaG
         topNS0/KGLDhICgLp/bK5qHTMzonlENZqsyy9xOU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4634060B1A;
        Tue,  7 Aug 2018 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533670627;
        bh=x32cLoUzAhHh4YJWWCdV+79WK7g5P0XiA3T2VC1UBXY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WVADr44Bv1qU3IFxSkkNp2il56ICcNThG9eg1nLUJ4tDq4iulEJjZo4hJBzyfWEoU
         0HF2ARXlPWGHwyVC/kF8F0Jbs99tnai7PtBZ6C/QDvZKsz88FwrAqvH8/m60NLVvLD
         y40XlfVtcrCLstgSvH9la7EGZv1bQ8VBdohWoGXY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Aug 2018 12:37:07 -0700
From:   skannan@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
In-Reply-To: <20180807164114.GA12587@rob-hp-laptop>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
 <20180807164114.GA12587@rob-hp-laptop>
Message-ID: <496ac47a3c78f37655b60841fba7494c@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-07 09:41, Rob Herring wrote:
> On Wed, Aug 01, 2018 at 05:57:41PM -0700, Saravana Kannan wrote:
>> Many CPU architectures have caches that can scale independent of the 
>> CPUs.
>> Frequency scaling of the caches is necessary to make sure the cache is 
>> not
>> a performance bottleneck that leads to poor performance and power. The 
>> same
>> idea applies for RAM/DDR.
>> 
>> To achieve this, this patch adds a generic devfreq governor that takes 
>> the
>> current frequency of each CPU frequency domain and then adjusts the
>> frequency of the cache (or any devfreq device) based on the frequency 
>> of
>> the CPUs. It listens to CPU frequency transition notifiers to keep 
>> itself
>> up to date on the current CPU frequency.
>> 
>> To decide the frequency of the device, the governor does one of the
>> following:
>> 
>> * Uses a CPU frequency to device frequency mapping table
>>   - Either one mapping table used for all CPU freq policies (typically 
>> used
>>     for system with homogeneous cores/clusters that have the same 
>> OPPs).
>>   - One mapping table per CPU freq policy (typically used for ASMP 
>> systems
>>     with heterogeneous CPUs with different OPPs)
>> 
>> OR
>> 
>> * Scales the device frequency in proportion to the CPU frequency. So, 
>> if
>>   the CPUs are running at their max frequency, the device runs at its 
>> max
>>   frequency.  If the CPUs are running at their min frequency, the 
>> device
>>   runs at its min frequency. And interpolated for frequencies in 
>> between.
>> 
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>  .../bindings/devfreq/devfreq-cpufreq-map.txt       |  53 ++
> 
> Bindings should be a separate patch.
> 
>>  drivers/devfreq/Kconfig                            |   8 +
>>  drivers/devfreq/Makefile                           |   1 +
>>  drivers/devfreq/governor_cpufreq_map.c             | 583 
>> +++++++++++++++++++++
>>  4 files changed, 645 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>>  create mode 100644 drivers/devfreq/governor_cpufreq_map.c
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt 
>> b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>> new file mode 100644
>> index 0000000..982a30b
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>> @@ -0,0 +1,53 @@
>> +Devfreq CPUfreq governor
>> +
>> +devfreq-cpufreq-map is a parent device that contains one or more 
>> child devices.
>> +Each child device provides CPU frequency to device frequency mapping 
>> for a
>> +specific device. Examples of devices that could use this are: DDR, 
>> cache and
>> +CCI.
>> +
>> +Parent device name shall be "devfreq-cpufreq-map".
>> +
>> +Required child device properties:
>> +- cpu-to-dev-map, or cpu-to-dev-map-<X>:
>> +			A list of tuples where each tuple consists of a
>> +			CPU frequency (KHz) and the corresponding device
>> +			frequency. CPU frequencies not listed in the table
>> +			will use the device frequency that corresponds to the
>> +			next rounded up CPU frequency.
>> +			Use "cpu-to-dev-map" if all CPUs in the system should
>> +			share same mapping.
>> +			Use cpu-to-dev-map-<cpuid> to describe different
>> +			mappings for different CPUs. The property should be
>> +			listed only for the first CPU if multiple CPUs are
>> +			synchronous.
>> +- target-dev:		Phandle to device that this mapping applies to.
>> +
>> +Example:
>> +	devfreq-cpufreq-map {
>> +		cpubw-cpufreq {
>> +			target-dev = <&cpubw>;
>> +			cpu-to-dev-map =
>> +				<  300000  1144000 >,
>> +				<  422400  2288000 >,
>> +				<  652800  3051000 >,
>> +				<  883200  5996000 >,
>> +				< 1190400  8056000 >,
>> +				< 1497600 10101000 >,
>> +				< 1728000 12145000 >,
>> +				< 2649600 16250000 >;
> 
> Now we have frequencies listed in multiple places, the OPP tables and
> here? Perhaps it is grouping OPPs that should be done.

This doesn't list all OPPs (it can if necessary). This is listing the 
minimum frequency needed to give good performance/power for a 
device/product.

AFAIK, OPP grouping isn't something that's supported in OPP framework or 
in DT. Is there something specific you had in mind? Also, I'd like for 
this to work even with devices that don't have OPPs listed in DT.

Thanks,
Saravana
