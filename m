Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B99BC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC3E20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfAUOdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:33:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbfAUOdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:33:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E58385363;
        Mon, 21 Jan 2019 14:33:30 +0000 (UTC)
Received: from [10.36.118.109] (unknown [10.36.118.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4410768728;
        Mon, 21 Jan 2019 14:33:22 +0000 (UTC)
Subject: Re: [PATCH RFC 00/24] userfaultfd: write protection support
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20190121075722.7945-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <c2485a2d-25b3-2fc0-4902-01fa278be9c7@redhat.com>
Date:   Mon, 21 Jan 2019 15:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190121075722.7945-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 21 Jan 2019 14:33:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.19 08:56, Peter Xu wrote:
> Hi,
> 
> This series implements initial write protection support for
> userfaultfd.  Currently both shmem and hugetlbfs are not supported
> yet, but only anonymous memory.
> 
> To be simple, either "userfaultfd-wp" or "uffd-wp" might be used in
> later paragraphs.
> 
> The whole series can also be found at:
> 
>   https://github.com/xzpeter/linux/tree/uffd-wp-merged
> 
> Any comment would be greatly welcomed.   Thanks.
> 
> Overview
> ====================
> 
> The uffd-wp work was initialized by Shaohua Li [1], and later
> continued by Andrea [2]. This series is based upon Andrea's latest
> userfaultfd tree, and it is a continuous works from both Shaohua and
> Andrea.  Many of the follow up ideas come from Andrea too.
> 
> Besides the old MISSING register mode of userfaultfd, the new uffd-wp
> support provides another alternative register mode called
> UFFDIO_REGISTER_MODE_WP that can be used to listen to not only missing
> page faults but also write protection page faults, or even they can be
> registered together.  At the same time, the new feature also provides
> a new userfaultfd ioctl called UFFDIO_WRITEPROTECT which allows the
> userspace to write protect a range or memory or fixup write permission
> of faulted pages.
> 
> Please refer to the document patch "userfaultfd: wp:
> UFFDIO_REGISTER_MODE_WP documentation update" for more information on
> the new interface and what it can do.
> 
> The major workflow of an uffd-wp program should be:
> 
>   1. Register a memory region with WP mode using UFFDIO_REGISTER_MODE_WP
> 
>   2. Write protect part of the whole registered region using
>      UFFDIO_WRITEPROTECT, passing in UFFDIO_WRITEPROTECT_MODE_WP to
>      show that we want to write protect the range.
> 
>   3. Start a working thread that modifies the protected pages,
>      meanwhile listening to UFFD messages.
> 
>   4. When a write is detected upon the protected range, page fault
>      happens, a UFFD message will be generated and reported to the
>      page fault handling thread
> 
>   5. The page fault handler thread resolves the page fault using the
>      new UFFDIO_WRITEPROTECT ioctl, but this time passing in
>      !UFFDIO_WRITEPROTECT_MODE_WP instead showing that we want to
>      recover the write permission.  Before this operation, the fault
>      handler thread can do anything it wants, e.g., dumps the page to
>      a persistent storage.
> 
>   6. The worker thread will continue running with the correctly
>      applied write permission from step 5.
> 
> Currently there are already two projects that are based on this new
> userfaultfd feature.
> 
> QEMU Live Snapshot: The project provides a way to allow the QEMU
>                     hypervisor to take snapshot of VMs without
>                     stopping the VM [3].
> 
> LLNL umap library:  The project provides a mmap-like interface and
>                     "allow to have an application specific buffer of
>                     pages cached from a large file, i.e. out-of-core
>                     execution using memory map" [4][5].
> 
> Before posting the patchset, this series was smoke tested against QEMU
> live snapshot and the LLNL umap library (by doing parallel quicksort
> using 128 sorting threads + 80 uffd servicing threads).  My sincere
> thanks to Marty Mcfadden and Denis Plotnikov for the help along the
> way.
> 
> Implementation
> ==============
> 
> Patch 1-4: The whole uffd-wp requires the kernel page fault path to
>            take more than one retries.  In the previous works starting
>            from Shaohua, a new fault flag FAULT_FLAG_ALLOW_UFFD_RETRY
>            was introduced for this [6]. However in this series we have
>            dropped that patch, instead the whole work is based on the
>            recent series "[PATCH RFC v3 0/4] mm: some enhancements to
>            the page fault mechanism" [7] which removes the assuption
>            that VM_FAULT_RETRY can only happen once.  This four
>            patches are identital patches but picked up here.  Please
>            refer to the cover letter [7] for more information.  More
>            discussion upstream shows that this work could even benefit
>            existing use case [8] so please help justify whether
>            patches 1-4 can be consider to be accepted even earlier
>            than the rest of the series.
> 
> Patch 5-21:   Implements the uffd-wp logic.  To avoid collision with
>               existing write protections (e.g., an private anonymous
>               page can be write protected if it was shared between
>               multiple processes), a new PTE bit (_PAGE_UFFD_WP) was
>               introduced to explicitly mark a PTE as userfault
>               write-protected.  A similar bit was also used in the
>               swap/migration entry (_PAGE_SWP_UFFD_WP) to make sure
>               even if the pages were swapped or migrated, the uffd-wp
>               tracking information won't be lost.  When resolving a
>               page fault, we'll do a page copy before hand if the page
>               was COWed to make sure we won't corrupt any shared
>               pages.  Etc.  Please see separated patches for more
>               details.
> 
> Patch 22:     Documentation update for uffd-wp
> 
> Patch 23,24:  Uffd-wp selftests
> 
> TODO
> =============
> 
> - hugetlbfs/shmem support
> - performance
> - more architectures
> - ...
> 
> References
> ==========
> 
> [1] https://lwn.net/Articles/666187/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/log/?h=userfault
> [3] https://github.com/denis-plotnikov/qemu/commits/background-snapshot-kvm
> [4] https://github.com/LLNL/umap
> [5] https://llnl-umap.readthedocs.io/en/develop/
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?h=userfault&id=b245ecf6cf59156966f3da6e6b674f6695a5ffa5
> [7] https://lkml.org/lkml/2018/11/21/370
> [8] https://lkml.org/lkml/2018/12/30/64
> 
> Andrea Arcangeli (5):
>   userfaultfd: wp: add the writeprotect API to userfaultfd ioctl
>   userfaultfd: wp: hook userfault handler to write protection fault
>   userfaultfd: wp: add WP pagetable tracking to x86
>   userfaultfd: wp: userfaultfd_pte/huge_pmd_wp() helpers
>   userfaultfd: wp: add UFFDIO_COPY_MODE_WP
> 
> Martin Cracauer (1):
>   userfaultfd: wp: UFFDIO_REGISTER_MODE_WP documentation update
> 
> Peter Xu (15):
>   mm: gup: rename "nonblocking" to "locked" where proper
>   mm: userfault: return VM_FAULT_RETRY on signals
>   mm: allow VM_FAULT_RETRY for multiple times
>   mm: gup: allow VM_FAULT_RETRY for multiple times
>   mm: merge parameters for change_protection()
>   userfaultfd: wp: apply _PAGE_UFFD_WP bit
>   mm: export wp_page_copy()
>   userfaultfd: wp: handle COW properly for uffd-wp
>   userfaultfd: wp: drop _PAGE_UFFD_WP properly when fork
>   userfaultfd: wp: add pmd_swp_*uffd_wp() helpers
>   userfaultfd: wp: support swap and page migration
>   userfaultfd: wp: don't wake up when doing write protect
>   khugepaged: skip collapse if uffd-wp detected
>   userfaultfd: selftests: refactor statistics
>   userfaultfd: selftests: add write-protect test
> 
> Shaohua Li (3):
>   userfaultfd: wp: add helper for writeprotect check
>   userfaultfd: wp: support write protection for userfault vma range
>   userfaultfd: wp: enabled write protection in userfaultfd API
> 
>  Documentation/admin-guide/mm/userfaultfd.rst |  51 +++++
>  arch/alpha/mm/fault.c                        |   4 +-
>  arch/arc/mm/fault.c                          |  12 +-
>  arch/arm/mm/fault.c                          |  17 +-
>  arch/arm64/mm/fault.c                        |  11 +-
>  arch/hexagon/mm/vm_fault.c                   |   3 +-
>  arch/ia64/mm/fault.c                         |   3 +-
>  arch/m68k/mm/fault.c                         |   5 +-
>  arch/microblaze/mm/fault.c                   |   3 +-
>  arch/mips/mm/fault.c                         |   3 +-
>  arch/nds32/mm/fault.c                        |   7 +-
>  arch/nios2/mm/fault.c                        |   5 +-
>  arch/openrisc/mm/fault.c                     |   3 +-
>  arch/parisc/mm/fault.c                       |   4 +-
>  arch/powerpc/mm/fault.c                      |   9 +-
>  arch/riscv/mm/fault.c                        |   9 +-
>  arch/s390/mm/fault.c                         |  14 +-
>  arch/sh/mm/fault.c                           |   5 +-
>  arch/sparc/mm/fault_32.c                     |   4 +-
>  arch/sparc/mm/fault_64.c                     |   4 +-
>  arch/um/kernel/trap.c                        |   6 +-
>  arch/unicore32/mm/fault.c                    |  10 +-
>  arch/x86/Kconfig                             |   1 +
>  arch/x86/include/asm/pgtable.h               |  67 ++++++
>  arch/x86/include/asm/pgtable_64.h            |   8 +-
>  arch/x86/include/asm/pgtable_types.h         |  11 +-
>  arch/x86/mm/fault.c                          |  13 +-
>  arch/xtensa/mm/fault.c                       |   4 +-
>  fs/userfaultfd.c                             | 110 +++++----
>  include/asm-generic/pgtable.h                |   1 +
>  include/asm-generic/pgtable_uffd.h           |  66 ++++++
>  include/linux/huge_mm.h                      |   2 +-
>  include/linux/mm.h                           |  21 +-
>  include/linux/swapops.h                      |   2 +
>  include/linux/userfaultfd_k.h                |  41 +++-
>  include/trace/events/huge_memory.h           |   1 +
>  include/uapi/linux/userfaultfd.h             |  28 ++-
>  init/Kconfig                                 |   5 +
>  mm/gup.c                                     |  61 ++---
>  mm/huge_memory.c                             |  28 ++-
>  mm/hugetlb.c                                 |   8 +-
>  mm/khugepaged.c                              |  23 ++
>  mm/memory.c                                  |  28 ++-
>  mm/mempolicy.c                               |   2 +-
>  mm/migrate.c                                 |   7 +
>  mm/mprotect.c                                |  99 +++++++--
>  mm/rmap.c                                    |   6 +
>  mm/userfaultfd.c                             |  92 +++++++-
>  tools/testing/selftests/vm/userfaultfd.c     | 222 ++++++++++++++-----
>  49 files changed, 898 insertions(+), 251 deletions(-)
>  create mode 100644 include/asm-generic/pgtable_uffd.h
> 

Does this series fix the "false positives" case I experienced on early
prototypes of uffd-wp? (getting notified about a write access although
it was not a write access?)

-- 

Thanks,

David / dhildenb
