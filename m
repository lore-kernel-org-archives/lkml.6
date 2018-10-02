Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADEAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C13620645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJBQ5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:57:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:57:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92ACota1916559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:12:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92ACo9S1916552;
        Tue, 2 Oct 2018 03:12:50 -0700
Date:   Tue, 2 Oct 2018 03:12:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-2f359c7ea554ba9cb78a52c82bedff351cdabd2b@git.kernel.org>
Cc:     eranian@google.com, hpa@zytor.com, acme@redhat.com,
        npiggin@gmail.com, dlustig@nvidia.com,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        luc.maranget@inria.fr, boqun.feng@gmail.com,
        alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
        andrea.parri@amarulasolutions.com, akiyks@gmail.com,
        jolsa@redhat.com, peterz@infradead.org, dhowells@redhat.com,
        tglx@linutronix.de, will.deacon@arm.com, mingo@kernel.org,
        j.alglave@ucl.ac.uk, corbet@lwn.net, stern@rowland.harvard.edu,
        torvalds@linux-foundation.org
Reply-To: corbet@lwn.net, stern@rowland.harvard.edu,
          torvalds@linux-foundation.org, mingo@kernel.org,
          j.alglave@ucl.ac.uk, dhowells@redhat.com, will.deacon@arm.com,
          tglx@linutronix.de, peterz@infradead.org, jolsa@redhat.com,
          akiyks@gmail.com, andrea.parri@amarulasolutions.com,
          vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
          luc.maranget@inria.fr, paulmck@linux.vnet.ibm.com,
          boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
          dlustig@nvidia.com, acme@redhat.com, hpa@zytor.com,
          npiggin@gmail.com, eranian@google.com
In-Reply-To: <20180926182920.27644-5-paulmck@linux.ibm.com>
References: <20180926182920.27644-5-paulmck@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/memory-barriers: Replace
 smp_cond_acquire() with smp_cond_load_acquire()
Git-Commit-ID: 2f359c7ea554ba9cb78a52c82bedff351cdabd2b
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

Commit-ID:  2f359c7ea554ba9cb78a52c82bedff351cdabd2b
Gitweb:     https://git.kernel.org/tip/2f359c7ea554ba9cb78a52c82bedff351cdabd2b
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Wed, 26 Sep 2018 11:29:20 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 10:28:05 +0200

locking/memory-barriers: Replace smp_cond_acquire() with smp_cond_load_acquire()

Amend the changes in commit:

  1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire() with smp_cond_load_acquire()")

... by updating the documentation accordingly.

Also remove some obsolete information related to the implementation.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/20180926182920.27644-5-paulmck@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/memory-barriers.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 0d8d7ef131e9..c1d913944ad8 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -471,8 +471,7 @@ And a couple of implicit varieties:
      operations after the ACQUIRE operation will appear to happen after the
      ACQUIRE operation with respect to the other components of the system.
      ACQUIRE operations include LOCK operations and both smp_load_acquire()
-     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
-     semantics from relying on a control dependency and smp_rmb().
+     and smp_cond_load_acquire() operations.
 
      Memory operations that occur before an ACQUIRE operation may appear to
      happen after it completes.
