Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0FDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F77F20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 04:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WN0NLSKs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AjdmjNKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F77F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeH3IzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 04:55:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39688 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeH3IzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 04:55:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E30096063F; Thu, 30 Aug 2018 04:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535604892;
        bh=BksG3ksxt16HMUtad3ITcOlP2EiTGDtoFzbMKG5xHOk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WN0NLSKsQRxYEmFfY9dJrrh8o5135/QajgAVECpqaabOK8tU4SgAIUz1UvMoM4FW/
         Hj1oJs+Kten4FpGhMcnOHsLbGw10t1dE8f5L/HgMwG3CsYfJvJuyh4or0u2qavlWxG
         OeVSkF0MHNYRPHf6GyJr4ImVPVvJEsMe/r+ZPnxI=
Received: from [10.206.24.40] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4634560271;
        Thu, 30 Aug 2018 04:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535604891;
        bh=BksG3ksxt16HMUtad3ITcOlP2EiTGDtoFzbMKG5xHOk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AjdmjNKS4q9mCk8tNz0kRyPLkos9dshNh87XRKedoKoF+Q420dMs2hLm8MijMmL1w
         5DPXujU3PUP1BoHCm5h44WwqtoqZHO1ke8LpXUb6CfIECuuVzKTtPja2DWWRfI0T8V
         RzyGD6l5NCdNySewsXsmdRiAQCn+HCjRUqEkw6yk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4634560271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V11 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
To:     Adrian Hunter <adrian.hunter@intel.com>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        riteshh@codeaurora.org
Cc:     stummala@codeaurora.org, linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>
References: <1535517338-26077-1-git-send-email-sayalil@codeaurora.org>
 <1535517338-26077-3-git-send-email-sayalil@codeaurora.org>
 <ec50c4f7-1c46-25ad-b4f2-72f292988751@intel.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <df0327a7-b7da-e1f9-d0ab-bf2165691829@codeaurora.org>
Date:   Thu, 30 Aug 2018 10:24:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ec50c4f7-1c46-25ad-b4f2-72f292988751@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/2018 1:24 PM, Adrian Hunter wrote:
> Cc'ing Joel Becker for any suggestions about configfs
>
> On 29/08/18 07:35, Sayali Lokhande wrote:
>> This patch adds configfs support to provision UFS device at
>> runtime. This feature can be primarily useful in factory or
>> assembly line as some devices may be required to be configured
>> multiple times during initial system development phase.
>> Configuration Descriptors can be written multiple times until
>> bConfigDescrLock attribute is zero.
>>
>> Configuration descriptor buffer consists of Device and Unit
>> descriptor configurable parameters which are parsed from vendor
>> specific provisioning file and then passed via configfs node at
>> runtime to provision ufs device.
>> CONFIG_CONFIGFS_FS and CONFIG_UFS_PROVISION needs to be enabled
>> for using this feature.
>>
>> Usage:
>> 1) To read current configuration descriptor with index X
>>     (where index X can be 0/1/2/3) :
>>     cat /config/XXXX.ufshc/ufs_config_desc_X
>>
>> 2) To write configuration descriptor with index X :
>>     echo <config_desc_buf> > /config/XXXX.ufshc/ufs_config_desc_X
>>
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
>>   Documentation/ABI/testing/configfs-driver-ufs |  12 ++
>>   drivers/scsi/ufs/Kconfig                      |  10 ++
>>   drivers/scsi/ufs/Makefile                     |   1 +
>>   drivers/scsi/ufs/ufs-configfs.c               | 228 ++++++++++++++++++++++++++
>>   drivers/scsi/ufs/ufshcd.c                     |   3 +-
>>   drivers/scsi/ufs/ufshcd.h                     |  17 ++
>>   6 files changed, 270 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/ABI/testing/configfs-driver-ufs
>>   create mode 100644 drivers/scsi/ufs/ufs-configfs.c
>>
>> diff --git a/Documentation/ABI/testing/configfs-driver-ufs b/Documentation/ABI/testing/configfs-driver-ufs
>> new file mode 100644
>> index 0000000..75cfc9e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/configfs-driver-ufs
>> @@ -0,0 +1,12 @@
>> +What:		/config/*/ufs_config_desc_X
>> +Date:		Jun 2018
>> +KernelVersion:	4.19
>> +Description:
>> +		This file shows the current ufs configuration descriptor with
> Should mention that it is in bytes i.e.
>
> 	This file shows the bytes of the ufs configuration descriptor with
Done.
>
>> +		index X (where X = 0/1/2/3) set in device. This can be used to
>> +		provision ufs device if bConfigDescrLock is 0.
>> +		For more details, refer 14.1.6.3 Configuration Descriptor and
>> +		table 14-12 - Unit Descriptor configurable parameters from specs for
>> +		description and format of each configuration descriptor parameter.
>> +		Parameters of Configuration descriptor buffer for respective index
>> +		needs to be passed in space separated format.
> "needs to be passed as bytes in space separated format"
Done.
>> diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
>> index e27b4d4..a9a0a58 100644
>> --- a/drivers/scsi/ufs/Kconfig
>> +++ b/drivers/scsi/ufs/Kconfig
>> @@ -100,3 +100,13 @@ config SCSI_UFS_QCOM
>>   
>>   	  Select this if you have UFS controller on QCOM chipset.
>>   	  If unsure, say N.
>> +
>> +config UFS_PROVISION
>> +	tristate "Runtime UFS Provisioning support"
>> +	depends on SCSI_UFSHCD && CONFIGFS_FS
>> +	help
>> +	  This enables runtime UFS provisioning support. This can be used
>> +	  primarily during assembly line as some devices may be required to
>> +	  be configured multiple times during initial development phase.
>> +
>> +	  If unsure, say N.
>> diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
>> index 918f579..00110ea 100644
>> --- a/drivers/scsi/ufs/Makefile
>> +++ b/drivers/scsi/ufs/Makefile
>> @@ -5,5 +5,6 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-d
>>   obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
>>   obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
>>   ufshcd-core-objs := ufshcd.o ufs-sysfs.o
>> +obj-$(CONFIG_UFS_PROVISION) += ufs-configfs.o
>>   obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
>>   obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
>> diff --git a/drivers/scsi/ufs/ufs-configfs.c b/drivers/scsi/ufs/ufs-configfs.c
>> new file mode 100644
>> index 0000000..a4d26b7
>> --- /dev/null
>> +++ b/drivers/scsi/ufs/ufs-configfs.c
>> @@ -0,0 +1,228 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +// Copyright (c) 2018, Linux Foundation.
>> +
>> +#include <linux/configfs.h>
>> +#include <linux/err.h>
>> +#include <linux/string.h>
>> +
>> +#include "ufs.h"
>> +#include "ufshcd.h"
>> +
>> +static inline struct ufs_hba *config_item_to_hba(struct config_item *item)
>> +{
>> +	struct config_group *group = to_config_group(item);
>> +	struct configfs_subsystem *subsys = to_configfs_subsystem(group);
>> +	struct ufs_hba *hba = container_of(subsys, struct ufs_hba, subsys);
>> +
>> +	return subsys ? hba : NULL;
> 'subsys' won't be null unless 'item' is null, but 'item' is passed by
> configfs, so that won't happen.  i.e. might just as well return 'hba; directly.
Done.
>> +}
>> +
>> +static ssize_t ufs_config_desc_show(struct config_item *item, char *buf,
>> +		u8 index)
>> +{
>> +	struct ufs_hba *hba = config_item_to_hba(item);
>> +	u8 *desc_buf = NULL;
>> +	int desc_buf_len = hba->desc_size.conf_desc;
>> +	int i, ret, curr_len = 0;
>> +
>> +	desc_buf = kmalloc(desc_buf_len, GFP_KERNEL);
>> +	if (!desc_buf)
>> +		return -ENOMEM;
>> +
>> +	memset(desc_buf, 0, desc_buf_len);
> Just use kzalloc
Agree. will update.
>> +
>> +	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
>> +	QUERY_DESC_IDN_CONFIGURATION, index, 0, desc_buf, &desc_buf_len);
> Indenting
Done.
>> +
> Blank line?
Done.
>> +	if (ret)
>> +		return ret;
>> +
>> +	for (i = 0; i < desc_buf_len; i++)
>> +		curr_len += snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
>> +				"0x%x ", desc_buf[i]);
> Free desc_buf
Done.
>> +
>> +	return curr_len;
>> +}
>> +
>> +ssize_t ufshcd_desc_configfs_store(struct config_item *item,
>> +		const char *buf, size_t count, u8 index)
>> +{
>> +	char *strbuf;
>> +	char *strbuf_copy;
>> +	struct ufs_hba *hba = config_item_to_hba(item);
>> +	u8 *desc_buf = NULL;
>> +	int desc_buf_len = hba->desc_size.conf_desc;
>> +	char *token;
>> +	int i, ret, value;
>> +	u32 config_desc_lock = 0;
>> +
>> +	desc_buf = kmalloc(desc_buf_len, GFP_KERNEL);
>> +	if (!desc_buf)
>> +		return -ENOMEM;
>> +
>> +	memset(desc_buf, 0, desc_buf_len);
> Just use kzalloc
Done.
>> +
>> +	/* reserve one byte for null termination */
>> +	strbuf = kmalloc(count + 1, GFP_KERNEL);
>> +	if (!strbuf)
>> +		return -ENOMEM;
>> +
>> +	strbuf_copy = strbuf;
>> +	strlcpy(strbuf, buf, count + 1);
>> +
>> +	/* Just return if bConfigDescrLock is already set */
>> +	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
>> +		QUERY_ATTR_IDN_CONF_DESC_LOCK, 0, 0, &config_desc_lock);
>> +	if (ret)
>> +		goto out;
>> +
>> +	if (config_desc_lock) {
>> +		dev_err(hba->dev, "%s: bConfigDescrLock already set to %u, cannot re-provision device!\n",
>> +		__func__, config_desc_lock);
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	for (i = 0; i < desc_buf_len; i++) {
>> +		token = strsep(&strbuf, " ");
>> +		if (!token && i)
>> +			break;
>> +
>> +		ret = kstrtoint(token, 0, &value);
> Why not unsigned, and also why not check the value is <= 255
will use kstrtou8, which will also in-turn check for <= 255.
>> +		if (ret) {
>> +			dev_err(hba->dev, "%s: kstrtoint failed %d %s\n",
>> +				__func__, ret, token);
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		desc_buf[i] = (u8)value;
>> +	}
>> +
>> +	/* Write configuration descriptor to provision ufs */
>> +	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_WRITE_DESC,
>> +	QUERY_DESC_IDN_CONFIGURATION, index, 0, desc_buf, &desc_buf_len);
> Indenting
Done.
>> +
> Blank line?
Done.
>> +	if (!ret)
>> +		dev_info(hba->dev, "%s: UFS Configuration Descriptor %u written\n",
>> +		__func__, index);
>> +
>> +out:
>> +	kfree(strbuf_copy);
> Please arrange it so that the variable used for kfree is the same as the
> variable assigned to kmalloc.
Agree. will update.
>> +	if (ret)
>> +		return ret;
> Free desc_buf
Done.
>> +	return count;
>> +}
>> +
>> +static ssize_t ufs_config_desc_0_show(struct config_item *item, char *buf)
>> +{
>> +	return ufs_config_desc_show(item, buf, 0);
>> +}
>> +
>> +static ssize_t ufs_config_desc_0_store(struct config_item *item,
>> +		const char *buf, size_t count)
>> +{
>> +	return ufshcd_desc_configfs_store(item, buf, count, 0);
>> +}
>> +
>> +static ssize_t ufs_config_desc_1_show(struct config_item *item, char *buf)
>> +{
>> +	return ufs_config_desc_show(item, buf, 1);
>> +}
>> +
>> +static ssize_t ufs_config_desc_1_store(struct config_item *item,
>> +		const char *buf, size_t count)
>> +{
>> +	return ufshcd_desc_configfs_store(item, buf, count, 1);
>> +}
>> +
>> +static ssize_t ufs_config_desc_2_show(struct config_item *item, char *buf)
>> +{
>> +	return ufs_config_desc_show(item, buf, 2);
>> +}
>> +
>> +static ssize_t ufs_config_desc_2_store(struct config_item *item,
>> +		const char *buf, size_t count)
>> +{
>> +	return ufshcd_desc_configfs_store(item, buf, count, 2);
>> +}
>> +
>> +static ssize_t ufs_config_desc_3_show(struct config_item *item, char *buf)
>> +{
>> +	return ufs_config_desc_show(item, buf, 3);
>> +}
>> +
>> +static ssize_t ufs_config_desc_3_store(struct config_item *item,
>> +		const char *buf, size_t count)
>> +{
>> +	return ufshcd_desc_configfs_store(item, buf, count, 3);
>> +}
>> +
>> +static struct configfs_attribute ufshcd_attr_provision_0 = {
>> +	.ca_name	= "ufs_config_desc_0",
>> +	.ca_mode	= 0644,
>> +	.ca_owner	= THIS_MODULE,
>> +	.show		= ufs_config_desc_0_show,
>> +	.store		= ufs_config_desc_0_store,
>> +};
>> +
>> +static struct configfs_attribute ufshcd_attr_provision_1 = {
>> +	.ca_name	= "ufs_config_desc_1",
>> +	.ca_mode	= 0644,
>> +	.ca_owner	= THIS_MODULE,
>> +	.show		= ufs_config_desc_1_show,
>> +	.store		= ufs_config_desc_1_store,
>> +};
>> +
>> +static struct configfs_attribute ufshcd_attr_provision_2 = {
>> +	.ca_name	= "ufs_config_desc_2",
>> +	.ca_mode	= 0644,
>> +	.ca_owner	= THIS_MODULE,
>> +	.show		= ufs_config_desc_2_show,
>> +	.store		= ufs_config_desc_2_store,
>> +};
>> +
>> +static struct configfs_attribute ufshcd_attr_provision_3 = {
>> +	.ca_name	= "ufs_config_desc_3",
>> +	.ca_mode	= 0644,
>> +	.ca_owner	= THIS_MODULE,
>> +	.show		= ufs_config_desc_3_show,
>> +	.store		= ufs_config_desc_3_store,
>> +};
>> +
>> +static struct configfs_attribute *ufshcd_attrs[] = {
>> +	&ufshcd_attr_provision_0,
>> +	&ufshcd_attr_provision_1,
>> +	&ufshcd_attr_provision_2,
>> +	&ufshcd_attr_provision_3,
>> +	NULL,
>> +};
>> +
>> +static struct config_item_type ufscfg_type = {
>> +	.ct_attrs	= ufshcd_attrs,
>> +	.ct_owner	= THIS_MODULE,
>> +};
>> +
>> +void ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
>> +{
>> +	int ret;
>> +	struct config_item *cg_item;
>> +	struct configfs_subsystem *subsys;
>> +
>> +	cg_item = &hba->subsys.su_group.cg_item;
>> +	sprintf(cg_item->ci_namebuf, "%s", name);
>> +	cg_item->ci_type = &ufscfg_type;
>> +
>> +	subsys = &hba->subsys;
>> +	config_group_init(&subsys->su_group);
>> +	mutex_init(&subsys->su_mutex);
>> +	ret = configfs_register_subsystem(subsys);
>> +	if (ret)
>> +		pr_err("Error %d while registering subsystem %s\n",
>> +		       ret,
>> +		       subsys->su_group.cg_item.ci_namebuf);
>> +}
>> +
>> +void ufshcd_configfs_exit(struct ufs_hba *hba)
>> +{
>> +	configfs_unregister_subsystem(&hba->subsys);
>> +}
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index e01cdc0..608e23e 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -7711,6 +7711,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
>>   void ufshcd_remove(struct ufs_hba *hba)
>>   {
>>   	ufs_sysfs_remove_nodes(hba->dev);
>> +	ufshcd_configfs_exit(hba);
>>   	scsi_remove_host(hba->host);
>>   	/* disable interrupts */
>>   	ufshcd_disable_intr(hba, hba->intr_mask);
>> @@ -7965,7 +7966,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>>   
>>   	async_schedule(ufshcd_async_scan, hba);
>>   	ufs_sysfs_add_nodes(hba->dev);
>> -
>> +	ufshcd_configfs_init(hba, dev_name(hba->dev));
>>   	return 0;
>>   
>>   out_remove_scsi_host:
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
>> index 45013b6..a340ca8 100644
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -37,6 +37,7 @@
>>   #ifndef _UFSHCD_H
>>   #define _UFSHCD_H
>>   
>> +#include <linux/configfs.h>
>>   #include <linux/module.h>
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>> @@ -515,6 +516,9 @@ struct ufs_hba {
>>   
>>   	struct Scsi_Host *host;
>>   	struct device *dev;
>> +#ifdef CONFIG_UFS_PROVISION
>> +	struct configfs_subsystem subsys;
>> +#endif
>>   	/*
>>   	 * This field is to keep a reference to "scsi_device" corresponding to
>>   	 * "UFS device" W-LU.
>> @@ -868,6 +872,19 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
>>   int ufshcd_hold(struct ufs_hba *hba, bool async);
>>   void ufshcd_release(struct ufs_hba *hba);
>>   
>> +/* Expose UFS configfs API's */
>> +#ifndef CONFIG_UFS_PROVISION
>> +static inline void ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
>> +{
>> +}
>> +static inline void ufshcd_configfs_exit(struct ufs_hba *hba)
>> +{
>> +}
>> +#else
>> +void ufshcd_configfs_init(struct ufs_hba *hba, const char *name);
>> +void ufshcd_configfs_exit(struct ufs_hba *hba);
>> +#endif
>> +
>>   int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
>>   	int *desc_length);
>>   
>>

