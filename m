Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14648C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74D820645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74D820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeLMMeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:34:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49405 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbeLMMeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:34:19 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gXQBv-0005iT-FJ; Thu, 13 Dec 2018 13:34:11 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] reset: sunxi: declare sun6i_reset_init in a header file
Date:   Thu, 13 Dec 2018 13:33:57 +0100
Message-Id: <20181213123358.24391-2-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213123358.24391-1-p.zabel@pengutronix.de>
References: <20181213123358.24391-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid declaring extern functions in c files. To make sure function
definition and usage don't get out of sync, declare sun6i_reset_init
in a common header.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-sunxi/sunxi.c | 2 +-
 drivers/reset/reset-sunxi.c | 1 +
 include/linux/reset/sunxi.h | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/reset/sunxi.h

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index de4b0e932f22..88680e80c166 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -14,6 +14,7 @@
 #include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/reset/sunxi.h>
 
 #include <asm/mach/arch.h>
 #include <asm/secure_cntvoff.h>
@@ -37,7 +38,6 @@ static const char * const sun6i_board_dt_compat[] = {
 	NULL,
 };
 
-extern void __init sun6i_reset_init(void);
 static void __init sun6i_timer_init(void)
 {
 	of_clk_init(NULL);
diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index db9a1a75523f..b06d724d8f21 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
+#include <linux/reset/sunxi.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
diff --git a/include/linux/reset/sunxi.h b/include/linux/reset/sunxi.h
new file mode 100644
index 000000000000..1ad7fffb413e
--- /dev/null
+++ b/include/linux/reset/sunxi.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_RESET_SUNXI_H__
+#define __LINUX_RESET_SUNXI_H__
+
+void __init sun6i_reset_init(void);
+
+#endif /* __LINUX_RESET_SUNXI_H__ */
-- 
2.19.1

