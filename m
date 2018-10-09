Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F4FC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661EF2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHkuu6oY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661EF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJISpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:45:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50947 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeJISpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:45:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so1480333wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJVB3VM1FhhD50A/8iTwRJ++Zbc5O4IuQOlX3n3nyqY=;
        b=QHkuu6oY7hpq/aFA6JWWa3T44Bg3xr5AFeFwlVv9GNWPSSNOJ5QR9sSXg3sXiONHa5
         y2sXDeQy2xaiHdI1iX/i09mq4cHb/0bpb5HpZpX9n/UEff49yZZQ6HaOhwysa6PfdBO/
         UUogZeTwVTL55CAC7eF3ebUCbo3EAaoVAvO03q8ei+CRcoUmAdZDyBhIjQJq0aAPZB9V
         CRC9mvq5YGdaUbpknWDxKJ3QSXCeXNmo1OGLWsWSZtxCObBD0YKMLcE+/tXlzFC8qUqT
         MAl3UzjPAc03zXudpMhTNb6s/n0eGwg6k9g3CdEVKl3MNDvKSen94R2HasGAsDtVnxWe
         79Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJVB3VM1FhhD50A/8iTwRJ++Zbc5O4IuQOlX3n3nyqY=;
        b=Jd7lu5T+De67uqESulARm6IzGzpytXd/3xm2yRVcj+aZwZTfAdBYu2IBctQfRIdujp
         eXklQoSvjQ273IVD2jVSK8QMEzEwIkA/SigPU+NtwhjJAhhxY9LOL3m0EZvY7wfnJ4ZE
         S0J+0i9r1zqbxxpaQP6hFLYJ8tSCGa/m+z4/pMVgUs8Ga43GpGkZ940WvheAAwam3Syv
         JIDv6LgkIInAlCT3Aj8un4vdwqqoHz4TFbcenxe1r4d4Si66glgNhCqNqjrZb+z+2jzu
         u0fcf9V2c127KtNmflWRsl39Zm8BvgtVxLCE2CmAFyUEaaHF59YaBsQL9wjhpB+jM4PG
         L/FQ==
X-Gm-Message-State: ABuFfohFABTrGb9pur1vkW9tGBYE7slbTATITTrH7Hd1SMmjOQq1scnQ
        89o7AQreaMcdbKzvKBXPyic=
X-Google-Smtp-Source: ACcGV62aLWac0v8WIVPWKq1ToywL5GV4WyaSLPiD0NmPfd8DRuKX4x7Q5k0TB2zFF/Sd4Vzj18bloQ==
X-Received: by 2002:a1c:b605:: with SMTP id g5-v6mr1524569wmf.97.1539084523501;
        Tue, 09 Oct 2018 04:28:43 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id e7-v6sm19849442wra.37.2018.10.09.04.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:28:42 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
Date:   Tue,  9 Oct 2018 13:28:37 +0200
Message-Id: <20181009112837.2517-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cyclone5 and Arria10 doesn't have the same memory map for UART1.

Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for Cylone5.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/Kconfig.debug | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f6fcb8a79889..25ebdcefe403 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1079,14 +1079,21 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA(Cyclone 5 and Arria 5) based platforms.
 
-	config DEBUG_SOCFPGA_UART1
+	config DEBUG_SOCFPGA_ARRIA10_UART1
 		depends on ARCH_SOCFPGA
-		bool "Use SOCFPGA UART1 for low-level debug"
+		bool "Use SOCFPGA Arria10 UART1 for low-level debug"
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA(Arria 10) based platforms.
 
+	config DEBUG_SOCFPGA_CYCLONE5_UART1
+		depends on ARCH_SOCFPGA
+		bool "Use SOCFPGA Cyclone 5 UART1 for low-level debug"
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on SOCFPGA(Cyclone 5 and Arria 5) based platforms.
 
 	config DEBUG_SUN9I_UART0
 		bool "Kernel low-level debugging messages via sun9i UART0"
@@ -1647,7 +1654,8 @@ config DEBUG_UART_PHYS
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART0
-	default 0xffc02100 if DEBUG_SOCFPGA_UART1
+	default 0xffc02100 if DEBUG_SOCFPGA_ARRIA10_UART1
+	default 0xffc03000 if DEBUG_SOCFPGA_CYCLONE5_UART1
 	default 0xffd82340 if ARCH_IOP13XX
 	default 0xffe40000 if DEBUG_RCAR_GEN1_SCIF0
 	default 0xffe42000 if DEBUG_RCAR_GEN1_SCIF2
@@ -1754,7 +1762,8 @@ config DEBUG_UART_VIRT
 	default 0xfeb30c00 if DEBUG_KEYSTONE_UART0
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
 	default 0xfec02000 if DEBUG_SOCFPGA_UART0
-	default 0xfec02100 if DEBUG_SOCFPGA_UART1
+	default 0xfec02100 if DEBUG_SOCFPGA_ARRIA10_UART1
+	default 0xfec03000 if DEBUG_SOCFPGA_CYCLONE5_UART1
 	default 0xfec12000 if (DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE) && ARCH_MVEBU
 	default 0xfec12100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xfec10000 if DEBUG_SIRFATLAS7_UART0
@@ -1803,9 +1812,9 @@ config DEBUG_UART_8250_WORD
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	depends on DEBUG_UART_8250_SHIFT >= 2
 	default y if DEBUG_PICOXCELL_UART || \
-		DEBUG_SOCFPGA_UART0 || DEBUG_SOCFPGA_UART1 || \
-		DEBUG_KEYSTONE_UART0 || DEBUG_KEYSTONE_UART1 || \
-		DEBUG_ALPINE_UART0 || \
+		DEBUG_SOCFPGA_UART0 || DEBUG_SOCFPGA_ARRIA10_UART1 || \
+		DEBUG_SOCFPGA_CYCLONE5_UART1 || DEBUG_KEYSTONE_UART0 || \
+		DEBUG_KEYSTONE_UART1 || DEBUG_ALPINE_UART0 || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
 		DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_BCM_IPROC_UART3 || \
 		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2
-- 
2.17.1

