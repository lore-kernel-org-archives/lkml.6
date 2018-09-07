Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED48C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DB720861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DB720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIGO4L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:56:11 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:45210 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbeIGO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:56:11 -0400
X-ASG-Debug-ID: 1536315340-093b7e54e6096e0001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id OBR84lqO5vpvD9gN (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 07 Sep 2018 18:15:40 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Sep 2018 18:15:44 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Fri, 7 Sep 2018 18:15:44 +0800
From:   "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To:     Ran Wang <ran.wang_1@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Thread-Topic: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
X-ASG-Orig-Subj: Re: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Thread-Index: AQHUQN7BocIUUTAFlkap4qeCxrnE2A==
Date:   Fri, 7 Sep 2018 10:15:43 +0000
Message-ID: <35f171989af34850bd192c2b4de9b43b@HXTBJIDCEMVIW02.hxtcorp.net>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <366f03eab44e489b9fef82fb8e8f3c3b@HXTBJIDCEMVIW02.hxtcorp.net>
 <AM5PR0402MB2865774C03981F9808AB3A13F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.85]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1536315340
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.57055
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/7 16:49, Ran Wang wrote:
> Hi Dongsheng
>
>> On 2018/9/5 11:05, Dongsheng Wang wrote:
>>
>> Please change your comments style.
>>
>> On 2018/8/31 11:57, Ran Wang wrote:
>>> This driver is to provide a independent framework for PM service
>>> provider and consumer to configure system level wake up feature. For
>>> example, RCPM driver could register a callback function on this
>>> platform first, and Flex timer driver who want to enable timer wake up
>>> feature, will call generic API provided by this platform driver, and
>>> then it will trigger RCPM driver to do it. The benefit is to isolate
>>> the user and service, such as flex timer driver will not have to know
>>> the implement details of wakeup function it require. Besides, it is
>>> also easy for service side to upgrade its logic when design is changed
>>> and remain user side unchanged.
>>>
>>> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
>>> ---
>>>  drivers/soc/fsl/Kconfig   |   14 +++++
>>>  drivers/soc/fsl/Makefile  |    1 +
>>>  drivers/soc/fsl/plat_pm.c |  144
>> +++++++++++++++++++++++++++++++++++++++++++++
>>>  include/soc/fsl/plat_pm.h |   22 +++++++
>>>  4 files changed, 181 insertions(+), 0 deletions(-)  create mode
>>> 100644 drivers/soc/fsl/plat_pm.c  create mode 100644
>>> include/soc/fsl/plat_pm.h
>>>
>>> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
>>> 7a9fb9b..6517412 100644
>>> --- a/drivers/soc/fsl/Kconfig
>>> +++ b/drivers/soc/fsl/Kconfig
>>> @@ -16,3 +16,17 @@ config FSL_GUTS
>>>  	  Initially only reading SVR and registering soc device are supported.
>>>  	  Other guts accesses, such as reading RCW, should eventually be
>> moved
>>>  	  into this driver as well.
>>> +
>>> +config FSL_PLAT_PM
>>> +	bool "Freescale platform PM framework"
>>> +	help
>>> +	  This driver is to provide a independent framework for PM service
>>> +	  provider and consumer to configure system level wake up feature.
>> For
>>> +	  example, RCPM driver could register a callback function on this
>>> +	  platform first, and Flex timer driver who want to enable timer wake
>>> +	  up feature, will call generic API provided by this platform driver,
>>> +	  and then it will trigger RCPM driver to do it. The benefit is to
>>> +	  isolate the user and service, such as  flex timer driver will not
>>> +	  have to know the implement details of wakeup function it require.
>>> +	  Besides, it is also easy for service side to upgrade its logic when
>>> +	  design changed and remain user side unchanged.
>>> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile index
>>> 44b3beb..8f9db23 100644
>>> --- a/drivers/soc/fsl/Makefile
>>> +++ b/drivers/soc/fsl/Makefile
>>> @@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
>>>  obj-$(CONFIG_QUICC_ENGINE)		+= qe/
>>>  obj-$(CONFIG_CPM)			+= qe/
>>>  obj-$(CONFIG_FSL_GUTS)			+= guts.o
>>> +obj-$(CONFIG_FSL_PLAT_PM)	+= plat_pm.o
>>> diff --git a/drivers/soc/fsl/plat_pm.c b/drivers/soc/fsl/plat_pm.c new
>>> file mode 100644 index 0000000..19ea14e
>>> --- /dev/null
>>> +++ b/drivers/soc/fsl/plat_pm.c
>>> @@ -0,0 +1,144 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// plat_pm.c - Freescale platform PM framework // // Copyright 2018
>>> +NXP // // Author: Ran Wang <ran.wang_1@nxp.com>,
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/device.h>
>>> +#include <linux/list.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/err.h>
>>> +#include <soc/fsl/plat_pm.h>
>>> +
>>> +
>>> +struct plat_pm_t {
>>> +	struct list_head node;
>>> +	fsl_plat_pm_handle handle;
>>> +	void *handle_priv;
>>> +	spinlock_t	lock;
>>> +};
>>> +
>>> +static struct plat_pm_t plat_pm;
>>> +
>>> +// register_fsl_platform_wakeup_source - Register callback function
>>> +to plat_pm // @handle: Pointer to handle PM feature requirement //
>>> +@handle_priv: Handler specific data struct // // Return 0 on success
>>> +other negative errno int
>>> +register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
>>> +		void *handle_priv)
>>> +{
>>> +	struct plat_pm_t *p;
>>> +	unsigned long	flags;
>>> +
>>> +	if (!handle) {
>>> +		pr_err("FSL plat_pm: Handler invalid, reject\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	p = kmalloc(sizeof(*p), GFP_KERNEL);
>>> +	if (!p)
>>> +		return -ENOMEM;
>>> +
>>> +	p->handle = handle;
>>> +	p->handle_priv = handle_priv;
>>> +
>>> +	spin_lock_irqsave(&plat_pm.lock, flags);
>>> +	list_add_tail(&p->node, &plat_pm.node);
>>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(register_fsl_platform_wakeup_source);
>>> +
>>> +// Deregister_fsl_platform_wakeup_source - deregister callback
>>> +function // @handle_priv: Handler specific data struct // // Return 0
>>> +on success other negative errno int
>>> +deregister_fsl_platform_wakeup_source(void *handle_priv) {
>>> +	struct plat_pm_t *p, *tmp;
>>> +	unsigned long	flags;
>>> +
>>> +	spin_lock_irqsave(&plat_pm.lock, flags);
>>> +	list_for_each_entry_safe(p, tmp, &plat_pm.node, node) {
>>> +		if (p->handle_priv == handle_priv) {
>>> +			list_del(&p->node);
>>> +			kfree(p);
>>> +		}
>>> +	}
>>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(deregister_fsl_platform_wakeup_source);
>>> +
>>> +// fsl_platform_wakeup_config - Configure wakeup source by calling
>>> +handlers // @dev: pointer to user's device struct // @flag: to tell
>>> +enable or disable wakeup source // // Return 0 on success other
>>> +negative errno int fsl_platform_wakeup_config(struct device *dev,
>>> +bool flag) {
>>> +	struct plat_pm_t *p;
>>> +	int ret;
>>> +	bool success_handled;
>>> +	unsigned long	flags;
>>> +
>>> +	success_handled = false;
>>> +
>>> +	// Will consider success if at least one callback return 0.
>>> +	// Also, rest handles still get oppertunity to be executed
>>> +	spin_lock_irqsave(&plat_pm.lock, flags);
>>> +	list_for_each_entry(p, &plat_pm.node, node) {
>>> +		if (p->handle) {
>>> +			ret = p->handle(dev, flag, p->handle_priv);
>>> +			if (!ret)
>>> +				success_handled = true;
>> Miss a break?
> Actually my idea is to allow more than one registered handler to handle this
> request, so I define a flag rather than return to indicated if there is at least one handler successfully
> do it. This design might give more flexibility to framework when running.
There is only one flag(success_handled) here, how did know which handler
failed?

BTW, I don't think we need this flag. We can only use the return value.

Cheers,
Dongsheng

>>> +			else if (ret != -ENODEV) {
>>> +				pr_err("FSL plat_pm: Failed to config wakeup
>> source:%d\n", ret);
>> Please unlock before return.
> Yes, will fix it in next version, thanks for pointing out!
>
>>> +				return ret;
>>> +			}
>>> +		} else
>>> +			pr_warn("FSL plat_pm: Invalid handler detected,
>> skip\n");
>>> +	}
>>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
>>> +
>>> +	if (success_handled == false) {
>>> +		pr_err("FSL plat_pm: Cannot find the matchhed handler for
>> wakeup source config\n");
>>> +		return -ENODEV;
>>> +	}
>> Add this into the loop.
> My design is that if the 1st handler return -ENODEV to indicated this device it doesn't support, 
> then the framework will continue try 2nd handler...
>
> So I think it is needed to place this checking out of loop, what do you say?
>
> Regards,
> Ran
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +// fsl_platform_wakeup_enable - Enable wakeup source // @dev: pointer
>>> +to user's device struct // // Return 0 on success other negative
>>> +errno int fsl_platform_wakeup_enable(struct device *dev) {
>>> +	return fsl_platform_wakeup_config(dev, true); }
>>> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_enable);
>>> +
>>> +// fsl_platform_wakeup_disable - Disable wakeup source // @dev:
>>> +pointer to user's device struct // // Return 0 on success other
>>> +negative errno int fsl_platform_wakeup_disable(struct device *dev) {
>>> +	return fsl_platform_wakeup_config(dev, false); }
>>> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_disable);
>>> +
>>> +static int __init fsl_plat_pm_init(void) {
>>> +	spin_lock_init(&plat_pm.lock);
>>> +	INIT_LIST_HEAD(&plat_pm.node);
>>> +	return 0;
>>> +}
>>> +
>>> +core_initcall(fsl_plat_pm_init);
>>> diff --git a/include/soc/fsl/plat_pm.h b/include/soc/fsl/plat_pm.h new
>>> file mode 100644 index 0000000..bbe151e
>>> --- /dev/null
>>> +++ b/include/soc/fsl/plat_pm.h
>>> @@ -0,0 +1,22 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// plat_pm.h - Freescale platform PM Header // // Copyright 2018 NXP
>>> +// // Author: Ran Wang <ran.wang_1@nxp.com>,
>>> +
>>> +#ifndef __FSL_PLAT_PM_H
>>> +#define __FSL_PLAT_PM_H
>>> +
>>> +typedef int (*fsl_plat_pm_handle)(struct device *dev, bool flag,
>>> +		void *handle_priv);
>>> +
>>> +int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
>>> +		void *handle_priv);
>>> +int deregister_fsl_platform_wakeup_source(void *handle_priv); int
>>> +fsl_platform_wakeup_config(struct device *dev, bool flag); int
>>> +fsl_platform_wakeup_enable(struct device *dev); int
>>> +fsl_platform_wakeup_disable(struct device *dev);
>>> +
>>> +#endif	// __FSL_PLAT_PM_H
>

