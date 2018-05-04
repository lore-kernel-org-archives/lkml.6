Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3611583-1525407384-2-1453942860213434193
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525407383; b=cYwI7+MmHfj4VU9Eqd2SF2pqGbg86K4s41AtdFLpIy1hhQA8Eq
    495JxUNSHMoP6GVEZ1ptINCDAekzvucwoh/AP1ndTitFhpoJtv6gt10ojTBmt0aX
    nOlyEkQirqrXHWtJbEveUFs712FRhvkfAspOzrC8NOR8MwH2LoOHa4wdpmJnIBG5
    nWiwR02PkqXwI/JSmoAh/hkOzyQJcqsaBG2UdGBm8uL+v9s/ZL+GxBGKt+r9uM2+
    4bfA30+SQEOMXCtO2DrTKNxstMQDF7gHgTVrgnvmw078Xsb3h4zRJhTg/Iyx07gR
    fI3yTxNTV6Idsl+IkT6Raz8K1+/Hosy43llA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525407383;
    bh=StawBZ4ozHAVRM1OdFwbZGhznIeWVZyLG961+Nck2J0=; b=NT5yRjVVg3oE
    DVXn0ZydSSCZKcNXDbrUAA+YIyh8sVYeLqtxWhX/dPUV/sb9CFNPbTbH/adayR6W
    WEC9p9OciNbDJSg3O22GG53o+HoJOODgA5z0cLGl6oBSmML5XousX/Sz8Oje08s9
    y8SET3s5+uI4yZvaUuHhoOFX9EzShsWLMgrqHYCTvXJKji17sBGhGPLZ9GDIoD8n
    jKYRmKV8aqecSnjYJeeXaRPWGwWoXCRsRp6qjinNKaZAQc25Quv61wLDqrzU0F5L
    PbJKGxMl3U1sEfUF7RWTdIsg4RSEN5IhOPsgz7sdj/Cr683J1S0XzSFB5Sz/sIWO
    rhnVayQ7Sw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=dhg1Ja08 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=dhg1Ja08 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDh/OoxABcjBU3KFptRyHL2mHVgihD3qx8OcGNWG89SArdJBJJQzB2cjr++O1UrHqxf2HNNtZT+QeW8ekWSr71lZN49bMtWhJFVcXeCciPySlAKTJ+iA
    LEatFN2LHuJqtB2NvIEVNKC+RpkunOz5jWB0bb9QTrSiMXa5nqVxeSz7g1NTVP+7nzAKPieoCsNwuLCFtAvWOl29DVlSjD6tRyRySneSH3MHI64/MrDPYV3C
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=1xjQt4pIUNXleNVYppwA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750709AbeEDEQW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 00:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDEQW (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 4 May 2018 00:16:22 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, David Long <dave.long@linaro.org>,
        stable@vger.kernel.org
Subject: [BUGFIX PATCH v3 3/4] arm: kprobes: Prohibit kprobes on do_undefinstr
Date: Fri,  4 May 2018 13:15:58 +0900
Message-Id: <152540735813.29650.10807161581632067171.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152540727123.29650.13679359124038587629.stgit@devbox>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Prohibit kprobes on do_undefinstr because kprobes on
arm is implemented by undefined instruction. This means
if we probe do_undefinstr(), it can cause infinit
recursive exception.

Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm/kernel/traps.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 5e3633c24e63..2fe87109ae46 100644
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
@@ -417,7 +418,8 @@ void unregister_undef_hook(struct undef_hook *hook)
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
 
-static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
+static nokprobe_inline
+int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 {
 	struct undef_hook *hook;
 	unsigned long flags;
@@ -490,6 +492,7 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 
 	arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
 }
+NOKPROBE_SYMBOL(do_undefinstr)
 
 /*
  * Handle FIQ similarly to NMI on x86 systems.
