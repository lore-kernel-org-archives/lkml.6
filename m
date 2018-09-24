Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB7CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7D72145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7D72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeIXPRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:17:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56617 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeIXPRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:17:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4MyS-0005nS-Lp; Mon, 24 Sep 2018 03:16:12 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4MvH-0002zU-Gk; Mon, 24 Sep 2018 03:12:56 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 24 Sep 2018 11:10:13 +0200
Message-Id: <20180924091015.4458-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
X-XM-SPF: eid=1g4MvH-0002zU-Gk;;;mid=<20180924091015.4458-13-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0GbLxE1n6LPxN5LfTFQNf9RV67b4c0SA=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 13/15] signal/arm64: In ptrace_hbptriggered name the signal description string
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will let the description be reused shortly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 7ab75e78aa08..921267f59d0d 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -182,6 +182,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 				struct pt_regs *regs)
 {
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+	const char *desc = "Hardware breakpoint trap (ptrace)";
 
 #ifdef CONFIG_COMPAT
 	if (is_compat_task()) {
@@ -206,7 +207,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 #endif
 	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT,
 			      (void __user *)(bkpt->trigger),
-			      "Hardware breakpoint trap (ptrace)");
+			      desc);
 }
 
 /*
-- 
2.17.1

