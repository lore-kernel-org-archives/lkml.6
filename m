Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325317-2-10536480282074522402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325316; b=qvCpgs+K45IqRBtwBEybe2Z2dk0Ki7BW7pWv+jolYSqrZ5K
    fB1vKHECp4XTkr4G4MAX+3ZsLqU5MrbFIi013FM62qwY4eZhmqy9jqRpOxJO+vwx
    lG61BJNkySTKr1MMlb4HQX8f1wC3zEAsq3HN+uRIEYV1nJA2eybGHPTIoE6KOCFF
    0oZOWgJMsH6ZV8F5c2y3PWI9yi57ImRJTs9aTyV5X37GmxXz3jIrcYZ0gVFMob8/
    eknTgTkluRIZHb2v03+XDG6/rVKSJLjIydsvxnClHYRCbAmhU8cqJZ+XU+3pUvzE
    tpUHLLUKTJM9g2c4O8RrDB/uBEkeodZgGAR9EHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325316; bh=IlJkdOFxntRoan3g2FN
    L/F8cHFMyRM1Mpf0PRPgQAg4=; b=R/dmmoCabY2xpiBHGjHYnUd0muI4RAIMnc8
    BG/Z74zeL+z90QSq6/FEVpBzXUpL2qt/YBSCuaehl12WFhpB7jizjYKpZJKXgR7V
    fpYaxeROnIVTDCmV05R9AKL0okhB95OtQI4mK6qz7vRnsEbgEe54I+C36pzdlXod
    /b+/lV/wDa4ekvjDk1baNIVxJidxmTaY/Ue5/HjykFpQlXIjpxannfheec6MLoQt
    6iVgrSNeGSgHXgOflHEUDzB3yNh3TeDoZgLTNfyS7JfGHkNpLJ4o/zlPt9edBLvi
    NB8+Hp/BvF42fBraZlj01kkVJkLyRNXKkZJQdmlAS3J2DTuRkRg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeBKFBM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:01:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41653 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752765AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.139268439@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 005/136] s390/runtime instrumention: fix possible
 memory corruption
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit d6e646ad7cfa7034d280459b2b2546288f247144 upstream.

For PREEMPT enabled kernels the runtime instrumentation (RI) code
contains a possible use-after-free bug. If a task that makes use of RI
exits, it will execute do_exit() while still enabled for preemption.

That function will call exit_thread_runtime_instr() via
exit_thread(). If exit_thread_runtime_instr() gets preempted after the
RI control block of the task has been freed but before the pointer to
it is set to NULL, then save_ri_cb(), called from switch_to(), will
write to already freed memory.

Avoid this and simply disable preemption while freeing the control
block and setting the pointer to NULL.

Fixes: e4b8b3f33fca ("s390: add support for runtime instrumentation")
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/kernel/runtime_instr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/runtime_instr.c
+++ b/arch/s390/kernel/runtime_instr.c
@@ -53,12 +53,14 @@ void exit_thread_runtime_instr(void)
 {
 	struct task_struct *task = current;
 
+	preempt_disable();
 	if (!task->thread.ri_cb)
 		return;
 	disable_runtime_instr();
 	kfree(task->thread.ri_cb);
 	task->thread.ri_signum = 0;
 	task->thread.ri_cb = NULL;
+	preempt_enable();
 }
 
 static void runtime_instr_int_handler(struct ext_code ext_code,
@@ -100,9 +102,7 @@ SYSCALL_DEFINE2(s390_runtime_instr, int,
 		return -EOPNOTSUPP;
 
 	if (command == S390_RUNTIME_INSTR_STOP) {
-		preempt_disable();
 		exit_thread_runtime_instr();
-		preempt_enable();
 		return 0;
 	}
 
