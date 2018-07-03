Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CBFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC1823EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC1823EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933796AbeGCIfb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:35:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932683AbeGCIef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:34:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w638XuWI214025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 01:33:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w638Xrfg214021;
        Tue, 3 Jul 2018 01:33:53 -0700
Date:   Tue, 3 Jul 2018 01:33:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tom Lendacky <tipbot@zytor.com>
Message-ID: <tip-845d382bb15c6e7dc5026c0ff919c5b13fc7e11b@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        dwmw@amazon.co.uk, konrad.wilk@oracle.com, hpa@zytor.com,
        torvalds@linux-foundation.org, bpetkov@suse.de, mingo@kernel.org
Reply-To: bpetkov@suse.de, mingo@kernel.org, torvalds@linux-foundation.org,
          konrad.wilk@oracle.com, dwmw@amazon.co.uk, hpa@zytor.com,
          linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20180702213553.29202.21089.stgit@tlendack-t1.amdoffice.net>
References: <20180702213553.29202.21089.stgit@tlendack-t1.amdoffice.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/bugs: Update when to check for the LS_CFG SSBD
 mitigation
Git-Commit-ID: 845d382bb15c6e7dc5026c0ff919c5b13fc7e11b
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

Commit-ID:  845d382bb15c6e7dc5026c0ff919c5b13fc7e11b
Gitweb:     https://git.kernel.org/tip/845d382bb15c6e7dc5026c0ff919c5b13fc7e11b
Author:     Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate: Mon, 2 Jul 2018 16:35:53 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:45:48 +0200

x86/bugs: Update when to check for the LS_CFG SSBD mitigation

If either the X86_FEATURE_AMD_SSBD or X86_FEATURE_VIRT_SSBD features are
present, then there is no need to perform the check for the LS_CFG SSBD
mitigation support.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180702213553.29202.21089.stgit@tlendack-t1.amdoffice.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 082d7875cef8..38915fbfae73 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -543,7 +543,9 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
-	if (c->x86 >= 0x15 && c->x86 <= 0x17) {
+	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
+	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
+	    c->x86 >= 0x15 && c->x86 <= 0x17) {
 		unsigned int bit;
 
 		switch (c->x86) {
