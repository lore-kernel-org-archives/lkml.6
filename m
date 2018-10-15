Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DB4C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEAC208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxX6Icv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEAC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeJPD0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:26:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36069 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJPD0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:26:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so18624289ljb.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/9NWfrU4yyCrkQpP563ooDYYnrLgUrU0Qz4OZakKBuY=;
        b=mxX6Icv5oBLfOKQswoyZSRq4tPAm3cvvcaxSHIfl6T9q7GS0NlQJgbwvb7ouIBlbMp
         /yt86LKjzt92gQMgZuIN9dgcUqhxlejRByRKSOwT1Gq5v+Uk3Ec0RE73/qL1I1efNszl
         TSPd38Ep/rqBehziGdHF+hbnlSXWyBi24NfczpdK/KIdYj4PmqGRazqwazmbHRfjzcfP
         rF3JB3xJBnHm8304gh43RopFdaHekjENO00jzxy5zrHU3bxzhkP3NukIWmJWJrUuFslG
         a+4JHCHcQpKwe8yjTO8TVhMQDV/fVf7R4Xcxjvkg0orbqhA2Ir0EY2nuZzVQHSaOCkDa
         phAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/9NWfrU4yyCrkQpP563ooDYYnrLgUrU0Qz4OZakKBuY=;
        b=ofowdOG10CXl3XlKFdIFH5yNhvHUiDRNMP617xCz4r6KHxtHWjw/YMvR5edC74PI5H
         yoEeRCV01YpkzrtYe6a7Ph/4eZEus+5Em9M8t5OAfSA3H3e6a26iGG01J6oWZJ0AJTV/
         1HtjYT/5pcH88s5JxOJ4NJuHdQ8A3B4KkrBar178rFSimH2b3M5LQUipgpfhQVEhcgll
         9/laYYgN0OWly0wB/s4zp+R2CU71JJkjSmo71Tikg1DzmbYydpeKH0+qeyAKW8wqL7XM
         A1WEp2+i/k43Siy65rNaeCe/zaLwq8z/jEpJO0800g9ew3eOnM7QGXjRD8Dcv2LU6+dI
         CViQ==
X-Gm-Message-State: ABuFfogWAGc5IFMJ7ArIzZrKltBK0/x3HgdKA3kiYgVl/xpgNZIkrIFm
        V1iGO/XvJ6Yi/M8tCEb9Odk=
X-Google-Smtp-Source: ACcGV62l5AS+u+dbvkYcJHinUuo55+Z8uQUDv6G5Qt8ogaYYdwUt3DETTHDdKNug4nSA4nuavKIzPA==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr11742168ljh.103.1539632403957;
        Mon, 15 Oct 2018 12:40:03 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id l3-v6sm2658830lji.60.2018.10.15.12.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:40:03 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 1/3] mtd: rawnand: Provide helper for polling GPIO R/B pin
Date:   Mon, 15 Oct 2018 21:41:28 +0200
Message-Id: <20181015194130.21764-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181012204101.26274-1-jmkrzyszt@gmail.com>
References: <20181012204101.26274-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each controller driver having access to NAND R/B pin over GPIO would
have to reimplement the polling loop otherwise.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changelog:
v3:
- don't surround added code with #ifdef CONFIG_GPIOLIB - sugeested by
  Boris Brezillon - thanks,
- drop inadequate comment on calling ->exec_op() recursively - catched
  by Boris Brezillon, thanks,
- drop redundant commend from header file - suggensted by Boris
  Brezillon - thanks,
- update comment on waiting for R/B pin rather than command completion
v2:
New patch - v1 consisted of only one patch reusing legacy helper

 drivers/mtd/nand/raw/nand_base.c | 31 +++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 05bd0779fe9b..0d5a2dc59b8d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -45,6 +45,7 @@
 #include <linux/io.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
+#include <linux/gpio/consumer.h>
 
 #include "internals.h"
 
@@ -531,6 +532,36 @@ int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
 };
 EXPORT_SYMBOL_GPL(nand_soft_waitrdy);
 
+/**
+ * nand_gpio_waitrdy - Poll R/B GPIO pin until ready
+ * @chip: NAND chip structure
+ * @gpiod: GPIO descriptor of R/B pin
+ * @timeout_ms: Timeout in ms
+ *
+ * Poll the R/B GPIO pin until it becomes ready. If that does not happen
+ * whitin the specified timeout, -ETIMEDOUT is returned.
+ *
+ * This helper is intended to be used when the controller has access to the
+ * NAND R/B pin over GPIO.
+ *
+ * Return 0 if the R/B pin indicates chip is ready, a negative error otherwise.
+ */
+int nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod,
+		      unsigned long timeout_ms)
+{
+	/* Wait until R/B pin indicates chip is ready or timeout occurs */
+	timeout_ms = jiffies + msecs_to_jiffies(timeout_ms);
+	do {
+		if (gpiod_get_value_cansleep(gpiod))
+			return 0;
+
+		cond_resched();
+	} while	(time_before(jiffies, timeout_ms));
+
+	return gpiod_get_value_cansleep(gpiod) ? 0 : -ETIMEDOUT;
+};
+EXPORT_SYMBOL_GPL(nand_gpio_waitrdy);
+
 /**
  * panic_nand_get_device - [GENERIC] Get chip for selected access
  * @chip: the nand chip descriptor
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index e10b126e148f..4e91a70ede10 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1346,4 +1346,8 @@ void nand_release(struct nand_chip *chip);
  */
 int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms);
 
+struct gpio_desc;
+int nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod,
+		      unsigned long timeout_ms);
+
 #endif /* __LINUX_MTD_RAWNAND_H */
-- 
2.16.4

