Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BAAC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2493921A8F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hdv5Zvxf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cmOMShzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2493921A8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbeHHXjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:39:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbeHHXjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:39:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 07E1060B7B; Wed,  8 Aug 2018 21:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533763100;
        bh=5i0cXE2A0udk25S4uu+6bcey/1t+zUXv2OaemoQJHmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hdv5Zvxfy0d4+7/O/YuVe/EHOOZ0+i7054bxiCKoAo6h1JZOmLkno3zprtyPZ6u3e
         EYInnUNPCJGiEB0cLV4McPi3WKOnRhIGHlMUSKXOlVmL19rNMPFIKN2TakRTTjASq9
         cc/k/7Ug4Xq5+ETA1nSYpiAg64Gz/By3IzApBseM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D265A601B4;
        Wed,  8 Aug 2018 21:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533763098;
        bh=5i0cXE2A0udk25S4uu+6bcey/1t+zUXv2OaemoQJHmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cmOMShzJJklNGutVsXpi6vCiRjtVjaBMNq1q8RdVPxsSdpOlJZdRaoCn/dP8eH9nz
         HG+JxniKsdcYBiox5cY3RixQ9rD43K25PuG47LkCk1J3pSvechMJ+G4lx2oQ0nWM5m
         K28Rfv2M14+W4gMWfe+UU1mtJARhWHHZEPrC7dUw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 08 Aug 2018 14:18:18 -0700
From:   skannan@codeaurora.org
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
In-Reply-To: <20180808084754.GB25416@e107155-lin>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
 <20180807164114.GA12587@rob-hp-laptop>
 <496ac47a3c78f37655b60841fba7494c@codeaurora.org>
 <20180808084754.GB25416@e107155-lin>
Message-ID: <8c7ab63d4c646733b89962a1d2a0a4ae@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-08 01:47, Sudeep Holla wrote:
> On Tue, Aug 07, 2018 at 12:37:07PM -0700, skannan@codeaurora.org wrote:
>> On 2018-08-07 09:41, Rob Herring wrote:
>> >On Wed, Aug 01, 2018 at 05:57:41PM -0700, Saravana Kannan wrote:
>> >>Many CPU architectures have caches that can scale independent of the
>> >>CPUs.
>> >>Frequency scaling of the caches is necessary to make sure the cache is
>> >>not
>> >>a performance bottleneck that leads to poor performance and power. The
>> >>same
>> >>idea applies for RAM/DDR.
>> >>
>> >>To achieve this, this patch adds a generic devfreq governor that takes
>> >>the
>> >>current frequency of each CPU frequency domain and then adjusts the
>> >>frequency of the cache (or any devfreq device) based on the frequency of
>> >>the CPUs. It listens to CPU frequency transition notifiers to keep
>> >>itself
>> >>up to date on the current CPU frequency.
>> >>
>> >>To decide the frequency of the device, the governor does one of the
>> >>following:
>> >>
>> >>* Uses a CPU frequency to device frequency mapping table
>> >>  - Either one mapping table used for all CPU freq policies (typically
>> >>used
>> >>    for system with homogeneous cores/clusters that have the same OPPs).
>> >>  - One mapping table per CPU freq policy (typically used for ASMP
>> >>systems
>> >>    with heterogeneous CPUs with different OPPs)
>> >>
>> >>OR
>> >>
>> >>* Scales the device frequency in proportion to the CPU frequency. So, if
>> >>  the CPUs are running at their max frequency, the device runs at its
>> >>max
>> >>  frequency.  If the CPUs are running at their min frequency, the device
>> >>  runs at its min frequency. And interpolated for frequencies in
>> >>between.
>> >>
>> >>Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> >>---
>> >> .../bindings/devfreq/devfreq-cpufreq-map.txt       |  53 ++
>> >
>> >Bindings should be a separate patch.
>> >
>> >> drivers/devfreq/Kconfig                            |   8 +
>> >> drivers/devfreq/Makefile                           |   1 +
>> >> drivers/devfreq/governor_cpufreq_map.c             | 583
>> >>+++++++++++++++++++++
>> >> 4 files changed, 645 insertions(+)
>> >> create mode 100644
>> >>Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>> >> create mode 100644 drivers/devfreq/governor_cpufreq_map.c
>> >>
>> >>diff --git
>> >>a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>> >>b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>> >>new file mode 100644
>> >>index 0000000..982a30b
>> >>--- /dev/null
>> >>+++ b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>> >>@@ -0,0 +1,53 @@
>> >>+Devfreq CPUfreq governor
>> >>+
>> >>+devfreq-cpufreq-map is a parent device that contains one or more child
>> >>devices.
>> >>+Each child device provides CPU frequency to device frequency mapping
>> >>for a
>> >>+specific device. Examples of devices that could use this are: DDR,
>> >>cache and
>> >>+CCI.
>> >>+
>> >>+Parent device name shall be "devfreq-cpufreq-map".
>> >>+
>> >>+Required child device properties:
>> >>+- cpu-to-dev-map, or cpu-to-dev-map-<X>:
>> >>+			A list of tuples where each tuple consists of a
>> >>+			CPU frequency (KHz) and the corresponding device
>> >>+			frequency. CPU frequencies not listed in the table
>> >>+			will use the device frequency that corresponds to the
>> >>+			next rounded up CPU frequency.
>> >>+			Use "cpu-to-dev-map" if all CPUs in the system should
>> >>+			share same mapping.
>> >>+			Use cpu-to-dev-map-<cpuid> to describe different
>> >>+			mappings for different CPUs. The property should be
>> >>+			listed only for the first CPU if multiple CPUs are
>> >>+			synchronous.
>> >>+- target-dev:		Phandle to device that this mapping applies to.
>> >>+
>> >>+Example:
>> >>+	devfreq-cpufreq-map {
>> >>+		cpubw-cpufreq {
>> >>+			target-dev = <&cpubw>;
>> >>+			cpu-to-dev-map =
>> >>+				<  300000  1144000 >,
>> >>+				<  422400  2288000 >,
>> >>+				<  652800  3051000 >,
>> >>+				<  883200  5996000 >,
>> >>+				< 1190400  8056000 >,
>> >>+				< 1497600 10101000 >,
>> >>+				< 1728000 12145000 >,
>> >>+				< 2649600 16250000 >;
>> >
>> >Now we have frequencies listed in multiple places, the OPP tables and
>> >here? Perhaps it is grouping OPPs that should be done.
>> 
>> This doesn't list all OPPs (it can if necessary). This is listing the
>> minimum frequency needed to give good performance/power for a
>> device/product.
>> 
> 
> Shouldn't the "status" property be used to disable OPPs you don't need
> on a particular platform ?

But that's not the point here? We aren't trying to disable any OPPs 
here? Not sure what you mean.

> Duplicating values is highly prone to errors and should be avoided.
> 
>> AFAIK, OPP grouping isn't something that's supported in OPP framework 
>> or in
>> DT. Is there something specific you had in mind? Also, I'd like for 
>> this to
>> work even with devices that don't have OPPs listed in DT.
>> 
> Also what's the solution you have for platforms with new *QCom FW 
> Cpufreq* ?
> IIUC the frequency is obtained from the firmware. TBH this should 
> ideally
> be handled in firmware if cpufreq is also handled by the firmware. I 
> guess
> this platform doesn't have that ?

All QC platforms would use this.

As a personal (non-Qcom) opinion, I'd rather the kernel control this 
than have some black magic FW manage this. I've a really bitter taste in 
my mouth for FW hiding this because of a broken ACPI implementation in 
one of my x86 motherboards prevented CPUfreq from working (this was well 
before I worked on CPUfreq). Pushing stuff to FW seems to beat the ideal 
behind an opensource OS. In a few cases it's elegant or more robust, so 
maybe in those cases its okay to use a FW. But I'd rather not for 
simpler stuff like this.

-Saravana
