Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C0F2089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icy225DU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C0F2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeGKDrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:47:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37870 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbeGKDrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:47:48 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so8531733plc.4;
        Tue, 10 Jul 2018 20:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHBChXFmazAMzVF7vpzQUl11RaUig0NOZCiA78oEdSo=;
        b=icy225DUrMKpsWhmeI/LetP1sC7J1Tfz+6kMT+7zSYW+cHuvqnDRWrlnqypm+cAZIa
         JuAfJlnd8mrnfX5oQONiiNNodacTGik90J5jTX0PUiLsrLxyBUKpSHkWSdYNF+AvWqRS
         9/E1n+wNGrb8c9lNStaYBupZzboTwt6ANxzpubcUih2zLf/TrTMp71+GpfGdDy7DkZOx
         7192QA74LI54kX2Rp9/FbTA23bzpCDhCs85PtqJXnRs3Bcr8NlfeKXNxtFABYCICatZJ
         8WPWmeP45nzbSK4keSg5FDubq0Rl1xmqGYpUWB2/PmU7TyqWDsfyTZNWmyhX1SWzQWha
         vxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHBChXFmazAMzVF7vpzQUl11RaUig0NOZCiA78oEdSo=;
        b=JfIP7imiEndY/ZH5qMIMNgvir3ZCkmLaFRjtywjUuqJHxSvWb4IOvVuuXtdvhPjPns
         2QjltZAFAks8q34lmS9jeVLTRDedwQpq6Y+y8m6oQTqSUm5vN7xp1KQ7rf+HiH+Ljb8O
         qsitmvryfsQhlJlpwm/G8nRQZKwcOaxHiXzHV2HmwGsKj4jALWBmp/uKGcpE/AafYSf+
         jimBfporNXXY/Pl3/Our8uWmLKSPwNgNCg2hUwVbuJ9IexZ2PdouP+CPxYDXPYEuwzYf
         Yn9/BznG7kLIA4f7oKFlYo7NMgS2zSWWrg29H7VL7su6qhhUxRVFHqcIwJ0b8ODOSWnj
         Mh1w==
X-Gm-Message-State: APt69E3Cv93RC1bmbFdldmfAolyVjWRETx/X0RwUpj0kXs5/UGPU2ByC
        Udq9S8LIJPugxw4oTGrnVfwl2w==
X-Google-Smtp-Source: AAOMgpdZZuIYMlR4kO8iy+jxLBRkgQIAOWTBBsvljV9tq+LMRgsWJDqCU2TmxQTZlS8S1q9kghfkrA==
X-Received: by 2002:a17:902:8c95:: with SMTP id t21-v6mr18339566plo.306.1531280734397;
        Tue, 10 Jul 2018 20:45:34 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id f126-v6sm10740641pgc.88.2018.07.10.20.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 20:45:33 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH RESEND] KVM: Add coalesced PIO support
Date:   Wed, 11 Jul 2018 11:45:29 +0800
Message-Id: <1531280729-4236-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Windows I/O, such as the real-time clock. The address register (port
0x70 in the RTC case) can use coalesced I/O, cutting the number of
userspace exits by half when reading or writing the RTC.

Guest access rtc like this: write register index to 0x70, then write or 
read data from 0x71. writing 0x70 port is just as index and do nothing 
else. So we can use coalesced mmio to handle this scene to reduce VM-EXIT 
time.

In our environment, 12 windows guests running on a Skylake server:

Before patch:

IO Port Access  Samples  Samples%   Time%    Avg time

0x70:POUT        20675    46.04%    92.72%   67.15us ( +-   7.93% )

After patch:

IO Port Access  Samples  Samples%   Time%    Avg time

0x70:POUT        17509    45.42%    42.08%   6.37us ( +-  20.37% )

Thanks to Peng Hao's initial patch.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/00-INDEX         |  2 ++
 Documentation/virtual/kvm/api.txt          |  7 +++++++
 Documentation/virtual/kvm/coalesced-io.txt | 17 +++++++++++++++++
 include/uapi/linux/kvm.h                   |  5 +++--
 virt/kvm/coalesced_mmio.c                  | 16 +++++++++++++---
 virt/kvm/kvm_main.c                        |  2 ++
 6 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/virtual/kvm/coalesced-io.txt

diff --git a/Documentation/virtual/kvm/00-INDEX b/Documentation/virtual/kvm/00-INDEX
index 3492458..4160620 100644
--- a/Documentation/virtual/kvm/00-INDEX
+++ b/Documentation/virtual/kvm/00-INDEX
@@ -9,6 +9,8 @@ arm
 	- internal ABI between the kernel and HYP (for arm/arm64)
 cpuid.txt
 	- KVM-specific cpuid leaves (x86).
+coalesced-io.txt
+	- Coalesced MMIO and coalesced PIO.
 devices/
 	- KVM_CAP_DEVICE_CTRL userspace API.
 halt-polling.txt
diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index d10944e..4190796 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4618,3 +4618,10 @@ This capability indicates that KVM supports paravirtualized Hyper-V TLB Flush
 hypercalls:
 HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
 HvFlushVirtualAddressList, HvFlushVirtualAddressListEx.
+
+8.19 KVM_CAP_COALESCED_PIO
+
+Architectures: x86, s390, ppc, arm64
+
+This Capability indicates that kvm supports writing to a coalesced-pio region
+is not reported to userspace until the next non-coalesced pio is issued.
diff --git a/Documentation/virtual/kvm/coalesced-io.txt b/Documentation/virtual/kvm/coalesced-io.txt
new file mode 100644
index 0000000..4a96eaf
--- /dev/null
+++ b/Documentation/virtual/kvm/coalesced-io.txt
@@ -0,0 +1,17 @@
+----
+Coalesced MMIO and coalesced PIO can be used to optimize writes to
+simple device registers. Writes to a coalesced-I/O region are not
+reported to userspace until the next non-coalesced I/O is issued,
+in a similar fashion to write combining hardware.  In KVM, coalesced
+writes are handled in the kernel without exits to userspace, and
+are thus several times faster.
+
+Examples of devices that can benefit from coalesced I/O include:
+
+- devices whose memory is accessed with many consecutive writes, for
+  example the EGA/VGA video RAM.
+
+- windows I/O, such as the real-time clock. The address register (port
+  0x70 in the RTC case) can use coalesced I/O, cutting the number of
+  userspace exits by half when reading or writing the RTC.
+----
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6270a3..9cc56d3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -420,13 +420,13 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+	__u32 pio;
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
-	__u32 pad;
+	__u32 pio;
 	__u8  data[8];
 };
 
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_COALESCED_PIO 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 9e65feb..fc66a834 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -83,6 +83,7 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
 	ring->coalesced_mmio[ring->last].phys_addr = addr;
 	ring->coalesced_mmio[ring->last].len = len;
 	memcpy(ring->coalesced_mmio[ring->last].data, val, len);
+	ring->coalesced_mmio[ring->last].pio = dev->zone.pio;
 	smp_wmb();
 	ring->last = (ring->last + 1) % KVM_COALESCED_MMIO_MAX;
 	spin_unlock(&dev->kvm->ring_lock);
@@ -149,8 +150,12 @@ int kvm_vm_ioctl_register_coalesced_mmio(struct kvm *kvm,
 	dev->zone = *zone;
 
 	mutex_lock(&kvm->slots_lock);
-	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, zone->addr,
-				      zone->size, &dev->dev);
+	if (zone->pio)
+		ret = kvm_io_bus_register_dev(kvm, KVM_PIO_BUS, zone->addr,
+						zone->size, &dev->dev);
+	else
+		ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, zone->addr,
+						zone->size, &dev->dev);
 	if (ret < 0)
 		goto out_free_dev;
 	list_add_tail(&dev->list, &kvm->coalesced_zones);
@@ -174,7 +179,12 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 
 	list_for_each_entry_safe(dev, tmp, &kvm->coalesced_zones, list)
 		if (coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
-			kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS, &dev->dev);
+			if (zone->pio)
+				kvm_io_bus_unregister_dev(kvm, KVM_PIO_BUS,
+							&dev->dev);
+			else
+				kvm_io_bus_unregister_dev(kvm, KVM_MMIO_BUS,
+							&dev->dev);
 			kvm_iodevice_destructor(&dev->dev);
 		}
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b47507f..a587fb9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2936,6 +2936,8 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
+	case KVM_CAP_COALESCED_PIO:
+		return 1;
 #endif
 #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
 	case KVM_CAP_IRQ_ROUTING:
-- 
2.7.4

