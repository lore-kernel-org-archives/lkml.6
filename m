Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeEUN6e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:58:34 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40074 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeEUN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:58:31 -0400
X-Google-Smtp-Source: AB8JxZqBS56Q+g1P+pLMOSmfKNK8kn0UEuRkvMP8pXEFAk7FhEbetyo4Lq3beO3LWz2YswtLFCdZKg==
Date: Mon, 21 May 2018 09:58:28 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 9/9] iio: counter: Remove IIO counter subdirectory
Message-ID: <20180521135828.GD5723@sophia>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
 <4c335e0eebfbaf6e86f41e0f2864d76993d90b13.1526487615.git.vilhelm.gray@gmail.com>
 <20180520165302.101d37ce@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180520165302.101d37ce@archlinux>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 04:53:02PM +0100, Jonathan Cameron wrote:
>On Wed, 16 May 2018 13:52:39 -0400
>William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> This patch removes the IIO counter subdirectory which is now superceded
>> by the Counter subsystem. Deprecation warnings are added to the
>> documentation of the relevant IIO counter sysfs attributes.
>> 
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
>Please drop the directory when it becomes empty rather than in a later
>patch.  IIRC there are some issues with empty Makefiles that will
>make building inbetween tricky.
>
>For the deprecated markings.
>
>Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'll have the directory removal occur with the removal of the last
module then when the directory becomes empty.

Regarding the deprecation markings, should I select a specific kernel
version to date the removal of these attributes, or leave the future
date open as this patch is now?

William Breathitt Gray

>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio          |  8 ++++++++
>>  .../ABI/testing/sysfs-bus-iio-counter-104-quad-8 | 16 ++++++++++++++++
>>  drivers/iio/Kconfig                              |  1 -
>>  drivers/iio/Makefile                             |  1 -
>>  drivers/iio/counter/Kconfig                      |  8 --------
>>  drivers/iio/counter/Makefile                     |  5 -----
>>  6 files changed, 24 insertions(+), 15 deletions(-)
>>  delete mode 100644 drivers/iio/counter/Kconfig
>>  delete mode 100644 drivers/iio/counter/Makefile
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 731146c3b138..6115d97b075e 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1637,6 +1637,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Raw counter device counts from channel Y. For quadrature
>>  		counters, multiplication by an available [Y]_scale results in
>>  		the counts of a single quadrature signal phase from channel Y.
>> @@ -1645,6 +1647,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_raw
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Raw counter device index value from channel Y. This attribute
>>  		provides an absolute positional reference (e.g. a pulse once per
>>  		revolution) which may be used to home positional systems as
>> @@ -1654,6 +1658,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_direction_available
>>  KernelVersion:	4.12
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		A list of possible counting directions which are:
>>  		- "up"	: counter device is increasing.
>>  		- "down": counter device is decreasing.
>> @@ -1662,4 +1668,6 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_direction
>>  KernelVersion:	4.12
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Raw counter device counters direction for channel Y.
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
>> index 7fac2c268d9a..bac3d0d48b7b 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
>> @@ -6,6 +6,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_index_synchronous_mode_available
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Discrete set of available values for the respective counter
>>  		configuration are listed in this file.
>>  
>> @@ -13,6 +15,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Count mode for channel Y. Four count modes are available:
>>  		normal, range limit, non-recycle, and modulo-n. The preset value
>>  		for channel Y is used by the count mode where required.
>> @@ -47,6 +51,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Read-only attribute that indicates whether excessive noise is
>>  		present at the channel Y count inputs in quadrature clock mode;
>>  		irrelevant in non-quadrature clock mode.
>> @@ -55,6 +61,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_preset
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		If the counter device supports preset registers, the preset
>>  		count for channel Y is provided by this attribute.
>>  
>> @@ -62,6 +70,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_quadrature_mode
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Configure channel Y counter for non-quadrature or quadrature
>>  		clock mode. Selecting non-quadrature clock mode will disable
>>  		synchronous load mode. In quadrature clock mode, the channel Y
>> @@ -83,6 +93,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_countY_set_to_preset_on_index
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Whether to set channel Y counter with channel Y preset value
>>  		when channel Y index input is active, or continuously count.
>>  		Valid attribute values are boolean.
>> @@ -91,6 +103,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Active level of channel Y index input; irrelevant in
>>  		non-synchronous load mode.
>>  
>> @@ -98,6 +112,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_synchronous_mode
>>  KernelVersion:	4.10
>>  Contact:	linux-iio@vger.kernel.org
>>  Description:
>> +		This interface is deprecated; please use the Counter subsystem.
>> +
>>  		Configure channel Y counter for non-synchronous or synchronous
>>  		load mode. Synchronous load mode cannot be selected in
>>  		non-quadrature clock mode.
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index d69e85a8bdc3..1152efad91a1 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -74,7 +74,6 @@ source "drivers/iio/afe/Kconfig"
>>  source "drivers/iio/amplifiers/Kconfig"
>>  source "drivers/iio/chemical/Kconfig"
>>  source "drivers/iio/common/Kconfig"
>> -source "drivers/iio/counter/Kconfig"
>>  source "drivers/iio/dac/Kconfig"
>>  source "drivers/iio/dummy/Kconfig"
>>  source "drivers/iio/frequency/Kconfig"
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index d8cba9c229c0..7bdd31f1b88f 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -20,7 +20,6 @@ obj-y += amplifiers/
>>  obj-y += buffer/
>>  obj-y += chemical/
>>  obj-y += common/
>> -obj-y += counter/
>>  obj-y += dac/
>>  obj-y += dummy/
>>  obj-y += gyro/
>> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
>> deleted file mode 100644
>> index 95a7a0df6cac..000000000000
>> --- a/drivers/iio/counter/Kconfig
>> +++ /dev/null
>> @@ -1,8 +0,0 @@
>> -#
>> -# Counter devices
>> -#
>> -# When adding new entries keep the list in alphabetical order
>> -
>> -menu "Counters"
>> -
>> -endmenu
>> diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
>> deleted file mode 100644
>> index 8fd3d954775a..000000000000
>> --- a/drivers/iio/counter/Makefile
>> +++ /dev/null
>> @@ -1,5 +0,0 @@
>> -#
>> -# Makefile for IIO counter devices
>> -#
>> -
>> -# When adding new entries keep the list in alphabetical order
>
