Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeBYTAS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 14:00:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751557AbeBYTAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 14:00:07 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-doc <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/3] mm/nommu: remove description of alloc_vm_area
Date: Sun, 25 Feb 2018 20:59:49 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519585191-10180-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1519585191-10180-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022519-0008-0000-0000-000004D44A13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022519-0009-0000-0000-00001E676150
Message-Id: <1519585191-10180-2-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802250253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloc_mm_area in nommu is a stub, but it's description states it
allocates kernel address space.
Remove the description to make the code and the documentation agree.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/nommu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index ebb6e618dade..4f1cabd07e81 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -457,18 +457,6 @@ void __weak vmalloc_sync_all(void)
 {
 }
 
-/**
- *	alloc_vm_area - allocate a range of kernel address space
- *	@size:		size of the area
- *
- *	Returns:	NULL on failure, vm_struct on success
- *
- *	This function reserves a range of kernel address space, and
- *	allocates pagetables to map that range.  No actual mappings
- *	are created.  If the kernel address space is not shared
- *	between processes, it syncs the pagetable across all
- *	processes.
- */
 struct vm_struct *alloc_vm_area(size_t size, pte_t **ptes)
 {
 	BUG();
-- 
2.7.4
