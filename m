Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19E7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84B320660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/pqpdTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84B320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeK1Wo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:44:28 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54184 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeK1Wo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:44:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so2261270wmi.3;
        Wed, 28 Nov 2018 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=YOK/0lVWXtXIWzf6VLlUPnU6BdVoB6fu0nWcPY2YNB8=;
        b=G/pqpdTezLWeis/6JbEJqoy4PnW6eC7eaRknsOpB+TLtu6RNGbsRS6ofvajiLly0qt
         qzx0AkYiTCQjfEaQrTGfUeQhGqUcW6WsQMXrU2KhylgPtyamF6/+fRwatHrHtqvJREG6
         P0YecCWA71dBzKD7twPbZEW4RsP2ac7rtz/+t/CczD8rsJdxVAhTWd/jImJE9QMp0lK2
         1TtAY7jN7pne8UU8o8uYqdN2Ysyi6F495OvtVgNFZZEuUUfBY4Q6tFWEgaKEOUVyG9nW
         QxDYil9TGt5SUvk9ikdVCmqAdcIYxfbzRhQ4m+E5s4mYZZTvDkr22vL39TmyMUi6SENi
         35Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references;
        bh=YOK/0lVWXtXIWzf6VLlUPnU6BdVoB6fu0nWcPY2YNB8=;
        b=K60hAuNWi2vRCpZhpV2q1I63vfPdgBSwPee/uwtAu9GNvZoMzFvGKE5aff/F86ooVS
         /qLF0qx02k4bfQWpKb0623DK/iFLSeZ4syd7qHkVM4xeZys9XiaMFos4b/r0oSiRd8hS
         QkaMEkBtWO5bVff3m2gixSVitREber36vjs+IkidrQQ6VlM3X1CrcglZn0nQ3Twp3/w+
         72VGJRGz1sq3JJfqUFA67Bwn4BL6z/KoQatwK3NsSI5a+72eaeLbB1jINuv8YneRw4LE
         k1ctfl5vX3pkP65daoF1fn835lclUl0auw5xriAchsiBRk7km0hMyGEPxceObbYFvdL5
         rkHA==
X-Gm-Message-State: AA+aEWYUo0o2smhCfv8a4mWaoRGLN1J9/F0xacN6Aawk6m/EXJCZh6t+
        slCTRlVDky1lB9k/TpgY8lbkjGSU
X-Google-Smtp-Source: AFSGD/VFFaWux8m5o5z9XMIaHWJYRH9w4NdCtPVi6+L46e/0aWA8a8nQLcsWkmuxeoqf0NFUtfdx/g==
X-Received: by 2002:a1c:1c88:: with SMTP id c130-v6mr2427861wmc.115.1543405382592;
        Wed, 28 Nov 2018 03:43:02 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id k19sm7061740wre.5.2018.11.28.03.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 03:43:02 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 1/3] kvm: make KVM_CAP_ENABLE_CAP_VM architecture agnostic
Date:   Wed, 28 Nov 2018 12:42:57 +0100
Message-Id: <1543405379-21910-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1543405379-21910-1-git-send-email-pbonzini@redhat.com>
References: <1543405379-21910-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first such capability to be handled in virt/kvm/ will be manual
dirty page reprotection.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virtual/kvm/api.txt | 13 +++++++++----
 arch/powerpc/kvm/powerpc.c        | 14 ++------------
 arch/s390/kvm/kvm-s390.c          | 11 +----------
 arch/x86/kvm/x86.c                | 14 ++------------
 include/linux/kvm_host.h          |  2 ++
 virt/kvm/kvm_main.c               | 25 +++++++++++++++++++++++++
 6 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index cd209f7730af..1071c10cf1c7 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1129,10 +1129,15 @@ documentation when it pops into existence).
 
 4.37 KVM_ENABLE_CAP
 
-Capability: KVM_CAP_ENABLE_CAP, KVM_CAP_ENABLE_CAP_VM
-Architectures: x86 (only KVM_CAP_ENABLE_CAP_VM),
-	       mips (only KVM_CAP_ENABLE_CAP), ppc, s390
-Type: vcpu ioctl, vm ioctl (with KVM_CAP_ENABLE_CAP_VM)
+Capability: KVM_CAP_ENABLE_CAP
+Architectures: mips, ppc, s390
+Type: vcpu ioctl
+Parameters: struct kvm_enable_cap (in)
+Returns: 0 on success; -1 on error
+
+Capability: KVM_CAP_ENABLE_CAP_VM
+Architectures: all
+Type: vcpu ioctl
 Parameters: struct kvm_enable_cap (in)
 Returns: 0 on success; -1 on error
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2869a299c4ed..b1ed31a17a8c 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -518,7 +518,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PPC_UNSET_IRQ:
 	case KVM_CAP_PPC_IRQ_LEVEL:
 	case KVM_CAP_ENABLE_CAP:
-	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
@@ -2084,8 +2083,8 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 }
 
 
-static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
-				   struct kvm_enable_cap *cap)
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+			    struct kvm_enable_cap *cap)
 {
 	int r;
 
@@ -2273,15 +2272,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		break;
 	}
-	case KVM_ENABLE_CAP:
-	{
-		struct kvm_enable_cap cap;
-		r = -EFAULT;
-		if (copy_from_user(&cap, argp, sizeof(cap)))
-			goto out;
-		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
-		break;
-	}
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	case KVM_CREATE_SPAPR_TCE_64: {
 		struct kvm_create_spapr_tce_64 create_tce_64;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fe24150ff666..16c300bdf2c8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -464,7 +464,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_CSS_SUPPORT:
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
-	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_S390_IRQCHIP:
 	case KVM_CAP_VM_ATTRIBUTES:
 	case KVM_CAP_MP_STATE:
@@ -607,7 +606,7 @@ static void icpt_operexc_on_all_vcpus(struct kvm *kvm)
 	}
 }
 
-static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 {
 	int r;
 
@@ -1933,14 +1932,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_s390_inject_vm(kvm, &s390int);
 		break;
 	}
-	case KVM_ENABLE_CAP: {
-		struct kvm_enable_cap cap;
-		r = -EFAULT;
-		if (copy_from_user(&cap, argp, sizeof(cap)))
-			break;
-		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
-		break;
-	}
 	case KVM_CREATE_IRQCHIP: {
 		struct kvm_irq_routing_entry routing;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d02937760c3b..714c5eb0c3bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3008,7 +3008,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_TIME:
 	case KVM_CAP_IOAPIC_POLARITY_IGNORED:
 	case KVM_CAP_TSC_DEADLINE_TIMER:
-	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_DISABLE_QUIRKS:
 	case KVM_CAP_SET_BOOT_CPU_ID:
  	case KVM_CAP_SPLIT_IRQCHIP:
@@ -4431,8 +4430,8 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 	return 0;
 }
 
-static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
-				   struct kvm_enable_cap *cap)
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+			    struct kvm_enable_cap *cap)
 {
 	int r;
 
@@ -4765,15 +4764,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
-	case KVM_ENABLE_CAP: {
-		struct kvm_enable_cap cap;
-
-		r = -EFAULT;
-		if (copy_from_user(&cap, argp, sizeof(cap)))
-			goto out;
-		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
-		break;
-	}
 	case KVM_MEMORY_ENCRYPT_OP: {
 		r = -ENOTTY;
 		if (kvm_x86_ops->mem_enc_op)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c926698040e0..54cc06dd7e6c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -765,6 +765,8 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 			bool line_status);
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+			    struct kvm_enable_cap *cap);
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e476b6c3..1d6b77162d7c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2948,6 +2948,7 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #endif
 	case KVM_CAP_IOEVENTFD_ANY_LENGTH:
 	case KVM_CAP_CHECK_EXTENSION_VM:
+	case KVM_CAP_ENABLE_CAP_VM:
 		return 1;
 #ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
@@ -2971,6 +2972,21 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	return kvm_vm_ioctl_check_extension(kvm, arg);
 }
 
+int __attribute__((weak)) kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+						  struct kvm_enable_cap *cap)
+{
+	return -EINVAL;
+}
+
+static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
+					   struct kvm_enable_cap *cap)
+{
+	switch (cap->cap) {
+	default:
+		return kvm_vm_ioctl_enable_cap(kvm, cap);
+	}
+}
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -2984,6 +3000,15 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_CREATE_VCPU:
 		r = kvm_vm_ioctl_create_vcpu(kvm, arg);
 		break;
+	case KVM_ENABLE_CAP: {
+		struct kvm_enable_cap cap;
+
+		r = -EFAULT;
+		if (copy_from_user(&cap, argp, sizeof(cap)))
+			goto out;
+		r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
+		break;
+	}
 	case KVM_SET_USER_MEMORY_REGION: {
 		struct kvm_userspace_memory_region kvm_userspace_mem;
 
-- 
1.8.3.1


