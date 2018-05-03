Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3312385-1525390280-2-6999253838997247700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525390280; b=DG8hGmJhusksmX5+GsHXrjgp/vm2Pd7xS12eS55Rrzih0m1nHf
    3egtBJDDi0iFv38ENrnk0alrVbqdWSysukVVqPAcqL0Ew3mmNvBNX/4AKdCupoHh
    0G/pI58OTWk3Iq4cTF1Uv4JzVFITZT6MMrsmsIZANkJCLTMq3XNqzrv+SPOtP7XZ
    VZX5QjJCkR/UP+O60fCNhussHHq3Tr3aR/nQyBBadRrz8W8GjGv5iE69HpzeusVS
    We4kfl6mcjxQpvc9ORrQka4jEd8Hb4QrxxEO5aFL523s1Nikmzja/YDJfIKSwipK
    nOACYouqbv3AFnTvRiJUiuySZCRWokmVJ9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525390280; bh=EBWz2Iio9cDTTcVUQH0F9zkZ3m4cyI
    qZoMN7IhpGqTc=; b=CJRsOB+BuHScNLONgQvlf7d52eyW4jM+4gWA1j0SjQbeTm
    QrQNjfQpXMaKL9c6gHgr86x4sIgeTNU8dXx//mgkrfYIiBrPdsxaD/PnMIb5a1vo
    raH6wUmlo9UidBeNaEAoIp67UmIqfU3JAPTpRi/tD4nGXNTGFfv55LTYErbftcGQ
    Q/LIkIbCbnb0HBAtO5WEFe3WKh+Z4HISmStT4zcIvemNE5SLA8J81h8iUXhYy1g2
    MyqHM6/cVbf09tpDj5aj8/BvdHLsa6YOvQWrRiIrhZMfA2URGZjpdargkIACTSCY
    pjddn8Bh0GqagnFAa5IKmwxU6nKhBVPUuumh5PDw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=hC8LXvbD x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=hC8LXvbD x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAdD/Xq2DXY5mfeSr4XSibDMaSbX8KWTqNMwT2qMRDgIGFejojmIRovSkGo8yO2oxjC0t7vD1HpthSWR63zDgt2L8gt9nKt8EUbc3p+cM1v/bL0n8Fiq
    pVT+Ay+D7LxrGXYWZ72kRBJ3IJ2V0dQrcn9/RxBDFNMjp8PyydhNx+Nvt6QXmYg2PKgWLjudDyqU/nuApg7TZfBpiIJd142As0+qBr9ICHtlRdeEKAP3K41S
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=yPCof4ZbAAAA:8 a=1WmDZwFra9lXDXl8VEQA:9 a=BCivQc36JmYwF43_:21
    a=jOpT_71mvYYHUGwL:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeECXac (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 19:30:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeECXa2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 19:30:28 -0400
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/4] Interface for higher order contiguous allocations
Date: Thu,  3 May 2018 16:29:31 -0700
Message-Id: <20180503232935.22539-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8882 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030204
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A respin of of the series to address these issues:

- fix issues found by kbuild
- find_alloc_contig_pages() should take nr_pages as argument instead of
  page order (Vlastimil and Michal).
- Cleaned up migratetype handling (Vlastimil and Michal).
- Use pfn_to_online_page instead of pfn_to_page as suggested by Michal.
  Also added comment about minimal number of conditions checked in
  contig_pfn_range_valid().
- When scanning pfns in zone, take pgdat_resize_lock() instead of
  zone->lock (Michal)

Also, 
- Separate patch to change type of free_contig_range(nr_pages) to an
  unsigned long so that it is consistent with other uses of nr_pages.
- Separate patch to optionally validate migratetype during pageblock
  isolation.
- Make find_alloc_contig_pages() work for smaller size allocation by
  simply calling __alloc_pages_nodemask().

Vlastimil and Michal brought up the issue of allocation alignment.  The
routine will currently align to 'nr_pages' (which is the requested size
argument).  It does this by examining and trying to allocate the first
nr_pages aligned/nr_pages sized range.  If this fails, it moves on to the
next nr_pages aligned/nr_pages sized range until success or all potential
ranges are exhausted.  If we allow an alignment to be specified, we will
need to potentially check all alignment aligned/nr_pages sized ranges.
In the worst case where alignment = PAGE_SIZE, this could result in huge
increase in the number of ranges to check.
To help cut down on the number of ranges to check, we could identify the
first page that causes a range allocation failure and start the next
range at the next aligned boundary.  I tried this, and we still end up
with a huge number of ranges and wasted CPU cycles.
This series did not add an alignment option.  Allocations are aligned to
nr_pages as described above.  If someone can thing of a good way to support
an alignment argument, I am open to implementing/adding it.

As described before,
These patches came out of the "[RFC] mmap(MAP_CONTIG)" discussions at:
http://lkml.kernel.org/r/21f1ec96-2822-1189-1c95-79a2bb491571@oracle.com

One suggestion in that thread was to create a friendlier interface that
could be used by drivers and others outside core mm code to allocate a
contiguous set of pages.  The alloc_contig_range() interface is used for
this purpose today by CMA and gigantic page allocation.  However, this is
not a general purpose interface.  So, wrap alloc_contig_range() in the
more general interface:

struct page *find_alloc_contig_pages(unsigned long nr_pages, gfp_t gfp,
					int nid, nodemask_t *nodemask)

This interface is essentially the same functionality provided by the
hugetlb specific routine alloc_gigantic_page().  After creating the
interface, change alloc_gigantic_page() to call find_alloc_contig_pages()
and delete all the supporting code in hugetlb.c.

A new use case for allocating contiguous memory has been identified in
Intel(R) Resource Director Technology Cache Pseudo-Locking.

Mike Kravetz (4):
  mm: change type of free_contig_range(nr_pages) to unsigned long
  mm: check for proper migrate type during isolation
  mm: add find_alloc_contig_pages() interface
  mm/hugetlb: use find_alloc_contig_pages() to allocate gigantic pages

 include/linux/gfp.h            |  14 +++-
 include/linux/page-isolation.h |   8 +--
 mm/cma.c                       |   2 +-
 mm/hugetlb.c                   |  87 ++--------------------
 mm/memory_hotplug.c            |   2 +-
 mm/page_alloc.c                | 159 +++++++++++++++++++++++++++++++++++++----
 mm/page_isolation.c            |  40 ++++++++---
 7 files changed, 200 insertions(+), 112 deletions(-)

-- 
2.13.6

