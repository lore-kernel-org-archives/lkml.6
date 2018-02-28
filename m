Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834340-2-14835089742492707994
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
    t=1519834340; b=oTNqw/EVieB3emd2uFj93cN0/Qnz+3JBCS+cBpah7fup/CG
    RDYIQJwn4swyhAUN01oJ/zM6OnIf0wwOqGUXpzXo/zP3p6kH1ofFV3j1bR4FpQjs
    PuiZZ7dITB5pfryJewLw0O98ajph/3lR1rlwIukoGK3uR6An1N8x2rHp9QZb3VH2
    2x9qj45R6O+isMoyxwwY5ADV2XjFDPAWb6OKWY08uV+D+aLZcSIFj9UitnBsb58H
    tfI6pPQUtP8VjXatXKi+K36mY/E/XZvMl5FiyjbtwsrFhqEp6NU8CyTBi+6xLwAM
    0ZpHVPVWUDy6iMy5cBCp6/TL9818viCYjfjW0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834340; bh=iXkTx35Vyr+SYQ0ZF7j
    9t8R4kpvJ/lhsM6+Y24enmSQ=; b=P12+uhYtO7Z+PfZqyy6rsJ2rnC8NUowDMn8
    MzV9yqKqBp5DAq5MPttJEU2UAvtHkErPsmATvgY62LfVaLcjbGbADHcKLQurKn4m
    b+x4V8niZR0oWYGRHCX341xyVrpwINO8ER0U67gpPZYj4rool9MYpHNv9C2QuXaT
    iJ+cYYLlYg6l1+jkLM+NpU+C2GYZs8IZE+E0GJY7Ucf6KgobBSEMt2f63sOZd/Rn
    P8ErjdgRcmkAkMuLr0BeyTR5sjVsqGRlISRoJS5YnieUU5x4H/9Y7IxDfvX/hxU0
    6Uk5tNMWpxWWniMqj4IVQpwrZ7L9afbgioUVHN4hdERABiTML6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934406AbeB1QMH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:12:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35028 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933269AbeB1QME (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:12:04 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dave Martin" <Dave.Martin@arm.com>,
        "Paul Burton" <Paul.Burton@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        "Alex Smith" <alex@alex-smith.me.uk>,
        "James Hogan" <james.hogan@mips.com>, linux-mips@linux-mips.org
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.222715157@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 108/254] MIPS: Guard against any partial write
 attempt with PTRACE_SETREGSET
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

From: "Maciej W. Rozycki" <macro@mips.com>

commit dc24d0edf33c3e15099688b6bbdf7bdc24bf6e91 upstream.

Complement commit d614fd58a283 ("mips/ptrace: Preserve previous
registers for short regset write") and ensure that no partial register
write attempt is made with PTRACE_SETREGSET, as we do not preinitialize
any temporaries used to hold incoming register data and consequently
random data could be written.

It is the responsibility of the caller, such as `ptrace_regset', to
arrange for writes to span whole registers only, so here we only assert
that it has indeed happened.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for FP regset")
Cc: James Hogan <james.hogan@mips.com>
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17926/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -535,7 +535,15 @@ static int fpr_set_msa(struct task_struc
 	return 0;
 }
 
-/* Copy the supplied NT_PRFPREG buffer to the floating-point context.  */
+/*
+ * Copy the supplied NT_PRFPREG buffer to the floating-point context.
+ *
+ * We optimize for the case where `count % sizeof(elf_fpreg_t) == 0',
+ * which is supposed to have been guaranteed by the kernel before
+ * calling us, e.g. in `ptrace_regset'.  We enforce that requirement,
+ * so that we can safely avoid preinitializing temporaries for
+ * partial register writes.
+ */
 static int fpr_set(struct task_struct *target,
 		   const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
@@ -543,6 +551,8 @@ static int fpr_set(struct task_struct *t
 {
 	int err;
 
+	BUG_ON(count % sizeof(elf_fpreg_t));
+
 	/* XXX fcr31  */
 
 	init_fp_ctx(target);
