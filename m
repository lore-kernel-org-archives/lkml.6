Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582252-1523931061-3-13603370613632933582
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
    1523931061; b=lQG75Szv7wV2DOQeQgbgk+gQDl4Qx3Cp2Dhm6LH4ZEZKd/s7sH
    HrulXkJMEbe9uT2RFv5XhGCAz8kXTSr1tB8pUjnzaVNj0nwr2PZaXp31EDcpmBQf
    dPWDZ9c8pk+2rFp1i/J4mIdTo0GqpjeI9VyY1rBdqunzJueQmQBDPqOuLdicXwNV
    zqhSFrmEJtyTWnBlg0+pUHFGmM3VMk5I18b32RndTWms5Uq0TPGq5X0qV9nl251h
    h2sgrxuzjNw+e7jBN4F7jigh+VoRc34htMNdPYF1VX4mmCG2FmfXSg+v7y07/M2f
    +tdyA2UvGpoTS9TM0Cf8Ca/573F7H1eqKwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523931061; bh=mHvw0MMNNCIxbsiBNkQkz14ZJJQiTi
    LdqBa3bL/Uqrk=; b=IjS76vWs/E7eSURyeUxDaH/dcJk3D+Q7XGpkseu8ICq54k
    Tv0xSaXwFoddfeVNuSiuyHZOS+D4ekNR9tD9ttDvrbqbmLeEK7W3LBw0fxequGxN
    7msHPbO68tafQtTQ7AvrhhXbyrkz+I651dSTVwrz+xzgX68CP4etlS+0zJXWb8To
    HhCC/EjJ2qH9TxRd0ANJTXKHfq3PkNUgNEmJo3hTVFgKWfPJAmOygNHvCIa3WoKF
    7UJjzBsmuV+oHc8KGKLvfFDh+kqzboAvs45Dyen0hnwbJzXbbQSIdvjlxqb5cala
    pdsfRMnOpNOeDKWKUcIaBXIVC/xZwCzCocT5WigA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=bIqkZdG+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=bIqkZdG+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-60 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNZo5Sbc/RM6rSwKH8mtIp5SLnbslgQ85VORbJYk0RDCn7vB1FEuUiit9nWVvUERq3/WfGZa3QL5R6EN8Lhol7+i/ITsbFR+bi11EKwb8S4wJGiFDtiZ
    5oRJoOQ8MizZ65aLKdtj2v5N1LH9+FDv+26tX7q/nHJaKow95Irp7PhJ/gjlnp3KYN8zsi70p4aP5ghd+PGEg9d20PHPZ3o29qKMl3goT6iZwMIak4mNx2zO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=yPCof4ZbAAAA:8 a=7wguZJQsvsjr__ebvbsA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeDQCKn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 22:10:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49920 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeDQCKP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 22:10:15 -0400
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
Subject: [PATCH 0/3] Interface for higher order contiguous allocations
Date: Mon, 16 Apr 2018 19:09:12 -0700
Message-Id: <20180417020915.11786-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170019
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These patches came out of the "[RFC] mmap(MAP_CONTIG)" discussions at:
http://lkml.kernel.org/r/21f1ec96-2822-1189-1c95-79a2bb491571@oracle.com

One suggestion in that thread was to create a friendlier interface that
could be used by drivers and others outside core mm code to allocate a
contiguous set of pages.  The alloc_contig_range() interface is used for
this purpose today by CMA and gigantic page allocation.  However, this is
not a general purpose interface.  So, wrap alloc_contig_range() in the
more general interface:

struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp, int nid,
                                        nodemask_t *nodemask)

This interface is essentially the same functionality provided by the
hugetlb specific routine alloc_gigantic_page().  After creating the
interface, change alloc_gigantic_page() to call find_alloc_contig_pages()
and delete all the supporting code in hugetlb.c.

A new use case for allocating contiguous memory has been identified in
Intel(R) Resource Director Technology Cache Pseudo-Locking.

Mike Kravetz (3):
  mm: change type of free_contig_range(nr_pages) to unsigned long
  mm: add find_alloc_contig_pages() interface
  mm/hugetlb: use find_alloc_contig_pages() to allocate gigantic pages

 include/linux/gfp.h | 14 +++++++-
 mm/cma.c            |  2 +-
 mm/hugetlb.c        | 87 ++++--------------------------------------------
 mm/page_alloc.c     | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 110 insertions(+), 88 deletions(-)

-- 
2.13.6

