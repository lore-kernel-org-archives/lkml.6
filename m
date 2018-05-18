Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-35557-1526662546-2-2269319625543767384
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526662545; b=Jm25o3bdv4Puaiz0rv3MJbkQHuRnakq9qqunq0xG9sYZN+NZMk
    JoCqjcYqITi5Nnovi/ddkgJqanDiuVA+jvwd1SLrkIlvW4mtki5R7jqGYk+4Z5ws
    oL+EmWZeCQpnjg+0ZG4mQvGc9bnFCHfI/Dulvr0fMTQZbVy72ZTDbLBj1MkYLdvi
    /HoftQ+KMvhUMUstUN0VOXPbI2Hridl/LUZHlltBvKFF9H1WagBDad+lzsDX05mY
    H0ekoz4TNqQC54DP+EuhZ2c27H3vggkqaEEw/MEcF7uw18pX/m2qoVHtvJeJlaEh
    dA65c+iuqe3mi7Cpnx1/rDKiBmuNL2ys68Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526662545; bh=7n7+dndSt5fcbo2GL+XYlSigCwX47z
    sFFqehD1CXL4Q=; b=GHXyXlI1OP+ygU0wxbIbgJkk/S5ccyFCBgQP8mQeHfgdLv
    JUmegpqKm/gPw79S05252wEG7q/+QS35qvL4kuyhGfBNsRWs5vmwpBevUIEhl5cJ
    A9C2p7DEZjn0I1uTXSJkV5MwIBjR8oPgjrzJ5z2u1UkLlFOjminL5TV3u7d8pySZ
    6KkAjCuWwMMeafV626EO8d98zQNICPT3L2DpnQ4NpCwgopwRg0kxJ7GLlxJ69825
    28mQ3LWitCeg0eXXTK9Ib/fiSBgcZFOmBcDrsoqHjfZ1rEL+zpujlcUiMO0l5YfY
    iInShOP36qpa0ZpM49ca4fnhLUCkoLhKClxVuhDw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAgW3dgcuoYQy9INiHk17Vsz7XB66b0cNq5ZiMu2Rd4xO3yTAry7ugyPnLOcKuhLrBKH3S1TOpBGUkIm7nre6tAEWX1hdTCmXE04TKACil7ezvidUuCX
    ocseQbz1iyeoFFjXZa3b6R28cD5O7dOt8bjHPWuD/awde4YXCseRm4ma0g3oNQJr9PF17plExzPNkCZnrsCsKKgB9j//UXsPjhY0k11LRhpLMK/jhAuwUNSQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=eMGQAqyUu0D8OVugCf4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeERQzl (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 12:55:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeERQzi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 12:55:38 -0400
Date: Fri, 18 May 2018 18:55:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] locking/rwsem: simplify the is-owner-spinnable checks
Message-ID: <20180518165534.GA22348@redhat.com>
References: <1526420991-21213-1-git-send-email-longman@redhat.com>
 <1526420991-21213-2-git-send-email-longman@redhat.com>
 <20180516121947.GE20670@bombadil.infradead.org>
 <20180518070258.GA20971@gmail.com>
 <20180518084122.GA14307@redhat.com>
 <20180518094052.GA26150@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518094052.GA26150@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add the trivial owner_on_cpu() helper for rwsem_can_spin_on_owner() and
rwsem_spin_on_owner(), it also allows to make rwsem_can_spin_on_owner()
a bit more clear.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index a903367..3064c50 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -347,6 +347,15 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 	}
 }
 
+static inline bool owner_on_cpu(struct task_struct *owner)
+{
+	/*
+	 * As lock holder preemption issue, we both skip spinning if
+	 * task is not on cpu or its cpu is preempted
+	 */
+	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
+}
+
 static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner;
@@ -359,17 +368,10 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 
 	rcu_read_lock();
 	owner = READ_ONCE(sem->owner);
-	if (!owner || !is_rwsem_owner_spinnable(owner)) {
-		ret = !owner;	/* !owner is spinnable */
-		goto done;
+	if (owner) {
+		ret = is_rwsem_owner_spinnable(owner) &&
+		      owner_on_cpu(owner);
 	}
-
-	/*
-	 * As lock holder preemption issue, we both skip spinning if task is not
-	 * on cpu or its cpu is preempted
-	 */
-	ret = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
-done:
 	rcu_read_unlock();
 	return ret;
 }
@@ -398,8 +400,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 * abort spinning when need_resched or owner is not running or
 		 * owner's cpu is preempted.
 		 */
-		if (!owner->on_cpu || need_resched() ||
-				vcpu_is_preempted(task_cpu(owner))) {
+		if (need_resched() || !owner_on_cpu(owner)) {
 			rcu_read_unlock();
 			return false;
 		}
-- 
2.5.0
