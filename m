Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27686C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD45827239
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HCbekPqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD45827239
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964823AbeF1Kn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:43:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46441 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933651AbeF1Knz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:43:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id t6-v6so4985836wrq.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kA/Qd/+eF+WsR5dok9DYpPFeLl/YvaQ82KNNeFD5/5s=;
        b=HCbekPqxKXDHtSQnK35JGjQBrI/Ml9UMWIvaHAUh7CWUgcNrXVhDGo+32aE3S3Fjlq
         iQKMh436tnnJyD+o+6vMOQK45qQXsCI03OA+vPmmKVjcAMr+lxbJN+wy9cmFkb0NGQ2N
         PbkvqesqjaTjjut4R6I6dKfcao+WgbE9XsfRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kA/Qd/+eF+WsR5dok9DYpPFeLl/YvaQ82KNNeFD5/5s=;
        b=nZcY8ouWVIevNlXmbwUrAwc0zejn6HjfKg3AxRUn04gPKcTl9OBjPS5NUDPKBR5a1r
         jamJXWc2hp+5/guo02+X3cvOYKBcSrUFjOHS8z0agopIAdjMxyBHNduTcxmr0R6c4GmU
         5mWyZ502tRM/qWdorGzKwV+KVds0OubSIaLiMR6IZgbAhxl/qfCgpQ81MsNrQaVynAus
         yUo9DUdiPBbQTAcD3k/9ItlP9mII6XYncQK76GTaA9wjaCiHUDM0P882zz0aXeETjmF3
         gnxelSb0eAwM2IR1OhjMwxQykXOkWmtnlxZeu/PrlNDuND/jyeWpA/krXTYcOgzlvzPG
         fm2w==
X-Gm-Message-State: APt69E3GyrreUlFDvWbHFvz6pYlFaUIqyJZ3PpPsZGgfWqFKdqruJ5iF
        bIaQppqusr1NiT75/JqhQDFMDeiD
X-Google-Smtp-Source: AAOMgped1QAiTZpfoCa1U7NeVN2Ne7aCd9dSGS/In4BgmCvSlZdDwEDGjhxeIrraKa0goZXb7eJamw==
X-Received: by 2002:adf:fc8c:: with SMTP id g12-v6mr8226893wrr.216.1530182633481;
        Thu, 28 Jun 2018 03:43:53 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id 14-v6sm9257298wmh.8.2018.06.28.03.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 03:43:52 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 2/3] locking: Clarify requirements for smp_mb__after_spinlock()
Date:   Thu, 28 Jun 2018 12:41:19 +0200
Message-Id: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 11 interpretations of the requirements described in the header
comment for smp_mb__after_spinlock(): one for each LKMM maintainer, and
one currently encoded in the Cat file. Stick to the latter (until a more
satisfactory solution is presented/agreed).

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
---
 include/linux/spinlock.h | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1e8a464358384..6737ee2381d50 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -114,29 +114,8 @@ do {								\
 #endif /*arch_spin_is_contended*/
 
 /*
- * This barrier must provide two things:
- *
- *   - it must guarantee a STORE before the spin_lock() is ordered against a
- *     LOAD after it, see the comments at its two usage sites.
- *
- *   - it must ensure the critical section is RCsc.
- *
- * The latter is important for cases where we observe values written by other
- * CPUs in spin-loops, without barriers, while being subject to scheduling.
- *
- * CPU0			CPU1			CPU2
- *
- *			for (;;) {
- *			  if (READ_ONCE(X))
- *			    break;
- *			}
- * X=1
- *			<sched-out>
- *						<sched-in>
- *						r = X;
- *
- * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
- * we get migrated and CPU2 sees X==0.
+ * smp_mb__after_spinlock() provides a full memory barrier between po-earlier
+ * lock acquisitions and po-later memory accesses.
  *
  * Since most load-store architectures implement ACQUIRE with an smp_mb() after
  * the LL/SC loop, they need no further barriers. Similarly all our TSO
-- 
2.7.4

