Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqI4okcqP+ObT0W3qd5vSX03zKVCkNPFoq8L4H7DdbqpuiEAHrUE6+3zN2lVMyG7e0ZVKaH
ARC-Seal: i=1; a=rsa-sha256; t=1525409016; cv=none;
        d=google.com; s=arc-20160816;
        b=EoTuEgVXg1vet6X1Sj2DbuRfNyBJq/m6jpt/DhIGq+AUwPu667e6PUilVBbeTlNcNL
         ld70p//kEUrq0ONBf3eO9e3RuosliSKE4tjl63/I2xN5XXlGzmVYRE69xoStQwsIMLI6
         bv1pJ7gIbhnb3zrZg9F67fpgaiHIfLw6+eWXHOZu7EeCT9PBg9jd+0/vHPPWjMmuDHHH
         csboqVPznl6e+KNqN5Icf4MLK2sy93lY84ByGas8Benp7gPmDEs4PaTbWmOkOg33oEJu
         GkBCX0lnx9hSmFRuTWgi+vHDJxWCAkA54GX4Q2qNb2pMY7mPuzoL8RKqLplxPdffNL5Y
         FGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=jDxow1AR4SrfaBxdTg1QxNahvHHP5zbWhXh7/Ry3yrk=;
        b=mmyjuOLoIgQy7jb8+Y675BdatbgXCOzDXkz0N3RPW+080aqQdT3rHvyD0RtPCMwbKv
         TPMNPPfnuGumdvicSHpzZxNff7r6ZHPyqIn+bXeAmiX9sqpHNVCjm0c8Kj3BA4DU6GDO
         RTEp23FrURd6BRqvkDSs5beI6cgk+zJ1Sk+E63K6SQmmOxLfW6iDk+51NpzzZkjeXzWJ
         y4Ib+GDOhbRyj8EuiJJp1CeRnyOdUyOxXS2lHkmwbl+6PCZ+bW5YRC5HmLxNL3kivaUf
         Wn+XwBC/rKH7Sg50yKasN6JxFVdgOQr+xNyBaVuMuFpEfTlfPXb9Q9I7nffWWZaycwDz
         apzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,361,1520924400";
   d="scan'208";a="53085446"
Date: Thu, 3 May 2018 21:46:16 -0700
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
Message-ID: <20180503214616.51553247@jacob-builder>
In-Reply-To: <b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180420181951.GA50099@ostrya.localdomain>
	<20180423134325.6780f6ac@jacob-builder>
	<72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
	<20180501155838.4ec3720c@jacob-builder>
	<b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1599507285592477651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2 May 2018 10:31:50 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 01/05/18 23:58, Jacob Pan wrote:
> >>>> Maybe this should be called "NG_PAGE_PASID",    
> >>> Sure. I was thinking page range already implies non-global
> >>> pages.    
> >>>> and "DOMAIN_PAGE" should
> >>>> instead be "PAGE_PASID". If I understood their meaning correctly,
> >>>> it would be more consistent with the rest.
> >>>>    
> >>> I am trying not to mix granu between request w/ PASID and w/o.
> >>> DOMAIN_PAGE meant to be for request w/o PASID.    
> >>
> >> Is the distinction necessary? I understand the IOMMU side might
> >> offer many possibilities for invalidation, but the user probably
> >> doesn't need all of them. It might be easier to document, upstream
> >> and maintain if we only specify what's currently needed by users
> >> (what does QEMU VT-d use?) Others can always extend it by
> >> increasing the version.
> >>
> >> Do you think that this invalidation message will be used outside of
> >> BIND_PASID_TABLE context? I can't see an other use but who knows.
> >> At the moment requests w/o PASID are managed with
> >> VFIO_IOMMU_MAP/UNMAP_DMA, which doesn't require invalidation. And
> >> in a BIND_PASID_TABLE context, IOMMUs requests w/o PASID are just a
> >> special case using PASID 0 (for Arm and AMD) so I suppose they'll
> >> use the same invalidation commands as requests w/ PASID.
> >>  
> > My understanding is that for GIOVA use case, VT-d vIOMMU creates
> > GIOVA-GPA mapping and the host shadows the 2nd level page tables to
> > create GIOVA-HPA mapping. So when assigned device in the guest can
> > do both DMA map/unmap and VFIO map/unmap, VFIO unmap is one time
> > deal (I guess invalidation can be captured in other code path), but
> > guest kernel use of DMA unmap could will trigger invalidation. QEMU
> > needs to trap those invalidation and passdown to physical IOMMU. So
> > we do need invalidation w/o PASID.  
> 
> Hm, isn't this all done by host userspace? Whether guest does DMA
> map/unmap or VFIO map/unmap, it creates/removes IOVA-GPA mappings in
> the vIOMMU. QEMU captures invalidation requests for these mappings
> from the guest, finds GPA-HVA in the shadow map and sends a VFIO
> map/unmap request for IOVA-HVA.
> 
Sorry for the delay but you are right, I have also confirmed with Yi
that we don't need second level invalidation. I will remove IOTLB
invalidation w/o PASID case from the API.

Thanks,

> Thanks,
> Jean
> 

[Jacob Pan]
