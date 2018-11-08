Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1E1ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D162086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D162086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeKHX6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:58:49 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59270 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHX6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:58:49 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8EN0sr086106;
        Thu, 8 Nov 2018 08:23:00 -0600
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8EMx05081752
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 08:23:00 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 08:22:59 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 08:22:59 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8EMvRc003140;
        Thu, 8 Nov 2018 08:22:57 -0600
Subject: Re: [RFC PATCH v1 14/14] usb:cdns3: Feature for changing role
To:     Pawel Laszczak <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-15-git-send-email-pawell@cadence.com>
 <5BE1AA81.3030107@ti.com>
 <BYAPR07MB4709524FC194D27BE6128ABADDC50@BYAPR07MB4709.namprd07.prod.outlook.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BE446C0.6080706@ti.com>
Date:   Thu, 8 Nov 2018 16:22:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB4709524FC194D27BE6128ABADDC50@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/18 13:51, Pawel Laszczak wrote:
>> On 03/11/18 19:51, Pawel Laszczak wrote:
>>> Patch adds feature that allow to change role from user space.
>>>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> ---
>>>  drivers/usb/cdns3/Makefile  |  2 +-
>>>  drivers/usb/cdns3/core.c    |  2 +
>>>  drivers/usb/cdns3/debugfs.c | 94 +++++++++++++++++++++++++++++++++++++
>>>  drivers/usb/cdns3/drd.h     |  3 ++
>>>  4 files changed, 100 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/usb/cdns3/debugfs.c
>>>
>>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>>> index 34e60d03c4ec..08e6cdbebd46 100644
>>> --- a/drivers/usb/cdns3/Makefile
>>> +++ b/drivers/usb/cdns3/Makefile
>>> @@ -1,7 +1,7 @@
>>>  obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
>>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
>>>
>>> -cdns3-y					:= core.o drd.o
>>> +cdns3-y					:= core.o drd.o debugfs.o
>>>  cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o debug.o
>>>  cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
>>>  cdns3-pci-y		 		:= cdns3-pci-wrap.o
>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>> index 20ae9e76940e..4012f1007da9 100644
>>> --- a/drivers/usb/cdns3/core.c
>>> +++ b/drivers/usb/cdns3/core.c
>>> @@ -309,6 +309,7 @@ static int cdns3_probe(struct platform_device *pdev)
>>>  	if (ret)
>>>  		goto err4;
>>>
>>> +	cdns3_debugfs_init(cdns);
>>>  	device_set_wakeup_capable(dev, true);
>>>  	pm_runtime_set_active(dev);
>>>  	pm_runtime_enable(dev);
>>> @@ -346,6 +347,7 @@ static int cdns3_remove(struct platform_device *pdev)
>>>  	pm_runtime_get_sync(&pdev->dev);
>>>  	pm_runtime_disable(&pdev->dev);
>>>  	pm_runtime_put_noidle(&pdev->dev);
>>> +	cdns3_debugfs_exit(cdns);
>>>  	cdns3_remove_roles(cdns);
>>>  	usb_phy_shutdown(cdns->usbphy);
>>>
>>> diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
>>> new file mode 100644
>>> index 000000000000..d4871bc1a69d
>>> --- /dev/null
>>> +++ b/drivers/usb/cdns3/debugfs.c
>>> @@ -0,0 +1,94 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Cadence USBSS DRD Controller DebugFS filer.
>>> + *
>>> + * Copyright (C) 2018 Cadence.
>>> + *
>>> + * Author: Pawel Laszczak <pawell@cadence.com>
>>> + */
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/debugfs.h>
>>> +#include <linux/seq_file.h>
>>> +#include <linux/uaccess.h>
>>> +
>>> +#include "core.h"
>>> +#include "gadget.h"
>>> +
>>> +static int cdns3_mode_show(struct seq_file *s, void *unused)
>>> +{
>>> +	struct cdns3		*cdns = s->private;
>>> +
>>> +	switch (cdns->role) {
>>> +	case CDNS3_ROLE_HOST:
>>> +		seq_puts(s, "host\n");
>>> +		break;
>>> +	case CDNS3_ROLE_GADGET:
>>> +		seq_puts(s, "device\n");
>>> +		break;
>>> +	case CDNS3_ROLE_OTG:
>>> +	case CDNS3_ROLE_END:
>>> +		seq_puts(s, "otg\n");
>>> +		break;
>>> +	default:
>>> +		seq_puts(s, "UNKNOWN mode\n");
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int cdns3_mode_open(struct inode *inode, struct file *file)
>>> +{
>>> +	return single_open(file, cdns3_mode_show, inode->i_private);
>>> +}
>>> +
>>> +static ssize_t cdns3_mode_write(struct file *file,
>>> +				const char __user *ubuf,
>>> +				size_t count, loff_t *ppos)
>>> +{
>>> +	struct seq_file		*s = file->private_data;
>>> +	struct cdns3		*cdns = s->private;
>>> +	u32			mode = 0;
>>> +	char			buf[32];
>>> +
>>> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
>>> +		return -EFAULT;
>>> +
>>> +	if (!strncmp(buf, "host", 4))
>>> +		mode = USB_DR_MODE_HOST;
>>> +
>>> +	if (!strncmp(buf, "device", 6))
>>> +		mode = USB_DR_MODE_PERIPHERAL;
>>> +
>>> +	if (!strncmp(buf, "otg", 3))
>>> +		mode = USB_DR_MODE_OTG;
>>> +
>>> +	cdns->desired_role = mode;
>>> +	queue_work(system_freezable_wq, &cdns->role_switch_wq);
>>
>> If we start with OTG mode and user says change mode to device will we still
>> switch to host based on ID pin change?
>>
>> If it does then this isn't working correctly.
>> We need to stop processing ID interrupts and keep the role static till
>> the user switches it back to otg.
> 
> Switching role form user space will limited driver only to selected mode. 
> Only for USB_DR_MODE_OTG driver should base on ID pin. 
> That's my intension.
> 

User space setting should override ID if it was OTG mode. At least this is how
it is for dwc3. That way it is useful for testing role swap.

cheers,
-roger

>>> +	return count;
>>> +}
>>> +
>>> +static const struct file_operations cdns3_mode_fops = {
>>> +	.open			= cdns3_mode_open,
>>> +	.write			= cdns3_mode_write,
>>> +	.read			= seq_read,
>>> +	.llseek			= seq_lseek,
>>> +	.release		= single_release,
>>> +};
>>> +
>>> +void cdns3_debugfs_init(struct cdns3 *cdns)
>>> +{
>>> +	struct dentry *root;
>>> +
>>> +	root = debugfs_create_dir(dev_name(cdns->dev), NULL);
>>> +	cdns->root = root;
>>> +	if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
>>> +	    IS_ENABLED(CONFIG_USB_CDNS3_HOST))
>>> +		debugfs_create_file("mode", 0644, root, cdns,
>>> +				    &cdns3_mode_fops);
>>> +}
>>> +
>>> +void cdns3_debugfs_exit(struct cdns3 *cdns)
>>> +{
>>> +	debugfs_remove_recursive(cdns->root);
>>> +}
>>> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
>>> index 85731f3b693c..5344290c76f2 100644
>>> --- a/drivers/usb/cdns3/drd.h
>>> +++ b/drivers/usb/cdns3/drd.h
>>> @@ -119,4 +119,7 @@ int cdns3_drd_probe(struct cdns3 *cdns);
>>>  void cdns3_set_hw_mode(struct cdns3 *cdns, u32 mode);
>>>  irqreturn_t cdns3_drd_irq(struct cdns3 *cdns);
>>>
>>> +void cdns3_debugfs_init(struct cdns3 *cdns);
>>> +void cdns3_debugfs_exit(struct cdns3 *cdns);
>>> +
>>>  #endif /* __LINUX_CDNS3_DRD */
>>>
>>
>> cheers,
>> -roger
>> --
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> 
> Thanks,
> Cheers,
> Pawel
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
