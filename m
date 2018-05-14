Return-Path: <yi.l.liu@intel.com>
X-Google-Smtp-Source: AB8JxZrLqokSw8RvMZgM660MCnfxXw4PHbwrbR8jmTBWHfeXpw9mtFb2Ujy5n1ZX3lXRMNvY+J+u
ARC-Seal: i=1; a=rsa-sha256; t=1526280976; cv=none;
        d=google.com; s=arc-20160816;
        b=USvoU67Yg9qfHcNGNyaxLP8BIAccuVLXGPrYQzRM0i7Ve0MHl0Vg5U25lMiUnGpHXi
         EBd+mCDHFeUzHQzWnUEoyOA3Bx6PrNxoxqC8/2ylzw/9lZvmtR+XgAYM38KHmGyRiOXe
         PQHOxFG89qpXK3+xjwnlA3bJV8duNVpG1HiTlBachRXj+tLFpXXWxeMTZnxuVlBA+MRN
         FWcb4uTBDRJo88qHRl9plBVTjV+sCRTXJ+nNDqX+SI5uF2/Fgw8hJ9vrbU1K5NLeT4Hq
         oIvBNNV2p1XrbHh+EWQv9OhiKGF3zJmkQHV5CFXAb7o2D+H5DDt687fz3XCskRFpfsFU
         hOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=cEv4A3dCqqoQhS2dkqab5BF3Th95ajLdSLZTAdV9XVU=;
        b=Yb39NeAjhfKeyGmQmb/xcvVwtLi47xTXxSIs0OAHPiNJef8PkgzVK7Wbuc2Gxe2yFB
         7Ss00ivwRuwAl9u/y6/fwZAHqcPq5jtkq3d2ZalRsgEvhQr2R7g7616wbkOQRafxMJRF
         ZRrEM77WwnNxuDn8QmERVAyZO4D5qvnYY/K00f/OP1Rd+r5ZSNjwJCCkng38NRoQRwNt
         mmqsIGcgxX6s5Eh0Ec3sXx491FyLcBqziy6rHd1ndCbYZixw58ntTBlIs4+wwQKTk19U
         u3nCDL9sfRgtoMLjMg885E5tDPeaQX9N/Y89wkMDiWyZXuEbbKdpe+ZtT7CXz7jrY9n8
         Tajg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="199119812"
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
 Hellwig" <hch@infradead.org>
Subject: RE: [PATCH v4 17/22] iommu/intel-svm: report device page request
Thread-Topic: [PATCH v4 17/22] iommu/intel-svm: report device page request
Thread-Index: AQHTwlR67zkycfs9Lki7nWnhdQQU1qQvHGEQ
Date: Mon, 14 May 2018 06:56:11 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BEFA7F@SHSMSX104.ccr.corp.intel.com>
References: <1521774734-48433-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1521774734-48433-18-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1521774734-48433-18-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTY2NDdiZmItNTZhNS00MGIyLTkwM2ItNmQ4MDVkNDdmNGQ5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJCTzNGRU1DOUJGYjBxSDNwaXNSUG1EYWt4WEtkZjdOdGljdXI5dm1KTmloOEk0bWhwY2c3ZGgzR3dvTStRQXhZIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595696334534344100?=
X-GMAIL-MSGID: =?utf-8?q?1600421601164888705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jacob,

Same comment with the one to patch 16, pci_get_bus_and_slot() is
deprecated, may update accordingly.

Thanks,
Yi Liu

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Friday, March 23, 2018 11:12 AM
>=20
> If the source device of a page request has its PASID table pointer bound =
to a guest,
> the first level page tables are owned by the guest.
> In this case, we shall let guest OS to manage page fault.
>=20
> This patch uses the IOMMU fault reporting API to send fault events, possi=
bly via VFIO,
> to the guest OS. Once guest pages are fault in, guest will issue page res=
ponse which
> will be passed down via the invalidation passdown APIs.
>=20
> Recoverable faults, such as page request reporting is not limitted to gue=
st use. In
> kernel driver can also request a chance to receive fault notifications.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/intel-svm.c | 71 ++++++++++++++++++++++++++++++++++++++++-=
--
> ----
>  include/linux/iommu.h     |  1 +
>  2 files changed, 62 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c index
> 99bc9bd..bdc702c 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -580,6 +580,56 @@ static bool is_canonical_address(u64 addr)
>  	return (((saddr << shift) >> shift) =3D=3D saddr);  }
>=20
> +static int prq_to_iommu_prot(struct page_req_dsc *req) {
> +	int prot =3D 0;
> +
> +	if (req->rd_req)
> +		prot |=3D IOMMU_FAULT_READ;
> +	if (req->wr_req)
> +		prot |=3D IOMMU_FAULT_WRITE;
> +	if (req->exe_req)
> +		prot |=3D IOMMU_FAULT_EXEC;
> +	if (req->priv_req)
> +		prot |=3D IOMMU_FAULT_PRIV;
> +
> +	return prot;
> +}
> +
> +static int intel_svm_prq_report(struct page_req_dsc *desc) {
> +	int ret =3D 0;
> +	struct iommu_fault_event event;
> +	struct pci_dev *pdev;
> +
> +	memset(&event, 0, sizeof(struct iommu_fault_event));
> +	pdev =3D pci_get_bus_and_slot(desc->bus, desc->devfn);
> +	if (!pdev) {
> +		pr_err("No PCI device found for PRQ [%02x:%02x.%d]\n",
> +			desc->bus, PCI_SLOT(desc->devfn),
> +			PCI_FUNC(desc->devfn));
> +		return -ENODEV;
> +	}
> +
> +	/* Fill in event data for device specific processing */
> +	event.type =3D IOMMU_FAULT_PAGE_REQ;
> +	event.addr =3D (u64)desc->addr << VTD_PAGE_SHIFT;
> +	event.pasid =3D desc->pasid;
> +	event.page_req_group_id =3D desc->prg_index;
> +	event.prot =3D prq_to_iommu_prot(desc);
> +	event.last_req =3D desc->lpig;
> +	event.pasid_valid =3D 1;
> +	/* keep track of PRQ so that when the response comes back, we know
> +	 * whether we do group response or stream response. SRR[0] and
> +	 * private[54:32] bits in the descriptor are stored.
> +	 */
> +	event.iommu_private =3D *(u64 *)desc;
> +	ret =3D iommu_report_device_fault(&pdev->dev, &event);
> +	pci_dev_put(pdev);
> +
> +	return ret;
> +}
> +
>  static irqreturn_t prq_event_thread(int irq, void *d)  {
>  	struct intel_iommu *iommu =3D d;
> @@ -628,6 +678,16 @@ static irqreturn_t prq_event_thread(int irq, void *d=
)
>  				goto no_pasid;
>  			}
>  		}
> +		/* If address is not canonical, return invalid response */
> +		if (!is_canonical_address(address))
> +			goto bad_req;
> +
> +		/*
> +		 * If prq is to be handled outside iommu driver via receiver of
> +		 * the fault notifiers, we skip the page response here.
> +		 */
> +		if (!intel_svm_prq_report(req))
> +			goto prq_advance;
>=20
>  		result =3D QI_RESP_INVALID;
>  		/* Since we're using init_mm.pgd directly, we should never take @@
> -638,9 +698,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		if (!mmget_not_zero(svm->mm))
>  			goto bad_req;
>=20
> -		/* If address is not canonical, return invalid response */
> -		if (!is_canonical_address(address))
> -			goto bad_req;
>=20
>  		down_read(&svm->mm->mmap_sem);
>  		vma =3D find_extend_vma(svm->mm, address); @@ -673,12 +730,6
> @@ static irqreturn_t prq_event_thread(int irq, void *d)
>=20
>  		if (WARN_ON(&sdev->list =3D=3D &svm->devs))
>  			sdev =3D NULL;
> -
> -		if (sdev && sdev->ops && sdev->ops->fault_cb) {
> -			int rwxp =3D (req->rd_req << 3) | (req->wr_req << 2) |
> -				(req->exe_req << 1) | (req->priv_req);
> -			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req-
> >private, rwxp, result);
> -		}
>  		/* We get here in the error case where the PASID lookup failed,
>  		   and these can be NULL. Do not use them below this point! */
>  		sdev =3D NULL;
> @@ -704,7 +755,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>=20
>  			qi_submit_sync(&resp, iommu);
>  		}
> -
> +	prq_advance:
>  		head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
>  	}
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index 94cfda8.=
.dbe2866
> 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -42,6 +42,7 @@
>   * if the IOMMU page table format is equivalent.
>   */
>  #define IOMMU_PRIV	(1 << 5)
> +#define IOMMU_EXEC	(1 << 6)
>=20
>  struct iommu_ops;
>  struct iommu_group;
> --
> 2.7.4
