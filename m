Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx48B0qs/qDFmIkv8H29G5zQ8LtrZXVk5yt+FUpYS9U8UV8EntPIG01q3n4nPDUDJ+Ij2p3zY
ARC-Seal: i=1; a=rsa-sha256; t=1524516051; cv=none;
        d=google.com; s=arc-20160816;
        b=1E10oB4xkw5hfJcyOC6YPmcSsnUTZxz6xYdRULBNZGuOwTQ9AZTzpSIVqtlx99xSX/
         qte/Z8Rkm1MNMTX43RgjbTkpUwY37sYcmY1t3xp4jCoTLzQSilbZt8mgJdOD+/BRTTZ/
         2lPJm/DrWVCL77OQ4wStH0HvBX3IcjpT0yalNrKe7XMdgQ9v/8GfT4kjpOh/wS1fNH5U
         vruQ90zZLmpcmgYuD6wwaDuwe/5sY6oMDrxVCHpM2cKizXGrVWOWTgIvjUA5+pClwxrb
         WX2eCloo5U7S2YeEBJuc1G48pzz0db7tZckkrdj7a6bg6kxkadecExVpdWqFoQ7w32j8
         nDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=wd8fgMEUsLEOVlhWbnIOJtoQSeeZ5E9cj1LUVaPTkrk=;
        b=EX1S78ldr3weZKp16prWO0CmFplKgpuZh3fNqLNxtKfUrqGar5vLZI7QLP92/gIC3W
         nV53/JuRLQhoXg7m6SnPiO9A5qCMU6nkjfGUgGw1UAHUXkVUemiXluLMgX84Bh9nAYHE
         gerQCUr7/arVO8FAfWrNqPg9Hq08FLzlXYb0KulhSI+yAs1rV8Wcj+OwUe4g4xzb5Jib
         KWSX8/ql0AGBmOZ0xZsppz3FnwWcS+kxGVBYX5Y7FfghtBkOQ4LNadiv0DhBcbGStaLK
         pMQUe4tqKdRhnlCzCGb995TDpm6Es+gC5QKoGH9FbznpvCX2o3CITO3xTfx+HYv10VoU
         40cA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,319,1520924400";
   d="scan'208";a="218794993"
Date: Mon, 23 Apr 2018 13:43:25 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok
 <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig
 <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi L"
 <yi.l.liu@linux.intel.com>, Liu@ostrya.localdomain,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Message-ID: <20180423134325.6780f6ac@jacob-builder>
In-Reply-To: <20180420181951.GA50099@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1598570943442195313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018 19:19:54 +0100
Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com> wrote:

> Hi Jacob,
> 
> On Mon, Apr 16, 2018 at 10:48:54PM +0100, Jacob Pan wrote:
> [...]
> > +/**
> > + * enum iommu_inv_granularity - Generic invalidation granularity
> > + *
> > + * When an invalidation request is sent to IOMMU to flush
> > translation caches,
> > + * it may carry different granularity. These granularity levels
> > are not specific
> > + * to a type of translation cache. For an example, PASID selective
> > granularity
> > + * is only applicable to PASID cache invalidation.  
> 
> I'm still confused by this, I think we should add more definitions
> because architectures tend to use different names. What you call
> "Translations caches" encompasses all caches that can be invalidated
> with this request, right? So all of:
> 
yes correct.
> * "TLB" and "DTLB" that cache IOVA->GPA and GPA->PA (TLB is in the
>   IOMMU, DTLB is an ATC in an endpoint),
> * "PASID cache" that cache PASID->Translation Table,
> * "Context cache" that cache RID->PASID table
> 
> Does this match the model you're using?
> 
yes. PASID cache and context caches are in the IOMMU.
> The last name is a bit unfortunate. Since the Arm architecture uses
> the name "context" for what a PASID points to, "Device cache" would
> suit us better but it's not important.
> 
or call it device context cache. actually so far context cache is here
only for completeness purpose. the expected use case is that QEMU traps
guest device context cache flush and call bind_pasid_table.

> I don't understand what you mean by "PASID selective granularity is
> only applicable to PASID cache invalidation", it seems to contradict
> the preceding sentence.
You are right. That was a mistake. I meant to say "These granularity
levels are specific to a type of"

> What if user sends an invalidation with
> IOMMU_INV_TYPE_TLB and IOMMU_INV_GRANU_ALL_PASID? Doesn't this remove
> from the TLBs all entries with the given PASID?
> 
No, this meant to invalidate all PASID of a given domain ID. I need to
correct the description.
The dilemma here is to map model specific fields into generic list. not
all combinations are legal.
> > + * This enum is a collection of granularities for all types of
> > translation
> > + * caches. The idea is to make it easy for IOMMU model specific
> > driver do
> > + * conversion from generic to model specific value.
> > + */
> > +enum iommu_inv_granularity {  
> 
> In patch 9, inv_type_granu_map has some valid fields with granularity
> == 0. Does it mean "invalidate all caches"?
> 
> I don't think user should ever be allowed to invalidate caches entries
> of devices and domains it doesn't own.
> 
Agreed, I removed global granu to avoid device invalidation beyond
device itself. But I missed some of the fields in
inv_type_granu_map{}. 
> > +	IOMMU_INV_GRANU_DOMAIN = 1,	/* all TLBs associated
> > with a domain */
> > +	IOMMU_INV_GRANU_DEVICE,		/* caching
> > structure associated with a
> > +					 * device ID
> > +					 */
> > +	IOMMU_INV_GRANU_DOMAIN_PAGE,	/* address range with
> > a domain */  
> 
> > +	IOMMU_INV_GRANU_ALL_PASID,	/* cache of a given
> > PASID */  
> 
> If this corresponds to QI_GRAN_ALL_ALL in patch 9, the comment should
> be "Cache of all PASIDs"? Or maybe "all entries for all PASIDs"? Is it
> different from GRANU_DOMAIN then?
QI_GRAN_ALL_ALL maps to VT-d spec 6.5.2.4, which invalidates all ext
TLB cache within a domain. It could reuse GRANU_DOMAIN but I was
also trying to match the naming convention in the spec.

> > +	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate
> > specified PASID */ +
> > +	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within
> > all PASIDs */
> > +	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a
> > PASIDs */  
> 
> Are the "NG" variant needed since there is a
> IOMMU_INVALIDATE_GLOBAL_PAGE below? We should drop either flag or
> granule.
> 
> FWIW I'm starting to think more granule options is actually better
> than flags, because it flattens the combinations and keeps them to two
> dimensions, that we can understand and explain with a table.
> 
> > +	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective
> > within a PASID */  
> 
> Maybe this should be called "NG_PAGE_PASID",
Sure. I was thinking page range already implies non-global pages.
> and "DOMAIN_PAGE" should
> instead be "PAGE_PASID". If I understood their meaning correctly, it
> would be more consistent with the rest.
> 
I am trying not to mix granu between request w/ PASID and w/o.
DOMAIN_PAGE meant to be for request w/o PASID.

> > +	IOMMU_INV_NR_GRANU,
> > +};
> > +
> > +/** enum iommu_inv_type - Generic translation cache types for
> > invalidation
> > + *
> > + * Invalidation requests sent to IOMMU may indicate which
> > translation cache
> > + * to be operated on.
> > + * Combined with enum iommu_inv_granularity, model specific driver
> > can do a
> > + * simple lookup to convert generic type to model specific value.
> > + */
> > +enum iommu_inv_type {  
> 
> These should be flags (1 << 0), (1 << 1) etc, since IOMMUs will want
> to invalidate multiple caches at once (at least DTLB and TLB). You
> could then do for_each_set_bit in the driver
> 
I was thinking the invalidation to be inclusive as we discussed earlier
,last year :).
TLB includes DLTB
PASID cache includes TLB and DTLB. I need to document it better.
> > +	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
> > +	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure cache
> > */
> > +	IOMMU_INV_TYPE_PASID,	/* PASID cache */
> > +	IOMMU_INV_TYPE_CONTEXT,	/* device context entry
> > cache */
> > +	IOMMU_INV_NR_TYPE
> > +};  
> 
> We need to summarize and explain valid combinations, because reading
> inv_type_granu_map and inv_type_granu_table is a bit tedious. I tried
> to reproduce inv_type_granu_map here (Cell format is PASID_TAGGED /
> !PASID_TAGGED). Could you check if this matches your model?
great summary. thanks
> 
>             type |   DTLB    |    TLB    |   PASID   |  CONTEXT
>  granule         |           |           |           |
> -----------------+-----------+-----------+-----------+-----------
>    -             |     / Y   |     / Y   |           |     / Y
what is this row?
>  DOMAIN          |           |     / Y   |           |     / Y
>  DEVICE          |           |           |           |     / Y
>  DOMAIN_PAGE     |           |     / Y   |           |
>  ALL_PASID       |   Y       |   Y       |           |
>  PASID_SEL       |   Y       |           |   Y       |
>  NG_ALL_PASID    |           |   Y       |   Y       |
>  NG_PASID        |           |   Y       |           |
>  PAGE_PASID      |           |   Y       |           |
> 
Mostly match what I intended for VT-d. Just one thing on the PASID
column, all PASID associated with a given domain ID can go either
NG_ALL_PASID (as in your table) or ALL_PASID.

Here is what I plan to change in comments that can reflect what you
have in the table above.
Can I also copy your table in the next version?

enum iommu_inv_granularity {
	IOMMU_INV_GRANU_DOMAIN = 1,	/* IOTLBs and device context
					 * cache associated with a
					 * domain ID
					 */

	IOMMU_INV_GRANU_DEVICE,		/* device context cache
					 * associated with a device ID
					 */

	IOMMU_INV_GRANU_DOMAIN_PAGE,	/* IOTLBs associated with
					 * address range of a
					 * given domain ID
					 */

        IOMMU_INV_GRANU_ALL_PASID,	/* DTLB or IOTLB of all
        				 * PASIDs associated to a
					 * given domain ID
					 */

	IOMMU_INV_GRANU_PASID_SEL,	/* DTLB and PASID cache
					 * associated to a PASID
					 */

	IOMMU_INV_GRANU_NG_ALL_PASID,	/* IOTLBs of non-global
					 * pages for all PASIDs for a
					 * given domain ID
				   	 */

	IOMMU_INV_GRANU_NG_PASID,	/* IOTLBs of non-global
					 * pages for a given PASID
					 */

   	IOMMU_INV_GRANU_PAGE_PASID,	/* IOTLBs of selected page
					 *  range within a PASID
					 */

> There is no intersection between PASID_TAGGED and !PASID_TAGGED (Y/Y),
> so the flag might not be needed.
> 
right

> I think the API can be more relaxed. Each IOMMU driver can add more
> restrictions, but I think the SMMU can support these combinations:
> 
>               |   DTLB    |    TLB    |   PASID   |  CONTEXT
> --------------+-----------+-----------+-----------+-----------
>  DOMAIN       |    Y      |     Y     |     Y     |     Y
>  DEVICE       |    Y      |     Y     |     Y     |     Y
>  DOMAIN_PAGE  |    Y      |     Y     |           |
>  ALL_PASID    |    Y      |     Y     |     Y     |
>  PASID_SEL    |    Y      |     Y     |     Y     |
>  NG_ALL_PASID |    Y      |     Y     |     Y     |
>  NG_PASID     |    Y      |     Y     |     Y     |
>  PAGE_PASID   |    Y      |     Y     |           |
> 
> Two are missing in the PASID column because it doesn't make any sense
> to target the PASID cache with a page-selective invalidation. And for
> the context cache, we can only invalidate per device or per domain.
> So I think this is the biggest set of allowed combinations.
> 
right, not all combinations are allowed, it is up to each IOMMU driver
to convert and sanitize based on a built-in valid map. e.g. in my vt-d
patch inv_type_granu_map[]
> 
> > +
> > +/**
> > + * Translation cache invalidation header that contains mandatory
> > meta data.
> > + * @version:	info format version, expecting future extesions
> > + * @type:	type of translation cache to be invalidated
> > + */
> > +struct tlb_invalidate_hdr {
> > +	__u32 version;
> > +#define TLB_INV_HDR_VERSION_1 1
> > +	enum iommu_inv_type type;
> > +};
> > +
> > +/**
> > + * Translation cache invalidation information, contains generic
> > IOMMU
> > + * data which can be parsed based on model ID by model specific
> > drivers.
> > + *
> > + * @granularity:	requested invalidation granularity, type
> > dependent
> > + * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB,
> > etc.  
> 
> Maybe start the size at 1 byte, we don't know what sort of granularity
> future architectures will offer.
> 
I can't see any case we are not operating at sub-page size. why would
anyone cache translation for 1 byte, that is too much overhead.
> > + * @pasid:		processor address space ID value per PCI
> > spec.
> > + * @addr:		page address to be invalidated
> > + * @flags	IOMMU_INVALIDATE_PASID_TAGGED: DMA with PASID
> > tagged,
> > + *						@pasid validity
> > can be
> > + *						deduced from
> > @granularity  
> 
> This is really hurting my brain... Two dimensions was already
> difficult, but I can't follow anymore. What does PASID_TAGGED say if
> not "@pasid is valid"? I thought VT-d mandated PASID for nested
> translation?
> 
you already have 3-D in your granu table :), this is the same as your
"Y" and "/Y" filed.
I need the PASID_TAGGED flag to differentiate different IOTLB types.
PASID_TAGGED is used only when @pasid is valid, which is implied in the
grnu. E.g. certain granu is only allowed for PASID tagged case.

> > + *		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries
> > + *		IOMMU_INVALIDATE_GLOBAL_PAGE: global pages
> > + *
> > + */
> > +struct tlb_invalidate_info {
> > +	struct tlb_invalidate_hdr	hdr;
> > +	enum iommu_inv_granularity	granularity;
> > +	__u32		flags;
> > +#define IOMMU_INVALIDATE_NO_PASID	(1 << 0)  
> 
> I suggested NO_PASID because Arm can have pasid-tagged and one
> no-pasid address spaces within the same domain in DSS0 mode. AMD
> would also need this for their GIoV mode, if I understood it
> correctly.
> 
> When specifying NO_PASID, the user invalidates mappings for the
> address space that doesn't have a PASID, but the same granularities
> as PASID contexts apply. I now think we can remove the NO_PASID flag
> and avoid a lot of confusion.
> 
> The GIoV and DSS0 modes are implemented by reserving entry 0 of the
> PASID table for NO_PASID translations. Given that the guest specifies
> this mode at BIND_TABLE time, the host understands that when the guest
> invalidates PASID 0, if GIoV or DSS0 was enabled, then the
> invalidation applies to the NO_PASID context. So you can drop this
> flag in my opinion.
> 
sounds good. PASID0 is used for request w/o PASID so both GIOVA and SVA
have PASIDs. Will drop.
> Thanks,
> Jean

[Jacob Pan]
