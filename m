Return-Path: <yi.l.liu@intel.com>
X-Google-Smtp-Source: AB8JxZr+uEsmmsZz/IzlgD4WSYVl4HdvZ4h2dglDn/IBxFHqLB5q3ciIXg0RTEZQXGTO1r12QHsU
ARC-Seal: i=1; a=rsa-sha256; t=1526599368; cv=none;
        d=google.com; s=arc-20160816;
        b=ZXQn9CApXdwowEfff9yJhhKY5J+AusqHq+DYubgWuuM/NV6WkRyRCpQ2N8EAFRO+YR
         smyJbZqh0n72HANM78by+HqLkpO9O+T4NC5ANDTeIjsD90Qk941erPqwengKBCDPnLx+
         4IyfGWNkYzu8p74w5Ym/voIVf9LS/Kd8xjGbpUjqI2hGSD+zF2mMi4XdUwdEQzZk1Gbu
         GRL3ChKQwU91pg2Zgd89lq1z1CPIp4Mj24zeFsp4Asub3nX8diQIGVzE1d+f0oPBvo0x
         6G6aWbcSMHRZwemmS815MR/0wzNqbWtKpBR+Ja68aQLUqlTI1yRF2PvJ5dbXONLEhkIj
         MAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=NUiH+SwiaqIfXL2gTZqLYvyeIwVdmBCJRsSDWyeQBrQ=;
        b=llgzepVCImQ9dQLouvbMZ9NJwsV/qsrEkA5dzd1kItLaXm3CsVdvKL8TZOikD4t1eY
         uERpBV2zqgTiuWPW2gy+vdU0DKONlfXWjmWkG4digIuJBZXSpN2I0jzXApY+hBswW/mX
         f5bpx0oE+FBaHy0zt5fwwn7qtEverc0IbPiiJm0NfXZzr3oRJLkzb3T8dSSs6kwgBB6i
         OHjzErAf611SzL0+ES6zmVNphuoZ2Vn8wc9dEMRQQFnoBpQiixfj8Whod0cxnaPVPiJ1
         r2t/ljYPLfe4n7LoAl4K24DQEvSqUUejnVPhqe8i7aHW2TDhtiGi1qIrB209l7YFp6yL
         s3vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yi.l.liu@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=yi.l.liu@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,412,1520924400";
   d="scan'208";a="225174151"
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, "Christoph
 Hellwig" <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v5 13/23] iommu: introduce device fault report API
Thread-Topic: [PATCH v5 13/23] iommu: introduce device fault report API
Thread-Index: AQHT6Wnd8uKXQGhOZUS5HMaaqAVR3qQz091Q///DLoCAAPOREA==
Date: Thu, 17 May 2018 23:22:43 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BF2B2D@SHSMSX104.ccr.corp.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439BF2537@SHSMSX104.ccr.corp.intel.com>
 <20180517085909.7470dfb5@jacob-builder>
In-Reply-To: <20180517085909.7470dfb5@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjBlODU5MDktNTAzOS00ZjI3LTkwZjktMjkyMzI5NWZlOWRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJZNWJZcmZqU0hOaEx4c3E0bDFKRStETUxDQVRvVGhHelhOTnVtWmFHMFpJTmFSM3pKK1c1WlwvbGw3YTdvZWZRdiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363226135285?=
X-GMAIL-MSGID: =?utf-8?q?1600755459566488656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Thursday, May 17, 2018 11:59 PM
> On Thu, 17 May 2018 11:41:56 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
>=20
> > > +int iommu_report_device_fault(struct device *dev, struct
> > > +iommu_fault_event *evt) {
> > > +	int ret =3D 0;
> > > +	struct iommu_fault_event *evt_pending;
> > > +	struct iommu_fault_param *fparam;
> > > +
> > > +	/* iommu_param is allocated when device is added to group
> > > */
> > > +	if (!dev->iommu_param | !evt)
> > > +		return -EINVAL;
> > > +	/* we only report device fault if there is a handler
> > > registered */
> > > +	mutex_lock(&dev->iommu_param->lock);
> > > +	if (!dev->iommu_param->fault_param ||
> > > +		!dev->iommu_param->fault_param->handler) {
> > > +		ret =3D -EINVAL;
> > > +		goto done_unlock;
> > > +	}
> > > +	fparam =3D dev->iommu_param->fault_param;
> > > +	if (evt->type =3D=3D IOMMU_FAULT_PAGE_REQ && evt->last_req) {
> > > +		evt_pending =3D kmemdup(evt, sizeof(struct
> > > iommu_fault_event),
> > > +				GFP_KERNEL);
> > > +		if (!evt_pending) {
> > > +			ret =3D -ENOMEM;
> > > +			goto done_unlock;
> > > +		}
> > > +		mutex_lock(&fparam->lock);
> > > +		list_add_tail(&evt_pending->list,
> > > &fparam->faults);
> >
> > I may missed it. Here only see list add, how about removing? Who would
> > remove entry from the fault list?
> >
> deletion of the pending event is in page response function (int
> iommu_page_response), once iommu driver finds a matching response for the
> pending request, it will delete the pending event.
>=20
> if the response never came, right now we don't delete it, just gives warn=
ing.

Got it.

>=20
> > > +		mutex_unlock(&fparam->lock);
> > > +	}
> > > +	ret =3D fparam->handler(evt, fparam->data);
> >
> > I remember you mentioned there will be a queue to store the faults.
> > Is it in the fparam->faults list? Or there is no such queue?
> There are two use cases:
> case A: guest SVA, PRQ events are reported outside IOMMU subsystem,
> 	e.g. vfio
> case B: in-kernel
>=20
> The io page fault queuing is Jean's patchset, mostly for case B (in-kerne=
l IO page
> fault handling). I will convert intel-svm to Jean's io page fault mechani=
sm so that we
> can also have parallel and out of order queuing of PRQ. I still need some=
 time to
> evaluate intel specific needs such as streaming page request/response.
>=20
> For case A, there is no queuing in host IOMMU driver. My understanding of=
 the flow
> is as the following:
> 1. host IOMMU receives PRQ
> 2. host IOMMU driver reports PRQ fault event to registered called, i.e.
> vfio
> 3. VFIO reports fault event to QEMU
> 4. QEMU injects PRQ to guest
> 5. Guest IOMMU driver receives PRQ in IRQ 6. Guest IOMMU driver queue PRQ=
 by
> groups, PASID.

Correct.

> So as long as in-kernel PRQ handling can do queuing, there is no need for=
 queuing in
> the host reporting path.

Will it affect current interface? Here the handler only get an "evt" per a =
PRQ IRQ. And I suppose
vfio needs not rely on host iommu queuing?

Thanks,
Yi Liu
