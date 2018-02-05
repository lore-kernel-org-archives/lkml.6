Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeBEBYa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:24:30 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39226 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeBEBYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:24:16 -0500
X-Google-Smtp-Source: AH8x225y9GkVrP0VOaRjq/MFjmkKl0O2tWJVMX4GHqZY+RNPtBeWseFfnSHslV6sY+S+4PJCbYpseA==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, Ulf Magnusson <ulfalizer@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 07/20] riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
Date: Mon,  5 Feb 2018 02:21:19 +0100
Message-Id: <20180205012146.23981-8-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARCH_WANT_OPTIONAL_GPIOLIB symbol was removed in commit 65053e1a7743
("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB"). GPIOLIB should
just be selected explicitly if needed.

Remove the ARCH_WANT_OPTIONAL_GPIOLIB select from RISCV.

See commit 0145071b3314 ("x86: Do away with
ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") and commit da9a1c6767 ("arm64: do
away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") as well.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/riscv/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ff69c77b9e78..716e90e60e5c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,7 +19,6 @@ config RISCV
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_DMA_API_DEBUG
-- 
2.14.1
