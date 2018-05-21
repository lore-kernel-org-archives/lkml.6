Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938498-2-5594698546351715126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938497; b=dAa4a/NBb1N1oEA4ilyaNSz4N2PowmLQoerxNHSUI/6cMIos9x
    p9cBC/Hi7ZAtMFUQBi9M1XUH3azuFA9/f8bmAbrxmhwLeb/OVdddxdyKE/1xUkPa
    dK5SPc1GqGxM18l8o5WTAoO5K6TbhcYWWTfZWqt4tUggca5n40w4FFYYJa7SQl3o
    z2v+eM2bHob4ISMA1xrmsB7OELJufmUosyUxo/f62UfS9TefuYev24scVm3riX/b
    GC2pTkpnxtHSFrAxLC4fIxnrdFm5sPGRhQOvdmgC2hAMb1qKsvofAYWjcLCknsWH
    m+cLbuPjxoRuqJKvapjlVdhz4dQFulxeNtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938497; bh=Lu9BCzksub3Nel+vzTVqLqi6IWq8Dn
    lKT/xKw82nIH0=; b=Hf4Ea10+CZbpqCW8Ykk3SKB4tc8JHwyotNZNu4WOHC7hfW
    9e7ezEDlwixPq/CMTmFLpOg6eOiVM3tBjP2P0iV9FsWVdfOu1lZH6bqBsGezZvGi
    MQsiqgACAOloae0m0bc8njnm2787bkVu1YOVsudgeTfvuR2cIwPlVNo6bO0fdCGK
    8tXqo1x6DPMGkLmXhGFwDfOGCPClR4MdVqZwQ1UUIQ+cfch0SsNAWUtHSJXqIbFK
    BX7b/F+FqLKY2SMyscJOd0f0l5OJYtgknQG12Sr7/TMdbOQ2F18d03ufdLsaXwSj
    8jNwTWWfpP59BBsTvNLjkBPEMxti7Kf1VPfJvQhQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=lqjQpg8D x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=lqjQpg8D x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFC+VJt1xY78ZhWzNevNLf7wriHYxgEZMFOBJyq7Gxd3dm6kigcHwe0onkAPrevdUGhLbJwzg08GZDveAgNiWRpru2xtv96BuiTPnzoE0cWOXuW8yfsa
    GofeyPQuS8VBvnzBZgvVMZlXirAhUR0fidqlwnCH98a/YJAIjjVq0Qbq5YTMMz8bEgoqFKXx+Q5G6VRRgnV5eRuIZSo8MUNUbTMMO9AgmjICt+v2DdyqoJT5
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=NQ5BNl5N-2Gq7MwW420A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754440AbeEUVex (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932480AbeEUVZv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:25:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 085/110] seccomp: Move speculation migitation control to arch code
Date: Mon, 21 May 2018 23:12:22 +0200
Message-Id: <20180521210513.688318412@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 8bf37d8c067bb7eb8e7c381bdadf9bd89182b6bc upstream

The migitation control is simpler to implement in architecture code as it
avoids the extra function call to check the mode. Aside of that having an
explicit seccomp enabled mode in the architecture mitigations would require
even more workarounds.

Move it into architecture code and provide a weak function in the seccomp
code. Remove the 'which' argument as this allows the architecture to decide
which mitigations are relevant for seccomp.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   29 ++++++++++++++++++-----------
 include/linux/nospec.h     |    2 ++
 kernel/seccomp.c           |   15 ++-------------
 3 files changed, 22 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -569,6 +569,24 @@ static int ssb_prctl_set(struct task_str
 	return 0;
 }
 
+int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
+			     unsigned long ctrl)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_set(task, ctrl);
+	default:
+		return -ENODEV;
+	}
+}
+
+#ifdef CONFIG_SECCOMP
+void arch_seccomp_spec_mitigate(struct task_struct *task)
+{
+	ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+}
+#endif
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -587,17 +605,6 @@ static int ssb_prctl_get(struct task_str
 	}
 }
 
-int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
-			     unsigned long ctrl)
-{
-	switch (which) {
-	case PR_SPEC_STORE_BYPASS:
-		return ssb_prctl_set(task, ctrl);
-	default:
-		return -ENODEV;
-	}
-}
-
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 {
 	switch (which) {
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -62,5 +62,7 @@ static inline unsigned long array_index_
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which);
 int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 			     unsigned long ctrl);
+/* Speculation control for seccomp enforced mitigation */
+void arch_seccomp_spec_mitigate(struct task_struct *task);
 
 #endif /* _LINUX_NOSPEC_H */
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -229,18 +229,7 @@ static inline bool seccomp_may_assign_mo
 	return true;
 }
 
-/*
- * If a given speculation mitigation is opt-in (prctl()-controlled),
- * select it, by disabling speculation (enabling mitigation).
- */
-static inline void spec_mitigate(struct task_struct *task,
-				 unsigned long which)
-{
-	int state = arch_prctl_spec_ctrl_get(task, which);
-
-	if (state > 0 && (state & PR_SPEC_PRCTL))
-		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_FORCE_DISABLE);
-}
+void __weak arch_seccomp_spec_mitigate(struct task_struct *task) { }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
 				       unsigned long seccomp_mode,
@@ -256,7 +245,7 @@ static inline void seccomp_assign_mode(s
 	smp_mb__before_atomic();
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
-		spec_mitigate(task, PR_SPEC_STORE_BYPASS);
+		arch_seccomp_spec_mitigate(task);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 
