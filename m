Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42339C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0163E25D8D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0163E25D8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965002AbeFZKaD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:30:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34215 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934938AbeFZK36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:29:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QASxaq1648577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:28:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QASxkn1648574;
        Tue, 26 Jun 2018 03:28:59 -0700
Date:   Tue, 26 Jun 2018 03:28:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-923442895760df69eedfd3e25aa954af99a753e6@git.kernel.org>
Cc:     mark.rutland@arm.com, ysato@users.sourceforge.jp,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        jcmvbkbc@gmail.com, luto@kernel.org, mingo@kernel.org,
        acme@redhat.com, chris@zankel.net, jolsa@redhat.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, acme@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, hpa@zytor.com, dalias@libc.org,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        will.deacon@arm.com, joel.opensrc@gmail.com, paulus@samba.org,
        frederic@kernel.org
Reply-To: luto@kernel.org, acme@redhat.com, mingo@kernel.org,
          mark.rutland@arm.com, ysato@users.sourceforge.jp,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          jcmvbkbc@gmail.com, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, dalias@libc.org,
          hpa@zytor.com, will.deacon@arm.com, catalin.marinas@arm.com,
          joel.opensrc@gmail.com, paulus@samba.org, frederic@kernel.org,
          chris@zankel.net, jolsa@redhat.com, mpe@ellerman.id.au,
          benh@kernel.crashing.org, acme@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <1529981939-8231-8-git-send-email-frederic@kernel.org>
References: <1529981939-8231-8-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/arch/sh: Remove "struct
 arch_hw_breakpoint::name" unused field
Git-Commit-ID: 923442895760df69eedfd3e25aa954af99a753e6
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

Commit-ID:  923442895760df69eedfd3e25aa954af99a753e6
Gitweb:     https://git.kernel.org/tip/923442895760df69eedfd3e25aa954af99a753e6
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 26 Jun 2018 04:58:54 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:07:57 +0200

perf/arch/sh: Remove "struct arch_hw_breakpoint::name" unused field

This field seem to be unused, perhaps a leftover from old code...

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1529981939-8231-8-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/sh/include/asm/hw_breakpoint.h | 1 -
 arch/sh/kernel/hw_breakpoint.c      | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index 8a88ed0b3cd7..dae622d9b10b 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 
 struct arch_hw_breakpoint {
-	char		*name; /* Contains name of the symbol to set bkpt */
 	unsigned long	address;
 	u16		len;
 	u16		type;
diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index 38791fefdd0c..c453a0cea3c2 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -247,13 +247,6 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		return ret;
 	}
 
-	/*
-	 * For kernel-addresses, either the address or symbol name can be
-	 * specified.
-	 */
-	if (info->name)
-		info->address = (unsigned long)kallsyms_lookup_name(info->name);
-
 	/*
 	 * Check that the low-order bits of the address are appropriate
 	 * for the alignment implied by len.
