Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoljA756rO3ahsvHybZwi7qP6DIHCmt/tQVv6RS2Ka24+UYFm4eO8rqi4Mb3qygprR7d5MA
ARC-Seal: i=1; a=rsa-sha256; t=1525457066; cv=none;
        d=google.com; s=arc-20160816;
        b=RgPTrQ7QX9lBOcQHDuY8rnAoK680tFjAmknGAMoctFqdgVlnKw+yeQhsGz0hO4uj7l
         SweX5pa52YIGF3CNF1h+sS3R6yUhaiRAMBhL04y1d5AS4WvlxRGMiSzDvMKcxNQJuzr0
         g8xeMnqoIezBiPAaJsWXeINrhDJLcG7YvdaDNUlN4hujEAz0bDUH7MJAmPcd9pcI1tGr
         fzlAZSYtDYm/h4/10iLOi68qDJJllH8IlKcaSa+xwr6SnqjJi0hUo/GfSMrzwDMt0Bo5
         zxGMdwkQu/VIo7IFhj6jMr8lBQB+nedsRarl0N8dBl39451UE3/Hz109a4zGu1/vYNdz
         WgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=qJivs1iq/X4rMtcTyODh0zwa4GFqufSoDnTJ3HSnriE=;
        b=R0wbrG09C/yhqYnhVhMbvfo6+7P21qUXrvovw2pZ66xpfgL4lnIvmEpur9lDbDlQy1
         99EyPnv17q3tMviVg4M1dYBoTXK2UaagDsZP4Oqk1I3oL6bl6sopCM8qUbfpwVXwdjXG
         K7yvgJceWoWGbpaufRuX2FK/isIxD9qR9+Arq38SsO1RpgHvbcuznMU6f/pUZFTtzeQJ
         etaI3XWiBUfEjV0R4tPQus2r8OQrFDJL7ylODjjk6MLJv6cZHMQtIdhe7JaHR1oYVrxS
         QEOKVODGIYNd2tach5pZetxekwVC2yZHQPOrio8+ahNCpIZjPNHFcpMUwCUqFM+bErgo
         zrUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="53245372"
Date: Fri, 4 May 2018 11:07:06 -0700
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
Message-ID: <20180504110706.3392a98e@jacob-builder>
In-Reply-To: <20180503214616.51553247@jacob-builder>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
	<20180423134325.6780f6ac@jacob-builder>
	<72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
	<20180501155838.4ec3720c@jacob-builder>
	<b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
	<20180503214616.51553247@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1599557669062262543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 3 May 2018 21:46:16 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> On Wed, 2 May 2018 10:31:50 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
> > On 01/05/18 23:58, Jacob Pan wrote:  
> > >>>> Maybe this should be called "NG_PAGE_PASID",      
> > >>> Sure. I was thinking page range already implies non-global
> > >>> pages.      
> > >>>> and "DOMAIN_PAGE" should
> > >>>> instead be "PAGE_PASID". If I understood their meaning
> > >>>> correctly, it would be more consistent with the rest.
> > >>>>      
> > >>> I am trying not to mix granu between request w/ PASID and w/o.
> > >>> DOMAIN_PAGE meant to be for request w/o PASID.      
> > >>
> > >> Is the distinction necessary? I understand the IOMMU side might
> > >> offer many possibilities for invalidation, but the user probably
> > >> doesn't need all of them. It might be easier to document,
> > >> upstream and maintain if we only specify what's currently needed
> > >> by users (what does QEMU VT-d use?) Others can always extend it
> > >> by increasing the version.
> > >>
> > >> Do you think that this invalidation message will be used outside
> > >> of BIND_PASID_TABLE context? I can't see an other use but who
> > >> knows. At the moment requests w/o PASID are managed with
> > >> VFIO_IOMMU_MAP/UNMAP_DMA, which doesn't require invalidation. And
> > >> in a BIND_PASID_TABLE context, IOMMUs requests w/o PASID are
> > >> just a special case using PASID 0 (for Arm and AMD) so I suppose
> > >> they'll use the same invalidation commands as requests w/ PASID.
> > >>    
> > > My understanding is that for GIOVA use case, VT-d vIOMMU creates
> > > GIOVA-GPA mapping and the host shadows the 2nd level page tables
> > > to create GIOVA-HPA mapping. So when assigned device in the guest
> > > can do both DMA map/unmap and VFIO map/unmap, VFIO unmap is one
> > > time deal (I guess invalidation can be captured in other code
> > > path), but guest kernel use of DMA unmap could will trigger
> > > invalidation. QEMU needs to trap those invalidation and passdown
> > > to physical IOMMU. So we do need invalidation w/o PASID.    
> > 
> > Hm, isn't this all done by host userspace? Whether guest does DMA
> > map/unmap or VFIO map/unmap, it creates/removes IOVA-GPA mappings in
> > the vIOMMU. QEMU captures invalidation requests for these mappings
> > from the guest, finds GPA-HVA in the shadow map and sends a VFIO
> > map/unmap request for IOVA-HVA.
> >   
> Sorry for the delay but you are right, I have also confirmed with Yi
> that we don't need second level invalidation. I will remove IOTLB
> invalidation w/o PASID case from the API.
> 
Now the passdown invalidation granularities look like:
(sorted by coarseness), will send out in v5 patchset soon if no issues.

/**
 * enum iommu_inv_granularity - Generic invalidation granularity
 *
 * @IOMMU_INV_GRANU_DOMAIN:		Device context cache associated with a
 *					domain ID.
 * @IOMMU_INV_GRANU_DEVICE:		Device context cache associated with a
 *					device ID
 * @IOMMU_INV_GRANU_DOMAIN_ALL_PASID:	TLB entries or PASID caches of all
 *					PASIDs associated with a domain ID
 * @IOMMU_INV_GRANU_PASID_SEL:		TLB entries or PASID cache associated
 *					with a PASID and a domain
 * @IOMMU_INV_GRANU_PAGE_PASID:		TLB entries of selected page range
 *					within a PASID
 *
 * When an invalidation request is passed down to IOMMU to flush translation
 * caches, it may carry different granularity levels, which can be specific
 * to certain types of translation caches. For an example, PASID selective
 * granularity is only applicable PASID cache and IOTLB invalidation but for
 * device context caches.
 * This enum is a collection of granularities for all types of translation
 * caches. The idea is to make it easy for IOMMU model specific driver to
 * convert from generic to model specific value. Not all combinations between
 * translation caches and granularity levels are valid. Each IOMMU driver
 * can enforce check based on its own conversion table. The conversion is
 * based on 2D look-up with inputs as follows:
 * - translation cache types
 * - granularity
 * No global granularity is allowed in that passdown invalidation for an
 * assigned device should only impact the device or domain itself.
 *
 *             type |   DTLB    |    TLB    |   PASID   |  CONTEXT
 *  granule         |           |           |           |
 * -----------------+-----------+-----------+-----------+-----------
 *  DOMAIN          |           |           |           |     Y
 *  DEVICE          |           |           |           |     Y
 *  DN_ALL_PASID    |   Y       |   Y       |   Y       |
 *  PASID_SEL       |   Y       |   Y       |   Y       |
 *  PAGE_PASID      |           |   Y       |           |
 *
 */
enum iommu_inv_granularity {
	IOMMU_INV_GRANU_DOMAIN,
	IOMMU_INV_GRANU_DEVICE,
	IOMMU_INV_GRANU_DOMAIN_ALL_PASID,
	IOMMU_INV_GRANU_PASID_SEL,
	IOMMU_INV_GRANU_PAGE_PASID,
	IOMMU_INV_NR_GRANU,
};


> Thanks,
> 
> > Thanks,
> > Jean
> >   
> 
> [Jacob Pan]

[Jacob Pan]
