Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeCXRe0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752626AbeCXReW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:34:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0A52178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 17:05:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/8] counter: Documentation: Add Generic Counter
 sysfs documentation
Message-ID: <20180324170517.33b7515c@archlinux>
In-Reply-To: <06d985b7f63471c5c5b74c11eb6c76b5ff32fdd5.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <06d985b7f63471c5c5b74c11eb6c76b5ff32fdd5.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 13:42:35 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds standard documentation for the userspace sysfs
> attributes of the Generic Counter interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Good, few comments inline.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 120 ++++++++++++++++++++++++++++
>  MAINTAINERS                                 |   1 +
>  2 files changed, 121 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> new file mode 100644
> index 000000000000..64785aab1763
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -0,0 +1,120 @@
> +What:		/sys/bus/counter/devices/counterX/countY/count
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count data of Count Y. The following data types are available:
> +
> +		COUNT_POSITION_UNSIGNED:
> +			Unsigned integer value representing position.
> +
> +		COUNT_POSITION_SIGNED:
> +			Signed integer value representing position.
Why are these data types relevant in this document?
You are outputting a string. Userspace doesn't really need to know
more than that.

> +
> +What:		/sys/bus/counter/devices/counterX/countY/function
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Count function mode of Count Y; count function evaluation is
> +		triggered by conditions specified by the countY_signalZ_action
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
> +		Quadrature x1:
> +			If direction is forward, rising edges on quadrature pair
> +			signal A updates the respective count; if the direction
> +			is backward, falling edges on quadrature pair signal A
> +			updates the respective count. Quadrature encoding
> +			determines the direction.
> +
> +		Quadrature x2:
> +			Any state transition on quadrature pair signal A updates
> +			the respective count. Quadrature encoding determines the
> +			direction.
> +
> +		Quadrature x4:
> +			Any state transition on either quadrature pair signals
> +			updates	the respective count. Quadrature encoding
> +			determines the direction.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/function_available
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available count function modes for the
> +		configuration of the respective Count Y are listed in this file.
How is this list delineated?  There are several competing options in different
kernel subsystems so this isn't exactly obvious ;)

> +
> +What:		/sys/bus/counter/devices/counterX/countY/name
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Count Y. If possible, this should match the name of the
> +		respective channel as it appears in the device datasheet
> +		documentation text.
> +
> +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action
> +KernelVersion:	4.17
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
> +What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Discrete set of available action modes are listed in this file
> +		for the configuration of the respective Synapse associating
> +		Signal Z to Count Y.
> +
> +What:		/sys/bus/counter/devices/counterX/name
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		the Counter. This should match the name of the device as it
> +		appears in its respective datasheet documentation text.
> +
> +What:		/sys/bus/counter/devices/counterX/signalY/signal
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Signal data of Signal Y. The following data types are available:
> +
> +		SIGNAL_LEVEL:
> +			Respective input has two discrete states: Low and High.
Formatting is rather inconsistent.  For the type we had Capital then lowercase
here all caps?  Or is this an integer from an enum?  Definitely prefer
a human readable version if possible  This is also rather pointless until
we have more than one option ;)

> +
> +What:		/sys/bus/counter/devices/counterX/signalY/name
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the device-specific name of
> +		Signal Y. If possible, this should match the name of the
> +		respective signal as it appears in the device datasheet
> +		documentation text.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2be01a95b7a5..2a7bf2f84272 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3672,6 +3672,7 @@ COUNTER SUBSYSTEM
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-bus-counter*
>  F:	drivers/counter/
>  F:	include/linux/counter.h
>  
