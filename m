Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452161-2-18299169017145724324
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452161; b=G3ELudTtK14ozbQmXOgw/3uBu38rAhOFOS9IGrK5UTgEYQh
    4IMfIq9GfpE/Dlr+9Anw/xVTlCo2wZX8tFg1Mga+f2OmdeJFxTnKiSUCupdlO4OO
    qKTJBwFVbm3H89tNmf6bsG0gN5NRUKxQ490ePz7d1YADSaGOYqUUQhNfKi4aOkWK
    wPMn0CKUnlcNbuZprT0k8+NDNUmuAZSRW/Sz17P8VDAkXbs5HpCgT2EzF+wSSw2h
    rCwyX+TmrmyB+mXu4KhSCl3hycYcs5cJYxO6OeMzKFLAv3hTmcgJsRKGiZUO17O7
    +n3EWJf1Jo1LnXCqDCCoHIyLbSFcK+Eqt+Lvmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452161; bh=dEFlMm1xB/uMZZyDlqyEGztfIQ
    XebBF61TkOS022MKY=; b=HEUwhXihAHKVYlJbqBcbKCBF81t/UMz+34xgQD11mA
    sCmYG6k6bKjSLS525HxKLFEGiyhPCKG2HUvsI+scXWdZAx7Mix1LL4mNtYYlFWuJ
    t3usYrfJu8IxGoWA4BKy3MZwgVG+pqk+Zj0+4OPj/hAxNti38SaxcZwsNI582/jB
    LvQbd1Lhr1EDLYDvNgPUU0Msk7Cf81yAVO3X2707D4U75yGPyr3Uizk8etRPTIGr
    ixWLk0BliqZZbR/TiChbJxHVrl0lMOMtW+bwKGcCV0taPo3JL8qO+BowpDh/2Iia
    CGwEOHJs/gAwe/01tYxOIu10X7OQvIDkIlAA2UAHbiIQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935073AbeCGTsd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:48:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965954AbeCGTs2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:48:28 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 4.14 095/110] ARM: kvm: fix building with gcc-8
Date: Wed,  7 Mar 2018 11:39:18 -0800
Message-Id: <20180307191052.008235354@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 67870eb1204223598ea6d8a4467b482e9f5875b5 upstream.

In banked-sr.c, we use a top-level '__asm__(".arch_extension virt")'
statement to allow compilation of a multi-CPU kernel for ARMv6
and older ARMv7-A that don't normally support access to the banked
registers.

This is considered to be a programming error by the gcc developers
and will no longer work in gcc-8, where we now get a build error:

/tmp/cc4Qy7GR.s:34: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_usr'
/tmp/cc4Qy7GR.s:41: Error: Banked registers are not available with this architecture. -- `mrs r3,ELR_hyp'
/tmp/cc4Qy7GR.s:55: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_svc'
/tmp/cc4Qy7GR.s:62: Error: Banked registers are not available with this architecture. -- `mrs r3,LR_svc'
/tmp/cc4Qy7GR.s:69: Error: Banked registers are not available with this architecture. -- `mrs r3,SPSR_svc'
/tmp/cc4Qy7GR.s:76: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_abt'

Passign the '-march-armv7ve' flag to gcc works, and is ok here, because
we know the functions won't ever be called on pre-ARMv7VE machines.
Unfortunately, older compiler versions (4.8 and earlier) do not understand
that flag, so we still need to keep the asm around.

Backporting to stable kernels (4.6+) is needed to allow those to be built
with future compilers as well.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84129
Fixes: 33280b4cd1dc ("ARM: KVM: Add banked registers save/restore")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/kvm/hyp/Makefile    |    5 +++++
 arch/arm/kvm/hyp/banked-sr.c |    4 ++++
 2 files changed, 9 insertions(+)

--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -7,6 +7,8 @@ ccflags-y += -fno-stack-protector -DDISA
 
 KVM=../../../../virt/kvm
 
+CFLAGS_ARMV7VE		   :=$(call cc-option, -march=armv7ve)
+
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
@@ -15,7 +17,10 @@ obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
 obj-$(CONFIG_KVM_ARM_HOST) += cp15-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += vfp.o
 obj-$(CONFIG_KVM_ARM_HOST) += banked-sr.o
+CFLAGS_banked-sr.o	   += $(CFLAGS_ARMV7VE)
+
 obj-$(CONFIG_KVM_ARM_HOST) += entry.o
 obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
 obj-$(CONFIG_KVM_ARM_HOST) += switch.o
+CFLAGS_switch.o		   += $(CFLAGS_ARMV7VE)
 obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
--- a/arch/arm/kvm/hyp/banked-sr.c
+++ b/arch/arm/kvm/hyp/banked-sr.c
@@ -20,6 +20,10 @@
 
 #include <asm/kvm_hyp.h>
 
+/*
+ * gcc before 4.9 doesn't understand -march=armv7ve, so we have to
+ * trick the assembler.
+ */
 __asm__(".arch_extension     virt");
 
 void __hyp_text __banked_save_state(struct kvm_cpu_context *ctxt)
