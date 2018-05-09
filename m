Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpYLZDY8MyNKtbSJxMshXwCW/Z4FS6AQo9ThRB0GLiMTI35BCb9HEwaEp/6T9GiqDH7vPyv
ARC-Seal: i=1; a=rsa-sha256; t=1525870367; cv=none;
        d=google.com; s=arc-20160816;
        b=io6jXmqRfu091cpILCmfkL+Oo4xXGWsFJ5yJJMiipGmStr7FIBjxu4vcf0EZvAwbM8
         k1UCkIjK0WHpN3vNy4CYna/KJHerad5f9XlB91EIiLNvO0gPyRb+krR7pPUs9LhN6snx
         9kRK2rjdSMa4+GjTPRn0BlZ2lE2rSGTWrVpZ9wLym3vE48NV6p1VgNJyROo55BP6G5Yq
         TfeDAGXLZO7R+xQqsEyMo+gqQGxg/DAUd6RtrEoAk9TM3sVN6r+bMhImuL0WGDQYfNjY
         KGIUGS2RGkSB0Ho/3MmrhW7ImCVgIML/TA4LChuqJKM+jsVY6H7WeMEhmDWcJHqNoMEG
         tNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=sZ3PTxxJpmEVxKM2xwhPDKBcG8CHHX5IFkN9Z2znJrM=;
        b=yCnx0Djvujax98YzxjPKHG01wYqWx7Q0HMy3Z4O6JXp1NOtCm35+4H57HUDdt1jdxd
         U8DnEcmtB7sBPmQvgs9pX5DLWb4a5OPoLSz249DNDJet2osI7ur/prpP5NOdlN9+D9IL
         bRdV12pRH+h6OoULz5runrZISi6qiHTxuzid70y3s43jmMngspJZkql0dlAEWHIge+Bo
         Zzw+/L/ltjAe45HvWnhyAAcmb1cOth+aT89C6mjzpNSCZr38okD5MhZEj8twLJRf97o1
         5tx5bbMJXj9xQoL+yPlAQwf9ePBu0hG7eVaTdyeLrJ8IB6kGftargsFuU0/uICIydMfW
         lLFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="49481240"
Date: Wed, 9 May 2018 05:55:30 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok
 <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig
 <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi L"
 <yi.l.liu@linux.intel.com>, "Liu@ostrya.localdomain"
 <Liu@ostrya.localdomain>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Message-ID: <20180509055530.166ab2a6@jacob-builder>
In-Reply-To: <ef462e73-01e3-d581-cf91-3e012a337c61@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
	<20180423134325.6780f6ac@jacob-builder>
	<72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
	<20180501155838.4ec3720c@jacob-builder>
	<b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
	<20180503214616.51553247@jacob-builder>
	<20180504110706.3392a98e@jacob-builder>
	<ef462e73-01e3-d581-cf91-3e012a337c61@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1599991046152317359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 8 May 2018 11:35:00 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi Jacob,
> 
> Looks mostly good to me, I just have a couple more comments
> 
> On 04/05/18 19:07, Jacob Pan wrote:
> > Now the passdown invalidation granularities look like:
> > (sorted by coarseness), will send out in v5 patchset soon if no
> > issues.
> > 
> > /**
> >  * enum iommu_inv_granularity - Generic invalidation granularity
> >  *
> >  * @IOMMU_INV_GRANU_DOMAIN:		Device context cache
> > associated with a
> >  *					domain ID.
> >  * @IOMMU_INV_GRANU_DEVICE:		Device context cache
> > associated with a
> >  *					device ID
> >  * @IOMMU_INV_GRANU_DOMAIN_ALL_PASID:	TLB entries or PASID
> > caches of all
> >  *					PASIDs associated with a
> > domain ID
> >  * @IOMMU_INV_GRANU_PASID_SEL:		TLB entries or PASID
> > cache associated
> >  *					with a PASID and a domain
> >  * @IOMMU_INV_GRANU_PAGE_PASID:		TLB entries of
> > selected page range
> >  *					within a PASID
> >  *
> >  * When an invalidation request is passed down to IOMMU to flush
> > translation
> >  * caches, it may carry different granularity levels, which can be
> > specific
> >  * to certain types of translation caches. For an example, PASID
> > selective
> >  * granularity is only applicable PASID cache and IOTLB
> > invalidation but for
> >  * device context caches.  
> 
> Should it be "PASID selective granularity is only applicable to PASID
> cache and IOTLB but not device context caches"?
> 
right, thanks!
> >  * This enum is a collection of granularities for all types of
> > translation
> >  * caches. The idea is to make it easy for IOMMU model specific
> > driver to
> >  * convert from generic to model specific value. Not all
> > combinations between
> >  * translation caches and granularity levels are valid. Each IOMMU
> > driver
> >  * can enforce check based on its own conversion table. The
> > conversion is
> >  * based on 2D look-up with inputs as follows:
> >  * - translation cache types
> >  * - granularity
> >  * No global granularity is allowed in that passdown invalidation
> > for an
> >  * assigned device should only impact the device or domain itself.  
> 
> That last sentence is a bit confusing, because "global granularity"
> might also refer to the "global" TLB flag which is allowed. In my
> opinion you can leave this rationale out, I doubt userspace will ever
> demand a mechanism for global invalidation.
> 
yes, i can leave the last sentence out.
> >  *
> >  *             type |   DTLB    |    TLB    |   PASID   |  CONTEXT
> >  *  granule         |           |           |           |
> >  * -----------------+-----------+-----------+-----------+-----------
> >  *  DOMAIN          |           |           |           |     Y
> >  *  DEVICE          |           |           |           |     Y  
> 
> I can't really see a use-case for DOMAIN and DEVICE. It might make
> more sense to keep only DN_ALL_PASID, which would then also
> invalidate the device context cache. But since they will be very rare
> events, factoring them doesn't seem important.
> 
ok. we have no use for now either, was there for completeness. i will
remove for now.
> >  *  DN_ALL_PASID    |   Y       |   Y       |   Y       |
> >  *  PASID_SEL       |   Y       |   Y       |   Y       |
> >  *  PAGE_PASID      |           |   Y       |           |  
> 
> Why not allow PAGE_PASID+DTLB? We need a way to invalidate individual
> DTLB entries
> 
I was thinking PAGE_PASID+TLB includes PAGE_PASID+DTLB, but you are
right, DTLB should be a 'Y' here.
> Thanks,
> Jean

[Jacob Pan]
