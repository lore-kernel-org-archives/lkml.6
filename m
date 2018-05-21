Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937470-2-439723823608705532
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
    1526937469; b=gSrgG7KBWJOBAGQMkWBCiGU+NKN7s067hAQmpfV0HEov+ZyR1L
    8OtTQWWKL4eH0VopbuYFk6hPqJTH7QmLoRGvbVfr8RIOjg5eGAmjgt7c77WZXiAS
    P2hhFSjouIiT+YOa1NnoTElXzotAwk8Cuejopbste/rIFIzYscN19A0zCgQQas7Q
    iOcJgxJDFa7OZqChpzdPcn4ihJvuM4ml80Dzg9qy5Xlwo2Y+tBwIXcZHMMj95Ya3
    0QcgJI1bbEU0/yBoUqC02CVfCEmdRec2pTakcfHs0144qW5jDDk+qkK4+HC8ml68
    IK5lmabgghbrOji+N4G4nrrVGAp2ThdVe7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937469; bh=xaAhbRKWVu3cn5mtREBaB1e8yp5hLA
    /sEdu6RzwZfR0=; b=bmyw6Yv+lNO9vjxVeCEq7/bSFCNaqXa+aPgGMj1S+VtV7j
    r/YuRncB57LyuUSV3WiLSudyi+gftN4Ku9XELCP+sefIx6Wr5U/rT7/ueaCE1qG7
    0UnCbXW6IxT8rBU3NIS0mcTl2Y1nZn3d0RZk/pl3U9MPJfiTl8C49y+Bd2oRCZQj
    tlC86eDUXAYM1lMlJy2DVTYXbbZvaM5t8wkcYJ8q+I/qFbmxRURbmdXwh62vkj67
    ClWO6y6YdPcTioplAH9gISRI9tijnY3zUAOlKpnA6dPnWzQ0VAG/eEnsdplVov1M
    yJk5vAwLNhxFy0B+cYAYsMuG5C2r6Iq3LoI0QsMQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=k61raiD4 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=k61raiD4 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOmtJTFTJxPVoNwDs8JRMxuJWTtDSA6T5DHpwp7DQNsUphbUuWtcqmbwf7QuBNRW11nY1J4AbFuSJUJqQH3fS7wzRK9cQPLTIY2oHG/yiHqfsmE5dqqk
    Ps9e5Is19XSedzcIvrtTCNPKFqyIT8CeDU7PyWCN+czTlPQwmv2M73DlmQKV5IMUVFnlHB2FKkaa2HQH1Ylx+jTuMSKbR/Ak2JbTmLLMmae13Pz3P9j1Z4gs
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=cm27Pg_UAAAA:8 a=pBOR-ozoAAAA:8 a=ag1SF4gXAAAA:8 a=C7OFwyuGYqsuo0XBkyEA:9
    a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeEUVRp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbeEUVRl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:17:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 57/87] seccomp: Enable speculation flaw mitigations
Date: Mon, 21 May 2018 23:11:33 +0200
Message-Id: <20180521210425.352522928@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 5c3070890d06ff82eecb808d02d2ca39169533ef upstream

When speculation flaw mitigations are opt-in (via prctl), using seccomp
will automatically opt-in to these protections, since using seccomp
indicates at least some level of sandboxing is desired.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/seccomp.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -16,6 +16,8 @@
 #include <linux/atomic.h>
 #include <linux/audit.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/seccomp.h>
 #include <linux/slab.h>
@@ -214,6 +216,19 @@ static inline bool seccomp_may_assign_mo
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
@@ -225,6 +240,8 @@ static inline void seccomp_assign_mode(s
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
+	/* Assume seccomp processes want speculation flaw mitigation. */
+	spec_mitigate(task, PR_SPEC_STORE_BYPASS);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 
