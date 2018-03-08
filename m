Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELtNkit0XiMN5R4xfh8mDmeo8VUH8VyfkUgCI1D4dMKmCM+IUVyprzXq16YvDWeYpRKYalr4
ARC-Seal: i=1; a=rsa-sha256; t=1520511538; cv=none;
        d=google.com; s=arc-20160816;
        b=XX9jXoXk6bdmCx2GpKIZr4MJXvTOYpJ1bpxuyZrD9jeMdSPl5K/oIBHhGVOL6glRGO
         IbjDPhXruk4bfDmDmT9qfNSpbsWu4f5pTcJmHEMXcJN8tMgqAL15d5D+wYlqNA6uIAcC
         ZdZN7bPsLAFsyexhqTfjfHpjB+ckrepGIB2kGJcE+hPulpiPfO+CjaBhpzcEU1WqDttI
         /FaLvADaIdvs2CJv4QjgfCQN82kE4QyJya+Ukl/4jtz5Jav+x2Q+vqW1Cu6aI4lHH3Fy
         zMhRo51B/lbOMnuilVTLC85wa0fCpI2AJqFe2GztG7xRNmPIzSCMV6PpX4I50oIc/KZ6
         viPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=qLynu/3oyx+c8tmZIR7AuTc0i02AkqtF0ZCLHOSSlVU=;
        b=DT0f+dbmjqra7Lss0GlEg+oR7tHh7RfXNyNQ//xLzLkWQovTgSxKwTMnKVGopsQNFc
         1pI2gLO1jW1dLT+RKnUQKPB2WtZH/iz94KctWNo8ZfRMzfs4VCq5CR5b6h+CrqDYBsGl
         xugCDLf83H9uiA2UEeogZC8Y6B1l0/uu0GS/ZdSzDu42EE1c1YSWBCseO91In9+eIVg3
         WSF45bZRfQSeBxpB9uJS45oaaH7nI9OeOGVDNhXwXugpalIrLNsD29uXr96/0r0wY2gU
         OzX8+M/+Pn+z9PNYb1YO1mWs1AjCbN0X8qmJKdK79ssh2Fze0wcWdDo+iAAQEA9RsZ/l
         gZkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, Rajan Vaja
 <RAJANV@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
To: Jolly Shah <JOLLYS@xilinx.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-3-git-send-email-jollys@xilinx.com>
 <dab419e8-3afe-5bfe-240e-e9ee4f2300f2@arm.com>
 <DM2PR0201MB076735E33069DC6F0C84EFDCB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <2fb8ee8c-35ac-b7e6-e691-84464b0c8745@arm.com>
Date: Thu, 8 Mar 2018 12:18:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <DM2PR0201MB076735E33069DC6F0C84EFDCB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948934312896009?=
X-GMAIL-MSGID: =?utf-8?q?1594371907728088901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/03/18 00:44, Jolly Shah wrote:
> Hi Sudeep,
> 
> Thanks for the review,
> 
>> -----Original Message-----
>> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
>> Sent: Thursday, March 01, 2018 6:28 AM
>> To: Jolly Shah <JOLLYS@xilinx.com>; michal.simek@xilinx.com
>> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
>> gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
>> hkallweit1@gmail.com; keescook@chromium.org;
>> dmitry.torokhov@gmail.com; robh+dt@kernel.org; mark.rutland@arm.com;
>> Sudeep Holla <sudeep.holla@arm.com>; Rajan Vaja <RAJANV@xilinx.com>;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>
>> Subject: Re: [PATCH v5 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
>> driver
>>
>>
>>
>> On 20/02/18 19:21, Jolly Shah wrote:
>>> This patch is adding communication layer with firmware.
>>> Firmware driver provides an interface to firmware APIs.
>>> Interface APIs can be used by any driver to communicate to
>>> PMUFW(Platform Management Unit). All requests go through ATF.
>>>
>>> Signed-off-by: Jolly Shah <jollys@xilinx.com>
>>> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>>> ---
>>>  arch/arm64/Kconfig.platforms                    |    1 +
>>>  drivers/firmware/Kconfig                        |    1 +
>>>  drivers/firmware/Makefile                       |    1 +
>>>  drivers/firmware/xilinx/Kconfig                 |    4 +
>>>  drivers/firmware/xilinx/Makefile                |    4 +
>>>  drivers/firmware/xilinx/zynqmp/Kconfig          |   16 +
>>>  drivers/firmware/xilinx/zynqmp/Makefile         |    4 +
>>>  drivers/firmware/xilinx/zynqmp/firmware.c       | 1051
>> +++++++++++++++++++++++
>>>  include/linux/firmware/xilinx/zynqmp/firmware.h |  590 +++++++++++++
>>>  9 files changed, 1672 insertions(+)
>>>  create mode 100644 drivers/firmware/xilinx/Kconfig  create mode
>>> 100644 drivers/firmware/xilinx/Makefile  create mode 100644
>>> drivers/firmware/xilinx/zynqmp/Kconfig
>>>  create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
>>>  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
>>>  create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h
>>>
>>> +
>>> +/**
>>> + * zynqmp_pm_force_powerdown - PM call to request for another PU or
>> subsystem to
>>> + *				be powered down forcefully
>>> + * @target:	Node ID of the targeted PU or subsystem
>>> + * @ack:	Flag to specify whether acknowledge is requested
>>> + *
>>> + * Return:	Returns status, either success or error+reason
>>> + */
>>> +static int zynqmp_pm_force_powerdown(const u32 target,
>>> +				     const enum zynqmp_pm_request_ack ack) {
>>> +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack,
>> 0, 0,
>>> +NULL); }
>>> +
>>
>> [...]
>>
>>> +/**
>>> + * zynqmp_pm_system_shutdown - PM call to request a system shutdown or
>> restart
>>> + * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
>>> + * @subtype:	Specifies which system should be restarted or shut down
>>> + *
>>> + * Return:	Returns status, either success or error+reason
>>> + */
>>> +static int zynqmp_pm_system_shutdown(const u32 type, const u32
>>> +subtype) {
>>> +	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
>>> +				   0, 0, NULL);
>>> +}
>>> +
>>
>> I can't understand why you need above 2 APIs: PM_FORCE_POWERDOWN and
>> PM_SYSTEM_SHUTDOWN. You should use PSCI_SYSTEM_OFF and
>> PSCI_SYSTEM_RESET and drop these two.
>>
> 
> FORCE_POWERDOWN allows remote master to force power off other
> node/domain. SYSTEM_SHUTDOWN provides interface to shutdown/restart
> the subsystem. It supports system/subsystem restart with argument value.> PSCI doesn’t
support argument to identify between restart types.

OK, what are the types you are referring here ? or why PSCI is not
sufficient ? How do you plan to use these APIs in Linux ?

>>
>>> +static const struct zynqmp_eemi_ops eemi_ops = {
>>> +	.get_api_version = zynqmp_pm_get_api_version,
>>> +	.get_chipid = zynqmp_pm_get_chipid,
>>> +	.reset_assert = zynqmp_pm_reset_assert,
>>> +	.reset_get_status = zynqmp_pm_reset_get_status,
>>> +	.fpga_load = zynqmp_pm_fpga_load,
>>> +	.fpga_get_status = zynqmp_pm_fpga_get_status,
>>> +	.sha_hash = zynqmp_pm_sha_hash,
>>> +	.rsa = zynqmp_pm_rsa,
>>> +	.request_suspend = zynqmp_pm_request_suspend,
>>> +	.force_powerdown = zynqmp_pm_force_powerdown,
>>> +	.request_wakeup = zynqmp_pm_request_wakeup,
>>> +	.set_wakeup_source = zynqmp_pm_set_wakeup_source,
>>> +	.system_shutdown = zynqmp_pm_system_shutdown,
>>> +	.request_node = zynqmp_pm_request_node,
>>> +	.release_node = zynqmp_pm_release_node,
>>> +	.set_requirement = zynqmp_pm_set_requirement,
>>> +	.set_max_latency = zynqmp_pm_set_max_latency,
>>> +	.set_configuration = zynqmp_pm_set_configuration,
>>> +	.get_node_status = zynqmp_pm_get_node_status,
>>> +	.get_operating_characteristic =
>> zynqmp_pm_get_operating_characteristic,
>>> +	.init_finalize = zynqmp_pm_init_finalize,
>>> +	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
>>> +	.ioctl = zynqmp_pm_ioctl,
>>> +	.query_data = zynqmp_pm_query_data,
>>> +	.pinctrl_request = zynqmp_pm_pinctrl_request,
>>> +	.pinctrl_release = zynqmp_pm_pinctrl_release,
>>> +	.pinctrl_get_function = zynqmp_pm_pinctrl_get_function,
>>> +	.pinctrl_set_function = zynqmp_pm_pinctrl_set_function,
>>> +	.pinctrl_get_config = zynqmp_pm_pinctrl_get_config,
>>> +	.pinctrl_set_config = zynqmp_pm_pinctrl_set_config,
>>> +	.clock_enable = zynqmp_pm_clock_enable,
>>> +	.clock_disable = zynqmp_pm_clock_disable,
>>> +	.clock_getstate = zynqmp_pm_clock_getstate,
>>> +	.clock_setdivider = zynqmp_pm_clock_setdivider,
>>> +	.clock_getdivider = zynqmp_pm_clock_getdivider,
>>> +	.clock_setrate = zynqmp_pm_clock_setrate,
>>> +	.clock_getrate = zynqmp_pm_clock_getrate,
>>> +	.clock_setparent = zynqmp_pm_clock_setparent,
>>> +	.clock_getparent = zynqmp_pm_clock_getparent, };
>>> +
>> Instead of introducing all these in oneshot, add them as you have users of it.
>> IOW, show the users of these functions in the series. Also I asked to split this
>> into functional changes like clock, pinctrl, power, etc.
> 
> It can be split into functional changes in same series but it will be
> difficult to split between users as there are more than 10 driver
> users for different EEMI APIs and also multiple driver users using
> specifc EEMI APIs. They all can't be submitted as single series.
> 

Why ? Start with basic EEMI and one functionality with it's user/client
driver in one series. Then you can top up with EEMI changes for other
functionality with it's user. If you introduce API's without the users
in a series it's hard to review and if there are more such unused APIs
I will object it in future versions.

To start with add only clock or power APIs and functionality in this
series, add drivers using then. Drop other functionalities like pinctrl,
fpga control and other functionalities. IOW start something basic and
simple.

-- 
Regards,
Sudeep
