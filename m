Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938605-2-8491152918407398396
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
    1526938604; b=J7DXtvnyB9c2PC9iHz3s1bTZEd9EW4TPYaMDAGhC0thE0Gb1cZ
    x0jQCHBgGgLYkvArFE7qzfKqy35HMV595JaRMG54qI+rI+ie1rgBhvoHvU0Ls6PH
    +rO+p97ttIX+MexiDuA3r0lr2yiHgzBkDKJpwyG0mka4kt+IIJSjChh2tHR7bRZf
    DSqIeg2r8zF+TjRe6V2X3+PmnNSDdGkZft5I8bvAYr4jMVgzseSLmnzS2VMejzqI
    roJodwJwNPVt/6r6gnq0sExhvs2iPtRm5qVeyKgVgoTw9WYzakoapCdLHfMct4J9
    JOv2wS/OBwPOl5bk/HS8u10mg5CHDMiE6ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938604; bh=5k+jCXeZElESmgCEwhvukMfLEhRQ2C
    92YTXoktUu6ho=; b=feg8N1FXWRI2lFCmymTItg8HVH5Xk6mcxfIGp8fyUfZqss
    6Xf4c0s3t6qaXENDtLrbcXwWXdDA2QVq5VNIATRLjOJPSctycD+YQk79uk9wBRnU
    kgRrvfC5vsnPlgnMuzYTbMb7dh9WdP6V44k0EgyfU5Xb+f6dfLabOfttfldczYaw
    iv3zNtRCoGOGx8UceSP+WT0QU3NpSjiY63SJPNYuVESJK3TJul7vGpbNZQrsfPDZ
    R/Ifk14B7BJK3lQfysMpBCgf/dPW1uB2bTfT/WG+eYHNfsgO5V10zIpWEY/At3+Y
    hRE4JwCkvyo603vGl0IysXvmr7sklYeJ4lsJjLpg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=mKWhYW+1 x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=mKWhYW+1 x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPMZs97QQz2acodP7li6r3NveAbK6fAqySLuBAqcwIsgMK+EY/MTkXnT9NjE7nnkFprCmdYMEHqc4t2ZSiwZI7XF+IgVxmRfx/tHklKxHkfzDzxbT/Ld
    9nK3RY7iaQRubnhQbybVdpnGrOrr/JGeq8I7zBk5JJYHB76/FvQOcRotBCkqJE0kkw4H7IyosZrj79k7can8X7ircrmNRbwVRN3blOqsdgOnUWTRxyMFRg1u
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=ag1SF4gXAAAA:8 a=C7OFwyuGYqsuo0XBkyEA:9
    a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbeEUVgQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932457AbeEUVZe (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:25:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 080/110] seccomp: Enable speculation flaw mitigations
Date: Mon, 21 May 2018 23:12:17 +0200
Message-Id: <20180521210513.359362358@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

commit 5c3070890d06ff82eecb808d02d2ca39169533ef upstream

When speculation flaw mitigations are opt-in (via prctl), using seccomp
will automatically opt-in to these protections, since using seccomp
indicates at least some level of sandboxing is desired.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/seccomp.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -19,6 +19,8 @@
 #include <linux/compat.h>
 #include <linux/coredump.h>
 #include <linux/kmemleak.h>
+#include <linux/nospec.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/seccomp.h>
@@ -227,6 +229,19 @@ static inline bool seccomp_may_assign_mo
 	return true;
 }
 
+/*
+ * If a given speculation mitigation is opt-in (prctl()-controlled),
+ * select it, by disabling speculation (enabling mitigation).
+ */
+static inline void spec_mitigate(struct task_struct *task,
+				 unsigned long which)
+{
+	int state = arch_prctl_spec_ctrl_get(task, which);
+
+	if (state > 0 && (state & PR_SPEC_PRCTL))
+		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_DISABLE);
+}
+
 static inline void seccomp_assign_mode(struct task_struct *task,
 				       unsigned long seccomp_mode)
 {
@@ -238,6 +253,8 @@ static inline void seccomp_assign_mode(s
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
+	/* Assume seccomp processes want speculation flaw mitigation. */
+	spec_mitigate(task, PR_SPEC_STORE_BYPASS);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 
