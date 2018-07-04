Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6405521C3B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6405521C3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933883AbeGDH7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:59:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932290AbeGDH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:59:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w647wikB119384
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 03:59:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0sub94sp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:59:31 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 4 Jul 2018 08:59:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 08:59:25 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w647xOg841156772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 07:59:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2FF2AE051;
        Wed,  4 Jul 2018 10:59:26 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59966AE04D;
        Wed,  4 Jul 2018 10:59:26 +0100 (BST)
Received: from osiris (unknown [9.152.212.90])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 10:59:26 +0100 (BST)
Date:   Wed, 4 Jul 2018 09:59:23 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/8] add support for relative references in jump tables
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
X-TM-AS-GCONF: 00
x-cbid: 18070407-0012-0000-0000-00000286940E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070407-0013-0000-0000-000020B814DC
Message-Id: <20180704075923.GF3701@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 08:11:37PM +0200, Ard Biesheuvel wrote:
> This series implements support for emitting the data structures associated
> with jump tables as 32-bit relative references instead of absolute
> references, which take up more space on builds that target 64-bit
> architectures, or implement self relocation [or both].
> 
> This series enables it for arm64 and x86, although other architectures
> might benefit as well.

Hello Ard,

feel free to add the patch below which adds support for s390 to your series.

> Changes since v1:
> - change the relative reference to the static key to a 64-bit wide one on 64
>   bit architectures; this is necessary on arm64, which allows modules to
>   reside anywhere within a 4 GB window covering the core kernel text, which
>   means a 32-bit signed quantity with its +/- 2 GB range is insufficient.
>   Note that x86_64 changes are in preparation that widen the relocation
>   range as well (using the PIE linker), so I assumed that the same change
>   is appropriate for x86 as well.

FWIW, kernel modules on s390 are since ages more than 2GB away from the
core kernel text. So this is required for s390 as well.

From 77d87236f3d5474f33c25534d8ba2c7c54c88c55 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 4 Jul 2018 09:13:37 +0200
Subject: [PATCH] s390/jump_label: switch to relative references

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/jump_label.h | 40 +++++++++++++++-----------------------
 arch/s390/kernel/jump_label.c      | 11 ++++++-----
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index baed39772c84..0349fb06a2ec 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -121,6 +121,7 @@ config S390
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 40f651292aa7..e2d3e6c43395 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -14,41 +14,33 @@
  * We use a brcl 0,2 instruction for jump labels at compile time so it
  * can be easily distinguished from a hotpatch generated instruction.
  */
-static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+static inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl	0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
+static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 15, %l[label]\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl 15,%l[label]\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-typedef unsigned long jump_label_t;
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 43f8430fb67d..50a1798604a8 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -33,13 +33,13 @@ static void jump_label_make_branch(struct jump_entry *entry, struct insn *insn)
 {
 	/* brcl 15,offset */
 	insn->opcode = 0xc0f4;
-	insn->offset = (entry->target - entry->code) >> 1;
+	insn->offset = (jump_entry_target(entry) - jump_entry_code(entry)) >> 1;
 }
 
 static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 			   struct insn *new)
 {
-	unsigned char *ipc = (unsigned char *)entry->code;
+	unsigned char *ipc = (unsigned char *)jump_entry_code(entry);
 	unsigned char *ipe = (unsigned char *)expected;
 	unsigned char *ipn = (unsigned char *)new;
 
@@ -59,6 +59,7 @@ static void __jump_label_transform(struct jump_entry *entry,
 				   enum jump_label_type type,
 				   int init)
 {
+	void *code = (void *)jump_entry_code(entry);
 	struct insn old, new;
 
 	if (type == JUMP_LABEL_JMP) {
@@ -69,13 +70,13 @@ static void __jump_label_transform(struct jump_entry *entry,
 		jump_label_make_nop(entry, &new);
 	}
 	if (init) {
-		if (memcmp((void *)entry->code, &orignop, sizeof(orignop)))
+		if (memcmp(code, &orignop, sizeof(orignop)))
 			jump_label_bug(entry, &orignop, &new);
 	} else {
-		if (memcmp((void *)entry->code, &old, sizeof(old)))
+		if (memcmp(code, &old, sizeof(old)))
 			jump_label_bug(entry, &old, &new);
 	}
-	s390_kernel_write((void *)entry->code, &new, sizeof(new));
+	s390_kernel_write(code, &new, sizeof(new));
 }
 
 static int __sm_arch_jump_label_transform(void *data)
-- 
2.16.4

