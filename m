Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E5C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496852088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496852088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeGYPcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:32:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:32:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEK5ZE399879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:20:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEK5gb399876;
        Wed, 25 Jul 2018 07:20:05 -0700
Date:   Wed, 25 Jul 2018 07:20:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-c0dc373a780f4ec63e45a573b9551763abd8cd1a@git.kernel.org>
Cc:     mingo@kernel.org, jmario@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, longman@redhat.com,
        tglx@linutronix.de, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, jmario@redhat.com, longman@redhat.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <1531858560-21547-1-git-send-email-longman@redhat.com>
References: <1531858560-21547-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/pvqspinlock/x86: Use LOCK_PREFIX in
 __pv_queued_spin_unlock() assembly code
Git-Commit-ID: c0dc373a780f4ec63e45a573b9551763abd8cd1a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c0dc373a780f4ec63e45a573b9551763abd8cd1a
Gitweb:     https://git.kernel.org/tip/c0dc373a780f4ec63e45a573b9551763abd8cd1a
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 17 Jul 2018 16:16:00 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:22:20 +0200

locking/pvqspinlock/x86: Use LOCK_PREFIX in __pv_queued_spin_unlock() assembly code

The LOCK_PREFIX macro should be used in the __raw_callee_save___pv_queued_spin_unlock()
assembly code, so that the lock prefix can be patched out on UP systems.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Joe Mario <jmario@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1531858560-21547-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 9ef5ee03d2d7..159622ee0674 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -43,7 +43,7 @@ asm    (".pushsection .text;"
 	"push  %rdx;"
 	"mov   $0x1,%eax;"
 	"xor   %edx,%edx;"
-	"lock cmpxchg %dl,(%rdi);"
+	LOCK_PREFIX "cmpxchg %dl,(%rdi);"
 	"cmp   $0x1,%al;"
 	"jne   .slowpath;"
 	"pop   %rdx;"
