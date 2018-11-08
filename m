Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D394C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3124D20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="POs29XcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3124D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeKHWZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:25:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34858 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeKHWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:25:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15-v6so1099777wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkZaCRo2zaKnU4q4rgttYNexn9XZNPQYchlDiiglfeA=;
        b=POs29XcKSJ+Osg56eob86xqMnKkpzaPJhCixt8Ooj3mtV7gEsriApCb71VBKUO48c1
         AZgQ/gjS7/GvPVxX2Yyu8+RTp4/YnUKGci29D/3wP1IrIBb800MG0mrLGom1BkDFfS9s
         tGaZQ+TpRqdvXpZLoxbXKLqct8GM93AQ5hw36nI4fEMly2s8K6fnciAqPFOiDVMgtgAZ
         s5GgYPrbDIQ2OF6FNtF97d5IoeR1fUKjMOgBFKqeyNba7Lmy9FtHSa3GSPGFd1m+pVSm
         Mu6iTyKfuCZM2SR9v5gDkplLqEX9W/qQSP1WWmzIStUKYzTHfD0/VPmgZ3aNCofQGLNx
         hJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkZaCRo2zaKnU4q4rgttYNexn9XZNPQYchlDiiglfeA=;
        b=sgRlHNZG7ifdHRwk3xVvsQGAbz4NLrYfa1ofoAULzNQ/OXgy6DWjjSj3CZ2L+2uF/s
         nU16FU7qiK6j9wmLpDYJP8vSa6cYqg67lbOhHESOhoaAigCjvlJGZxqRnKTa+jezfaMz
         ey9Vr2zz5h21JOlFzwlsBTYtOtatK4TiJvLK0nAeazKFQk6VMJSLaKQrV6HaSu7bdPBd
         Zu7FsORqlOF3aJkAnGdSqX6ApS0QvQ/dfeBmKTsjwwrHgHuFDf/wHhJOnka1jYq8yRZL
         ADTpBObv97oxJcBCo7kaUTmxzaK687gifTRFET6WX7TIk5BEV0AcUUSmJWT5yt3cT0SK
         t/2A==
X-Gm-Message-State: AGRZ1gKzyVBbSvoDezqeihbR8tlA2IqBF+fcQRGClB8TjKYhtkxPSh4U
        uw2Wc1ujzV8105ItDuEMKhB55g==
X-Google-Smtp-Source: AJdET5fZaWG3YR/6zKy2dBTCaPdGFqk+oQfKw8B8lyIzM3KBshKw9OhMSgzfUUH+0g2Xx7MYq11U1Q==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr1059495wmk.89.1541681413179;
        Thu, 08 Nov 2018 04:50:13 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2470014wru.88.2018.11.08.04.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 04:50:12 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Yasunari.Takiguchi@sony.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: cxd2880-spi: Add optional vcc regulator
Date:   Thu,  8 Nov 2018 13:50:09 +0100
Message-Id: <1541681410-8187-2-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
References: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds an optional VCC regulator to the driver probe function to
make sure power is enabled to the module before starting attaching to
the device.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/media/spi/cxd2880-spi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/spi/cxd2880-spi.c b/drivers/media/spi/cxd2880-spi.c
index c437309..d5c433e 100644
--- a/drivers/media/spi/cxd2880-spi.c
+++ b/drivers/media/spi/cxd2880-spi.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
 
 #include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
 #include <linux/ktime.h>
 
 #include <media/dvb_demux.h>
@@ -51,6 +52,7 @@ struct cxd2880_dvb_spi {
 	struct mutex spi_mutex; /* For SPI access exclusive control */
 	int feed_count;
 	int all_pid_feed_count;
+	struct regulator *vcc_supply;
 	u8 *ts_buf;
 	struct cxd2880_pid_filter_config filter_config;
 };
@@ -518,6 +520,17 @@ cxd2880_spi_probe(struct spi_device *spi)
 	if (!dvb_spi)
 		return -ENOMEM;
 
+	dvb_spi->vcc_supply = devm_regulator_get_optional(&spi->dev, "vcc");
+	if (IS_ERR(dvb_spi->vcc_supply)) {
+		if (PTR_ERR(dvb_spi->vcc_supply) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dvb_spi->vcc_supply = NULL;
+	} else {
+		ret = regulator_enable(dvb_spi->vcc_supply);
+		if (ret)
+			return ret;
+	}
+
 	dvb_spi->spi = spi;
 	mutex_init(&dvb_spi->spi_mutex);
 	dev_set_drvdata(&spi->dev, dvb_spi);
@@ -631,6 +644,9 @@ cxd2880_spi_remove(struct spi_device *spi)
 	dvb_frontend_detach(&dvb_spi->dvb_fe);
 	dvb_unregister_adapter(&dvb_spi->adapter);
 
+	if (dvb_spi->vcc_supply)
+		regulator_disable(dvb_spi->vcc_supply);
+
 	kfree(dvb_spi);
 	pr_info("cxd2880_spi remove ok.\n");
 
-- 
2.7.4

