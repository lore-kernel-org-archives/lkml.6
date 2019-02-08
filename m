Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77FEC4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96FB217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kfw4LKUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfBHRhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:37:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51900 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfBHRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so4377734wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
        b=kfw4LKUkinrqgKxn2J44QnZKv+b6P2k6DkxPKpM4H+AERpC2TM6nRzevACIsMZM3mj
         zGwHnvvpXxN28iUD50IcevhBfr6YWw++gbGBemLYfTNIsZ/9ljKroNt1g5hJQiSCnTxH
         YK/2wf/f6JRjiBkJtwlEtadEZZ8ZKwz4KWTrJ0G+JGvi4BmXXnCvnYDiYm01hQuSrUp3
         YLALrTl/sp52XGyBbyYy6aWiZ3JnvQeNrLj3qyH8O6rv9rtXjZ/x5c4/WlaaVXzZ449C
         svgQgVdoY6zTLDABAfLAoagmBJ/FQyijjGUHd1huohVIHl55NXn5CDMRzoTHX960ZGdv
         2o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
        b=ZDhLROb7Pai8XpPs4ti+hqNcvKeWOMMmjpKsHzfEP+sDhB8zw1WQQ7k3kXZuaZeiW5
         r58Tqvd9+DuoqeV9VBC2gwExJWcI4+uXecrTB8fxMry1j/jEbMLiih0maPSrQdyJ9fYy
         edmg+s+xIIixmak+Ljdj+fDJnL++SsGM7pADmucJwBnBeiLMNB+rPWlYKDf6wik1/ZZu
         S54pRb/CKgtLVnUPJvcS5WIecTDRccRZDVDsDJAj8VWL2QmSaL83PaaBvzTTvYPbFAFR
         EiipGOKztZYwCsTdXGkV0MH/uSj5ko0BbFLJLWKwJsewcy411qvKJuVfznIevGfMXiMI
         oAvw==
X-Gm-Message-State: AHQUAub3JO7rXK+zP/R19tjACgd+MLNUtLLCHXXcD8loF0GSe9jv1KSG
        xsjNMRhuHQHnew4XeQUABUUWGw==
X-Google-Smtp-Source: AHgI3Iah1Osavlul5DJpnUgS8LEdiyOze9kT8ZYuPBJcRdxjOb0Uv2+91dgBg3DzBcH3z0WPJdLu3w==
X-Received: by 2002:a1c:c4c4:: with SMTP id u187mr7528513wmf.114.1549647323182;
        Fri, 08 Feb 2019 09:35:23 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 14/33] irqchip: davinci-aintc: add a new config structure
Date:   Fri,  8 Feb 2019 18:34:39 +0100
Message-Id: <20190208173458.4801-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a config structure that will be used by aintc-based platforms.
It contains the register range resource, number of interrupts and
a list of priorities.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqchip/irq-davinci-aintc.h | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h

diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
new file mode 100644
index 000000000000..2b2ace3c1b22
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-aintc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_AINTC_
+#define _LINUX_IRQ_DAVINCI_AINTC_
+
+#include <linux/ioport.h>
+
+/**
+ * struct davinci_aintc_config - configuration data for davinci-aintc driver.
+ *
+ * @reg: register range to map
+ * @num_irqs: number of HW interrupts supported by the controller
+ * @prios: an array of size num_irqs containing priority settings for
+ *         each interrupt
+ */
+struct davinci_aintc_config {
+	struct resource reg;
+	unsigned int num_irqs;
+	u8 *prios;
+};
+
+#endif /* _LINUX_IRQ_DAVINCI_AINTC_ */
-- 
2.20.1

