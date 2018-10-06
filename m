Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7410C67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72862089D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72862089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeJFXzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:55:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40803 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbeJFXzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:55:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42SCLk4F8lz9ttCF;
        Sat,  6 Oct 2018 18:51:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ly3DZzwfEgm0; Sat,  6 Oct 2018 18:51:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42SCLk3bkpz9ttC7;
        Sat,  6 Oct 2018 18:51:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FBBD8B793;
        Sat,  6 Oct 2018 18:51:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IXV1vd-Gw-1U; Sat,  6 Oct 2018 18:51:17 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 805C28B74B;
        Sat,  6 Oct 2018 18:51:16 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5B7C46F2BA; Sat,  6 Oct 2018 16:51:16 +0000 (UTC)
Message-Id: <31d84480ca37b6b2bc76d5a0307163a55b03ced8.1538789120.git.christophe.leroy@c-s.fr>
In-Reply-To: <981244f0ffb38c1aa02c9eb831c7ebf479b8f564.1538789120.git.christophe.leroy@c-s.fr>
References: <981244f0ffb38c1aa02c9eb831c7ebf479b8f564.1538789120.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 3/3] powerpc/process: Constify the number of insns printed
 by show instructions functions.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, muriloo@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sat,  6 Oct 2018 16:51:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

instructions_to_print var is assigned value 16 and there is no
way to change it.

This patch replaces it by a constant.

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: rebased
 v3: no change
 v2: no change

 arch/powerpc/kernel/process.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8dabf656d924..dd8447d3f0bf 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1258,17 +1258,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	return last;
 }
 
-static int instructions_to_print = 16;
+#define NR_INSN_TO_PRINT	16
 
 static void show_instructions(struct pt_regs *regs)
 {
 	int i;
-	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
-			sizeof(int));
+	unsigned long pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
 
 	printk("Instruction dump:");
 
-	for (i = 0; i < instructions_to_print; i++) {
+	for (i = 0; i < NR_INSN_TO_PRINT; i++) {
 		int instr;
 
 		if (!(i % 8))
@@ -1301,17 +1300,17 @@ static void show_instructions(struct pt_regs *regs)
 void show_user_instructions(struct pt_regs *regs)
 {
 	unsigned long pc;
-	int n = instructions_to_print;
+	int n = NR_INSN_TO_PRINT;
 	struct seq_buf s;
 	char buf[96]; /* enough for 8 times 9 + 2 chars */
 
-	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
+	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
 
 	/*
 	 * Make sure the NIP points at userspace, not kernel text/data or
 	 * elsewhere.
 	 */
-	if (!__access_ok(pc, instructions_to_print * sizeof(int), USER_DS)) {
+	if (!__access_ok(pc, NR_INSN_TO_PRINT * sizeof(int), USER_DS)) {
 		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
 			current->comm, current->pid);
 		return;
-- 
2.13.3

