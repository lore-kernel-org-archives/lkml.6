Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49488208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49488208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933948AbeGCPOh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:14:37 -0400
Received: from mout.perfora.net ([74.208.4.197]:40589 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932648AbeGCPJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:09:36 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MLgwf-1fZXu71GiZ-000rNI; Tue, 03 Jul 2018 17:04:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2] mfd: as3722: disable auto power on when AC OK
Date:   Tue,  3 Jul 2018 17:04:11 +0200
Message-Id: <20180703150411.29709-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:HafWlSOL0eAqKzo2QzBTG1HOaWM/l4n3sKTXyZ/iJ0YrS+xD5O3
 kof1bES7yX5bBfwAQbmy0YQWFzQD6fG9vUkbc1+ICXz1i58sn3HghEb9tYUuEf4ZK8tAXpP
 /VxCzc1Jvm7c6+4s+Nv0hahC0bGy/gFaH+C3B3g2amxno/npaCVvEgZ6HbGkSm2th8jVWbT
 EeQSB0JOA3nr8QK2AaAdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c8afnf1Uxo0=:+rbfrk3Kzc/3SF+Ax4bdXw
 eZWYI/xQIRomvbkRnsY9b2fKQT7QkkEyJ+0edEacS2LZr5oB0NB6NNeXsPBavBC7kTj/CayhR
 x9ehGQiWjUhNKtQtmE7bGE7Z8fDkfsHBJPquzAud+5i+uGtZRcYRUBGM2MqkYEEzr5W3Oct1n
 TK0KSylYYcNP1DDfXecDMmAlkUL+SmvgaKAcC9BhRrOwgvuJeWFh7AuFvWi5czF4eJR/XnFpE
 ei03sEPyFrS5ToLWo6WlEJLZoddagZ3QI7nLveoFZ26jR7ISH6MJU9d6N5XWWO8m9LqRLu88O
 xWTqxULx/g9NsfFTaD5y6smqMq2zc3zcGeX9bpR6rMJR/Pht9A2//5E8f57wlCigeWNTW0OUp
 7jySzEljWSAoNqkRN1iw0E/v2C5ND588NbahsBt/Z4rcJGSmtayL5sunYAmcB2cZinKQagHKh
 t5HtbKq43vcU5KA8d3qDhcRTkBfQrnXz+bdbYEa2FbV4V7/V5yoYqRFUJL+6vvN0Ug/Op+D/n
 HEhCd9L1DZA0QUubiztEK0GxO8c0HkzpTaJMsn9j5hYv+bHnvbRPblq8q5hnT9SG8Gn04elG0
 7PmUZ/Ef946Q4bLMRP8fJ/4ufAjEzDb8NgbFxt3DU+xXj0dZlG6DewYw0SMi49AzA4pjNWxhg
 cVFKjeuhBjWVb2hurkxZiWCmFoTj8JmftWTT+54m7drt88ouzd012CWw9fnFv8NA/L7I=
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
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Document device tree property as suggested by Stefan.
- Rename SEQ1 to SEQU1 as per datasheet as suggested by Stefan.
- Drop reference to downstream commit as suggested by Lee.

 Documentation/devicetree/bindings/mfd/as3722.txt |  2 ++
 drivers/mfd/as3722.c                             | 12 ++++++++++++
 include/linux/mfd/as3722.h                       |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/as3722.txt b/Documentation/devicetree/bindings/mfd/as3722.txt
index 5297b2210704..2a665741d7fe 100644
--- a/Documentation/devicetree/bindings/mfd/as3722.txt
+++ b/Documentation/devicetree/bindings/mfd/as3722.txt
@@ -20,6 +20,8 @@ Optional properties:
 - ams,enable-internal-i2c-pullup: Boolean property, to enable internal pullup on
 	i2c scl/sda pins. Missing this will disable internal pullup on i2c
 	scl/sda lines.
+- ams,enable-ac-ok-power-on: Boolean property, to enable exit out of power off
+	mode with AC_OK pin (pin enabled in power off mode).
 
 Optional submodule and their properties:
 =======================================
diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index f87342c211bc..4d069ed21ff6 100644
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
+		val = AS3722_CTRL_SEQU1_AC_OK_PWR_ON;
+	ret = as3722_update_bits(as3722, AS3722_CTRL_SEQU1_REG,
+			AS3722_CTRL_SEQU1_AC_OK_PWR_ON, val);
+	if (ret < 0) {
+		dev_err(as3722->dev, "CTRLsequ1 update failed: %d\n", ret);
+		return ret;
+	}
+
 	ret = devm_mfd_add_devices(&i2c->dev, -1, as3722_devs,
 				   ARRAY_SIZE(as3722_devs), NULL, 0,
 				   regmap_irq_get_domain(as3722->irq_data));
diff --git a/include/linux/mfd/as3722.h b/include/linux/mfd/as3722.h
index 51e6f9414575..b404a5af9bba 100644
--- a/include/linux/mfd/as3722.h
+++ b/include/linux/mfd/as3722.h
@@ -296,6 +296,8 @@
 #define AS3722_ADC1_CONV_NOTREADY			BIT(7)
 #define AS3722_ADC1_SOURCE_SELECT_MASK			0x1F
 
+#define AS3722_CTRL_SEQU1_AC_OK_PWR_ON			BIT(0)
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

