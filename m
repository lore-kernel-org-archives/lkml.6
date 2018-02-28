Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839634-2-4517764752476904058
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
    t=1519839633; b=nLZ7GjjdFU6l2ix38/xNTJQOf8q8i8zk/9x+/tKZlPbJrkK
    Q1c+Of/ecAlPvEt54rw8iy0PYRq4/SPOw84tUQNYIyraFjt3Pj5nX9aUpwN/uxoh
    JLX9qEcLT0cZWSGnVW+RB+tgdMLeDtlw2M7v+8GX5V8N5YegG+p/o7m4WYfNFO1d
    WEQejYQtCkIXVTSxIy1UvZCae1prOWlaggDj6GXvvJanMh5WsKTipOE36++CtsDx
    CrPzhWZUjd1y6lVDeXiopwzbvFq8x7/aXiJ9epLQ7lBDbQDzcTTetpafGlIhS9ET
    y6eHp607qPewZqSipmqgQ3DBbUITedtaUvO0vTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839633; bh=jJ3LZNSJ6nyY9MON/LQ
    9vBoWnoM6mFaQVzKBRvzfcpY=; b=iEOcA85eGG/mEACmKR0N5Enbq+BQbSbWHPL
    SZ1Vj/U7Ikpq7vTVce1RMGN+eJElMnHRoNp15ST9Qsi6j3gSkfOTFJv6GPqF1tWt
    hCXPMG0sXrvBad8wXoIt6MKHMVEWygHyZAVkknY6Xc3V2zR0zflkLXgdu01vlGVD
    ok3HpgObSlF5QHRiPFUS2Ul93RoSjpDuxXlV39CYEJ+j8urgRq52IhZ+U0HJOOGi
    p2tP7YmuEa+/a0lm8yQ9eh2XwEiYB6o/hr03CEx9HyLIvgivOKmC9a7NmnBkii6J
    Nq3okUpd5IMcyPilDxUMbyAI9bt00g15Ymw1vn5Zc8TmJkc3o1Q==
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
        id S932474AbeB1Rjo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:39:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33160 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932530AbeB1PWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Borislav Petkov" <bp@alien8.de>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.384042005@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 112/140] x86/mce: Make machine check speculation protected
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 6f41c34d69eb005e7848716bbcafc979b35037d5 upstream.

The machine check idtentry uses an indirect branch directly from the low
level code. This evades the speculation protection.

Replace it by a direct call into C code and issue the indirect call there
so the compiler can apply the proper speculation protection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by:Borislav Petkov <bp@alien8.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Niced-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/alpine.DEB.2.20.1801181626290.1847@nanos
[bwh: Backported to 3.2:
 - Don't use dotraplinkage
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/traps.h     | 1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 5 +++++
 arch/x86/kernel/entry_64.S       | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -69,6 +69,7 @@ dotraplinkage void do_simd_coprocessor_e
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *, long);
 #endif
+void do_mce(struct pt_regs *, long);
 
 static inline int get_si_code(unsigned long condition)
 {
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1407,6 +1407,11 @@ static void unexpected_machine_check(str
 void (*machine_check_vector)(struct pt_regs *, long error_code) =
 						unexpected_machine_check;
 
+void do_mce(struct pt_regs *regs, long error_code)
+{
+	machine_check_vector(regs, error_code);
+}
+
 /*
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off:
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1399,7 +1399,7 @@ errorentry page_fault do_page_fault
 errorentry async_page_fault do_async_page_fault
 #endif
 #ifdef CONFIG_X86_MCE
-paranoidzeroentry machine_check *machine_check_vector(%rip)
+paranoidzeroentry machine_check do_mce
 #endif
 
 	/*
