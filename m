Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4018576-1525225510-2-11300751279161480913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525225509; b=m6zpB/elQUhMJOaAPUTQSvHJb9Y6FFNORJLLndSuFJksNRIlo0
    3VJ4V4Ltw3JPFI+zeVjsdw0gmLiJ3FqAtHyOxU6nWiprmKwk75ZRfrKXUrT1/5rO
    Y7q1fjeWN4GOe/6B+q8hPqlPYcKH6N6pUFkxT8A3KVHsgKaBG/lzSNdisCNWvlqj
    0XlnifNwCUUq6I2OALzFQZDzxW46wTtzw5XyFcHtBjJ7/xO9va2LF2CG/vTCZ7zs
    wdpqi5VvxBG6kEKlq3XsXaPUOF3FJRANKEsbuU/gNAodmoyxLgwc8YbeE76gUyUU
    tQK+ZhSxdcXyJq6hgPLMzKkk/crLywY3ghwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525225509; bh=2sO3hbGpQ7mQfCj/WRq1JZdI+DMM7r
    k2nUvsy/pNOmE=; b=niAMkl5cQLs6FeZiJtXu/3FNClmIVXeV9OC31eJGQaTShz
    YBdTr3szKyuDrZfP1wrj/erS9gG33/62z7PPLWLGDsT/plnncjPLPeCSRc8mRhkT
    gvZHrPaeKIcgVP5J738zx4u7kOcL+Xgju472LgTWNUcBQ5AH08ksuHPxmAaBNhv8
    ChfF14xdtitvGqjOi8qEHhwg5p4CbcJyUeef0N6N/tnZ4zDIu7AygIPlVA8z9I/x
    4tc5PMvMsyC5NzRH5672TvgfG2nz8FM5Rsu+nPi0yPsj0E8rPXyD1790bgfhcq8B
    JTL3AH1/bU0E4ELLdqfCMlhyxvMRlrdPR5pcgEjw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=e5+UY0zX x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=gynH9t4G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=e5+UY0zX x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=gynH9t4G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJmNv9QMDInBNBjyKdaxSJ0NeoCCydR3zXGA+IXTwfZW3mHTCYRugr2xtsbOuVIMlZJvHVvmQmBH58d5NzoFoTFvLovJt5bL4fQfBHVU9OccDRYTKJWl
    2ixLtF8BrkVi53A9EQXjLKxi4hwZ3j0GS9A4GsvVvrbPNE6Zgi49wGO9ddmkl5NQziB5XQc30WRd4QsFR4Dy8WAB91gD6rvJmE1Hzg8JMD4ZtfVnDfvErzVH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=meVymXHHAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=7d_E57ReAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
    a=n8i27M1mAAAA:8 a=1XWaLZrsAAAA:8 a=avd3DLw0iyMjPW8tV1oA:9
    a=2JgSa4NbpEOStq-L5dxp:22 a=1CNFftbPRP8L7MoqJWF3:22 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeEBBpI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 21:45:08 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41002 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeEBBpH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 21:45:07 -0400
X-Google-Smtp-Source: AB8JxZrsU7VLh7ZOO6O3iEqFhHwH+RPuLXJXJuPboZuSmvhiUUN5703AS61qGSs1p3iNe9UZtQbFkg==
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com,
        stable@vger.kernel.org
Subject: [PATCH] softirq: reorder trace_softirqs_on to prevent lockdep splat
Date: Tue,  1 May 2018 18:44:39 -0700
Message-Id: <20180502014439.87828-1-joelaf@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'm able to reproduce a lockdep splat with config options:
CONFIG_PROVE_LOCKING=y,
CONFIG_DEBUG_LOCK_ALLOC=y and
CONFIG_PREEMPTIRQ_EVENTS=y

$ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
---
[   26.112609] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
[   26.112636] WARNING: CPU: 0 PID: 118 at kernel/locking/lockdep.c:3854
[...]
[   26.144229] Call Trace:
[   26.144926]  <IRQ>
[   26.145506]  lock_acquire+0x55/0x1b0
[   26.146499]  ? __do_softirq+0x46f/0x4d9
[   26.147571]  ? __do_softirq+0x46f/0x4d9
[   26.148646]  trace_preempt_on+0x8f/0x240
[   26.149744]  ? trace_preempt_on+0x4d/0x240
[   26.150862]  ? __do_softirq+0x46f/0x4d9
[   26.151930]  preempt_count_sub+0x18a/0x1a0
[   26.152985]  __do_softirq+0x46f/0x4d9
[   26.153937]  irq_exit+0x68/0xe0
[   26.154755]  smp_apic_timer_interrupt+0x271/0x280
[   26.156056]  apic_timer_interrupt+0xf/0x20
[   26.157105]  </IRQ>

The issue was this:

preempt_count = 1 << SOFTIRQ_SHIFT

	__local_bh_enable(cnt = 1 << SOFTIRQ_SHIFT) {
		if (softirq_count() == (cnt && SOFTIRQ_MASK)) {
			trace_softirqs_on() {
				current->softirqs_enabled = 1;
			}
		}
		preempt_count_sub(cnt) {
			trace_preempt_on() {
				tracepoint() {
					rcu_read_lock_sched() {
						// jumps into lockdep

Where preempt_count still has softirqs disabled, but
current->softirqs_enabled is true, and we get a splat.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Fenguang Wu <fengguang.wu@intel.com>
Cc: Baohong Liu <baohong.liu@intel.com>
Cc: Vedang Patel <vedang.patel@intel.com>
Cc: kernel-team@android.com
Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: d59158162e032 ("tracing: Add support for preempt and irq enable/disable events")
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 kernel/softirq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 24d243ef8e71..47e2f61938c0 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
 {
 	lockdep_assert_irqs_disabled();
 
+	if (preempt_count() == cnt)
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_on(_RET_IP_);
-	preempt_count_sub(cnt);
+
+	__preempt_count_sub(cnt);
 }
 
 /*
-- 
2.17.0.441.gb46fe60e1d-goog
