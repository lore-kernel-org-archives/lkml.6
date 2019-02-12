Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E36C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CE220449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EPlsrLlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfBLKkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:40:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37971 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbfBLKj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so2093813wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
        b=EPlsrLlwIM5eQ6qCbBM/iLWsiNRq1swEAhorrsdQfx5Nz7e9/7PIzUL39IrYxQG/cP
         VQVS28KgHXP9Azk2pU5hxDSOi8GnHfaSFmcbuxpTf2evpuaVUCO01JF79PV3CzCFlmOa
         /CKumZ5ZdyTuwh2Q5pLkbskmGRaYpXBVJ8+Nb3TP55db2tno4A3ML9lqqMRnJ5UWZ4MC
         YfJimjI4/n6N4aGczwo+aEAf3iPM3V80mma8+jXkHS712XIhb//qFjCu0PQjRFOh8h5B
         8cyxZe+/ncF/jxiS1baSZxc2hMpp5XHW+tMug5qB3fhYtLpi7l2jIuyUPhebQs8B6MgO
         r45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
        b=Bh3O4WBKi2TZLv/TKexjxcZ/82qL6mAHMe0tH2hpxyxrhi1OvNOKk5D/EVqcGWcVEM
         nQnPqHyM/agoOxdjfAwFlL4p8DLqEgxcSavw31La79s8qg4rn7k7rTYxhyt4yNsIgUxi
         LiadinnZ6L/v4ejVdFzmT8vDd2h7hr9qT6I1wnCvqI1kHf/SlZ23u7tzPE8Cp16RumR1
         w+DmYIJcFEQkMwI9m9KqNkNRlV/qYfDOXhqc3QwOh4KpHr/ogqm1vk5c+HOY7btP/wjl
         jcDST50VxjIGgHJI7f5Lj8+bSa6HKHhLA6SPja3Dsj3TM8xYv0Pz1nKy5bwuFNPBKYvH
         ODyQ==
X-Gm-Message-State: AHQUAubSFoCr+HF1rW1k+bR0AgrV5mr48ZO7L1mOER4GIJ/0nOgLOXrX
        5aXJqsmuI0GQurRmsgZsroUHKA==
X-Google-Smtp-Source: AHgI3IaHYJQXAFGCW6IoU/bSVxGT/oCXiB6qrYsPXsWCvUatBlekF+zInG72x6L84+RgvwAbRGoNug==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr2318947wrn.13.1549967966020;
        Tue, 12 Feb 2019 02:39:26 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:25 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 25/37] irqchip: davinci-cp-intc: add a new config structure
Date:   Tue, 12 Feb 2019 11:38:23 +0100
Message-Id: <20190212103835.7768-26-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
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

