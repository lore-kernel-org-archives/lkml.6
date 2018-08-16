Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8115DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8BA2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8BA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404095AbeHPTYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:24:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389145AbeHPTYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:24:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7GGOhZf086384
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:24:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kw9mh8egq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:24:44 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 16 Aug 2018 10:24:27 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Aug 2018 10:24:23 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7GGOKJ1983380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Aug 2018 09:24:20 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C6A06A054;
        Thu, 16 Aug 2018 10:24:20 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F8FE6A04F;
        Thu, 16 Aug 2018 10:24:17 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.159.167])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Aug 2018 10:24:17 -0600 (MDT)
Subject: Re: [PATCH v9 09/22] s390: vfio-ap: register matrix device with VFIO
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
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180814131929.37d4b530.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 16 Aug 2018 12:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180814131929.37d4b530.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081616-0036-0000-0000-00000A2402E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009555; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074413; UDB=6.00553681; IPR=6.00854371;
 MB=3.00022758; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-16 16:24:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081616-0037-0000-0000-0000489AD455
Message-Id: <5b77a5e9-6d91-c7a3-5ada-d888735f0488@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808160169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 07:19 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:06 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Registers the matrix device created by the VFIO AP device
>> driver with the VFIO mediated device framework.
>> Registering the matrix device will create the sysfs
>> structures needed to create mediated matrix devices
>> each of which will be used to configure the AP matrix
>> for a guest and connect it to the VFIO AP device driver.
>>
>> Registering the matrix device with the VFIO mediated device
>> framework will create the following sysfs structures:
>>
>> /sys/devices/vfio_ap/matrix/
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ create
>>
>> To create a mediated device for the AP matrix device, write a UUID
>> to the create file:
>>
>> 	uuidgen > create
>>
>> A symbolic link to the mediated device's directory will be created in the
>> devices subdirectory named after the generated $uuid:
>>
>> /sys/devices/vfio_ap/matrix/
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ [devices]
>> ............... [$uuid]
>>
>> A symbolic link to the mediated device will also be created
>> in the vfio_ap matrix's directory:
>>
>> /sys/devices/vfio_ap/matrix/[$uuid]
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   MAINTAINERS                           |    1 +
>>   drivers/s390/crypto/Makefile          |    2 +-
>>   drivers/s390/crypto/vfio_ap_drv.c     |   23 ++++++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  124 +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   45 ++++++++++++
>>   include/uapi/linux/vfio.h             |    1 +
>>   6 files changed, 195 insertions(+), 1 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
>>
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> new file mode 100644
>> index 0000000..8018c2d
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Adjunct processor matrix VFIO device driver callbacks.
>> + *
>> + * Copyright IBM Corp. 2018
>> + *
>> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>> + *	      Halil Pasic <pasic@linux.ibm.com>
>> + *	      Pierre Morel <pmorel@linux.ibm.com>
>> + */
>> +#include <linux/string.h>
>> +#include <linux/vfio.h>
>> +#include <linux/device.h>
>> +#include <linux/list.h>
>> +#include <linux/ctype.h>
>> +
>> +#include "vfio_ap_private.h"
>> +
>> +#define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
>> +#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>> +
>> +static void vfio_ap_matrix_init(struct ap_config_info *info,
>> +				struct ap_matrix *matrix)
>> +{
>> +	matrix->apm_max = info->apxa ? info->Na : 63;
>> +	matrix->aqm_max = info->apxa ? info->Nd : 15;
>> +	matrix->adm_max = info->apxa ? info->Nd : 15;
>> +}
>> +
>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>> +{
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
>> +	if (!matrix_mdev)
>> +		return -ENOMEM;
>> +
>> +	matrix_mdev->name = dev_name(mdev_dev(mdev));
>> +	vfio_ap_matrix_init(&matrix_dev.info, &matrix_mdev->matrix);
>> +	mdev_set_drvdata(mdev, matrix_mdev);
>> +
>> +	if (atomic_dec_if_positive(&matrix_dev.available_instances) < 0) {
>> +		kfree(matrix_mdev);
>> +		return -EPERM;
>> +	}
> Maybe move this check to the top of the function?

Please ignore my previous response to your comment. I can't move the call to
atomic_dec_if_positive() to the top of the function because it 
decrements the
available_instances and if the kzalloc() of matrix_mdev fails, then the 
value
would have to then be incremented to remain valid. What I can do is this:

1. Check the value of available_instances using atomic_read() at the top of
    the function and if it is zero, return an error.

2. Replace the call to atomic_dec_if_positive() with a call to atomic_dec()
    to decrement the available_instances.

I agree that it makes sense to return before attempting to allocate the
matrix_mdev if available_instances is zero.

>
>> +
>> +	mutex_lock(&matrix_dev.lock);
>> +	list_add(&matrix_mdev->list, &matrix_dev.mdev_list);
>> +	mutex_unlock(&matrix_dev.lock);
>> +
>> +	return 0;
>> +}


