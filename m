Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeBEB0h (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:26:37 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43878 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeBEBZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:25:14 -0500
X-Google-Smtp-Source: AH8x225PQ5OXXo5q2sBf3XgnK3L0Y9BVB12VHjq60zuTqq31KhcX8pVxKdfttPy/Sk6OMyENSGC+nw==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, Ulf Magnusson <ulfalizer@gmail.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 16/20] auxdisplay: img-ascii-lcd: Remove MIPS_SEAD3 dep.
Date: Mon,  5 Feb 2018 02:21:28 +0100
Message-Id: <20180205012146.23981-17-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPS_SEAD3 symbol was removed in commit 64601cb1343f ("leds: Remove SEAD-3
driver").

Remove the MIPS_SEAD3 dependency from IMG_ASCII_LCD.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/auxdisplay/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 2c2ed9cf8796..3cba78d36eec 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -137,7 +137,7 @@ config CFAG12864B_RATE
 config IMG_ASCII_LCD
 	tristate "Imagination Technologies ASCII LCD Display"
 	depends on HAS_IOMEM
-	default y if MIPS_MALTA || MIPS_SEAD3
+	default y if MIPS_MALTA
 	select SYSCON
 	help
 	  Enable this to support the simple ASCII LCD displays found on
-- 
2.14.1
