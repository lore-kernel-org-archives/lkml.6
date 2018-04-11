Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3190956-1523476468-2-10296253891799391360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476468; b=h7V9Lr16bygHzeZwYK70faYHKGWIC8X03Ad47no69zkWW/YWoX
    PQcTjatr8Jg84i6PISOyAZ5gNP6rbYTpXCxpi8yw2LQTzIbJAJnl1PO1IaHEdxIL
    MptDb6qDcyshTWFQCfKZc5wwM8tRrhoFmiuZ+VItn3nPx6bJG6nV3VV2R38fK6d0
    r/23AC/1iRMR/6+ncDJ6pPqSWP7fmdSG03oCNG8iGYw+IV+EZUR63Prlbgkgbrpa
    Opy26L95q4vXMgY0fdI7ZlmMdVyeUJfLf3LRP4vib5K/NHSaCqg9GVJQw89Pam8c
    9nSYJ3qMEylxAHrqGA4VcPV04y1Ocz+UEGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476468; bh=i8wyh+L+2xHX1S5Nk+lrklmRh3wodq
    OYh045iXyHSF4=; b=b9xXD+CyIzUYssdnCORQMHJxYVcqsg1LqEPsYZew7b0C24
    4/CwEZD8onPp4+yEfDtIYGa/7r88nJaWFSqXod1IxPUQ98P5q81roh29fxTWGaSE
    isH7GSwQ6scqd+/TNeVBbIh2uU/5Ha81VqCd7LBTAXbuYvDRvz3xy9P7Li/FU25z
    +TPTl810glM0h3JX5nTyNgqUT5v12p0XYjJCZuTJVRgdVDpKcTz+MWkdBqTbHeU1
    i2DYDTEKwFJEllTlCFtYYd3uU7ubkvZ/knYXCWfzalYOvTPmi0ScpUIOz//I/sK0
    qWr1SA+moxAN4tAhhzR4RY/mXUQQfKN84ai284Lg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFH+kJiK6VUNWS6SbaXNm25HfTOq9qglxl6845xezWwTtehZFnUCB32inhivOxa9uj++klYGv4N480GbZfSmGQXRJ9Uj/hFHyFfzsGncmXzTMfFVeoTY
    gprEK8IFENAXJQA+yg1ouVX3zY0z2a+KBUWPUJZO8x6RzX5C8kZWhqk7pDBUQjpW78bSsGIcvvi921qtx5fdSpyuY7NM+A377qHvOUOl5xHv5efSDhvamxm7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=meVymXHHAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=1N9BP1AaHhNaR1yAtEAA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756432AbeDKS5e (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:57:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756431AbeDKS5c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:57:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 113/310] cpuhotplug: Link lock stacks for hotplug callbacks
Date: Wed, 11 Apr 2018 20:34:12 +0200
Message-Id: <20180411183627.044868504@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>


[ Upstream commit 49dfe2a6779717d9c18395684ee31bdc98b22e53 ]

The CPU hotplug callbacks are not covered by lockdep versus the cpu hotplug
rwsem.

CPU0						CPU1
cpuhp_setup_state(STATE, startup, teardown);
 cpus_read_lock();
  invoke_callback_on_ap();
    kick_hotplug_thread(ap);
    wait_for_completion();			hotplug_thread_fn()
    						  lock(m);
						  do_stuff();
						  unlock(m);

Lockdep does not know about this dependency and will not trigger on the
following code sequence:

	  lock(m);
	  cpus_read_lock();

Add a lockdep map and connect the initiators lock chain with the hotplug
thread lock chain, so potential deadlocks can be detected.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170524081549.709375845@linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cpu.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -63,6 +63,12 @@ struct cpuhp_cpu_state {
 
 static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state);
 
+#if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
+static struct lock_class_key cpuhp_state_key;
+static struct lockdep_map cpuhp_state_lock_map =
+	STATIC_LOCKDEP_MAP_INIT("cpuhp_state", &cpuhp_state_key);
+#endif
+
 /**
  * cpuhp_step - Hotplug state machine step
  * @name:	Name of the step
@@ -563,6 +569,7 @@ static void cpuhp_thread_fun(unsigned in
 
 	st->should_run = false;
 
+	lock_map_acquire(&cpuhp_state_lock_map);
 	/* Single callback invocation for [un]install ? */
 	if (st->single) {
 		if (st->cb_state < CPUHP_AP_ONLINE) {
@@ -594,6 +601,7 @@ static void cpuhp_thread_fun(unsigned in
 		else if (st->state > st->target)
 			ret = cpuhp_ap_offline(cpu, st);
 	}
+	lock_map_release(&cpuhp_state_lock_map);
 	st->result = ret;
 	complete(&st->done);
 }
@@ -608,6 +616,9 @@ cpuhp_invoke_ap_callback(int cpu, enum c
 	if (!cpu_online(cpu))
 		return 0;
 
+	lock_map_acquire(&cpuhp_state_lock_map);
+	lock_map_release(&cpuhp_state_lock_map);
+
 	/*
 	 * If we are up and running, use the hotplug thread. For early calls
 	 * we invoke the thread function directly.
@@ -651,6 +662,8 @@ static int cpuhp_kick_ap_work(unsigned i
 	enum cpuhp_state state = st->state;
 
 	trace_cpuhp_enter(cpu, st->target, state, cpuhp_kick_ap_work);
+	lock_map_acquire(&cpuhp_state_lock_map);
+	lock_map_release(&cpuhp_state_lock_map);
 	__cpuhp_kick_ap_work(st);
 	wait_for_completion(&st->done);
 	trace_cpuhp_exit(cpu, st->state, state, st->result);
