Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE208C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA7F21EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA7F21EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbeHISxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:53:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732411AbeHISxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:53:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w79GOcJJ073512
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 12:27:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2krs0j8bxy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 12:27:24 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 9 Aug 2018 17:27:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 17:27:19 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w79GRHuZ40632454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 16:27:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E2942049;
        Thu,  9 Aug 2018 19:27:25 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E11784203F;
        Thu,  9 Aug 2018 19:27:24 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 19:27:24 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v8 09/22] s390: vfio-ap: register matrix device with VFIO
 mdev framework
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-10-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180809130607.32781b72.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 9 Aug 2018 18:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809130607.32781b72.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080916-0020-0000-0000-000002B47A4E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080916-0021-0000-0000-000021018F35
Message-Id: <e52ee356-bb7b-f672-1c9c-5b1b84775a2d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2018 13:06, Cornelia Huck wrote:
> On Wed,  8 Aug 2018 10:44:19 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index d7e39ad..6a827f3 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/slab.h>
>>   #include <linux/string.h>
>> +#include <asm/zcrypt.h>
>>   #include "vfio_ap_private.h"
>>   
>>   #define VFIO_AP_ROOT_NAME "vfio_ap"
>> @@ -68,6 +69,18 @@ static int vfio_ap_matrix_dev_create(void)
>>   {
>>   	int ret;
>>   
>> +	mutex_init(&matrix_dev.lock);
>> +	INIT_LIST_HEAD(&matrix_dev.mdev_list);
>> +
>> +	/* Test if PQAP(QCI) instruction is available */
>> +	if (test_facility(12)) {
>> +		ret = ap_qci(&matrix_dev.info);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	atomic_set(&matrix_dev.available_instances, MAX_ZDEV_ENTRIES_EXT);
>> +
>>   	ret = misc_register(&matrix_dev.misc_dev);
> OK, you are adding more stuff other than the miscdevice after all...
> still, I don't think that this is a good idea.
>
> I think I had already asked this for a previous version: Why has this
> been turned into a miscdevice? (I think my reaction to the answer was
> 'meh'... but I think more and more that we should not do that.)

Following our off-line conversation...

I understand your concern, about the misc device and dynamically
updating the misc device structure.

For it is your main point of contention and we do not currently have
a use case for the misc device I propose we just let it go and
rebase on the device design we had in V6 and did not seem to
make any trouble to any one.

We will propose a v9 with the integration of all comment done
so far soon as possible.


Best regards,

Pierre


>
>>   	if (ret)
>>   		return ret;


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

