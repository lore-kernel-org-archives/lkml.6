Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeBEBZe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:25:34 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36859 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeBEBYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:24:49 -0500
X-Google-Smtp-Source: AH8x227EFaAw4XwwUAtGWzO5p2lix3QZLrVH6w/mqMxQFGyJRtjA8vVXyIxoTjthdKQN43KIB0uURw==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, Ulf Magnusson <ulfalizer@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/20] ARM: debug: Remove ARCH_MSM dep. from UNCOMPRESS_INCLUDE
Date: Mon,  5 Feb 2018 02:21:24 +0100
Message-Id: <20180205012146.23981-13-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARCH_MSM symbol was removed in commit c0c89fafa289 ("ARM: Remove
mach-msm and associated ARM architecture code"), but a default in
UNCOMPRESS_INCLUDE still depends on it.

Remove the ARCH_MSM dependency from the default in UNCOMPRESS_INCLUDE.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 78a647080ebc..20c601a045d2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1825,7 +1825,7 @@ config DEBUG_UNCOMPRESS
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
+	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || \
 					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
 	default "mach/uncompress.h"
 
-- 
2.14.1
