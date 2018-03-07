Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELuBYR5jBMQxexYjL52zG6a9rxNRFRlhqbLYUfFm4TwNtg12VxXPyFefKCBLzloE21MlbHjH
ARC-Seal: i=1; a=rsa-sha256; t=1520416071; cv=none;
        d=google.com; s=arc-20160816;
        b=rAy3J+JrEZC1DfjP/FZIKegYcusQCoRNVbqb0ToEYf79S0ItBCAGmd9zjKI5n37zC+
         2d40E4/0uznB0CWXwJffUCeKcCedqlAUph8lLsceGIFvrHFSYkKEUzY6IqgNGMLQpAr3
         6h0eT3eYR7sFgT9upA7YAPGsE+WnnRvlpnNT8rkSni3jH8/Swm0Tx42CJTbf3xggwwrR
         AexnldfbMHM1tYn+DmY+0EsVRurVsXqgP+Fm0LXO+8tIi2Egqzws7O/w7GvsUu1e4F9R
         ybAR4TbWyQDcTKVZxB9LMWn1ozDCvgkPEwo91R04A3k8x2kCQ1g9JGYvwjIY+zIZr8SY
         qgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=Vo8SpsQynngYtfIS8NGAZaImPSoShdpPpTI/RGE+zyM=;
        b=riHTbCdVEoOTNaGRMxwDe4tYKaGr+Jfb7ACW4Izj+ZYpDMrsNE52rlqPuf4yvf8qkG
         AcIR5w5n3wIck+C4/EemT528PryFpFTkN9OHvu3ncwVEhKZg9D4uon/Rv3chcRsf933c
         yIvIMuYkzKZDBHsSt6GpjLNwj+mhYqQG0uHc/Ie49CXD6L0O1IDQOohspTafUsf9E5ZU
         9mTiUQ5W2ppNT5qAeMN2Q4kAnZuziTDBc4seA2mh7cZvAqB8Y7vA9/N2AQDuBjoiuKga
         UhmCFTNlWIncbdJQCOpnkAIo/5CL5sdophSgDbDBmJ6C5XVT81E+DmXKFpGwfLd2Gchs
         ONRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Wed, 07 Mar 2018 01:47:49 -0800
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
To: Guenter Roeck <linux@roeck-us.net>, Mikko Perttunen <cyndis@kapsi.fi>,
	<robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <corbet@lwn.net>,
	<catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <timur@codeaurora.org>, <andy.gross@linaro.org>,
	<xuwei5@hisilicon.com>, <elder@linaro.org>, <heiko@sntech.de>,
	<krzk@kernel.org>, <ard.biesheuvel@linaro.org>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
 <2510b525-ec36-b49d-5a62-81f335c0d10d@nvidia.com>
 <cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net>
 <2628eff2-dd33-34f4-a7e1-cfe46ef88a3f@nvidia.com>
 <4556a8d2-947d-72c4-2962-3167afb53978@kapsi.fi>
 <62ba7f67-5a99-51ab-1214-eb68ebb7e642@roeck-us.net>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>
From: Rajkumar Rampelli <rrajk@nvidia.com>
Message-ID: <952cb50e-d9a0-ae5e-d9f6-d1ce268f0384@nvidia.com>
Date: Wed, 7 Mar 2018 15:17:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <62ba7f67-5a99-51ab-1214-eb68ebb7e642@roeck-us.net>
X-Originating-IP: [10.19.65.123]
X-ClientProxiedBy: BGMAIL102.nvidia.com (10.25.59.11) To bgmail103.nvidia.com
 (10.25.59.12)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1594271801803950279?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wednesday 28 February 2018 07:59 PM, Guenter Roeck wrote:
> On 02/27/2018 11:03 PM, Mikko Perttunen wrote:
>> On 02/28/2018 08:12 AM, Rajkumar Rampelli wrote:
>>>
>>> On Wednesday 28 February 2018 11:28 AM, Guenter Roeck wrote:
>>>> On 02/27/2018 09:38 PM, Rajkumar Rampelli wrote:
>>>>>
>>>>> On Wednesday 21 February 2018 08:20 PM, Guenter Roeck wrote:
>>>>>> On 02/20/2018 10:58 PM, Rajkumar Rampelli wrote:
>>>>>>> Add generic PWM based tachometer driver via HWMON interface
>>>>>>> to report the RPM of motor. This drivers get the period/duty
>>>>>>> cycle from PWM IP which captures the motor PWM output.
>>>>>>>
>>>>>>> This driver implements a simple interface for monitoring the 
>>>>>>> speed of
>>>>>>> a fan and exposes it in roatations per minute (RPM) to the user 
>>>>>>> space
>>>>>>> by using the hwmon's sysfs interface
>>>>>>>
>>>>>>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>>>>>>> ---
>>>>>>>   Documentation/hwmon/generic-pwm-tachometer |  17 +++++
>>>>>>>   drivers/hwmon/Kconfig                      |  10 +++
>>>>>>>   drivers/hwmon/Makefile                     |   1 +
>>>>>>>   drivers/hwmon/generic-pwm-tachometer.c     | 112 
>>>>>>> +++++++++++++++++++++++++++++
>>>>>>>   4 files changed, 140 insertions(+)
>>>>>>>   create mode 100644 Documentation/hwmon/generic-pwm-tachometer
>>>>>>>   create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
>>>>>>>
>>>>>>> diff --git a/Documentation/hwmon/generic-pwm-tachometer 
>>>>>>> b/Documentation/hwmon/generic-pwm-tachometer
>>>>>>> new file mode 100644
>>>>>>> index 0000000..e0713ee
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/hwmon/generic-pwm-tachometer
>>>>>>> @@ -0,0 +1,17 @@
>>>>>>> +Kernel driver generic-pwm-tachometer
>>>>>>> +====================================
>>>>>>> +
>>>>>>> +This driver enables the use of a PWM module to monitor a fan. 
>>>>>>> It uses the
>>>>>>> +generic PWM interface and can be used on SoCs as along as the 
>>>>>>> SoC supports
>>>>>>> +Tachometer controller that moniors the Fan speed in periods.
>>>>>>> +
>>>>>>> +Author: Rajkumar Rampelli <rrajk@nvidia.com>
>>>>>>> +
>>>>>>> +Description
>>>>>>> +-----------
>>>>>>> +
>>>>>>> +The driver implements a simple interface for monitoring the Fan 
>>>>>>> speed using
>>>>>>> +PWM module and Tachometer controller. It requests period value 
>>>>>>> through PWM
>>>>>>> +capture interface to Tachometer and measures the Rotations per 
>>>>>>> minute using
>>>>>>> +received period value. It exposes the Fan speed in RPM to the 
>>>>>>> user space by
>>>>>>> +using the hwmon's sysfs interface.
>>>>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>>>>> index ef23553..8912dcb 100644
>>>>>>> --- a/drivers/hwmon/Kconfig
>>>>>>> +++ b/drivers/hwmon/Kconfig
>>>>>>> @@ -1878,6 +1878,16 @@ config SENSORS_XGENE
>>>>>>>         If you say yes here you get support for the temperature
>>>>>>>         and power sensors for APM X-Gene SoC.
>>>>>>>   +config GENERIC_PWM_TACHOMETER
>>>>>>> +    tristate "Generic PWM based tachometer driver"
>>>>>>> +    depends on PWM
>>>>>>> +    help
>>>>>>> +      Enables a driver to use PWM signal from motor to use
>>>>>>> +      for measuring the motor speed. The RPM is captured by
>>>>>>> +      PWM modules which has PWM capture capability and this
>>>>>>> +      drivers reads the captured data from PWM IP to convert
>>>>>>> +      it to speed in RPM.
>>>>>>> +
>>>>>>>   if ACPI
>>>>>>>     comment "ACPI drivers"
>>>>>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>>>>>> index f814b4a..9dcc374 100644
>>>>>>> --- a/drivers/hwmon/Makefile
>>>>>>> +++ b/drivers/hwmon/Makefile
>>>>>>> @@ -175,6 +175,7 @@ obj-$(CONFIG_SENSORS_WM8350)    += 
>>>>>>> wm8350-hwmon.o
>>>>>>>   obj-$(CONFIG_SENSORS_XGENE)    += xgene-hwmon.o
>>>>>>>     obj-$(CONFIG_PMBUS)        += pmbus/
>>>>>>> +obj-$(CONFIG_GENERIC_PWM_TACHOMETER) += generic-pwm-tachometer.o
>>>>>>>     ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
>>>>>>>   diff --git a/drivers/hwmon/generic-pwm-tachometer.c 
>>>>>>> b/drivers/hwmon/generic-pwm-tachometer.c
>>>>>>> new file mode 100644
>>>>>>> index 0000000..9354d43
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/hwmon/generic-pwm-tachometer.c
>>>>>>> @@ -0,0 +1,112 @@
>>>>>>> +/*
>>>>>>> + * Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights 
>>>>>>> reserved.
>>>>>>> + *
>>>>>>> + * This program is free software; you can redistribute it 
>>>>>>> and/or modify it
>>>>>>> + * under the terms and conditions of the GNU General Public 
>>>>>>> License,
>>>>>>> + * version 2, as published by the Free Software Foundation.
>>>>>>> + *
>>>>>>> + * This program is distributed in the hope it will be useful, 
>>>>>>> but WITHOUT
>>>>>>> + * ANY WARRANTY; without even the implied warranty of 
>>>>>>> MERCHANTABILITY or
>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General 
>>>>>>> Public License for
>>>>>>> + * more details.
>>>>>>> + *
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/module.h>
>>>>>>> +#include <linux/platform_device.h>
>>>>>>> +#include <linux/err.h>
>>>>>>> +#include <linux/pwm.h>
>>>>>>> +#include <linux/hwmon.h>
>>>>>>> +#include <linux/hwmon-sysfs.h>
>>>>>>> +
>>>>>>> +struct pwm_hwmon_tach {
>>>>>>> +    struct device        *dev;
>>>>>>> +    struct pwm_device    *pwm;
>>>>>>> +    struct device        *hwmon;
>>>>>>> +};
>>>>>>> +
>>>>>>> +static ssize_t show_rpm(struct device *dev, struct 
>>>>>>> device_attribute *attr,
>>>>>>> +            char *buf)
>>>>>>> +{
>>>>>>> +    struct pwm_hwmon_tach *ptt = dev_get_drvdata(dev);
>>>>>>> +    struct pwm_device *pwm = ptt->pwm;
>>>>>>> +    struct pwm_capture result;
>>>>>>> +    int err;
>>>>>>> +    unsigned int rpm = 0;
>>>>>>> +
>>>>>>> +    err = pwm_capture(pwm, &result, 0);
>>>>>>> +    if (err < 0) {
>>>>>>> +        dev_err(ptt->dev, "Failed to capture PWM: %d\n", err);
>>>>>>> +        return err;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (result.period)
>>>>>>> +        rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
>>>>>>> +                        result.period);
>>>>>>> +
>>>>>>> +    return sprintf(buf, "%u\n", rpm);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static SENSOR_DEVICE_ATTR(rpm, 0444, show_rpm, NULL, 0);
>>>>>>> +
>>>>>>> +static struct attribute *pwm_tach_attrs[] = {
>>>>>>> +    &sensor_dev_attr_rpm.dev_attr.attr,
>>>>>>> +    NULL,
>>>>>>> +};
>>>>>>
>>>>>> "rpm" is not a standard hwmon sysfs attribute. If you don't provide
>>>>>> a single standard hwmon sysfs attribute, having a hwmon driver is 
>>>>>> pointless.
>>>>> Guenter Roeck,
>>>>> I will define a new hwmon sysfs attribute node called 
>>>>> "hwmon_tachometer_attributes" in hwmon.h like below and update the 
>>>>> same in tachometer hwmon driver. Is it fine ?
>>>>> enum hwmon_tachometer_attributes {
>>>>
>>>> Are you kidding me ?
>>>>
>>>> Guenter
>>> Sorry, I just wanted to confirm whether my understanding is correct 
>>> or not before implementing it actually.
>>> Or, shall I add this attribute as a part of fan attributes with 
>>> "hwmon_fan_rpm" ? or any other way to do it ? I need your inputs in 
>>> fixing this.
>>
>> I think he wants the attribute to be named according to the 
>> properties in this document: 
>> https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface. I 
>> guess the attribute would then map to fan1_input, though I'm not sure 
>> if that's 100% correct either since this could technically be 
>> attached to something other than a fan. But I would think in practice 
>> that's not a big concern.
>>
>> Guenter,
>> Please correct me as well if I'm wrong.
>>
> You are absolutely correct.
>
> While I am not opposed to ABI changes, the merits of those would need 
> to be
> discussed on the mailing list. But replacing "fan1_input" with "rpm" is
> not an acceptable ABI change, even if it may measure something that turns
> but isn't a fan.
>
> If this _is_ in fact supposed to be used for something else but fans, we
> would have to discuss what that might be, and if hwmon is the appropriate
> subsystem to measure and report it. This does to some degree lead back to
> my concern of having the "fan" part of this patch series in the pwm core.
> I am still not sure if that makes sense.
>
> Thanks,
> Guenter
I am planning to add tachometer support in pwm-fan.c driver 
(drivers/hwmon/) instead of adding new generic-pwm-tachometer.c driver. 
Measuring RPM value will be done in pwm-fan driver itself using pwm 
capture feature and will add new sysfs attributes under this driver to 
report rpm value of fan.
>
>> Thank you,
>> Mikko
>>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-tegra" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-hwmon" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
