Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-575325-1523931018-5-14886876485950867822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523931017; b=ZtFc5BkAR/8SWtq2iBV9rTA7dbZHMcAH1G15DO3YOrbI9zLIb3
    1M/ZM+fSrpA2+oLnaO5jYE48f/jIqtzAR5k0DyLB0w2KSTE9Dj+7ZdWf9G6eddYV
    enbNk5rqdl9XehC/xsCKYuUwUTYkd5SrBXoGc5UhJEHnadfHsjABPvblgZS2xiga
    eiQ4V1rhmc+2sHwRIxCi9w8ga+86nZkwtKbCC891dOpZj5kFIfTJ0N1lMPotn3dx
    dAGqzIZTxjOrqR0IOFuEzWOjEw8/x7uDvSsCTfs6fB0xYWQgxBPQzXfE4QbfHIBz
    4BV3hB+NEObOuMU52V7Dua1qH5sCe/lBqntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523931017; bh=
    XXs9WFnqVoVUQPOblm34TGny3F+pg6NpclLgVjHiHUk=; b=qZCZueaYC12lXwVH
    fx+mCYEKrTKVHUcs+1dTxsueGRsnrZXGuY4dPC7q64N/nKc8TVhwLEeIR6vCSfPS
    kU/l3WyxNUurFJBCEp6ka+7mYRbqLPkN/BjyeehfDyTA/RKjXWnj70aevos07jGS
    jPsyPah+RS+JQx+Mk3KlP1tCIiXy5vF+dUV+hfTU3zytaWmRLkwpKsNUMhJlvvQz
    52BULfecEx04mfRmDK6Ku0MwJOXShbIWSjUBH/Bw/2PHNa+oXTMkG+4z3ulqXMXB
    2DYt1GuaQToRtYVxMb71dNRv+11V0CfxC1X04TdF5ogY76qiDWpQcOs7uVRzUH+Y
    6FAU0w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=suF1gBy4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=suF1gBy4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEzyYJE9Symewiz2nGR6jEvvhdlpgsudm9xCutgnqeH7VTuQ9jn+YB48hBIoH/NdHSUxTuBU1ImW+ySlq3oza3J6XLdiYnHlXRPT/RVRDfJMQY8HST0J
    JCIfBifcmtNca/4qqgUlO5yjGXKRJ8RBWFtInqsXK0vp6uGeUpyMRKVzGHMPY4fwBjLFrc5YW9hoBHQ6O55Sc+XQo7pgWNNb/Y9g3sMAz8sh+DMod7F9YedO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=_uUnvOAkXTw6sgMkcK4A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeDQCKP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 22:10:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56156 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeDQCKM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 22:10:12 -0400
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
Subject: [PATCH 1/3] mm: change type of free_contig_range(nr_pages) to unsigned long
Date: Mon, 16 Apr 2018 19:09:13 -0700
Message-Id: <20180417020915.11786-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180417020915.11786-1-mike.kravetz@oracle.com>
References: <20180417020915.11786-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=858
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170019
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

free_contig_range() is currently defined as:
void free_contig_range(unsigned long pfn, unsigned nr_pages);
change to,
void free_contig_range(unsigned long pfn, unsigned long nr_pages);

Some callers are passing a truncated unsigned long today.  It is
highly unlikely that these values will overflow an unsigned int.
However, this should be changed to an unsigned long to be consistent
with other page counts.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/gfp.h | 2 +-
 mm/cma.c            | 2 +-
 mm/hugetlb.c        | 2 +-
 mm/page_alloc.c     | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 1a4582b44d32..86a0d06463ab 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -572,7 +572,7 @@ static inline bool pm_suspended_storage(void)
 /* The below functions must be run on a range from a single zone. */
 extern int alloc_contig_range(unsigned long start, unsigned long end,
 			      unsigned migratetype, gfp_t gfp_mask);
-extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
+extern void free_contig_range(unsigned long pfn, unsigned long nr_pages);
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/mm/cma.c b/mm/cma.c
index aa40e6c7b042..f473fc2b7cbd 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -563,7 +563,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 
 	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
 
-	free_contig_range(pfn, count);
+	free_contig_range(pfn, (unsigned long)count);
 	cma_clear_bitmap(cma, pfn, count);
 	trace_cma_release(pfn, pages, count);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 218679138255..c81072ce7510 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1055,7 +1055,7 @@ static void destroy_compound_gigantic_page(struct page *page,
 
 static void free_gigantic_page(struct page *page, unsigned int order)
 {
-	free_contig_range(page_to_pfn(page), 1 << order);
+	free_contig_range(page_to_pfn(page), 1UL << order);
 }
 
 static int __alloc_gigantic_page(unsigned long start_pfn,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 905db9d7962f..0fd5e8e2456e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7937,9 +7937,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	return ret;
 }
 
-void free_contig_range(unsigned long pfn, unsigned nr_pages)
+void free_contig_range(unsigned long pfn, unsigned long nr_pages)
 {
-	unsigned int count = 0;
+	unsigned long count = 0;
 
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
@@ -7947,7 +7947,7 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
 		count += page_count(page) != 1;
 		__free_page(page);
 	}
-	WARN(count != 0, "%d pages are still in use!\n", count);
+	WARN(count != 0, "%ld pages are still in use!\n", count);
 }
 #endif
 
-- 
2.13.6

