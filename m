Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519832203-2-4679383866578899946
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832203; b=EDlco057QDpkDmdgXlCud/jiO86C8Ucbq/CDd0wFfxX/ozC
    +BKWZ0B9eIKzSk6WW98PQQRkGPQYeLjOxvt+GY/FJzaIx6R0Aj3dN8ufdjukIFiL
    FBqE0kz2kc4oN9XDsu0Z7lUiOtsQNO+0W66F+XJQUgsDUPZlmBGM5HaqsD1AtTMB
    AWKTm3mWwhPLxAxKv98gYIGykyQ2i1c2zjprVIjx+A6PQGNqEk2u0WRO0iAt7zMS
    y9dkN4S2Nak5cplpdoLsLb4vC3sQGuMzX9I+1YovjQHGFhX404WJr3WZsNQWreGG
    yxyT6jpFOqv0liaITuoqhRJh5EXzwUaXwiHbwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832203; bh=AdSAMA4KH6FRP1x14C+
    p6va2zbq9lnMs5zcA+OOoAyI=; b=E8UIeP5j3Xxc6fZ5LD8X8W/vzPvUZeFQpE/
    vOaJOJW+XBQ6JtEyyBA+gXy0d4V/j/6jxyc83crl1ZPJKQzHyJLhScMHvXPFWi51
    KAZqCLHcylavjAYNtlDUBuzkNH8PjmA6CNvbqVrLWULrDOq5iTd73PsMhlVKUikX
    U6ROWbwn7zQVetgC8ZkZDZlH6f6o32L913TURSGOyUjPcO3lYzCJUUoa/XyJqd/w
    FMR7C9Xe0s8iVSxg7OmjKxT8XjNuEx9YbKoikl50s3RWYc1VOL57yywWvokvrZkV
    gteG0OVKl2g47GhHvOJPVFexm4jR6u3tnwy1VGwmC0wW6miWD3g==
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
        id S933034AbeB1Pgl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:36:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33241 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752756AbeB1PWe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.414252290@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 055/254] s390: always save and restore all registers
 on context switch
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
[bwh: Backported to 3.16:
 - The save/restore functions are different here
 - FP restore is non-lazy, so drop the comment about it being lazy]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/s390/include/asm/switch_to.h
+++ b/arch/s390/include/asm/switch_to.h
@@ -117,21 +117,17 @@ static inline void restore_access_regs(u
 	asm volatile("lam 0,15,%0" : : "Q" (*(acrstype *)acrs));
 }
 
-#define switch_to(prev,next,last) do {					\
-	if (prev->mm) {							\
-		save_fp_ctl(&prev->thread.fp_regs.fpc);			\
-		save_fp_regs(prev->thread.fp_regs.fprs);		\
-		save_access_regs(&prev->thread.acrs[0]);		\
-		save_ri_cb(prev->thread.ri_cb);				\
-	}								\
+#define switch_to(prev, next, last) do {				\
+	save_fp_ctl(&prev->thread.fp_regs.fpc);				\
+	save_fp_regs(prev->thread.fp_regs.fprs);			\
+	save_access_regs(&prev->thread.acrs[0]);			\
+	save_ri_cb(prev->thread.ri_cb);					\
 	update_cr_regs(next);						\
-	if (next->mm) {							\
-		restore_fp_ctl(&next->thread.fp_regs.fpc);		\
-		restore_fp_regs(next->thread.fp_regs.fprs);		\
-		restore_access_regs(&next->thread.acrs[0]);		\
-		restore_ri_cb(next->thread.ri_cb, prev->thread.ri_cb);	\
-	}								\
-	prev = __switch_to(prev,next);					\
+	restore_fp_ctl(&next->thread.fp_regs.fpc);			\
+	restore_fp_regs(next->thread.fp_regs.fprs);			\
+	restore_access_regs(&next->thread.acrs[0]);			\
+	restore_ri_cb(next->thread.ri_cb, prev->thread.ri_cb);		\
+	prev = __switch_to(prev, next);					\
 } while (0)
 
 #endif /* __ASM_SWITCH_TO_H */
