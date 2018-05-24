Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163110-2-7366912625724554211
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
    1527163109; b=aRS4wfSfZiQlPYzUxRUQ1UGQk5t9aJUHw3QQ4a6Itw6xwYjG67
    1WBcbJuajE6UJZnZojfkYvcwhPj8t4t4SVFMeDlMBeKopo/05hF41KXZj/A0Vmb1
    7gjxBHRMcff+qOe+CtbMwPeY14SUuLAEMugMWpG5dCEEIjKuIDo8ZkzpeWLNNiaf
    2MzqGgyedZX2QxiC1cOmsV0nORUjNwxZJRSowPM/8M/O7I8trIGsR/cI3moPt51F
    +R3p/p8dtEKYjRawgb0yOZ/jxES1E3cZBDJS/tjjUvQ+RPcPrpiQjKMZUUYOHnsi
    UvXgpchpjOc5OVAJrc95lMHRjVsjjWmXnF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163109; bh=YlLipN0Yi+DJFH1+JRKIZKaxVPFh+M
    ATdheMJjI7FNo=; b=cj5vJvmx8gqxoAOpIFXGtkBgoQbbUpi272dv1DAQ0TFNyF
    o6BV2vifJsSbrbWhfOw7mVWDBmBt5APBBDmaSMNen1ViH6GVlQM4RRSNU3FmG7qm
    ze0RjYpORpGLJlBaXY2zFhyG8yCLBVhrzURa6XqM5rNeFGaMGhZqpD/z6kjAWlyY
    JBU+7wmBTyKK+EFfZ/Al/Da/tE3vC9J8HsMNbnQdxmj4S3lv3OdNMEtGNEa98jfA
    YKuhvsKE+j9M5cdP2YWw30z0BvjEFp61nER1xxXE6MT6C4ZvO0BkfLWMN/yF2jlk
    zxVS/M+1/OyDtUTgp0wLG6VZc+vztya2G74CUYQA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=QuUsiulJ x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=QuUsiulJ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOMXszSmhgw4hCG0TRctfs/4UhyWeN3U4oLiw0j4FRIr61ZqZxMXMHX8C/n/P83cw2v0BSY0uZLExO4Gr+2Tom9BWYlBOBod+/ghTmv50vBDNjt3lHRX
    9gbxVJEPbElqtZUTu1FXbDkf/VnzvJMjeAZTG14YwBZt7fGep/tI2W6P/BcKaxKblEBjk7BjuQYdDqTR70D5yJpqQQMNEt5RbbmgbXth6P4udPRPCPPZ67BN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=ag1SF4gXAAAA:8 a=1xjQt4pIUNXleNVYppwA:9
    a=IZTnPKTQGXmHhBqz:21 a=mxM1O23oZlYCg8nu:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966507AbeEXJpZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966782AbeEXJpY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.4 63/92] ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
Date: Thu, 24 May 2018 11:38:40 +0200
Message-Id: <20180524093205.395164167@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
