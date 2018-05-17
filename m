Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2258841-1526567996-2-3122358383326170410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526567996; b=XP9yPfXgwROWomiwnDX+bLNFN8rfUnpL4m4aGV9/eWKj+aenPE
    qUpb+hL7DT8O2RmbEtnbq9FFeV8U94clVmn3aVrRmk+ruDLz1mNrGWbrTQlq8Z2T
    ++QQqEvrTh1u5knkNF/G8VQaiZR3ZIZGrHrJwZ3HzRZ5ZyRrCm8wWP4tULpGYStL
    PGS78+8Jrx8xmT4rW+xgMNMdQ5aNoKNJlXIeoNwD/P3Mv3BXaP1uhjEZpQQAVgwB
    UDVcUbRC4AO74KT/h5mePHcoi1ueioFqwGkhz4utBgfoYasEFrixx5zHUM2saCWF
    leQ5t8F4SOcWY5SLxvJwCLDEaPwQC+XcKECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526567996; bh=hp6sG98rV+9OD/RezWuTdPkm7dBZ9P
    Dt+ZB4ypfbzXw=; b=B1UbFjoGhstED5pq+0mdtlP9IRHjo6inpgXhI0oOWpQ5Zk
    F5BYyDiNpnZcAdsdFTdgjWkHUN2EUBGWsHZfgZrYACvon279TpAlE1m1z2x7CURQ
    HgK0velDgrJjqkD6KOCV3jMrXCBYMR4oCgHgDrLFf8XpKiD26De/fA7UrNJv7d3v
    m3Z3OWXtIr8DQrXQGCxIOuYCllHnyk3iJvsJ++tN6PVq+7Z2yTwDKkKSWpKz7tNF
    r8PmfPsQ2T2uoF61j6srvGwX4NLFXnC8BGJhTH2feIHF7KPCwJf9Ri+OK0bf3y3I
    Cnabu7nXYBMiI6p6cDwnm2Otk64b1Ca1zlwgK4TQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLJKaSE7NcFqsulc6e5xuPsqBsqd6ADZ8iO2ReCupLaubJhYTkDrQQZIvyMGWjVADm940PxonH5oZfhRkObHc1/nnScaeIyeu1rXarGtVn+SzNAs+WU+
    LixbALRtMB/g6RHy0gRnbfD6l2pbLgnihB0s8jQlREoK5t1W3TmIDMT6fJ7DR8J+RZ8t/4O74YuNIThdDHqfhBIR42BvTNZ45L1dxNw0pEr2GmOO2mkpSAKN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=iox4zFpeAAAA:8 a=CbKAncbUPe6x3Puzp-oA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEQOjy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 10:39:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44065 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeEQOjy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 10:39:54 -0400
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        "4 . 13+" <stable@vger.kernel.org>
Subject: [PATCH] printk/nmi: Prevent deadlock when serializing NMI backtraces
Date: Thu, 17 May 2018 16:39:03 +0200
Message-Id: <20180517143903.19339-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The commit 719f6a7040f1bdaf96fcc ("printk: Use the main logbuf in NMI when
logbuf_lock is available") tried to detect when logbuf_lock was taken
on another CPU. Then it looked safe to wait for the lock even in NMI.

It would be safe if other locks were not involved. Ironically the same
commit introduced an ABBA deadlock scenario. It added a spin lock into
nmi_cpu_backtrace() to serialize logs from different CPUs. The effect
is that also the NMI handlers are serialized. As a result, logbuf_lock
might be blocked by NMI on another CPU:

CPU0			CPU1			CPU2

printk()
  vprintk_emit()
    spin_lock(&logbuf_lock)

						trigger_all_cpu_backtrace()
						  raise()

			nmi_enter()
			  printk_nmi_enter()
			    if (this_cpu_read(printk_context)
			      & PRINTK_SAFE_CONTEXT_MASK)
			      // false
			    else
			      // looks safe to use printk_deferred()
			      this_cpu_or(printk_context,
				PRINTK_NMI_DEFERRED_CONTEXT_MASK);

			  nmi_cpu_backtrace()
			    arch_spin_lock(&lock);
			      show_regs()

nmi_enter()
  nmi_cpu_backtrace()
    arch_spin_lock(&lock);

			      printk()
				vprintk_func()
				  vprintk_deferred()
				    vprintk_emit()
				      spin_lock(&logbuf_lock)

DEADLOCK: between &logbuf_lock from vprintk_emit() and
		  &lock from nmi_cpu_backtrace().

CPU0			CPU1
lock(logbuf_lock)	lock(lock)
  lock(lock)		  lock(logbuf_lock)

I have found this problem when stress testing trigger_all_cpu_backtrace()
and the system frozen.

Note that lockdep is not able to detect these dependencies because
there is no support for NMI context. Let's stay on the safe side
and always use printk_safe buffers when logbuf_lock is taken
when entering NMI.

Fixes: 719f6a7040f1bdaf96fcc ("printk: Use the main logbuf in NMI when logbuf_lock is available")
Cc: 4.13+ <stable@vger.kernel.org> # v4.13+
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_safe.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 449d67edfa4b..a2ebd749c053 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -310,15 +310,12 @@ void printk_nmi_enter(void)
 {
 	/*
 	 * The size of the extra per-CPU buffer is limited. Use it only when
-	 * the main one is locked. If this CPU is not in the safe context,
-	 * the lock must be taken on another CPU and we could wait for it.
+	 * the main one is locked.
 	 */
-	if ((this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) &&
-	    raw_spin_is_locked(&logbuf_lock)) {
+	if (raw_spin_is_locked(&logbuf_lock))
 		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
-	} else {
+	else
 		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
-	}
 }
 
 void printk_nmi_exit(void)
-- 
2.13.6
