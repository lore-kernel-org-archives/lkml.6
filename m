Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF09C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445A325064
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445A325064
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934032AbeF0JIr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:08:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48489 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933824AbeF0JIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:08:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5R98Fdx2025749
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Jun 2018 02:08:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5R98Et42025746;
        Wed, 27 Jun 2018 02:08:14 -0700
Date:   Wed, 27 Jun 2018 02:08:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-e8a445dea219c32727016af14f847d2e8f7ebec8@git.kernel.org>
Cc:     peterz@infradead.org, bp@alien8.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
          bp@alien8.de, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, luto@kernel.org
In-Reply-To: <bb3bc1f923a2f6fe7912d22a1068fe29d6033d38.1530076529.git.luto@kernel.org>
References: <bb3bc1f923a2f6fe7912d22a1068fe29d6033d38.1530076529.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] selftests/x86/sigreturn: Do minor cleanups
Git-Commit-ID: e8a445dea219c32727016af14f847d2e8f7ebec8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e8a445dea219c32727016af14f847d2e8f7ebec8
Gitweb:     https://git.kernel.org/tip/e8a445dea219c32727016af14f847d2e8f7ebec8
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 26 Jun 2018 22:17:18 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 27 Jun 2018 09:36:56 +0200

selftests/x86/sigreturn: Do minor cleanups

We have short names for the requested and resulting register values.
Use them instead of spelling out the whole register entry for each
case.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/bb3bc1f923a2f6fe7912d22a1068fe29d6033d38.1530076529.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/sigreturn.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 2559e2c01793..4d9dc3f2fd70 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -610,6 +610,7 @@ static int test_valid_sigreturn(int cs_bits, bool use_16bit_ss, int force_ss)
 	 */
 	for (int i = 0; i < NGREG; i++) {
 		greg_t req = requested_regs[i], res = resulting_regs[i];
+
 		if (i == REG_TRAPNO || i == REG_IP)
 			continue;	/* don't care */
 
@@ -673,18 +674,18 @@ static int test_valid_sigreturn(int cs_bits, bool use_16bit_ss, int force_ss)
 #endif
 
 		/* Sanity check on the kernel */
-		if (i == REG_CX && requested_regs[i] != resulting_regs[i]) {
+		if (i == REG_CX && req != res) {
 			printf("[FAIL]\tCX (saved SP) mismatch: requested 0x%llx; got 0x%llx\n",
-			       (unsigned long long)requested_regs[i],
-			       (unsigned long long)resulting_regs[i]);
+			       (unsigned long long)req,
+			       (unsigned long long)res);
 			nerrs++;
 			continue;
 		}
 
-		if (requested_regs[i] != resulting_regs[i] && !ignore_reg) {
+		if (req != res && !ignore_reg) {
 			printf("[FAIL]\tReg %d mismatch: requested 0x%llx; got 0x%llx\n",
-			       i, (unsigned long long)requested_regs[i],
-			       (unsigned long long)resulting_regs[i]);
+			       i, (unsigned long long)req,
+			       (unsigned long long)res);
 			nerrs++;
 		}
 	}
