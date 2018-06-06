Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S3LnZEjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A15F960555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932424AbeFFSrM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:47:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35349 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbeFFSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:47:11 -0400
X-Google-Smtp-Source: ADUXVKKzjrxT0w1n7i+A3bjZA9/kTKuutU3OrEiqFCLyJ6RTHZY74eGrzIR4+Zr+5sOnX75muyW1Cg==
From: Corentin Labbe <clabbe@baylibre.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] serial: 8250_dw: 8250_dw need to depend on COMMON_CLK
Date: Wed,  6 Jun 2018 18:47:04 +0000
Message-Id: <1528310824-12706-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following build error on M68K:
drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
8250_dw.c:(.text+0x50c): undefined reference to `clk_round_rate'
8250_dw.c:(.text+0x594): undefined reference to `clk_set_rate'

So 8250_dw need to depend on COMMON_CLK.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/tty/serial/8250/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f005eaf8bc57..37d4ec5f3cc9 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -351,7 +351,7 @@ config SERIAL_8250_FSL
 
 config SERIAL_8250_DW
 	tristate "Support for Synopsys DesignWare 8250 quirks"
-	depends on SERIAL_8250
+	depends on SERIAL_8250 && COMMON_CLK
 	help
 	  Selecting this option will enable handling of the extra features
 	  present in the Synopsys DesignWare APB UART.
-- 
2.16.4
