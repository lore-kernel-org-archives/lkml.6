Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519836861-2-15200795850193101396
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
    t=1519836860; b=baBiM4o+9ZhLd1b3KCZtACviWN7QUqM4tmtpKJyOnAXWtu8
    IFbXwO+wWCRp1a154KOW+4BHii68hYVClGuoFtSFv8PlqV15JR6vay3huddA+KSl
    9UaXX6QLz0f7U2r9JSCh1BP7VQ8sMrH45Q9JZUaADJj5C8V6MekR8SsLqsDTLdLR
    Mlicuq5dmsndGNT+nGaBCBb+WzJMHRWTnXVepjX6CU5ouKYWXjWjFgt58+JXJmXb
    X8zjyZ2SfeaeGYy5uSubNU/aOQMQ3RT9VrlvqHi14A3MA9Z0/mEnR+e/38a4WEz6
    ZCWxaJRfKqSUJgfnurvMSy7i6EwrFWAYXhl61PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836860; bh=EKbrfmAzxdEaRTC/8Pf
    tuOn+lhCkGn6P/tlnj0P6acw=; b=iMO1inEnPplr1/mKwLbTEXSVP9wkPn/2Z2n
    JOgBQ57gaP3Q6HoOlhjUVThjssbj7r0vukNfoZxJNjLCjammZBZEsp6TNu/J42fW
    s7Q8o/8QaQdarGM45gEgptY4+IitUD+W6DgfQkmQijd/WfYvy9xkmzX9zl2Rkubk
    68Gfo5nlBYkyloGmNyY27fNXxhqBSkbuJtcLHsfROq5Jz6Q/aE5M+oLGiWg4MCPu
    W5U6i4Bm16EUKATddYDrn6lbKr0jpK/NkFc6CuMYsHlPMA/2lTq1gvz11hdMGfo9
    NF7XSOMT2cv9Ms3O7+iRsWIfsKTo/Yav7Tk2S+DSH7pwlxZLLoA==
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
        id S934186AbeB1P5p (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:57:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34520 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933979AbeB1P5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:57:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.86470448@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 199/254] powerpc: Don't preempt_disable() in
 show_cpuinfo()
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 349524bc0da698ec77f2057cf4a4948eb6349265 upstream.

This causes warnings from cpufreq mutex code. This is also rather
unnecessary and ineffective. If we really want to prevent concurrent
unplug, we could take the unplug read lock but I don't see this being
critical.

Fixes: cd77b5ce208c ("powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo")
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/setup-common.c | 11 -----------
 1 file changed, 11 deletions(-)

--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -216,14 +216,6 @@ static int show_cpuinfo(struct seq_file
 	unsigned short maj;
 	unsigned short min;
 
-	/* We only show online cpus: disable preempt (overzealous, I
-	 * knew) to prevent cpu going down. */
-	preempt_disable();
-	if (!cpu_online(cpu_id)) {
-		preempt_enable();
-		return 0;
-	}
-
 #ifdef CONFIG_SMP
 	pvr = per_cpu(cpu_pvr, cpu_id);
 #else
@@ -328,9 +320,6 @@ static int show_cpuinfo(struct seq_file
 #ifdef CONFIG_SMP
 	seq_printf(m, "\n");
 #endif
-
-	preempt_enable();
-
 	/* If this is the last cpu, print the summary */
 	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
 		show_cpuinfo_summary(m);
