Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id G5fpNEOaHlvKWgAAmS7hNA
	; Mon, 11 Jun 2018 15:50:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 34D2F608BA; Mon, 11 Jun 2018 15:50:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akBTAoSH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E1662608CF;
	Mon, 11 Jun 2018 15:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1662608CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933148AbeFKPuQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:50:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34747 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeFKPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:50:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so20948840wro.1;
        Mon, 11 Jun 2018 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/bU7tUyNPyHOzWHB1knV+7XJ28ThmwleIiTE9NsMBg=;
        b=akBTAoSHQv7uXBbX9pl11oJ86DrCbyDoITPj71K7ZPfd6zB0KTsTUp4nm6xeFxYuKJ
         HWoP6DiKmjgqKC/5vsoX8IuaCc2J8MeRHf+zohqvzAQQuWG0NZSJ0uItsfQZZAeTqIG1
         9/lVo6OGfAp4yoDsI5JBJRYOPUm1sut9/FwgGEh1463e/PZTTuozwfw3daAAC5Q+lUdZ
         JPy6r/OleiP2MfmBQCYLx3W/7ztPa+pA2fdsaOmlO8o7VpD5JMSBMhQqGajUUmGW0VqF
         Hcx5ETF0MmDkcIp4/qZgS80tYnexfBzDPcX7Ku8Ti+8LQOvJjT6CK/f9pSxFt8MHI0lR
         vB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/bU7tUyNPyHOzWHB1knV+7XJ28ThmwleIiTE9NsMBg=;
        b=hiQPZcmANBeRtas/WC1B5V1rW3/9GrVvFNGrzOqd00H1xlkQeFZgMruWE/h9TGFOov
         XZ9DVTz7iUA0zJBErgtxzErSU302L1XH/jwr9rksUEZllDbfUDtOFUpjA01omcz5+09k
         7gro/KEiglxQR911+T/lGNd6zPzOBP9AVwz3Frx6kyjpCZWkYqCyqhjJ0GnCbCfUnM51
         VM3cmPm6p1AYpS3x/fdeIjrFWFZtYe5D6OmyL/K/8+10tt5lbH3A4bHmDlRFN4yD2X1V
         miyfSjJ+6326GfeAVypo1gBU6vQ/VsRAEtjttS+rcLsh0HkxvHIfmxMAyVA7IsecjGCh
         66zg==
X-Gm-Message-State: APt69E2gWkqTdJ1nugEqCtDb3RdcA487it7wbnlyXnvtzYa2EzM3D/Gk
        CT+FYtews6u2uK/MIeIxrEI=
X-Google-Smtp-Source: ADUXVKJkUwZ+grL+QjOSG1mCc9Xt3rBTm3AdwBW97dSP41IfyIe/NzPx/4Kysc5lasIu184thwhKbg==
X-Received: by 2002:a5d:408f:: with SMTP id o15-v6mr12123480wrp.133.1528732209635;
        Mon, 11 Jun 2018 08:50:09 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id n11-v6sm30308862wro.13.2018.06.11.08.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:50:09 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Stefan Agner <stefan@agner.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v7 1/5] clk: imx6: add EPIT clock support
Date: Mon, 11 Jun 2018 17:49:57 +0200
Message-Id: <20180611155001.3506-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611155001.3506-1-peron.clem@gmail.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Didier <colin.didier@devialet.com>

Ignore this Patch, already merged in clk-next

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Clément Peron <clement.peron@devialet.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/imx/clk-imx6q.c               | 2 ++
 include/dt-bindings/clock/imx6qdl-clock.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8d518ad5dc13..b9ea7037e193 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -753,6 +753,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	else
 		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
 	clk[IMX6QDL_CLK_ENET]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
+	clk[IMX6QDL_CLK_EPIT1]        = imx_clk_gate2("epit1",         "ipg",               base + 0x6c, 12);
+	clk[IMX6QDL_CLK_EPIT2]        = imx_clk_gate2("epit2",         "ipg",               base + 0x6c, 14);
 	clk[IMX6QDL_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal",   "esai_podf",   base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ahb",           base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index da59fd9cdb5e..7ad171b8f3bf 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -271,6 +271,8 @@
 #define IMX6QDL_CLK_PRE_AXI			258
 #define IMX6QDL_CLK_MLB_SEL			259
 #define IMX6QDL_CLK_MLB_PODF			260
-#define IMX6QDL_CLK_END				261
+#define IMX6QDL_CLK_EPIT1			261
+#define IMX6QDL_CLK_EPIT2			262
+#define IMX6QDL_CLK_END				263
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
2.17.1
