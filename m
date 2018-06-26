Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F20DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1906D214F2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QIml3ZDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1906D214F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeFZQYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:24:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35257 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeFZQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:24:42 -0400
Received: by mail-wr0-f193.google.com with SMTP id c13-v6so7925720wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=6sT9z6N8VNAXX4BMh34IMHS9WnCtCMfj+JQSdr7ubJU=;
        b=QIml3ZDCEAqdAlxST54zML93vcvn6NKvIND8KSbMiAZBvbhMTD6P9bzc6Z3GIy6vmG
         2pVPEeDzGl/nFZaKXXZhXfMMR0kpdsUwtdH6sY6oB6UqJF0TJMhdr3YPLhY5wk+7y/dN
         HToM3TyM2BqYLI+3eLzEy66YNfbkZnHccE8H/Pwbi6KTJMCsmDlylZGJCida1cyDfHUM
         pkaz0hpUrJYM5vxKlP05keOmmoEsTg8fe2+dq3fTztbSve8Wz7y6Hr0ec0G/XrAvWmRS
         sYknQ861ZRp6GyjiLnofT/ghgBjOqZqmuvbQel0WlF9v5nDwBuLMBRHoefuy4D25elKi
         BSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6sT9z6N8VNAXX4BMh34IMHS9WnCtCMfj+JQSdr7ubJU=;
        b=coJKNwz2bYKCPEPmR2nz7IOX4FhMgv2GgsMYxwbCxmzAuUi59gY3XVkx5ohHoL6CGi
         IjlPa3qWxlz0OIIvaVNgQPyx+HJFk8X7HdqyBpDlIQQoViEyQ7XJBEkOWH60hDSSJ3R1
         EHSSVSSOiQ1NOJp0uUNFJxSTcgoOnXkz+YOUTommXkV1yXEkNozIEQP3zBQ1AMmMu6Vh
         QWm2tmM8ypF+D173VmmY9DG1Iy1jDNyCjO8xMofQ1m68lH/Q+3PGSfHULQaAoUB4VM13
         zy2P5ITI9+hgkpCTuOrsc3iyMwW/82/YypMjXVZFkDJsCHsV9RWRTlqjAN7CLSsoAV0N
         OfDA==
X-Gm-Message-State: APt69E3LrLoFOiU9gWchBHnI1cDCHvRtq3G364F7MEdyu5NSl/2Mq1tn
        ZcjGUAop/QNJuUAB4d4Q8v/YNjeAjhI=
X-Google-Smtp-Source: AAOMgpe/EupOIgFT510OScQeTJaRyKdP244ttX+vlayIc7VG1JPFc75Gkg3i5R9yKle0ZyWfK3XInA==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr2144550wrc.40.1530030280342;
        Tue, 26 Jun 2018 09:24:40 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2731860wrr.47.2018.06.26.09.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 09:24:39 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Arnd Bergmann <arnd@arndb.de>,
        David Airlie <airlied@linux.ie>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCHv2] lib/ratelimit: Lockless ratelimiting
Date:   Tue, 26 Jun 2018 17:24:38 +0100
Message-Id: <20180626162438.16306-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ratelimit_state is protected with spin_lock. If the .lock is
taken at the moment of ___ratelimit() call, the message is suppressed to
make ratelimiting robust.

That results in the following issue issue:
      CPU0                          CPU1
------------------           ------------------
printk_ratelimit()           printk_ratelimit()
        |                             |
  try_spin_lock()              try_spin_lock()
        |                             |
time_is_before_jiffies()          return 0; // suppress

So, concurrent call of ___ratelimit() results in silently suppressing
one of the messages, regardless if the limit is reached or not.
And rc->missed is not increased in such case so the issue is covered
from user.

Convert ratelimiting to use atomic counters and drop spin_lock.

Note: That might be unexpected, but with the first interval of messages
storm one can print up to burst*2 messages. So, it doesn't guarantee
that in *any* interval amount of messages is lesser than burst.
But, that differs lightly from previous behavior where one can start
burst=5 interval and print 4 messages on the last milliseconds of
interval + new 5 messages from new interval (totally 9 messages in
lesser than interval value):

   msg0              msg1-msg4 msg0-msg4
    |                     |       |
    |                     |       |
 |--o---------------------o-|-----o--------------------|--> (t)
                          <------->
                       Lesser than burst

Dropped dev/random patch since v1 version:
lkml.kernel.org/r/<20180510125211.12583-1-dima@arista.com>

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/char/random.c            | 16 ++++-------
 drivers/gpu/drm/i915/i915_perf.c |  4 +--
 include/linux/ratelimit.h        | 24 +++++++++-------
 lib/ratelimit.c                  | 59 +++++++++++++++++++---------------------
 4 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a8fb0020ba5c..ba67ea0dc568 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -936,24 +936,20 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 	crng->init_time = jiffies;
 	spin_unlock_irqrestore(&crng->lock, flags);
 	if (crng == &primary_crng && crng_init < 2) {
+		int unseeded_miss, urandom_miss;
+
 		invalidate_batched_entropy();
 		numa_crng_init();
 		crng_init = 2;
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: crng init done\n");
-		if (unseeded_warning.missed) {
+		if ((unseeded_miss = atomic_xchg(&unseeded_warning.missed, 0)))
 			pr_notice("random: %d get_random_xx warning(s) missed "
-				  "due to ratelimiting\n",
-				  unseeded_warning.missed);
-			unseeded_warning.missed = 0;
-		}
-		if (urandom_warning.missed) {
+				  "due to ratelimiting\n", unseeded_miss);
+		if ((urandom_miss = atomic_xchg(&urandom_warning.missed, 0)))
 			pr_notice("random: %d urandom warning(s) missed "
-				  "due to ratelimiting\n",
-				  urandom_warning.missed);
-			urandom_warning.missed = 0;
-		}
+				  "due to ratelimiting\n", urandom_miss);
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 019bd2d073ad..75f6203f6e8e 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -1317,9 +1317,9 @@ static void i915_oa_stream_destroy(struct i915_perf_stream *stream)
 
 	put_oa_config(dev_priv, stream->oa_config);
 
-	if (dev_priv->perf.oa.spurious_report_rs.missed) {
+	if (atomic_read(&dev_priv->perf.oa.spurious_report_rs.missed)) {
 		DRM_NOTE("%d spurious OA report notices suppressed due to ratelimiting\n",
-			 dev_priv->perf.oa.spurious_report_rs.missed);
+			 atomic_read(&dev_priv->perf.oa.spurious_report_rs.missed));
 	}
 }
 
diff --git a/include/linux/ratelimit.h b/include/linux/ratelimit.h
index 8ddf79e9207a..7b5914e12d5b 100644
--- a/include/linux/ratelimit.h
+++ b/include/linux/ratelimit.h
@@ -4,7 +4,6 @@
 
 #include <linux/param.h>
 #include <linux/sched.h>
-#include <linux/spinlock.h>
 
 #define DEFAULT_RATELIMIT_INTERVAL	(5 * HZ)
 #define DEFAULT_RATELIMIT_BURST		10
@@ -13,20 +12,20 @@
 #define RATELIMIT_MSG_ON_RELEASE	BIT(0)
 
 struct ratelimit_state {
-	raw_spinlock_t	lock;		/* protect the state */
+	atomic_t	printed;
+	atomic_t	missed;
 
 	int		interval;
 	int		burst;
-	int		printed;
-	int		missed;
 	unsigned long	begin;
 	unsigned long	flags;
 };
 
 #define RATELIMIT_STATE_INIT(name, interval_init, burst_init) {		\
-		.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),	\
 		.interval	= interval_init,			\
 		.burst		= burst_init,				\
+		.printed	= ATOMIC_INIT(0),			\
+		.missed		= ATOMIC_INIT(0),			\
 	}
 
 #define RATELIMIT_STATE_INIT_DISABLED					\
@@ -42,9 +41,10 @@ static inline void ratelimit_state_init(struct ratelimit_state *rs,
 {
 	memset(rs, 0, sizeof(*rs));
 
-	raw_spin_lock_init(&rs->lock);
 	rs->interval	= interval;
 	rs->burst	= burst;
+	atomic_set(&rs->printed, 0);
+	atomic_set(&rs->missed, 0);
 }
 
 static inline void ratelimit_default_init(struct ratelimit_state *rs)
@@ -53,16 +53,20 @@ static inline void ratelimit_default_init(struct ratelimit_state *rs)
 					DEFAULT_RATELIMIT_BURST);
 }
 
+/*
+ * Keeping it simple: not reenterable and not safe for concurrent
+ * ___ratelimit() call as used only by devkmsg_release().
+ */
 static inline void ratelimit_state_exit(struct ratelimit_state *rs)
 {
+	int missed;
+
 	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE))
 		return;
 
-	if (rs->missed) {
+	if ((missed = atomic_xchg(&rs->missed, 0)))
 		pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
-			current->comm, rs->missed);
-		rs->missed = 0;
-	}
+			current->comm, missed);
 }
 
 static inline void
diff --git a/lib/ratelimit.c b/lib/ratelimit.c
index d01f47135239..c99305e9239f 100644
--- a/lib/ratelimit.c
+++ b/lib/ratelimit.c
@@ -13,6 +13,18 @@
 #include <linux/jiffies.h>
 #include <linux/export.h>
 
+static void ratelimit_end_interval(struct ratelimit_state *rs, const char *func)
+{
+	rs->begin = jiffies;
+
+	if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
+		unsigned missed = (unsigned)atomic_xchg(&rs->missed, 0);
+
+		if (missed)
+			pr_warn("%s: %u callbacks suppressed\n", func, missed);
+	}
+}
+
 /*
  * __ratelimit - rate limiting
  * @rs: ratelimit_state data
@@ -27,45 +39,30 @@
  */
 int ___ratelimit(struct ratelimit_state *rs, const char *func)
 {
-	unsigned long flags;
-	int ret;
-
 	if (!rs->interval)
 		return 1;
 
-	/*
-	 * If we contend on this state's lock then almost
-	 * by definition we are too busy to print a message,
-	 * in addition to the one that will be printed by
-	 * the entity that is holding the lock already:
-	 */
-	if (!raw_spin_trylock_irqsave(&rs->lock, flags))
+	if (unlikely(!rs->burst)) {
+		atomic_add_unless(&rs->missed, 1, -1);
+		if (time_is_before_jiffies(rs->begin + rs->interval))
+			ratelimit_end_interval(rs, func);
+
 		return 0;
+	}
 
-	if (!rs->begin)
-		rs->begin = jiffies;
+	if (atomic_add_unless(&rs->printed, 1, rs->burst))
+		return 1;
 
 	if (time_is_before_jiffies(rs->begin + rs->interval)) {
-		if (rs->missed) {
-			if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
-				printk_deferred(KERN_WARNING
-						"%s: %d callbacks suppressed\n",
-						func, rs->missed);
-				rs->missed = 0;
-			}
-		}
-		rs->begin   = jiffies;
-		rs->printed = 0;
-	}
-	if (rs->burst && rs->burst > rs->printed) {
-		rs->printed++;
-		ret = 1;
-	} else {
-		rs->missed++;
-		ret = 0;
+		if (atomic_cmpxchg(&rs->printed, rs->burst, 0))
+			ratelimit_end_interval(rs, func);
 	}
-	raw_spin_unlock_irqrestore(&rs->lock, flags);
 
-	return ret;
+	if (atomic_add_unless(&rs->printed, 1, rs->burst))
+		return 1;
+
+	atomic_add_unless(&rs->missed, 1, -1);
+
+	return 0;
 }
 EXPORT_SYMBOL(___ratelimit);
-- 
2.13.6

