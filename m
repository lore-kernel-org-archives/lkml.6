Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeBEBYO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:24:14 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46449 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeBEBXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:23:49 -0500
X-Google-Smtp-Source: AH8x2279t7n9Z8J9Eo3Ua0ru/v9tos8mMcCJJvmM6nlHC1P49IEmRJJ+7Hycsac3+0UToW/qFzmZNQ==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no,
        linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, Ulf Magnusson <ulfalizer@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH 05/20] rtc: at32ap700x: Remove PLATFORM_AT32AP dependency
Date: Mon,  5 Feb 2018 02:21:17 +0100
Message-Id: <20180205012146.23981-6-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLATFORM_AT32AP symbol went away when AVR32 was removed in
commit 26202873bb51 ("avr32: remove support for AVR32 architecture").

Remove the RTC_DRV_AT32AP700X dependency from RTC_DRV_AT32AP700X.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b71cc7b5fbc9..1f5f3bd82ab6 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1404,7 +1404,7 @@ config RTC_DRV_PL031
 
 config RTC_DRV_AT32AP700X
 	tristate "AT32AP700X series RTC"
-	depends on PLATFORM_AT32AP || COMPILE_TEST
+	depends on COMPILE_TEST
 	help
 	  Driver for the internal RTC (Realtime Clock) on Atmel AVR32
 	  AT32AP700x family processors.
-- 
2.14.1
