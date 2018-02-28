Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519835018-2-12401541239131163292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835017; b=u103O/0qDm2Fk1xcwQBqLHLB4cqdRKbv5WUNEhdcMO8k81h
    qhDl17R6yzyXtoP87tCQiU59kLpOH/gQm9wbao1d3PCEQaFqZTqtTOr95WCLgGdj
    0maCRSU2qJY6Ut3+zR0fsxC2iYdHcG8CyIAF059CDpVhTZ3msvXltAp9n7R9ZnYs
    D/H7RI4dzST9LQb6AJ8GgOOskyHtL6vNGtDFB6j55rxHyNx1oiaw0nV7gb2ZHZqQ
    a0T29eomMBM2YpDp/I2u2FSd5aP/Kn8wyg8MztAnYJE/9U6tRx31Cjdt6ul+1zQE
    NyUIXF3uIBPYso9S/IcxGrFNSDeuAnxBaGgN/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835017; bh=SBnPYebmOX3U0XHgG4R
    nnwuMSVR8aCmSRQwHkh/JvP8=; b=XvAQN+hi9W/lD60VEUOc10I/sAcD5aXo0Ji
    4uTslYR759zD47UjG4Kjkwt+ROD1Bddo7A1QqEAyHIP5Y4Gyr3PkJttxbCY1nh20
    eivfxVKE2MT7BGQIUSor2oSU0ckdo4Ag9nnd39I6O/CwSX97HVjt8ssv1Ng12X9Y
    lk9l8MD7C3gpZI7EQK0qqvxtqrgtWI7MGnlghTR4WHPPkpqZZ5gDODee/H1n+vHl
    1jINMMMQcXTOPbm8we65H4ghapM62lL8hmL+kSwFcTxSDMSSyhoZpbS801Ar2hQr
    wBo5LuDECRZKjp4UMQbYd7Q8tnCUZXo0f1hbnugBXrtb1UJWyNg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932844AbeB1QXI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:23:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35393 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935188AbeB1QUv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:51 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dave Martin" <Dave.Martin@arm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.329652331@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 106/254] mips/ptrace: Preserve previous registers for
 short regset write
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

From: Dave Martin <Dave.Martin@arm.com>

commit d614fd58a2834cfe4efa472c33c8f3ce2338b09b upstream.

Ensure that if userspace supplies insufficient data to PTRACE_SETREGSET
to fill all the registers, the thread's old registers are preserved.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -484,7 +484,8 @@ static int fpr_set(struct task_struct *t
 					  &target->thread.fpu,
 					  0, sizeof(elf_fpregset_t));
 
-	for (i = 0; i < NUM_FPU_REGS; i++) {
+	BUILD_BUG_ON(sizeof(fpr_val) != sizeof(elf_fpreg_t));
+	for (i = 0; i < NUM_FPU_REGS && count >= sizeof(elf_fpreg_t); i++) {
 		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 					 &fpr_val, i * sizeof(elf_fpreg_t),
 					 (i + 1) * sizeof(elf_fpreg_t));
