Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E0C46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5424D20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="DPctK5zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5424D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389804AbeHARDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:03:42 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37417 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389691AbeHARDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:03:42 -0400
Received: by mail-qt0-f196.google.com with SMTP id n6-v6so20282454qtl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7HJ/faUwNp70pvtX2vst2/bX0oNS92n5Rlox7XiLwSM=;
        b=DPctK5zfYaQ0V4YIT0cOc+G2ibXQKwNsexBwhBszDgpcxVUcfrnx9WMrfKc89CpzWh
         DmYcv1soQq2VwT3zcvMIUKLLXwi7dgDFW2s8ZmC8sqY3YEjrAc6KPhIzyb83bim9RZIL
         6EX7rvRwWH3wYHU+3AgXrQlfKub5GgQui0IGNFSIm9y8nAHMSO78eLwT72940dbXZgi4
         XxhT6jMElMtHXZAHx8zuyjBtH7w0twHKqHL8aEBHOIMpi92YVD+KXJvpUg+tB50/0v3h
         9Fv3op0mXYXYijb0hMh26+uwl4p3E8GNPT3CVKUyxOxO5cr/UjWFRJ3/6TSkO0snLH3s
         wuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7HJ/faUwNp70pvtX2vst2/bX0oNS92n5Rlox7XiLwSM=;
        b=uGMxnawekpIUOnVpEd9WGOOGUmZ6WazI2JpZmWccyg+JKIfLmx1lskrWeu1k6+IV2b
         BrR/K1zDUheCOzunlAC5YRLs2JgOPNtJCyTgPgSA2pT6n2VosMlyEXxAlPkwK9N3uRRg
         22rHqnENTWAnjHBd55zaexv39meP1w3yuLlCfwYM+HDO4dhlta7x03FivwSh943FME67
         SP0QG4cHQ4UTjcCOhP8380h9pprW4FYvcpeCkMTW/o7T3RnRREb0hOJTF1+mthlKnU0B
         cojXzx4KZPc+S1Ogu5Ljxas8kqRefxV9s6XsTix1si9R/FC4GMBOUtkhgOO9M7U9Seei
         tn8Q==
X-Gm-Message-State: AOUpUlESg6eD21lKnSJinCUbVZyc1/bCYFNDuimHkZS/QJr7DmfYiRBu
        /CPTZftXbNcLnA/2l3OK8Bm3uUV5JbQ=
X-Google-Smtp-Source: AAOMgpdbWpoM7qIjETQdOzVbQgH12G2t7WjQg9oaO/HXxSR73Ckh2cPo3WyzbVTfp8SMPQBIG39a5g==
X-Received: by 2002:ac8:460b:: with SMTP id p11-v6mr26602836qtn.418.1533136650080;
        Wed, 01 Aug 2018 08:17:30 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id t11-v6sm14624295qtc.2.2018.08.01.08.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:17:29 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 5/9] sched: loadavg: make calc_load_n() public
Date:   Wed,  1 Aug 2018 11:19:54 -0400
Message-Id: <20180801151958.32590-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801151958.32590-1-hannes@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's going to be used in a later patch. Keep the churn separate.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/sched/loadavg.h |   3 +
 kernel/sched/loadavg.c        | 138 +++++++++++++++++-----------------
 2 files changed, 72 insertions(+), 69 deletions(-)

diff --git a/include/linux/sched/loadavg.h b/include/linux/sched/loadavg.h
index cc9cc62bb1f8..4859bea47a7b 100644
--- a/include/linux/sched/loadavg.h
+++ b/include/linux/sched/loadavg.h
@@ -37,6 +37,9 @@ calc_load(unsigned long load, unsigned long exp, unsigned long active)
 	return newload / FIXED_1;
 }
 
+extern unsigned long calc_load_n(unsigned long load, unsigned long exp,
+				 unsigned long active, unsigned int n);
+
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 54fbdfb2d86c..28a516575c18 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -91,6 +91,75 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	return delta;
 }
 
+/**
+ * fixed_power_int - compute: x^n, in O(log n) time
+ *
+ * @x:         base of the power
+ * @frac_bits: fractional bits of @x
+ * @n:         power to raise @x to.
+ *
+ * By exploiting the relation between the definition of the natural power
+ * function: x^n := x*x*...*x (x multiplied by itself for n times), and
+ * the binary encoding of numbers used by computers: n := \Sum n_i * 2^i,
+ * (where: n_i \elem {0, 1}, the binary vector representing n),
+ * we find: x^n := x^(\Sum n_i * 2^i) := \Prod x^(n_i * 2^i), which is
+ * of course trivially computable in O(log_2 n), the length of our binary
+ * vector.
+ */
+static unsigned long
+fixed_power_int(unsigned long x, unsigned int frac_bits, unsigned int n)
+{
+	unsigned long result = 1UL << frac_bits;
+
+	if (n) {
+		for (;;) {
+			if (n & 1) {
+				result *= x;
+				result += 1UL << (frac_bits - 1);
+				result >>= frac_bits;
+			}
+			n >>= 1;
+			if (!n)
+				break;
+			x *= x;
+			x += 1UL << (frac_bits - 1);
+			x >>= frac_bits;
+		}
+	}
+
+	return result;
+}
+
+/*
+ * a1 = a0 * e + a * (1 - e)
+ *
+ * a2 = a1 * e + a * (1 - e)
+ *    = (a0 * e + a * (1 - e)) * e + a * (1 - e)
+ *    = a0 * e^2 + a * (1 - e) * (1 + e)
+ *
+ * a3 = a2 * e + a * (1 - e)
+ *    = (a0 * e^2 + a * (1 - e) * (1 + e)) * e + a * (1 - e)
+ *    = a0 * e^3 + a * (1 - e) * (1 + e + e^2)
+ *
+ *  ...
+ *
+ * an = a0 * e^n + a * (1 - e) * (1 + e + ... + e^n-1) [1]
+ *    = a0 * e^n + a * (1 - e) * (1 - e^n)/(1 - e)
+ *    = a0 * e^n + a * (1 - e^n)
+ *
+ * [1] application of the geometric series:
+ *
+ *              n         1 - x^(n+1)
+ *     S_n := \Sum x^i = -------------
+ *             i=0          1 - x
+ */
+unsigned long
+calc_load_n(unsigned long load, unsigned long exp,
+	    unsigned long active, unsigned int n)
+{
+	return calc_load(load, fixed_power_int(exp, FSHIFT, n), active);
+}
+
 #ifdef CONFIG_NO_HZ_COMMON
 /*
  * Handle NO_HZ for the global load-average.
@@ -210,75 +279,6 @@ static long calc_load_nohz_fold(void)
 	return delta;
 }
 
-/**
- * fixed_power_int - compute: x^n, in O(log n) time
- *
- * @x:         base of the power
- * @frac_bits: fractional bits of @x
- * @n:         power to raise @x to.
- *
- * By exploiting the relation between the definition of the natural power
- * function: x^n := x*x*...*x (x multiplied by itself for n times), and
- * the binary encoding of numbers used by computers: n := \Sum n_i * 2^i,
- * (where: n_i \elem {0, 1}, the binary vector representing n),
- * we find: x^n := x^(\Sum n_i * 2^i) := \Prod x^(n_i * 2^i), which is
- * of course trivially computable in O(log_2 n), the length of our binary
- * vector.
- */
-static unsigned long
-fixed_power_int(unsigned long x, unsigned int frac_bits, unsigned int n)
-{
-	unsigned long result = 1UL << frac_bits;
-
-	if (n) {
-		for (;;) {
-			if (n & 1) {
-				result *= x;
-				result += 1UL << (frac_bits - 1);
-				result >>= frac_bits;
-			}
-			n >>= 1;
-			if (!n)
-				break;
-			x *= x;
-			x += 1UL << (frac_bits - 1);
-			x >>= frac_bits;
-		}
-	}
-
-	return result;
-}
-
-/*
- * a1 = a0 * e + a * (1 - e)
- *
- * a2 = a1 * e + a * (1 - e)
- *    = (a0 * e + a * (1 - e)) * e + a * (1 - e)
- *    = a0 * e^2 + a * (1 - e) * (1 + e)
- *
- * a3 = a2 * e + a * (1 - e)
- *    = (a0 * e^2 + a * (1 - e) * (1 + e)) * e + a * (1 - e)
- *    = a0 * e^3 + a * (1 - e) * (1 + e + e^2)
- *
- *  ...
- *
- * an = a0 * e^n + a * (1 - e) * (1 + e + ... + e^n-1) [1]
- *    = a0 * e^n + a * (1 - e) * (1 - e^n)/(1 - e)
- *    = a0 * e^n + a * (1 - e^n)
- *
- * [1] application of the geometric series:
- *
- *              n         1 - x^(n+1)
- *     S_n := \Sum x^i = -------------
- *             i=0          1 - x
- */
-static unsigned long
-calc_load_n(unsigned long load, unsigned long exp,
-	    unsigned long active, unsigned int n)
-{
-	return calc_load(load, fixed_power_int(exp, FSHIFT, n), active);
-}
-
 /*
  * NO_HZ can leave us missing all per-CPU ticks calling
  * calc_load_fold_active(), but since a NO_HZ CPU folds its delta into
-- 
2.18.0

