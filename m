Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F74C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3AC222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437545AbfBNIgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:36:33 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390648AbfBNIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:36:32 -0500
Received: from orion.localdomain ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M8k65-1gyLNM298D-004lz1; Thu, 14 Feb 2019 09:36:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: [PATCH 2/2] input: keyboard: gpio_keys_polled: use gpio lookup table
Date:   Thu, 14 Feb 2019 09:36:19 +0100
Message-Id: <1550133379-1793-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550133379-1793-1-git-send-email-info@metux.net>
References: <1550133379-1793-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:tN8DQuaNYEA+ZoCEfAy3i7u8ehj8Sgs3UAHDaNgLdoMyXbDSlON
 iiKhJlzJ3lyLhZLfFspzLbhSXNGVdUuXyBpmfJLAPfN/T2WHOEf8S835Ls6esT5/6QGjqrz
 RqqqODtD3F9WSGnYO723JtXATS/knZLgQxEuDbXj9RIUSLacXauQTAI8UMkRcAOtv8/+Zql
 LMEi+XLWWLOfAoP4k7fiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nzYNXRKmnw8=:nfpyN81VWDvc+1OBMoqeX0
 W1TJwwbfJYvQ2FDNphlzg1w3CK0IPbZDct30HJlD8KWd7KQzeruMan2ARURB/VCrjnEqRG+zt
 R21XllCs5YVD6VH7uIA5AZa+60tDkEhu/n5HRLpVAp0JhytlPwTs6q77+wWchT4dHSZYMuCtP
 yuZzhaQ1SQSFDF/H5H5j8iZMjsqkf4/tp9Rhe3Ob6Zf3Rp6DHaoGxmFsY5S8EUj1RPW0hr68e
 gg1U7nQWwPExa6udCoV5v3yhVq+Fbiv2MNO1PTol0/jGtTZmtjgmw9yW0PWxaJpn5/MYYXOSd
 ZGqyfzdcDqR79IGKZLxM3/4hIbnkhS5Qyvf7X90AwVZQ5Lg7TMSWvlaHVzeIsJBad9pW0ydL/
 PDBVedRHtDC5qTOB0cMf5MW80cpUJoJW8zWIlhO8RhAn2eJ4PgVsLSYgpP09Sk7hsuFVvPRTN
 6n1/qxT9nF4tMWIXiNEy+3oKvbFDVFeeUiUcGq6/a2HyING6fpDrILrvFe/UvI7SPKZxsF1BG
 ccA7IQIWV+DIVb9xSQ1PpDRB5aR/JY7Ajjr2AgRkq29n79sfq7MFtJ9N40qlfETjmE5dMdzGp
 AyXASdiQ/ys03fAYMWMhG9+Mw2f37KjRmlnAYwwG23oinS40tzu8CIX9VHbiQumEi9Jbw6BKz
 Rstre6qy4aRD517trgWvVmG1p7HWEgliJuiAR/dILJE/qUUo8NkEdnDySs3MhnAravfRIZLg1
 ZknqdZ7NVlLJtiBg5P6wpdNOZk3f6XryctnMuw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the recently introduced gpio lookup tables for
attaching to gpio lines. So, harcoded gpio numbers aren't
needed anymore.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 167 +++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 48 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 3312186..3f773b2 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio_keys.h>
 #include <linux/property.h>
 
@@ -227,6 +228,119 @@ static void gpio_keys_polled_set_abs_params(struct input_dev *input,
 };
 MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
 
+static struct gpio_desc *gpio_keys_polled_get_gpiod_fwnode(
+	struct device *dev,
+	int idx,
+	const char *desc)
+{
+	struct gpio_desc *gpiod;
+	struct fwnode_handle *child;
+	int x;
+
+	/* get the idx'th child node */
+	child = device_get_next_child_node(dev, NULL);
+	while (child && x) {
+		child = device_get_next_child_node(dev, child);
+		x--;
+	}
+
+	if (!child) {
+		dev_err(dev, "missing oftree child node #%d\n", idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	gpiod = devm_fwnode_get_gpiod_from_child(dev,
+						 NULL,
+						 child,
+						 GPIOD_IN,
+						 desc);
+	if (IS_ERR(gpiod)) {
+		if (PTR_ERR(gpiod) != -EPROBE_DEFER)
+			dev_err(dev,
+				"failed to get gpio: %ld\n",
+				PTR_ERR(gpiod));
+		fwnode_handle_put(child);
+		return gpiod;
+	}
+
+	return gpiod;
+}
+
+static struct gpio_desc *gpio_keys_polled_get_gpiod_legacy(
+	struct device *dev,
+	int idx,
+	const struct gpio_keys_button *button)
+{
+	/*
+	 * Legacy GPIO number so request the GPIO here and
+	 * convert it to descriptor.
+	 */
+	unsigned int flags = GPIOF_IN;
+	struct gpio_desc *gpiod;
+	int error;
+
+	dev_info(dev, "hardcoded gpio IDs are deprecated.\n");
+
+	if (button->active_low)
+		flags |= GPIOF_ACTIVE_LOW;
+
+	error = devm_gpio_request_one(dev, button->gpio,
+			flags, button->desc ? : DRV_NAME);
+	if (error) {
+		dev_err(dev,
+			"unable to claim gpio %u, err=%d\n",
+			button->gpio, error);
+		return ERR_PTR(error);
+	}
+
+	gpiod = gpio_to_desc(button->gpio);
+	if (!gpiod) {
+		dev_err(dev,
+			"unable to convert gpio %u to descriptor\n",
+			button->gpio);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return gpiod;
+}
+
+static struct gpio_desc *gpio_keys_polled_get_gpiod(
+	struct device *dev,
+	int idx,
+	const struct gpio_keys_button *button)
+{
+	struct gpio_desc *gpiod = NULL;
+	int error;
+
+	/* No legacy static platform data - use oftree */
+	if (!dev_get_platdata(dev)) {
+		return gpio_keys_polled_get_gpiod_fwnode(
+			dev, idx, button->desc);
+	}
+
+	gpiod = devm_gpiod_get_index(dev, NULL, idx, GPIOF_IN);
+
+	if (!IS_ERR(gpiod)) {
+		dev_info(dev, "picked gpiod idx %d from gpio table\n", idx);
+		gpiod_set_consumer_name(gpiod, button->desc ? : DRV_NAME);
+		return gpiod;
+	}
+
+	if (PTR_ERR(gpiod) != -ENOENT) {
+		dev_err(dev, "failed fetching gpiod #%d: %d\n",
+			idx, PTR_ERR(gpiod));
+		return gpiod;
+	}
+
+	/* Use legacy gpio id, if defined */
+	if (gpio_is_valid(button->gpio)) {
+		return gpio_keys_polled_get_gpiod_legacy(
+			dev, idx, button);
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
 static int gpio_keys_polled_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -291,57 +405,14 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 		if (button->wakeup) {
 			dev_err(dev, DRV_NAME " does not support wakeup\n");
-			fwnode_handle_put(child);
 			return -EINVAL;
 		}
 
-		if (!dev_get_platdata(dev)) {
-			/* No legacy static platform data */
-			child = device_get_next_child_node(dev, child);
-			if (!child) {
-				dev_err(dev, "missing child device node\n");
-				return -EINVAL;
-			}
-
-			bdata->gpiod = devm_fwnode_get_gpiod_from_child(dev,
-								NULL, child,
-								GPIOD_IN,
-								button->desc);
-			if (IS_ERR(bdata->gpiod)) {
-				error = PTR_ERR(bdata->gpiod);
-				if (error != -EPROBE_DEFER)
-					dev_err(dev,
-						"failed to get gpio: %d\n",
-						error);
-				fwnode_handle_put(child);
-				return error;
-			}
-		} else if (gpio_is_valid(button->gpio)) {
-			/*
-			 * Legacy GPIO number so request the GPIO here and
-			 * convert it to descriptor.
-			 */
-			unsigned flags = GPIOF_IN;
-
-			if (button->active_low)
-				flags |= GPIOF_ACTIVE_LOW;
-
-			error = devm_gpio_request_one(dev, button->gpio,
-					flags, button->desc ? : DRV_NAME);
-			if (error) {
-				dev_err(dev,
-					"unable to claim gpio %u, err=%d\n",
-					button->gpio, error);
-				return error;
-			}
-
-			bdata->gpiod = gpio_to_desc(button->gpio);
-			if (!bdata->gpiod) {
-				dev_err(dev,
-					"unable to convert gpio %u to descriptor\n",
-					button->gpio);
-				return -EINVAL;
-			}
+		bdata->gpiod = gpio_keys_polled_get_gpiod(dev, i, button);
+
+		if (IS_ERR(bdata->gpiod)) {
+			dev_err(dev, "failed to fetch gpiod #%d\n", i);
+			return PTR_ERR(bdata->gpiod);
 		}
 
 		bdata->last_state = -1;
-- 
1.9.1

