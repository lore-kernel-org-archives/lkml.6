Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DqchHDy4HVtdKgAAmS7hNA
	; Sun, 10 Jun 2018 23:46:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5752360792; Sun, 10 Jun 2018 23:46:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNozJIFI"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B5DCD604D4;
	Sun, 10 Jun 2018 23:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5DCD604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753723AbeFJXp7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 19:45:59 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33162 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753531AbeFJXp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 19:45:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so9282291pfi.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 16:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=plNzHcAhpungQm78VxafCFi2EDjeTT64qkFxxYjePAU=;
        b=eNozJIFI6hQd7Lv2ig9iNzmInQpinrSaaqC/35SfvgP24kaf1EuhPDZGTcSFLr78eL
         WBmiVbMtXqdOJJ/xiyV4dsVeEjcene5UwwxZoNeBu5viLVoir+qKWrT2Jgj+qDOAP0mK
         Bjsr1GUy78XTmGD7oqeuFH8UzIovASXMs4RSTmkRv7TGEmhdlT+rFkbWwuKXfZeiX1nc
         iSv8e649xExdbDXzjh6gmUfNe7cDZq5RBZb3bTosnbzqVRD3fv1htVTjzbdGciVxPaei
         3p1MfjlBg9vUBGDrl3UEuLyqRXMIWV3UueUARXLekgg/WtvWDYKdFv4/s9v7MYASZVf1
         XTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=plNzHcAhpungQm78VxafCFi2EDjeTT64qkFxxYjePAU=;
        b=Prx3ON5t5flm80e1Gls7daxL3LGsF9/NUndAmThOWOEFIJMWvWlNYblxzF7pkEnWYh
         6C8TCqo2U1iPV3QnC4itWz8UhgwFAesnYngw6BPcxXuUqNz8drWJpmWzAEybQZo2mjZt
         7Fe5yjKI6TI4bu9hld0had87h9kKt/NjQEIafR83BzyLRptB6kTPPr9fdLI3hsipetQi
         tbgTeaaQesTFIofonhXqEUUzq8aWepLLv4TXiLqthEZLhJ91JbO7LzVlvXPGPk6beXPK
         iXHmsHkPBjmNDMeqknmJKYpeTYC2uWFhJmpiUsK4fJRS5dmebWzxxwSak/vUMYeCht15
         L4ow==
X-Gm-Message-State: APt69E0+3HWGZ2EQKXJo/hyNo7jOkce8YFgeYZGg+JBauHcta9b7XvOy
        tFuCXu8kpHA8r9i5Yx2Xka0do8bcA6E=
X-Google-Smtp-Source: ADUXVKLB7+T+A43Z7KWUd+HNcmgc7s9JeiRhmQ9GsbzKYW0mBsQ5YegJNU4aEitKKQpI5KcVMDRBAg==
X-Received: by 2002:a65:51c9:: with SMTP id i9-v6mr10502094pgq.202.1528674356525;
        Sun, 10 Jun 2018 16:45:56 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id x72-v6sm64939133pff.176.2018.06.10.16.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 16:45:55 -0700 (PDT)
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
Subject: [PATCH 1/2] rcutorture: Disable RT throttling for boost tests
Date: Sun, 10 Jun 2018 16:45:43 -0700
Message-Id: <20180610234544.150933-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently rcutorture is not able to torture RCU boosting properly. This
is because the rcutorture's boost threads which are doing the torturing
may be throttled due to RT throttling.

This patch makes rcutorture use the right torture technique (unthrottled
rcutorture boost tasks) for torturing RCU so that the test fails
correctly when no boost is available.

Currently this requires accessing sysctl_sched_rt_runtime directly, but
that should be Ok since rcutorture is test code. Such direct access is
also only possible if rcutorture is used as a built-in so make it
conditional on that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5219e7ccd8a4..00e06349d7bb 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -55,6 +55,7 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/sysctl.h>
 
 #include "rcu.h"
 
@@ -772,6 +773,32 @@ static void rcu_torture_boost_cb(struct rcu_head *head)
 	smp_store_release(&rbip->inflight, 0);
 }
 
+static int old_rt_runtime = -1;
+
+static void rcu_torture_disable_rt_throttle(void)
+{
+	/*
+	 * Disable RT throttling so that rcutorture's boost threads don't get
+	 * throttled. Only possible if rcutorture is built-in otherwise the
+	 * user should manually do this by setting the sched_rt_period_us and
+	 * sched_rt_runtime sysctls.
+	 */
+	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
+		return;
+
+	old_rt_runtime = sysctl_sched_rt_runtime;
+	sysctl_sched_rt_runtime = -1;
+}
+
+static void rcu_torture_enable_rt_throttle(void)
+{
+	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
+		return;
+
+	sysctl_sched_rt_runtime = old_rt_runtime;
+	old_rt_runtime = -1;
+}
+
 static int rcu_torture_boost(void *arg)
 {
 	unsigned long call_rcu_time;
@@ -1510,6 +1537,7 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
 	mutex_lock(&boost_mutex);
 	t = boost_tasks[cpu];
 	boost_tasks[cpu] = NULL;
+	rcu_torture_enable_rt_throttle();
 	mutex_unlock(&boost_mutex);
 
 	/* This must be outside of the mutex, otherwise deadlock! */
@@ -1526,6 +1554,7 @@ static int rcutorture_booster_init(unsigned int cpu)
 
 	/* Don't allow time recalculation while creating a new task. */
 	mutex_lock(&boost_mutex);
+	rcu_torture_disable_rt_throttle();
 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
 	boost_tasks[cpu] = kthread_create_on_node(rcu_torture_boost, NULL,
 						  cpu_to_node(cpu),
-- 
2.18.0.rc1.242.g61856ae69a-goog
