Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpGM+wzC85NLlM7Uo2UeDKYOEdhppF+2+gYwmxX410QdI0kfAw8wo2VEYRG1o7VpJxQ57Oe
ARC-Seal: i=1; a=rsa-sha256; t=1526329669; cv=none;
        d=google.com; s=arc-20160816;
        b=tTgr1zqH6RoObimAoCEIZTkfeeFQMIdDRQguojrOjBEsSEysSCinptVQrOM2E9v23A
         DM147sma5GXsCvLUrGQ/sGnavyuN+frLmFZlZCJgoewfftA0v5hDx+ozffiH6D16H0CU
         PQkV2+5VwEiCk9ux+pBsxAM+vDUnt8A3IGbjwP2Vbe2bLMLAwxWdzLcJ+qRT/nTuiBk4
         ue/JroAvmoamjPqLDNLL5C/rHIEK3xeEQNoakBqlYN7izUotyMYhDoiRLaEr69Q2W1rz
         pwcVWDrzvmDHz7aMqxQu6SaL+QC5dsz/42FSONBAuJvv0sCWHKxSxKDZm9pDe51xLqEt
         8HJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=kAVe9Q8k1xNeGREuUu+6KkbV8y85g62H8A/uJoJ+658=;
        b=YQlQh7NmBSojbeQ0zHnM4X+X84oGoXJ1NUdl8Ayikja+iIb/vE5igKqKcrgo3lVwBU
         yXTIDi3OtRxp6yCozF4Gr9PYCVWIdE32hfhrNJifL5GTbATAcYKvL8zKjA4F690Lfl6k
         UoPEbxDVARDjAzf0b/i7cBIMDel+a1tDzB5tQHSHfg5qTGKzx4UgHutfk/ez+elqyitZ
         9tH1Ow87T9EXRJXszFCfJSL8Z5QjkIvp+qT5+z2O1NpYSEUEcIPbXAdw/5WZOd4Vblsu
         5+D9usXpsWoN+cTKeR6P3a/GC0Idk++wnyK4nnTrgLlyNfonDwiwn/ryN6iTdxgc6xfq
         wa3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="228419675"
Date: Mon, 14 May 2018 13:30:34 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 06/23] iommu/vt-d: add definitions for PFSID
Message-ID: <20180514133034.54aaf4ed@jacob-builder>
In-Reply-To: <5AF8E808.5030402@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-7-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF8E808.5030402@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362182382878?=
X-GMAIL-MSGID: =?utf-8?q?1600472659810162782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 09:36:08 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 05/12/2018 04:53 AM, Jacob Pan wrote:
> > When SRIOV VF device IOTLB is invalidated, we need to provide
> > the PF source ID such that IOMMU hardware can gauge the depth
> > of invalidation queue which is shared among VFs. This is needed
> > when device invalidation throttle (DIT) capability is supported.
> >
> > This patch adds bit definitions for checking and tracking PFSID.  
> 
> Patch 6 and 7 could be posted in a separated patch series.
> 
Thought about that also, but we need to include PFSID passdown
invalidation in this patchset, that is why i prefer to include
this fix, otherwise this patchset will continue to be wrong.
> >
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/linux/intel-iommu.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index ddc7d79..dfacd49 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -114,6 +114,7 @@
> >   * Extended Capability Register
> >   */
> >  
> > +#define ecap_dit(e)		((e >> 41) & 0x1)
> >  #define ecap_pasid(e)		((e >> 40) & 0x1)
> >  #define ecap_pss(e)		((e >> 35) & 0x1f)
> >  #define ecap_eafs(e)		((e >> 34) & 0x1)
> > @@ -284,6 +285,7 @@ enum {
> >  #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
> >  #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
> >  #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) &
> > VTD_PAGE_MASK) +#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid &
> > 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48)) #define
> > QI_DEV_IOTLB_SIZE	1 #define QI_DEV_IOTLB_MAX_INVS	32
> >  
> > @@ -308,6 +310,7 @@ enum {
> >  #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
> >  #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
> >  #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
> > +#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) |
> > ((u64)(pfsid & 0xff0) << 48))  
> 
> PFSID[15:4] are stored in Descriptor [63:52], hence it should look
> like:
> 
> +#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) |
> ((u64)(pfsid & 0xfff0) << 48))
> 
> 
good catch! thanks.
> 
> >  #define QI_DEV_EIOTLB_MAX_INVS	32
> >  
> >  #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
> > @@ -467,6 +470,7 @@ struct device_domain_info {
> >  	struct list_head global; /* link to global list */
> >  	u8 bus;			/* PCI bus number */
> >  	u8 devfn;		/* PCI devfn number */
> > +	u16 pfsid;		/* SRIOV physical function
> > source ID */ u8 pasid_supported:3;
> >  	u8 pasid_enabled:1;
> >  	u8 pri_supported:1;  
> 
> Best regards,
> Lu Baolu
