Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5990C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F022504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8F022504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbeKMDni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:43:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14649 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbeKMDni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:43:38 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D1206B4BF807;
        Tue, 13 Nov 2018 01:49:19 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 13 Nov 2018
 01:49:14 +0800
Subject: Re: [PATCH] scsi: libsas: Remove pcidev reference
To:     Joe Perches <joe@perches.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1542043689-214071-1-git-send-email-john.garry@huawei.com>
 <584e7b4fcd6f95fe0c581f6f9472852685c754d1.camel@perches.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <310504a2-f33c-183b-d00a-fa067b273dfd@huawei.com>
Date:   Mon, 12 Nov 2018 17:49:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <584e7b4fcd6f95fe0c581f6f9472852685c754d1.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 17:32, Joe Perches wrote:
> On Tue, 2018-11-13 at 01:28 +0800, John Garry wrote:
>> Not all host drivers are PCI drivers - like hisi_sas, which supports a
>> platform driver - so remove reference to "pcidev".
>>
>> The debug level is also downgraded to KERN_ERR for the same message.
> []
>> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> []
>> @@ -186,7 +186,7 @@ int sas_notify_lldd_dev_found(struct domain_device *dev)
>>
>>  	res = i->dft->lldd_dev_found(dev);
>>  	if (res) {
>> -		printk("sas: driver on pcidev %s cannot handle "
>> +		pr_err("sas: driver on host %s cannot handle "
>>  		       "device %llx, error:%d\n",
>
> As a printk without a KERN_<LEVEL> is printed at whatever
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT is set to (default: 4 and
> rarely unchanged), this is effectively upgraded from a
> KERN_WARNING to KERN_ERR.

ah, I thought that it was printed always.

So maybe I'll just leave as-is.

Thanks,
John

>
>
>
> .
>


