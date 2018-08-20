Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFC3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AC021570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnKEazNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AC021570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHTV3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:29:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43433 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTV3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:29:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id m84-v6so439208lje.10;
        Mon, 20 Aug 2018 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7H4vp0EsPAd2Ofq3+tQ1pqiYwK34bXGlpOIDdMOQ8EE=;
        b=bnKEazNSGuBhuivNFwYWFiISSKTJbVSAkOQ8VzMUdUYzEwGe9zG5S23gIRS0I2N2fe
         7wKjpiXOjPlyYgLx93Knj93yvV68pW1afqHzHxv8/C7g8CiMqCYqLVoEDbGGQ4v4yVrS
         f3imuhowG2u7FYD/7P3mAz24bcp6nTXMZhutgdxgoANsSt0eonNRTZf4cj893POHtVav
         lpcwCfRlo3AnGWVzHYnuYseIfWVmGrN+8khZu4meMxOoKPRqmdWOm6+7zPGkaovETDyI
         6gLUW361Us1jf5Y+pFAXRwj7ktokLHwbyvjAXQI+5p727WxievIFW6Nk6hPVnJ3L9Dn+
         uDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7H4vp0EsPAd2Ofq3+tQ1pqiYwK34bXGlpOIDdMOQ8EE=;
        b=mh/9M/x8X3NRrcR+8O7tmjRs2aT9Bm+89UW8/Q4Gro0/u3t0gAEXCc99uyvCi4n54I
         I8I3mupBiDOZHeBR3Spw64qfuS7R562Ow1zOfoQ3Y15BwtAMGRlLK/tjXZ7VMG30I056
         QNg2uRa9Ucv1btRDkxjbRAl0oBAXKwNnOiDNj2m+p5p+nO8Um947BlczZS6DOnRMoj27
         EjytQbK6bVG1OdDsgf6ea+Xhwj8VOVDvB/1TyP3j1JAaO3aBiXknFgWSRbS57hyn5tq1
         MrSs0IHsh6QuOLyzu1JubPBk7oZczjzs+2fzGlm+WBZfnpUej4RlaoFE6D/sWc0qjhUw
         ANQg==
X-Gm-Message-State: AOUpUlHE64dYroWo+2o4N0DJb3xmCp2rQn7qJGrXUO/vUNfWIykqTKJw
        ST8Xg3EiAY+ySX46B4kBuIM=
X-Google-Smtp-Source: AA+uWPznbBPNlimjuQ8SI4V8hIfheWIEq0pv/knHCsU6bTeq2Of1UtSnHYIgo2Z1Bs0p0nbe0cpqOQ==
X-Received: by 2002:a2e:7406:: with SMTP id p6-v6mr17448106ljc.5.1534788758629;
        Mon, 20 Aug 2018 11:12:38 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id g16-v6sm379918lfb.5.2018.08.20.11.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 11:12:38 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 2/3] ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
Date:   Mon, 20 Aug 2018 20:13:32 +0200
Message-Id: <20180820181333.2527-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820181333.2527-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latch2 pins control a number of on-board devices, namely LCD, NAND,
MODEM and CODEC.  Those pins used to be initialized with safe values
from init_machine before that operation was:
1) moved to late_initcall in preparation for conversion of latch2 to
GPIO device - see commit f7519d8c8290 ("ARM: OMAP1: ams-delta: register
latch dependent devices later"),
2) replaced with non-atomic initialization performed by means of
gpio_request_array() - see commit 937eb4bb0058 ("ARM: OMAP1: ams-delta:
convert latches to basic_mmio_gpio"),
3) made completely asynchronous by delegation of GPIO request
operations performed on subsets of pins to respective device drivers in
subsequent commits.

One visible negative result of that disintegration was corrupt keyboard
data reported by serio driver, recently fixed by commit 41f8fee385a0
("ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin").

Moreover, initialization of LATCH2_PIN_MODEM_CODEC still performed with
ams_delta_latch2_write() wrapper from late_init() is now done on not
requested GPIO pin.

Reintroduce atomic initialization of latch2 pins at machine_init to
prevent from random values potentially corrupting NAND data or maybe
even destroing other hardware.  Also take care of MODEM/CODEC related
pins so MODEM device probe succeeds even if latch2 GPIO device or
dependent regulator is not ready and CODEC can be reached over the
MODEM even if audio driver doesn't take control over
LATCH2_PIN_MODEM_CODEC.

Once done, remove the no longer needed GPIO based implementation of
ams_delta_latch_write() and its frontend macro.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 52 +++++++++++++++++++++++------------
 arch/arm/mach-omap1/board-ams-delta.h |  7 -----
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index b3fe515b6f49..c865c6921af8 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -321,20 +321,6 @@ struct modem_private_data {
 
 static struct modem_private_data modem_priv;
 
-void ams_delta_latch_write(int base, int ngpio, u16 mask, u16 value)
-{
-	int bit = 0;
-	u16 bitpos = 1 << bit;
-
-	for (; bit < ngpio; bit++, bitpos = bitpos << 1) {
-		if (!(mask & bitpos))
-			continue;
-		else
-			gpio_set_value(base + bit, (value & bitpos) != 0);
-	}
-}
-EXPORT_SYMBOL(ams_delta_latch_write);
-
 static struct resource ams_delta_nand_resources[] = {
 	[0] = {
 		.start	= OMAP1_MPUIO_BASE,
@@ -680,6 +666,40 @@ static void __init omap_gpio_deps_init(void)
 	modem_assign_irq(chip);
 }
 
+/*
+ * Initialize latch2 pins with values which are safe for dependent on-board
+ * devices or useful for their successull initialization even before GPIO
+ * driver takes control over the latch pins:
+ * - LATCH2_PIN_LCD_VBLEN	= 0
+ * - LATCH2_PIN_LCD_NDISP	= 0	Keep LCD device powered off before its
+ *					driver takes control over it.
+ * - LATCH2_PIN_NAND_NCE	= 0
+ * - LATCH2_PIN_NAND_NWP	= 0	Keep NAND device down and write-
+ *					protected before its driver takes
+ *					control over it.
+ * - LATCH2_PIN_KEYBRD_PWR	= 0	Keep keyboard powered off before serio
+ *					driver takes control over it.
+ * - LATCH2_PIN_KEYBRD_DATAOUT	= 0	Keep low to avoid corruption of first
+ *					byte of data received from attached
+ *					keyboard when serio device is probed;
+ *					the pin is also hogged low by the latch2
+ *					GPIO driver as soon as it is ready.
+ * - LATCH2_PIN_MODEM_NRESET	= 1	Enable voice MODEM device, allowing for
+ *					its successful probe even before a
+ *					regulator it depends on, which in turn
+ *					takes control over the pin, is set up.
+ * - LATCH2_PIN_MODEM_CODEC	= 1	Attach voice MODEM CODEC data port
+ *					to the MODEM so the CODEC is under
+ *					control even if audio driver doesn't
+ *					take it over.
+ */
+static void __init ams_delta_latch2_init(void)
+{
+	u16 latch2 = 1 << LATCH2_PIN_MODEM_NRESET | 1 << LATCH2_PIN_MODEM_CODEC;
+
+	__raw_writew(latch2, LATCH2_VIRT);
+}
+
 static void __init ams_delta_init(void)
 {
 	/* mux pins for uarts */
@@ -701,6 +721,7 @@ static void __init ams_delta_init(void)
 	omap_cfg_reg(J18_1610_CAM_D7);
 
 	omap_gpio_deps_init();
+	ams_delta_latch2_init();
 	gpiod_add_hogs(ams_delta_gpio_hogs);
 
 	omap_serial_init();
@@ -888,9 +909,6 @@ static int __init ams_delta_modem_init(void)
 	/* Initialize the modem_nreset regulator consumer before use */
 	modem_priv.regulator = ERR_PTR(-ENODEV);
 
-	ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC,
-			AMS_DELTA_LATCH2_MODEM_CODEC);
-
 	err = platform_device_register(&ams_delta_modem_device);
 
 	return err;
diff --git a/arch/arm/mach-omap1/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
index 1fbada29431a..a74a306d7e77 100644
--- a/arch/arm/mach-omap1/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -59,13 +59,6 @@
 #define AMS_DELTA_LATCH2_GPIO_BASE	AMS_DELTA_GPIO_PIN_LCD_VBLEN
 #define AMS_DELTA_LATCH2_NGPIO		16
 
-#ifndef __ASSEMBLY__
-void ams_delta_latch_write(int base, int ngpio, u16 mask, u16 value);
-#define ams_delta_latch2_write(mask, value) \
-	ams_delta_latch_write(AMS_DELTA_LATCH2_GPIO_BASE, \
-			AMS_DELTA_LATCH2_NGPIO, (mask), (value))
-#endif
-
 #endif /* CONFIG_MACH_AMS_DELTA */
 
 #endif /* __ASM_ARCH_OMAP_AMS_DELTA_H */
-- 
2.16.4

