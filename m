Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63834C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2543820831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jpu+Z8fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2543820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeJ3TPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:15:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34495 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeJ3TPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:15:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id l6-v6so11939418wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ciXHZq7IgUjKzK1dmpUyx2KByjHqFG7X4uzy09xTGg=;
        b=jpu+Z8fvnPHfsMy01qKgjjhOOGsGwdGkd0ILfZQFjcz+SDc1qvmaZ58TN5YbAh75HZ
         Znhxtxq11l4mzW61ofx1Ly9lbfyMIBzzwEvasPq72WbwB7Up0RwjRuhfyS5U5pDkfNgi
         AgvBQhlLtzipJUdHAio9eWd26yF49FlhrN3cvbW+WPJXBpymyh11CMNwkNetfuLQ1wyp
         DiIUv2mXmXt0FdETTP9SbQ3UEOUBIZfrGtnCbsyImumsR139+DCxN+lgwvlEeS7Y38qA
         tLJl6GC45NUPsQjTErlvLEW7EVJdo0r16FVwTHP6B0heibF7AXTZjOSeedOBkabzaHJd
         7NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ciXHZq7IgUjKzK1dmpUyx2KByjHqFG7X4uzy09xTGg=;
        b=azkZCLuwmEOdZO0L2EULRj8OV90ACCQLlNaLq6uBZj8KeJnPVcqKNfgMvUrGCBdJDZ
         /A0Y9GTXQ/LyqR17zXHyUPQDigPqPopiQJ7AfiNLoW3OeMJgriAGIUkSdcFJ0LUrR7cr
         W8rDio/uudcE2yV2iUfB+cxIDEH1Len512ZABDQrxrX4Etbr3twHIRcYp1SOGDhpeXs4
         J7c3MRDp4YOYjS7wbFwAhA0BIpYtV9sXHZlfB1kSTetV7iS/WEXMdp7IRl/Dqfj4v4Xn
         FqOUQfa+KMp1MN0MbYm+rFJ5Xe3W9tBx3YDnAcnTPukFPPBt5sG8TAckpqJyC76Ix9vk
         4daA==
X-Gm-Message-State: AGRZ1gJUoYfbhye3EAsjU1Zjdc07OW9sOVvSnX7ELpxv+A7AAwStPkbN
        GUI6xZ7SbY0dUJKG8Fgxq6Fdbg==
X-Google-Smtp-Source: AJdET5fKhROE/aimQ1rRt3miLeWFYefFvT3QdSuoQALV4SJ9187Krf1F4uNa0MudrsbwyJjKeaSx7g==
X-Received: by 2002:adf:9403:: with SMTP id 3-v6mr17676176wrq.54.1540894962474;
        Tue, 30 Oct 2018 03:22:42 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i204-v6sm26638614wmd.28.2018.10.30.03.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:22:42 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] nvmem: meson-efuse: add peripheral clock
Date:   Tue, 30 Oct 2018 11:22:31 +0100
Message-Id: <20181030102231.4851-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181030102231.4851-1-jbrunet@baylibre.com>
References: <20181030102231.4851-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get and enable the peripheral clock required by the efuse device.
The driver has been handle to work without it so far because the
clock was left enabled by default but it won't be the case soon.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 40b9df1d030d..99372768446b 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -14,6 +14,7 @@
  * more details.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
@@ -46,7 +47,31 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct nvmem_device *nvmem;
 	struct nvmem_config *econfig;
+	struct clk *clk;
 	unsigned int size;
+	int ret;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get efuse gate");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(dev, "failed to enable gate");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       clk);
+	if (ret) {
+		dev_err(dev, "failed to add disable callback");
+		return ret;
+	}
 
 	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
 		dev_err(dev, "failed to get max user");
-- 
2.17.2

