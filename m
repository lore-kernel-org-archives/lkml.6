Return-Path: <yi.l.liu@intel.com>
X-Google-Smtp-Source: AB8JxZrTDPoL9exNSXk9fj7EB4Y2SvzrWKXpJ21vhI8CgAfag7e/s5YzpgcoydUM5/qymrsVKpn1
ARC-Seal: i=1; a=rsa-sha256; t=1526280939; cv=none;
        d=google.com; s=arc-20160816;
        b=LaDHGfQXkWppWgS7Wn26eWdeUQoGr3f4tIZBJgCwOCAiN5t5P71whxwzLGOf984e3M
         A8UI7bmzPXfmpCuNY3dCFakM57fkfY1vlZ5b4XtNYJvFpKxKTCMiOwwCsbWpkmm16kA5
         wVfUjow2ThyXUl48f4V1LkuHC8bVKZZeeSZNDoBPd4zgIsduHhI4ieM8TqO+udT64L6Z
         p/JwfOERjI9ZwpF6k73xn1jUA7thUi/54cVaCFPInsz7KScS15Ag8Wo9Daz6PcWdosF1
         L2GjbJN0I38vkmMFZU++d8kvQXAlWHeMtHcgmtjCbI2hDf3bhpwOax/KomizrFZXnNZz
         RXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=gw95PGJwSiYd8gnZIbzkwX3TxbrQ4Osbcc2HB/fddwM=;
        b=ht9d4YR8estyh6p4QDVqX/KfDhhuJXPimC0Kxzs3LgDGv6H2CEXC5ggwGs9uY8KX8N
         hQs7K2D72/YGHV+gIL+YnFpYFjSAiOsdx6nUqNtXT+SHh8hhCuByrf+bI98TalfnDyQa
         DKXnwAf/ztYyDavqiblhq5ycsB3rgknIz0qeD6SisdCCk9ViBSjyawJ/H88UsvoqOkHH
         cplO+3f3g6vlcDE2fR/xWuiiTdVUkPAN8GAbykNbkM8nJQMLkE53+r/wZMhAJYbNZ9vb
         UbPGuiCKoeUCRyWaRJm4m4V85/bnZvgefh4N1ZQk+2fUzr+yJXm9XR/i0/826dBCDh98
         mdHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="199119705"
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
	<linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Jean-Philippe Brucker
	<jean-philippe.brucker@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>
CC: Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"Raj, Ashok" <ashok.raj@intel.com>, Alex Williamson
	<alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, "Christoph
 Hellwig" <hch@infradead.org>, Yi L <yi.l.liu@linux.intel.com>
Subject: RE: [PATCH v4 16/22] iommu/vt-d: report non-recoverable faults to
 device
Thread-Topic: [PATCH v4 16/22] iommu/vt-d: report non-recoverable faults to
 device
Thread-Index: AQHTwlR6DYT5TI/2YUKrdhK3l9EgMqQvHAXg
Date: Mon, 14 May 2018 06:55:17 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BEFA65@SHSMSX104.ccr.corp.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1521774734-48433-17-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1521774734-48433-17-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTUyZWI4MzQtYzIwNy00N2RhLWEzMmItMzdjMmIyMzdjZDE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJwSW00MmVzY0VGcnQwOUVoMEpOQTZObzVPYTZRa3JXTWdnczUxREVjTlJWZ0d3MXZPZjY3TnNPK01xUjFsQ2VJIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696333748452964?=
X-GMAIL-MSGID: =?utf-8?q?1600421562192187660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jacob,

pci_get_bus_and_slot() is deprecated, may update accordingly.

Thanks,
Yi Liu
> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Friday, March 23, 2018 11:12 AM
> Subject: [PATCH v4 16/22] iommu/vt-d: report non-recoverable faults to de=
vice
>=20
> Currently, dmar fault IRQ handler does nothing more than rate limited pri=
ntk, no
> critical hardware handling need to be done in IRQ context.
> For some use case such as vIOMMU, it might be useful to report non-recove=
rable
> faults outside host IOMMU subsystem. DMAR fault can come from both DMA an=
d
> interrupt remapping which has to be set up early before threaded IRQ is a=
vailable.
> This patch adds an option and a workqueue such that when faults are reque=
sted,
> DMAR fault IRQ handler can use the IOMMU fault reporting API to report.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/dmar.c        | 157
> ++++++++++++++++++++++++++++++++++++++++++--
>  drivers/iommu/intel-iommu.c |   6 +-
>  include/linux/dmar.h        |   2 +-
>  include/linux/intel-iommu.h |   1 +
>  4 files changed, 157 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c index 2ed4979..0=
f1abfc
> 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1110,6 +1110,12 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd=
)
>  	return err;
>  }
>=20
> +static inline void dmar_free_fault_wq(struct intel_iommu *iommu) {
> +	if (iommu->fault_wq)
> +		destroy_workqueue(iommu->fault_wq);
> +}
> +
>  static void free_iommu(struct intel_iommu *iommu)  {
>  	if (intel_iommu_enabled) {
> @@ -1126,6 +1132,7 @@ static void free_iommu(struct intel_iommu *iommu)
>  		free_irq(iommu->irq, iommu);
>  		dmar_free_hwirq(iommu->irq);
>  		iommu->irq =3D 0;
> +		dmar_free_fault_wq(iommu);
>  	}
>=20
>  	if (iommu->qi) {
> @@ -1554,6 +1561,31 @@ static const char *irq_remap_fault_reasons[] =3D
>  	"Blocked an interrupt request due to source-id verification failure",  =
};
>=20
> +/* fault data and status */
> +enum intel_iommu_fault_reason {
> +	INTEL_IOMMU_FAULT_REASON_SW,
> +	INTEL_IOMMU_FAULT_REASON_ROOT_NOT_PRESENT,
> +	INTEL_IOMMU_FAULT_REASON_CONTEXT_NOT_PRESENT,
> +	INTEL_IOMMU_FAULT_REASON_CONTEXT_INVALID,
> +	INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH,
> +	INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS,
> +	INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS,
> +	INTEL_IOMMU_FAULT_REASON_NEXT_PT_INVALID,
> +	INTEL_IOMMU_FAULT_REASON_ROOT_ADDR_INVALID,
> +	INTEL_IOMMU_FAULT_REASON_CONTEXT_PTR_INVALID,
> +	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_RTP,
> +	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_CTP,
> +	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_PTE,
> +	NR_INTEL_IOMMU_FAULT_REASON,
> +};
> +
> +/* fault reasons that are allowed to be reported outside IOMMU subsystem=
 */
> +#define INTEL_IOMMU_FAULT_REASON_ALLOWED			\
> +	((1ULL << INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH) |	\
> +		(1ULL << INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS) |
> 	\
> +		(1ULL << INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS))
> +
> +
>  static const char *dmar_get_fault_reason(u8 fault_reason, int *fault_typ=
e)  {
>  	if (fault_reason >=3D 0x20 && (fault_reason - 0x20 < @@ -1634,11 +1666,=
90
> @@ void dmar_msi_read(int irq, struct msi_msg *msg)
>  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);  }
>=20
> +static enum iommu_fault_reason to_iommu_fault_reason(u8 reason) {
> +	if (reason >=3D NR_INTEL_IOMMU_FAULT_REASON) {
> +		pr_warn("unknown DMAR fault reason %d\n", reason);
> +		return IOMMU_FAULT_REASON_UNKNOWN;
> +	}
> +	switch (reason) {
> +	case INTEL_IOMMU_FAULT_REASON_SW:
> +	case INTEL_IOMMU_FAULT_REASON_ROOT_NOT_PRESENT:
> +	case INTEL_IOMMU_FAULT_REASON_CONTEXT_NOT_PRESENT:
> +	case INTEL_IOMMU_FAULT_REASON_CONTEXT_INVALID:
> +	case INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH:
> +	case INTEL_IOMMU_FAULT_REASON_ROOT_ADDR_INVALID:
> +	case INTEL_IOMMU_FAULT_REASON_CONTEXT_PTR_INVALID:
> +		return IOMMU_FAULT_REASON_INTERNAL;
> +	case INTEL_IOMMU_FAULT_REASON_NEXT_PT_INVALID:
> +	case INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS:
> +	case INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS:
> +		return IOMMU_FAULT_REASON_PERMISSION;
> +	default:
> +		return IOMMU_FAULT_REASON_UNKNOWN;
> +	}
> +}
> +
> +struct dmar_fault_work {
> +	struct work_struct fault_work;
> +	u64 addr;
> +	int type;
> +	int fault_type;
> +	enum intel_iommu_fault_reason reason;
> +	u16 sid;
> +};
> +
> +static void report_fault_to_device(struct work_struct *work) {
> +	struct dmar_fault_work *dfw =3D container_of(work, struct dmar_fault_wo=
rk,
> +						fault_work);
> +	struct iommu_fault_event event;
> +	struct pci_dev *pdev;
> +	u8 bus, devfn;
> +
> +	memset(&event, 0, sizeof(struct iommu_fault_event));
> +
> +	/* check if fault reason is permitted to report outside IOMMU */
> +	if (!((1 << dfw->reason) & INTEL_IOMMU_FAULT_REASON_ALLOWED)) {
> +		pr_debug("Fault reason %d not allowed to report to device\n",
> +			dfw->reason);
> +		goto free_work;
> +	}
> +
> +	bus =3D PCI_BUS_NUM(dfw->sid);
> +	devfn =3D PCI_DEVFN(PCI_SLOT(dfw->sid), PCI_FUNC(dfw->sid));
> +	/*
> +	 * we need to check if the fault reporting is requested for the
> +	 * offending device.
> +	 */
> +	pdev =3D pci_get_bus_and_slot(bus, devfn);
> +	if (!pdev) {
> +		pr_warn("No PCI device found for source ID %x\n", dfw->sid);
> +		goto free_work;
> +	}
> +	/*
> +	 * unrecoverable fault is reported per IOMMU, notifier handler can
> +	 * resolve PCI device based on source ID.
> +	 */
> +	event.reason =3D to_iommu_fault_reason(dfw->reason);
> +	event.addr =3D dfw->addr;
> +	event.type =3D IOMMU_FAULT_DMA_UNRECOV;
> +	event.prot =3D dfw->type ? IOMMU_READ : IOMMU_WRITE;
> +	dev_warn(&pdev->dev, "report device unrecoverable fault: %d, %x, %d\n",
> +		event.reason, dfw->sid, event.type);
> +	iommu_report_device_fault(&pdev->dev, &event);
> +	pci_dev_put(pdev);
> +
> +free_work:
> +	kfree(dfw);
> +}
> +
>  static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>  		u8 fault_reason, u16 source_id, unsigned long long addr)  {
>  	const char *reason;
>  	int fault_type;
> +	struct dmar_fault_work *dfw;
>=20
>  	reason =3D dmar_get_fault_reason(fault_reason, &fault_type);
>=20
> @@ -1647,11 +1758,28 @@ static int dmar_fault_do_one(struct intel_iommu
> *iommu, int type,
>  			source_id >> 8, PCI_SLOT(source_id & 0xFF),
>  			PCI_FUNC(source_id & 0xFF), addr >> 48,
>  			fault_reason, reason);
> -	else
> +	else {
>  		pr_err("[%s] Request device [%02x:%02x.%d] fault addr %llx [fault
> reason %02d] %s\n",
>  		       type ? "DMA Read" : "DMA Write",
>  		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>  		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
> +	}
> +
> +	dfw =3D kmalloc(sizeof(*dfw), GFP_ATOMIC);
> +	if (!dfw)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&dfw->fault_work, report_fault_to_device);
> +	dfw->addr =3D addr;
> +	dfw->type =3D type;
> +	dfw->fault_type =3D fault_type;
> +	dfw->reason =3D fault_reason;
> +	dfw->sid =3D source_id;
> +	if (!queue_work(iommu->fault_wq, &dfw->fault_work)) {
> +		kfree(dfw);
> +		return -EBUSY;
> +	}
> +
>  	return 0;
>  }
>=20
> @@ -1731,10 +1859,28 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>=20
> -int dmar_set_interrupt(struct intel_iommu *iommu)
> +static int dmar_set_fault_wq(struct intel_iommu *iommu) {
> +	if (iommu->fault_wq)
> +		return 0;
> +
> +	iommu->fault_wq =3D alloc_ordered_workqueue(iommu->name, 0);
> +	if (!iommu->fault_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +int dmar_set_interrupt(struct intel_iommu *iommu, bool queue_fault)
>  {
>  	int irq, ret;
>=20
> +	/* fault can be reported back to device drivers via a wq */
> +	if (queue_fault) {
> +		ret =3D dmar_set_fault_wq(iommu);
> +		if (ret)
> +			pr_err("Failed to create fault handling workqueue\n");
> +	}
>  	/*
>  	 * Check if the fault interrupt is already initialized.
>  	 */
> @@ -1748,10 +1894,11 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
>  		pr_err("No free IRQ vectors\n");
>  		return -EINVAL;
>  	}
> -
>  	ret =3D request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name,
> iommu);
> -	if (ret)
> +	if (ret) {
>  		pr_err("Can't request irq\n");
> +		dmar_free_fault_wq(iommu);
> +	}
>  	return ret;
>  }
>=20
> @@ -1765,7 +1912,7 @@ int __init enable_drhd_fault_handling(void)
>  	 */
>  	for_each_iommu(iommu, drhd) {
>  		u32 fault_status;
> -		int ret =3D dmar_set_interrupt(iommu);
> +		int ret =3D dmar_set_interrupt(iommu, false);
>=20
>  		if (ret) {
>  			pr_err("DRHD %Lx: failed to enable fault, interrupt,
> ret %d\n", diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel=
-iommu.c
> index 771ee1e..3229e20 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3424,10 +3424,10 @@ static int __init init_dmars(void)
>  				goto free_iommu;
>  		}
>  #endif
> -		ret =3D dmar_set_interrupt(iommu);
> +		ret =3D dmar_set_interrupt(iommu, true);
> +
>  		if (ret)
>  			goto free_iommu;
> -
>  		if (!translation_pre_enabled(iommu))
>  			iommu_enable_translation(iommu);
>=20
> @@ -4345,7 +4345,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *d=
maru)
>  			goto disable_iommu;
>  	}
>  #endif
> -	ret =3D dmar_set_interrupt(iommu);
> +	ret =3D dmar_set_interrupt(iommu, true);
>  	if (ret)
>  		goto disable_iommu;
>=20
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h index e2433bc..2=
1f2162
> 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -278,7 +278,7 @@ extern void dmar_msi_unmask(struct irq_data *data);
> extern void dmar_msi_mask(struct irq_data *data);  extern void dmar_msi_r=
ead(int
> irq, struct msi_msg *msg);  extern void dmar_msi_write(int irq, struct ms=
i_msg *msg);
> -extern int dmar_set_interrupt(struct intel_iommu *iommu);
> +extern int dmar_set_interrupt(struct intel_iommu *iommu, bool
> +queue_fault);
>  extern irqreturn_t dmar_fault(int irq, void *dev_id);  extern int dmar_a=
lloc_hwirq(int
> id, int node, void *arg);  extern void dmar_free_hwirq(int irq); diff --g=
it
> a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h index 245ac7e=
..dacb6cf
> 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -445,6 +445,7 @@ struct intel_iommu {
>  	struct iommu_device iommu;  /* IOMMU core code handle */
>  	int		node;
>  	u32		flags;      /* Software defined flags */
> +	struct workqueue_struct *fault_wq; /* Reporting IOMMU fault to device
> +*/
>  };
>=20
>  /* PCI domain-device relationship */
> --
> 2.7.4
