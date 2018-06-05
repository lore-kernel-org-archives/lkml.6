Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeFEGfx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:35:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751361AbeFEGfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:35:51 -0400
From: Abbott Liu <liuwenliang@huawei.com>
To: <aryabinin@virtuozzo.com>, <glider@google.com>, <dvyukov@google.com>,
        <corbet@lwn.net>, <linux@armlinux.org.uk>, <christoffer.dall@arm.com>,
        <marc.zyngier@arm.com>, <arnd@arndb.de>, <nicolas.pitre@linaro.org>,
        <vladimir.murzin@arm.com>, <keescook@chromium.org>,
        <jinb.park7@gmail.com>, <alexandre.belloni@bootlin.com>,
        <ard.biesheuvel@linaro.org>, <daniel.lezcano@linaro.org>,
        <pombredanne@nexb.com>, <kstewart@linuxfoundation.org>,
        <liuwenliang@huawei.com>, <rob@landley.net>,
        <gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
        <mawilcox@microsoft.com>, <akpm@linux-foundation.org>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <yamada.masahiro@socionext.com>, <alexander.levin@verizon.com>,
        <tglx@linutronix.de>, <thgarnie@google.com>, <dhowells@redhat.com>,
        <geert@linux-m68k.org>, <andre.przywara@arm.com>,
        <julien.thierry@arm.com>, <drjones@redhat.com>, <philip@cog.systems>,
        <opendmb@gmail.com>, <mhocko@suse.com>,
        <kirill.shutemov@linux.intel.com>, <kasan-dev@googlegroups.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>
CC: <a.ryabinin@samsung.com>, <ryabinin.a.a@gmail.com>
Subject: [PATCH v5 6/6] Enable KASan for arm
Date: Tue, 5 Jun 2018 14:14:16 +0800
Message-ID: <20180605061416.18690-7-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180605061416.18690-1-liuwenliang@huawei.com>
References: <20180605061416.18690-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ryabinin <ryabinin@virtuozzo.com>

This patch enable kernel address sanitizer for arm.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 Documentation/dev-tools/kasan.rst | 2 +-
 arch/arm/Kconfig                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index f7a18f2..d92120d 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -12,7 +12,7 @@ KASAN uses compile-time instrumentation for checking every memory access,
 therefore you will need a GCC version 4.9.2 or later. GCC 5.0 or later is
 required for detection of out-of-bounds accesses to stack or global variables.
 
-Currently KASAN is supported only for the x86_64 and arm64 architectures.
+Currently KASAN is supported only for the x86_64, arm64 and arm architectures.
 
 Usage
 -----
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f..a43a746 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,7 @@ config ARM
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_KASAN if MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
-- 
2.9.0
