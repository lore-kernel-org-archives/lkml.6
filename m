Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6115C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69CA214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gz88jOMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBKM0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54880 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfBKM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so17478408wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
        b=gz88jOMbltaN1A9U65rIx6+gTcaHNE17vOImT7eFqeHfroUdxJLwonPAU38uZJZwzs
         6sWGtm/47goXM6a9hEjwg0IJ6Z1OQaysbzPXLWrQe1/WMnanbI5+zKFnADuB0FiupFyK
         p9OdniyRz8AfugtkNSHmCUkNlVd9HDDLls5tUBUpP37V13A9LElADjp+EE5cdn+FpLng
         njrxYUPjlKI+cF75Uk7dAY6khu0WsOiklN3oIsNFUslF+hw1ZhrsyvTAIM8KyxtMjc57
         qSTP2OHk8jVS7YV19zV+GIdZZd+H6l6Q8qwt71Tdyigkm48pX24pCsFPlTyJWCGaF1My
         pxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhFqkmsXZyuazPofYbQWZL9RcZ7Ca/je+Dz4MrjLFaI=;
        b=GC58G6yB1kQOYoZ7K3HYLGbpzl/beynfJ4mqcYfrm+PDcXItFU+5hjofeGcqrJ1GfS
         axhYCsXydqL6gCB0vcYI9wQbL48MScHKXLHMARmuGz/AnUPx7A7I+95j59R8qC4wJn/H
         BWPiAtZDEtRXzA5kdaKKYK5IjHqLWyqqniL3jHXpSWRvUw/3Xu8rUBA34MgnuQ5ogOT/
         8o/S7r+DQDU/86/vS+ExUYTmdRxKS5Af/A6MwS/6YBwVt+IXtYpMfmbYwqvmwc8rqDZ/
         ur1CJlCcAj7b1A5CAw0+N9dU3eEwtaq6TMhDqrjBqE80ZkhG1CLcj2ZNyonKeRKnpsVL
         hWuQ==
X-Gm-Message-State: AHQUAuZntRnvc0pQCZKNx192b+s+lMprGv408vqtpCUDuSKyxOhhDWLr
        YJN9re3+63CdBGCG9vP7h2xSng==
X-Google-Smtp-Source: AHgI3IYYEuJ2Sjdsx2Tp7Wu29UAkNxG9nEmxgIoJ5MP4ovJ9vXOrvtJbTXNc12DAsOhZm+d793BSBQ==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr8987058wmc.113.1549888000291;
        Mon, 11 Feb 2019 04:26:40 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 22/33] irqchip: davinci-cp-intc: add a new config structure
Date:   Mon, 11 Feb 2019 13:25:55 +0100
Message-Id: <20190211122606.8662-23-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
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

