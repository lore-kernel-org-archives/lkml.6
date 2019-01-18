Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369A1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBB820896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfARQY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:24:57 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:54399 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfARQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:35 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8QNy-1gouaL0Udc-004VsZ; Fri, 18 Jan 2019 17:19:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/29] ARM: add kexec_file_load system call number
Date:   Fri, 18 Jan 2019 17:18:13 +0100
Message-Id: <20190118161835.2259170-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8ym37e+lD/lgSGacCaoLSHBwvMbYSdoq935/+50m0n+e2+nfjyl
 Uc3eCCUqAr3iiX9tp3dh/UjTnNU1TWM344t7SmBQecjF8G3qbieGmrEuRnYfdVzVTXxlNMn
 1F6pSIpGD86JSkJzsxanqoPTEb+l+XA5OO3U0pzk6a/S0BMyuhTWrH4HTr95PQFlXgEL4sD
 b/smjhXtOquSiUivlB38g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hPFjMXC73D8=:yIT7bb4MDFSWj86wHD5l4c
 Dw71KKy4lEMciOZt+W7BOiEuK2mNuN+kh5N3AiCr4vfMUFyOd0gUpMGVvzlD5ys8kVC8UFHy1
 GF3XDa3FhTBMA3K+9JRQ8rmAsDSolTFqDYWCMPAT63yZzygeYo+H4Gb28+uNbUdwlsZqY9gO8
 6lK6+sEIXt8TvMB4ddTaGomaNQPmxg4p1hEhaovZAfReP98dH5330uzzrgeqRsnqM2eHkKNHE
 IPPBPHtvsyz2uSE81DXrtfxuBWnljymZkblHoH/MPVnSr/2bCgJGktCOvWDoVamsF7nbJsafo
 2OignWTVnOttBAtdSjEfSQ6CDTNo9IioOYs6f/rgrWALcLtl8cQBqMMcwSuRSeg7LAk4hc7Oj
 vKqxXzmE6UzScOdNEzF+a+2KnoI+oavrpydZ3aezYjXL9WJt6eh/9b1NMWLoLioZhktu7kZ6b
 mZh1EEbibQK8F64O6oN3sLL4qqNGDpvKpnMdtyBo2RHlZhWm2ACWT6TJIaGxLHEQjzxZGToRN
 IFf4ybmEY0PVOn3IHZu/nuvhVYHTeILnajyNYSzLFJ3VZ9kru5A/DCKSsLyoeKTCUNnQHigs5
 2bl5d22j1GPBmdXFJiXmupqH8HXQEkhm2IhAGe2JkhUkSAvGLFP1YeJ1fCfrGDG34cx2/LUcp
 JcCpam5vxV5OOFiQEFF/gbY/veubTMQIf5uhL2znlb1HwTgwa3y+NgPSsmX9zdfo3Hj9Ix3G5
 AQJldjI7SaGcXfDZb0CIJB58fi1O6B6dUcSGIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of architectures including arm64 already implement the
kexec_file_load system call, on many others we have assigned a system
call number for it, but not implemented it yet.

Adding the number in arch/arm/ lets us use the system call on arm64
systems in compat mode, and also reduces the number of differences
between architectures. If we want to implement kexec_file_load on ARM
in the future, the number assignment means that kexec tools can already
be built with the now current set of kernel headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 86de9eb34296..20ed7e026723 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -415,3 +415,4 @@
 398	common	rseq			sys_rseq
 399	common	io_pgetevents		sys_io_pgetevents
 400	common	migrate_pages		sys_migrate_pages
+401	common	kexec_file_load		sys_kexec_file_load
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 261216c3336e..2c30e6f145ff 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		401
+#define __NR_compat_syscalls		402
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index f15bcbacb8f6..8ca1d4c304f4 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_migrate_pages 400
 __SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
+#define __NR_kexec_file_load 401
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0

