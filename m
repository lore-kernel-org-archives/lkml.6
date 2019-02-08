Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDEAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110FF217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="R244DRLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfBHRgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:36:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54554 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfBHRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so4351725wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
        b=R244DRLUOHJxTKS4+02UK9t0O20yjYfjrh1rWAjC7gQH0i12FlcW5laSi7o68d2kpw
         Dge5aGYYAtnRVBfk5fFQXlp3P8LGu3mh2Dw7pv3ZqArJ3BrhKl23e02wFTaJEWx2u4wh
         69CF71cJYdd/Pe0mO78gds6VNz2afyWmOE3olAfW6QRVFKDxeEvIqpvFO3Nj3SvyOHkk
         akTqFmDSHVbdEwpgmJ93SoXceD02FeDcVTAVQgXnT9Jupr6pNJJ9qJmqHk7zPLpgWIZr
         8ih60oDd5vL8AxQCEMWxOJK+pFrmUKX1CRzmrZoMyJAUDMJaD/slSbefBzMLoYab6s3Z
         5iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
        b=HjHm7t5Egd9fS4LBRU5eR2jD9sxpU87EIAmurA+p3bzAnQONV9/ia3Kb01TpKdSBDA
         N7J9soZkO47TslRjV7hREIUdwhlGOsHhoJdB+YYk17OASf+vjBc+CkSk/YFqD/r3wrXG
         IYz8G91SCC2SSlslnKtVlyZVkBs3GWNZDIadrwSpHF+GjMDEng/52GoiiiRKEoIDOoE4
         3cGnW1tVMMyjLezdZ8M+NLiR/+h4G5vuFO7farFj73uhbC8VPLvxUzY1GJniLl533Qrs
         ObC6rY8CV4UcFpyaZb+plVJkDVGOBEVnqfPhXik/XBk1NkLfoF/5prGFwXBTeVyqQdD6
         2Qxw==
X-Gm-Message-State: AHQUAuY6gWbCVv1bJuNX4zjeOBuSqeaaPXU+gqciSnkLqEPdEoY/WGxs
        0K7IrSXqIg2NUjHD75BtQjUVNw==
X-Google-Smtp-Source: AHgI3IarRzyLRPIRwBmzpzMNT6mVugzKkKsXQmIL21MGbzccmL1V3cDULngxVLqpT4gh8cFCNHwKfw==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr16978676wrt.43.1549647332659;
        Fri, 08 Feb 2019 09:35:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:32 -0800 (PST)
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
Subject: [PATCH v2 22/33] irqchip: davinci-cp-intc: add a new config structure
Date:   Fri,  8 Feb 2019 18:34:47 +0100
Message-Id: <20190208173458.4801-23-brgl@bgdev.pl>
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

