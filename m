Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id I4CFJuA+GlviSQAAmS7hNA
	; Fri, 08 Jun 2018 08:31:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8D6F0608BA; Fri,  8 Jun 2018 08:31:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 08B65606FA;
	Fri,  8 Jun 2018 08:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08B65606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeFHIbZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:31:25 -0400
Received: from regular1.263xmail.com ([211.150.99.140]:46194 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbeFHIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:31:22 -0400
Received: from jay.xu?rock-chips.com (unknown [192.168.167.83])
        by regular1.263xmail.com (Postfix) with ESMTP id 4AA044B72;
        Fri,  8 Jun 2018 16:31:15 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 9060F369;
        Fri,  8 Jun 2018 16:31:11 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: jay.xu@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: jay.xu@rock-chips.com
X-UNIQUE-TAG: <4e92f1444f758af31928676b2b0d1df8>
X-ATTACHMENT-NUM: 0
X-SENDER: xjq@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 22850JBR8YG;
        Fri, 08 Jun 2018 16:31:14 +0800 (CST)
From: Jianqun Xu <jay.xu@rock-chips.com>
To: robh+dt@kernel.org, heiko@sntech.de, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        jay.xu@rock-chips.com, broonie@kernel.org
Cc: shawn.lin@rock-chips.com, kever.yang@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rockchip: add config for rockchip dmaengine pcm register
Date: Fri,  8 Jun 2018 16:31:09 +0800
Message-Id: <1528446669-18141-1-git-send-email-jay.xu@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the rockchip i2s pcm configurable by adding
rockchip pcm config for devm_snd_dmaengine_pcm_register.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/Makefile       |  3 ++-
 sound/soc/rockchip/rockchip_i2s.c |  3 ++-
 sound/soc/rockchip/rockchip_pcm.c | 45 +++++++++++++++++++++++++++++++++++++++
 sound/soc/rockchip/rockchip_pcm.h | 14 ++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/rockchip/rockchip_pcm.c
 create mode 100644 sound/soc/rockchip/rockchip_pcm.h

diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 05b078e..65e814d 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # ROCKCHIP Platform Support
 snd-soc-rockchip-i2s-objs := rockchip_i2s.o
+snd-soc-rockchip-pcm-objs := rockchip_pcm.o
 snd-soc-rockchip-pdm-objs := rockchip_pdm.o
 snd-soc-rockchip-spdif-objs := rockchip_spdif.o
 
-obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o snd-soc-rockchip-pcm.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_PDM) += snd-soc-rockchip-pdm.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-rockchip-spdif.o
 
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 908211e..5e60181 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -22,6 +22,7 @@
 #include <sound/dmaengine_pcm.h>
 
 #include "rockchip_i2s.h"
+#include "rockchip_pcm.h"
 
 #define DRV_NAME "rockchip-i2s"
 
@@ -667,7 +668,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = rockchip_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
 		return ret;
diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
new file mode 100644
index 0000000..f775383
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "rockchip_pcm.h"
+
+static const struct snd_pcm_hardware snd_rockchip_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_PAUSE |
+				  SNDRV_PCM_INFO_RESUME,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 8192,
+	.periods_min		= 1,
+	.periods_max		= 52,
+	.buffer_bytes_max	= 64 * 1024,
+	.fifo_size		= 32,
+};
+
+static const struct snd_dmaengine_pcm_config rk_dmaengine_pcm_config = {
+	.pcm_hardware = &snd_rockchip_hardware,
+	.prealloc_buffer_size = 32 * 1024,
+};
+
+int rockchip_pcm_platform_register(struct device *dev)
+{
+	return devm_snd_dmaengine_pcm_register(dev, &rk_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
+}
+EXPORT_SYMBOL_GPL(rockchip_pcm_platform_register);
+
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/rockchip/rockchip_pcm.h b/sound/soc/rockchip/rockchip_pcm.h
new file mode 100644
index 0000000..d6c3611
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_pcm.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ROCKCHIP_PCM_H
+#define _ROCKCHIP_PCM_H
+
+int rockchip_pcm_platform_register(struct device *dev);
+
+#endif
-- 
1.9.1
