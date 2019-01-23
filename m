Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB27C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4622184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SP/GG+v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfAWWyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:54:54 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40079 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfAWWyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:54:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so3278339oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KXJGakeSaX7kv9eetlGNGm5mHRuC6WsYW0U7AeHhhy8=;
        b=SP/GG+v/QxoIGNZ8VbX34PLfJJIZoF8sFWJ1gQIuxuTQbyTgJv9C6WJEv4vo/m4bSq
         dDJbcbUdhOw6NsE7c92E8Zq8/gOJXfjNSdfdmk8X6aATPKS1vGxGhh6eOt+Y6zBmDkIY
         NX1WAZLF8bkimY4e3g6XyXU1h23kOMk36V95AK17AS61C5BiondT3dW9S4zdYo3aZUhz
         eQdysotsv1aCWm85RP8ni3CQvWbj5G/E9Y2TN7IRYQRgBWa3jSg8QQZ4PZZewPK+K15B
         H0AuGW8ryNazURsm4VX3TVtwVjmD+ZoGvV7CdP5O5Q/55adJpq5u8ydSh99Ni0USR3DF
         ri1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KXJGakeSaX7kv9eetlGNGm5mHRuC6WsYW0U7AeHhhy8=;
        b=U+baV2Wp2SmRw9Z68upt41dIaMWWHs4TIpfrv/iAfZO377C9KqCVl2lGu/mSy8QX2H
         p3GtTqnpd/c0BXn77i2ZJBH3MjqhNr6hSLSEbfLJGNgzZqCktHsD3QxKh53KPqw2ZLYZ
         tw646erS6CDnQ3sQeDxmcFCumcDefKzzH54s/jFCNcbk8Q7vi7uyzKBRjxE9ss1meAo7
         QDwF0cvdiLXpa4Q+WUxUH6Z9mQBIOpVs4A2nZcELxOvnqX2XXGVFD0JurjrEOJfv8haS
         koq+aitFmjXqSRWPxWDFr1wDea0kY+bvLmIWTRnKvQOICjxVxNg8ybULNVGP4Ld+F7z9
         nHvQ==
X-Gm-Message-State: AJcUukcP5ATY6ZdGnSyVKMf0hOjRdojSn4bBkJEcHmlcvKMa3pU4UPe9
        n5rv/8tfMfskdKTHS27gFEI2k3QvEexe562oLKb3aA==
X-Google-Smtp-Source: ALg8bN5xhNKlGCOtDldzoet0FqfgFQ3+v461/dUKws1MoZsT8qIoZbDtxRBwxe0VV7OEQZZWDQ5Oxh9CYHPic3DdhuM=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr2466766oig.232.1548284091829;
 Wed, 23 Jan 2019 14:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20190123222315.1122-1-jglisse@redhat.com>
In-Reply-To: <20190123222315.1122-1-jglisse@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 23 Jan 2019 14:54:40 -0800
Message-ID: <CAPcyv4i9_T9779ZyaYt2T3b20-wQTaWA4P63+49TM=a=twtDVw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] mmu notifier provide context informations
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        KVM list <kvm@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:23 PM <jglisse@redhat.com> wrote:
>
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> Hi Andrew, i see that you still have my event patch in you queue [1].
> This patchset replace that single patch and is broken down in further
> step so that it is easier to review and ascertain that no mistake were
> made during mechanical changes. Here are the step:
>
>     Patch 1 - add the enum values
>     Patch 2 - coccinelle semantic patch to convert all call site of
>               mmu_notifier_range_init to default enum value and also
>               to passing down the vma when it is available
>     Patch 3 - update many call site to more accurate enum values
>     Patch 4 - add the information to the mmu_notifier_range struct
>     Patch 5 - helper to test if a range is updated to read only
>
> All the remaining patches are update to various driver to demonstrate
> how this new information get use by device driver. I build tested
> with make all and make all minus everything that enable mmu notifier
> ie building with MMU_NOTIFIER=3Dno. Also tested with some radeon,amd
> gpu and intel gpu.
>
> If they are no objections i believe best plan would be to merge the
> the first 5 patches (all mm changes) through your queue for 5.1 and
> then to delay driver update to each individual driver tree for 5.2.
> This will allow each individual device driver maintainer time to more
> thouroughly test this more then my own testing.
>
> Note that i also intend to use this feature further in nouveau and
> HMM down the road. I also expect that other user like KVM might be
> interested into leveraging this new information to optimize some of
> there secondary page table invalidation.

"Down the road" users should introduce the functionality they want to
consume. The common concern with preemptively including
forward-looking infrastructure is realizing later that the
infrastructure is not needed, or needs changing. If it has no current
consumer, leave it out.

>
> Here is an explaination on the rational for this patchset:
>
>
> CPU page table update can happens for many reasons, not only as a result
> of a syscall (munmap(), mprotect(), mremap(), madvise(), ...) but also
> as a result of kernel activities (memory compression, reclaim, migration,
> ...).
>
> This patch introduce a set of enums that can be associated with each of
> the events triggering a mmu notifier. Latter patches take advantages of
> those enum values.
>
> - UNMAP: munmap() or mremap()
> - CLEAR: page table is cleared (migration, compaction, reclaim, ...)
> - PROTECTION_VMA: change in access protections for the range
> - PROTECTION_PAGE: change in access protections for page in the range
> - SOFT_DIRTY: soft dirtyness tracking
>
> Being able to identify munmap() and mremap() from other reasons why the
> page table is cleared is important to allow user of mmu notifier to
> update their own internal tracking structure accordingly (on munmap or
> mremap it is not longer needed to track range of virtual address as it
> becomes invalid).

The only context information consumed in this patch set is
MMU_NOTIFY_PROTECTION_VMA.

What is the practical benefit of these "optimize out the case when a
range is updated to read only" optimizations? Any numbers to show this
is worth the code thrash?

>
> [1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-mmu_notifier-context=
ual-information-for-event-triggering-invalidation-v2.patch
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: kvm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> J=C3=A9r=C3=B4me Glisse (9):
>   mm/mmu_notifier: contextual information for event enums
>   mm/mmu_notifier: contextual information for event triggering
>     invalidation
>   mm/mmu_notifier: use correct mmu_notifier events for each invalidation
>   mm/mmu_notifier: pass down vma and reasons why mmu notifier is
>     happening
>   mm/mmu_notifier: mmu_notifier_range_update_to_read_only() helper
>   gpu/drm/radeon: optimize out the case when a range is updated to read
>     only
>   gpu/drm/amdgpu: optimize out the case when a range is updated to read
>     only
>   gpu/drm/i915: optimize out the case when a range is updated to read
>     only
>   RDMA/umem_odp: optimize out the case when a range is updated to read
>     only
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 13 ++++++++
>  drivers/gpu/drm/i915/i915_gem_userptr.c | 16 ++++++++++
>  drivers/gpu/drm/radeon/radeon_mn.c      | 13 ++++++++
>  drivers/infiniband/core/umem_odp.c      | 22 +++++++++++--
>  fs/proc/task_mmu.c                      |  3 +-
>  include/linux/mmu_notifier.h            | 42 ++++++++++++++++++++++++-
>  include/rdma/ib_umem_odp.h              |  1 +
>  kernel/events/uprobes.c                 |  3 +-
>  mm/huge_memory.c                        | 14 +++++----
>  mm/hugetlb.c                            | 11 ++++---
>  mm/khugepaged.c                         |  3 +-
>  mm/ksm.c                                |  6 ++--
>  mm/madvise.c                            |  3 +-
>  mm/memory.c                             | 25 +++++++++------
>  mm/migrate.c                            |  5 ++-
>  mm/mmu_notifier.c                       | 10 ++++++
>  mm/mprotect.c                           |  4 ++-
>  mm/mremap.c                             |  3 +-
>  mm/oom_kill.c                           |  3 +-
>  mm/rmap.c                               |  6 ++--
>  20 files changed, 171 insertions(+), 35 deletions(-)
>
> --
> 2.17.2
>
