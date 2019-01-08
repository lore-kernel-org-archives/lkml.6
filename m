Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1ACC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5B62089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="q6QpXxqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfAHD5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:57:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44093 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfAHD5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:57:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so1090014pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 19:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Phue9K3b18E6tBPB72fQB7pO/am4rKViU95kxXzrZY=;
        b=q6QpXxqfCHkSeG6V+I7848S8PBjyt+RGR0iSQLywNcvemVs07SlWr4SAU3ESSrhHRt
         rYl4apNe/6TYywcTNRyaiZ1yM5yswQ7UfNdW3RoVNW4647Jf+R922SA0g3k86aONr62H
         vFEGGNxs0y9V/JwayF4akrwJVOng+zMn7MxPUps1es6u8Pz3YWwPJGqu70vGn7iN5MoI
         Nfz+/LS7ae3HF3jpclixsb78r3OEsyLMnYkFi3JjX9ifJx86xt6pyDWsCGlro6G0ptef
         hgV4TWavG73cOvlCCutETeSZC4chSC4VFDi9HjU245WoLXTd1igVWjKHTXN/4Ztf389y
         anbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Phue9K3b18E6tBPB72fQB7pO/am4rKViU95kxXzrZY=;
        b=KmFjAroS+ptbflWvysuxoivlrDt7yowaWgzO3VOrTBA+21sQwtyCT6sb6Bbl6lGwFx
         wZJlREd80GN6Da3uEg7h2QrHMhUdYonK3gNXjaY2ML6otsagxzIWITC43gnoOlwXxqqU
         5ijx3n0QHigZTdYu9IJoiuC9pJsNfic5dukUfDWayXi8wFUQ4xC/9Ps9b6dHh1uG9Sid
         o20ETjz/efHt9QO4PLY/NyaNDDtkHm7hrpX/ZMne39HkUdVSQ6RKY+kwLYIoH98XgxNE
         OitFvdurY2Tgg/uRGyd6TCx200zhnDmffcJXA5UErXqgUFFUYZAllivEcrBsTObgpET2
         Cn4Q==
X-Gm-Message-State: AJcUukdVM31vS2c6fdwOsKytnIPsM7Z60g1aoXQLI0yZfmO2vsm7QU4Z
        gDXRqqe614+NvRsQ6IRSGcLhUja2uvs=
X-Google-Smtp-Source: ALg8bN7aAOrSeFQabShCO5SBYj0BfUWf4VkJIpxlI84YmsDMfhsUw8jdA3G1fyPtIB+gqWOx+h2GDA==
X-Received: by 2002:a63:3d1:: with SMTP id 200mr167612pgd.68.1546919823741;
        Mon, 07 Jan 2019 19:57:03 -0800 (PST)
Received: from localhost ([2601:647:4700:93d:6db5:e35d:dacd:7872])
        by smtp.gmail.com with ESMTPSA id n22sm134729001pfh.166.2019.01.07.19.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 19:57:03 -0800 (PST)
From:   Moritz Fischer <moritz.fischer@ettus.com>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, lee.jones@linaro.org, moritz@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2] platform/chrome: Add cros_ec_readmem() helpers for I2C/SPI based ECs
Date:   Mon,  7 Jan 2019 19:56:38 -0800
Message-Id: <20190108035638.9685-1-moritz.fischer@ettus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Add cros_ec_readmem() based helpers for I2C/SPI based ECs.
Unlike the LPC based ECs the I2C/SPI based ones cannot just directly
read the mapped region.

This is useful for things like accessing fan speeds or temperatures.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi all,


I had submitted this back in May 2017 [1] and then somewhat forgot
about it. So here's a new version :)

As to why is this required? we're using this in some of our devices
[2] that run a modified firmware based on Chromium-EC.
I've been carrying the patch downstream in our tree for a while and
it would be nice if we can merge this upstream so I can stop rebasing
this :)

Thanks,

Moritz

[1] https://lore.kernel.org/patchwork/patch/786065/ 
[2] https://www.ettus.com/product/details/USRP-E320 

---
 drivers/platform/chrome/cros_ec_i2c.c   |  1 +
 drivers/platform/chrome/cros_ec_proto.c | 38 +++++++++++++++++++++++++
 drivers/platform/chrome/cros_ec_spi.c   |  1 +
 include/linux/mfd/cros_ec.h             | 12 ++++++++
 4 files changed, 52 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index ef9b4763356f..c3a9bee37b1d 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -303,6 +303,7 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
 	ec_dev->irq = client->irq;
 	ec_dev->cmd_xfer = cros_ec_cmd_xfer_i2c;
 	ec_dev->pkt_xfer = cros_ec_pkt_xfer_i2c;
+	ec_dev->cmd_readmem = cros_ec_readmem;
 	ec_dev->phys_name = client->adapter->name;
 	ec_dev->din_size = sizeof(struct ec_host_response_i2c) +
 			   sizeof(struct ec_response_get_protocol_info);
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index cc7baf0ecb3c..2f1d45a7a934 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -636,3 +636,41 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 	return host_event;
 }
 EXPORT_SYMBOL(cros_ec_get_host_event);
+
+int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
+		    unsigned int bytes, void *dest)
+{
+	int ret;
+	struct ec_params_read_memmap *params;
+	struct cros_ec_command *msg;
+
+	if (offset >= EC_MEMMAP_SIZE - bytes)
+		return -EINVAL;
+
+	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), bytes), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = 0;
+	msg->command = EC_CMD_READ_MEMMAP;
+	msg->insize = bytes;
+	msg->outsize = sizeof(*params);
+
+	params = (struct ec_params_read_memmap *)msg->data;
+	params->offset = offset;
+	params->size = bytes;
+
+	ret = cros_ec_cmd_xfer_status(ec, msg);
+	if (ret < 0) {
+		dev_warn(ec->dev, "cannot read mapped reg: %d/%d\n",
+			 ret, msg->result);
+		goto out_free;
+	}
+
+	memcpy(dest, msg->data, bytes);
+
+out_free:
+	kfree(msg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cros_ec_readmem);
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 2060d1483043..b95c1a25adfc 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -666,6 +666,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	ec_dev->irq = spi->irq;
 	ec_dev->cmd_xfer = cros_ec_cmd_xfer_spi;
 	ec_dev->pkt_xfer = cros_ec_pkt_xfer_spi;
+	ec_dev->cmd_readmem = cros_ec_readmem;
 	ec_dev->phys_name = dev_name(&ec_spi->spi->dev);
 	ec_dev->din_size = EC_MSG_PREAMBLE_COUNT +
 			   sizeof(struct ec_host_response) +
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index de8b588c8776..0228fb42dcda 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -335,6 +335,18 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
  */
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
+/**
+ * cros_ec_readmem - Read mapped memory in the ChromeOS EC
+ *
+ * @ec: Device to read from
+ * @offset: Offset to read within the mapped region
+ * @bytes: number of bytes to read
+ * @data: Return data
+ * @return: 0 if Ok, -ve on error
+ */
+int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
+		    unsigned int bytes, void *dest);
+
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
 extern struct attribute_group cros_ec_lightbar_attr_group;
-- 
2.20.1

