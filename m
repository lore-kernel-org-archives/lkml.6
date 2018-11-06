Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61956C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D74F20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YS3wKV4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D74F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbeKGARa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:17:30 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34664 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbeKGAR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:17:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA6EpnAq024842;
        Tue, 6 Nov 2018 08:51:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541515909;
        bh=GYQ0MFXS1TtNLqvUbBGA4h/Z95rKTg82ie2Ax0W2iRc=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=YS3wKV4mRSsuEfMEtS55nSvr0OBW33qKbmq/6Lsapw+JG2CXebguqz2L+zFcQwhRM
         MNGFR2Ud+VIsICIii21g7HmPqisruR3Lix7DB6toRxwE09bByQO/o9SS4kBefkakgE
         ewGMT5Sqq5wJrHCIQDdUoyJ1wdNNW3O1N0VlQIWw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA6EpnOZ126640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 08:51:49 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 08:51:49 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 08:51:49 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA6EpkvO025162;
        Tue, 6 Nov 2018 08:51:47 -0600
Subject: Re: [RFC PATCH v1 14/14] usb:cdns3: Feature for changing role
To:     Pawel Laszczak <pawell@cadence.com>, <gregkh@linuxfoundation.org>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
 <1541267487-3664-15-git-send-email-pawell@cadence.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BE1AA81.3030107@ti.com>
Date:   Tue, 6 Nov 2018 16:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1541267487-3664-15-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/18 19:51, Pawel Laszczak wrote:
> Patch adds feature that allow to change role from user space.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Makefile  |  2 +-
>  drivers/usb/cdns3/core.c    |  2 +
>  drivers/usb/cdns3/debugfs.c | 94 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/cdns3/drd.h     |  3 ++
>  4 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/cdns3/debugfs.c
> 
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index 34e60d03c4ec..08e6cdbebd46 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -1,7 +1,7 @@
>  obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
>  
> -cdns3-y					:= core.o drd.o
> +cdns3-y					:= core.o drd.o debugfs.o
>  cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o debug.o
>  cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
>  cdns3-pci-y		 		:= cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 20ae9e76940e..4012f1007da9 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -309,6 +309,7 @@ static int cdns3_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err4;
>  
> +	cdns3_debugfs_init(cdns);
>  	device_set_wakeup_capable(dev, true);
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> @@ -346,6 +347,7 @@ static int cdns3_remove(struct platform_device *pdev)
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> +	cdns3_debugfs_exit(cdns);
>  	cdns3_remove_roles(cdns);
>  	usb_phy_shutdown(cdns->usbphy);
>  
> diff --git a/drivers/usb/cdns3/debugfs.c b/drivers/usb/cdns3/debugfs.c
> new file mode 100644
> index 000000000000..d4871bc1a69d
> --- /dev/null
> +++ b/drivers/usb/cdns3/debugfs.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Controller DebugFS filer.
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/uaccess.h>
> +
> +#include "core.h"
> +#include "gadget.h"
> +
> +static int cdns3_mode_show(struct seq_file *s, void *unused)
> +{
> +	struct cdns3		*cdns = s->private;
> +
> +	switch (cdns->role) {
> +	case CDNS3_ROLE_HOST:
> +		seq_puts(s, "host\n");
> +		break;
> +	case CDNS3_ROLE_GADGET:
> +		seq_puts(s, "device\n");
> +		break;
> +	case CDNS3_ROLE_OTG:
> +	case CDNS3_ROLE_END:
> +		seq_puts(s, "otg\n");
> +		break;
> +	default:
> +		seq_puts(s, "UNKNOWN mode\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns3_mode_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, cdns3_mode_show, inode->i_private);
> +}
> +
> +static ssize_t cdns3_mode_write(struct file *file,
> +				const char __user *ubuf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct seq_file		*s = file->private_data;
> +	struct cdns3		*cdns = s->private;
> +	u32			mode = 0;
> +	char			buf[32];
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (!strncmp(buf, "host", 4))
> +		mode = USB_DR_MODE_HOST;
> +
> +	if (!strncmp(buf, "device", 6))
> +		mode = USB_DR_MODE_PERIPHERAL;
> +
> +	if (!strncmp(buf, "otg", 3))
> +		mode = USB_DR_MODE_OTG;
> +
> +	cdns->desired_role = mode;
> +	queue_work(system_freezable_wq, &cdns->role_switch_wq);

If we start with OTG mode and user says change mode to device will we still
switch to host based on ID pin change?

If it does then this isn't working correctly.
We need to stop processing ID interrupts and keep the role static till
the user switches it back to otg.

> +	return count;
> +}
> +
> +static const struct file_operations cdns3_mode_fops = {
> +	.open			= cdns3_mode_open,
> +	.write			= cdns3_mode_write,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +void cdns3_debugfs_init(struct cdns3 *cdns)
> +{
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir(dev_name(cdns->dev), NULL);
> +	cdns->root = root;
> +	if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET) &&
> +	    IS_ENABLED(CONFIG_USB_CDNS3_HOST))
> +		debugfs_create_file("mode", 0644, root, cdns,
> +				    &cdns3_mode_fops);
> +}
> +
> +void cdns3_debugfs_exit(struct cdns3 *cdns)
> +{
> +	debugfs_remove_recursive(cdns->root);
> +}
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index 85731f3b693c..5344290c76f2 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -119,4 +119,7 @@ int cdns3_drd_probe(struct cdns3 *cdns);
>  void cdns3_set_hw_mode(struct cdns3 *cdns, u32 mode);
>  irqreturn_t cdns3_drd_irq(struct cdns3 *cdns);
>  
> +void cdns3_debugfs_init(struct cdns3 *cdns);
> +void cdns3_debugfs_exit(struct cdns3 *cdns);
> +
>  #endif /* __LINUX_CDNS3_DRD */
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
