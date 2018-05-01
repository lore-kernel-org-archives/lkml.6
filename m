Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZo9e/LVKILlrC5GS96fWoQE+au4BGGE+umHYrK/N+Sawt8ioFl3EKyheggGFH6evn9GSbIf
ARC-Seal: i=1; a=rsa-sha256; t=1525215360; cv=none;
        d=google.com; s=arc-20160816;
        b=AWL8tpdqpFy2fSSy63FhC5Df2nlPf+VeEUSYdnoUlHuIB/ivy986zoLBl4xI+So7zs
         t7MzG4cf2PNSoYQrfDjOYEWMgVCHJjEvmgdp/Bh59Pg1jynyFCDOIqCs4ZSBl2WpJ9tc
         h4ba1gTYRpBKeJ7JFprob4Nd0C1CpzyIHcP7lA3ezidJE0g9r1lMNBoB6k49U79BbwmV
         Wr5Uu6WHRo3h6YmTfz4lRiCUQ6u9f1pCjR1mWh+Dw2IfudsPoOxYcXjCDra6Ssqc328z
         DTenLyjyC8jS9hEEJPNeYlUAXDN8nI389PchWtsAQF+tmifI2pf6dtJNaIo/sXGW4SSS
         62tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=fcHGj/+aIngVOeQT5h/10IITdK9puuFjxiIpN+0ftN8=;
        b=s1jmKnpkJ+MrlFd9+J9qIi7F2s9fIjKNN5nFqzOanNCxvNWpaqL6HPHmAJSiRDHkDd
         Eg3MEPHjyBXkJSiZGmGONlW1Ci9M7NY4UGIZAktqpiU66RIpUZG8Z1reMhgjhtCvqrEz
         CZxpdm0LB/g4S55PBUXcGsLMDBjhWyJCDK4QkQhZdIWWuZ3G+YmRyxw0b5JNpgepwTvI
         u3g7vpEPORi3ErL5kWQvvtusZYB2Qc3ntk+jSGGgCB0Xd1dz1tayVojs2oxn10UvgJeu
         9kUmcp9IOFKb8EKuEi6nVpZBQOaSAOo7R2agGGZW1T/6d+wuofncs4pkIdLI5LmHrq+v
         b8hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,352,1520924400";
   d="scan'208";a="55179909"
Date: Tue, 1 May 2018 15:58:38 -0700
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
Message-ID: <20180501155838.4ec3720c@jacob-builder>
In-Reply-To: <72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
	<20180423134325.6780f6ac@jacob-builder>
	<72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1599304221610863248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 19:07:43 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 23/04/18 21:43, Jacob Pan wrote:
> [...]
> >> The last name is a bit unfortunate. Since the Arm architecture uses
> >> the name "context" for what a PASID points to, "Device cache" would
> >> suit us better but it's not important.
> >>  
> > or call it device context cache. actually so far context cache is
> > here only for completeness purpose. the expected use case is that
> > QEMU traps guest device context cache flush and call
> > bind_pasid_table.   
> 
> Right, makes sense
> 
> [...]
> >> If this corresponds to QI_GRAN_ALL_ALL in patch 9, the comment
> >> should be "Cache of all PASIDs"? Or maybe "all entries for all
> >> PASIDs"? Is it different from GRANU_DOMAIN then?  
> > QI_GRAN_ALL_ALL maps to VT-d spec 6.5.2.4, which invalidates all ext
> > TLB cache within a domain. It could reuse GRANU_DOMAIN but I was
> > also trying to match the naming convention in the spec.  
> 
> Sorry I don't quite understand the difference between TLB and ext TLB
> invalidation. Can an ext TLB invalidation do everything a TLB can do
> plus some additional parameters (introduced in more recent version of
> the spec), or do they have distinct purposes? I'm trying to understand
> why it needs to be user-visible
> 
> >>> +	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate
> >>> specified PASID */ +
> >>> +	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within
> >>> all PASIDs */
> >>> +	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a
> >>> PASIDs */    
> >>
> >> Are the "NG" variant needed since there is a
> >> IOMMU_INVALIDATE_GLOBAL_PAGE below? We should drop either flag or
> >> granule.
> >>
> >> FWIW I'm starting to think more granule options is actually better
> >> than flags, because it flattens the combinations and keeps them to
> >> two dimensions, that we can understand and explain with a table.
> >>  
> >>> +	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective
> >>> within a PASID */    
> >>
> >> Maybe this should be called "NG_PAGE_PASID",  
> > Sure. I was thinking page range already implies non-global pages.  
> >> and "DOMAIN_PAGE" should
> >> instead be "PAGE_PASID". If I understood their meaning correctly,
> >> it would be more consistent with the rest.
> >>  
> > I am trying not to mix granu between request w/ PASID and w/o.
> > DOMAIN_PAGE meant to be for request w/o PASID.  
> 
> Is the distinction necessary? I understand the IOMMU side might offer
> many possibilities for invalidation, but the user probably doesn't
> need all of them. It might be easier to document, upstream and
> maintain if we only specify what's currently needed by users (what
> does QEMU VT-d use?) Others can always extend it by increasing the
> version.
> 
> Do you think that this invalidation message will be used outside of
> BIND_PASID_TABLE context? I can't see an other use but who knows. At
> the moment requests w/o PASID are managed with
> VFIO_IOMMU_MAP/UNMAP_DMA, which doesn't require invalidation. And in
> a BIND_PASID_TABLE context, IOMMUs requests w/o PASID are just a
> special case using PASID 0 (for Arm and AMD) so I suppose they'll use
> the same invalidation commands as requests w/ PASID.
> 
My understanding is that for GIOVA use case, VT-d vIOMMU creates
GIOVA-GPA mapping and the host shadows the 2nd level page tables to
create GIOVA-HPA mapping. So when assigned device in the guest can do
both DMA map/unmap and VFIO map/unmap, VFIO unmap is one time deal
(I guess invalidation can be captured in other code path), but guest
kernel use of DMA unmap could will trigger invalidation. QEMU needs to
trap those invalidation and passdown to physical IOMMU. So we do need
invalidation w/o PASID.

> >>> +	IOMMU_INV_NR_GRANU,
> >>> +};
> >>> +
> >>> +/** enum iommu_inv_type - Generic translation cache types for
> >>> invalidation
> >>> + *
> >>> + * Invalidation requests sent to IOMMU may indicate which
> >>> translation cache
> >>> + * to be operated on.
> >>> + * Combined with enum iommu_inv_granularity, model specific
> >>> driver can do a
> >>> + * simple lookup to convert generic type to model specific value.
> >>> + */
> >>> +enum iommu_inv_type {    
> >>
> >> These should be flags (1 << 0), (1 << 1) etc, since IOMMUs will
> >> want to invalidate multiple caches at once (at least DTLB and
> >> TLB). You could then do for_each_set_bit in the driver
> >>  
> > I was thinking the invalidation to be inclusive as we discussed
> > earlier ,last year :).
> > TLB includes DLTB
> > PASID cache includes TLB and DTLB. I need to document it better.  
> 
> Ah right, I guess I was stuck on an old version :) Then the current
> values make sense
> 
> >>> +	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
> >>> +	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure
> >>> cache */
> >>> +	IOMMU_INV_TYPE_PASID,	/* PASID cache */
> >>> +	IOMMU_INV_TYPE_CONTEXT,	/* device context entry
> >>> cache */
> >>> +	IOMMU_INV_NR_TYPE
> >>> +};    
> >>
> >> We need to summarize and explain valid combinations, because
> >> reading inv_type_granu_map and inv_type_granu_table is a bit
> >> tedious. I tried to reproduce inv_type_granu_map here (Cell format
> >> is PASID_TAGGED / !PASID_TAGGED). Could you check if this matches
> >> your model?  
> > great summary. thanks  
> >>
> >>             type |   DTLB    |    TLB    |   PASID   |  CONTEXT
> >>  granule         |           |           |           |
> >> -----------------+-----------+-----------+-----------+-----------
> >>    -             |     / Y   |     / Y   |           |     / Y  
> > what is this row?  
> 
> Hm, the arrays in patch 9 have 9 entries, this is entry 0 (for which I
> asked if it corresponded to "invalidate all caches" in my previous
> reply).
> 
I see, I have removed global invalidation. So we can remove this row.
> >>  DOMAIN          |           |     / Y   |           |     / Y
> >>  DEVICE          |           |           |           |     / Y
> >>  DOMAIN_PAGE     |           |     / Y   |           |
> >>  ALL_PASID       |   Y       |   Y       |           |
> >>  PASID_SEL       |   Y       |           |   Y       |
> >>  NG_ALL_PASID    |           |   Y       |   Y       |
> >>  NG_PASID        |           |   Y       |           |
> >>  PAGE_PASID      |           |   Y       |           |
> >>  
> > Mostly match what I intended for VT-d. Just one thing on the PASID
> > column, all PASID associated with a given domain ID can go either
> > NG_ALL_PASID (as in your table) or ALL_PASID.
> > 
> > Here is what I plan to change in comments that can reflect what you
> > have in the table above.
> > Can I also copy your table in the next version?  
> 
> Sure
> 
> (For the patch, putting all descriptions in a single comment at the
> top of the enum would be better)
> 
ok, will do.
> > enum iommu_inv_granularity {
> > 	IOMMU_INV_GRANU_DOMAIN = 1,	/* IOTLBs and device
> > context
> > 					 * cache associated with a
> > 					 * domain ID
> > 					 */
> > 
> > 	IOMMU_INV_GRANU_DEVICE,		/* device context
> > cache
> > 					 * associated with a device
> > ID */
> > 
> > 	IOMMU_INV_GRANU_DOMAIN_PAGE,	/* IOTLBs associated
> > with
> > 					 * address range of a
> > 					 * given domain ID
> > 					 */  
> 
> Another nit: it might be easier to understand if we sort these values
> by "coarseness". DOMAIN_PAGE seems finer than ALL_PASID or PASID_SEL
> because it doesn't nuke all TLB entries of an address space, so might
> make more sense to move it at the bottom. Though as said above, I
> don't think we should distinguish between DOMAIN_PAGE and PAGE_PASID
> 

It is hard to sort by coarseness when we cross different types. If you
are convinced that we do need w/o PASID case, can we keep both
DOMAIN_PAGE and PAGE_PASID?

> > 
> >         IOMMU_INV_GRANU_ALL_PASID,	/* DTLB or IOTLB of all
> >         				 * PASIDs associated to a
> > 					 * given domain ID
> > 					 */
> > 
> > 	IOMMU_INV_GRANU_PASID_SEL,	/* DTLB and PASID cache
> > 					 * associated to a PASID
> > 					 */  
> 
> This comment has "DTLB", the previous had "DTLB or IOTLB", and the
> first one had "IOTLBs". But doesn't the TLB selection, either DTLB or
> "DTLB+IOTLB", depend on iommu_inv_type? So maybe saying "TLB entries"
> everywhere in the granule comments is good enough?
> 
Since not all inv_types and granu combinations are valid, I was trying
to give additional info so that people can understand certain granu
only apply to certain types. I guess your truth table explains the same
information better, I will rename them to TLB entries.


> > 	IOMMU_INV_GRANU_NG_ALL_PASID,	/* IOTLBs of non-global
> > 					 * pages for all PASIDs for
> > a
> > 					 * given domain ID
> > 				   	 */
> > 
> > 	IOMMU_INV_GRANU_NG_PASID,	/* IOTLBs of non-global
> > 					 * pages for a given PASID
> > 					 */
> > 
> >    	IOMMU_INV_GRANU_PAGE_PASID,	/* IOTLBs of selected
> > page
> > 					 *  range within a PASID
> > 					 */  
> 
> I think the other comments are fine
> 
> [...]
> >>> + * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB,
> >>> etc.    
> >>
> >> Maybe start the size at 1 byte, we don't know what sort of
> >> granularity future architectures will offer.
> >>  
> > I can't see any case we are not operating at sub-page size. why
> > would anyone cache translation for 1 byte, that is too much
> > overhead.  
> 
> 1 bytes is probably overkill, but why not 2048 for TCP packets... we
> don't really know what strange ideas people will come up with. But
> you're right, it's unlikely.
> 
> However I thought about this more and we are actually missing
> something. Some architectures will have arbitrary ranges in their
> invalidation commands, they might want to invalidate three pages at a
> time without sending three invalidation commands. Having a page
> granularity is good, because users might want to invalidate huge TLB,
> but we should also have a number of pages.
> 
> Could you add a nr_pages parameter?
> 
> 	@size: one page is 2^size (*4k?) bytes
> 	@nr_pages: number of pages to invalidate
> 
> 	u8 size
> 	u64 nr_pages
> 
That sounds good. VT-d DTLB size is implied in the address bits. but it
better to open code here to accommodate all.
> Sorry about the late changes, I don't want to slow this down and I
> think we're nearly there, but this last point seems important.
> 
> Thanks,
> Jean
