Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519833710-2-1270610701843227775
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833710; b=N657YT2g66/M36stQp2skgNnhRw9ZWtysAQDyATCayNbtI7
    lkgjUn+KFwwNtDF9FasvRw7DdySifav/BKg/fZgJLZ7UCD9+UwfDf4PXrMP3LKGu
    YFzOW7UkRkZz8W8ZbMAN3hZuglZ37CUFp5WmfcUjIG8Np4UACyyRs/C0FENJiwjC
    E2/7dG5RH6ay9a2HXg1sF0XMLyxCQrBf6HS8NcDfT7Kj/y8OmWymAPu4GaCv3aaB
    iJLvkjLGTkY2MhGDhMqhlrSpYT3Ywiekb5G7uYf08d+yo7NTYLknCqwYZEaaN23e
    DP3lykjrNKYf3UKI3qDXZ0ByLK0xX4c2JXGZxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833710; bh=C1bGcVnqo6iOqjqEQjN
    neaCpl5eSwxp0zOFVMNK1fq4=; b=cckSTZpFFt98caMdt1si1xTubPP8xTxyHDT
    twq/qQao2Yff7rEJ4YsJhuenjp5Vd2qG1byMmvIMkxlIcLQh+nBXctz5RHIIydf8
    NiOf+aG3CWUlrwKIToUkRjSmbLpp5Gjw3evopWX373CkFAvCAMv6OakIsMcszkGG
    V6/8XWVBjNkO46RHDrEqO+xrsSugxie9UIBzMvSQ7imTXBsCi+0DAPW7Ntbl4Inm
    ddwqy19eN+N3SiOuM/MNcd8FgYih3xe3i9C1hy+qqU86cBItWqsc19tlOxcMGPmT
    lPT7LYHsoPALVnsXZZpJdBVzeJPzRrsGWbVAAbyCLzEMXrPeCiQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932470AbeB1QAq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:00:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34681 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932458AbeB1QAn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Sebastian Siewior" <bigeasy@linutronix.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Sebastian Siewior" <bigeasy@linutronix.d>,
        "Paul McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.117173069@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 147/254] nohz: Prevent a timer interrupt storm in
 tick_nohz_stop_sched_tick()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 5d62c183f9e9df1deeea0906d099a94e8a43047a upstream.

The conditions in irq_exit() to invoke tick_nohz_irq_exit() which
subsequently invokes tick_nohz_stop_sched_tick() are:

  if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu))

If need_resched() is not set, but a timer softirq is pending then this is
an indication that the softirq code punted and delegated the execution to
softirqd. need_resched() is not true because the current interrupted task
takes precedence over softirqd.

Invoking tick_nohz_irq_exit() in this case can cause an endless loop of
timer interrupts because the timer wheel contains an expired timer, but
softirqs are not yet executed. So it returns an immediate expiry request,
which causes the timer to fire immediately again. Lather, rinse and
repeat....

Prevent that by adding a check for a pending timer soft interrupt to the
conditions in tick_nohz_stop_sched_tick() which avoid calling
get_next_timer_interrupt(). That keeps the tick sched timer on the tick and
prevents a repetitive programming of an already expired timer.

Reported-by: Sebastian Siewior <bigeasy@linutronix.d>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1712272156050.2431@nanos
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/time/tick-sched.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -527,6 +527,11 @@ u64 get_cpu_iowait_time_us(int cpu, u64
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
+static inline bool local_timer_softirq_pending(void)
+{
+	return local_softirq_pending() & TIMER_SOFTIRQ;
+}
+
 static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 					 ktime_t now, int cpu)
 {
@@ -545,8 +550,18 @@ static ktime_t tick_nohz_stop_sched_tick
 		last_jiffies = jiffies;
 	} while (read_seqretry(&jiffies_lock, seq));
 
-	if (rcu_needs_cpu(cpu, &rcu_delta_jiffies) ||
-	    arch_needs_cpu(cpu) || irq_work_needs_cpu()) {
+	/*
+	 * Keep the periodic tick, when RCU, architecture or irq_work
+	 * requests it.
+	 * Aside of that check whether the local timer softirq is
+	 * pending. If so its a bad idea to call get_next_timer_interrupt()
+	 * because there is an already expired timer, so it will request
+	 * immeditate expiry, which rearms the hardware timer with a
+	 * minimal delta which brings us back to this place
+	 * immediately. Lather, rinse and repeat...
+	 */
+	if (rcu_needs_cpu(cpu, &rcu_delta_jiffies) || arch_needs_cpu(cpu) ||
+	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
 		next_jiffies = last_jiffies + 1;
 		delta_jiffies = 1;
 	} else {
