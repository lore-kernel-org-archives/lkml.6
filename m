Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164227-2-15848319570044917156
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164227; b=lWTqkoSA6rfKCnNoqE83PTDjunHalQgHKCKtaXs5z/e5MGRFI4
    Xv5HLZkObYnolHz7+wvSg7e8sq97G1yxO7rvHoXQiuJO0pvWvQm4oz4KylUKbKeZ
    /VECJRZTc7mKX9ImpoK40R0Af1+RwQDYZFSY2ZAyEYG0HCsyiULWW+G2a7SnJhwK
    TP/W1jMAyhuW3AXrCsJPbr9HHgD8VoK2ocltJY96Y/MGlTFUGTBrWynCppMTY7xt
    sm2fnpc9KfLBcwrVtQS5/80p7lSoqvR6N3xWaNwPmLeV4Yo7BBvxqfBBiOIdhYI2
    cGBd8ytUwCXKwBg56bm8C4BGWiVmKX1C1wgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164227; bh=IfRD0iZvyXJyo24MfVQ/HF5Zz38RYV
    KvjUL82k0AOOU=; b=N79Pg8939ndukl41wWuWP9Tw2cq9FnaMKGIjqNLzKNXliv
    th6VG4BTTv3MyTBbT1+9mWo3mnwABmuKtVKy8jjbUmJxsKD0xFEscSBmor9mN1CF
    eyUr2Mg2iMvFFGmLQK12mQ8FhbdEZVjWtni331LqXjNGiD7c7X/a0Lub1m5f6HZe
    9/fV4DFJZGB2aDvDhEgFLCdRCaAkc8QQ4NB4tDQZlOTqlNXMJ5n0TagUwmn42vYV
    ANaw0Hjg6qA8/RmQF4JeBcWcGYBm7fKM7F29TBl0xmOXS7jWOlv6xwfL0MOc5K2y
    OzKGDtRPkptVcUw4gw99Vmfvqnk+AvtXIk17ETdA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NCmcywyA x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=NCmcywyA x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfANFnG/+6eSD45g7GO13YM9HVdBfRCSIBMyDA4Ls9EF6UX83ygaGXxPHoWRDwkpxlsaHV28rmISqbd6KBpoXbhxteCELgXTHMqreFzWLiCz9yfSGWPol
    Xek22RkakeF8Zw707oKQ6LH39pKGTQoxcA+QK4QrMBd2bC3fthABctoq5IAn7XHMnw44e7l/7TItqRzuxKNtqxzwqvff5ppZQOj27FVqcD51aZY/mWHnzWLA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=ag1SF4gXAAAA:8 a=1xjQt4pIUNXleNVYppwA:9
    a=FOFD_0Mp1XFBZlU-:21 a=mxM1O23oZlYCg8nu:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966417AbeEXMQm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966216AbeEXJl7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 3.18 35/45] ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
Date: Thu, 24 May 2018 11:38:43 +0200
Message-Id: <20180524093125.189371405@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit eb0146daefdde65665b7f076fbff7b49dade95b9 upstream.

Prohibit kprobes on do_undefinstr because kprobes on
arm is implemented by undefined instruction. This means
if we probe do_undefinstr(), it can cause infinit
recursive exception.

Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kernel/traps.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kdebug.h>
+#include <linux/kprobes.h>
 #include <linux/module.h>
 #include <linux/kexec.h>
 #include <linux/bug.h>
@@ -395,7 +396,8 @@ void unregister_undef_hook(struct undef_
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
 
-static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
+static nokprobe_inline
+int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 {
 	struct undef_hook *hook;
 	unsigned long flags;
@@ -468,6 +470,7 @@ die_sig:
 
 	arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
 }
+NOKPROBE_SYMBOL(do_undefinstr)
 
 /*
  * Handle FIQ similarly to NMI on x86 systems.
