Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeE3NUW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:20:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54721 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeE3NUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:20:06 -0400
X-Google-Smtp-Source: ADUXVKLyFpnsdNH+2CIDngqOkW3Px+K+diD2Yi3jMiFPkGDRHSpEETy/9X7sOceyTs2421KxSf/oeA==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, Laura Abbott <labbott@redhat.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v2 2/2] ARM: debug: fix BCM2836 order entry
Date: Wed, 30 May 2018 15:19:56 +0200
Message-Id: <20180530131956.13972-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530131956.13972-1-peron.clem@gmail.com>
References: <20180530131956.13972-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

Entries are sorted by their address value, except the BCM2836/KONA
which are not in the proper order.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 4ea9d5793b91..1571d6c8f40e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1572,8 +1572,8 @@ config DEBUG_UART_PHYS
 	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0x20068000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0x20201000 if DEBUG_BCM2835
-	default 0x3f201000 if DEBUG_BCM2836
 	default 0x3e000000 if DEBUG_BCM_KONA_UART
+	default 0x3f201000 if DEBUG_BCM2836
 	default 0x4000e400 if DEBUG_LL_UART_EFM32
 	default 0x40028000 if DEBUG_AT91_SAMV7_USART1
 	default 0x40081000 if DEBUG_LPC18XX_UART0
-- 
2.17.0
