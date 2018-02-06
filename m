Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeBFQu4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:50:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752854AbeBFQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:50:26 -0500
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
Subject: [PATCH v7 01/24] mm: Introduce CONFIG_SPECULATIVE_PAGE_FAULT
Date: Tue,  6 Feb 2018 17:49:47 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1517935810-31177-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020616-0020-0000-0000-000003F2EA99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020616-0021-0000-0000-0000428562A9
Message-Id: <1517935810-31177-2-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802060212
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This configuration variable will be used to build the code needed to
handle speculative page fault.

By default it is turned off, and activated depending on architecture
support.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index c782e8fb7235..42be0d92336e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -760,3 +760,6 @@ config GUP_BENCHMARK
 	  performance of get_user_pages_fast().
 
 	  See tools/testing/selftests/vm/gup_benchmark.c
+
+config SPECULATIVE_PAGE_FAULT
+       bool
-- 
2.7.4
