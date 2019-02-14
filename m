Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC02C222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dMEIyIKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439640AbfBNOxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32799 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439617AbfBNOxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so6838086wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
        b=dMEIyIKQ1+p+s2GGR8u0p1ancuKmBtnHkysDYXKQbJbqEEhAFT2VLpOaYe3RJe+Ida
         Zw4WaQTrfKHfeeZ7XruqLtI3Qr0CtLZZbJ8wYnrkSvpia4MqyyT0Uo1pq16R2AFdSD4r
         5UnFfU2dURXtZ90HC92cIPB0w+gFuu9H5RPJyD1U64l41KDZfQqyf0ET34wYXsYPDP9i
         Cg6LatVVdihDJDDgxLRKh2Ja73E7wGZlh4YzdlXInakU0MNRa/atvgEBEfOXw7t3MNo0
         egUJhKfeW2N2TX8MyZjVDv+DHGlNZJb5SwWiKSCJ/6gEQtNGvfdCOpwcEP82LTwI5QK9
         YPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
        b=hGcnAJWfNWp6ZpdK4ZU2w+UmlS0RvEB4Vc447uEeFbFQJDwM+6t8Dk/5PIyoUO/pNS
         7wtEPEdpbLMRDkeLB//xRn+crE6I3n0C1Vy+sIPq4VZ6UBg93X1xymqoemMS6oosQQal
         4E8oM3mBM1GoBz21iQopqXhUUitsdThS5gWCphDOmPm2sLDVTgP6sDoIXvBrjlrcFyvt
         w4Tu+DFJEmFY2jf7LSIh9FOC3f7XJ45y29dNK0l6zFAvSoABwB3/w8Y5h6T9rVSOlipX
         r4kylfx6D9TAbo2UfmFr7TWzeqGPwVRMr7rAaByuu6s/00RTVUjaI9SgNF0lja+G+azR
         fxfw==
X-Gm-Message-State: AHQUAuZv/uSVipUiJvouRqKccISLtHbZM8Z/u+sGI+eOzQrA/eMKKFrv
        e82WBzLD+rmJZLpW3cHuRMXS2A==
X-Google-Smtp-Source: AHgI3IagVd1vnN+m5pFUhjTDmSkTOS3BuaOxxShDaBavjQdgxYNlcYgU5yJtMIB8qQcA4ohF8C2SNA==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr3298464wrx.203.1550155992764;
        Thu, 14 Feb 2019 06:53:12 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 25/37] irqchip: davinci-cp-intc: add a new config structure
Date:   Thu, 14 Feb 2019 15:52:19 +0100
Message-Id: <20190214145231.8750-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a config structure that will be used by cp-intc-based platforms.
It contains the register range resource and the number of interrupts.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqchip/irq-davinci-cp-intc.h | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
new file mode 100644
index 000000000000..2270a6167b98
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-cp-intc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_CP_INTC_
+#define _LINUX_IRQ_DAVINCI_CP_INTC_
+
+#include <linux/ioport.h>
+
+/**
+ * struct davinci_cp_intc_config - configuration data for davinci-cp-intc
+ *                                 driver.
+ *
+ * @reg: register range to map
+ * @num_irqs: number of HW interrupts supported by the controller
+ */
+struct davinci_cp_intc_config {
+	struct resource reg;
+	unsigned int num_irqs;
+};
+
+#endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
-- 
2.20.1

