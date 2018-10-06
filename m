Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB64ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A317B208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 19:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZrfeM0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A317B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeJGC66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 22:58:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33574 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJGC66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 22:58:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id s4-v6so8315474plp.0;
        Sat, 06 Oct 2018 12:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q2isY+1SsEnXd5TNs9kCj5VetlPq/HDeDGs51chPnA0=;
        b=DZrfeM0Uq9rjPYpdS+MCVv0+mwRPmtJl5V3qySvBYPo5M2dtuEIs4+ZwrzFpMOUZJn
         vldAkTFE+TOe229RWSccRH/HumHJ02kMFJA+WeI8zyJBFMFMLvALTucP/SDwgtgtMy59
         0ngZjAEVg8UqrEEjG5i7p9M9VAQO0Ubp8F+1lK/H2WoXcVq9ZMZiD7vZuwlhOtKKnJj5
         ZolYZRB+HNOHfDN5gLiAvYpB6ifqsLJayO2jnbbkeTX9TL6YBUVnnuUyPcMaEgo0qLWh
         Og5ZroJUR7HWOfLB03vphlhKJQVj8o+hJjdhkXCFst99qr+eWPy6UXlengdMItFm+dmX
         08XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q2isY+1SsEnXd5TNs9kCj5VetlPq/HDeDGs51chPnA0=;
        b=W0Tvc6z74i79q5LJ/xOb/xiQTg7YJaalFbBpD6yrT76V4uQezk7Ih2jKp6cZThkYaY
         JQxQOqHt866tHYCdBkxywSbxPEBj7qxh2H2geONGjif2Za0qL6M4kD919HOWqisCK2OR
         M2eM/oSftXdI33m8CWvTWRFDM59cTwzreH14KrUW8VRZjjlZny/Cnyoh30JLxjVoavzd
         IUqaVeJzFHsDoOOA6tig3wJQTcSOcwcFQw/KeF6G0sC728WBl0k7BqpDAlQFKvRgQfKN
         jtEcWLU7VsiGpi3wERc5EfsKgezMu4pApCzuLlX1GbSFyG9wRmVU/d2k0/86b3jCG5/c
         IJ1Q==
X-Gm-Message-State: ABuFfoiwvVfakDLqH8BSQma7I/0bqutPTGcYQ3I7lgDlrwg9UgnoObEd
        KmBs5jEA5B0y0IPa/KCyQ/iF1v8tA34=
X-Google-Smtp-Source: ACcGV635Cn22k2lwPSBR7nrHIsyxljEW2WBUondIw8GS4+QnVBf5T5N89XUSZnwCE8rWaVqKANq9/g==
X-Received: by 2002:a17:902:3143:: with SMTP id w61-v6mr17356086plb.85.1538855662569;
        Sat, 06 Oct 2018 12:54:22 -0700 (PDT)
Received: from localhost.localdomain ([106.193.73.211])
        by smtp.gmail.com with ESMTPSA id f193-v6sm20174608pfc.74.2018.10.06.12.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Oct 2018 12:54:22 -0700 (PDT)
From:   Leslie Monis <lesliemonis@gmail.com>
To:     jhs@mojatatu.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leslie Monis <lesliemonis@gmail.com>
Subject: [PATCH] net: sched: pie: fix coding style issues
Date:   Sun,  7 Oct 2018 01:22:45 +0530
Message-Id: <1538855565-22986-1-git-send-email-lesliemonis@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 5 warnings and 14 checks issued by checkpatch.pl:

CHECK: Logical continuations should be on the previous line
+	if ((q->vars.qdelay < q->params.target / 2)
+	    && (q->vars.prob < MAX_PROB / 5))

WARNING: line over 80 characters
+		q->params.tupdate = usecs_to_jiffies(nla_get_u32(tb[TCA_PIE_TUPDATE]));

CHECK: Blank lines aren't necessary after an open brace '{'
+{
+

CHECK: braces {} should be used on all arms of this statement
+			if (qlen < QUEUE_THRESHOLD)
[...]
+			else {
[...]

CHECK: Unbalanced braces around else statement
+			else {

CHECK: No space is necessary after a cast
+	if (delta > (s32) (MAX_PROB / (100 / 2)) &&

CHECK: Unnecessary parentheses around 'qdelay == 0'
+	if ((qdelay == 0) && (qdelay_old == 0) && update_prob)

CHECK: Unnecessary parentheses around 'qdelay_old == 0'
+	if ((qdelay == 0) && (qdelay_old == 0) && update_prob)

CHECK: Unnecessary parentheses around 'q->vars.prob == 0'
+	if ((q->vars.qdelay < q->params.target / 2) &&
+	    (q->vars.qdelay_old < q->params.target / 2) &&
+	    (q->vars.prob == 0) &&
+	    (q->vars.avg_dq_rate > 0))

CHECK: Unnecessary parentheses around 'q->vars.avg_dq_rate > 0'
+	if ((q->vars.qdelay < q->params.target / 2) &&
+	    (q->vars.qdelay_old < q->params.target / 2) &&
+	    (q->vars.prob == 0) &&
+	    (q->vars.avg_dq_rate > 0))

CHECK: Blank lines aren't necessary before a close brace '}'
+
+}

CHECK: Comparison to NULL could be written "!opts"
+	if (opts == NULL)

CHECK: No space is necessary after a cast
+			((u32) PSCHED_TICKS2NS(q->params.target)) /

WARNING: line over 80 characters
+	    nla_put_u32(skb, TCA_PIE_TUPDATE, jiffies_to_usecs(q->params.tupdate)) ||

CHECK: Blank lines aren't necessary before a close brace '}'
+
+}

CHECK: No space is necessary after a cast
+		.delay		= ((u32) PSCHED_TICKS2NS(q->vars.qdelay)) /

WARNING: Missing a blank line after declarations
+	struct sk_buff *skb;
+	skb = qdisc_dequeue_head(sch);

WARNING: Missing a blank line after declarations
+	struct pie_sched_data *q = qdisc_priv(sch);
+	qdisc_reset_queue(sch);

WARNING: Missing a blank line after declarations
+	struct pie_sched_data *q = qdisc_priv(sch);
+	q->params.tupdate = 0;

Signed-off-by: Leslie Monis <lesliemonis@gmail.com>
---
 net/sched/sch_pie.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 18d30bb..d142937 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -110,8 +110,8 @@ static bool drop_early(struct Qdisc *sch, u32 packet_size)
 	/* If current delay is less than half of target, and
 	 * if drop prob is low already, disable early_drop
 	 */
-	if ((q->vars.qdelay < q->params.target / 2)
-	    && (q->vars.prob < MAX_PROB / 5))
+	if ((q->vars.qdelay < q->params.target / 2) &&
+	    (q->vars.prob < MAX_PROB / 5))
 		return false;
 
 	/* If we have fewer than 2 mtu-sized packets, disable drop_early,
@@ -209,7 +209,8 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* tupdate is in jiffies */
 	if (tb[TCA_PIE_TUPDATE])
-		q->params.tupdate = usecs_to_jiffies(nla_get_u32(tb[TCA_PIE_TUPDATE]));
+		q->params.tupdate =
+			usecs_to_jiffies(nla_get_u32(tb[TCA_PIE_TUPDATE]));
 
 	if (tb[TCA_PIE_LIMIT]) {
 		u32 limit = nla_get_u32(tb[TCA_PIE_LIMIT]);
@@ -247,7 +248,6 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 
 static void pie_process_dequeue(struct Qdisc *sch, struct sk_buff *skb)
 {
-
 	struct pie_sched_data *q = qdisc_priv(sch);
 	int qlen = sch->qstats.backlog;	/* current queue size in bytes */
 
@@ -294,9 +294,9 @@ static void pie_process_dequeue(struct Qdisc *sch, struct sk_buff *skb)
 			 * dq_count to 0 to re-enter the if block when the next
 			 * packet is dequeued
 			 */
-			if (qlen < QUEUE_THRESHOLD)
+			if (qlen < QUEUE_THRESHOLD) {
 				q->vars.dq_count = DQCOUNT_INVALID;
-			else {
+			} else {
 				q->vars.dq_count = 0;
 				q->vars.dq_tstamp = psched_get_time();
 			}
@@ -370,7 +370,7 @@ static void calculate_probability(struct Qdisc *sch)
 	oldprob = q->vars.prob;
 
 	/* to ensure we increase probability in steps of no more than 2% */
-	if (delta > (s32) (MAX_PROB / (100 / 2)) &&
+	if (delta > (s32)(MAX_PROB / (100 / 2)) &&
 	    q->vars.prob >= MAX_PROB / 10)
 		delta = (MAX_PROB / 100) * 2;
 
@@ -405,7 +405,7 @@ static void calculate_probability(struct Qdisc *sch)
 	 * delay is 0 for 2 consecutive Tupdate periods.
 	 */
 
-	if ((qdelay == 0) && (qdelay_old == 0) && update_prob)
+	if (qdelay == 0 && qdelay_old == 0 && update_prob)
 		q->vars.prob = (q->vars.prob * 98) / 100;
 
 	q->vars.qdelay = qdelay;
@@ -419,8 +419,8 @@ static void calculate_probability(struct Qdisc *sch)
 	 */
 	if ((q->vars.qdelay < q->params.target / 2) &&
 	    (q->vars.qdelay_old < q->params.target / 2) &&
-	    (q->vars.prob == 0) &&
-	    (q->vars.avg_dq_rate > 0))
+	    q->vars.prob == 0 &&
+	    q->vars.avg_dq_rate > 0)
 		pie_vars_init(&q->vars);
 }
 
@@ -437,7 +437,6 @@ static void pie_timer(struct timer_list *t)
 	if (q->params.tupdate)
 		mod_timer(&q->adapt_timer, jiffies + q->params.tupdate);
 	spin_unlock(root_lock);
-
 }
 
 static int pie_init(struct Qdisc *sch, struct nlattr *opt,
@@ -469,15 +468,16 @@ static int pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct nlattr *opts;
 
 	opts = nla_nest_start(skb, TCA_OPTIONS);
-	if (opts == NULL)
+	if (!opts)
 		goto nla_put_failure;
 
 	/* convert target from pschedtime to us */
 	if (nla_put_u32(skb, TCA_PIE_TARGET,
-			((u32) PSCHED_TICKS2NS(q->params.target)) /
+			((u32)PSCHED_TICKS2NS(q->params.target)) /
 			NSEC_PER_USEC) ||
 	    nla_put_u32(skb, TCA_PIE_LIMIT, sch->limit) ||
-	    nla_put_u32(skb, TCA_PIE_TUPDATE, jiffies_to_usecs(q->params.tupdate)) ||
+	    nla_put_u32(skb, TCA_PIE_TUPDATE,
+			jiffies_to_usecs(q->params.tupdate)) ||
 	    nla_put_u32(skb, TCA_PIE_ALPHA, q->params.alpha) ||
 	    nla_put_u32(skb, TCA_PIE_BETA, q->params.beta) ||
 	    nla_put_u32(skb, TCA_PIE_ECN, q->params.ecn) ||
@@ -489,7 +489,6 @@ static int pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 nla_put_failure:
 	nla_nest_cancel(skb, opts);
 	return -1;
-
 }
 
 static int pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
@@ -497,7 +496,7 @@ static int pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	struct pie_sched_data *q = qdisc_priv(sch);
 	struct tc_pie_xstats st = {
 		.prob		= q->vars.prob,
-		.delay		= ((u32) PSCHED_TICKS2NS(q->vars.qdelay)) /
+		.delay		= ((u32)PSCHED_TICKS2NS(q->vars.qdelay)) /
 				   NSEC_PER_USEC,
 		/* unscale and return dq_rate in bytes per sec */
 		.avg_dq_rate	= q->vars.avg_dq_rate *
@@ -514,8 +513,7 @@ static int pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 
 static struct sk_buff *pie_qdisc_dequeue(struct Qdisc *sch)
 {
-	struct sk_buff *skb;
-	skb = qdisc_dequeue_head(sch);
+	struct sk_buff *skb = qdisc_dequeue_head(sch);
 
 	if (!skb)
 		return NULL;
@@ -527,6 +525,7 @@ static struct sk_buff *pie_qdisc_dequeue(struct Qdisc *sch)
 static void pie_reset(struct Qdisc *sch)
 {
 	struct pie_sched_data *q = qdisc_priv(sch);
+
 	qdisc_reset_queue(sch);
 	pie_vars_init(&q->vars);
 }
@@ -534,6 +533,7 @@ static void pie_reset(struct Qdisc *sch)
 static void pie_destroy(struct Qdisc *sch)
 {
 	struct pie_sched_data *q = qdisc_priv(sch);
+
 	q->params.tupdate = 0;
 	del_timer_sync(&q->adapt_timer);
 }
-- 
2.7.4

