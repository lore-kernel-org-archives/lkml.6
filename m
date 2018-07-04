Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10268C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E7F2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E7F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeGDNSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:18:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753207AbeGDNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:18:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64DA4WJ049371
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 09:18:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0w2ed70v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:18:28 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 14:18:27 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 14:18:24 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64DINiU43450380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 13:18:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 293484C046;
        Wed,  4 Jul 2018 16:18:48 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 893AC4C040;
        Wed,  4 Jul 2018 16:18:46 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 16:18:46 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 04 Jul 2018 16:18:20 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Ley Foon Tan <lftan@altera.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        nios2-dev@lists.rocketboards.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/3] nios2: use generic early_init_dt_add_memory_arch
Date:   Wed,  4 Jul 2018 16:18:14 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530710295-10774-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530710295-10774-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070413-4275-0000-0000-000002951BD9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070413-4276-0000-0000-0000379CA065
Message-Id: <1530710295-10774-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=815 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All we have to do is to enable memblock, the generic FDT code will take
care of the rest.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/nios2/Kconfig        |  1 +
 arch/nios2/kernel/prom.c  | 10 ----------
 arch/nios2/kernel/setup.c |  2 ++
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88..5db8fa1 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -19,6 +19,7 @@ config NIOS2
 	select SPARSE_IRQ
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
+	select HAVE_MEMBLOCK
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
index 8d7446a..ba96a49 100644
--- a/arch/nios2/kernel/prom.c
+++ b/arch/nios2/kernel/prom.c
@@ -32,16 +32,6 @@
 
 #include <asm/sections.h>
 
-void __init early_init_dt_add_memory_arch(u64 base, u64 size)
-{
-	u64 kernel_start = (u64)virt_to_phys(_text);
-
-	if (!memory_size &&
-	    (kernel_start >= base) && (kernel_start < (base + size)))
-		memory_size = size;
-
-}
-
 int __init early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
 					     bool nomap)
 {
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 926a02b..0946840 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/console.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/initrd.h>
 #include <linux/of_fdt.h>
 #include <linux/screen_info.h>
@@ -147,6 +148,7 @@ void __init setup_arch(char **cmdline_p)
 
 	console_verbose();
 
+	memory_size = memblock_phys_mem_size();
 	memory_start = PAGE_ALIGN((unsigned long)__pa(_end));
 	memory_end = (unsigned long) CONFIG_NIOS2_MEM_BASE + memory_size;
 
-- 
2.7.4

