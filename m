Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AFD214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nVvVG4Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfBKM2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:28:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33069 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfBKM0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id h22so14453665wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
        b=nVvVG4TdBI19mw5+gd072h8J5/eCAvd5REhTqYUnyRqphAvr13PIIJ7xCwew2I6k2r
         LIOjvJcjaia0cgFjEpvr1KkbxsC3y/vs2Qssd7DhGmCg5X8GuGAMtNquHM3V/2A4Toob
         Oj8wgc5BSNxb8GqzosdwDapidLwsD4U+dHdqnEEYtrxm3SBrnKCPCmai2VUlq+QEhfWu
         ntuMItW2OgYqkznud1jQVbf8Ad63RKk3yy+AUxFCtRc2i3mjeovZGbW3JrB9UhEucEdb
         FdyUkAJBgDjnan6WEdR2Qws+2mJjGIhZr2JDCFCixTp8U8XGN84fUKAxzkkVDTV5gF2q
         p2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
        b=UdhysoYAxSRvSwgHMSS46O1a3R5uS40q9naw5Ft+8RDihJNGMSXNJryKKipFYOhsS8
         EGihUA2DW6aF2n8/RIBF0Cwp1oZOJ3Ue1AjecqfNlDTpsA0rsSiMbGXfLb2t3sFcy3NE
         6W8EYVnkNRGkkRrTl0K+Iev7CSFOyncRz5lU1iVBNzcFTKk7qMhzR1xXC6pUzu02ZOin
         CBHCwCkIdtoQjOCZrlBvzfJYyG7MG9KnM5eIKQUMGeJvIQbl+UmnR4MyrxJqOjNoYe9m
         YKUx/WpX1/OXlRsplpk3+a6pNGZF2C3qQS0p3Ae7lwhY806+c/2iLAnUmguPySKM/aEy
         SwKw==
X-Gm-Message-State: AHQUAuYiFDaQgeyucEMfjUsJAosCOlyKJBbHwZywY86Od6rAKz81quVP
        yv/Hje79wMWNbGBQhUELJsRahA==
X-Google-Smtp-Source: AHgI3IZKL63zBm+2l6DD1Lj8GHJDvCr2J1MPoPleYKV2EUyok2qkRUtTQkG/z385qlx8GI8SKg4N8Q==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr7561227wmh.83.1549887990918;
        Mon, 11 Feb 2019 04:26:30 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 14/33] irqchip: davinci-aintc: add a new config structure
Date:   Mon, 11 Feb 2019 13:25:47 +0100
Message-Id: <20190211122606.8662-15-brgl@bgdev.pl>
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

