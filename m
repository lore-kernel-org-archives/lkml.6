Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id C+T5CKGRGVtHMwAAmS7hNA
	; Thu, 07 Jun 2018 20:12:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 04DCC6074D; Thu,  7 Jun 2018 20:12:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLMKtHX7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 818E460452;
	Thu,  7 Jun 2018 20:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 818E460452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeFGUMI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:12:08 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44824 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbeFGUMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:12:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so6813854plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T6Ql7a4X22yghU/QoV02kTO2IcMkBGjr/VWGIhq2epw=;
        b=KLMKtHX7O+KubTFlykJXP35A9BDLyIBQD7AQ7fdTEj80axVNPv1J0HC6eny9qTchE3
         rAfZSeD7WBoW9/75cLOzdOdAQd0XDCJ0vkmAQ1yZZuBAROZL4bc7Vyg4iKEftBRRf5O8
         gaBL43E/34+Y5Xz5NACS2/7DDnc02sc5756s6uJYrZ4QP0tOSyw7os0u97vvnwci4CYt
         ZzIdL0akzQCD3Dveh9G8P30rjBOUmBXJGB08VcP3u7/8VOzZ6Y9XigET9DcJy790Jn3N
         kE45cr9i4MqRuHpXZe4gScO3qm8/aq1kMgBIwFdEbgudb9ILIosS6cHjPQnNrVhw/Wf0
         Iz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T6Ql7a4X22yghU/QoV02kTO2IcMkBGjr/VWGIhq2epw=;
        b=nduVLwdZ9vbKoQLP95w7+94fgqPXVIGP++F3fTQ/4JX4eMvbhZ+GmdRiDoV71HtnYj
         CskVcC16Z/JemNbhc/FsR8whGhqbdjGmCejTX2As9scPXBBsWkRiSnDYGIFT6YbIh75d
         AEaepXBtJr3S/cYGNliSIPt9i/ZrAc+cMvasrCTZ1Kr5ckN1xNiZDW8JZoWJpM/Iy+CB
         fHkJYfOEWPjer0zmNoB3BZBobyrQOb2ml3U67r83mZrIwCwXuDLQW56mZOIDD42xQtnY
         YPfkA2BS83Q2fDe60ipKAOMeM2fifRbrR01nqErAgOt8NyqQG/d0W2zYJ7H6XEbCKIOJ
         DWKg==
X-Gm-Message-State: APt69E0+umNen/h1l+J7261pXNieGnWgLHXOnIo84qiPqShdCwSe+DlG
        UWrWvs8+PoKo16fukq0ubHWVects8o0=
X-Google-Smtp-Source: ADUXVKJww8H/yAPIxwFRokOrz3EVDdNZWKFjPPscYJmW/9aQQldWkwwBnoK/oRZmz8syp4UQ19zhYw==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19-v6mr3397416plo.166.1528402324758;
        Thu, 07 Jun 2018 13:12:04 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id v36-v6sm45540506pgn.34.2018.06.07.13.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:12:03 -0700 (PDT)
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Erick Reyes <erickreyes@google.com>,
        Julia Cartwright <julia@ni.com>,
        Byungchul Park <byungchul.park@lge.com>, stable@vger.kernel.org
Subject: [PATCH RESEND] softirq: reorder trace_softirqs_on to prevent lockdep splat
Date: Thu,  7 Jun 2018 13:11:43 -0700
Message-Id: <20180607201143.247775-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Erick Reyes <erickreyes@google.com>
Cc: Julia Cartwright <julia@ni.com>
Cc: Byungchul Park <byungchul.park@lge.com>
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
2.17.1.1185.g55be947832-goog
