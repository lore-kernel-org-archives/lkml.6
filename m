Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D9C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205DD217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfBRVIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:08:00 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfBRVH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:07:58 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MYvHa-1gZvZR2VSy-00UtS6; Mon, 18 Feb 2019 22:07:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        arnd@arndb.de, linux-riscv@lists.infradead.org,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 7/8] csky: Use latest system call ABI
Date:   Mon, 18 Feb 2019 22:07:11 +0100
Message-Id: <20190218210712.3503891-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b9uGlJZjYWR0TeRDyLkO0y46fjRMT6X+cqSqFO9XKVQTCBbYU4k
 lqAzapNVCiizm6JQu9hlZXLd9zdDa9NpI6N+vWtguD18PgqQWTdIUMiNfWHZyyu1VhmCnZO
 YuhMkgj/O//KHs+9BWKQAluN3GvcadruPhi2m7LWm2ED2/epAJVhzvFqPEA0jiBJGkYNa1z
 ef5UNsDCjbuUd1nCxCBzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yfd0sA9GaOs=:n7pkNDVjGX9jsrtkpjCKIV
 MvNdGj/B2VYYToKFb9TuPve71L7+IOm3/m1RCEuBcNbHVzfi8Emh1bkaa7pEB3XdxI2f5Xxah
 G3P7RlCMPGJOigz8xG+g16DXO5WzQQ20cohHSra7HNSngbL/jBCaI9WidivWeqYD7j3r12zyi
 bFtTj44bzd4yQwNOgdkzzGMaGYuuoaTCzXqDHYAiFUL+U+dcSFJOYQW18COw8vtgi7+/H4jwA
 PKmhKUdYYTMIXfsn9UB1Ix8R+2u07rBRyPa1alYMR4rbphJdyYznT/nG8r9NkKjYVufKkeToA
 tX76RZ/OzwNr2xSpl60cgLFDy0w9YOGKAIz79D2zDSAt+ekxc/+GahpvAUk41+PZsPV/CR9am
 5ww8qcFJ7KxnfkAg9SpVSwIxHzGV0kw3SiR46FdF4IvPSMgcbpI3PX1vszcTMaNtrcMP7Ft2y
 kaiaWtwZHtdM6WnewsRAfHQJsBwF1oia3pggtfzbltLG6MkoBRjc5GAsPW4Aa/WktuMjUqbD9
 3f3eu1XmnOAQUL3mq3GJhP85UdM1qoiANVdgpWg1eFVcbc4z8NmNlIoNmIvZz387xvq69rxpQ
 YfIWJj9/ZKhwjAYQSbD/HD/MBzzwAlnybqjHn1pSWtB5hnIgVJuIDq9Kg63l/eaU4Aks2tgwv
 pAfKYIFDhID4rHBl2cJFxxCAZDvVSk3zFn2/2SWyPszeYuNF+KMp7tqDwEHKFSnpmrS8rRwlG
 vY3wB1GLQ7Vv12T2FIyyPgLmxKnAad1RKx+GDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't yet have an upstream glibc port for csky, so there is no user
space for the existing ABI, and we can remove the definitions for 32-bit
time_t, off_t and struct resource.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                   | 1 -
 arch/csky/include/uapi/asm/unistd.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 6959e0b1e956..398113c845f5 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -1,6 +1,5 @@
 config CSKY
 	def_bool y
-	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index ec60e49cea66..224c9a9ab45b 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -2,8 +2,6 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_TIME32_SYSCALLS
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
-- 
2.20.0

