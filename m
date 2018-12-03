Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8ECC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2C2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B2C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeLCRXm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:23:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:59872 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeLCRXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:23:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 09:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="300608467"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 03 Dec 2018 09:23:38 -0800
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 3 Dec 2018 09:23:38 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 3 Dec 2018 09:23:37 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.203]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.201]) with mapi id 14.03.0415.000;
 Tue, 4 Dec 2018 01:23:35 +0800
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
Subject: RE: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Topic: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Index: AQHUhs6VrgeNMu20h0WMLIZiTwAaWqVsiiUAgAC/u+A=
Date:   Mon, 3 Dec 2018 17:23:35 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D838AB@SHSMSX104.ccr.corp.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-5-baolu.lu@linux.intel.com>
 <20181203134856.lui4us4ejm4d5avz@8bytes.org>
In-Reply-To: <20181203134856.lui4us4ejm4d5avz@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2QyYTEzODEtYmRjMC00NDhlLThmNDMtOGU4NmQ2NWNhZWM2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR0hSNmplRnVNcHgrVG5hbFk0Y3lvTk4wWnI5ZWVmdFlvejZtcVdRcDBVdklETTJOc0liWm1sNXRWcXhNY2NPNiJ9
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
> Sent: Monday, December 3, 2018 5:49 AM
> To: Lu Baolu <baolu.lu@linux.intel.com>
> Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
> support
> 
> On Wed, Nov 28, 2018 at 11:54:41AM +0800, Lu Baolu wrote:
> > -
> > -	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
> 0);
> > +	/*
> > +	 * Need two pages to accommodate 256 descriptors of 256 bits each
> > +	 * if the remapping hardware supports scalable mode translation.
> > +	 */
> > +	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
> > +				     !!ecap_smts(iommu->ecap));
> 
> 
> Same here, does the allocation really need GFP_ATOMIC?

still leave to Baolu.

> 
> >  struct q_inval {
> >  	raw_spinlock_t  q_lock;
> > -	struct qi_desc  *desc;          /* invalidation queue */
> > +	void		*desc;          /* invalidation queue */
> >  	int             *desc_status;   /* desc status */
> >  	int             free_head;      /* first free entry */
> >  	int             free_tail;      /* last free entry */
> 
> Why do you switch the pointer to void* ?

In this patch, there is some code like the code below. It calculates
destination address of memcpy with qi->desc. If it's still struct qi_desc
pointer, the calculation result would be wrong.

+			memcpy(desc, qi->desc + (wait_index << shift),
+			       1 << shift);

The change of the calculation method is to support 128 bits invalidation
descriptors and 256 invalidation descriptors in this unified code logic.

Also, the conversation between Baolu and me may help.

https://lore.kernel.org/patchwork/patch/1006756/

> 
> 	Joerg

Thanks,
Yi Liu
