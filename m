Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326308-2-3725743534033115437
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
    t=1518326307; b=kGtLH49p492je66XFe3xj4lLZd+3C9HsG4URvH13fRvOVN1
    p/Ac5WYmg5V83OzIjKoSOR3I4OjB3vBzHfKyvLj2qNJNrWRXk46Ilt0m1UGnZwn0
    7YNAok3LodpzyQZGopJX95JEAfgDXlpKCQtjM9PyF7kJAv78S+WHxcONWiP4+km8
    biTrYWKkWXH3jP9IyOm3qH+m3j/y2jBCoJwsocCjkMFxjbU6oH5RXY5sxd0AdRd2
    cpLDHoe94e1f85nx6JUzrEepaS1VZZJ8oTn87BZunrNNOryKx8RPXZTEZrqc/H/e
    l4hNR8tf8ucsQpGR2XlE1dION0t+RRthVGrAftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326307; bh=4Zp9EJ3Ubrv18soT/AO
    4NcPHq88bQMQ6eYP+ZZHUPN0=; b=Wq3PCUNhSbbawFXd1foA4rCcTwNCJq+aXB0
    vJv5EReGAHTe8gdRLAO+KXrh0e6L8jlQjtfeJaaTIfEec+IlNfixqQufeNjEGJZ1
    1n1Lgh6TzSlIvwBXllTiqPSRNrYok8o5ajV2Z9ig+ekPm7sbm9qfJrJwAGrsD9Mn
    ewBRSPGCFpRVhhDJvpEL5hdDmoCbmIzfixqWI5XcMp78zMLPQYXBmI3TnaQAyBG6
    qrs0thyPQrvWFz5x7W9UwSsWIoRkHCWbJAeRsKFq1dHkAoF+zvmvoo/ywWsdXoKn
    h5c4qikREw7CPupfgW0gElGP+c/8HZ2THHnVhREZbLsEAlTBeFQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeBKFSX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:18:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754028AbeBKFSU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:20 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Djordje Todorovic" <djordje.todorovic@rt-rk.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <jhogan@kernel.org>, linux-mips@linux-mips.org
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.320638011@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 070/136] MIPS: Fix an n32 core file generation regset
 support regression
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

From: "Maciej W. Rozycki" <macro@mips.com>

commit 547da673173de51f73887377eb275304775064ad upstream.

Fix a commit 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
regression, then activated by commit 6a9c001b7ec3 ("MIPS: Switch ELF
core dumper to use regsets.)", that caused n32 processes to dump o32
core files by failing to set the EF_MIPS_ABI2 flag in the ELF core file
header's `e_flags' member:

$ file tls-core
tls-core: ELF 32-bit MSB executable, MIPS, N32 MIPS64 rel2 version 1 (SYSV), [...]
$ ./tls-core
Aborted (core dumped)
$ file core
core: ELF 32-bit MSB core file MIPS, MIPS-I version 1 (SYSV), SVR4-style
$

Previously the flag was set as the result of a:

statement placed in arch/mips/kernel/binfmt_elfn32.c, however in the
regset case, i.e. when CORE_DUMP_USE_REGSET is set, ELF_CORE_EFLAGS is
no longer used by `fill_note_info' in fs/binfmt_elf.c, and instead the
`->e_flags' member of the regset view chosen is.  We have the views
defined in arch/mips/kernel/ptrace.c, however only an o32 and an n64
one, and the latter is used for n32 as well.  Consequently an o32 core
file is incorrectly dumped from n32 processes (the ELF32 vs ELF64 class
is chosen elsewhere, and the 32-bit one is correctly selected for n32).

Correct the issue then by defining an n32 regset view and using it as
appropriate.  Issue discovered in GDB testing.

Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Djordje Todorovic <djordje.todorovic@rt-rk.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17617/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -522,6 +522,19 @@ static const struct user_regset_view use
 	.n		= ARRAY_SIZE(mips64_regsets),
 };
 
+#ifdef CONFIG_MIPS32_N32
+
+static const struct user_regset_view user_mipsn32_view = {
+	.name		= "mipsn32",
+	.e_flags	= EF_MIPS_ABI2,
+	.e_machine	= ELF_ARCH,
+	.ei_osabi	= ELF_OSABI,
+	.regsets	= mips64_regsets,
+	.n		= ARRAY_SIZE(mips64_regsets),
+};
+
+#endif /* CONFIG_MIPS32_N32 */
+
 #endif /* CONFIG_64BIT */
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
@@ -533,6 +546,10 @@ const struct user_regset_view *task_user
 	if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 		return &user_mips_view;
 #endif
+#ifdef CONFIG_MIPS32_N32
+	if (test_tsk_thread_flag(task, TIF_32BIT_ADDR))
+		return &user_mipsn32_view;
+#endif
 	return &user_mips64_view;
 #endif
 }
