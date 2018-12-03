Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3600C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B789120850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B789120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbeLCRXv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:23:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:14936 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeLCRXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:23:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 09:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="280562138"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga005.jf.intel.com with ESMTP; 03 Dec 2018 09:23:45 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 3 Dec 2018 09:23:44 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 3 Dec 2018 09:23:44 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.203]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.59]) with mapi id 14.03.0415.000;
 Tue, 4 Dec 2018 01:23:41 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Jean-Philippe Brucker" <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Thread-Topic: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
Thread-Index: AQHUhs6TVk6guLNF2UqGEgW8JQITuaVsiNIAgAC8OMA=
Date:   Mon, 3 Dec 2018 17:23:40 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D838B9@SHSMSX104.ccr.corp.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-3-baolu.lu@linux.intel.com>
 <20181203134411.lejlkbnagxml54ro@8bytes.org>
In-Reply-To: <20181203134411.lejlkbnagxml54ro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGQyYzg1MTgtNWZlMy00ZDc1LTk3NmEtOGU3ZjhlYThhMDI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRXFtOHltcjA5ZmdUUlcxUmwxc3BoWWdBQVM3QUtRZmpvQU1tbEw5M254VlBlU081MHhnQnBWZytDdUFjZGNjbCJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Monday, December 3, 2018 5:44 AM
> To: Lu Baolu <baolu.lu@linux.intel.com>
> Subject: Re: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
> 
> Hi Baolu,
> 
> On Wed, Nov 28, 2018 at 11:54:39AM +0800, Lu Baolu wrote:
> > @@ -2482,12 +2482,13 @@ static struct dmar_domain
> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
> >  	if (dev)
> >  		dev->archdata.iommu = info;
> >
> > -	if (dev && dev_is_pci(dev) && info->pasid_supported) {
> > +	/* PASID table is mandatory for a PCI device in scalable mode. */
> > +	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
> 
> This will also allocate a PASID table if the device does not support
> PASIDs, right? Will the table not be used in that case or will the
> device just use the fallback PASID? Isn't it better in that case to have
> no PASID table?

We need to allocate the PASID table in scalable mode, the reason is as below:
In VT-d scalable mode, all address translation is done in PASID-granularity.
For requests-with-PASID, the address translation would be subjected to the
PASID entry specified by the PASID value in the DMA request. However, for
requests-without-PASID, there is no PASID in the DMA request. To fulfil
the translation logic, we've introduced RID2PASID field in sm-context-entry
in VT-d 3.o spec. So that such DMA requests would be subjected to the pasid
entry specified by the PASID value in the RID2PASID field of sm-context-entry.

So for a device without PASID support, we need to at least to have a PASID
entry so that its DMA request (without pasid) can be translated. Thus a PASID
table is needed for such devices.

> 
> > @@ -143,18 +143,20 @@ int intel_pasid_alloc_table(struct device *dev)
> >  		return -ENOMEM;
> >  	INIT_LIST_HEAD(&pasid_table->dev);
> >
> > -	size = sizeof(struct pasid_entry);
> > -	count = min_t(int, pci_max_pasids(to_pci_dev(dev)), intel_pasid_max_id);
> > -	order = get_order(size * count);
> > +	if (info->pasid_supported)
> > +		max_pasid = min_t(int, pci_max_pasids(to_pci_dev(dev)),
> > +				  intel_pasid_max_id);
> > +
> > +	size = max_pasid >> (PASID_PDE_SHIFT - 3);
> > +	order = size ? get_order(size) : 0;
> >  	pages = alloc_pages_node(info->iommu->node,
> > -				 GFP_ATOMIC | __GFP_ZERO,
> > -				 order);
> > +				 GFP_ATOMIC | __GFP_ZERO, order);
> 
> This is a simple data structure allocation path, does it need
> GFP_ATOMIC?

will leave it to Baolu.

> 
> 	Joerg

Thanks,
Yi Liu
