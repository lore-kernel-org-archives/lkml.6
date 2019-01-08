Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E9CC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA442183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lMGGq/1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfAHJQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44789 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfAHJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:16:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so3434478edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYduuyLykfVkK02cpHVrshV0EAassw2QUbxst2VbhOo=;
        b=lMGGq/1/+RrKG+Y5iaA+D1X2h4tWmXYaeKoUan2/+LY4VCG52v/a/N8FhFabzjD/aZ
         6RUMHAabT3uwztPOYb32kL576UldulvYC3r+ev8KBIlfg9QFJYx+ZmyokTy7dKnHKdcI
         AL3qnndA/2nVB631bAQCMRjGXtjJ4+qgF7BdZiK/VkqxaPoj79RjL+6bjRcCX38gA6Px
         DiNzE0VNeFKanncYsZOm7KK0su6rc/vjolE7NE40n6QxCtfMrI7WfGpKhg3w4p3IUXIZ
         8Xo0lARxBwv0BQIltA4C+lBvD1azWXt0wHjV6n84EEh5xFbXW8wCwPMgBMjv4LAcDuW6
         90rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYduuyLykfVkK02cpHVrshV0EAassw2QUbxst2VbhOo=;
        b=E7d3Ubsfkdh7cCgprwdDlE7gwYBlyKOSVCb8vIpnoXuuD0l1kFgDeZjSiOz5LcXmDe
         fxM1JixtmSm66Dydo1PelCqWufG/fzeFz6vUxoeJewXVFiB8yGBDKZeork3sZBrwyazw
         VvSpwIY+wuMyBos/ZIawzbUSAtylGBqYwstjanGfWHQa9ks/b0Hh3Oc18aYNzFPDJ3TQ
         WDycuJ9i7uPWJtCUSV+kShBEJrWHhDkw3txA4ncqcJsW4cbklz3kqcu7DNMHxrsIGl0q
         swMPFTEb7dHt8akxdDuGL6H0oQxWeihwHDZHvEGRyqelEMlnUvHNTeFpORdcjezpgD5z
         zl2Q==
X-Gm-Message-State: AJcUukeyWpA400RYSfvq8cUUpsEvv2dWGk3v+Q0KYZutzLej/7Z81Cbm
        8BMoMx46qCtVQDBjST2deUkvTQ==
X-Google-Smtp-Source: ALg8bN7EBiqcXgy8zu4HyKYCXHdhSNO6sw6k4tpeRnsjRlFlsQIaCJc98mEtHhWPY6DIkqmj3wqeDg==
X-Received: by 2002:a05:6402:1347:: with SMTP id y7mr1309667edw.114.1546938964858;
        Tue, 08 Jan 2019 01:16:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:16:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 12/12] eeprom: at24: remove at24_platform_data
Date:   Tue,  8 Jan 2019 10:15:39 +0100
Message-Id: <20190108091539.16674-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of at24_platform_data. Remove the relevant
header and modify the driver code to not use it anymore.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS                        |   1 -
 drivers/misc/eeprom/at24.c         | 162 +++++++++++++----------------
 include/linux/platform_data/at24.h |  60 -----------
 3 files changed, 75 insertions(+), 148 deletions(-)
 delete mode 100644 include/linux/platform_data/at24.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..767c1e0e5cf7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2503,7 +2503,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/eeprom/at24.txt
 F:	drivers/misc/eeprom/at24.c
-F:	include/linux/platform_data/at24.h
 
 ATA OVER ETHERNET (AOE) DRIVER
 M:	"Ed L. Cashin" <ed.cashin@acm.org>
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ddfcf4ade7bf..b806a403ca46 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -22,10 +22,24 @@
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
 #include <linux/regmap.h>
-#include <linux/platform_data/at24.h>
 #include <linux/pm_runtime.h>
 #include <linux/gpio/consumer.h>
 
+/* Address pointer is 16 bit. */
+#define AT24_FLAG_ADDR16	BIT(7)
+/* sysfs-entry will be read-only. */
+#define AT24_FLAG_READONLY	BIT(6)
+/* sysfs-entry will be world-readable. */
+#define AT24_FLAG_IRUGO		BIT(5)
+/* Take always 8 addresses (24c00). */
+#define AT24_FLAG_TAKE8ADDR	BIT(4)
+/* Factory-programmed serial number. */
+#define AT24_FLAG_SERIAL	BIT(3)
+/* Factory-programmed mac address. */
+#define AT24_FLAG_MAC		BIT(2)
+/* Does not auto-rollover reads to the next slave address. */
+#define AT24_FLAG_NO_RDROL	BIT(1)
+
 /*
  * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
  * Differences between different vendor product lines (like Atmel AT24C or
@@ -107,10 +121,6 @@ module_param_named(write_timeout, at24_write_timeout, uint, 0);
 MODULE_PARM_DESC(at24_write_timeout, "Time (in ms) to try writes (default 25)");
 
 struct at24_chip_data {
-	/*
-	 * these fields mirror their equivalents in
-	 * struct at24_platform_data
-	 */
 	u32 byte_len;
 	u8 flags;
 };
@@ -471,63 +481,11 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	return 0;
 }
 
-static void at24_properties_to_pdata(struct device *dev,
-				     struct at24_platform_data *chip)
-{
-	int err;
-	u32 val;
-
-	if (device_property_present(dev, "read-only"))
-		chip->flags |= AT24_FLAG_READONLY;
-	if (device_property_present(dev, "no-read-rollover"))
-		chip->flags |= AT24_FLAG_NO_RDROL;
-
-	err = device_property_read_u32(dev, "address-width", &val);
-	if (!err) {
-		switch (val) {
-		case 8:
-			if (chip->flags & AT24_FLAG_ADDR16)
-				dev_warn(dev, "Override address width to be 8, while default is 16\n");
-			chip->flags &= ~AT24_FLAG_ADDR16;
-			break;
-		case 16:
-			chip->flags |= AT24_FLAG_ADDR16;
-			break;
-		default:
-			dev_warn(dev, "Bad \"address-width\" property: %u\n",
-				 val);
-		}
-	}
-
-	err = device_property_read_u32(dev, "size", &val);
-	if (!err)
-		chip->byte_len = val;
-
-	err = device_property_read_u32(dev, "pagesize", &val);
-	if (!err) {
-		chip->page_size = val;
-	} else {
-		/*
-		 * This is slow, but we can't know all eeproms, so we better
-		 * play safe. Specifying custom eeprom-types via platform_data
-		 * is recommended anyhow.
-		 */
-		chip->page_size = 1;
-	}
-}
-
-static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
+static const struct at24_chip_data *at24_get_chip_data(struct device *dev)
 {
 	struct device_node *of_node = dev->of_node;
 	const struct at24_chip_data *cdata;
 	const struct i2c_device_id *id;
-	struct at24_platform_data *pd;
-
-	pd = dev_get_platdata(dev);
-	if (pd) {
-		memcpy(pdata, pd, sizeof(*pdata));
-		return 0;
-	}
 
 	id = i2c_match_id(at24_ids, to_i2c_client(dev));
 
@@ -544,13 +502,9 @@ static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
 		cdata = acpi_device_get_match_data(dev);
 
 	if (!cdata)
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
-	pdata->byte_len = cdata->byte_len;
-	pdata->flags = cdata->flags;
-	at24_properties_to_pdata(dev, pdata);
-
-	return 0;
+	return cdata;
 }
 
 static void at24_remove_dummy_clients(struct at24_data *at24)
@@ -619,7 +573,8 @@ static int at24_probe(struct i2c_client *client)
 {
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
-	struct at24_platform_data pdata = { };
+	u32 byte_len, page_size, flags, addrw;
+	const struct at24_chip_data *cdata;
 	struct device *dev = &client->dev;
 	bool i2c_fn_i2c, i2c_fn_block;
 	unsigned int i, num_addresses;
@@ -634,35 +589,72 @@ static int at24_probe(struct i2c_client *client)
 	i2c_fn_block = i2c_check_functionality(client->adapter,
 					       I2C_FUNC_SMBUS_WRITE_I2C_BLOCK);
 
-	err = at24_get_pdata(dev, &pdata);
+	cdata = at24_get_chip_data(dev);
+	if (IS_ERR(cdata))
+		return PTR_ERR(cdata);
+
+	err = device_property_read_u32(dev, "pagesize", &page_size);
 	if (err)
-		return err;
+		/*
+		 * This is slow, but we can't know all eeproms, so we better
+		 * play safe. Specifying custom eeprom-types via platform_data
+		 * is recommended anyhow.
+		 */
+		page_size = 1;
+
+	flags = cdata->flags;
+	if (device_property_present(dev, "read-only"))
+		flags |= AT24_FLAG_READONLY;
+	if (device_property_present(dev, "no-read-rollover"))
+		flags |= AT24_FLAG_NO_RDROL;
+
+	err = device_property_read_u32(dev, "address-width", &addrw);
+	if (!err) {
+		switch (addrw) {
+		case 8:
+			if (flags & AT24_FLAG_ADDR16)
+				dev_warn(dev,
+					 "Override address width to be 8, while default is 16\n");
+			flags &= ~AT24_FLAG_ADDR16;
+			break;
+		case 16:
+			flags |= AT24_FLAG_ADDR16;
+			break;
+		default:
+			dev_warn(dev, "Bad \"address-width\" property: %u\n",
+				 addrw);
+		}
+	}
+
+	err = device_property_read_u32(dev, "size", &byte_len);
+	if (err)
+		byte_len = cdata->byte_len;
 
 	if (!i2c_fn_i2c && !i2c_fn_block)
-		pdata.page_size = 1;
+		page_size = 1;
 
-	if (!pdata.page_size) {
+	if (!page_size) {
 		dev_err(dev, "page_size must not be 0!\n");
 		return -EINVAL;
 	}
 
-	if (!is_power_of_2(pdata.page_size))
+	if (!is_power_of_2(page_size))
 		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
-	if (pdata.flags & AT24_FLAG_TAKE8ADDR)
+	if (flags & AT24_FLAG_TAKE8ADDR)
 		num_addresses = 8;
 	else
-		num_addresses =	DIV_ROUND_UP(pdata.byte_len,
-			(pdata.flags & AT24_FLAG_ADDR16) ? 65536 : 256);
+		num_addresses =	DIV_ROUND_UP(byte_len,
+			(flags & AT24_FLAG_ADDR16) ? 65536 : 256);
 
-	if ((pdata.flags & AT24_FLAG_SERIAL) && (pdata.flags & AT24_FLAG_MAC)) {
+	if ((flags & AT24_FLAG_SERIAL) && (flags & AT24_FLAG_MAC)) {
 		dev_err(dev,
 			"invalid device data - cannot have both AT24_FLAG_SERIAL & AT24_FLAG_MAC.");
 		return -EINVAL;
 	}
 
 	regmap_config.val_bits = 8;
-	regmap_config.reg_bits = (pdata.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	regmap_config.reg_bits = (flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
 
 	regmap = devm_regmap_init_i2c(client, &regmap_config);
@@ -675,11 +667,11 @@ static int at24_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	mutex_init(&at24->lock);
-	at24->byte_len = pdata.byte_len;
-	at24->page_size = pdata.page_size;
-	at24->flags = pdata.flags;
+	at24->byte_len = byte_len;
+	at24->page_size = page_size;
+	at24->flags = flags;
 	at24->num_addresses = num_addresses;
-	at24->offset_adj = at24_get_offset_adj(pdata.flags, pdata.byte_len);
+	at24->offset_adj = at24_get_offset_adj(flags, byte_len);
 	at24->client[0].client = client;
 	at24->client[0].regmap = regmap;
 
@@ -687,10 +679,10 @@ static int at24_probe(struct i2c_client *client)
 	if (IS_ERR(at24->wp_gpio))
 		return PTR_ERR(at24->wp_gpio);
 
-	writable = !(pdata.flags & AT24_FLAG_READONLY);
+	writable = !(flags & AT24_FLAG_READONLY);
 	if (writable) {
 		at24->write_max = min_t(unsigned int,
-					pdata.page_size, at24_io_limit);
+					page_size, at24_io_limit);
 		if (!i2c_fn_i2c && at24->write_max > I2C_SMBUS_BLOCK_MAX)
 			at24->write_max = I2C_SMBUS_BLOCK_MAX;
 	}
@@ -733,7 +725,7 @@ static int at24_probe(struct i2c_client *client)
 	nvmem_config.priv = at24;
 	nvmem_config.stride = 1;
 	nvmem_config.word_size = 1;
-	nvmem_config.size = pdata.byte_len;
+	nvmem_config.size = byte_len;
 
 	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
 	if (IS_ERR(at24->nvmem)) {
@@ -742,13 +734,9 @@ static int at24_probe(struct i2c_client *client)
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
-		 pdata.byte_len, client->name,
+		 byte_len, client->name,
 		 writable ? "writable" : "read-only", at24->write_max);
 
-	/* export data to kernel code */
-	if (pdata.setup)
-		pdata.setup(at24->nvmem, pdata.context);
-
 	return 0;
 
 err_clients:
diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
deleted file mode 100644
index 63507ff464ee..000000000000
--- a/include/linux/platform_data/at24.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * at24.h - platform_data for the at24 (generic eeprom) driver
- * (C) Copyright 2008 by Pengutronix
- * (C) Copyright 2012 by Wolfram Sang
- * same license as the driver
- */
-
-#ifndef _LINUX_AT24_H
-#define _LINUX_AT24_H
-
-#include <linux/types.h>
-#include <linux/nvmem-consumer.h>
-#include <linux/bitops.h>
-
-/**
- * struct at24_platform_data - data to set up at24 (generic eeprom) driver
- * @byte_len: size of eeprom in byte
- * @page_size: number of byte which can be written in one go
- * @flags: tunable options, check AT24_FLAG_* defines
- * @setup: an optional callback invoked after eeprom is probed; enables kernel
-	code to access eeprom via nvmem, see example
- * @context: optional parameter passed to setup()
- *
- * If you set up a custom eeprom type, please double-check the parameters.
- * Especially page_size needs extra care, as you risk data loss if your value
- * is bigger than what the chip actually supports!
- *
- * An example in pseudo code for a setup() callback:
- *
- * void get_mac_addr(struct nvmem_device *nvmem, void *context)
- * {
- *	u8 *mac_addr = ethernet_pdata->mac_addr;
- *	off_t offset = context;
- *
- *	// Read MAC addr from EEPROM
- *	if (nvmem_device_read(nvmem, offset, ETH_ALEN, mac_addr) == ETH_ALEN)
- *		pr_info("Read MAC addr from EEPROM: %pM\n", mac_addr);
- * }
- *
- * This function pointer and context can now be set up in at24_platform_data.
- */
-
-struct at24_platform_data {
-	u32		byte_len;		/* size (sum of all addr) */
-	u16		page_size;		/* for writes */
-	u8		flags;
-#define AT24_FLAG_ADDR16	BIT(7)	/* address pointer is 16 bit */
-#define AT24_FLAG_READONLY	BIT(6)	/* sysfs-entry will be read-only */
-#define AT24_FLAG_IRUGO		BIT(5)	/* sysfs-entry will be world-readable */
-#define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
-#define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
-#define AT24_FLAG_MAC		BIT(2)	/* factory-programmed mac address */
-#define AT24_FLAG_NO_RDROL	BIT(1)	/* does not auto-rollover reads to */
-					/* the next slave address */
-
-	void		(*setup)(struct nvmem_device *nvmem, void *context);
-	void		*context;
-};
-
-#endif /* _LINUX_AT24_H */
-- 
2.19.1

