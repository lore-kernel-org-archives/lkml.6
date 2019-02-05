Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EE1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E8020818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfBEQkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:40:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbfBEQkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:40:46 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15GdCGm031087
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 11:40:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfbv8fvg9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 11:40:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 5 Feb 2019 16:40:41 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 16:40:34 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15GeXhM49938578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 16:40:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8890411C054;
        Tue,  5 Feb 2019 16:40:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDA1611C050;
        Tue,  5 Feb 2019 16:40:31 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Feb 2019 16:40:31 +0000 (GMT)
Date:   Tue, 5 Feb 2019 18:40:30 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 6/6] mm/gup: Documentation/vm/get_user_pages.rst,
 MAINTAINERS
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <20190204052135.25784-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204052135.25784-7-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19020516-0020-0000-0000-00000312007F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020516-0021-0000-0000-0000216312C9
Message-Id: <20190205164029.GA12942@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Sun, Feb 03, 2019 at 09:21:35PM -0800, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> 1. Added Documentation/vm/get_user_pages.rst
> 
> 2. Added a GET_USER_PAGES entry in MAINTAINERS
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  Documentation/vm/get_user_pages.rst | 197 ++++++++++++++++++++++++++++
>  Documentation/vm/index.rst          |   1 +
>  MAINTAINERS                         |  10 ++
>  3 files changed, 208 insertions(+)
>  create mode 100644 Documentation/vm/get_user_pages.rst
> 
> diff --git a/Documentation/vm/get_user_pages.rst b/Documentation/vm/get_user_pages.rst
> new file mode 100644
> index 000000000000..8598f20afb09
> --- /dev/null
> +++ b/Documentation/vm/get_user_pages.rst

It's great to see docs coming alone with the patches! :)

Yet, I'm a bit confused. The documentation here mostly describes the
existing problems that this patchset aims to solve, but the text here does
not describe the proposed solution.

> @@ -0,0 +1,197 @@
> +.. _get_user_pages:
> +
> +==============
> +get_user_pages
> +==============
> +
> +.. contents:: :local:
> +
> +Overview
> +========
> +
> +Some kernel components (file systems, device drivers) need to access
> +memory that is specified via process virtual address. For a long time, the
> +API to achieve that was get_user_pages ("GUP") and its variations. However,
> +GUP has critical limitations that have been overlooked; in particular, GUP
> +does not interact correctly with filesystems in all situations. That means
> +that file-backed memory + GUP is a recipe for potential problems, some of
> +which have already occurred in the field.
> +
> +GUP was first introduced for Direct IO (O_DIRECT), allowing filesystem code
> +to get the struct page behind a virtual address and to let storage hardware
> +perform a direct copy to or from that page. This is a short-lived access
> +pattern, and as such, the window for a concurrent writeback of GUP'd page
> +was small enough that there were not (we think) any reported problems.
> +Also, userspace was expected to understand and accept that Direct IO was
> +not synchronized with memory-mapped access to that data, nor with any
> +process address space changes such as munmap(), mremap(), etc.
> +
> +Over the years, more GUP uses have appeared (virtualization, device
> +drivers, RDMA) that can keep the pages they get via GUP for a long period
> +of time (seconds, minutes, hours, days, ...). This long-term pinning makes
> +an underlying design problem more obvious.
> +
> +In fact, there are a number of key problems inherent to GUP:
> +
> +Interactions with file systems
> +==============================
> +
> +File systems expect to be able to write back data, both to reclaim pages,
> +and for data integrity. Allowing other hardware (NICs, GPUs, etc) to gain
> +write access to the file memory pages means that such hardware can dirty the
> +pages, without the filesystem being aware. This can, in some cases
> +(depending on filesystem, filesystem options, block device, block device
> +options, and other variables), lead to data corruption, and also to kernel
> +bugs of the form:
> +
> +::
> +
> +    kernel BUG at /build/linux-fQ94TU/linux-4.4.0/fs/ext4/inode.c:1899!
> +    backtrace:
> +
> +	ext4_writepage
> +	__writepage
> +	write_cache_pages
> +	ext4_writepages
> +	do_writepages
> +	__writeback_single_inode
> +	writeback_sb_inodes
> +	__writeback_inodes_wb
> +	wb_writeback
> +	wb_workfn
> +	process_one_work
> +	worker_thread
> +	kthread
> +	ret_from_fork
> +
> +...which is due to the file system asserting that there are still buffer
> +heads attached:
> +
> +::
> +
> + /* If we *know* page->private refers to buffer_heads */
> + #define page_buffers(page)                                      \
> +        ({                                                      \
> +                BUG_ON(!PagePrivate(page));                     \
> +                ((struct buffer_head *)page_private(page));     \
> +        })
> + #define page_has_buffers(page)  PagePrivate(page)
> +
> +Dave Chinner's description of this is very clear:
> +
> +    "The fundamental issue is that ->page_mkwrite must be called on every
> +    write access to a clean file backed page, not just the first one.
> +    How long the GUP reference lasts is irrelevant, if the page is clean
> +    and you need to dirty it, you must call ->page_mkwrite before it is
> +    marked writeable and dirtied. Every. Time."
> +
> +This is just one symptom of the larger design problem: filesystems do not
> +actually support get_user_pages() being called on their pages, and letting
> +hardware write directly to those pages--even though that pattern has been
> +going on since about 2005 or so.
> +
> +Long term GUP
> +=============
> +
> +Long term GUP is an issue when FOLL_WRITE is specified to GUP (so, a
> +writeable mapping is created), and the pages are file-backed. That can lead
> +to filesystem corruption. What happens is that when a file-backed page is
> +being written back, it is first mapped read-only in all of the CPU page
> +tables; the file system then assumes that nobody can write to the page, and
> +that the page content is therefore stable. Unfortunately, the GUP callers
> +generally do not monitor changes to the CPU pages tables; they instead
> +assume that the following pattern is safe (it's not):
> +
> +::
> +
> +    get_user_pages()
> +
> +    Hardware then keeps a reference to those pages for some potentially
> +    long time. During this time, hardware may write to the pages. Because
> +    "hardware" here means "devices that are not a CPU", this activity
> +    occurs without any interaction with the kernel's file system code.
> +
> +    for each page:
> +	set_page_dirty()
> +	put_page()
> +
> +In fact, the GUP documentation even recommends that pattern.
> +
> +Anyway, the file system assumes that the page is stable (nothing is writing
> +to the page), and that is a problem: stable page content is necessary for
> +many filesystem actions during writeback, such as checksum, encryption,
> +RAID striping, etc. Furthermore, filesystem features like COW (copy on
> +write) or snapshot also rely on being able to use a new page for as memory
> +for that memory range inside the file.
> +
> +Corruption during write back is clearly possible here. To solve that, one
> +idea is to identify pages that have active GUP, so that we can use a bounce
> +page to write stable data to the filesystem. The filesystem would work
> +on the bounce page, while any of the active GUP might write to the
> +original page. This would avoid the stable page violation problem, but note
> +that it is only part of the overall solution, because other problems
> +remain.
> +
> +Other filesystem features that need to replace the page with a new one can
> +be inhibited for pages that are GUP-pinned. This will, however, alter and
> +limit some of those filesystem features. The only fix for that would be to
> +require GUP users monitor and respond to CPU page table updates. Subsystems
> +such as ODP and HMM do this, for example. This aspect of the problem is
> +still under discussion.
> +
> +Direct IO
> +=========
> +
> +Direct IO can cause corruption, if userspace does Direct-IO that writes to
> +a range of virtual addresses that are mmap'd to a file.  The pages written
> +to are file-backed pages that can be under write back, while the Direct IO
> +is taking place.  Here, Direct IO need races with a write back: it calls
> +GUP before page_mkclean() has replaced the CPU pte with a read-only entry.
> +The race window is pretty small, which is probably why years have gone by
> +before we noticed this problem: Direct IO is generally very quick, and
> +tends to finish up before the filesystem gets around to do anything with
> +the page contents.  However, it's still a real problem.  The solution is
> +to never let GUP return pages that are under write back, but instead,
> +force GUP to take a write fault on those pages.  That way, GUP will
> +properly synchronize with the active write back.  This does not change the
> +required GUP behavior, it just avoids that race.
> +
> +Measurement and visibility
> +==========================
> +
> +There are several /proc/vmstat items, in order to provide some visibility
> +into what get_user_pages() and put_user_page() are doing.
> +
> +After booting and running fio (https://github.com/axboe/fio)
> +a few times on an NVMe device, as a way to get lots of
> +get_user_pages_fast() calls, the counters look like this:
> +
> +::
> +
> + $ cat /proc/vmstat | grep gup
> + nr_gup_slow_pages_requested 21319
> + nr_gup_fast_pages_requested 11533792
> + nr_gup_fast_page_backoffs 0
> + nr_gup_page_count_overflows 0
> + nr_gup_pages_returned 11555104
> +
> +Interpretation of the above:
> +
> +::
> +
> + Total gup requests (slow + fast): 11555111
> + Total put_user_page calls:        11555104
> +
> +This shows 7 more calls to get_user_pages(), than to put_user_page().
> +That may, or may not, represent a problem worth investigating.
> +
> +Normally, those last two numbers should be equal, but a couple of things
> +may cause them to differ:
> +
> +1. Inherent race condition in reading /proc/vmstat values.
> +
> +2. Bugs at any of the get_user_pages*() call sites. Those
> +sites need to match get_user_pages() and put_user_page() calls.
> +
> +
> +
> diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> index 2b3ab3a1ccf3..433aaf1996e6 100644
> --- a/Documentation/vm/index.rst
> +++ b/Documentation/vm/index.rst
> @@ -32,6 +32,7 @@ descriptions of data structures and algorithms.
>     balance
>     cleancache
>     frontswap
> +   get_user_pages
>     highmem
>     hmm
>     hwpoison
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c68de3cfd80..1e8f91b8ce4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6384,6 +6384,16 @@ M:	Frank Haverkamp <haver@linux.ibm.com>
>  S:	Supported
>  F:	drivers/misc/genwqe/
>  
> +GET_USER_PAGES
> +M:	Dan Williams <dan.j.williams@intel.com>
> +M:	Jan Kara <jack@suse.cz>
> +M:	Jérôme Glisse <jglisse@redhat.com>
> +M:	John Hubbard <jhubbard@nvidia.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +F:	mm/gup.c
> +F:	Documentation/vm/get_user_pages.rst
> +
>  GET_MAINTAINER SCRIPT
>  M:	Joe Perches <joe@perches.com>
>  S:	Maintained
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

