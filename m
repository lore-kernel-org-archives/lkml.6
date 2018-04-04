Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3640711-1522826724-2-11243882949662797267
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522826724; b=NQqpFw0u0cMshnBHDyjYZnEscHeNIn+WrlImV7eu7pNyLJjlb6
    hjXqgJxqb2j5I6tDnLF+vaiwsrNefpu/eAujmFCB13eDoUKx1DltD2tVPjDwJ7zP
    Y74rYLLvkmi+Z2ZbrZPFY4zVdSs9TA00ZAfSCnw0vSYUDyTn5rvZ4PGsVOdleHcV
    GBE1Gt/4oJRWU/hf9ppdcjbyvlppNvli3KrYPu1r1ed8N/3XK3IMp8239Mi0KG8e
    jTonNdnLJw+ntkXSwPvNmtoEErG8D8YiJDAk9NotJ4TTZI5rA4j4cRA8VoB+s9Fb
    ZP2HqwyAMYtGXkOl/2/nwOpRKpDhNAQgRHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1522826724; bh=
    +vg8cwbYmh1RqsitbN8WJBKdIi5L3/PApSMwvZW8p+o=; b=eLG86oLTJXUAAY4J
    dsdl78b9uAxxOvmwHtEBqve81BbJDDV1LrOl3+HMx+uvU4Ef2pnZqXHn99yk/Trd
    OYEqEZtCN/2YM1f68uCnFZH+45ZEoWQG09o8EfzFpSaSxsx/goqBSIk4gHQXnwrl
    jhu9grAjRXimIpTGv2x7QsPJIUP/mLywpHW089xJFBhIHuGF5KGycT8WgoEmqV1T
    tB54BZrhq8T2+Obt2i0JOmuYh2EdDsWDVf6SaMVBE62Pc92q2xdAMmoWWoS6jZ31
    TwRbVgUWndBX8ax8mq3l2jiBMSVB3OLpQzD29omjzooncDb2NGBzkI+0Yv1XGXpI
    LkZUHw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB60Be7FU8INku/86+++Ms/5hQBgfwT57+ctJGAZbIr9qq72OAKkWFJNGZgY33lYtj9GGx/387hTsjZZcRN9/t+gcFtRMyiqfbEwb6OIydsZGDCFDfm6
    +nqOucS0zyglZ4UP4sEM/1kWMVYvBYOlyVhg6vVTs7fgyjlhLI9sWW9OF7V/QOGmmFotdNJa2u5lsDI++scXaOsDEKnluYaN6M+2H/ICkR9f3JFD7L7PTztv
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=DqzIuXWK0c9Jp5pHqTIA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbeDDHZV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 03:25:21 -0400
Received: from mail.monom.org ([188.138.9.77]:49774 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbeDDHZU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 4 Apr 2018 03:25:20 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail.monom.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
From: Daniel Wagner <wagi@monom.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable@vger.kernel.org,
        rt@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT 2/7] timer: Invoke timer_start_debug() where it makes sense
Date: Wed,  4 Apr 2018 09:16:47 +0200
Message-Id: <20180404071652.24196-3-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404071652.24196-1-wagi@monom.org>
References: <20180404071652.24196-1-wagi@monom.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

The timer start debug function is called before the proper timer base is
set. As a consequence the trace data contains the stale CPU and flags
values.

Call the debug function after setting the new base and flags.

Fixes: 500462a9de65 ("timers: Switch to a non-cascading wheel")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: rt@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a8246d79cb5a..6b322aea1c46 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -838,8 +838,6 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 	if (!ret && pending_only)
 		goto out_unlock;
 
-	debug_activate(timer, expires);
-
 	new_base = get_target_base(base, pinned);
 
 	if (base != new_base) {
@@ -854,6 +852,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 			base = switch_timer_base(timer, base, new_base);
 	}
 
+	debug_activate(timer, expires);
+
 	timer->expires = expires;
 	internal_add_timer(base, timer);
 
-- 
2.14.3
