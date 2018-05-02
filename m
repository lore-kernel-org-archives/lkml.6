Return-Path: <jean-philippe.brucker@arm.com>
X-Google-Smtp-Source: AB8JxZr85/VPORWEWtxljlu0UNp8ssA3f8rglxPPUdILioEOPqqoiDUO50Hh9VpdlOixeRlX38L3
ARC-Seal: i=1; a=rsa-sha256; t=1525253520; cv=none;
        d=google.com; s=arc-20160816;
        b=BWL0g6gw/LEbdYRa39lfeKFuAl7UeEb4SP53dqXHYQq+jjcCQBfZJFWHvYb5QISqKd
         B9lleoT2y0dvD34IJt6pZfvNe6cqJ2C2H1sNtXYr4/rjBaXVX2npg70GOGh/iHj3XqCi
         RVHJC4WyrxH+zWYLTixg+32wK92SaZLNyk+5j4F8pBpQynNKt99heFR7hlKRuls2ZXOo
         OwRg8QVvGCtogSU0Y6ge4EcRHTF3z71e5sLs7ASSKz33bdRshZzpeZOXVWn7M2QTv2hK
         lAeYoCQrO0potHg/tUO7WakDLhLyEsk644wMDDcuKrYfgAw0fsu5au4YLc6LXRK2wY6K
         BDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=VBg0HdZNWzpwc9kslyZevmOaYPNi3RJRrDzA5rDhs+g=;
        b=mh4nDGHcAlRyfvwJyq1Wpkz42y513YkzYIMI01HBeMQ60Ai4afSB6lOLXlygViJgpK
         CcC5taJpQhwRfVehl87DvmBG5EaBnI6UGpz1mrLB/P78pparj7tEh+sevd3mcxmfKjD9
         Gp0RhthuO+xXF3FZ6mv6AAbze7sPlXCRXrjRv5fVbSJcU5r24KJdWrvoQxu0Iz9wPKqu
         u/BZQe4GyZrPdKmEHv1F+70b0UgwZIssA/lbRIcAZm70lkdzu5sH9aJpCdsEVFq5YujG
         MVqwLBTiNrIc9K7p3N0xawMIv8ik+lc7vneop9/fya1D+Nq7ihJQk3A/B1OB/goTdq2C
         IzXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 "Liu, Yi L" <yi.l.liu@linux.intel.com>,
 "Liu@ostrya.localdomain" <Liu@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20180420181951.GA50099@ostrya.localdomain>
 <20180423134325.6780f6ac@jacob-builder>
 <72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
 <20180501155838.4ec3720c@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
Date: Wed, 2 May 2018 10:31:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501155838.4ec3720c@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1599344235413220301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/05/18 23:58, Jacob Pan wrote:
>>>> Maybe this should be called "NG_PAGE_PASID",  
>>> Sure. I was thinking page range already implies non-global pages.  
>>>> and "DOMAIN_PAGE" should
>>>> instead be "PAGE_PASID". If I understood their meaning correctly,
>>>> it would be more consistent with the rest.
>>>>  
>>> I am trying not to mix granu between request w/ PASID and w/o.
>>> DOMAIN_PAGE meant to be for request w/o PASID.  
>>
>> Is the distinction necessary? I understand the IOMMU side might offer
>> many possibilities for invalidation, but the user probably doesn't
>> need all of them. It might be easier to document, upstream and
>> maintain if we only specify what's currently needed by users (what
>> does QEMU VT-d use?) Others can always extend it by increasing the
>> version.
>>
>> Do you think that this invalidation message will be used outside of
>> BIND_PASID_TABLE context? I can't see an other use but who knows. At
>> the moment requests w/o PASID are managed with
>> VFIO_IOMMU_MAP/UNMAP_DMA, which doesn't require invalidation. And in
>> a BIND_PASID_TABLE context, IOMMUs requests w/o PASID are just a
>> special case using PASID 0 (for Arm and AMD) so I suppose they'll use
>> the same invalidation commands as requests w/ PASID.
>>
> My understanding is that for GIOVA use case, VT-d vIOMMU creates
> GIOVA-GPA mapping and the host shadows the 2nd level page tables to
> create GIOVA-HPA mapping. So when assigned device in the guest can do
> both DMA map/unmap and VFIO map/unmap, VFIO unmap is one time deal
> (I guess invalidation can be captured in other code path), but guest
> kernel use of DMA unmap could will trigger invalidation. QEMU needs to
> trap those invalidation and passdown to physical IOMMU. So we do need
> invalidation w/o PASID.

Hm, isn't this all done by host userspace? Whether guest does DMA
map/unmap or VFIO map/unmap, it creates/removes IOVA-GPA mappings in the
vIOMMU. QEMU captures invalidation requests for these mappings from the
guest, finds GPA-HVA in the shadow map and sends a VFIO map/unmap
request for IOVA-HVA.

Thanks,
Jean
