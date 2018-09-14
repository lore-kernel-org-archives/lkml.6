Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE48ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FE320671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FE320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeINSqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:46:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24492 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeINSqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:46:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Bbz01PLHz9ttgN;
        Fri, 14 Sep 2018 15:31:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id evS9gR2EmXsj; Fri, 14 Sep 2018 15:31:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Bbz00njRz9ttgK;
        Fri, 14 Sep 2018 15:31:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 40F1A8B8BF;
        Fri, 14 Sep 2018 15:32:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0pCOK5H8klZt; Fri, 14 Sep 2018 15:32:00 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2059D8B8BC;
        Fri, 14 Sep 2018 15:32:00 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F2902718F8; Fri, 14 Sep 2018 13:31:59 +0000 (UTC)
Message-Id: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/3] watchdog: mpc8xxx: use dev_xxxx() instead of pr_xxxx()
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Date:   Fri, 14 Sep 2018 13:31:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc8xxx watchdog driver is a platform device drivers, it is
therefore possible to use dev_xxx() messaging rather than pr_xxx()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/watchdog/mpc8xxx_wdt.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index aca2d6323f8a..1dcf5f10cdd9 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -17,8 +17,6 @@
  * option) any later version.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -137,26 +135,27 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	struct mpc8xxx_wdt_ddata *ddata;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
+	struct device *dev = &ofdev->dev;
 
-	wdt_type = of_device_get_match_data(&ofdev->dev);
+	wdt_type = of_device_get_match_data(dev);
 	if (!wdt_type)
 		return -EINVAL;
 
 	if (!freq || freq == -1)
 		return -EINVAL;
 
-	ddata = devm_kzalloc(&ofdev->dev, sizeof(*ddata), GFP_KERNEL);
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
 	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	ddata->base = devm_ioremap_resource(&ofdev->dev, res);
+	ddata->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ddata->base))
 		return PTR_ERR(ddata->base);
 
 	enabled = in_be32(&ddata->base->swcrr) & SWCRR_SWEN;
 	if (!enabled && wdt_type->hw_enabled) {
-		pr_info("could not be enabled in software\n");
+		dev_info(dev, "could not be enabled in software\n");
 		return -ENODEV;
 	}
 
@@ -166,7 +165,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	ddata->wdd.ops = &mpc8xxx_wdt_ops,
 
 	ddata->wdd.timeout = WATCHDOG_TIMEOUT;
-	watchdog_init_timeout(&ddata->wdd, timeout, &ofdev->dev);
+	watchdog_init_timeout(&ddata->wdd, timeout, dev);
 
 	watchdog_set_nowayout(&ddata->wdd, nowayout);
 
@@ -189,12 +188,13 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 
 	ret = watchdog_register_device(&ddata->wdd);
 	if (ret) {
-		pr_err("cannot register watchdog device (err=%d)\n", ret);
+		dev_err(dev, "cannot register watchdog device (err=%d)\n", ret);
 		return ret;
 	}
 
-	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
-		reset ? "reset" : "interrupt", ddata->wdd.timeout);
+	dev_info(dev,
+		 "WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
+		 reset ? "reset" : "interrupt", ddata->wdd.timeout);
 
 	platform_set_drvdata(ofdev, ddata);
 	return 0;
@@ -204,8 +204,8 @@ static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
 {
 	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
 
-	pr_crit("Watchdog removed, expect the %s soon!\n",
-		reset ? "reset" : "machine check exception");
+	dev_crit(&ofdev->dev, "Watchdog removed, expect the %s soon!\n",
+		 reset ? "reset" : "machine check exception");
 	watchdog_unregister_device(&ddata->wdd);
 
 	return 0;
-- 
2.13.3

