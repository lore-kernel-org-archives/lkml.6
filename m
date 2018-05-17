Return-Path: <yi.l.liu@intel.com>
X-Google-Smtp-Source: AB8JxZooeZIk8DO4R6Fd7+vo2nYpXMdPjvUtdZR5H3lGopMxcM0Ig/zcviyy5863iDAKHqlQ7PGo
ARC-Seal: i=1; a=rsa-sha256; t=1526557321; cv=none;
        d=google.com; s=arc-20160816;
        b=Zsm+v8d6NiCCdVAwoOhQtfdi2Ui+GYb21nVAu5oTNtYnTa5wBuEX+5Kx8cLcv8iFsH
         r09CPcGHJs0rnJoIy5pgslJV3gP7CP9H0YdDJOX1/+xopYyxeuVPzDKYMiy0rnNItgte
         KJqvEV7rn7RsYZGJ0eBRbj/fsCEFSO+R7QHljDMGpS7+qE8QEgIlusnZfWw+nn6mmElx
         eSChN+VshmT6SyyfQ66gQZIwO7HTgVFQe2a1lfP+utuvIHdjl37LTmrvMSQW8Gqct1Hk
         Oh9SKmkFCef9JvrctCrx617f/l4O9aGkDWXT+jUJE60FBY1QRCLFODhT+e97EQNuwy1E
         SK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=UMDS6R9jE9GYxukHd/yqIbG/63rGvKFixupkdYVqoBU=;
        b=QiHPRt8lip7xwQxbLMULKv+BP4SC1MIDmXq3znSQcmo0anyDgtHP7vnHeYx27UvSqK
         6bpiRPfLSagC9DwPtw2XWk7qR0AOEWxif7Nmy6SlVcNQXU95AgknmVRJ5GJHTEi0f4HL
         GvYU0zMbijdX6gmrF95iWKpc/JbIPxLXxfhJi8U+Fq32OkJmDEpRMzk/sf+I9VPrT6au
         sfpI5udAp/R+fWxnNRlm/FIn6j6x5xkWyspGgRsvJFsFLha6mMaCuWjIx11X4NGC+0WR
         rzs3h2Q5BOlQWBjLqftLrThf4oW/ByiybWliRZXgXB37X+eUypVUXP7UyXUFsfKVztXQ
         2ZPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="42009419"
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
	<linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
CC: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Jean Delvare
	<khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH v5 13/23] iommu: introduce device fault report API
Thread-Topic: [PATCH v5 13/23] iommu: introduce device fault report API
Thread-Index: AQHT6Wnd8uKXQGhOZUS5HMaaqAVR3qQz091Q
Date: Thu, 17 May 2018 11:41:56 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BF2537@SHSMSX104.ccr.corp.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGM1OTAyYjQtNDJjNS00ZWU3LWI2MmMtOWZmNzcyZWYxMTMyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ4VnlXRk9VdWlzRHp5ZW5jOEo3Y3VTc2tSd0VDWGY0dzROcEpDOTc4RURrV2FKU3c0Q3V6ZXA2U1UzXC9RdVVcL3AifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363226135285?=
X-GMAIL-MSGID: =?utf-8?q?1600711370378462807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Saturday, May 12, 2018 4:54 AM
>=20
> Traditionally, device specific faults are detected and handled within the=
ir own device
> drivers. When IOMMU is enabled, faults such as DMA related transactions a=
re
> detected by IOMMU. There is no generic reporting mechanism to report faul=
ts back
> to the in-kernel device driver or the guest OS in case of assigned device=
s.
>=20
> Faults detected by IOMMU is based on the transaction's source ID which ca=
n be
> reported at per device basis, regardless of the device type is a PCI devi=
ce or not.
>=20
> The fault types include recoverable (e.g. page request) and unrecoverable=
 faults(e.g.
> access error). In most cases, faults can be handled by IOMMU drivers inte=
rnally. The
> primary use cases are as
> follows:
> 1. page request fault originated from an SVM capable device that is assig=
ned to
> guest via vIOMMU. In this case, the first level page tables are owned by =
the guest.
> Page request must be propagated to the guest to let guest OS fault in the=
 pages then
> send page response. In this mechanism, the direct receiver of IOMMU fault
> notification is VFIO, which can relay notification events to QEMU or othe=
r user space
> software.
>=20
> 2. faults need more subtle handling by device drivers. Other than simply =
invoke reset
> function, there are needs to let device driver handle the fault with a sm=
aller impact.
>=20
> This patchset is intended to create a generic fault report API such that =
it can scale as
> follows:
> - all IOMMU types
> - PCI and non-PCI devices
> - recoverable and unrecoverable faults
> - VFIO and other other in kernel users
> - DMA & IRQ remapping (TBD)
> The original idea was brought up by David Woodhouse and discussions summa=
rized
> at https://lwn.net/Articles/608914/.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/iommu.c | 149
> +++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/iommu.h |  35 +++++++++++-
>  2 files changed, 181 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> 3a49b96..b3f9daf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -609,6 +609,13 @@ int iommu_group_add_device(struct iommu_group *group=
,
> struct device *dev)
>  		goto err_free_name;
>  	}
>=20
> +	dev->iommu_param =3D kzalloc(sizeof(*dev->iommu_param), GFP_KERNEL);
> +	if (!dev->iommu_param) {
> +		ret =3D -ENOMEM;
> +		goto err_free_name;
> +	}
> +	mutex_init(&dev->iommu_param->lock);
> +
>  	kobject_get(group->devices_kobj);
>=20
>  	dev->iommu_group =3D group;
> @@ -639,6 +646,7 @@ int iommu_group_add_device(struct iommu_group *group,
> struct device *dev)
>  	mutex_unlock(&group->mutex);
>  	dev->iommu_group =3D NULL;
>  	kobject_put(group->devices_kobj);
> +	kfree(dev->iommu_param);
>  err_free_name:
>  	kfree(device->name);
>  err_remove_link:
> @@ -685,7 +693,7 @@ void iommu_group_remove_device(struct device *dev)
>  	sysfs_remove_link(&dev->kobj, "iommu_group");
>=20
>  	trace_remove_device_from_group(group->id, dev);
> -
> +	kfree(dev->iommu_param);
>  	kfree(device->name);
>  	kfree(device);
>  	dev->iommu_group =3D NULL;
> @@ -820,6 +828,145 @@ int iommu_group_unregister_notifier(struct
> iommu_group *group,  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>=20
>  /**
> + * iommu_register_device_fault_handler() - Register a device fault
> +handler
> + * @dev: the device
> + * @handler: the fault handler
> + * @data: private data passed as argument to the handler
> + *
> + * When an IOMMU fault event is received, call this handler with the
> +fault event
> + * and data as argument. The handler should return 0 on success. If the
> +fault is
> + * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also complete
> + * the fault by calling iommu_page_response() with one of the following
> + * response code:
> + * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
> + * - IOMMU_PAGE_RESP_INVALID: terminate the fault
> + * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
> + *   page faults if possible.
> + *
> + * Return 0 if the fault handler was installed successfully, or an error=
.
> + */
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	struct iommu_param *param =3D dev->iommu_param;
> +	int ret =3D 0;
> +
> +	/*
> +	 * Device iommu_param should have been allocated when device is
> +	 * added to its iommu_group.
> +	 */
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);
> +	/* Only allow one fault handler registered for each device */
> +	if (param->fault_param) {
> +		ret =3D -EBUSY;
> +		goto done_unlock;
> +	}
> +
> +	get_device(dev);
> +	param->fault_param =3D
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
> +	if (!param->fault_param) {
> +		put_device(dev);
> +		ret =3D -ENOMEM;
> +		goto done_unlock;
> +	}
> +	mutex_init(&param->fault_param->lock);
> +	param->fault_param->handler =3D handler;
> +	param->fault_param->data =3D data;
> +	INIT_LIST_HEAD(&param->fault_param->faults);
> +
> +done_unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> +
> +/**
> + * iommu_unregister_device_fault_handler() - Unregister the device
> +fault handler
> + * @dev: the device
> + *
> + * Remove the device fault handler installed with
> + * iommu_register_device_fault_handler().
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_unregister_device_fault_handler(struct device *dev) {
> +	struct iommu_param *param =3D dev->iommu_param;
> +	int ret =3D 0;
> +
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);
> +	/* we cannot unregister handler if there are pending faults */
> +	if (!list_empty(&param->fault_param->faults)) {
> +		ret =3D -EBUSY;
> +		goto unlock;
> +	}
> +
> +	kfree(param->fault_param);
> +	param->fault_param =3D NULL;
> +	put_device(dev);
> +unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> +
> +
> +/**
> + * iommu_report_device_fault() - Report fault event to device
> + * @dev: the device
> + * @evt: fault event data
> + *
> + * Called by IOMMU model specific drivers when fault is detected,
> +typically
> + * in a threaded IRQ handler.
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_report_device_fault(struct device *dev, struct
> +iommu_fault_event *evt) {
> +	int ret =3D 0;
> +	struct iommu_fault_event *evt_pending;
> +	struct iommu_fault_param *fparam;
> +
> +	/* iommu_param is allocated when device is added to group */
> +	if (!dev->iommu_param | !evt)
> +		return -EINVAL;
> +	/* we only report device fault if there is a handler registered */
> +	mutex_lock(&dev->iommu_param->lock);
> +	if (!dev->iommu_param->fault_param ||
> +		!dev->iommu_param->fault_param->handler) {
> +		ret =3D -EINVAL;
> +		goto done_unlock;
> +	}
> +	fparam =3D dev->iommu_param->fault_param;
> +	if (evt->type =3D=3D IOMMU_FAULT_PAGE_REQ && evt->last_req) {
> +		evt_pending =3D kmemdup(evt, sizeof(struct iommu_fault_event),
> +				GFP_KERNEL);
> +		if (!evt_pending) {
> +			ret =3D -ENOMEM;
> +			goto done_unlock;
> +		}
> +		mutex_lock(&fparam->lock);
> +		list_add_tail(&evt_pending->list, &fparam->faults);

I may missed it. Here only see list add, how about removing? Who would remo=
ve
entry from the fault list?

> +		mutex_unlock(&fparam->lock);
> +	}
> +	ret =3D fparam->handler(evt, fparam->data);

I remember you mentioned there will be a queue to store the faults. Is it i=
n the
fparam->faults list? Or there is no such queue?

Thanks,
Yi Liu

> +done_unlock:
> +	mutex_unlock(&dev->iommu_param->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_report_device_fault);
> +
> +/**
>   * iommu_group_id - Return ID for a group
>   * @group: the group to ID
>   *
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index aeadb4f.=
.b3312ee
> 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -307,7 +307,8 @@ enum iommu_fault_reason {
>   * and PASID spec.
>   * - Un-recoverable faults of device interest
>   * - DMA remapping and IRQ remapping faults
> -
> + *
> + * @list pending fault event list, used for tracking responses
>   * @type contains fault type.
>   * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver =
internal
>   *         faults are not reported
> @@ -324,6 +325,7 @@ enum iommu_fault_reason {
>   *                 sending the fault response.
>   */
>  struct iommu_fault_event {
> +	struct list_head list;
>  	enum iommu_fault_type type;
>  	enum iommu_fault_reason reason;
>  	u64 addr;
> @@ -340,10 +342,13 @@ struct iommu_fault_event {
>   * struct iommu_fault_param - per-device IOMMU fault data
>   * @dev_fault_handler: Callback function to handle IOMMU faults at devic=
e level
>   * @data: handler private data
> - *
> + * @faults: holds the pending faults which needs response, e.g. page res=
ponse.
> + * @lock: protect pending PRQ event list
>   */
>  struct iommu_fault_param {
>  	iommu_dev_fault_handler_t handler;
> +	struct list_head faults;
> +	struct mutex lock;
>  	void *data;
>  };
>=20
> @@ -357,6 +362,7 @@ struct iommu_fault_param {
>   *	struct iommu_fwspec	*iommu_fwspec;
>   */
>  struct iommu_param {
> +	struct mutex lock;
>  	struct iommu_fault_param *fault_param;  };
>=20
> @@ -456,6 +462,14 @@ extern int iommu_group_register_notifier(struct
> iommu_group *group,
>  					 struct notifier_block *nb);
>  extern int iommu_group_unregister_notifier(struct iommu_group *group,
>  					   struct notifier_block *nb);
> +extern int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data);
> +
> +extern int iommu_unregister_device_fault_handler(struct device *dev);
> +
> +extern int iommu_report_device_fault(struct device *dev, struct
> +iommu_fault_event *evt);
> +
>  extern int iommu_group_id(struct iommu_group *group);  extern struct
> iommu_group *iommu_group_get_for_dev(struct device *dev);  extern struct
> iommu_domain *iommu_group_default_domain(struct iommu_group *); @@ -
> 727,6 +741,23 @@ static inline int iommu_group_unregister_notifier(struct
> iommu_group *group,
>  	return 0;
>  }
>=20
> +static inline int iommu_register_device_fault_handler(struct device *dev=
,
> +						iommu_dev_fault_handler_t
> handler,
> +						void *data)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int iommu_unregister_device_fault_handler(struct device
> +*dev) {
> +	return 0;
> +}
> +
> +static inline int iommu_report_device_fault(struct device *dev, struct
> +iommu_fault_event *evt) {
> +	return -ENODEV;
> +}
> +
>  static inline int iommu_group_id(struct iommu_group *group)  {
>  	return -ENODEV;
> --
> 2.7.4
