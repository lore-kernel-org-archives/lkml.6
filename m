Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE35C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E65208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ausKXPHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E65208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeIZSZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:25:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48421 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbeIZSY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:24:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180926121216euoutp01d46644a3a3f7a7042f42858279559def~X8g00smzK3040030400euoutp01Z;
        Wed, 26 Sep 2018 12:12:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180926121216euoutp01d46644a3a3f7a7042f42858279559def~X8g00smzK3040030400euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537963936;
        bh=qhILIikUNfAm/d0/L9/M13xSavtKH5j1QxdW8g4UPqM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ausKXPHX1eUbocKP6yd/+BIATus0ZfwgeRnNgBh0vNhMNH9oN8L2ixqXFgpwsN+Zs
         hItVzwzfjY9jubpVUSdteDd+RA6Oa+HgvYp+2D2uErYrpYfj9kJZa5U9gg0tWZsXuv
         YIBay9epv8dGnZPPCIXNCUd52HjX6obDu4+Luc9A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121215eucas1p184c0ef64adb612454cc82821dd7c829d~X8g0OQ3oD0489504895eucas1p1b;
        Wed, 26 Sep 2018 12:12:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AC.E1.04441.F977BAB5; Wed, 26
        Sep 2018 13:12:15 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121214eucas1p1660542d20425551038da8d3feaf7e1b7~X8gzbfasr0757007570eucas1p1T;
        Wed, 26 Sep 2018 12:12:14 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-86-5bab779f2e1d
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 18.0B.04128.E977BAB5; Wed, 26
        Sep 2018 13:12:14 +0100 (BST)
Received: from AMDC3482.DIGITAL.local ([106.120.51.30]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PFN0028YWK7Q120@eusync4.samsung.com>;
        Wed, 26 Sep 2018 13:12:14 +0100 (BST)
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH v2 2/7] arm64: uprobes - fix checkpatch issues
Date:   Wed, 26 Sep 2018 14:12:00 +0200
Message-id: <1537963925-25313-3-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfyyUcRzHfZ/nueceV6fHw+abytY1LSqx2Xq2sFqtPX9ksfVr3UYXT0c5
        7B5OrM0p6RwhElKXDec6mhznd9JFp1mpOwlFk5rShsgfNpTz5L/XZ+/3+/P57LMPgVK/ME8i
        Nj6JVcbL4iS4CGt+tTSw/1FKrdTffJeiteOtOK0xlQnohtJ6AT2rzwV075sVhM6Yf4jSpskh
        AW1vf4DTluJngO7Mr8XpJz1jQtrWXYHQ1/VmjDY/vwlo6+1uhP75uw87TDJ1ujrA2Ifeo0yj
        wZcxGbNxRvc6nGmsSmdezHQizGzXB5zJazICZsHkFSY6LwqKZuNiVazyQMgFUYxhOU+YWLn3
        ak9zP6IGN3ZpgTMByUD4qbxSoAUigiINAE51FKJ8sQDgx4kswYar+sd31MEUqQdwVX+C578A
        5qrDHYyTB2FLbybmYHfyOBzO0CCORihpR6C9LwdxCG5kCGz7+nLdhJHecKBnTuhgMXkStumy
        hPwwLzjyNnt9mDMZBi0lhvWNIDmFw7l3ZqAFxFpxDA4WcbzfDU5bm/5nt0N7UQ7Gcwrs6BsR
        8tlMAIszuhFeOASXjXdwB6OkCyxsLkH5nmKoyaJ4CwMHbtVg/CUqATRoJrECsLUCOBmBB5vM
        KeQsFxDPpvhxMgWXHC/3i0pQmMDaC/SvWudbwaLtogWQBJBsFhPBRiklkKm4VIUFQAKVuIs3
        qWqllDhalprGKhMilclxLGcB2whM4iF28b0kpUi5LIm9wrKJrHJDRQhnTzUo/4KqQ62hPl2f
        LV1po6qJU+rBI/eOnm67Jp3Q7HbKLSvV7dxXEuU8MzQW0ZDfZBjW2Lv/dIr3SKsUjwVjU95n
        khcL2tNt8D41Dq1BC7Z6ZUSgWL30VG8b9x+7/G05OMR1x3Rgy9mY4Tida43PpN+5Ua2lfWW4
        Wu4ZLN9ii4ySYFyMLMAXVXKyf9wlJlv+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t/xa7rzyldHG/xeq23RdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlbHiTx97wWLtiiPbTjM1MDYrdzFy
        ckgImEgsffGUuYuRi0NIYAmjxPHWA1BOI5PE9K4GVpAqNgFzie1HW1hAbBEBN4kbjR1MIEXM
        ApeZJD4v2AtWJCxgJ7Hz0WGwIhYBVYnzRz6wg9i8Av4SO+e1sUOsk5O4ea6TGcTmFAiQODR9
        BZgtBFRz5eRMlgmMPAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEBvG2Yz+37GDsehd8
        iFGAg1GJh5fDdlW0EGtiWXFl7iFGCQ5mJRFe7rLV0UK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        zxtURgkJpCeWpGanphakFsFkmTg4pRoYdftO9Cr+1ardKPv0YYDCiUwF75w972PvasxdzjhJ
        NfPf09WHLctnLLl6SyCss6SQ56Cdqsofr5NZ5qe2KNy4OMtY9EbxrbVxb6o5cz/+ZTXY6MT+
        Ijxo6hH/oLk6B/25Vt6Luh25lX+tPOf5bp9MA4+MI0e2Fc64P+n/V920CS7+UTpJay7xKrEU
        ZyQaajEXFScCADs+IVBeAgAA
X-CMS-MailID: 20180926121214eucas1p1660542d20425551038da8d3feaf7e1b7
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121214eucas1p1660542d20425551038da8d3feaf7e1b7
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121214eucas1p1660542d20425551038da8d3feaf7e1b7@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch issues in moved arm uprobes code.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 lib/probes/arm/actions-arm.c | 4 ++--
 lib/probes/arm/decode-arm.c  | 1 +
 lib/probes/arm/decode-arm.h  | 4 ++--
 lib/probes/arm/decode.c      | 6 ++++++
 lib/probes/arm/decode.h      | 7 +++++--
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/probes/arm/actions-arm.c b/lib/probes/arm/actions-arm.c
index a25795a..db6017d 100644
--- a/lib/probes/arm/actions-arm.c
+++ b/lib/probes/arm/actions-arm.c
@@ -165,10 +165,10 @@ uprobe_decode_ldmstm(probes_opcode_t insn,
 {
 	struct arch_uprobe *auprobe = container_of(asi, struct arch_uprobe,
 						   asi);
-	unsigned reglist = insn & 0xffff;
+	unsigned int reglist = insn & 0xffff;
 	int rn = (insn >> 16) & 0xf;
 	int lbit = insn & (1 << 20);
-	unsigned used = reglist | (1 << rn);
+	unsigned int used = reglist | (1 << rn);
 
 	if (rn == 15)
 		return INSN_REJECTED;
diff --git a/lib/probes/arm/decode-arm.c b/lib/probes/arm/decode-arm.c
index f72c33a..3aa2e58 100644
--- a/lib/probes/arm/decode-arm.c
+++ b/lib/probes/arm/decode-arm.c
@@ -101,6 +101,7 @@ void __kprobes simulate_mrs(probes_opcode_t insn,
 {
 	int rd = (insn >> 12) & 0xf;
 	unsigned long mask = 0xf8ff03df; /* Mask out execution state */
+
 	regs->uregs[rd] = regs->ARM_cpsr & mask;
 }
 
diff --git a/lib/probes/arm/decode-arm.h b/lib/probes/arm/decode-arm.h
index b3b80f6..ed34f03 100644
--- a/lib/probes/arm/decode-arm.h
+++ b/lib/probes/arm/decode-arm.h
@@ -66,8 +66,8 @@ void __kprobes simulate_mov_ipsp(probes_opcode_t opcode,
 
 extern const union decode_item probes_decode_arm_table[];
 
-enum probes_insn arm_probes_decode_insn(probes_opcode_t,
-		struct arch_probes_insn *, bool emulate,
+enum probes_insn arm_probes_decode_insn(probes_opcode_t opcode,
+		struct arch_probes_insn *api, bool emulate,
 		const union decode_action *actions,
 		const struct decode_checker *checkers[]);
 
diff --git a/lib/probes/arm/decode.c b/lib/probes/arm/decode.c
index 880ebe0..6840054 100644
--- a/lib/probes/arm/decode.c
+++ b/lib/probes/arm/decode.c
@@ -55,6 +55,7 @@ bool load_write_pc_interworks;
 void __init test_load_write_pc_interworking(void)
 {
 	int arch = cpu_architecture();
+
 	BUG_ON(arch == CPU_ARCH_UNKNOWN);
 	load_write_pc_interworks = arch >= CPU_ARCH_ARMv5T;
 }
@@ -69,6 +70,7 @@ bool alu_write_pc_interworks;
 void __init test_alu_write_pc_interworking(void)
 {
 	int arch = cpu_architecture();
+
 	BUG_ON(arch == CPU_ARCH_UNKNOWN);
 	alu_write_pc_interworks = arch >= CPU_ARCH_ARMv7;
 }
@@ -151,6 +153,7 @@ static unsigned long __kprobes __check_lt(unsigned long cpsr)
 static unsigned long __kprobes __check_gt(unsigned long cpsr)
 {
 	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+
 	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
 	return (~temp) & PSR_N_BIT;
 }
@@ -158,6 +161,7 @@ static unsigned long __kprobes __check_gt(unsigned long cpsr)
 static unsigned long __kprobes __check_le(unsigned long cpsr)
 {
 	unsigned long temp = cpsr ^ (cpsr << 3); /* PSR_N_BIT ^= PSR_V_BIT */
+
 	temp |= (cpsr << 1);			 /* PSR_N_BIT |= PSR_Z_BIT */
 	return temp & PSR_N_BIT;
 }
@@ -228,6 +232,7 @@ set_emulated_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 #ifdef CONFIG_THUMB2_KERNEL
 	if (thumb) {
 		u16 *ip = (u16 *)asi->insn;
+
 		if (is_wide_instruction(insn))
 			*ip++ = __opcode_to_mem_thumb16(insn >> 16);
 		*ip++ = __opcode_to_mem_thumb16(insn);
@@ -465,6 +470,7 @@ probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi,
 
 		case DECODE_TYPE_TABLE: {
 			struct decode_table *d = (struct decode_table *)h;
+
 			next = (struct decode_header *)d->table.table;
 			break;
 		}
diff --git a/lib/probes/arm/decode.h b/lib/probes/arm/decode.h
index 548d622..43b02fd 100644
--- a/lib/probes/arm/decode.h
+++ b/lib/probes/arm/decode.h
@@ -59,6 +59,7 @@ static inline unsigned long it_advance(unsigned long cpsr)
 		/* We need to shift left ITSTATE<4:0> */
 		const unsigned long mask = 0x06001c00;  /* Mask ITSTATE<4:0> */
 		unsigned long it = cpsr & mask;
+
 		it <<= 1;
 		it |= it >> (27 - 10);  /* Carry ITSTATE<2> to correct place */
 		it &= mask;
@@ -71,6 +72,7 @@ static inline unsigned long it_advance(unsigned long cpsr)
 static inline void __kprobes bx_write_pc(long pcv, struct pt_regs *regs)
 {
 	long cpsr = regs->ARM_cpsr;
+
 	if (pcv & 0x1) {
 		cpsr |= PSR_T_BIT;
 		pcv &= ~0x1;
@@ -253,7 +255,8 @@ static inline void __kprobes alu_write_pc(long pcv, struct pt_regs *regs)
  * instruction will be modified to "AND R0, R2, R3, ASL R1" and then placed into
  * the kprobes instruction slot. This can then be called later by the handler
  * function emulate_rd12rn16rm0rs8_rwflags (a pointer to which is retrieved from
- * the indicated slot in the action array), in order to simulate the instruction.
+ * the indicated slot in the action array), in order to simulate the
+ * instruction.
  */
 
 enum decode_type {
@@ -282,7 +285,7 @@ enum decode_reg_type {
 	REG_TYPE_NOPCWB,   /* No PC if load/store write-back flag also set */
 
 	/* The following types are used when the encoding for PC indicates
-	 * another instruction form. This distiction only matters for test
+	 * another instruction form. This distinction only matters for test
 	 * case coverage checks.
 	 */
 	REG_TYPE_NOPCX,	   /* Register must not be PC */
-- 
2.7.4

