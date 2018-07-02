Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579ADC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99A82492C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="yyPEjFDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99A82492C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeGBTLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:11:42 -0400
Received: from vern.gendns.com ([206.190.152.46]:46423 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752526AbeGBTLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u5DP2KsfxhMmB7qV+4BzR906lnRhzyd9mV6fmo44GHE=; b=yyPEjFDoWylkQhD/nv+/dAi4Ai
        KwF+j3M0CsddQhThfb3/pST6VelLbyRcEH/9tP99lF0W4NznrpN78gUryvLVVLX1e1CEE+6qgAai2
        j3bV56HFvdNk1pythA5JndNKBaaFHutQ8cY8cX1nNLaquvO/PoZxAs0gE0jiK5QXvVrMB5LAkNHd2
        lm4zXubQzAoosChcue7EZ9MvpgO7eU1sZo9vDYqbk9LCESwiDP+mw8Cia4/q3ZCD49zq2651rgRiV
        a+xc2amw/rwmPQi8DZT1fBtWEwj19EnGC1EnUcm6PhfJaxrHWiK1brfSZdXtAZauTMQqNK7+gvJZC
        m/VAbVww==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:36022 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fa4Eb-00DqCE-Ts; Mon, 02 Jul 2018 15:11:38 -0400
Subject: Re: [v7, 02/10] counter: Documentation: Add Generic Counter sysfs
 documentation
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
References: <27299151c2c7c57e70c49b4f7b794839d00cd750.1529607879.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <2c7ae044-c09b-3d51-bd16-3ecf35154024@lechnology.com>
Date:   Mon, 2 Jul 2018 14:11:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <27299151c2c7c57e70c49b4f7b794839d00cd750.1529607879.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 04:07 PM, William Breathitt Gray wrote:
> This patch adds standard documentation for the userspace sysfs
> attributes of the Generic Counter interface.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-counter | 230 ++++++++++++++++++++
>   MAINTAINERS                                 |   1 +
>   2 files changed, 231 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> new file mode 100644
> index 000000000000..0bb0dce67bf8
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -0,0 +1,230 @@
> +What:		/sys/bus/counter/devices/counterX/countY/count
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count data of Count Y represented as a string.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/ceiling
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count value ceiling for Count Y. This is the upper limit for the
> +		respective counter.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/floor
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count value floor for Count Y. This is the lower limit for the
> +		respective counter.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/count_mode
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count mode for channel Y. The ceiling and floor values for
> +		Count Y are used by the count mode where required. The following
> +		count modes are available:
> +
> +		Normal:
> +			Counting is continuous in either direction.
> +
> +		Range Limit:
> +			An upper or lower limit is set, mimicking limit switches
> +			in the mechanical counterpart. The upper limit is set to
> +			the Count Y ceiling value, while the lower limit is set
> +			to the Count Y floor value. The counter freezes at
> +			count = ceiling when counting up, and at count = floor
> +			when counting down. At either of these limits, the
> +			counting is resumed only when the count direction is
> +			reversed.
> +
> +		Non-Recycle:
> +			The counter is disabled whenever a counter overflow or
> +			underflow takes place. The counter is re-enabled when a
> +			new count value is loaded to the counter via a preset
> +			operation or direct write.
> +
> +		Modulo-N:
> +			A count value boundary is set between the Count Y floor
> +			value and the Count Y ceiling value. The counter is
> +			reset to the Cunt Y floor value at count = ceiling when
> +			counting up, while the counter is set to the Count Y
> +			ceiling value at count = floor when counting down; the
> +			counter does not freeze at the boundary points, but
> +			counts continuously throughout.
> +

This might be a bit misleading since the values returned are all lower case,
e.g. "rising edge", whereas they are listed here in Title Case.

> +What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
> +What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
> +What:		/sys/bus/counter/devices/counterX/countY/function_available
> +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Count Y
> +		configuration are listed in this file. Values are delineated by
> +		newline characters.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/direction
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the count direction of Count
> +		Y. Two count directions are available: forward and backward.
> +
> +		Some counter devices are able to determine the direction of
> +		their counting. For example, quadrature encoding counters can
> +		determine the direction of movement by evaluating the leading
> +		phase of the respective A and B quadrature encoding signals.
> +		This attribute exposes such count directions.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/enable
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Whether channel Y counter is enabled. Valid attribute values are
> +		boolean.
> +
> +		This attribute is intended to serve as a pause/unpause mechanism
> +		for Count Y. Suppose a counter device is used to count the total
> +		movement of a conveyor belt: this attribute allows an operator
> +		to temporarily pause the counter, service the conveyor belt,
> +		and then finally unpause the counter to continue where it had
> +		left off.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/error_noise
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates whether excessive noise is
> +		present at the channel Y counter inputs.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/function
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count function mode of Count Y; count function evaluation is
> +		triggered by conditions specified by the Count Y signalZ_action
> +		attributes. The following count functions are available:
> +
> +		Increase:
> +			Accumulated count is incremented.
> +
> +		Decrease:
> +			Accumulated count is decremented.
> +
> +		Pulse-Direction:
> +			Rising edges on signal A updates the respective count.
> +			The input level of signal B determines direction.
> +
> +		Quadrature x1 A:
> +			If direction is forward, rising edges on quadrature pair
> +			signal A updates the respective count; if the direction
> +			is backward, falling edges on quadrature pair signal A
> +			updates the respective count. Quadrature encoding
> +			determines the direction.
> +
> +		Quadrature x1 B:
> +			If direction is forward, rising edges on quadrature pair
> +			signal B updates the respective count; if the direction
> +			is backward, falling edges on quadrature pair signal B
> +			updates the respective count. Quadrature encoding
> +			determines the direction.
> +
> +		Quadrature x2 A:
> +			Any state transition on quadrature pair signal A updates
> +			the respective count. Quadrature encoding determines the
> +			direction.
> +
> +		Quadrature x2 B:
> +			Any state transition on quadrature pair signal B updates
> +			the respective count. Quadrature encoding determines the
> +			direction.
> +
> +		Quadrature x4:
> +			Any state transition on either quadrature pair signals
> +			updates	the respective count. Quadrature encoding
> +			determines the direction.
> +
Same here about lower case vs. Title Case.

> +What:		/sys/bus/counter/devices/counterX/countY/name
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Count Y. If possible, this should match the name of the
> +		respective channel as it appears in the device datasheet.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/preset
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If the counter device supports preset registers -- registers
> +		used to load counter channels to a set count upon device-defined
> +		preset operation trigger events -- the preset count for channel
> +		Y is provided by this attribute.

Should this be presetZ in case a device has more than one preset?

> +
> +What:		/sys/bus/counter/devices/counterX/countY/preset_enable
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Whether channel Y counter preset operation is enabled. Valid
> +		attribute values are boolean.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Action mode of Count Y for Signal Z. This attribute indicates
> +		the condition of Signal Z that triggers the count function
> +		evaluation for Count Y. The following action modes are
> +		available:
> +
> +		None:
> +			Signal does not trigger the count function. In
> +			Pulse-Direction count function mode, this Signal is
> +			evaluated as Direction.
> +
> +		Rising Edge:
> +			Low state transitions to high state.
> +
> +		Falling Edge:
> +			High state transitions to low state.
> +
> +		Both Edges:
> +			Any state transition.

And again here (Title Case/lower case)

> +
> +What:		/sys/bus/counter/devices/counterX/name
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		the Counter. This should match the name of the device as it
> +		appears in its respective datasheet.
> +
> +What:		/sys/bus/counter/devices/counterX/num_counts
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the total number of Counts
> +		belonging to the Counter.
> +
> +What:		/sys/bus/counter/devices/counterX/num_signals
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the total number of Signals
> +		belonging to the Counter.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/signal
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Signal data of Signal Y represented as a string.

I guess the actual value returned depends on the type of signal? Would we
need /sys/bus/counter/devices/counterX/signalY/type to indicate this so we
know how to interpret the value?

> +
> +What:		/sys/bus/counter/devices/counterX/signalY/name
> +KernelVersion:	4.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Signal Y. If possible, this should match the name of the
> +		respective signal as it appears in the device datasheet.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6e995c142ed..f8a47fd197a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3692,6 +3692,7 @@ COUNTER SUBSYSTEM
>   M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-counter*
>   F:	drivers/counter/
>   F:	include/linux/counter.h
>   
> 

