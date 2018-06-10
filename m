Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id O04AO0e4HVvWJAAAmS7hNA
	; Sun, 10 Jun 2018 23:46:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D0FE960791; Sun, 10 Jun 2018 23:46:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ex9SLnpi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 35D1F604D4;
	Sun, 10 Jun 2018 23:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35D1F604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbeFJXqL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 19:46:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40716 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbeFJXp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 19:45:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so9280309pfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 16:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sAsnYkTBYc+FGHe6cSqvPL8irZtOAqC+0fBuLqZw7qQ=;
        b=ex9SLnpiWtQqGhQDsbr62ypGjipmAICpR9OMSplBc8735rzzIHDSo2cf1bnPGVQB3p
         C1D8PwOi+Lw+m7VvJsggV+56wuCCdMgpcPKjTe05PCmYLBSarMKowj33umZX88hKkFWr
         KbBx1QjOGyVPOzzIMTZMiMIxdzR6xlhXH0bR0orny6Pta/75t+hWV/eWSZvinjYGG+Jc
         bi9wgKvSevNPBtYaxvkRIBdUT93d2QRujZVM52je/T5LkiIbzcswUm0wMWsdEI2PweWg
         fat1W+YpQgUv2vMsFXFw9nPWfOfj8fMvM0/dnmRnpIEp3xZcjcFNbXEbbVA8ytZqwhVl
         oBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sAsnYkTBYc+FGHe6cSqvPL8irZtOAqC+0fBuLqZw7qQ=;
        b=sXib8W237KI9vFFkrkaGda1oLW+RjX2YcIBMf4DZJW9rgKkijII2g4a+/qBcWTzeZN
         B+XtDl7ZnanWiOIv3gvhzsWaocJ9V+8fF5jgvO/Kn98rjMMu10XpJsOqmmAuy4GARQvE
         7C74ouBgtrMV97kj2Dmy+OsvfOnqQGn2xF+H+0yxwk2vntINw44jw10qOo8gPGIC/oio
         wy9Tbk0zyjXBcnhBWoDSlcSTzO6vfc2uI4hn3Mb4zdaov7BNkXxOTIca/xLy2gcDn3V+
         ZmBb7sOH2Cd6cCc80tr1FH6VOgHr9iv65MBYuFFKsu6s3Pd7M0Om06SEowtNftWFwpJe
         WPvw==
X-Gm-Message-State: APt69E12v6ni6PsKkZPA7ABO/0YGeJ8Dmxltvjq/6G8o7PDSdwwybowf
        79fRmWLBcv5A1lptgfjtZakC19TMXoQ=
X-Google-Smtp-Source: ADUXVKI+jYbh2ztVguJJquHDe3HRSsKgL0RLfTGo8IXAY2qVfBIxqzd4ucRQAQZDxOCW5UWsj/roCg==
X-Received: by 2002:a63:6501:: with SMTP id z1-v6mr12693397pgb.452.1528674357550;
        Sun, 10 Jun 2018 16:45:57 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x72-v6sm64939133pff.176.2018.06.10.16.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 16:45:57 -0700 (PDT)
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mingo@redhat.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de
Subject: [PATCH 2/2] rcutorture: Make boost test more robust
Date: Sun, 10 Jun 2018 16:45:44 -0700
Message-Id: <20180610234544.150933-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180610234544.150933-1-joel@joelfernandes.org>
References: <20180610234544.150933-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently, with RCU_BOOST disabled, I get no failures when forcing
rcutorture to test RCU boost priority inversion. The reason seems to be
that we don't check for failures if the callback never ran at all for
the duration of the boost-test loop.

Further, the 'rtb' and 'rtbf' counters seem to be used inconsistently.
'rtb' is incremented at the start of each test and 'rtbf' is incremented
per-cpu on each failure of call_rcu. So its possible 'rtbf' > 'rtb'.

To test the boost with rcutorture, I did following on a 4-CPU x86 machine:

modprobe rcutorture  test_boost=2
sleep 20
rmmod rcutorture

With patch:
rtbf: 8 rtb: 12

Without patch:
rtbf: 0 rtb: 2

In summary this patch:
 - Increments failed and total test counters once per boost-test.
 - Checks for failure cases correctly.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 45 +++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 00e06349d7bb..0040cc2b836b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -799,6 +799,18 @@ static void rcu_torture_enable_rt_throttle(void)
 	old_rt_runtime = -1;
 }
 
+static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
+{
+	if (end - start > test_boost_duration * HZ - HZ / 2) {
+		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
+		n_rcu_torture_boost_failure++;
+
+		return true; /* failed */
+	}
+
+	return false; /* passed */
+}
+
 static int rcu_torture_boost(void *arg)
 {
 	unsigned long call_rcu_time;
@@ -819,6 +831,21 @@ static int rcu_torture_boost(void *arg)
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
+		/* Track if the test failed already in this test interval? */
+		bool failed = false;
+
+		/* Increment n_rcu_torture_boosts once per boost-test */
+		while (!kthread_should_stop()) {
+			if (mutex_trylock(&boost_mutex)) {
+				n_rcu_torture_boosts++;
+				mutex_unlock(&boost_mutex);
+				break;
+			}
+			schedule_timeout_uninterruptible(1);
+		}
+		if (kthread_should_stop())
+			goto checkwait;
+
 		/* Wait for the next test interval. */
 		oldstarttime = boost_starttime;
 		while (ULONG_CMP_LT(jiffies, oldstarttime)) {
@@ -837,11 +864,10 @@ static int rcu_torture_boost(void *arg)
 				/* RCU core before ->inflight = 1. */
 				smp_store_release(&rbi.inflight, 1);
 				call_rcu(&rbi.rcu, rcu_torture_boost_cb);
-				if (jiffies - call_rcu_time >
-					 test_boost_duration * HZ - HZ / 2) {
-					VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
-					n_rcu_torture_boost_failure++;
-				}
+				/* Check if the boost test failed */
+				failed = failed ||
+					 rcu_torture_boost_failed(call_rcu_time,
+								 jiffies);
 				call_rcu_time = jiffies;
 			}
 			stutter_wait("rcu_torture_boost");
@@ -849,6 +875,14 @@ static int rcu_torture_boost(void *arg)
 				goto checkwait;
 		}
 
+		/*
+		 * If boost never happened, then inflight will always be 1, in
+		 * this case the boost check would never happen in the above
+		 * loop so do another one here.
+		 */
+		if (!failed && smp_load_acquire(&rbi.inflight))
+			rcu_torture_boost_failed(call_rcu_time, jiffies);
+
 		/*
 		 * Set the start time of the next test interval.
 		 * Yes, this is vulnerable to long delays, but such
@@ -861,7 +895,6 @@ static int rcu_torture_boost(void *arg)
 			if (mutex_trylock(&boost_mutex)) {
 				boost_starttime = jiffies +
 						  test_boost_interval * HZ;
-				n_rcu_torture_boosts++;
 				mutex_unlock(&boost_mutex);
 				break;
 			}
-- 
2.18.0.rc1.242.g61856ae69a-goog
