Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeETPoG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 11:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752529AbeETPn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 11:43:56 -0400
Date: Sun, 20 May 2018 16:12:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/9] counter: Documentation: Add Generic Counter
 sysfs documentation
Message-ID: <20180520161234.3707d397@archlinux>
In-Reply-To: <1bf56af37a1d6dab8181ce71f827914acdf5c4f7.1526487615.git.vilhelm.gray@gmail.com>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
        <1bf56af37a1d6dab8181ce71f827914acdf5c4f7.1526487615.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 13:50:55 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds standard documentation for the userspace sysfs
> attributes of the Generic Counter interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Some really minor stuff inline.  No functional changes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 241 ++++++++++++++++++++
>  MAINTAINERS                                 |   1 +
>  2 files changed, 242 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> new file mode 100644
> index 000000000000..e4a45d231b4f
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -0,0 +1,241 @@
> +What:		/sys/bus/counter/devices/counterX/countY/count
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count data of Count Y represented as a string.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/ceiling
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count value ceiling for Count Y. This is the upper limit for the
> +		respective counter.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/floor
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count value floor for Count Y. This is the lower limit for the
> +		respective counter.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/count_mode
> +KernelVersion:	4.18
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
> +What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
> +What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
> +What:		/sys/bus/counter/devices/counterX/countY/function_available
> +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available values for the respective Count Y
> +		configuration are listed in this file. Values are delineated by
> +		newline characters.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/direction
> +KernelVersion:	4.18
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
> +KernelVersion:	4.18
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
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates whether excessive noise is
> +		present at the channel Y counter inputs.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/function
> +KernelVersion:	4.18
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
> +			Rising edges on quadrature pair signal A updates the
> +			respective count. The input level of quadrature pair
> +			signal B determines direction.
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
> +		Quadrature x2 Rising:
> +			Rising edges on either quadrature pair signals updates
> +			the respective count. Quadrature encoding determines the
> +			direction.
> +
> +		Quadrature x2 Falling:
> +			Falling edges on either quadrature pair signals updates
> +			the respective count. Quadrature encoding determines the
> +			direction.
> +
> +		Quadrature x4:
> +			Any state transition on either quadrature pair signals
> +			updates	the respective count. Quadrature encoding
> +			determines the direction.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/name
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Count Y. If possible, this should match the name of the
> +		respective channel as it appears in the device datasheet
> +		documentation text.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/preset
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If the counter device supports preset registers, the preset
> +		count for channel Y is provided by this attribute.

I would add a small block of text here saying what a "preset" typically is.
It is a term heavily used in encoders etc, but perhaps not some other types
of counter.

> +
> +What:		/sys/bus/counter/devices/counterX/countY/preset_enable
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Whether channel Y counter preset operation is enabled. Valid
> +		attribute values are boolean.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action
> +KernelVersion:	4.18
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
> +
> +What:		/sys/bus/counter/devices/counterX/name
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		the Counter. This should match the name of the device as it
> +		appears in its respective datasheet documentation text.

As below, I'm not sure if "documentation text" makes it clearer or less clear..

> +
> +What:		/sys/bus/counter/devices/counterX/num_counts
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the total number of Counts
> +		belonging to the Counter.
> +
> +What:		/sys/bus/counter/devices/counterX/num_signals
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the total number of Signals
> +		belonging to the Counter.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/signal
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Signal data of Signal Y represented as a string.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/name
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Signal Y. If possible, this should match the name of the
> +		respective signal as it appears in the device datasheet
> +		documentation text.

Not sure "documentation text" adds any clarity over the simply "device datasheet"

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a016d73ab72..1413e3eb49e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3673,6 +3673,7 @@ COUNTER SUBSYSTEM
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-counter*
>  F:	drivers/counter/
>  F:	include/linux/counter.h
>  
