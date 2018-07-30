Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C2C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F6B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F6B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeGaAxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:53:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:14706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732038AbeGaAxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:53:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 16:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,425,1526367600"; 
   d="scan'208";a="60751514"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.149]) ([10.7.153.149])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2018 16:15:45 -0700
Subject: Re: [PATCH v7 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        darrick.wong@oracle.com, sandeen@redhat.com,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        kusumi.tomohiro@gmail.com, bryantly@linux.vnet.ibm.com,
        fbarrat@linux.vnet.ibm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod <vkoul@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        david.kershner@unisys.com,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jgross@suse.com,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
 <20180723214751.1733-9-jae.hyun.yoo@linux.intel.com>
 <20180727082611.GE4628@dell>
 <acffdfef-cb20-4208-5297-d94bac5ecb1b@linux.intel.com>
 <CAL_JsqL7WkDOaegwmBDqLkRh0JfCo7O2krONVstjWMUsLiJMrg@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <7ab43253-1154-6e2f-b216-69b0d44b470a@linux.intel.com>
Date:   Mon, 30 Jul 2018 16:15:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL7WkDOaegwmBDqLkRh0JfCo7O2krONVstjWMUsLiJMrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/30/2018 3:10 PM, Rob Herring wrote:
> On Fri, Jul 27, 2018 at 11:36 AM Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> Hi Lee,
>>
>> On 7/27/2018 1:26 AM, Lee Jones wrote:
>>> On Mon, 23 Jul 2018, Jae Hyun Yoo wrote:
>>>
>>>> This commit adds PECI client MFD driver.
>>>>
>>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Andrew Jeffery <andrew@aj.id.au>
>>>> Cc: James Feist <james.feist@linux.intel.com>
>>>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>>>> Cc: Joel Stanley <joel@jms.id.au>
>>>> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
>>>> ---
>>>>    drivers/mfd/Kconfig                   |  14 ++
>>>>    drivers/mfd/Makefile                  |   1 +
>>>>    drivers/mfd/intel-peci-client.c       | 182 ++++++++++++++++++++++++++
>>>>    include/linux/mfd/intel-peci-client.h |  81 ++++++++++++
>>>>    4 files changed, 278 insertions(+)
>>>>    create mode 100644 drivers/mfd/intel-peci-client.c
>>>>    create mode 100644 include/linux/mfd/intel-peci-client.h
>>>>
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index f3fa516011ec..e38b591479d4 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -595,6 +595,20 @@ config MFD_INTEL_MSIC
>>>>         Passage) chip. This chip embeds audio, battery, GPIO, etc.
>>>>         devices used in Intel Medfield platforms.
>>>>
>>>> +config MFD_INTEL_PECI_CLIENT
>>>> +    bool "Intel PECI client"
>>>> +    depends on (PECI || COMPILE_TEST)
>>>> +    select MFD_CORE
>>>> +    help
>>>> +      If you say yes to this option, support will be included for the
>>>> +      multi-funtional Intel PECI (Platform Environment Control Interface)
>>>> +      client. PECI is a one-wire bus interface that provides a communication
>>>> +      channel from PECI clients in Intel processors and chipset components
>>>> +      to external monitoring or control devices.
>>>> +
>>>> +      Additional drivers must be enabled in order to use the functionality
>>>> +      of the device.
>>>> +
>>>>    config MFD_IPAQ_MICRO
>>>>       bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>>>>       depends on SA1100_H3100 || SA1100_H3600
>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>> index 2852a6042ecf..29e2cacc58bd 100644
>>>> --- a/drivers/mfd/Makefile
>>>> +++ b/drivers/mfd/Makefile
>>>> @@ -203,6 +203,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)     += intel-lpss.o
>>>>    obj-$(CONFIG_MFD_INTEL_LPSS_PCI)   += intel-lpss-pci.o
>>>>    obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)  += intel-lpss-acpi.o
>>>>    obj-$(CONFIG_MFD_INTEL_MSIC)       += intel_msic.o
>>>> +obj-$(CONFIG_MFD_INTEL_PECI_CLIENT) += intel-peci-client.o
>>>>    obj-$(CONFIG_MFD_PALMAS)   += palmas.o
>>>>    obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>>>>    obj-$(CONFIG_MFD_RC5T583)  += rc5t583.o rc5t583-irq.o
>>>> diff --git a/drivers/mfd/intel-peci-client.c b/drivers/mfd/intel-peci-client.c
>>>> new file mode 100644
>>>> index 000000000000..d7702cf1ea50
>>>> --- /dev/null
>>>> +++ b/drivers/mfd/intel-peci-client.c
>>>> @@ -0,0 +1,182 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +// Copyright (c) 2018 Intel Corporation
>>>> +
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/mfd/core.h>
>>>> +#include <linux/mfd/intel-peci-client.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/peci.h>
>>>> +#include <linux/of_device.h>
>>>> +
>>>> +enum cpu_gens {
>>>> +    CPU_GEN_HSX = 0, /* Haswell Xeon */
>>>> +    CPU_GEN_BRX,     /* Broadwell Xeon */
>>>> +    CPU_GEN_SKX,     /* Skylake Xeon */
>>>> +};
>>>> +
>>>> +static struct mfd_cell peci_functions[] = {
>>>> +    {
>>>> +            .name = "peci-cputemp",
>>>> +            .of_compatible = "intel,peci-cputemp",
>>>> +    },
>>>> +    {
>>>> +            .name = "peci-dimmtemp",
>>>> +            .of_compatible = "intel,peci-dimmtemp",
>>>> +    },
>>>> +};
>>>
>>> The more I look at this driver, the less I think it fits into MFD.
>>>
>>> What's stopping you from registering these devices directly from DT?
>>>
>>
>> Because DT doesn't allow 2 nodes at the same address so Rob suggested
>> MFD for this case.
> 
> Only after I first suggested you create cpu and dimm sensors from a
> single hwmon driver. Perhaps you should figure out how to fix the
> problem with delayed registration. Perhaps you can register the
> sensor, but just delay returning actual data until it is ready.
> 

The actual reason why I divided the single hwmon driver into two is for
using recommended hwmon API set which doesn't allow incremental
creation of sysfs attributes at run time - using of
'devm_hwmon_device_register_with_info' is suggested by Guenter instead
of using other deprecated APIs.

The reason why the delayed registration is needed is, BMC kernel cannot
know how many DIMM are installed in remote machine before the machine
completing memory training and testing in POST. So dimm temp driver
cannot create hwmon attributes in advance.

My thought is, this way is the best to address these requirements.

Thanks,

Jae

> Rob
> 
