Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8A620652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8A620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeJEP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:27:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeJEP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:27:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w958T8n23071761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 01:29:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w958T8O43071758;
        Fri, 5 Oct 2018 01:29:08 -0700
Date:   Fri, 5 Oct 2018 01:29:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-d0e7d14455d41163126afecd0fcce935463cc512@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, bp@suse.de,
        tglx@linutronix.de, torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, bp@suse.de, tglx@linutronix.de,
          torvalds@linux-foundation.org
In-Reply-To: <20181004172227.10094-1-bp@alien8.de>
References: <20181004172227.10094-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] cpu/SMT: State SMT is disabled even with nosmt and
 without "=force"
Git-Commit-ID: d0e7d14455d41163126afecd0fcce935463cc512
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

Commit-ID:  d0e7d14455d41163126afecd0fcce935463cc512
Gitweb:     https://git.kernel.org/tip/d0e7d14455d41163126afecd0fcce935463cc512
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 4 Oct 2018 19:22:27 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 5 Oct 2018 10:20:31 +0200

cpu/SMT: State SMT is disabled even with nosmt and without "=force"

When booting with "nosmt=force" a message is issued into dmesg to
confirm that SMT has been force-disabled but such a message is not
issued when only "nosmt" is on the kernel command line.

Fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181004172227.10094-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0097acec1c71..f1338452d998 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -362,6 +362,7 @@ void __init cpu_smt_disable(bool force)
 		pr_info("SMT: Force disabled\n");
 		cpu_smt_control = CPU_SMT_FORCE_DISABLED;
 	} else {
+		pr_info("SMT: disabled\n");
 		cpu_smt_control = CPU_SMT_DISABLED;
 	}
 }
