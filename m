Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837125-2-18328118939640797940
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
    t=1519837124; b=sGHU8Hj/jstrhud5SctG3TWD5KkS4k9Kev571KJGu/uSZ62
    8UwqVaVjdyuc5bY2M1MsirIf311ehFQ7DGI6oLKCQT/5E0kf6i+yuJOOEgOTGdGx
    XpC8sbpjXKrHbATQyk6F2ZrotnZvDRLXqzfqkPAlerhggShNXBHc9Jk4s2i8l6A1
    BxS2jfxqYztYaHctMo01JKmxfn7ndQuQmupqhfg5JSb947aDPi2P40D+mmj20mDw
    N8x+1b00CeAb5hwwDJEN6+AzivS6nCu5aoeHNATA3PR4Juk7+Dxaa5Yx4TVNjoIK
    ROqafNfpsbZBV3WoED/JDxE4LI5DLRhajOekO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837124; bh=zYdl+2bi2FAceI2NrOG
    qz3NurNxdJfgZPsc+/4TugMQ=; b=vxQ1Cc+S18o4Z2IzeKD1UYZm4XImBH5iNap
    pbP8yjpcLSR+cJ1l2PXORCEAYfzdy/iAJ8Pnwv1ijY6EeYl1+rkKA+d9tqXyZ8bK
    gK5v5nSAMnzAdVYUvMtbi6ard9G20jHNilPlqdg1OZWbib7l1XnY3SgYN4zFAWgT
    0Pp/EMKQJAubh9+Fm2eqoreHoTkUhYL+awE3qOAMmKZGwWttcAZFTgVxmgIDE9Br
    5nRUniVcvLbj7rYRVNZkcE1vGm/K0pTHc8KDMVMhbArxkl21NNPOju/epSGrIPSP
    jmpYRldozLWTUMtOKg17ZQGZCUOzHdnRN/cVptFGofrN4mUreBQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933643AbeB1Pwq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:52:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34412 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeB1Pwo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:44 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.99981508@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 030/140] s390: always save and restore all registers
 on context switch
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit fbbd7f1a51965b50dd12924841da0d478f3da71b upstream.

The switch_to() macro has an optimization to avoid saving and
restoring register contents that aren't needed for kernel threads.

There is however the possibility that a kernel thread execve's a user
space program. In such a case the execve'd process can partially see
the contents of the previous process, which shouldn't be allowed.

To avoid this, simply always save and restore register contents on
context switch.

Fixes: fdb6d070effba ("switch_to: dont restore/save access & fpu regs for kernel threads")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
[bwh: Backported to 3.2:
 - The save/restore functions are different here
 - FP restore is non-lazy, so drop the comment about it being lazy
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/include/asm/system.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- a/arch/s390/include/asm/system.h
+++ b/arch/s390/include/asm/system.h
@@ -89,17 +89,13 @@ static inline void restore_access_regs(u
 	asm volatile("lam 0,15,%0" : : "Q" (*acrs));
 }
 
-#define switch_to(prev,next,last) do {					\
-	if (prev->mm) {							\
-		save_fp_regs(&prev->thread.fp_regs);			\
-		save_access_regs(&prev->thread.acrs[0]);		\
-	}								\
-	if (next->mm) {							\
-		restore_fp_regs(&next->thread.fp_regs);			\
-		restore_access_regs(&next->thread.acrs[0]);		\
-		update_per_regs(next);					\
-	}								\
-	prev = __switch_to(prev,next);					\
+#define switch_to(prev, next, last) do {				\
+	save_fp_regs(&prev->thread.fp_regs);				\
+	save_access_regs(&prev->thread.acrs[0]);			\
+	restore_fp_regs(&next->thread.fp_regs);				\
+	restore_access_regs(&next->thread.acrs[0]);			\
+	update_per_regs(next);						\
+	prev = __switch_to(prev, next);					\
 } while (0)
 
 extern void account_vtime(struct task_struct *, struct task_struct *);
