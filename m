Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6FE26776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6FE26776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeF1FWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:22:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753188AbeF1FWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:22:37 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5S5KBUM014949
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:22:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvsa50brc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:22:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 28 Jun 2018 06:22:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 06:22:28 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5S5MSsg27459628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 05:22:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7E5D4203F;
        Thu, 28 Jun 2018 06:22:18 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6541042047;
        Thu, 28 Jun 2018 06:22:15 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.233])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 06:22:15 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v5 03/10] Uprobe: Change set_swbp definition
Date:   Thu, 28 Jun 2018 10:52:02 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062805-0016-0000-0000-000001E0F218
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062805-0017-0000-0000-0000323534CF
Message-Id: <20180628052209.13056-4-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=726 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of arch_uprobe, pass uprobe object to set_swbp(). We need
this in later set of patches.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/arm/probes/uprobes/core.c | 4 ++--
 arch/mips/kernel/uprobes.c     | 4 ++--
 include/linux/uprobes.h        | 2 +-
 kernel/events/uprobes.c        | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index d1329f1ba4e4..c678a5c4a284 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -29,11 +29,11 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 		(UPROBE_SWBP_ARM_INSN & 0x0fffffff);
 }
 
-int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+int set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	     unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr,
-		   __opcode_to_mem_arm(auprobe->bpinsn));
+		   __opcode_to_mem_arm(uprobe->arch.bpinsn));
 }
 
 bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index f7a0645ccb82..2aaa378a46e6 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -211,7 +211,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
 
 /**
  * set_swbp - store breakpoint at a given address.
- * @auprobe: arch specific probepoint information.
+ * @uprobe: uprobe object.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to insert the opcode.
  *
@@ -221,7 +221,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
  * This version overrides the weak version in kernel/events/uprobes.c.
  * It is required to handle MIPS16 and microMIPS.
  */
-int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 044359083a57..7a77bd57c9e7 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -140,7 +140,7 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
-extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern int set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 26c2d95c55fa..8de52bcd1a18 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -318,14 +318,14 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
 
 /**
  * set_swbp - store breakpoint at a given address.
- * @auprobe: arch specific probepoint information.
+ * @uprobe: uprobe object.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, store the breakpoint instruction at @vaddr.
  * Return 0 (success) or a negative errno.
  */
-int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
 }
@@ -642,7 +642,7 @@ install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, mm, vaddr);
+	ret = set_swbp(uprobe, mm, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
-- 
2.14.4

