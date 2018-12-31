Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ECEC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0A621736
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeLaJaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:30:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727164AbeLaJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 04:29:58 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBV9Si0M020529
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:29:57 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pqg850h4j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 04:29:56 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 31 Dec 2018 09:29:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 31 Dec 2018 09:29:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBV9TlgC5636522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Dec 2018 09:29:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED91411C050;
        Mon, 31 Dec 2018 09:29:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 276E811C04A;
        Mon, 31 Dec 2018 09:29:43 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.181])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 31 Dec 2018 09:29:43 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 31 Dec 2018 11:29:42 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 3/6] sh: prefer memblock APIs returning virtual address
Date:   Mon, 31 Dec 2018 11:29:23 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
References: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18123109-0020-0000-0000-000002FE3658
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123109-0021-0000-0000-0000214E6FCA
Message-Id: <1546248566-14910-4-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812310088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than use the memblock_alloc_base that returns a physical address and
then convert this address to the virtual one, use appropriate memblock
function that returns a virtual address.

There is a small functional change in the allocation of then NODE_DATA().
Instead of panicing if the local allocation failed, the non-local
allocation attempt will be made.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sh/mm/init.c | 18 +++++-------------
 arch/sh/mm/numa.c |  5 ++---
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a8e5c0e..a0fa4de 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -192,24 +192,16 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
 void __init allocate_pgdat(unsigned int nid)
 {
 	unsigned long start_pfn, end_pfn;
-#ifdef CONFIG_NEED_MULTIPLE_NODES
-	unsigned long phys;
-#endif
 
 	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-	phys = __memblock_alloc_base(sizeof(struct pglist_data),
-				SMP_CACHE_BYTES, end_pfn << PAGE_SHIFT);
-	/* Retry with all of system memory */
-	if (!phys)
-		phys = __memblock_alloc_base(sizeof(struct pglist_data),
-					SMP_CACHE_BYTES, memblock_end_of_DRAM());
-	if (!phys)
+	NODE_DATA(nid) = memblock_alloc_try_nid_nopanic(
+				sizeof(struct pglist_data),
+				SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
+				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+	if (!NODE_DATA(nid))
 		panic("Can't allocate pgdat for node %d\n", nid);
-
-	NODE_DATA(nid) = __va(phys);
-	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 #endif
 
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
index 830e8b3..c4bde61 100644
--- a/arch/sh/mm/numa.c
+++ b/arch/sh/mm/numa.c
@@ -41,9 +41,8 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 	__add_active_range(nid, start_pfn, end_pfn);
 
 	/* Node-local pgdat */
-	NODE_DATA(nid) = __va(memblock_alloc_base(sizeof(struct pglist_data),
-					     SMP_CACHE_BYTES, end));
-	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
+	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
+					     SMP_CACHE_BYTES, nid);
 
 	NODE_DATA(nid)->node_start_pfn = start_pfn;
 	NODE_DATA(nid)->node_spanned_pages = end_pfn - start_pfn;
-- 
2.7.4

