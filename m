Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30D7208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30D7208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbeGJUZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:25:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbeGJUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:25:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6AKOcSV3268196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Jul 2018 13:24:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6AKOc8V3268193;
        Tue, 10 Jul 2018 13:24:38 -0700
Date:   Tue, 10 Jul 2018 13:24:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-8a46580128a02bdc18d7dcc0cba19d3cea4fb9c4@git.kernel.org>
Cc:     joelaf@google.com, catalin.marinas@arm.com, hpa@zytor.com,
        akpm@linux-foundation.org, bmaurer@fb.com, andi@firstfloor.org,
        mtk.manpages@gmail.com, paulmck@linux.vnet.ibm.com,
        davejwatson@fb.com, pjt@google.com, josh@joshtriplett.org,
        will.deacon@arm.com, linux@arm.linux.org.uk, cl@linux.com,
        mathieu.desnoyers@efficios.com, boqun.feng@gmail.com,
        luto@amacapital.net, rostedt@goodmis.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: catalin.marinas@arm.com, akpm@linux-foundation.org,
          hpa@zytor.com, joelaf@google.com, will.deacon@arm.com,
          josh@joshtriplett.org, pjt@google.com, linux@arm.linux.org.uk,
          mtk.manpages@gmail.com, paulmck@linux.vnet.ibm.com,
          bmaurer@fb.com, andi@firstfloor.org, davejwatson@fb.com,
          mathieu.desnoyers@efficios.com, cl@linux.com,
          luto@amacapital.net, boqun.feng@gmail.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          rostedt@goodmis.org, peterz@infradead.org,
          torvalds@linux-foundation.org
In-Reply-To: <20180709195155.7654-7-mathieu.desnoyers@efficios.com>
References: <20180709195155.7654-7-mathieu.desnoyers@efficios.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] rseq/selftests: cleanup: Update comment above
 rseq_prepare_unload
Git-Commit-ID: 8a46580128a02bdc18d7dcc0cba19d3cea4fb9c4
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

Commit-ID:  8a46580128a02bdc18d7dcc0cba19d3cea4fb9c4
Gitweb:     https://git.kernel.org/tip/8a46580128a02bdc18d7dcc0cba19d3cea4fb9c4
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 9 Jul 2018 15:51:55 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 10 Jul 2018 22:18:52 +0200

rseq/selftests: cleanup: Update comment above rseq_prepare_unload

rseq as it was merged does not have rseq_finish_*() in the user-space
selftests anymore. Update the rseq_prepare_unload() helper comment to
adapt to this reality.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-api@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Paul Turner <pjt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Chris Lameter <cl@linux.com>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180709195155.7654-7-mathieu.desnoyers@efficios.com

---
 tools/testing/selftests/rseq/rseq.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index f2073cfa4448..86ce22417e0d 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -143,12 +143,13 @@ static inline void rseq_clear_rseq_cs(void)
 }
 
 /*
- * rseq_prepare_unload() should be invoked by each thread using rseq_finish*()
- * at least once between their last rseq_finish*() and library unload of the
- * library defining the rseq critical section (struct rseq_cs). This also
- * applies to use of rseq in code generated by JIT: rseq_prepare_unload()
- * should be invoked at least once by each thread using rseq_finish*() before
- * reclaim of the memory holding the struct rseq_cs.
+ * rseq_prepare_unload() should be invoked by each thread executing a rseq
+ * critical section at least once between their last critical section and
+ * library unload of the library defining the rseq critical section
+ * (struct rseq_cs). This also applies to use of rseq in code generated by
+ * JIT: rseq_prepare_unload() should be invoked at least once by each
+ * thread executing a rseq critical section before reclaim of the memory
+ * holding the struct rseq_cs.
  */
 static inline void rseq_prepare_unload(void)
 {
