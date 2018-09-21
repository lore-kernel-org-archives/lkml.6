Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF57ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E296321566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E296321566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391117AbeIUWXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:23:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389683AbeIUWXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:23:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 753F1307C81E;
        Fri, 21 Sep 2018 16:33:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E60655C23B;
        Fri, 21 Sep 2018 16:33:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/34] Make anon_inodes unconditional [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:33:34 +0100
Message-ID: <153754761417.17872.5654918693471310181.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 21 Sep 2018 16:33:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the anon_inodes facility unconditional so that it can be used by core
VFS code.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/arm/kvm/Kconfig       |    1 -
 arch/arm64/kvm/Kconfig     |    1 -
 arch/mips/kvm/Kconfig      |    1 -
 arch/powerpc/kvm/Kconfig   |    1 -
 arch/s390/kvm/Kconfig      |    1 -
 arch/x86/Kconfig           |    1 -
 arch/x86/kvm/Kconfig       |    1 -
 drivers/base/Kconfig       |    1 -
 drivers/char/tpm/Kconfig   |    1 -
 drivers/dma-buf/Kconfig    |    1 -
 drivers/gpio/Kconfig       |    1 -
 drivers/iio/Kconfig        |    1 -
 drivers/infiniband/Kconfig |    1 -
 drivers/vfio/Kconfig       |    1 -
 fs/Makefile                |    2 +-
 fs/notify/fanotify/Kconfig |    1 -
 fs/notify/inotify/Kconfig  |    1 -
 init/Kconfig               |   10 ----------
 18 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index e2bd35b6780c..c09fcc092a54 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on MMU && OF
 	select PREEMPT_NOTIFIERS
-	select ANON_INODES
 	select ARM_GIC
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 47b23bf617c7..86fe9b3e3ff8 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -23,7 +23,6 @@ config KVM
 	depends on OF
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
-	select ANON_INODES
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	select KVM_MMIO
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index 76b93a9c8c9b..4d06a29bc13b 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -20,7 +20,6 @@ config KVM
 	depends on HAVE_KVM
 	select EXPORT_UASM
 	select PREEMPT_NOTIFIERS
-	select ANON_INODES
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_MMIO
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 68a0e9d5b440..e058d02ee819 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -20,7 +20,6 @@ if VIRTUALIZATION
 config KVM
 	bool
 	select PREEMPT_NOTIFIERS
-	select ANON_INODES
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select SRCU
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index a3dbd459cce9..600e4fd11a67 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -21,7 +21,6 @@ config KVM
 	prompt "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
 	select PREEMPT_NOTIFIERS
-	select ANON_INODES
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select HAVE_KVM_EVENTFD
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..d02baf335d98 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -46,7 +46,6 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
-	select ANON_INODES
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1bbec387d289..f3f2e547484b 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -27,7 +27,6 @@ config KVM
 	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
 	select MMU_NOTIFIER
-	select ANON_INODES
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
 	select IRQ_BYPASS_MANAGER
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 3e63a900b330..ae213ed2a7c8 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -174,7 +174,6 @@ source "drivers/base/regmap/Kconfig"
 config DMA_SHARED_BUFFER
 	bool
 	default n
-	select ANON_INODES
 	select IRQ_WORK
 	help
 	  This option enables the framework for buffer-sharing between
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 18c81cbe4704..4819874b5523 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -157,7 +157,6 @@ config TCG_CRB
 config TCG_VTPM_PROXY
 	tristate "VTPM Proxy Interface"
 	depends on TCG_TPM
-	select ANON_INODES
 	---help---
 	  This driver proxies for an emulated TPM (vTPM) running in userspace.
 	  A device /dev/vtpmx is provided that creates a device pair
diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index ed3b785bae37..b0194c8c251c 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -3,7 +3,6 @@ menu "DMABUF options"
 config SYNC_FILE
 	bool "Explicit Synchronization Framework"
 	default n
-	select ANON_INODES
 	select DMA_SHARED_BUFFER
 	---help---
 	  The Sync File Framework adds explicit syncronization via
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 4f52c3a8ec99..392fd95b3734 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -12,7 +12,6 @@ config ARCH_HAVE_CUSTOM_GPIO_H
 
 menuconfig GPIOLIB
 	bool "GPIO Support"
-	select ANON_INODES
 	help
 	  This enables GPIO support through the generic GPIO library.
 	  You only need to enable this, if you also want to enable
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d08aeb41cd07..1dec0fecb6ef 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -4,7 +4,6 @@
 
 menuconfig IIO
 	tristate "Industrial I/O support"
-	select ANON_INODES
 	help
 	  The industrial I/O subsystem provides a unified framework for
 	  drivers for many different types of embedded sensors using a
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index abb6660c099c..176b943dfec9 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -25,7 +25,6 @@ config INFINIBAND_USER_MAD
 
 config INFINIBAND_USER_ACCESS
 	tristate "InfiniBand userspace access (verbs and CM)"
-	select ANON_INODES
 	---help---
 	  Userspace InfiniBand access support.  This enables the
 	  kernel side of userspace verbs and the userspace
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index c84333eb5eb5..9aa91e736023 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -22,7 +22,6 @@ menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
 	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
-	select ANON_INODES
 	help
 	  VFIO provides a framework for secure userspace device drivers.
 	  See Documentation/vfio.txt for more details.
diff --git a/fs/Makefile b/fs/Makefile
index 9a0b8003f069..ae681523b4b1 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_PROC_FS) += proc_namespace.o
 
 obj-y				+= notify/
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
-obj-$(CONFIG_ANON_INODES)	+= anon_inodes.o
+obj-y				+= anon_inodes.o
 obj-$(CONFIG_SIGNALFD)		+= signalfd.o
 obj-$(CONFIG_TIMERFD)		+= timerfd.o
 obj-$(CONFIG_EVENTFD)		+= eventfd.o
diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
index 41355ce74ac0..f5b0b3af32dd 100644
--- a/fs/notify/fanotify/Kconfig
+++ b/fs/notify/fanotify/Kconfig
@@ -1,7 +1,6 @@
 config FANOTIFY
 	bool "Filesystem wide access notification"
 	select FSNOTIFY
-	select ANON_INODES
 	default n
 	---help---
 	   Say Y here to enable fanotify support.  fanotify is a file access
diff --git a/fs/notify/inotify/Kconfig b/fs/notify/inotify/Kconfig
index b981fc0c8379..0161c74e76e2 100644
--- a/fs/notify/inotify/Kconfig
+++ b/fs/notify/inotify/Kconfig
@@ -1,6 +1,5 @@
 config INOTIFY_USER
 	bool "Inotify support for userspace"
-	select ANON_INODES
 	select FSNOTIFY
 	default y
 	---help---
diff --git a/init/Kconfig b/init/Kconfig
index 1e234e2f1cba..275534995f78 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1114,9 +1114,6 @@ config LD_DEAD_CODE_DATA_ELIMINATION
 config SYSCTL
 	bool
 
-config ANON_INODES
-	bool
-
 config HAVE_UID16
 	bool
 
@@ -1321,14 +1318,12 @@ config HAVE_FUTEX_CMPXCHG
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
-	select ANON_INODES
 	help
 	  Disabling this option will cause the kernel to be built without
 	  support for epoll family of system calls.
 
 config SIGNALFD
 	bool "Enable signalfd() system call" if EXPERT
-	select ANON_INODES
 	default y
 	help
 	  Enable the signalfd() system call that allows to receive signals
@@ -1338,7 +1333,6 @@ config SIGNALFD
 
 config TIMERFD
 	bool "Enable timerfd() system call" if EXPERT
-	select ANON_INODES
 	default y
 	help
 	  Enable the timerfd() system call that allows to receive timer
@@ -1348,7 +1342,6 @@ config TIMERFD
 
 config EVENTFD
 	bool "Enable eventfd() system call" if EXPERT
-	select ANON_INODES
 	default y
 	help
 	  Enable the eventfd() system call that allows to receive both
@@ -1450,7 +1443,6 @@ config KALLSYMS_BASE_RELATIVE
 # syscall, maps, verifier
 config BPF_SYSCALL
 	bool "Enable bpf() system call"
-	select ANON_INODES
 	select BPF
 	select IRQ_WORK
 	default n
@@ -1467,7 +1459,6 @@ config BPF_JIT_ALWAYS_ON
 
 config USERFAULTFD
 	bool "Enable userfaultfd() system call"
-	select ANON_INODES
 	depends on MMU
 	help
 	  Enable the userfaultfd() system call that allows to intercept and
@@ -1534,7 +1525,6 @@ config PERF_EVENTS
 	bool "Kernel performance events and counters"
 	default y if PROFILING
 	depends on HAVE_PERF_EVENTS
-	select ANON_INODES
 	select IRQ_WORK
 	select SRCU
 	help

