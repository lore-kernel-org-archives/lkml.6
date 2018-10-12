Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A0FC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8020868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ7bBPFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeJMENw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:13:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41494 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeJMENw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:13:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id u21-v6so12428779lja.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 13:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPZoG7xBIXV1527/eKMNrcpLfJdSOy5pxS4ndXfw/U4=;
        b=gJ7bBPFwk6UNq/ljMObuduPaWDzsI6mo8boiBdGO7iSycb1Xpux0EP24aQqDRarYda
         bkET1vEjgi8YAnsdHxi0AdJmok+UmaDjUg7LjwNiji01eQ5qGHyjG5I5+PofM5QrE8yQ
         pWEjX6XM30r+E7yI/oIBIZJpE83Gkwbrr52SlqRXgUqX+UBh3wyMYAN48JJCW9A43nCJ
         jEqy/ALZX5vZkeGv3rEPy4gE8aI/qXRTHh5Vshv/dOGRf63AFuC9K7YKY6teNIEp3mlF
         kjUWmO+81djOIjP0L9b49h1IuXaXQEeNvGoyLW+EmdTCrEP2uxDjfeG55ECu4AW7pJrH
         LfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPZoG7xBIXV1527/eKMNrcpLfJdSOy5pxS4ndXfw/U4=;
        b=KEyBJMrwSuQsAY2kEDtkFU0feHiv2SpsZx78SURuUJqx+/3GoAPUweXWZOmrWKgWqs
         tKwO0vmWA92Gkn1LqBfOeH56P4fwId9JhSWG3zEtbuTSiv5f0+SP9cnG/Pi4alU6R75d
         AuNpa+39QQQfn9hNt1nHLo6WvX1t7do+Uakuqbljt/S5SIvSiD7JhtX0w5OaaJp4VIba
         luwWfy8ulsgSNbi28+Ujd+QDfpUqBSobdbyJmXBWGPX90loQJxcYkFvfDOQ9jNSJVewU
         jv33C66/V0EJZHz+kV35AM1QLnDkHcp9vbtWR01jA/IqhWuTawrod0UhdkQY5d5jX0lY
         4Pcg==
X-Gm-Message-State: ABuFfojhTus005v9UpwN7DjA0ntoYMRWNNWED1LVwursjFyNBERaSCEh
        RZqVyKtMT5juDdA9Vg6c9v0=
X-Google-Smtp-Source: ACcGV63f0xxaP0aGSxT6Hne6eSfMqP6P4VnJmlc//MmG7BTLdLYEWewKoSLztWuLYOr26GlV5/jR1w==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr4931782ljj.90.1539376775501;
        Fri, 12 Oct 2018 13:39:35 -0700 (PDT)
Received: from localhost.localdomain ([31.0.86.150])
        by smtp.gmail.com with ESMTPSA id s4-v6sm460187ljh.11.2018.10.12.13.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 13:39:34 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 1/2] mtd: rawnand: Provide helper for polling GPIO R/B pin
Date:   Fri, 12 Oct 2018 22:41:00 +0200
Message-Id: <20181012204101.26274-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181003120028.9257-1-jmkrzyszt@gmail.com>
References: <20181003120028.9257-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each controller driver with access to NAND R/B pin over GPIO would have 
to reimplement the polling loop otherwise.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2:
New patch - v1 consisted of only one patch (the followning one)


 drivers/mtd/nand/raw/nand_base.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 05bd0779fe9b..ff1ac4a3c647 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -45,6 +45,9 @@
 #include <linux/io.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
+#ifdef CONFIG_GPIOLIB
+#include <linux/gpio/consumer.h>
+#endif
 
 #include "internals.h"
 
@@ -531,6 +534,41 @@ int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
 };
 EXPORT_SYMBOL_GPL(nand_soft_waitrdy);
 
+#ifdef CONFIG_GPIOLIB
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
+ * Be aware that calling this helper from an ->exec_op() implementation means
+ * ->exec_op() must be re-entrant.
+ *
+ * Return 0 if the R/B pin indicates chip is ready, a negative error otherwise.
+ */
+int nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod,
+		      unsigned long timeout_ms)
+{
+	/* Wait until command is processed or timeout occurs */
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
+#endif
+
 /**
  * panic_nand_get_device - [GENERIC] Get chip for selected access
  * @chip: the nand chip descriptor
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index e10b126e148f..09f0ed1345b1 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1346,4 +1346,14 @@ void nand_release(struct nand_chip *chip);
  */
 int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms);
 
+#ifdef CONFIG_GPIOLIB
+struct gpio_desc;
+/*
+ * External helper for controller drivers that have to implement the WAITRDY
+ * instruction and do have GPIO pin to check it.
+ */
+int nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod,
+		      unsigned long timeout_ms);
+#endif
+
 #endif /* __LINUX_MTD_RAWNAND_H */
-- 
2.16.4

