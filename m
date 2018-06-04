Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1780358-1528127889-2-9437482914668037584
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528127888; b=B2rwjr//OA/qrSW5YkZaT/3+GNxuYJtyiNsYIrYOwDaOatTYD8
    KLkJTtlJW40etczxcLoIzsuzUHMpt4KP1SmuV3LUtBRNj2eIQDnn7EkZ2RAV/dDr
    oMqweVPWvjU1SPQsJqkb5UlGK+ydUbTNAVgR+FxMLzS4wTvNu0M4SedMXXERNaEg
    hw1Ae/M1ZzwsWF8nWTMCBfI9wuRiHbHNN+m25VJ/9hTwDjYPNUdGNHk+b7GUZt06
    znTuW1APQELahSR7tUdS/Acun8+0pUVsrgeuWn3P7JiE8t1KfQbj51kniUE0pH4E
    NIU4mIMFdC6fOvmnK9gMTgDvbzhfGvjE/Zzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1528127888;
    bh=ZGEVW7mzisdEcrpptg6xlRI3FQhvzUnwXvIOQMyccBw=; b=Dl3dOEO6t0LU
    gFZS+9K173j56ERXD18n/KyW4XIox/siGmG1Xmdj/xuEn7lWvhqlYN1jbL8v2P5U
    B496UwSsUEydHluioOiaNshvYowskuFB/02HaBImAzbr85nkCNnFm2VmsjNiWI95
    3GB67dWz3MuvEwHqBkSLvGsxgV68DX2apDdX7H9Vw1e7dnNpF9BkqIO/4XMyKV3x
    pLbvXXjBBZBO/QU6lBGs67UlslerwplyftpMSzLCBX/nzvZeYT6Kvfa7olPqw8RK
    YO4Eq164U84A2mYIKpraSJQETd9JWdNNfZApWtBHSgxBp3nSkO9YjnnptQXajPSW
    NTYCHByUgQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=z8ogcL05 header.a=rsa-sha256
    header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=z8ogcL05 header.a=rsa-sha256
      header.s=default x-bits=1024;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKu0kNJrM/6s6AqC+PjOfyfyIDEqaz7IZngm8bx2uSAGQ400iNuWrAKc7Gwzpp02mU9Zz9UH5r5nPXjIC33JM4ojSJZsrpftcFtGb0y1grbwvzmvrN+X
    apOMCBYaRIna5ctENhAA+OBsLlTiP1QwnNzLn5eZgJP20J39+tYcZPKLqhTtnzH4GbAUuoUljLmF+g6PVDtLpcJW3DSdu242lEb/lSuFVm1bgKLV0xmJssQG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=vQqmB3E4GQfW7Bs5r6wA:9
    a=aigzTBwpMLBe8ycc:21 a=8-xcBjv8x79O3ZvQ:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeFDP6H (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 11:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbeFDP6H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:58:07 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [RFC PATCH -tip v5 19/27] ia64: kprobes: Don't call the ->break_handler() in ia64 kprobes code
Date: Tue,  5 Jun 2018 00:57:43 +0900
Message-Id: <152812786284.10068.6480042015375560025.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Don't call the ->break_handler() from the ia64 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/uapi/asm/break.h |    1 -
 arch/ia64/kernel/kprobes.c         |   10 ----------
 2 files changed, 11 deletions(-)

diff --git a/arch/ia64/include/uapi/asm/break.h b/arch/ia64/include/uapi/asm/break.h
index 5d742bcb0018..4ca110f0a94b 100644
--- a/arch/ia64/include/uapi/asm/break.h
+++ b/arch/ia64/include/uapi/asm/break.h
@@ -14,7 +14,6 @@
  */
 #define __IA64_BREAK_KDB		0x80100
 #define __IA64_BREAK_KPROBE		0x81000 /* .. 0x81fff */
-#define __IA64_BREAK_JPROBE		0x82000
 
 /*
  * OS-specific break numbers:
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 823e4bd03a18..74c8524e6309 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -817,14 +817,6 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 			prepare_ss(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
-		} else if (args->err == __IA64_BREAK_JPROBE) {
-			/*
-			 * jprobe instrumented function just completed
-			 */
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				goto ss_probe;
-			}
 		} else if (!is_ia64_break_inst(regs)) {
 			/* The breakpoint instruction was removed by
 			 * another cpu right after we hit, no further
@@ -867,7 +859,6 @@ static int __kprobes pre_kprobes_handler(struct die_args *args)
 		 */
 		return 1;
 
-ss_probe:
 #if !defined(CONFIG_PREEMPT)
 	if (p->ainsn.inst_flag == INST_FLAG_BOOSTABLE && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
@@ -990,7 +981,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	case DIE_BREAK:
 		/* err is break number from ia64_bad_break() */
 		if ((args->err >> 12) == (__IA64_BREAK_KPROBE >> 12)
-			|| args->err == __IA64_BREAK_JPROBE
 			|| args->err == 0)
 			if (pre_kprobes_handler(args))
 				ret = NOTIFY_STOP;
