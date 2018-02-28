Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519836981-2-1202439737982160274
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
    t=1519836980; b=hjfbHeVvLq9Kr9cAMIRos2nqJvGXB782eHArYofiIvt1gWf
    mbGSRL6r0m3yPBTCoqkrviVmsfB1bt+FQ70QhB+8FbF59kKu9V76YXfFHH/9MF4k
    QUZylaoBXaunmOIVfJB4JLNmvsebNaUxKtwuzy1/GoHov2l7lD4vje9h0KnnkawK
    qwbQgZlC0+ioik0hW1q50kLM3EPBez+PRleo9y5ZAylLawrcbzYQfCz8VDUc8gvN
    TXIvFRBD6VWbBFfy38CqkusrmfmKclvi1aag6ofBSmUAqfjT5uNQxEScByjnLEYn
    zi8eEwNKudIQ0wRSXT/pvZ67vZIQmGEkZVnxNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836980; bh=VaRdzESCjhN9HeEjEfe
    bh86U1T/j2Jn3AhN7vgNSaxs=; b=h64eYc37Jl80L2VS3yZqtKqp+YD6MOrQyEA
    xgzQWZu6NgdLOgmcDZuVNO5D6PsByRrHMzCkUXVmpcpKdrgAOIpJC5xWCBYhH/Wl
    vk8b04SBYc0B5fprrZY4fdUxfSIwkNFhtN+OlGWUTQn5EhphS19pn1+VNJDYT9TR
    e9HrhpVQEmQDSlXmtjzqEiDwFQcroD0VEJO8ZA5aycgT3Ap852O8TAtjABKSZag5
    qR4iRwbkRM0HiqvcdVfimmfYJpHq8UL2KHAAT7dEpF9T0Yw8cVZtj8In8+zO0ZqJ
    PAvf+pq9IRtJFuDY966eWPBjDVXpsBHQp7aPXqvFC8u8+MYJGSw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932728AbeB1Q4F (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:56:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34512 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934011AbeB1P5Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:57:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Sebastian Sewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Anna-Maria Gleixner" <anna-maria@linutronix.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.849748282@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 230/254] hrtimer: Reset hrtimer cpu base proper on
 CPU hotplug
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

commit d5421ea43d30701e03cadc56a38854c36a8b4433 upstream.

The hrtimer interrupt code contains a hang detection and mitigation
mechanism, which prevents that a long delayed hrtimer interrupt causes a
continous retriggering of interrupts which prevent the system from making
progress. If a hang is detected then the timer hardware is programmed with
a certain delay into the future and a flag is set in the hrtimer cpu base
which prevents newly enqueued timers from reprogramming the timer hardware
prior to the chosen delay. The subsequent hrtimer interrupt after the delay
clears the flag and resumes normal operation.

If such a hang happens in the last hrtimer interrupt before a CPU is
unplugged then the hang_detected flag is set and stays that way when the
CPU is plugged in again. At that point the timer hardware is not armed and
it cannot be armed because the hang_detected flag is still active, so
nothing clears that flag. As a consequence the CPU does not receive hrtimer
interrupts and no timers expire on that CPU which results in RCU stalls and
other malfunctions.

Clear the flag along with some other less critical members of the hrtimer
cpu base to ensure starting from a clean state when a CPU is plugged in.

Thanks to Paul, Sebastian and Anna-Maria for their help to get down to the
root cause of that hard to reproduce heisenbug. Once understood it's
trivial and certainly justifies a brown paperbag.

Fixes: 41d2e4949377 ("hrtimer: Tune hrtimer_interrupt hang logic")
Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801261447590.2067@nanos
[bwh: Backported to 3.16:
 - There's no next_timer field to reset
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/hrtimer.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -659,6 +659,7 @@ static int hrtimer_reprogram(struct hrti
 static inline void hrtimer_init_hres(struct hrtimer_cpu_base *base)
 {
 	base->expires_next.tv64 = KTIME_MAX;
+	base->hang_detected = 0;
 	base->hres_active = 0;
 }
 
@@ -1680,6 +1681,7 @@ static void init_hrtimers_cpu(int cpu)
 		timerqueue_init_head(&cpu_base->clock_base[i].active);
 	}
 
+	cpu_base->active_bases = 0;
 	hrtimer_init_hres(cpu_base);
 }
 
