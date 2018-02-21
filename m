Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519224387; cv=none;
        d=google.com; s=arc-20160816;
        b=ZOybE/BQGyzXz9q+D/2o4wjbsFTi9H262lTaz759ug9Z/adEGkgkc6PFuCZjJcH/va
         CytsTRLPdy1SUFw+JdTwD1NNcCHy24b6NDPmPqONQRRdmUvdneFechlCfEo3Xx4b1wYb
         5k/FNwQb5gf44S6+Lh6wtecPF3Xak3x67cLfLQPQkjcEvEUoFti2l8pMHNXnzK93/Dkn
         oMKH9A8yeb7ekLO80WYmiTSCwUo8x4o5mdZKJeGIFl04zRTATevFdRC6LX7rb0u4mkaP
         o/SO0mmrUk+Y2et0v+0c2RUoNV+tz4qC/unIpg+5dZ7h4miFhxrdlvOkMmf08dwkBLKR
         QxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=516qXUmpFD7NhqOxsaiexquJM5eANm+Do06FsXD+dbk=;
        b=TKbff4vzO8+PM61K18j72Wky+ZWgFnnyVxF3y2XQdrjxsWzH8f3a6dPeHQWwbxnD7O
         N4OiBatdmPb3hxlCoHff4WvNZ1t6SHl4cyddNzlOLjeVN5+kz3Sow2ENIeHP5RcXF3DR
         gLxw5zVjHVGe9v5NFjx2xhL7iBR/rH1rkB/yNKsA6j3YBVjUjW8jZKjekGyfxZXtZv9A
         zY8MHJcTTE7gUXj+xZSyWxPOYOEtWfQ3daz7U89hS02iU69OTZpYfgktykuTa6dMoowk
         EpgV9sBMHGLafAQEudyKqjsSCMM3zihTt1d6UjMUUsBoLO9iYofKNu0YXK+FyTsiU0Dw
         wA+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IY/sq7Fc;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IY/sq7Fc;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x226GBVck9QBtkP8XvEqdo9lzpdDd84YIDMFaqbVK7QGlUTQgf+nv7q5UWQR0pRTu/4Bu535giw==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
To: Mikko Perttunen <cyndis@kapsi.fi>, Rajkumar Rampelli <rrajk@nvidia.com>,
 robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, jdelvare@suse.com, corbet@lwn.net,
 catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com,
 mperttunen@nvidia.com, arnd@arndb.de, gregory.clement@free-electrons.com,
 timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com,
 elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <ee03e1e5-bbeb-1238-04ed-b992fe3a3ce6@kapsi.fi>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c1192f75-0e6e-c735-67e1-2901624831ae@roeck-us.net>
Date: Wed, 21 Feb 2018 06:46:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ee03e1e5-bbeb-1238-04ed-b992fe3a3ce6@kapsi.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1593022231786688965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/20/2018 11:15 PM, Mikko Perttunen wrote:
> AIUI, the PWM framework already exposes a sysfs node with period information. We should just use that instead of adding a new driver for this.
> 

I am kind of lost. Please explain.

Are you saying that we should drop the pwm-fan driver as well (which goes
the opposite way), as well as any other drivers doing anything with pwm signals,
because after all those signals are already exposed to userspace a sysfs attributes,
and a kernel driver to abstract those values is thus not needed ?

> In any case, we cannot add something like this to device tree since it's not a hardware device.
> 

So you are saying there is no means to express in devicetree that
a pwm input is connected to a fan ? How is that not hardware ?

If so, how do you express in devicetree that a pwm signal is connected
to anything ?

Guenter

> Mikko
> 
> On 21.02.2018 08:58, Rajkumar Rampelli wrote:
>> Add generic PWM based tachometer driver via HWMON interface
>> to report the RPM of motor. This drivers get the period/duty
>> cycle from PWM IP which captures the motor PWM output.
>>
>> This driver implements a simple interface for monitoring the speed of
>> a fan and exposes it in roatations per minute (RPM) to the user space
>> by using the hwmon's sysfs interface
>>
>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>> ---
>>  Documentation/hwmon/generic-pwm-tachometer |  17 +++++
>>  drivers/hwmon/Kconfig                      |  10 +++
>>  drivers/hwmon/Makefile                     |   1 +
>>  drivers/hwmon/generic-pwm-tachometer.c     | 112 +++++++++++++++++++++++++++++
>>  4 files changed, 140 insertions(+)
>>  create mode 100644 Documentation/hwmon/generic-pwm-tachometer
>>  create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
>>
>> diff --git a/Documentation/hwmon/generic-pwm-tachometer b/Documentation/hwmon/generic-pwm-tachometer
>> new file mode 100644
>> index 0000000..e0713ee
>> --- /dev/null
>> +++ b/Documentation/hwmon/generic-pwm-tachometer
>> @@ -0,0 +1,17 @@
>> +Kernel driver generic-pwm-tachometer
>> +====================================
>> +
>> +This driver enables the use of a PWM module to monitor a fan. It uses the
>> +generic PWM interface and can be used on SoCs as along as the SoC supports
>> +Tachometer controller that moniors the Fan speed in periods.
>> +
>> +Author: Rajkumar Rampelli <rrajk@nvidia.com>
>> +
>> +Description
>> +-----------
>> +
>> +The driver implements a simple interface for monitoring the Fan speed using
>> +PWM module and Tachometer controller. It requests period value through PWM
>> +capture interface to Tachometer and measures the Rotations per minute using
>> +received period value. It exposes the Fan speed in RPM to the user space by
>> +using the hwmon's sysfs interface.
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index ef23553..8912dcb 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1878,6 +1878,16 @@ config SENSORS_XGENE
>>        If you say yes here you get support for the temperature
>>        and power sensors for APM X-Gene SoC.
>>
>> +config GENERIC_PWM_TACHOMETER
>> +    tristate "Generic PWM based tachometer driver"
>> +    depends on PWM
>> +    help
>> +      Enables a driver to use PWM signal from motor to use
>> +      for measuring the motor speed. The RPM is captured by
>> +      PWM modules which has PWM capture capability and this
>> +      drivers reads the captured data from PWM IP to convert
>> +      it to speed in RPM.
>> +
>>  if ACPI
>>
>>  comment "ACPI drivers"
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index f814b4a..9dcc374 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -175,6 +175,7 @@ obj-$(CONFIG_SENSORS_WM8350)    += wm8350-hwmon.o
>>  obj-$(CONFIG_SENSORS_XGENE)    += xgene-hwmon.o
>>
>>  obj-$(CONFIG_PMBUS)        += pmbus/
>> +obj-$(CONFIG_GENERIC_PWM_TACHOMETER) += generic-pwm-tachometer.o
>>
>>  ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>
>> diff --git a/drivers/hwmon/generic-pwm-tachometer.c b/drivers/hwmon/generic-pwm-tachometer.c
>> new file mode 100644
>> index 0000000..9354d43
>> --- /dev/null
>> +++ b/drivers/hwmon/generic-pwm-tachometer.c
>> @@ -0,0 +1,112 @@
>> +/*
>> + * Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/err.h>
>> +#include <linux/pwm.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +
>> +struct pwm_hwmon_tach {
>> +    struct device        *dev;
>> +    struct pwm_device    *pwm;
>> +    struct device        *hwmon;
>> +};
>> +
>> +static ssize_t show_rpm(struct device *dev, struct device_attribute *attr,
>> +            char *buf)
>> +{
>> +    struct pwm_hwmon_tach *ptt = dev_get_drvdata(dev);
>> +    struct pwm_device *pwm = ptt->pwm;
>> +    struct pwm_capture result;
>> +    int err;
>> +    unsigned int rpm = 0;
>> +
>> +    err = pwm_capture(pwm, &result, 0);
>> +    if (err < 0) {
>> +        dev_err(ptt->dev, "Failed to capture PWM: %d\n", err);
>> +        return err;
>> +    }
>> +
>> +    if (result.period)
>> +        rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
>> +                        result.period);
>> +
>> +    return sprintf(buf, "%u\n", rpm);
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(rpm, 0444, show_rpm, NULL, 0);
>> +
>> +static struct attribute *pwm_tach_attrs[] = {
>> +    &sensor_dev_attr_rpm.dev_attr.attr,
>> +    NULL,
>> +};
>> +
>> +ATTRIBUTE_GROUPS(pwm_tach);
>> +
>> +static int pwm_tach_probe(struct platform_device *pdev)
>> +{
>> +    struct pwm_hwmon_tach *ptt;
>> +    int err;
>> +
>> +    ptt = devm_kzalloc(&pdev->dev, sizeof(*ptt), GFP_KERNEL);
>> +    if (!ptt)
>> +        return -ENOMEM;
>> +
>> +    ptt->dev = &pdev->dev;
>> +
>> +    platform_set_drvdata(pdev, ptt);
>> +    dev_set_drvdata(&pdev->dev, ptt);
>> +
>> +    ptt->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
>> +    if (IS_ERR(ptt->pwm)) {
>> +        err = PTR_ERR(ptt->pwm);
>> +        dev_err(&pdev->dev, "Failed to get pwm handle, err: %d\n",
>> +            err);
>> +        return err;
>> +    }
>> +
>> +    ptt->hwmon = devm_hwmon_device_register_with_groups(&pdev->dev,
>> +                     "pwm_tach", ptt, pwm_tach_groups);
>> +    if (IS_ERR(ptt->hwmon)) {
>> +        err = PTR_ERR_OR_ZERO(ptt->hwmon);
>> +        dev_err(&pdev->dev, "Failed to register hwmon device: %d\n",
>> +            err);
>> +        return err;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id pwm_tach_of_match[] = {
>> +    { .compatible = "generic-pwm-tachometer" },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, pwm_tach_of_match);
>> +
>> +static struct platform_driver pwm_tach_driver = {
>> +    .driver = {
>> +        .name = "generic-pwm-tachometer",
>> +        .of_match_table = pwm_tach_of_match,
>> +    },
>> +    .probe = pwm_tach_probe,
>> +};
>> +
>> +module_platform_driver(pwm_tach_driver);
>> +
>> +MODULE_DESCRIPTION("PWM based Generic Tachometer driver");
>> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
>> +MODULE_AUTHOR("Rajkumar Rampelli <rrajk@nvidia.com>");
>> +MODULE_LICENSE("GPL v2");
>>
> 
