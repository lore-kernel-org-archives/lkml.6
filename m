Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18908C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC12421885
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC12421885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390217AbeHGS4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:56:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43100 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389051AbeHGS4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:56:24 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so14506383ioa.10;
        Tue, 07 Aug 2018 09:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KNzPsAi2jmOtcso0jfPqvGN6HjmyQq99Fe6hmxxdtQc=;
        b=sZOhkBTXuRbO7fhxHuANP11HAgi1hdAE34V9GFzTjJpT1rmBpfAMlP9D4rv7ZjZgjt
         12+03CaThT5/ffoH8Zfg+l8q3xXoTov186QBm7NtXfwaJ3K2mst5YGHzJpuZJeFqpNkj
         B4i9ZnGY05Z7eCMP1FpiwR1IYKJxIWPKgGBQ5qAAGc2/IPZpYjVLaN4x7OsE/MbEdhU5
         qzWDd/CN3nF+7XeIzJ6itQLQuKGIeURE6OhhWfnD0P2W8wUxnD66a1ITAznZp1miORju
         kcIXR82ikSFLkbGPpa280S5CG8ntQGMgHYt5tmmUIqVkTSkgm18VWShLUEfhhRdOpvBY
         WoGw==
X-Gm-Message-State: AOUpUlHHffwmEDZeqd5molexEiBfU7LdvU184qeHnGdFZaXnRxAmc/nb
        vySQvzhjoT4mm0JH9oozgBop4jY=
X-Google-Smtp-Source: AA+uWPzQOEVMkj3U7p+GkuZqj1NZwypMxj8aqPFnYI/hCSl6/iaqc2DymAV8cbj8StMpwGmg8fXN7w==
X-Received: by 2002:a6b:8fc4:: with SMTP id r187-v6mr5849308iod.59.1533660075639;
        Tue, 07 Aug 2018 09:41:15 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 137-v6sm1113750itl.39.2018.08.07.09.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 09:41:15 -0700 (PDT)
Date:   Tue, 7 Aug 2018 10:41:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PM / devfreq: Generic CPU frequency to device
 frequency mapping governor
Message-ID: <20180807164114.GA12587@rob-hp-laptop>
References: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533171465-25508-1-git-send-email-skannan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:57:41PM -0700, Saravana Kannan wrote:
> Many CPU architectures have caches that can scale independent of the CPUs.
> Frequency scaling of the caches is necessary to make sure the cache is not
> a performance bottleneck that leads to poor performance and power. The same
> idea applies for RAM/DDR.
> 
> To achieve this, this patch adds a generic devfreq governor that takes the
> current frequency of each CPU frequency domain and then adjusts the
> frequency of the cache (or any devfreq device) based on the frequency of
> the CPUs. It listens to CPU frequency transition notifiers to keep itself
> up to date on the current CPU frequency.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> 
> * Uses a CPU frequency to device frequency mapping table
>   - Either one mapping table used for all CPU freq policies (typically used
>     for system with homogeneous cores/clusters that have the same OPPs).
>   - One mapping table per CPU freq policy (typically used for ASMP systems
>     with heterogeneous CPUs with different OPPs)
> 
> OR
> 
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its max
>   frequency.  If the CPUs are running at their min frequency, the device
>   runs at its min frequency. And interpolated for frequencies in between.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  .../bindings/devfreq/devfreq-cpufreq-map.txt       |  53 ++

Bindings should be a separate patch.

>  drivers/devfreq/Kconfig                            |   8 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/governor_cpufreq_map.c             | 583 +++++++++++++++++++++
>  4 files changed, 645 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
>  create mode 100644 drivers/devfreq/governor_cpufreq_map.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> new file mode 100644
> index 0000000..982a30b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq-map.txt
> @@ -0,0 +1,53 @@
> +Devfreq CPUfreq governor
> +
> +devfreq-cpufreq-map is a parent device that contains one or more child devices.
> +Each child device provides CPU frequency to device frequency mapping for a
> +specific device. Examples of devices that could use this are: DDR, cache and
> +CCI.
> +
> +Parent device name shall be "devfreq-cpufreq-map".
> +
> +Required child device properties:
> +- cpu-to-dev-map, or cpu-to-dev-map-<X>:
> +			A list of tuples where each tuple consists of a
> +			CPU frequency (KHz) and the corresponding device
> +			frequency. CPU frequencies not listed in the table
> +			will use the device frequency that corresponds to the
> +			next rounded up CPU frequency.
> +			Use "cpu-to-dev-map" if all CPUs in the system should
> +			share same mapping.
> +			Use cpu-to-dev-map-<cpuid> to describe different
> +			mappings for different CPUs. The property should be
> +			listed only for the first CPU if multiple CPUs are
> +			synchronous.
> +- target-dev:		Phandle to device that this mapping applies to.
> +
> +Example:
> +	devfreq-cpufreq-map {
> +		cpubw-cpufreq {
> +			target-dev = <&cpubw>;
> +			cpu-to-dev-map =
> +				<  300000  1144000 >,
> +				<  422400  2288000 >,
> +				<  652800  3051000 >,
> +				<  883200  5996000 >,
> +				< 1190400  8056000 >,
> +				< 1497600 10101000 >,
> +				< 1728000 12145000 >,
> +				< 2649600 16250000 >;

Now we have frequencies listed in multiple places, the OPP tables and 
here? Perhaps it is grouping OPPs that should be done.

This all looks bolted on and very much Linux specifc.

Rob
