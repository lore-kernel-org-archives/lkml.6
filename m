Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1005518-1527125067-2-3745125227741335978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527125067; b=Xy9Af+zmJGjiJfus9jBDXQFRSxWOdWo+idmgJAjriR0I36a9X2
    esx8if1DXtNazcFZCw7xM4gxXKSuVSqFbUHx8NvTfUdJVvCdOIMz5Tv4t7Bytkyb
    Uk3GIvwiaEUYgo1AayFyMDySDGgtt2L7MCef3bTYVKIzqppXDj4UOprG7t5ambQ+
    XlZX3RPSk2FtHBNgEGqS5/N4z2jY5JMObyAdVPiMlUahb2+WnZJdIenHHsF8apEr
    RxEDXf6bLgkVOQNzUHhusjzzi7uizzJeYkO5xdokZjjC0wTZU7S6xu1n0oSQLWzP
    N9SkgGs1K0YMZ/+2/dHngQ4ahb68iNtEaOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527125067; bh=
    AEGV6heGcjUpaeyw6p8+XTTxa7HsHy0/1gDIOZxxLL4=; b=VolAdiE25/+EQLxH
    8eJhfUf5HbzIeHSm6GBQhk179jrU6p2rT0d1HUdC2kxkLHTMJVBNXiUBMHLFoR0v
    UZKRSvV8w8hEwyd+NacrucYCHtvZo9JNeuGp86bjeAbt84bqdXHfr5AcNVOe2s5h
    4VGypQyljvp/inzm2S5j/4feGlqRXYVANLv9ITFejqVf07sofvrDfRAAp1J8/86W
    tCANlKX7TppSdRjbOXFYM+XbSWm+X0PG7BhNDBb01TNZ/L2FwvEotJZpP0Y9B84R
    WMmByxnjzRbqtuxTfz2XiJYDqz+ai6SF25PxSKqfZYG6Qgdc31xjnBadnUWNaZ3/
    4Lyc+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=Kj3Kongc x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=V+96BrrC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=Kj3Kongc x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=V+96BrrC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJIoLkqiPzdm/Uj8uZ+GOBAXRlzVrz6SlHE+wRPi9o3ImNyBPbpoRnKRArl7VsjCmSdZ4vfDkwwxCpN6lZ/8At6q/rUzniOuwb5z9GDEAteeSgl/HMOt
    vlgpdxz3jHYzVNHodDDN30uIpLnONqOtOGtBgBqnFCq8xhcmtN5g+tAlbL5cOM/OYmtLnw2WlPeRXCooaEqrZMr+j7gOpGknUyDsxGnLlDc7Urf3XiKHxcf1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=qqdB56dbAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=P4ErRIUFX53d52tWOcYA:9
    a=ccaIO3UgQCpleZvgly2v:22 a=AjGcO6oz07-iQ99wixmX:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935169AbeEXBYY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 21:24:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35002 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935330AbeEXBW2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 May 2018 21:22:28 -0400
X-Google-Smtp-Source: AB8JxZr6+Tssw51LzANFsnZX56Z829KACSQrKctUcG/E6WbE/EHk0tarOAuUyY2EHS8Mf3+foXTxJg==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        stable@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v7 1/8] softirq: reorder trace_softirqs_on to prevent lockdep splat
Date: Wed, 23 May 2018 18:21:50 -0700
Message-Id: <20180524012157.181277-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180524012157.181277-1-joel@joelfernandes.org>
References: <20180524012157.181277-1-joel@joelfernandes.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

I'm able to reproduce a lockdep splat with config options:
CONFIG_PROVE_LOCKING=y,
CONFIG_DEBUG_LOCK_ALLOC=y and
CONFIG_PREEMPTIRQ_EVENTS=y

$ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable

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

Cc: stable@vger.kernel.org
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: d59158162e032 ("tracing: Add support for preempt and irq enable/disable events")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/softirq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 177de3640c78..8a040bcaa033 100644
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
