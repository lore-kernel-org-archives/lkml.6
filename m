Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3A3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320B920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320B920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeKSUgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:36:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeKSUgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:36:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJACuGD2523680
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:12:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJACuPH2523676;
        Mon, 19 Nov 2018 02:12:56 -0800
Date:   Mon, 19 Nov 2018 02:12:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Maciej S. Szmigiero" <tipbot@zytor.com>
Message-ID: <tip-479229d1607b6051abc4f9c2ccbb65338f030c65@git.kernel.org>
Cc:     bp@suse.de, x86@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, mail@maciej.szmigiero.name,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: bp@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
          x86@kernel.org, hpa@zytor.com, mail@maciej.szmigiero.name,
          tglx@linutronix.de
In-Reply-To: <6df43f4f6a28186a13a66e8d7e61143c5e1a2324.1529424596.git.mail@maciej.szmigiero.name>
References: <6df43f4f6a28186a13a66e8d7e61143c5e1a2324.1529424596.git.mail@maciej.szmigiero.name>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Subtract SECTION_HDR_SIZE
 from file leftover length
Git-Commit-ID: 479229d1607b6051abc4f9c2ccbb65338f030c65
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

Commit-ID:  479229d1607b6051abc4f9c2ccbb65338f030c65
Gitweb:     https://git.kernel.org/tip/479229d1607b6051abc4f9c2ccbb65338f030c65
Author:     Maciej S. Szmigiero <mail@maciej.szmigiero.name>
AuthorDate: Tue, 19 Jun 2018 20:47:31 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:44:59 +0100

x86/microcode/AMD: Subtract SECTION_HDR_SIZE from file leftover length

verify_patch_size() verifies whether the remaining size of the microcode
container file is large enough to contain a patch of the indicated size.

However, the section header length is not included in this indicated
size but it is present in the leftover file length so it should be
subtracted from the leftover file length before passing this value to
verify_patch_size().

 [ bp: Split comment. ]

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/6df43f4f6a28186a13a66e8d7e61143c5e1a2324.1529424596.git.mail@maciej.szmigiero.name
---
 arch/x86/kernel/cpu/microcode/amd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 07b5fc00b188..b44c9029860c 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -461,8 +461,12 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	return 0;
 }
 
-static unsigned int verify_patch_size(u8 family, u32 patch_size,
-				      unsigned int size)
+/*
+ * Check whether the passed remaining file @size is large enough to contain a
+ * patch of the indicated @patch_size (and also whether this size does not
+ * exceed the per-family maximum).
+ */
+static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int size)
 {
 	u32 max_size;
 
@@ -621,7 +625,12 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return crnt_size;
 	}
 
-	ret = verify_patch_size(family, patch_size, leftover);
+	/*
+	 * The section header length is not included in this indicated size
+	 * but is present in the leftover file length so we need to subtract
+	 * it before passing this value to the function below.
+	 */
+	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
 	if (!ret) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
 		return crnt_size;
