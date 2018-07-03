Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9C9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C53B23C71
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C53B23C71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeGCIfC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:35:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932471AbeGCIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:34:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w638YVh2214062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 01:34:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w638YVhC214059;
        Tue, 3 Jul 2018 01:34:31 -0700
Date:   Tue, 3 Jul 2018 01:34:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tom Lendacky <tipbot@zytor.com>
Message-ID: <tip-612bc3b3d4be749f73a513a17d9b3ee1330d3487@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, bpetkov@suse.de,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        dwmw@amazon.co.uk, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
          dwmw@amazon.co.uk, torvalds@linux-foundation.org,
          konrad.wilk@oracle.com, bpetkov@suse.de, mingo@kernel.org
In-Reply-To: <20180702213602.29202.33151.stgit@tlendack-t1.amdoffice.net>
References: <20180702213602.29202.33151.stgit@tlendack-t1.amdoffice.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR
Git-Commit-ID: 612bc3b3d4be749f73a513a17d9b3ee1330d3487
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

Commit-ID:  612bc3b3d4be749f73a513a17d9b3ee1330d3487
Gitweb:     https://git.kernel.org/tip/612bc3b3d4be749f73a513a17d9b3ee1330d3487
Author:     Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate: Mon, 2 Jul 2018 16:36:02 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:45:48 +0200

x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR

On AMD, the presence of the MSR_SPEC_CTRL feature does not imply that the
SSBD mitigation support should use the SPEC_CTRL MSR. Other features could
have caused the MSR_SPEC_CTRL feature to be set, while a different SSBD
mitigation option is in place.

Update the SSBD support to check for the actual SSBD features that will
use the SPEC_CTRL MSR.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6ac2f49edb1e ("x86/bugs: Add AMD's SPEC_CTRL MSR usage")
Link: http://lkml.kernel.org/r/20180702213602.29202.33151.stgit@tlendack-t1.amdoffice.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 404df26b7de8..5c0ea39311fe 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -155,7 +155,8 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 		guestval |= guest_spec_ctrl & x86_spec_ctrl_mask;
 
 		/* SSBD controlled in MSR_SPEC_CTRL */
-		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		    static_cpu_has(X86_FEATURE_AMD_SSBD))
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
 		if (hostval != guestval) {
@@ -533,9 +534,10 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
 		 * use a completely different MSR and bit dependent on family.
 		 */
-		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) &&
+		    !static_cpu_has(X86_FEATURE_AMD_SSBD)) {
 			x86_amd_ssb_disable();
-		else {
+		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
