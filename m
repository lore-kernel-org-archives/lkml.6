Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C1020449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="fhknH9yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfBLKlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:41:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39745 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfBLKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so2086158wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
        b=fhknH9yuAz+Q8a/IDesU9QcI+GLvXcEB70qbfAc/rjRGMRsiMKiGDDea/dNOcYHIzK
         OY0UahDt6RTm6LSVSes8O4qybx+niaWBZUspAEfPiZ5jWIXlHKDM2ZlfoIxhwE1DVQXT
         lL9Gah14dVGCOBCFc+MoWpKQ92v0ejJRp0fNmVe5JA/778c2F3BawSwKQcaXH9C2vS7i
         VowCS9/ioEDavhWcMLqMsf6J5wHT17bch5AC5JsANnD/bD/tDJzA74unS+cp+8IR8Y9X
         zW0jua/3eQgonQds2e9q4YKPr5BQ+PNQi84MBeeMhSsCnkX4+7gHx70KanJ0W29byRVL
         3yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ODe9/pBgLE4PrWfBJM71T1koYiCMuvoiVEkHhTfTA4=;
        b=ZMC1m6RhoGehk5K8cuRkidL7bcR5EOf0Cyh+PwEPWVW3puXdsU2zCNcTiR8kDsYnFo
         H0WF3Rt4f/OHaMDTRLJUXZpoELAsKgcd9Yq+DS8h8eF5AQsvexv/p0SVCIbQxsUq/BwV
         rsX5cNxLuejL5PZcpjYyejLcYscQWVu8GjDyKlsY0Ujq4U84BU3vV8yiixQ9gpib/ogu
         IP60GDrEf56o5WTNwGgnqinTNJker4N4UT7hBCUluPTs/I9fRkrGR4jXTfgqISaCSL8b
         GkJglDEKNveUk/tr/ztBDbDegj5XGDgvEa5qGQio0mjSOQt+cMjngsCXnrymgZSgMULh
         6CZw==
X-Gm-Message-State: AHQUAuaRp5jy1MYtXUav33mrNR3dA10/MHnhn4CJPNcrTWoPeqYpcGuQ
        SSCUcUYZfpnSzYC8NaM5+Sgd2w==
X-Google-Smtp-Source: AHgI3IYg5zLuW/ykThLokXkS00HkbX/i7AT29xKgmi5Tf/Wt+smxEEuoS84iukeLoO/qR8bTMbSb5A==
X-Received: by 2002:adf:ba8d:: with SMTP id p13mr2447461wrg.53.1549967954645;
        Tue, 12 Feb 2019 02:39:14 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:13 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 15/37] irqchip: davinci-aintc: add a new config structure
Date:   Tue, 12 Feb 2019 11:38:13 +0100
Message-Id: <20190212103835.7768-16-brgl@bgdev.pl>
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

