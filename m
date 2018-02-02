Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2700043-1517584120-2-5176232773880124215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517584119; b=SQoixYosxu+NjTezUpgatapZB5JUUqWbWBlyWr0f30K2qia
    NvddIv4MXQQIw59q+DFlPbTXvMusjTkpvoV+Hj3sd8TP7CeoIXYjAkousd2hhNg9
    w6qZQWi9zlMcUPb8TRQng/QSZcIGBCUC2wPS2cmJefYwpFmR4IrDmeaxoUQyPA2I
    acEASTggXsFh9Y3FvCPpDOC7ODiW2ywnFL9KITtdoCo2sEM81bssrIRvV/9qdX5k
    LeONKYsAN2qJagFYZsSH9+bMoutbjxXVk0db41jW4VlOLqkj87Zm3/6KSwjcZ+Xj
    U2fmttYYfPjQ7SA18vhGwKdTRZ8nK7DMMUwvveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517584119; bh=lhEDRQzORAjpcpPMO1ZA9uyYJf
    1mZbt+2dgjBYa2ypk=; b=E3aYAA7Qi6mERC4JCOzzpXyCJFFhd5sx6VXEKrRWSg
    DvG6N8NwmDnPW8Z014JBoBZXxN6y7gn1QrAUu72Ww4MuZNgIc9qOc38iRWv/NY7f
    nvh/cgg0K2TAzwSZ/w75fy26bNFsw8f/3Ekiduz8UVCOj3D0lyv63tjc/ouY18qv
    6XXTrEgEE6Qao5QH0zkFDH1XipqBo/KHiGE3/QQRJThet9HiPRZXUW49EDlZY9RZ
    pxQB6fs36Hjbj9Yu6+Sc1r1+a5Emp7OsUtn8j3+hnCspFctyNJuB8K8YNnBi3M9u
    ehFyMgr5dZeLg4JGqCT+QoYiNfmqnkkBRtBsSXDGnYuQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBBPIh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 10:08:37 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60954 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeBBPIg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 10:08:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: kvm: fix building with gcc-8
Date: Fri,  2 Feb 2018 16:07:34 +0100
Message-Id: <20180202150756.420422-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:o/lYdJ8CK5Cdort1B65GHmoSABFadVtvLpeBaWFOXYpGGZduw0U
 m3w0mlD7RgxnezE/HTE0dRPeYFrKHktJ07GuRaPhouISKHyw8Y+DO+3LyM+MoBLF3Q262ys
 CPobY1+gNnC6EgcdAN6K2uZLp0K7GDbEr7ZscXEkIwONoxlZ0Ms6vuYRYt0lqBdIGXZCAhS
 vhPsPlD9ZCKT6CGLmQP1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nVwlNOozFt8=:hbp/wV5Nc+uHQzRoTPdvLR
 OLakWvyJUYCKegRDPhsv8t98X/hbAqMUGtG5dwLpjskxoD5muTjUIlgMtvrznjSJn0VR4e18g
 TXPc7G6fxodbS2g8P52rHwc8WL3S5VHWc8Vf6MAbsUiwECuO0uqqH3+Whcn84IijoEG41JmOe
 0q87bqlvjY15sKzx83egn+dUMv3c0HjKyA/EADkdbcqj1oRM+ffp+o42yak05dA1D3BCgriL6
 0a/UC45FUdxj15Y4ycIA69TxgDbWulLiDvw+4GakmbPDcQ04TRggBD9N9ZCyzwVJfYDxi0f6Y
 qS7SRIvLcWuTziWwYPf/0sL1qNnh50VAcZu8ZENkKD13fCAgy5YFCK6DIREcjkcHGFMRcbCmZ
 82Li05J2XI9Bi73raDXJVsqiZBLx6Do6ZK28/5p5OzMsEbFbCe54Ipu+nMqpFUgriYIxJxK2s
 c946XDyCU7W1XmjIrQjcJ+jv9x6vN7Wa3gVsvfj3Q2v12mfzBg5U+9ufacN2U/K6iEviq24zu
 3VVKhyKil/Fd85/6b9urVLahTs+/kq9P/UYFYIOsMSgd7VbnsIcQ0u4AhXPF06qvAzmHh92IB
 GMzcofJljEdZ2+Eg6jrQNJeMhQQlv/xqYEV8gmL3gVbA/1I80b17GU4bTAR/s5GKS/7cCbN+Z
 iuYzcf1bPi64sXZ0rBuwFP8MTudo1729EqmQKQVoxj9aixe3/y+zhPWSwr5N//RihezjTwkQ5
 0bZhJ6hBs/O3Iy/ywIPOa/LkENpM/rcqruu69A==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 arch/arm/kvm/hyp/Makefile    | 5 +++++
 arch/arm/kvm/hyp/banked-sr.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
index 5638ce0c9524..63d6b404d88e 100644
--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -7,6 +7,8 @@ ccflags-y += -fno-stack-protector -DDISABLE_BRANCH_PROFILING
 
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
diff --git a/arch/arm/kvm/hyp/banked-sr.c b/arch/arm/kvm/hyp/banked-sr.c
index 111bda8cdebd..be4b8b0a40ad 100644
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
-- 
2.9.0
