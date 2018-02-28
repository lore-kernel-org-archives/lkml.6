Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519828166; cv=none;
        d=google.com; s=arc-20160816;
        b=NhdMTdM56rxgYnm0/d32eAO/A6Jbcm14MlM9xK6e0/iITJHJ8InyGgsYfAq6vqobrg
         Zv8ZgHaP17Z8+Shjo7xPPN4x7ko+6PMT0VotNkWjP/I8TetJI75ewhwO40jBYdyhu0Jh
         Q6x2fBy5ql3lXAZkGBo/q/E8tD5ywLpsG7fysQheiIaE/08fJWwOC3mu93WyAoC6tdd1
         IbTGkZhY18miV/HaevKVy/hnlUN4wT/OQ7jkHa7lWwYPykILsM8rKel3XOn6UW2y2DDj
         SaZ1Oqfk7aSd2pKQtx8vE8Op3c/pD3fUhmKvRXhi9nnvxRhe143yl4FCP6lBqGCxVLMq
         HmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=XIMtixO7X9aPr9qCorf1+mIsEV2X49kpj5LakXL5pUM=;
        b=vaaWZX5U7LshK254cZkK5N42gygc6fddgnGEknSjQQ4o7ttj7RDIqbqNCLTqgLpE7o
         GfxpZqfoLswj2OMk7okow8quArYPm5iJ5kFj7d3hZjGhY9LTNU8/A03LRi1+8jlsFAgh
         T11oExPt3LRVs8VgAXWGI5NPjM8JgkzVc7TppdCtHnPgKnAwoYkeEioEu7QNHTdvlOCp
         SjvjloOUWpqIZnTDJZUJm6Mv61xrDDWeWk9opTY0Sz5xFGb8bpfrSZB7WQOOsL7+Z7BM
         YWCQG9Eu5tZtdwgPPEld49omdQPE9KE02YaxJY2lQzUHf6+5MSfS757S9RDiAhG9ib7O
         KcFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GJVgmcB/;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GJVgmcB/;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELtAiJQMtK0KR37mdvdYzO+F4GmDDaKCkYy9aV/d2ZjM3x3foW16RgQqaNbvyQuJf7uEIKaJ7A==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
To: Mikko Perttunen <cyndis@kapsi.fi>, Rajkumar Rampelli <rrajk@nvidia.com>,
 robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, jdelvare@suse.com, corbet@lwn.net,
 catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com,
 mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org,
 andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org,
 heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
 <2510b525-ec36-b49d-5a62-81f335c0d10d@nvidia.com>
 <cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net>
 <2628eff2-dd33-34f4-a7e1-cfe46ef88a3f@nvidia.com>
 <4556a8d2-947d-72c4-2962-3167afb53978@kapsi.fi>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <62ba7f67-5a99-51ab-1214-eb68ebb7e642@roeck-us.net>
Date: Wed, 28 Feb 2018 06:29:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4556a8d2-947d-72c4-2962-3167afb53978@kapsi.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1593655339347948573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/27/2018 11:03 PM, Mikko Perttunen wrote:
> On 02/28/2018 08:12 AM, Rajkumar Rampelli wrote:
>>
>> On Wednesday 28 February 2018 11:28 AM, Guenter Roeck wrote:
>>> On 02/27/2018 09:38 PM, Rajkumar Rampelli wrote:
>>>>
>>>> On Wednesday 21 February 2018 08:20 PM, Guenter Roeck wrote:
>>>>> On 02/20/2018 10:58 PM, Rajkumar Rampelli wrote:
>>>>>> Add generic PWM based tachometer driver via HWMON interface
>>>>>> to report the RPM of motor. This drivers get the period/duty
>>>>>> cycle from PWM IP which captures the motor PWM output.
>>>>>>
>>>>>> This driver implements a simple interface for monitoring the speed of
>>>>>> a fan and exposes it in roatations per minute (RPM) to the user space
>>>>>> by using the hwmon's sysfs interface
>>>>>>
>>>>>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>>>>>> ---
>>>>>>   Documentation/hwmon/generic-pwm-tachometer |  17 +++++
>>>>>>   drivers/hwmon/Kconfig                      |  10 +++
>>>>>>   drivers/hwmon/Makefile                     |   1 +
>>>>>>   drivers/hwmon/generic-pwm-tachometer.c     | 112 +++++++++++++++++++++++++++++
>>>>>>   4 files changed, 140 insertions(+)
>>>>>>   create mode 100644 Documentation/hwmon/generic-pwm-tachometer
>>>>>>   create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
>>>>>>
>>>>>> diff --git a/Documentation/hwmon/generic-pwm-tachometer b/Documentation/hwmon/generic-pwm-tachometer
>>>>>> new file mode 100644
>>>>>> index 0000000..e0713ee
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/hwmon/generic-pwm-tachometer
>>>>>> @@ -0,0 +1,17 @@
>>>>>> +Kernel driver generic-pwm-tachometer
>>>>>> +====================================
>>>>>> +
>>>>>> +This driver enables the use of a PWM module to monitor a fan. It uses the
>>>>>> +generic PWM interface and can be used on SoCs as along as the SoC supports
>>>>>> +Tachometer controller that moniors the Fan speed in periods.
>>>>>> +
>>>>>> +Author: Rajkumar Rampelli <rrajk@nvidia.com>
>>>>>> +
>>>>>> +Description
>>>>>> +-----------
>>>>>> +
>>>>>> +The driver implements a simple interface for monitoring the Fan speed using
>>>>>> +PWM module and Tachometer controller. It requests period value through PWM
>>>>>> +capture interface to Tachometer and measures the Rotations per minute using
>>>>>> +received period value. It exposes the Fan speed in RPM to the user space by
>>>>>> +using the hwmon's sysfs interface.
>>>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>>>> index ef23553..8912dcb 100644
>>>>>> --- a/drivers/hwmon/Kconfig
>>>>>> +++ b/drivers/hwmon/Kconfig
>>>>>> @@ -1878,6 +1878,16 @@ config SENSORS_XGENE
>>>>>>         If you say yes here you get support for the temperature
>>>>>>         and power sensors for APM X-Gene SoC.
>>>>>>   +config GENERIC_PWM_TACHOMETER
>>>>>> +    tristate "Generic PWM based tachometer driver"
>>>>>> +    depends on PWM
>>>>>> +    help
>>>>>> +      Enables a driver to use PWM signal from motor to use
>>>>>> +      for measuring the motor speed. The RPM is captured by
>>>>>> +      PWM modules which has PWM capture capability and this
>>>>>> +      drivers reads the captured data from PWM IP to convert
>>>>>> +      it to speed in RPM.
>>>>>> +
>>>>>>   if ACPI
>>>>>>     comment "ACPI drivers"
>>>>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>>>>> index f814b4a..9dcc374 100644
>>>>>> --- a/drivers/hwmon/Makefile
>>>>>> +++ b/drivers/hwmon/Makefile
>>>>>> @@ -175,6 +175,7 @@ obj-$(CONFIG_SENSORS_WM8350)    += wm8350-hwmon.o
>>>>>>   obj-$(CONFIG_SENSORS_XGENE)    += xgene-hwmon.o
>>>>>>     obj-$(CONFIG_PMBUS)        += pmbus/
>>>>>> +obj-$(CONFIG_GENERIC_PWM_TACHOMETER) += generic-pwm-tachometer.o
>>>>>>     ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>>>>>   diff --git a/drivers/hwmon/generic-pwm-tachometer.c b/drivers/hwmon/generic-pwm-tachometer.c
>>>>>> new file mode 100644
>>>>>> index 0000000..9354d43
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/hwmon/generic-pwm-tachometer.c
>>>>>> @@ -0,0 +1,112 @@
>>>>>> +/*
>>>>>> + * Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights reserved.
>>>>>> + *
>>>>>> + * This program is free software; you can redistribute it and/or modify it
>>>>>> + * under the terms and conditions of the GNU General Public License,
>>>>>> + * version 2, as published by the Free Software Foundation.
>>>>>> + *
>>>>>> + * This program is distributed in the hope it will be useful, but WITHOUT
>>>>>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>>>>>> + * more details.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/platform_device.h>
>>>>>> +#include <linux/err.h>
>>>>>> +#include <linux/pwm.h>
>>>>>> +#include <linux/hwmon.h>
>>>>>> +#include <linux/hwmon-sysfs.h>
>>>>>> +
>>>>>> +struct pwm_hwmon_tach {
>>>>>> +    struct device        *dev;
>>>>>> +    struct pwm_device    *pwm;
>>>>>> +    struct device        *hwmon;
>>>>>> +};
>>>>>> +
>>>>>> +static ssize_t show_rpm(struct device *dev, struct device_attribute *attr,
>>>>>> +            char *buf)
>>>>>> +{
>>>>>> +    struct pwm_hwmon_tach *ptt = dev_get_drvdata(dev);
>>>>>> +    struct pwm_device *pwm = ptt->pwm;
>>>>>> +    struct pwm_capture result;
>>>>>> +    int err;
>>>>>> +    unsigned int rpm = 0;
>>>>>> +
>>>>>> +    err = pwm_capture(pwm, &result, 0);
>>>>>> +    if (err < 0) {
>>>>>> +        dev_err(ptt->dev, "Failed to capture PWM: %d\n", err);
>>>>>> +        return err;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (result.period)
>>>>>> +        rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
>>>>>> +                        result.period);
>>>>>> +
>>>>>> +    return sprintf(buf, "%u\n", rpm);
>>>>>> +}
>>>>>> +
>>>>>> +static SENSOR_DEVICE_ATTR(rpm, 0444, show_rpm, NULL, 0);
>>>>>> +
>>>>>> +static struct attribute *pwm_tach_attrs[] = {
>>>>>> +    &sensor_dev_attr_rpm.dev_attr.attr,
>>>>>> +    NULL,
>>>>>> +};
>>>>>
>>>>> "rpm" is not a standard hwmon sysfs attribute. If you don't provide
>>>>> a single standard hwmon sysfs attribute, having a hwmon driver is pointless.
>>>> Guenter Roeck,
>>>> I will define a new hwmon sysfs attribute node called "hwmon_tachometer_attributes" in hwmon.h like below and update the same in tachometer hwmon driver. Is it fine ?
>>>> enum hwmon_tachometer_attributes {
>>>
>>> Are you kidding me ?
>>>
>>> Guenter
>> Sorry, I just wanted to confirm whether my understanding is correct or not before implementing it actually.
>> Or, shall I add this attribute as a part of fan attributes with "hwmon_fan_rpm" ? or any other way to do it ? I need your inputs in fixing this.
> 
> I think he wants the attribute to be named according to the properties in this document: https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface. I guess the attribute would then map to fan1_input, though I'm not sure if that's 100% correct either since this could technically be attached to something other than a fan. But I would think in practice that's not a big concern.
> 
> Guenter,
> Please correct me as well if I'm wrong.
> 
You are absolutely correct.

While I am not opposed to ABI changes, the merits of those would need to be
discussed on the mailing list. But replacing "fan1_input" with "rpm" is
not an acceptable ABI change, even if it may measure something that turns
but isn't a fan.

If this _is_ in fact supposed to be used for something else but fans, we
would have to discuss what that might be, and if hwmon is the appropriate
subsystem to measure and report it. This does to some degree lead back to
my concern of having the "fan" part of this patch series in the pwm core.
I am still not sure if that makes sense.

Thanks,
Guenter

> Thank you,
> Mikko
> 
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
