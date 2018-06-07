Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N4y6GY4CGVtpIwAAmS7hNA
	; Thu, 07 Jun 2018 10:02:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1DCC9607DC; Thu,  7 Jun 2018 10:02:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hlHO9gtR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 155386063F;
	Thu,  7 Jun 2018 10:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 155386063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeFGKCR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:02:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52778 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeFGKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:02:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so16793258wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X16pk0Ml23pL4XoS0LJ114RDqw7fQNqIijYPiOAf2eg=;
        b=hlHO9gtRedmyvuH6CHklUNngEGgzS2QkGqbiGXI82d4nL48dsB7wviNWQOtdG6cjz9
         4xbwietGMWJ3/eWXy0yrLSQroMXzyax5YpTdn4O0FE1Qc6w81AY5jGUsUWYRGXHv1Tz/
         vc3JtPJDkOyLf/lwFqYCEek+y81V8AfJnsh3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X16pk0Ml23pL4XoS0LJ114RDqw7fQNqIijYPiOAf2eg=;
        b=NopJtI8l4Jiq4fCj49Zo/Sg1gW21jSanLHcb2Zh7BICgaK2rnQKigR1r15qQyYnbk/
         vAs37zzOGtuV0gLtKrfhNix2Ep3C6zxHSXo4vPtVul8sLKjmX9mn6Yy3LSfy7huwlTE9
         rtLoXa13RGZex5BrNItLJXF2jTkY/XXNP3gKNALKqyd4KKNLmfTYl3NgDQSDW9HVnYNp
         6yeuRvFVKI46qxz5i2pIeic8QkKSqqhp6B+f6EmGrL1iLCQIwJNx4/b5MFT2l5AYBVTn
         m77zCb4CEdKFHTwO6NRq2BXN3WGS8nnhjESqc3E2SVmUeCkOVtHUelsTyQqRc3rNhgVr
         oYXQ==
X-Gm-Message-State: APt69E3bpWdEDTNXTgqAI2hZ1s05H6sj2vlf1s3b7ABZsNtH6EyG0gr/
        fjWTeqBoyI/YjGxgkh5wrPdqNN9d
X-Google-Smtp-Source: ADUXVKJ4HVVXtY0zhwY8YjydA2gEIp+RlChA7vgSrcszRIwVtJl7tX006Wl/V/itwFTjtQs10M/FkA==
X-Received: by 2002:a1c:581:: with SMTP id 123-v6mr1177187wmf.58.1528365733231;
        Thu, 07 Jun 2018 03:02:13 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id b80-v6sm2161583wmf.2.2018.06.07.03.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 03:02:12 -0700 (PDT)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] doc: Update synchronize_rcu() definition in whatisRCU.txt
Date: Thu,  7 Jun 2018 12:01:57 +0200
Message-Id: <1528365717-7213-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synchronize_rcu() definition based on RW-locks in whatisRCU.txt
does not meet the "Memory-Barrier Guarantees" in Requirements.html;
for example, the following SB-like test:

    P0:                      P1:

    WRITE_ONCE(x, 1);        WRITE_ONCE(y, 1);
    synchronize_rcu();       smp_mb();
    r0 = READ_ONCE(y);       r1 = READ_ONCE(x);

should not be allowed to reach the state "r0 = 0 AND r1 = 0", but
the current write_lock()+write_unlock() definition can not ensure
this. Remedies this by inserting an smp_mb__after_spinlock().

Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/RCU/whatisRCU.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index a27fbfb0efb82..86a54ff911fc2 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -586,6 +586,7 @@ It is extremely simple:
 	void synchronize_rcu(void)
 	{
 		write_lock(&rcu_gp_mutex);
+		smp_mb__after_spinlock();
 		write_unlock(&rcu_gp_mutex);
 	}
 
@@ -607,12 +608,15 @@ don't forget about them when submitting patches making use of RCU!]
 
 The rcu_read_lock() and rcu_read_unlock() primitive read-acquire
 and release a global reader-writer lock.  The synchronize_rcu()
-primitive write-acquires this same lock, then immediately releases
-it.  This means that once synchronize_rcu() exits, all RCU read-side
-critical sections that were in progress before synchronize_rcu() was
-called are guaranteed to have completed -- there is no way that
-synchronize_rcu() would have been able to write-acquire the lock
-otherwise.
+primitive write-acquires this same lock, then releases it.  This means
+that once synchronize_rcu() exits, all RCU read-side critical sections
+that were in progress before synchronize_rcu() was called are guaranteed
+to have completed -- there is no way that synchronize_rcu() would have
+been able to write-acquire the lock otherwise.  The smp_mb__after_spinlock()
+promotes synchronize_rcu() to a full memory barrier in compliance with
+the "Memory-Barrier Guarantees" listed in:
+
+	Documentation/RCU/Design/Requirements/Requirements.html.
 
 It is possible to nest rcu_read_lock(), since reader-writer locks may
 be recursively acquired.  Note also that rcu_read_lock() is immune
-- 
2.7.4
