Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F00BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BB920685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfAJQ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:26:29 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:43163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbfAJQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:26:25 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M26n9-1gjYwt2XdZ-002VJW; Thu, 10 Jan 2019 17:25:14 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        firoz.khan@linaro.org, ebiederm@xmission.com,
        deepa.kernel@gmail.com, linux@dominikbrodowski.net,
        akpm@linux-foundation.org, dave@stgolabs.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 07/15] ARM: add kexec_file_load system call number
Date:   Thu, 10 Jan 2019 17:24:27 +0100
Message-Id: <20190110162435.309262-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bbQTa8+RVq8uOU5pbxDK+0/4n2oFwdb20J9rbCJvp69tR6LbpUE
 BGw9PvuvotSd1z/CxUlN3LgFpu8c2eaVfhJU913d+y+4OuiKFe0x+5pUiPKr+A8JyoqUNYl
 +HzTAqMZP6muHMdLv1v6FLhgS7jrtc4eJiWfRbo6++zUEUKkS/plrzdPDX4N3ebSRZ82vdU
 29ipN8xprnY8eaAdBUF1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KcIkOw8POYU=:PlPoKFpPERWmgM//oISQHu
 FSulXma/Pg8PEBbrHXiPuKmqgQPSJjkYE+IphJVFUZAY6EDeu6AtFVVptEDSdANsrovpTXcAL
 b/AS9w9/SN/itOc8+uv+gP7/lQwmYzvDK1BbwMZpnXwYFjfMvbHPoKh9HcCWPXrhFDSGmw+8y
 5noFZR9dcb/SHixiXSpF1Uzzrt/1D05eMzRme6bDd6MQ8vzxvH9RxaowXKWyPsrHShPT5Yns3
 RvFMOs0GUK3O83DVUX7KxpyabIrqW2LWJqx+aQ/5s1+2NDh5iBfmAYGenrjOjg1Dw7D3x2DO6
 CbwGY7gKDYkp0Xv059QhC7u7F1tqgEzxTdrIb4K+LJQWNhFWZE6dFMlppU8my+3kMD+cIT6a4
 /lKUb9S1bXaWBFRozDTYAQ/dWsNDdcosUEbHB8AsA5zHlOClTE881gOj7PkZjhSIyEpiIEioD
 iBQFivwkpvXegsxBX3XNPos5ITLYPP00OJlLDCNuDqXAAMqMGQWMyaOHiSPo+J0RuYfofVFUk
 +ZA+taJ3UVicsNsNzgjrOb/MA1fkK79L0NYP12Nqoq7c8R8vhby74mvgU8cyLD8zYnzaa6jLH
 4nGKiLGdIzNVujVY6D9aWQawS+VNaFBXbqJ55jmmne047urmDt0vQV5Lg53Yze4OpTMtc1ZKL
 bEcAVanw4q5TBWN6nFcFgDqVzMcE+qwbf76mZR1JQw1kZojx200VU6Wc77Ggq+t14WHPxEt3u
 fc4ZKBNefarvA8bAMh25iORuVAYJ+Kk4mxSxzQ==
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
index 355fe2bc035b..19f3f58b6146 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_migrate_pages 400
 __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
+#define __NR_kexec_file_load 401
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0

