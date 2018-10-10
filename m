Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C1F2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C1F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJKAqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:46:45 -0400
Received: from shell.v3.sk ([90.176.6.54]:54552 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJKAqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:46:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A4042BCFBD;
        Wed, 10 Oct 2018 19:23:34 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id i_nqN1EWszN0; Wed, 10 Oct 2018 19:23:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 473E9BCFBC;
        Wed, 10 Oct 2018 19:23:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q0V_-29Cc2dm; Wed, 10 Oct 2018 19:23:05 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A4A44BCFAA;
        Wed, 10 Oct 2018 19:23:04 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 05/15] Platform: OLPC: Move OLPC config symbol out of x86 tree
Date:   Wed, 10 Oct 2018 19:22:50 +0200
Message-Id: <20181010172300.317643-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are ARM OLPC machines that use mostly the same drivers, including
EC infrastructure, DCON and Battery.

While at that, fix Kconfig to allow building this as a module.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/x86/Kconfig                  | 11 -----------
 drivers/input/mouse/Kconfig       |  2 +-
 drivers/platform/Kconfig          |  2 ++
 drivers/platform/olpc/Kconfig     | 11 +++++++++++
 drivers/staging/olpc_dcon/Kconfig |  2 +-
 5 files changed, 15 insertions(+), 13 deletions(-)
 create mode 100644 drivers/platform/olpc/Kconfig

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..be6af341a718 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2729,17 +2729,6 @@ config SCx200HR_TIMER
 	  processor goes idle (as is done by the scheduler).  The
 	  other workaround is idle=3Dpoll boot option.
=20
-config OLPC
-	bool "One Laptop Per Child support"
-	depends on !X86_PAE
-	select GPIOLIB
-	select OF
-	select OF_PROMTREE
-	select IRQ_DOMAIN
-	---help---
-	  Add support for detecting the unique features of the OLPC
-	  XO hardware.
-
 config OLPC_XO1_PM
 	bool "OLPC XO-1 Power Management"
 	depends on OLPC && MFD_CS5535 && PM_SLEEP
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 566a1e3aa504..58034892a4df 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -165,7 +165,7 @@ config MOUSE_PS2_TOUCHKIT
=20
 config MOUSE_PS2_OLPC
 	bool "OLPC PS/2 mouse protocol extension"
-	depends on MOUSE_PS2 && OLPC
+	depends on MOUSE_PS2 && X86 && OLPC
 	help
 	  Say Y here if you have an OLPC XO-1 laptop (with built-in
 	  PS/2 touchpad/tablet device).  The manufacturer calls the
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index d4c2e424a700..4313d73d3618 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -10,3 +10,5 @@ source "drivers/platform/goldfish/Kconfig"
 source "drivers/platform/chrome/Kconfig"
=20
 source "drivers/platform/mellanox/Kconfig"
+
+source "drivers/platform/olpc/Kconfig"
diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
new file mode 100644
index 000000000000..7b736c9e67ac
--- /dev/null
+++ b/drivers/platform/olpc/Kconfig
@@ -0,0 +1,11 @@
+config OLPC
+	tristate "One Laptop Per Child support"
+	depends on X86 || ARM || COMPILE_TEST
+	depends on !X86_PAE
+	select GPIOLIB
+	select OF
+	select OF_PROMTREE if X86
+	select IRQ_DOMAIN
+	help
+	  Add support for detecting the unique features of the OLPC
+	  XO hardware.
diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dco=
n/Kconfig
index c91a56f77bcb..07f9f1de8667 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -1,6 +1,6 @@
 config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
-	depends on OLPC && FB
+	depends on X86 && OLPC && FB
 	depends on I2C
 	depends on (GPIO_CS5535 || GPIO_CS5535=3Dn)
 	select BACKLIGHT_CLASS_DEVICE
--=20
2.19.0

