Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A15C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD4F20834
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BG3t+4OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD4F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeHHE1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:27:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35662 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeHHE1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:27:51 -0400
Received: by mail-qt0-f196.google.com with SMTP id r21-v6so799114qtm.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dTWzlJbte7Ktvl+TnVgtlz/TadLPhuWbLcWgya24Jpo=;
        b=BG3t+4OPZycccxfYAnekHbHfQUfKiTH2J7B6lLs8RcdRQEkR2J/eTUM/925eVsGgK5
         guTh6OWvG/IRbeJPp08lDjVfrsg+SUhaStzuMDVlbuDhfk9Y9DDDRikPNMnyBoLOOtLO
         3IJ9CsALw2yI4cgaMvepc9INcc5ClURnuX6c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dTWzlJbte7Ktvl+TnVgtlz/TadLPhuWbLcWgya24Jpo=;
        b=PKnQbNP8Re4kpoxFIl2ZfvYV4E8SlLvk6Pvcuzm3WSCt+SNNoX2Zmns8Du3wSpzL+U
         zUAWq45M93aWJvr8vi+fCGXswCz06G07BD/sVd0hkH88vnfICSFJAfWEWGa4ISGtcAAm
         K8pTDumnU8gEhtJzPzbHWZRqNMXcPdc1JTBsKMY/GLwT6SbJZrF5K+XQ7mxtL8XfG7Bx
         FFPq42t5tFEYl0Tj4OHstYIwxCnhbmAmmJJSigJnW8rN4892rykNp/1LtbfqBGjN4kt+
         +DvL/ELVOBFg9JASBmTt5+Uuiz7UfplmEJRAgwjEZdkCwlKvK6EIOJ+HGRdc+nfQ1BO7
         lDmw==
X-Gm-Message-State: AOUpUlEXA2fYVEnsheEp8dhHJo53yY64OwIzPLlrJaoSb74/TuoMdZes
        tbk5AFrS2BBS+Nq4SRTG+yFP/kLetmE=
X-Google-Smtp-Source: AA+uWPz37id5wD8nZx4+Wg/gRbm7uhoqDb/f9l9TVehQmTGgsisJZciOnl+op6BbC0vvFOg3vGYDOA==
X-Received: by 2002:ac8:1779:: with SMTP id u54-v6mr888998qtk.285.1533694234472;
        Tue, 07 Aug 2018 19:10:34 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com ([2601:5c2:201:936::a37e])
        by smtp.gmail.com with ESMTPSA id o26-v6sm1950316qtk.4.2018.08.07.19.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 19:10:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com,
        mathieu.desnoyers@efficios.com, tglx@linutronix.de
Subject: [PATCH RFC] tracepoint: Use SRCU for all tracepoint invocations
Date:   Tue,  7 Aug 2018 19:10:21 -0700
Message-Id: <20180808021021.230669-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven reported that rcuidle && in_nmi() condition can occur which
creates a problem for SRCU usage, since we can't use the SRCU node from
both NMI context and other contexts (NMI can come in while the SRCU read
lock is in the process of being held).

This patch switches to using a separate SRCU node for tracepoints called
from in_nmi(). This is needed to also make tracepoints work while CPU is
offline.

Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and
                      unify their usage")
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Dropped the "CPU offline" changes, and only keeping the SRCU changes.

 include/linux/tracepoint.h | 19 ++++++++-----------
 kernel/tracepoint.c        | 10 ++++++----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index d9a084c72541..1ceee17a38dc 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -35,6 +35,7 @@ struct trace_eval_map {
 #define TRACEPOINT_DEFAULT_PRIO	10
 
 extern struct srcu_struct tracepoint_srcu;
+extern struct srcu_struct tracepoint_srcu_nmi;
 
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
@@ -144,13 +145,11 @@ extern void syscall_unregfunc(void);
 		void *it_func;						\
 		void *__data;						\
 		int __maybe_unused idx = 0;				\
+		struct srcu_struct *ss;					\
 									\
 		if (!(cond))						\
 			return;						\
 									\
-		/* srcu can't be used from NMI */			\
-		WARN_ON_ONCE(rcuidle && in_nmi());			\
-									\
 		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
 									\
@@ -159,7 +158,11 @@ extern void syscall_unregfunc(void);
 		 * doesn't work from the idle path.			\
 		 */							\
 		if (rcuidle)						\
-			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
+			ss = &tracepoint_srcu_nmi;			\
+		else							\
+			ss = &tracepoint_srcu;				\
+									\
+		idx = srcu_read_lock_notrace(ss);			\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -171,8 +174,7 @@ extern void syscall_unregfunc(void);
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle)						\
-			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
+		srcu_read_unlock_notrace(ss, idx);			\
 									\
 		preempt_enable_notrace();				\
 	} while (0)
@@ -212,11 +214,6 @@ extern void syscall_unregfunc(void);
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 0);			\
-		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
-			rcu_read_lock_sched_notrace();			\
-			rcu_dereference_sched(__tracepoint_##name.funcs);\
-			rcu_read_unlock_sched_notrace();		\
-		}							\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
 		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 955148d91b74..769d74b2f90e 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -32,7 +32,9 @@ extern struct tracepoint * const __start___tracepoints_ptrs[];
 extern struct tracepoint * const __stop___tracepoints_ptrs[];
 
 DEFINE_SRCU(tracepoint_srcu);
+DEFINE_SRCU(tracepoint_srcu_nmi);
 EXPORT_SYMBOL_GPL(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu_nmi);
 
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
@@ -70,14 +72,14 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void srcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes_nmi(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
-	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+	call_srcu(&tracepoint_srcu_nmi, head, srcu_free_old_probes_nmi);
 }
 
 static inline void release_probes(struct tracepoint_func *old)
@@ -91,7 +93,7 @@ static inline void release_probes(struct tracepoint_func *old)
 		 * cover both cases. So let us chain the SRCU and sched RCU
 		 * callbacks to wait for both grace periods.
 		 */
-		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
+		call_srcu(&tracepoint_srcu, &tp_probes->rcu, srcu_free_old_probes);
 	}
 }
 
-- 
2.18.0.597.ga71716f1ad-goog

