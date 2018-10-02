Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F18C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9E620878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9E620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeJBQz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:55:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJBQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:55:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92ACHum1916508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:12:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92ACHqQ1916505;
        Tue, 2 Oct 2018 03:12:17 -0700
Date:   Tue, 2 Oct 2018 03:12:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-d8fa25c4efde0e5f31a427202e583d73d3f021c4@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        eranian@google.com, acme@redhat.com, mingo@kernel.org,
        andrea.parri@amarulasolutions.com, jolsa@redhat.com,
        tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
        vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com,
          vincent.weaver@maine.edu, peterz@infradead.org,
          paulmck@linux.vnet.ibm.com, tglx@linutronix.de, jolsa@redhat.com,
          andrea.parri@amarulasolutions.com, acme@redhat.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, eranian@google.com
In-Reply-To: <20180926182920.27644-4-paulmck@linux.ibm.com>
References: <20180926182920.27644-4-paulmck@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Add more LKMM limitations
Git-Commit-ID: d8fa25c4efde0e5f31a427202e583d73d3f021c4
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

Commit-ID:  d8fa25c4efde0e5f31a427202e583d73d3f021c4
Gitweb:     https://git.kernel.org/tip/d8fa25c4efde0e5f31a427202e583d73d3f021c4
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Wed, 26 Sep 2018 11:29:19 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 10:28:04 +0200

tools/memory-model: Add more LKMM limitations

This commit adds more detail about compiler optimizations and
not-yet-modeled Linux-kernel APIs.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180926182920.27644-4-paulmck@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/README | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index ee987ce20aae..acf9077cffaa 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -171,6 +171,12 @@ The Linux-kernel memory model has the following limitations:
 	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
 	and "A WARNING" sections).
 
+	Note that this limitation in turn limits LKMM's ability to
+	accurately model address, control, and data dependencies.
+	For example, if the compiler can deduce the value of some variable
+	carrying a dependency, then the compiler can break that dependency
+	by substituting a constant of that value.
+
 2.	Multiple access sizes for a single variable are not supported,
 	and neither are misaligned or partially overlapping accesses.
 
@@ -190,6 +196,36 @@ The Linux-kernel memory model has the following limitations:
 	However, a substantial amount of support is provided for these
 	operations, as shown in the linux-kernel.def file.
 
+	a.	When rcu_assign_pointer() is passed NULL, the Linux
+		kernel provides no ordering, but LKMM models this
+		case as a store release.
+
+	b.	The "unless" RMW operations are not currently modeled:
+		atomic_long_add_unless(), atomic_add_unless(),
+		atomic_inc_unless_negative(), and
+		atomic_dec_unless_positive().  These can be emulated
+		in litmus tests, for example, by using atomic_cmpxchg().
+
+	c.	The call_rcu() function is not modeled.  It can be
+		emulated in litmus tests by adding another process that
+		invokes synchronize_rcu() and the body of the callback
+		function, with (for example) a release-acquire from
+		the site of the emulated call_rcu() to the beginning
+		of the additional process.
+
+	d.	The rcu_barrier() function is not modeled.  It can be
+		emulated in litmus tests emulating call_rcu() via
+		(for example) a release-acquire from the end of each
+		additional call_rcu() process to the site of the
+		emulated rcu-barrier().
+
+	e.	Sleepable RCU (SRCU) is not modeled.  It can be
+		emulated, but perhaps not simply.
+
+	f.	Reader-writer locking is not modeled.  It can be
+		emulated in litmus tests using atomic read-modify-write
+		operations.
+
 The "herd7" tool has some additional limitations of its own, apart from
 the memory model:
 
@@ -204,3 +240,6 @@ the memory model:
 Some of these limitations may be overcome in the future, but others are
 more likely to be addressed by incorporating the Linux-kernel memory model
 into other tools.
+
+Finally, please note that LKMM is subject to change as hardware, use cases,
+and compilers evolve.
