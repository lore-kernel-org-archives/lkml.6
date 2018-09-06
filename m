Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A79C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48C22075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48C22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeIFNX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:23:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728098AbeIFNX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:23:56 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w868iPA9132161
        for <linux-kernel@vger.kernel.org>; Thu, 6 Sep 2018 04:49:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2maymd3w1v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 04:49:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 6 Sep 2018 09:49:30 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Sep 2018 09:49:26 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w868nP5w42467474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Sep 2018 08:49:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C9B85204F;
        Thu,  6 Sep 2018 11:49:17 +0100 (BST)
Received: from [9.152.224.219] (unknown [9.152.224.219])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7959952052;
        Thu,  6 Sep 2018 11:49:16 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v9 09/22] s390: vfio-ap: register matrix device with VFIO
 mdev framework
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 6 Sep 2018 10:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534196899-16987-10-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18090608-4275-0000-0000-000002B61C2B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090608-4276-0000-0000-000037BF3A13
Message-Id: <af1cd7a8-446c-ddf6-cf17-886dd259da3d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809060093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2018 23:48, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Registers the matrix device created by the VFIO AP device
> driver with the VFIO mediated device framework.
> Registering the matrix device will create the sysfs
> structures needed to create mediated matrix devices
> each of which will be used to configure the AP matrix
> for a guest and connect it to the VFIO AP device driver.
> 
> Registering the matrix device with the VFIO mediated device
> framework will create the following sysfs structures:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ create
> 
> To create a mediated device for the AP matrix device, write a UUID
> to the create file:
> 
> 	uuidgen > create
> 
> A symbolic link to the mediated device's directory will be created in the
> devices subdirectory named after the generated $uuid:
> 
> /sys/devices/vfio_ap/matrix/
> ...... [mdev_supported_types]
> ......... [vfio_ap-passthrough]
> ............ [devices]
> ............... [$uuid]
> 
> A symbolic link to the mediated device will also be created
> in the vfio_ap matrix's directory:
> 
> /sys/devices/vfio_ap/matrix/[$uuid]
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   MAINTAINERS                           |    1 +
>   drivers/s390/crypto/Makefile          |    2 +-
>   drivers/s390/crypto/vfio_ap_drv.c     |   23 ++++++
>   drivers/s390/crypto/vfio_ap_ops.c     |  124 +++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |   45 ++++++++++++
>   include/uapi/linux/vfio.h             |    1 +
>   6 files changed, 195 insertions(+), 1 deletions(-)
>   create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e84c559..f60dd56 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12427,6 +12427,7 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
>   S:	Supported
>   F:	drivers/s390/crypto/vfio_ap_drv.c
>   F:	drivers/s390/crypto/vfio_ap_private.h
> +F:	drivers/s390/crypto/vfio_ap_ops.c
> 
>   S390 ZFCP DRIVER
>   M:	Steffen Maier <maier@linux.ibm.com>
> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
> index 48e466e..8d36b05 100644
> --- a/drivers/s390/crypto/Makefile
> +++ b/drivers/s390/crypto/Makefile
> @@ -17,5 +17,5 @@ pkey-objs := pkey_api.o
>   obj-$(CONFIG_PKEY) += pkey.o
> 
>   # adjunct processor matrix
> -vfio_ap-objs := vfio_ap_drv.o
> +vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
>   obj-$(CONFIG_VFIO_AP) += vfio_ap.o
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 5069580..fa04c5a 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -11,6 +11,7 @@
>   #include <linux/mod_devicetable.h>
>   #include <linux/slab.h>
>   #include <linux/string.h>
> +#include <asm/zcrypt.h>
>   #include "vfio_ap_private.h"
> 
>   #define VFIO_AP_ROOT_NAME "vfio_ap"
> @@ -65,6 +66,19 @@ static int vfio_ap_matrix_dev_init(void)
>   		return ret;
>   	}
> 
> +	mutex_init(&matrix_dev.lock);
> +	INIT_LIST_HEAD(&matrix_dev.mdev_list);
> +
> +	/* Test if PQAP(QCI) instruction is available */
> +	if (test_facility(12)) {
> +		ret = ap_qci(&matrix_dev.info);
> +		if (ret) {
> +			root_device_unregister(root_device);
> +			return ret;
> +		}
> +	}
> +
> +	atomic_set(&matrix_dev.available_instances, MAX_ZDEV_ENTRIES_EXT);
>   	matrix_dev.device.type = &vfio_ap_dev_type;
>   	dev_set_name(&matrix_dev.device, "%s", VFIO_AP_DEV_NAME);
>   	matrix_dev.device.type = &vfio_ap_dev_type;
> @@ -105,11 +119,20 @@ int __init vfio_ap_init(void)
>   		return ret;
>   	}
> 
> +	ret = vfio_ap_mdev_register();
> +	if (ret) {
> +		ap_driver_unregister(&vfio_ap_drv);
> +		vfio_ap_matrix_dev_destroy();
> +
> +		return ret;
> +	}
> +
>   	return 0;
>   }
> 
>   void __exit vfio_ap_exit(void)
>   {
> +	vfio_ap_mdev_unregister();
>   	ap_driver_unregister(&vfio_ap_drv);
>   	vfio_ap_matrix_dev_destroy();
>   }
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> new file mode 100644
> index 0000000..8018c2d
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Adjunct processor matrix VFIO device driver callbacks.
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *	      Halil Pasic <pasic@linux.ibm.com>
> + *	      Pierre Morel <pmorel@linux.ibm.com>
> + */
> +#include <linux/string.h>
> +#include <linux/vfio.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/ctype.h>
> +
> +#include "vfio_ap_private.h"
> +
> +#define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
> +#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
> +
> +static void vfio_ap_matrix_init(struct ap_config_info *info,
> +				struct ap_matrix *matrix)
> +{
> +	matrix->apm_max = info->apxa ? info->Na : 63;
> +	matrix->aqm_max = info->apxa ? info->Nd : 15;
> +	matrix->adm_max = info->apxa ? info->Nd : 15;
> +}
> +
> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
> +	if (!matrix_mdev)
> +		return -ENOMEM;
> +
> +	matrix_mdev->name = dev_name(mdev_dev(mdev));
> +	vfio_ap_matrix_init(&matrix_dev.info, &matrix_mdev->matrix);
> +	mdev_set_drvdata(mdev, matrix_mdev);
> +
> +	if (atomic_dec_if_positive(&matrix_dev.available_instances) < 0) {
> +		kfree(matrix_mdev);
> +		return -EPERM;
> +	}
> +
> +	mutex_lock(&matrix_dev.lock);
> +	list_add(&matrix_mdev->list, &matrix_dev.mdev_list);
> +	mutex_unlock(&matrix_dev.lock);
> +
Hi Tony,

You need to initialize the matrix_mdev->list before
using it.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

