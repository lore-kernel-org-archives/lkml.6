Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELtHxAHFyaxA57duT+Qc2G8LcGLv0zfEo0Q0GDrSw+Xzr35nwBSxoJDHFjAhvtfCubpVcOP+
ARC-Seal: i=1; a=rsa-sha256; t=1519796306; cv=none;
        d=google.com; s=arc-20160816;
        b=f1a/b8IPeq0lw6sERXcARirIVnI6s/Jyk4iuhpRVJyeiVbrSAFZQnmEKHv8M2PUWfk
         xlC5to9XLhUTIUeMfyf2VJ/48V68JXcjYHfrzwr7V1Oe8YhJFUuPf/02COuZnEGYVYVG
         G/4sepjeGB2977zaA5DGPjTomWP3ex4GDogrDUc6slHvipPAQRzHoYWkTM3MvKN0gTdn
         ibiNTwAQxAE2tnMK4tkAUcUJQ+qOV9HUGd1mDayrmSQJbpLahnF243ZZiQYyn7iZI6vj
         2BzOVtmLYQ+qJwFJXELSBIQMkp+bZ6C15WKOwm6buo06bOT2MGt/TzDGEVGGUpIuPVOp
         a0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=9+bsfOeUu2sa0CGqolOLfZIBG6srp9dXVkTqxOOYT1c=;
        b=CSt7aTqzWkzpCytu8GL1YMxkeCw/wTAejfnzmhAKKEmM9smmFNslk9sIyjpPAPekou
         MZb1LQYGrR7mOqDx6+DhqVeHzxFYKW608bB2Qa5YSl51krLeVfbRkUODyhwhDarGLccr
         77rkLghbQ1P1S6b6wBc1+gyAIqZzyPIVpP/cgsJP08+F/5McdWYbxVx67Nt9YPMYmIv2
         XQoivP1Vwhp6C4fMi68y4ApFFRVIw/a5yaGmcPd7cFE7k15wVrCy/4IjRFMznylEd1qa
         zGdKGjb2aDJj5nl1GGIhgl+RIoRlBZ2PBw2e5NXR/QdXWWk0Ph86oTSbzGypBFqVy8U/
         I7qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 27 Feb 2018 21:38:25 -0800
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
To: Guenter Roeck <linux@roeck-us.net>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jdelvare@suse.com>, <corbet@lwn.net>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <pombredanne@nexb.com>,
	<mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>, <arnd@arndb.de>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>
From: Rajkumar Rampelli <rrajk@nvidia.com>
Message-ID: <2510b525-ec36-b49d-5a62-81f335c0d10d@nvidia.com>
Date: Wed, 28 Feb 2018 11:08:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
X-Originating-IP: [10.19.65.123]
X-ClientProxiedBy: BGMAIL102.nvidia.com (10.25.59.11) To bgmail103.nvidia.com
 (10.25.59.12)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1593621931819616212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On Wednesday 21 February 2018 08:20 PM, Guenter Roeck wrote:
> On 02/20/2018 10:58 PM, Rajkumar Rampelli wrote:
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
>>   Documentation/hwmon/generic-pwm-tachometer |  17 +++++
>>   drivers/hwmon/Kconfig                      |  10 +++
>>   drivers/hwmon/Makefile                     |   1 +
>>   drivers/hwmon/generic-pwm-tachometer.c     | 112 
>> +++++++++++++++++++++++++++++
>>   4 files changed, 140 insertions(+)
>>   create mode 100644 Documentation/hwmon/generic-pwm-tachometer
>>   create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
>>
>> diff --git a/Documentation/hwmon/generic-pwm-tachometer 
>> b/Documentation/hwmon/generic-pwm-tachometer
>> new file mode 100644
>> index 0000000..e0713ee
>> --- /dev/null
>> +++ b/Documentation/hwmon/generic-pwm-tachometer
>> @@ -0,0 +1,17 @@
>> +Kernel driver generic-pwm-tachometer
>> +====================================
>> +
>> +This driver enables the use of a PWM module to monitor a fan. It 
>> uses the
>> +generic PWM interface and can be used on SoCs as along as the SoC 
>> supports
>> +Tachometer controller that moniors the Fan speed in periods.
>> +
>> +Author: Rajkumar Rampelli <rrajk@nvidia.com>
>> +
>> +Description
>> +-----------
>> +
>> +The driver implements a simple interface for monitoring the Fan 
>> speed using
>> +PWM module and Tachometer controller. It requests period value 
>> through PWM
>> +capture interface to Tachometer and measures the Rotations per 
>> minute using
>> +received period value. It exposes the Fan speed in RPM to the user 
>> space by
>> +using the hwmon's sysfs interface.
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index ef23553..8912dcb 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1878,6 +1878,16 @@ config SENSORS_XGENE
>>         If you say yes here you get support for the temperature
>>         and power sensors for APM X-Gene SoC.
>>   +config GENERIC_PWM_TACHOMETER
>> +    tristate "Generic PWM based tachometer driver"
>> +    depends on PWM
>> +    help
>> +      Enables a driver to use PWM signal from motor to use
>> +      for measuring the motor speed. The RPM is captured by
>> +      PWM modules which has PWM capture capability and this
>> +      drivers reads the captured data from PWM IP to convert
>> +      it to speed in RPM.
>> +
>>   if ACPI
>>     comment "ACPI drivers"
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index f814b4a..9dcc374 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -175,6 +175,7 @@ obj-$(CONFIG_SENSORS_WM8350)    += wm8350-hwmon.o
>>   obj-$(CONFIG_SENSORS_XGENE)    += xgene-hwmon.o
>>     obj-$(CONFIG_PMBUS)        += pmbus/
>> +obj-$(CONFIG_GENERIC_PWM_TACHOMETER) += generic-pwm-tachometer.o
>>     ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>   diff --git a/drivers/hwmon/generic-pwm-tachometer.c 
>> b/drivers/hwmon/generic-pwm-tachometer.c
>> new file mode 100644
>> index 0000000..9354d43
>> --- /dev/null
>> +++ b/drivers/hwmon/generic-pwm-tachometer.c
>> @@ -0,0 +1,112 @@
>> +/*
>> + * Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or 
>> modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but 
>> WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of 
>> MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public 
>> License for
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
>> +    struct device        *dev;
>> +    struct pwm_device    *pwm;
>> +    struct device        *hwmon;
>> +};
>> +
>> +static ssize_t show_rpm(struct device *dev, struct device_attribute 
>> *attr,
>> +            char *buf)
>> +{
>> +    struct pwm_hwmon_tach *ptt = dev_get_drvdata(dev);
>> +    struct pwm_device *pwm = ptt->pwm;
>> +    struct pwm_capture result;
>> +    int err;
>> +    unsigned int rpm = 0;
>> +
>> +    err = pwm_capture(pwm, &result, 0);
>> +    if (err < 0) {
>> +        dev_err(ptt->dev, "Failed to capture PWM: %d\n", err);
>> +        return err;
>> +    }
>> +
>> +    if (result.period)
>> +        rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
>> +                        result.period);
>> +
>> +    return sprintf(buf, "%u\n", rpm);
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(rpm, 0444, show_rpm, NULL, 0);
>> +
>> +static struct attribute *pwm_tach_attrs[] = {
>> +    &sensor_dev_attr_rpm.dev_attr.attr,
>> +    NULL,
>> +};
>
> "rpm" is not a standard hwmon sysfs attribute. If you don't provide
> a single standard hwmon sysfs attribute, having a hwmon driver is 
> pointless.
Guenter Roeck,
I will define a new hwmon sysfs attribute node called 
"hwmon_tachometer_attributes" in hwmon.h like below and update the same 
in tachometer hwmon driver. Is it fine ?
enum hwmon_tachometer_attributes {
         hwmon_tachometer_rpm,
};
>> +
>> +ATTRIBUTE_GROUPS(pwm_tach);
>> +
>> +static int pwm_tach_probe(struct platform_device *pdev)
>> +{
>> +    struct pwm_hwmon_tach *ptt;
>> +    int err;
>> +
>> +    ptt = devm_kzalloc(&pdev->dev, sizeof(*ptt), GFP_KERNEL);
>> +    if (!ptt)
>> +        return -ENOMEM;
>> +
>> +    ptt->dev = &pdev->dev;
>> +
>> +    platform_set_drvdata(pdev, ptt);
>> +    dev_set_drvdata(&pdev->dev, ptt);
>> +
>
> None of those is used.
I will take care in next version of patches.
>
>> +    ptt->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
>> +    if (IS_ERR(ptt->pwm)) {
>> +        err = PTR_ERR(ptt->pwm);
>> +        dev_err(&pdev->dev, "Failed to get pwm handle, err: %d\n",
>> +            err);
>> +        return err;
>> +    }
>> +
>> +    ptt->hwmon = devm_hwmon_device_register_with_groups(&pdev->dev,
>> +                     "pwm_tach", ptt, pwm_tach_groups);
>
> Please use the new API - devm_hwmon_device_register_with_info -
> for new drivers.
Sure, will take care.
>
>> +    if (IS_ERR(ptt->hwmon)) {
>> +        err = PTR_ERR_OR_ZERO(ptt->hwmon);
>> +        dev_err(&pdev->dev, "Failed to register hwmon device: %d\n",
>> +            err);
>> +        return err;
>> +    }
>
> Please no noise on failure. The failure is going to be a memory 
> allocation failure,
> which is reported already, and user space will be informed with the 
> error code.
I will take care.
