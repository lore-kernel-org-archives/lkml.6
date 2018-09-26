Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449E820843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449E820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeIZNbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbeIZNbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:31:13 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23034307D945;
        Wed, 26 Sep 2018 07:19:42 +0000 (UTC)
Received: from [10.36.117.98] (ovpn-117-98.ams2.redhat.com [10.36.117.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C0B5308BE75;
        Wed, 26 Sep 2018 07:19:33 +0000 (UTC)
Subject: Re: [PATCH v11 04/26] s390: vfio-ap: base implementation of VFIO AP
 device driver
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
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-5-akrowiak@linux.vnet.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <95928d4b-e187-ef38-0f50-872763905b71@redhat.com>
Date:   Wed, 26 Sep 2018 09:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925231641.4954-5-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 26 Sep 2018 07:19:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2018 01:16, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Introduces a new AP device driver. This device driver
> is built on the VFIO mediated device framework. The framework
> provides sysfs interfaces that facilitate passthrough
> access by guests to devices installed on the linux host.
> 
> The VFIO AP device driver will serve two purposes:
> 
> 1. Provide the interfaces to reserve AP devices for exclusive
>    use by KVM guests. This is accomplished by unbinding the
>    devices to be reserved for guest usage from the zcrypt
>    device driver and binding them to the VFIO AP device driver.
> 
> 2. Implements the functions, callbacks and sysfs attribute
>    interfaces required to create one or more VFIO mediated
>    devices each of which will be used to configure the AP
>    matrix for a guest and serve as a file descriptor
>    for facilitating communication between QEMU and the
>    VFIO AP device driver.
> 
> When the VFIO AP device driver is initialized:
> 
> * It registers with the AP bus for control of type 10 (CEX4
>   and newer) AP queue devices. This limitation was imposed
>   due to:
> 
>   1. A desire to keep the code as simple as possible;
> 
>   2. Some older models are no longer supported by the kernel
>      and others are getting close to end of service.
> 
>   3. A lack of older systems on which to test older devices.
> 
>   The probe and remove callbacks will be provided to support
>   the binding/unbinding of AP queue devices to/from the VFIO
>   AP device driver.
> 
> * Creates a matrix device, /sys/devices/vfio_ap/matrix,
>   to serve as the parent of the mediated devices created, one
>   for each guest, and to hold the APQNs of the AP devices bound to
>   the VFIO AP device driver.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  MAINTAINERS                           |  10 ++
>  arch/s390/Kconfig                     |  11 ++
>  drivers/iommu/Kconfig                 |   8 ++
>  drivers/s390/crypto/Makefile          |   4 +
>  drivers/s390/crypto/vfio_ap_drv.c     | 138 ++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |  34 +++++++
>  6 files changed, 205 insertions(+)
>  create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>  create mode 100644 drivers/s390/crypto/vfio_ap_private.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e993064637ca..45cd096c0600 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12668,6 +12668,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
>  S:	Supported
>  F:	drivers/s390/crypto/
>  
> +S390 VFIO AP DRIVER
> +M:	Tony Krowiak <akrowiak@linux.ibm.com>
> +M:	Pierre Morel <pmorel@linux.ibm.com>
> +M:	Halil Pasic <pasic@linux.ibm.com>
> +L:	linux-s390@vger.kernel.org
> +W:	http://www.ibm.com/developerworks/linux/linux390/
> +S:	Supported
> +F:	drivers/s390/crypto/vfio_ap_drv.c
> +F:	drivers/s390/crypto/vfio_ap_private.h
> +
>  S390 ZFCP DRIVER
>  M:	Steffen Maier <maier@linux.ibm.com>
>  M:	Benjamin Block <bblock@linux.ibm.com>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 9a9c7a6fe925..8cc8f25d9576 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -773,6 +773,17 @@ config VFIO_CCW
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vfio_ccw.
>  
> +config VFIO_AP
> +	def_tristate n
> +	prompt "VFIO support for AP devices"
> +	depends on S390_AP_IOMMU && VFIO_MDEV_DEVICE && KVM
> +	help
> +		This driver grants access to Adjunct Processor (AP) devices
> +		via the VFIO mediated device interface.
> +
> +		To compile this driver as a module, choose M here: the module
> +		will be called vfio_ap.
> +
>  endmenu
>  
>  menu "Dump support"
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c60395b7470f..83e6d993fca5 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -372,6 +372,14 @@ config S390_CCW_IOMMU
>  	  Enables bits of IOMMU API required by VFIO. The iommu_ops
>  	  is not implemented as it is not necessary for VFIO.
>  
> +config S390_AP_IOMMU
> +	bool "S390 AP IOMMU Support"
> +	depends on S390 && ZCRYPT
> +	select IOMMU_API
> +	help
> +	  Enables bits of IOMMU API required by VFIO. The iommu_ops
> +	  is not implemented as it is not necessary for VFIO.
> +
>  config MTK_IOMMU
>  	bool "MTK IOMMU Support"
>  	depends on ARM || ARM64
> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
> index b59af548ed1c..48e466eb19cf 100644
> --- a/drivers/s390/crypto/Makefile
> +++ b/drivers/s390/crypto/Makefile
> @@ -15,3 +15,7 @@ obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
>  # pkey kernel module
>  pkey-objs := pkey_api.o
>  obj-$(CONFIG_PKEY) += pkey.o
> +
> +# adjunct processor matrix
> +vfio_ap-objs := vfio_ap_drv.o
> +obj-$(CONFIG_VFIO_AP) += vfio_ap.o
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> new file mode 100644
> index 000000000000..ea2ae03c896e
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * VFIO based AP device driver
> + *
> + * Copyright IBM Corp. 2018
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include "vfio_ap_private.h"
> +
> +#define VFIO_AP_ROOT_NAME "vfio_ap"
> +#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
> +#define VFIO_AP_DEV_NAME "matrix"
> +
> +MODULE_AUTHOR("IBM Corporation");
> +MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
> +MODULE_LICENSE("GPL v2");
> +
> +static struct ap_driver vfio_ap_drv;
> +
> +static struct device_type vfio_ap_dev_type = {
> +	.name = VFIO_AP_DEV_TYPE_NAME,
> +};
> +
> +struct ap_matrix_dev *matrix_dev;
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
> +static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
> +{
> +	/* Nothing to do yet */
> +}
> +
> +static void vfio_ap_matrix_dev_release(struct device *dev)
> +{
> +	struct ap_matrix_dev *matrix_dev = dev_get_drvdata(dev);
> +
> +	kfree(matrix_dev);
> +}
> +
> +static int vfio_ap_matrix_dev_create(void)
> +{
> +	int ret;
> +	struct device *root_device;
> +
> +	root_device = root_device_register(VFIO_AP_ROOT_NAME);
> +	if (IS_ERR(root_device))
> +		return PTR_ERR(root_device);
> +
> +	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
> +	if (!matrix_dev) {
> +		ret = -ENOMEM;
> +		goto matrix_alloc_err;
> +	}
> +
> +	matrix_dev->device.type = &vfio_ap_dev_type;
> +	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
> +	matrix_dev->device.parent = root_device;
> +	matrix_dev->device.release = vfio_ap_matrix_dev_release;
> +	matrix_dev->device.driver = &vfio_ap_drv.driver;
> +
> +	ret = device_register(&matrix_dev->device);
> +	if (ret)
> +		goto matrix_reg_err;
> +
> +	return 0;
> +
> +matrix_reg_err:
> +	put_device(&matrix_dev->device);
> +matrix_alloc_err:
> +	root_device_unregister(root_device);
> +
> +	return ret;
> +}
> +
> +static void vfio_ap_matrix_dev_destroy(void)
> +{
> +	device_unregister(&matrix_dev->device);
> +	root_device_unregister(matrix_dev->device.parent);
> +}
> +
> +int __init vfio_ap_init(void)
> +{
> +	int ret;
> +
> +	/* If there are no AP instructions, there is nothing to pass through. */
> +	if (!ap_instructions_available())
> +		return -ENODEV;
> +
> +	ret = vfio_ap_matrix_dev_create();
> +	if (ret)
> +		return ret;
> +
> +	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
> +	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
> +	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
> +	vfio_ap_drv.ids = ap_queue_ids;
> +
> +	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
> +	if (ret) {
> +		vfio_ap_matrix_dev_destroy();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void __exit vfio_ap_exit(void)
> +{
> +	ap_driver_unregister(&vfio_ap_drv);
> +	vfio_ap_matrix_dev_destroy();
> +}
> +
> +module_init(vfio_ap_init);
> +module_exit(vfio_ap_exit);
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> new file mode 100644
> index 000000000000..6141420c8bb0
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Private data and functions for adjunct processor VFIO matrix driver.
> + *
> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
> + *
> + * Copyright IBM Corp. 2018
> + */
> +
> +#ifndef _VFIO_AP_PRIVATE_H_
> +#define _VFIO_AP_PRIVATE_H_
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/mdev.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +
> +#include "ap_bus.h"
> +
> +#define VFIO_AP_MODULE_NAME "vfio_ap"
> +#define VFIO_AP_DRV_NAME "vfio_ap"
> +
> +/**
> + * ap_matrix_dev - the AP matrix device structure
> + * @device:	generic device structure associated with the AP matrix device
> + */
> +struct ap_matrix_dev {
> +	struct device device;
> +};
> +
> +extern struct ap_matrix_dev *matrix_dev;
> +
> +#endif /* _VFIO_AP_PRIVATE_H_ */
> 


From what I can tell

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
