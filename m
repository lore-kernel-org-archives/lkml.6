Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3B7C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9718A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NZkza4yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9718A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbeGZPQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:16:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54114 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:16:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so2093349wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=m9CCiwR/zhrqNdJ6Qi86kfoFuPrHTGpOo/Cqk2c9lMw=;
        b=NZkza4yogigBBOi5izjgx9CAY1ce3IXfSFLxmUy1TB4UQovCnPBny2wWmuPPw5D2Xn
         Fkdxi2tLXl9aP+jeqy6Z6IsjNtfouzYYkn8U4lRNi7nXCqE6pd5oURI8dP6p5c98Ys6K
         dam+D8uxPrX0AIzAnKOdI8aUWWBafjRDcFJSI4a3yWWlVKtZSUpbhq8K55GsLRxZniBm
         4dI6ieTTm1fNilkW4e3yvUV1ldZr4EQB6L7DBb+wZQX9LPblJ8o0ZgrGKiIBE/siPC7T
         ZRsqjkB/Dq5/chQ254R3gqx2Mt5ibXU7/SSYJxP6khIb7Rs/vnCyuLyyO79Jrvwl7Rn7
         lpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m9CCiwR/zhrqNdJ6Qi86kfoFuPrHTGpOo/Cqk2c9lMw=;
        b=S4/L6f2NMub3Fplt5lIictHXPEDGRK48nZOqDIv3TTusgkpsWaqLG8ClMsVVDIzkFn
         sMcONXOBnIK74d5RVmeElJAjJdIb1Z5K/Uo9hAk9hgokHYm3NFY3qsJwDQGufjS4FOvg
         08gywielBlSDxD0xcPcIeOyEueFN6V+EaRB9FPdfgeBCeP+LmQ0uIW66BmMz8q/vgduL
         vQG+DeTuBcauyvB7J6tg6wDPji9iUr+QWmbKJg25Fu+NffbuSo1H05YuRxi2i1M0XYVx
         AxoOEYJRIHz//17AItO4gtylQdyPUza15J35ie1L0oI797fHTXNkjYrWr0QzHCp4h0YU
         HJhg==
X-Gm-Message-State: AOUpUlGTTUdlwR80TEhK6usTH0G8qYvi251FXeeBLQibPkcL5I5z9tOh
        dqf7A0fhxHlCEU4CLRl+i/LCNA==
X-Google-Smtp-Source: AAOMgpdIZHKdxLrmyYhJum/5Lv0enqEOOoxtxcAtew9b7WQ3g8SRQ1Lkhv8AyyfbQkYIIPYSHmOwbg==
X-Received: by 2002:a1c:c4ce:: with SMTP id u197-v6mr1656860wmf.10.1532613559582;
        Thu, 26 Jul 2018 06:59:19 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s7-v6sm1754942wru.96.2018.07.26.06.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 06:59:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, carlo@caione.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: meson_sm: Add serial number sysfs entry
Date:   Thu, 26 Jul 2018 15:59:16 +0200
Message-Id: <1532613556-5398-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson SoC Secure Monitor implements a call to retrieve an unique
SoC ID starting from the GX Family and all new families.

The serial number is simply exposed as a sysfs entry under the firmware
sysfs directory.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/meson/meson_sm.c       | 56 +++++++++++++++++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h |  1 +
 2 files changed, 57 insertions(+)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 0ec2ca8..29fbc81 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -24,6 +24,7 @@
 #include <linux/printk.h>
 #include <linux/types.h>
 #include <linux/sizes.h>
+ #include <linux/slab.h>
 
 #include <linux/firmware/meson/meson_sm.h>
 
@@ -48,6 +49,7 @@ struct meson_sm_chip gxbb_chip = {
 		CMD(SM_EFUSE_READ,	0x82000030),
 		CMD(SM_EFUSE_WRITE,	0x82000031),
 		CMD(SM_EFUSE_USER_MAX,	0x82000033),
+		CMD(SM_GET_CHIP_ID,	0x82000044),
 		{ /* sentinel */ },
 	},
 };
@@ -214,6 +216,57 @@ int meson_sm_call_write(void *buffer, unsigned int size, unsigned int cmd_index,
 }
 EXPORT_SYMBOL(meson_sm_call_write);
 
+#define SM_CHIP_ID_LENGTH	119
+#define SM_CHIP_ID_OFFSET	4
+#define SM_CHIP_ID_SIZE		12
+
+static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	uint8_t *id_buf;
+	int ret;
+
+	id_buf = kmalloc(SM_CHIP_ID_LENGTH, GFP_KERNEL);
+	if (!id_buf)
+		return -ENOMEM;
+
+	ret = meson_sm_call_read(id_buf, SM_CHIP_ID_LENGTH, SM_GET_CHIP_ID,
+				 0, 0, 0, 0, 0);
+	if (ret < 0) {
+		kfree(id_buf);
+		return ret;
+	}
+
+	ret = sprintf(buf, "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x\n",
+			id_buf[SM_CHIP_ID_OFFSET + 0],
+			id_buf[SM_CHIP_ID_OFFSET + 1],
+			id_buf[SM_CHIP_ID_OFFSET + 2],
+			id_buf[SM_CHIP_ID_OFFSET + 3],
+			id_buf[SM_CHIP_ID_OFFSET + 4],
+			id_buf[SM_CHIP_ID_OFFSET + 5],
+			id_buf[SM_CHIP_ID_OFFSET + 6],
+			id_buf[SM_CHIP_ID_OFFSET + 7],
+			id_buf[SM_CHIP_ID_OFFSET + 8],
+			id_buf[SM_CHIP_ID_OFFSET + 9],
+			id_buf[SM_CHIP_ID_OFFSET + 10],
+			id_buf[SM_CHIP_ID_OFFSET + 11]);
+
+	kfree(id_buf);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(serial);
+
+static struct attribute *meson_sm_sysfs_attributes[] = {
+	&dev_attr_serial.attr,
+	NULL,
+};
+
+static const struct attribute_group meson_sm_sysfs_attr_group = {
+	.attrs = meson_sm_sysfs_attributes,
+};
+
 static const struct of_device_id meson_sm_ids[] = {
 	{ .compatible = "amlogic,meson-gxbb-sm", .data = &gxbb_chip },
 	{ /* sentinel */ },
@@ -242,6 +295,9 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 	fw.chip = chip;
 	pr_info("secure-monitor enabled\n");
 
+	if (sysfs_create_group(&pdev->dev.kobj, &meson_sm_sysfs_attr_group))
+		goto out_in_base;
+
 	return 0;
 
 out_in_base:
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 37a5eae..f98c20d 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -17,6 +17,7 @@ enum {
 	SM_EFUSE_READ,
 	SM_EFUSE_WRITE,
 	SM_EFUSE_USER_MAX,
+	SM_GET_CHIP_ID,
 };
 
 struct meson_sm_firmware;
-- 
2.7.4

