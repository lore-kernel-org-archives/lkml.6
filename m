Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479445-2-12834279128968362158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479444; b=DKo8UOZCQ28YZkLAEsimYvnas2qaO1gwTYFYbEsK5vMTWITFtl
    BNqOEwxTnjNhqKGsH0nAkWOMaUL0S1FIN0zLakNF64xmFHvuhcw/Varyhc7Oyxve
    2ocKt7a6zn8x/yYvvgogSrjNm2FjVs2mcD6RBV3TlBK4LkjUkn48EyAkrWW1AJEU
    JSz7gjNjVzDYwyd/SLsS6Cd61jlFplpI8I/vOXAV03WRg/53qBdB67ZvAkra+fUu
    KO5KWx1vjJ937Tz13UFSQraK5mzWKX+r7tDVhaXPMiAyqAiCKW3ExF+ZFbA5gyrD
    7Etm54QVw9kto5Oj3Ux/sDpO/QaOju0mhmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479444; bh=oa5ck88G2xhW2AAqDPtdg5tVT6wDUx
    P8QJhQuB+5q10=; b=cJIP7VFvz0Lq7lb3U1sVyikAhbUmDoLEFpeJCaO3LPpmU2
    qFVo2XaGlfr4CUELWtIKOJ0+q9NC8p388+Y0yTl+T8ZxbT+cyZnio44yQSz1B96c
    VjO0Ytns9gP7xKedf7xERx82JeA45DUerhW2+x314uc7bds8cj9P0QN2L8/B4Zk/
    P9kTiZm1USnjro7FRjCgV9mIWNhi7mfEabAhmSbUAdZzXOtu0HfEDkN3G5DLT+ua
    PzUGVfNfj8ZsMw2dD3UGiRR5l/wivj1OqhJ6206/b4fWz4352R2jMGqV9rzCCS7D
    Fd/FsqXLxKcf8va1mdrbgtl4pERv1ZW8MpUvkvzg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfDlAHdYdvBPAUNeqBiALD7kYMIX/jg2On4SkxiGYEt9mOJnJBp0JRK13kVqMagR7CdvIR/0kxK9/ff7lX/KXl+IK9hXZlbVfVPuycZ8naN3yR+RQnpR7
    CZvTclWpti6j/ibhDd6etswY8vMGL1zLuCkz5KsM1wQbFoJnoBDmwRt9KbjMYmVNyH7mp7YpcoO4+TUypiCHiWYDRg1AaeJmHhE6sNW2YBaxnqpUuRmrPwrr
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=R_Myd5XaAAAA:8 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=Q85a5QUVxAGcZ4WZ4qcA:9
    a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=L2g4Dz8VuBQ37YGmWQah:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeDKUoB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:44:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755860AbeDKSrX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 062/190] sched/numa: Use down_read_trylock() for the mmap_sem
Date: Wed, 11 Apr 2018 20:35:08 +0200
Message-Id: <20180411183553.939186174@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>


[ Upstream commit 8655d5497735b288f8a9b458bd22e7d1bf95bb61 ]

A customer has reported a soft-lockup when running an intensive
memory stress test, where the trace on multiple CPU's looks like this:

 RIP: 0010:[<ffffffff810c53fe>]
  [<ffffffff810c53fe>] native_queued_spin_lock_slowpath+0x10e/0x190
...
 Call Trace:
  [<ffffffff81182d07>] queued_spin_lock_slowpath+0x7/0xa
  [<ffffffff811bc331>] change_protection_range+0x3b1/0x930
  [<ffffffff811d4be8>] change_prot_numa+0x18/0x30
  [<ffffffff810adefe>] task_numa_work+0x1fe/0x310
  [<ffffffff81098322>] task_work_run+0x72/0x90

Further investigation showed that the lock contention here is pmd_lock().

The task_numa_work() function makes sure that only one thread is let to perform
the work in a single scan period (via cmpxchg), but if there's a thread with
mmap_sem locked for writing for several periods, multiple threads in
task_numa_work() can build up a convoy waiting for mmap_sem for read and then
all get unblocked at once.

This patch changes the down_read() to the trylock version, which prevents the
build up. For a workload experiencing mmap_sem contention, it's probably better
to postpone the NUMA balancing work anyway. This seems to have fixed the soft
lockups involving pmd_lock(), which is in line with the convoy theory.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@redhat.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170515131316.21909-1-vbabka@suse.cz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2223,7 +2223,8 @@ void task_numa_work(struct callback_head
 		return;
 
 
-	down_read(&mm->mmap_sem);
+	if (!down_read_trylock(&mm->mmap_sem))
+		return;
 	vma = find_vma(mm, start);
 	if (!vma) {
 		reset_ptenuma_scan(p);
