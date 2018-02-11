Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324316-2-4395645502779039313
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
    t=1518324316; b=l4E313CYZk1iv6omQrNzf/m6rtRtoWEarFP93VWkqWnUik6
    nci3c6sWYoimOY2mJyqB/grb+0QX5DTmxY7VjByTD8rYzO4fX7+jKuQjOcb+npVW
    bLvYgZU+h6oz6/hRXenuFA+EmF/4MW8//AUJO9VQTF7xS9SDaJwgonmMqv9ZAul5
    OGGgcnaqko4T0979Tf+3Rgx6dl+Iejtcl0JaIuepHJHW4PJt0LxianjuJ9j10y5E
    e8QoHDbSB3fqdhpiFJV7/VM4trfupaTNEyc2+muQX1U6rbQfnvP3KCG4MbWpOaLB
    n+QjjdcG3Ar/Q8fUZJZ8yo9F96qEtdOWNVeSaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324316; bh=kbI+6BcA0bUbK0giF95
    HpaHp7+I7ppAkt4OCgbQ5rkg=; b=l+W1wPifdVrk+fBKkVCxlgsjmd+zg2i8UMJ
    MfZycmLWoa29IuLD9hq+TvtIWoEGr36aa1Un/UGV3EeiwJ//GC+dKJpFfYbI2WDp
    2oS2wLe5CA1gWWLeweggfIRYk91NX0gE3jmcug86m+GSsH9Ezo1mZU4IuVufYPw2
    HJfrqBCBDTLelcZYUyFYUgzxdk7iefgGwr36OOewWTYjJNOIcFAri0jjNsVQ1akL
    OMoe1TjaeNMcb1LsAZzvtISef3So/gvD7h2XQwcigJuUGPAksvFKDMIG8m+6Kt6o
    zUyVAvvUUQ37zNt6fM7Br4HHlGyfhxMhU9IctLlY/C777qzw/lw==
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
        id S1753267AbeBKEnD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:43:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41905 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752877AbeBKEd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "Hendrik Brueckner" <brueckner@linux.vnet.ibm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.586992741@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 073/136] s390: fix transactional execution control
 register handling
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

commit a1c5befc1c24eb9c1ee83f711e0f21ee79cbb556 upstream.

Dan Horák reported the following crash related to transactional execution:

User process fault: interruption code 0013 ilc:3 in libpthread-2.26.so[3ff93c00000+1b000]
CPU: 2 PID: 1 Comm: /init Not tainted 4.13.4-300.fc27.s390x #1
Hardware name: IBM 2827 H43 400 (z/VM 6.4.0)
task: 00000000fafc8000 task.stack: 00000000fafc4000
User PSW : 0705200180000000 000003ff93c14e70
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:2 PM:0 RI:0 EA:3
User GPRS: 0000000000000077 000003ff00000000 000003ff93144d48 000003ff93144d5e
           0000000000000000 0000000000000002 0000000000000000 000003ff00000000
           0000000000000000 0000000000000418 0000000000000000 000003ffcc9fe770
           000003ff93d28f50 000003ff9310acf0 000003ff92b0319a 000003ffcc9fe6d0
User Code: 000003ff93c14e62: 60e0b030            std     %f14,48(%r11)
           000003ff93c14e66: 60f0b038            std     %f15,56(%r11)
          #000003ff93c14e6a: e5600000ff0e        tbegin  0,65294
          >000003ff93c14e70: a7740006            brc     7,3ff93c14e7c
           000003ff93c14e74: a7080000            lhi     %r0,0
           000003ff93c14e78: a7f40023            brc     15,3ff93c14ebe
           000003ff93c14e7c: b2220000            ipm     %r0
           000003ff93c14e80: 8800001c            srl     %r0,28

There are several bugs with control register handling with respect to
transactional execution:

- on task switch update_per_regs() is only called if the next task has
  an mm (is not a kernel thread). This however is incorrect. This
  breaks e.g. for user mode helper handling, where the kernel creates
  a kernel thread and then execve's a user space program. Control
  register contents related to transactional execution won't be
  updated on execve. If the previous task ran with transactional
  execution disabled then the new task will also run with
  transactional execution disabled, which is incorrect. Therefore call
  update_per_regs() unconditionally within switch_to().

- on startup the transactional execution facility is not enabled for
  the idle thread. This is not really a bug, but an inconsistency to
  other facilities. Therefore enable the facility if it is available.

- on fork the new thread's per_flags field is not cleared. This means
  that a child process inherits the PER_FLAG_NO_TE flag. This flag can
  be set with a ptrace request to disable transactional execution for
  the current process. It should not be inherited by new child
  processes in order to be consistent with the handling of all other
  PER related debugging options. Therefore clear the per_flags field in
  copy_thread_tls().

Reported-and-tested-by: Dan Horák <dan@danny.cz>
Fixes: d35339a42dd1 ("s390: add support for transactional memory")
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/include/asm/switch_to.h | 2 +-
 arch/s390/kernel/early.c          | 4 +++-
 arch/s390/kernel/process.c        | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/switch_to.h
+++ b/arch/s390/include/asm/switch_to.h
@@ -124,12 +124,12 @@ static inline void restore_access_regs(u
 		save_access_regs(&prev->thread.acrs[0]);		\
 		save_ri_cb(prev->thread.ri_cb);				\
 	}								\
+	update_cr_regs(next);						\
 	if (next->mm) {							\
 		restore_fp_ctl(&next->thread.fp_regs.fpc);		\
 		restore_fp_regs(next->thread.fp_regs.fprs);		\
 		restore_access_regs(&next->thread.acrs[0]);		\
 		restore_ri_cb(next->thread.ri_cb, prev->thread.ri_cb);	\
-		update_cr_regs(next);					\
 	}								\
 	prev = __switch_to(prev,next);					\
 } while (0)
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -388,8 +388,10 @@ static __init void detect_machine_facili
 		S390_lowcore.machine_flags |= MACHINE_FLAG_IDTE;
 	if (test_facility(40))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_LPP;
-	if (test_facility(50) && test_facility(73))
+	if (test_facility(50) && test_facility(73)) {
 		S390_lowcore.machine_flags |= MACHINE_FLAG_TE;
+		__ctl_set_bit(0, 55);
+	}
 	if (test_facility(66))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_RRBM;
 	if (test_facility(51))
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -123,6 +123,7 @@ int copy_thread(unsigned long clone_flag
 	memset(&p->thread.per_user, 0, sizeof(p->thread.per_user));
 	memset(&p->thread.per_event, 0, sizeof(p->thread.per_event));
 	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
+	p->thread.per_flags = 0;
 	/* Initialize per thread user and system timer values */
 	ti = task_thread_info(p);
 	ti->user_timer = 0;
