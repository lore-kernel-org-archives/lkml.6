Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801FB25594
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801FB25594
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeFYIFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:05:43 -0400
Received: from mout.perfora.net ([74.208.4.197]:54855 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752237AbeFYIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:05:40 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1HiQ-1gQIWT277A-00t6cn; Mon, 25 Jun 2018 10:00:30 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: as3722: disable auto power on when AC OK
Date:   Mon, 25 Jun 2018 10:00:13 +0200
Message-Id: <20180625080013.32157-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:dyWuBbByBhrY5zyCaCL6D6U4n3s+cywk0AQVRH7HFZqdRj+yVRr
 HEdS98DZIWaLHtS/UQs4zb4uK5hOVuTNrH7D1d5hg+0+O7Rynac3CztHXrJz/hMH7xy7wSf
 jeTogXU+oED/tSoh2Lq7hDoQtlNSAA8KpWFhhH3qgJ0u03oIdU3HxgvLZpM1hbPjnuOdnt8
 k5scT8IvEZIwAzWuRDExQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UaY2MjKuQ70=:yDAOf5iydZ7a7xtlUMHEmn
 vcyz1130yCiUETOmaIuFEbYaibWhYCsRLxbYJhrwpzQlB0KwR4SPSHT1lmZbjAc54g8OABN1v
 gZO2cbqkbqgiVFlfM328+vrC62nGIMHbRVkdIjuv5jAX6ifemnV7vppMCLazBTxiy4LKvvE4T
 j0GgfAcVlxQ2r7PMIfAO8Whv5Ww127WwPM2xj4fICz7XXgeYKL5YsRCA5LxX+wwXBm0tLvIex
 qcQtCjvyBrDIBqSGVlUaahim/MCWLcnOMCSFqQe6k+5BJTzdiclWdV6CUB0TJmkuYsRsrC6YK
 dafsjzRFujqYzpyfSw2PNa6dv6zc4dOzJnyk2xf8SK98P/btTIEIpZnMRuVeaNFXbZjExT/Sk
 8ta9ZerOInGEa2xTIWBlzBYtsUL66PRuUdDsn8wZbWmiErxb+ejVUk02UWLBklcIVAvr5pN8L
 q/5p02aPr41SqjTBz3eNk4TNalOlsialFYHk9TG9R7RiFl6U4joZEAkMDzHy4BPxHF9RAehUW
 dfzfmT0qNc9iGOHAL20tB+fvRPfumCzDyMfhIJ6Pu/i4SiVd9oJ6tqUfgBYRjPUk3+m66EAZa
 /RG3K4vh9ViTQn/bPzzH1TgZknJxbgXJ64JHytz3xEhHYNsoTUJsePEjpcJSg3fj6mfnHWxeN
 VVF5bU2nPyzdCIYbof9/OQr48Qzk5y+XEmCs60VOoY/e4XqkuQgzxZMxV8SDBJQ7YcSc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

On ams AS3722, power on when AC OK is enabled by default.
Making this option as disable by default and enable only
when platform need this explicitly.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Reviewed-by: Bibek Basu <bbasu@nvidia.com>
Tested-by: Bibek Basu <bbasu@nvidia.com>
Downsteam commit 09cd706fecb9 ("mfd: as3722: disable auto power on when
AC OK").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/mfd/as3722.c       | 12 ++++++++++++
 include/linux/mfd/as3722.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index f87342c211bc..215465c97759 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -349,6 +349,8 @@ static int as3722_i2c_of_probe(struct i2c_client *i2c,
 					"ams,enable-internal-int-pullup");
 	as3722->en_intern_i2c_pullup = of_property_read_bool(np,
 					"ams,enable-internal-i2c-pullup");
+	as3722->en_ac_ok_pwr_on = of_property_read_bool(np,
+					"ams,enable-ac-ok-power-on");
 	as3722->irq_flags = irqd_get_trigger_type(irq_data);
 	dev_dbg(&i2c->dev, "IRQ flags are 0x%08lx\n", as3722->irq_flags);
 	return 0;
@@ -360,6 +362,7 @@ static int as3722_i2c_probe(struct i2c_client *i2c,
 	struct as3722 *as3722;
 	unsigned long irq_flags;
 	int ret;
+	u8 val = 0;
 
 	as3722 = devm_kzalloc(&i2c->dev, sizeof(struct as3722), GFP_KERNEL);
 	if (!as3722)
@@ -398,6 +401,15 @@ static int as3722_i2c_probe(struct i2c_client *i2c,
 	if (ret < 0)
 		return ret;
 
+	if (as3722->en_ac_ok_pwr_on)
+		val = AS3722_CTRL_SEQ1_AC_OK_PWR_ON;
+	ret = as3722_update_bits(as3722, AS3722_CTRL_SEQU1_REG,
+			AS3722_CTRL_SEQ1_AC_OK_PWR_ON, val);
+	if (ret < 0) {
+		dev_err(as3722->dev, "CTRL_SEQ1 update failed: %d\n", ret);
+		return ret;
+	}
+
 	ret = devm_mfd_add_devices(&i2c->dev, -1, as3722_devs,
 				   ARRAY_SIZE(as3722_devs), NULL, 0,
 				   regmap_irq_get_domain(as3722->irq_data));
diff --git a/include/linux/mfd/as3722.h b/include/linux/mfd/as3722.h
index 51e6f9414575..8841b9896033 100644
--- a/include/linux/mfd/as3722.h
+++ b/include/linux/mfd/as3722.h
@@ -296,6 +296,8 @@
 #define AS3722_ADC1_CONV_NOTREADY			BIT(7)
 #define AS3722_ADC1_SOURCE_SELECT_MASK			0x1F
 
+#define AS3722_CTRL_SEQ1_AC_OK_PWR_ON			BIT(0)
+
 /* GPIO modes */
 #define AS3722_GPIO_MODE_MASK				0x07
 #define AS3722_GPIO_MODE_INPUT				0x00
@@ -391,6 +393,7 @@ struct as3722 {
 	unsigned long irq_flags;
 	bool en_intern_int_pullup;
 	bool en_intern_i2c_pullup;
+	bool en_ac_ok_pwr_on;
 	struct regmap_irq_chip_data *irq_data;
 };
 
-- 
2.14.4

