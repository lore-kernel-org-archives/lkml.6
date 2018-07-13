Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4465DECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12E42087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WaBev1vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12E42087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeGMWM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:12:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36375 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeGMWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:12:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id u16-v6so23323260pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1mYBJsHMIqmk37mLKsMQrlBQi1HvJKTuqoh+4Ivrmk4=;
        b=WaBev1vjFXPyxNcVV88HFc9oCYz0rzrcVaskkQsTHfMiQ43AR2gsvFbx2bOMmt/q6W
         ez7Wxa8aBdtLcK33Y/SXPv/IlzJNG8S1qaPMsXPjYWijtFcHnx7vSg5jl+pLZ0ZLSFP4
         bAN/fqJl231ETR8S9qikW4LvxCR9q+3R7rg60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1mYBJsHMIqmk37mLKsMQrlBQi1HvJKTuqoh+4Ivrmk4=;
        b=UeglM8ObnUo0a1eNp6yYsagHtfzQ+jB1YRvq4qGwhh1j4/a20X/ujJFaay5GtRmvOr
         KwTywlMIkAwroZQQYBkWNk8mg7EC+aGRDohyJv6qp+OxE+nseovJPCHUHgYW/2sjTGrF
         8Cd8vpFkjPxAP3/VJzoo0EpP+wHR/Rd58JMmzKA2TAVk84weLwLeU02NP4CNg9BMJeN8
         WsqqUP6UBytMKFPXjMP2tZG3uO6gTovVeI+8yACMeaP83RTAr9Y4s/6vho7FhJ7gLq2x
         nxvEPUTtbjlT0AyGsO+ijDUVhgSl5USW9ettysyq0fyzAhwBUc7vEvKMZKh+POm7sqzC
         rCEA==
X-Gm-Message-State: AOUpUlHx7xqUVLbEl+wfmGDj5aLL7l7OXQYRFsmXB96RWEho/RVu3UMO
        aq0FEKOKI7C/Ehol5WVu24LLl/Cgd6Y=
X-Google-Smtp-Source: AAOMgpdeio9P4XXUwBG3oqmmCWD3/GggKQ6Ug3PEJkWAtoBSLWoqNmArL19dn6sYpsj17Ri2C3kIAA==
X-Received: by 2002:a62:b29c:: with SMTP id z28-v6mr8918631pfl.8.1531518955522;
        Fri, 13 Jul 2018 14:55:55 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id k4-v6sm35232990pgo.49.2018.07.13.14.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 14:55:55 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v10 1/3] lockdep: use this_cpu_ptr instead of get_cpu_var stats
Date:   Fri, 13 Jul 2018 14:55:45 -0700
Message-Id: <20180713215547.255620-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180713215547.255620-1-joel@joelfernandes.org>
References: <20180713215547.255620-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

get_cpu_var disables preemption which has the potential to call into the
preemption disable trace points causing some complications. There's also
no need to disable preemption in uses of get_lock_stats anyway since
preempt is already disabled. So lets simplify the code.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/locking/lockdep.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5fa4d3138bf1..8f5ce0048d15 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -248,12 +248,7 @@ void clear_lock_stats(struct lock_class *class)
 
 static struct lock_class_stats *get_lock_stats(struct lock_class *class)
 {
-	return &get_cpu_var(cpu_lock_stats)[class - lock_classes];
-}
-
-static void put_lock_stats(struct lock_class_stats *stats)
-{
-	put_cpu_var(cpu_lock_stats);
+	return &this_cpu_ptr(&cpu_lock_stats)[class - lock_classes];
 }
 
 static void lock_release_holdtime(struct held_lock *hlock)
@@ -271,7 +266,6 @@ static void lock_release_holdtime(struct held_lock *hlock)
 		lock_time_inc(&stats->read_holdtime, holdtime);
 	else
 		lock_time_inc(&stats->write_holdtime, holdtime);
-	put_lock_stats(stats);
 }
 #else
 static inline void lock_release_holdtime(struct held_lock *hlock)
@@ -4090,7 +4084,6 @@ __lock_contended(struct lockdep_map *lock, unsigned long ip)
 		stats->contending_point[contending_point]++;
 	if (lock->cpu != smp_processor_id())
 		stats->bounces[bounce_contended + !!hlock->read]++;
-	put_lock_stats(stats);
 }
 
 static void
@@ -4138,7 +4131,6 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 	}
 	if (lock->cpu != cpu)
 		stats->bounces[bounce_acquired + !!hlock->read]++;
-	put_lock_stats(stats);
 
 	lock->cpu = cpu;
 	lock->ip = ip;
-- 
2.18.0.203.gfac676dfb9-goog

