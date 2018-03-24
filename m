Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeCXR2F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 13:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752705AbeCXR2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 13:28:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD662177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 24 Mar 2018 17:27:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/8] counter: stm32-timer-cnt: Add sysfs
 documentation
Message-ID: <20180324172757.5350649c@archlinux>
In-Reply-To: <d85788df126b716b05fe1d56fca292933fee1db2.1520614431.git.vilhelm.gray@gmail.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <d85788df126b716b05fe1d56fca292933fee1db2.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 13:43:44 -0500
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> From: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> In addition of the generic sysfs-bus-counter ABI stm32-timer-cnt
> offerts three functionality:
> - enable the counter
> - set preset value
> - allow to read counter direction
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
My main thought here is that there is nothing which doesn't belong
in sysfs-bus-counter to my mind anyway.

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-counter-stm32-timer-cnt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt b/Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt
> new file mode 100644
> index 000000000000..73328e8e6d7e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt
> @@ -0,0 +1,21 @@
> +What:		/sys/bus/counter/devices/counterX/countY_direction
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only attribute that indicates the count direction of
> +		Count Y. Two count directions are available: Forward and
> +		Backward.
Given both existing devices have this, I'm guessing it is generic enough
to graduate to the generic sysfs documentation file.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_enable
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Whether channel Y inputs A and B are enabled. Valid attribute
> +		values are boolean.
Given for the previous device we had individual inputs (which to my mind
made no sense to disable separately) perhaps we should have this as the
generic option.  If a driver needs to separately disable the two signals
then that is up to it to sort out.

At least this way we reduce the guessing any userspace code will need
to do in order to turns things on.
> +
> +What:		/sys/bus/counter/devices/counterX/countY_preset
> +KernelVersion:	4.17
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If the counter device supports preset registers, the preset
> +		count for channel Y is provided by this attribute.
Again, looks pretty generic...
