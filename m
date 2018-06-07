Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id u+RKGnfzGFsXLgAAmS7hNA
	; Thu, 07 Jun 2018 08:57:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5EF1607E7; Thu,  7 Jun 2018 08:57:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CC7B76063F;
	Thu,  7 Jun 2018 08:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC7B76063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbeFGI5y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:57:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753085AbeFGI5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:57:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w578sDBP067818
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 04:57:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jf1b98xg3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 04:57:50 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 7 Jun 2018 09:57:48 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 09:57:44 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w578vgWG7995410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 08:57:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82A005203F;
        Thu,  7 Jun 2018 08:47:19 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BF3B752047;
        Thu,  7 Jun 2018 08:47:18 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 04/13] s390: vfio-ap: base implementation of VFIO AP
 device driver
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-5-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 7 Jun 2018 10:57:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1525705912-12815-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060708-0028-0000-0000-000002CE2BD7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060708-0029-0000-0000-000023852E05
Message-Id: <ea42e912-918a-13a0-4461-db117c455868@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 17:11, Tony Krowiak wrote:
> Introduces a new AP device driver. This device driver
> is built on the VFIO mediated device framework. The framework
> provides sysfs interfaces that facilitate passthrough
> access by guests to devices installed on the linux host.
>
> The VFIO AP device driver will serve two purposes:
>
> 1. Provide the interfaces to reserve AP devices for exclusive
>     use by KVM guests. This is accomplished by unbinding the
>     devices to be reserved for guest usage from the default AP
>     device driver and binding them to the VFIO AP device driver.
>
> 2. Implements the functions, callbacks and sysfs attribute
>     interfaces required to create one or more VFIO mediated
>     devices each of which will be used to configure the AP
>     matrix for a guest and serve as a file descriptor
>     for facilitating communication between QEMU and the
>     VFIO AP device driver.
>
> When the VFIO AP device driver is initialized:
>
> * It registers with the AP bus for control of type 10 (CEX4
>    and newer) AP queue devices. This limitation was imposed
>    due to:
>
>    1. A lack of access to older systems needed to test the
>       older AP device models;
>
>    2. A desire to keep the code as simple as possible;
>
>    3. Some older models are no longer supported by the kernel
>       and others are getting close to end of service.
>
>    The probe and remove callbacks will be provided to support
>    the binding/unbinding of AP queue devices to/from the VFIO
>    AP device driver.
>
> * Creates a /sys/devices/vfio-ap/matrix device to hold
>    the APQNs of the AP devices bound to the VFIO
>    AP device driver and serves as the parent of the
>    mediated devices created for each guest.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   MAINTAINERS                           |   10 +++
>   arch/s390/Kconfig                     |   11 +++
>   drivers/s390/crypto/Makefile          |    4 +
>   drivers/s390/crypto/vfio_ap_drv.c     |  134 +++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |   23 ++++++
>   include/uapi/linux/vfio.h             |    2 +
>   6 files changed, 184 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>   create mode 100644 drivers/s390/crypto/vfio_ap_private.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 224e97b..2792c81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12237,6 +12237,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
>   S:	Supported
>   F:	drivers/s390/crypto/
>
> +S390 VFIO AP DRIVER
> +M:	Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> +M:	Christian Borntraeger <borntraeger@de.ibm.com>
> +M:	Martin Schwidefsky <schwidefsky@de.ibm.com>
> +L:	linux-s390@vger.kernel.org
> +W:	http://www.ibm.com/developerworks/linux/linux390/
> +S:	Supported
> +F:	drivers/s390/crypto/vfio_ap_drv.c
> +F:	drivers/s390/crypto/vfio_ap_private.h
> +
>   S390 ZFCP DRIVER
>   M:	Steffen Maier <maier@linux.ibm.com>
>   M:	Benjamin Block <bblock@linux.ibm.com>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 199ac3e..8d833be 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -786,6 +786,17 @@ config VFIO_CCW
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called vfio_ccw.
>
> +config VFIO_AP
> +	def_tristate n
> +	prompt "VFIO support for AP devices"
> +	depends on ZCRYPT && VFIO_MDEV_DEVICE && KVM
> +	help
> +		This driver grants access to Adjunct Processor (AP) devices
> +		via the VFIO mediated device interface.
> +
> +		To compile this driver as a module, choose M here: the module
> +		will be called vfio_ap.
> +
>   endmenu
>
>   menu "Dump support"
> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
> index b59af54..48e466e 100644
> --- a/drivers/s390/crypto/Makefile
> +++ b/drivers/s390/crypto/Makefile
> @@ -15,3 +15,7 @@ obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
>   # pkey kernel module
>   pkey-objs := pkey_api.o
>   obj-$(CONFIG_PKEY) += pkey.o
> +
> +# adjunct processor matrix
> +vfio_ap-objs := vfio_ap_drv.o
> +obj-$(CONFIG_VFIO_AP) += vfio_ap.o
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> new file mode 100644
> index 0000000..014d70f
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VFIO based AP device driver
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/slab.h>
> +
> +#include "vfio_ap_private.h"
> +
> +#define VFIO_AP_ROOT_NAME "vfio_ap"
> +#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
> +#define VFIO_AP_DEV_NAME "matrix"
> +
> +MODULE_AUTHOR("IBM Corporation");
> +MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2017");
> +MODULE_LICENSE("GPL v2");
> +
> +static struct device *vfio_ap_root_device;
> +
> +static struct ap_driver vfio_ap_drv;
> +
> +static struct ap_matrix *ap_matrix;
> +
> +static struct device_type vfio_ap_dev_type = {
> +	.name = VFIO_AP_DEV_TYPE_NAME,
> +};
> +
> +/* Only type 10 adapters (CEX4 and later) are supported
> + * by the AP matrix device driver
> + */
> +static struct ap_device_id ap_queue_ids[] = {
> +	{ .dev_type = AP_DEVICE_TYPE_CEX4,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ .dev_type = AP_DEVICE_TYPE_CEX5,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ .dev_type = AP_DEVICE_TYPE_CEX6,
> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
> +	{ /* end of sibling */ },
> +};
> +
> +MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
> +
> +static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
> +{
> +	return 0;
> +}
> +
> +static void vfio_ap_matrix_dev_release(struct device *dev)
> +{
> +	struct ap_matrix *ap_matrix = dev_get_drvdata(dev);
> +
> +	kfree(ap_matrix);
> +}
> +
> +static int vfio_ap_matrix_dev_create(void)
> +{
> +	int ret;
> +
> +	vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
> +
> +	if (IS_ERR(vfio_ap_root_device)) {
> +		ret = PTR_ERR(vfio_ap_root_device);
> +		goto done;
> +	}
> +
> +	ap_matrix = kzalloc(sizeof(*ap_matrix), GFP_KERNEL);

Since you always need this, why not a static structure ?

> +	if (!ap_matrix) {
> +		ret = -ENOMEM;
> +		goto matrix_alloc_err;
> +	}
> +
> +	ap_matrix->device.type = &vfio_ap_dev_type;
> +	dev_set_name(&ap_matrix->device, "%s", VFIO_AP_DEV_NAME);
> +	ap_matrix->device.parent = vfio_ap_root_device;
> +	ap_matrix->device.release = vfio_ap_matrix_dev_release;
> +	ap_matrix->device.driver = &vfio_ap_drv.driver;
> +
> +	ret = device_register(&ap_matrix->device);
> +	if (ret)
> +		goto matrix_reg_err;
> +
> +	goto done;
> +
> +matrix_reg_err:
> +	put_device(&ap_matrix->device);
> +
> +matrix_alloc_err:
> +	root_device_unregister(vfio_ap_root_device);
> +
> +done:
> +	return ret;
> +}
> +
> +static void vfio_ap_matrix_dev_destroy(struct ap_matrix *ap_matrix)
> +{
> +	device_unregister(&ap_matrix->device);
> +	root_device_unregister(vfio_ap_root_device);
> +}
> +
> +int __init vfio_ap_init(void)
> +{
> +	int ret;
> +
> +	ret = vfio_ap_matrix_dev_create();
> +	if (ret)
> +		return ret;
> +
> +	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));

your structure is static, no need to initialize to 0.

> +	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
> +	vfio_ap_drv.ids = ap_queue_ids;
> +
> +	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
> +	if (ret) {
> +		vfio_ap_matrix_dev_destroy(ap_matrix);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void __exit vfio_ap_exit(void)
> +{
> +	ap_driver_unregister(&vfio_ap_drv);
> +	vfio_ap_matrix_dev_destroy(ap_matrix);
> +}
> +
> +module_init(vfio_ap_init);
> +module_exit(vfio_ap_exit);
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> new file mode 100644
> index 0000000..cf23675
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Private data and functions for adjunct processor VFIO matrix driver.
> + *
> + * Copyright IBM Corp. 2017
> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + */
> +
> +#ifndef _VFIO_AP_PRIVATE_H_
> +#define _VFIO_AP_PRIVATE_H_
> +
> +#include <linux/types.h>
> +
> +#include "ap_bus.h"
> +
> +#define VFIO_AP_MODULE_NAME "vfio_ap"
> +#define VFIO_AP_DRV_NAME "vfio_ap"
> +
> +struct ap_matrix {
> +	struct device device;
> +};
> +
> +#endif /* _VFIO_AP_PRIVATE_H_ */
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82..f378b98 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -200,6 +200,7 @@ struct vfio_device_info {
>   #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>   #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
>   #define VFIO_DEVICE_FLAGS_CCW	(1 << 4)	/* vfio-ccw device */
> +#define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
>   	__u32	num_regions;	/* Max region index + 1 */
>   	__u32	num_irqs;	/* Max IRQ index + 1 */
>   };
> @@ -215,6 +216,7 @@ struct vfio_device_info {
>   #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
>   #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
>   #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
> +#define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
>
>   /**
>    * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
