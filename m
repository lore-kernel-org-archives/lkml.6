Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeFEByu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:54:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbeFEByt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:54:49 -0400
Date: Mon, 4 Jun 2018 18:54:44 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v4 8/8] Documentation/ABI: Add documentation mlxreg-io
 sysfs interfaces
Message-ID: <20180605015444.GB47042@localhost.localdomain>
References: <1527584347-167548-1-git-send-email-vadimp@mellanox.com>
 <1527584347-167548-3-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527584347-167548-3-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 08:59:07AM +0000, Vadim Pasternak wrote:
> Add documentation for mlxreg-io driver sysfs interfaces for user space
> access to system's power resets control, reset causes monitoring,
> programmable devices version reading and devices selection control.
> 
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>

Hi Vadim,

You mentioned that these can vary by platform, I presume that means that
any given platform will present a subset of these attributes - but that
all possible attributes are documented here. Is that correct?

> ---
> v4:
>  Comments pointed out by Greg:
>  Add Documentation/ABI/ entries for the new sysfs files.
> ---
>  Documentation/ABI/stable/sysfs-driver-mlxreg-io | 51 +++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-driver-mlxreg-io
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> new file mode 100644
> index 0000000..fcd659e
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> @@ -0,0 +1,51 @@
> +What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> +							cause_aux_pwr_or_ref
> +							cause_asic_thermal
> +							cause_hotswap_or_wd
> +							cause_fw_reset
> +							cause_long_pb
> +							cause_main_pwr_fail
> +							cause_short_pb
> +							cause_sw_reset

These property names do not seem to follow any kind of logical pattern
with respect to abbreviation. Starting with "cause_" made me think they
were event generators at first... Of course, who wants to be able to
generate an asic thermal shutdown from sysfs... ;-)

The only thing that might make more sense to *me* would be to replace
"cause" with "reset". Not required. I'll leave it to you, you may have
good reason for the names chosen.

> +Date:		May 2018
> +KernelVersion:	4.18
> +Contact:	Vadim Pasternak <vadimpmellanox.com>
> +Description:	These files show the system reset cause, as following: power
> +		auxiliary outage or power refresh, ASIC thermal shutdown,
> +		hotswap or watchdog, firmware reset, long press power button,
> +		short press power button, software reset. Value 1 in file means
> +		this is reset cause, 0 - otherwise. Only one of the above
> +		causes could be 1 at the same time, representing only last
> +		reset cause.
> +
> +		The files are read only.
> +
> +What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> +							cpld1_version
> +							cpld2_version
> +Date:		May 2018
> +KernelVersion:	4.18
> +Contact:	Vadim Pasternak <vadimpmellanox.com>
> +Description:	These files show with which CPLD versions have been burned
> +		on carrier and switch boards.
> +
> +		The files are read only.
> +
> +What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/select_iio
> +Date:		May 2018
> +KernelVersion:	4.18
> +Contact:	Vadim Pasternak <vadimpmellanox.com>
> +Description:	This file allows iio devices selection.
> +
> +		The file is read/write.
> +

Some description is appropriate here for what values it accepts and how
it is intended to be used.

> +What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/psu1_on
> +		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/psu2_on
> +		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/pwr_cycle
> +Date:		May 2018
> +KernelVersion:	4.18
> +Contact:	Vadim Pasternak <vadimpmellanox.com>
> +Description:	These files allow assert system's power cycling and PS units
> +		on/off switching.

This Description is awkward. Consider:

These files allow asserting system power cycling and switching power
supply units on and off.

> +		The files are write only.

Please provide usage and resulting behavior.

-- 
Darren Hart
VMware Open Source Technology Center
