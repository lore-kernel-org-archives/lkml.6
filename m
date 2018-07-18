Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A27ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BF120661
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llGO3w9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BF120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeGSAhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:37:21 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36771 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbeGSAhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:37:20 -0400
Received: by mail-lf0-f68.google.com with SMTP id b22-v6so4704845lfa.3;
        Wed, 18 Jul 2018 16:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PbypWeH7RwBMrWfLK/sWiwz3HN+58XBzfb8H1ml/oqE=;
        b=llGO3w9j2a9jGknZFbb8CSKUX+sOoQGihS6CWslFwRCKDUNovu8m9kCxLjGgaNmAj7
         4GVvK6PODsieH2w82+xJ0p+25BVBD6cMZt2JSAeVqvA2sOyO21I0RPRNXTXXvlZHFN27
         T6+6FDVJAMFoRgQ1bcHxjVF6RQHKYuyyQKs4wbPv3e69bDRpfZw3I9rq0JnqAra1r6rW
         Nt7D9mdX+8jAIM+7zB7DPTquPTQJdNxe1PjQGq7qeV86PLh+8RQ9wvyYqTXobH1R+BzY
         xxmqeUSn3Bixm8zfwBRrACcELHlAP8DMYvUKxyHwYQ9LLOTI6h+6pgoOZHDcfTBcFWSQ
         ZuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PbypWeH7RwBMrWfLK/sWiwz3HN+58XBzfb8H1ml/oqE=;
        b=jmK1ggBKyOFzujXKicXP45SN+M/APowB5McAVWtvwXJ1JTrhW9Ejnfxl8GpTOJUZRn
         4cAzTavECJS7/+pdRk7A+hIrVCs0SShRxOekwKJHVRrwx0H26o+fAI/q9iHuIkqhoCz4
         qGPCeqwO/S3hTcqA+tpXBnSOdiOBwZh9T32nCP9E6EMuY3n2wFLsb+Seu7yuoI9najOD
         v9hJYbnTbHJ1F+HYW9uq0cbX9fmCfN1WRgH/3SgefEXPRW5YLkr4jFqYroiQ5G0JzQNo
         aAnX4u6kRJFMCLotA3syeCHa8jLVIZ2WLujuY9IgoLTZnzk/AJMeG1wrNe5Hn6phB0Wb
         rTWQ==
X-Gm-Message-State: AOUpUlHJNNu7LnF7AST+3WUg+20eIcOJ9vbEyHSYZfqOTY6zPu2gyn74
        RNSg8TfPiZlNBi7zwflE5aQ=
X-Google-Smtp-Source: AAOMgpeJQ/q8sNAw15axAiaJCV9vkRGpEmFvXqAnZySJvYnyoGNIG/coOmuvZ4+gW5vz7O0oEMc+bQ==
X-Received: by 2002:a19:d819:: with SMTP id p25-v6mr4964094lfg.36.1531958219884;
        Wed, 18 Jul 2018 16:56:59 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h7-v6sm826584ljk.27.2018.07.18.16.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:56:59 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data GPIO resource
Date:   Thu, 19 Jul 2018 01:57:09 +0200
Message-Id: <20180718235710.18242-8-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plan is to replace data port readw()/writew() operations with GPIO
callbacks provided by gpio-omap driver.  For acceptable performance the
GPIO chip must support get/set_multiple() GPIO callbacks.

In order to avoid data corruption, we require the array of data GPIO
descriptors obtained with gpiod_get_array() to meet some strict
requirements:
- all pins must belong to the same single GPIO chip,
- array index of each pin descriptor must match its hardware number,
- pin polarity must not be inverted,
- pin hardware configuration must not be open drain nor open source.

Let's implement the above described sanity checks before replacing the
readw()/writew() operations witn GPIO callbacks.  If a check fails,
return -EINVAL to indicate the board provided GPIO setup is invalid.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 87 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index ad62c0245458..bd501f385e78 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -190,7 +191,9 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
 	struct gpio_descs *data_gpiods;
-	int err = 0;
+	struct gpio_chip *data_gpioc;
+	unsigned long mask, bits;
+	int i, err = 0;
 
 	if (!res)
 		return -ENXIO;
@@ -298,6 +301,88 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_mtd;
 	}
 
+	/* Use GPIO chip of first data GPIO pin descriptor */
+	data_gpioc = gpiod_to_chip(data_gpiods->desc[0]);
+
+	/*
+	 * For acceptable performance require the data GPIO
+	 * chip to support get/set_multiple() callbacks.
+	 */
+	if (!data_gpioc->get_multiple || !data_gpioc->set_multiple) {
+		err = -EINVAL;
+		dev_err(&pdev->dev,
+			"data GPIO chip does not support get/set_multiple()\n");
+		goto out_mtd;
+	}
+
+	/* Verify if get_multiple() returns all pins low as initialized above */
+	mask = (1 << data_gpiods->ndescs) - 1;
+	err = data_gpioc->get_multiple(data_gpioc, &mask, &bits);
+	if (err) {
+		dev_err(&pdev->dev,
+			"data GPIO chip get_multiple() failed: %d\n", err);
+		goto out_mtd;
+	}
+	if (bits) {
+		err = -EINVAL;
+		dev_err(&pdev->dev,
+			"mismmatch of data GPIO initial value: %lu\n", bits);
+		goto out_mtd;
+	}
+
+	/* Verify each data GPIO pin */
+	for (i = 0; i < data_gpiods->ndescs; i++) {
+		/* Require all pins belong to the same GPIO chip */
+		if (gpiod_to_chip(data_gpiods->desc[i]) != data_gpioc) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "GPIO chip mismatch of data bit %d\n",
+				i);
+			goto out_mtd;
+		}
+
+		/* Require all pins active high (not inverted) */
+		if (gpiod_is_active_low(data_gpiods->desc[i])) {
+			err = -EINVAL;
+			dev_err(&pdev->dev,
+				"unsupported polarity of data GPIO bit %d\n",
+				i);
+			goto out_mtd;
+		}
+
+		/*
+		 * Require pin gpiod array index to match hardware pin number.
+		 * Verified by setting the pin high with gpiod_set_raw_value()
+		 * then reading it back with gpiochip->get() for comparison.
+		 */
+		gpiod_set_raw_value(data_gpiods->desc[i], 1);
+		err = data_gpioc->get(data_gpioc, i);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"data bit %d GPIO chip get() failed: %d\n", i,
+				err);
+			goto out_mtd;
+		}
+		if (!err) {
+			err = -EINVAL;
+			dev_err(&pdev->dev, "mismatch of data GPIO bit %d value\n",
+				i);
+			goto out_mtd;
+		}
+
+		/*
+		 * Check for unsupported pin hardware configuration.  Use
+		 * just verified gpiod array index as hardware pin number.
+		 */
+		if (gpiochip_line_is_open_drain(data_gpioc, i) ||
+		    gpiochip_line_is_open_source(data_gpioc, i)) {
+			err = -EINVAL;
+			dev_err(&pdev->dev,
+				"unsupported mode of data GPIO bit %d\n",
+				i);
+			goto out_mtd;
+		}
+	}
+
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
 	if (err)
-- 
2.16.4

