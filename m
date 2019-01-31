Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3AAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D83F2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZGCCYjok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfAaNlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:41:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35795 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387766AbfAaNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so2635238wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYTaet1Bgd+3TjusLrnLJTwwFR4I7lsLwRcAysaeRos=;
        b=ZGCCYjokBLcG5+KDM3mpQsBIIl1KK0uLF3aZDEa40VBxsh7Wg1y3Nj9MV3VJyEbulz
         4Utd1wYLRAhicO1NU8j6De7dOoG7f00tKpmAAx0fmE4BePp6IO0n4YMs1w+/OrtKQHQN
         efVendyAQfiJFg0cdvLQPsSGw6wC+C7T/hvpMd7jhf8dmDgwyaQqMTCKbLfeuNxRoaZc
         fJh8fQ0B2tQsereO+uRmwNXO49LbNZHC6DHpIgPtn7zzcUywJ4OSO92+yazh/UpNbf/n
         2cG2BKvuhjhQ3fh0/wIEoeWJqNMx70iDsW5rEd0AKx9DWAtLh7ySLwL7BuNN40SREWpp
         gLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYTaet1Bgd+3TjusLrnLJTwwFR4I7lsLwRcAysaeRos=;
        b=OhX7bONBS3MgerbdCWnV3gO3ABXMLzJcmgk81OCd63fBHE21VfqJxNg0coJcCRFgxo
         IkR/NUezABgVPW9Z99hoUnQe5gW6upMMNcWtSWzXBhVlZPfIGUqlBdRfxK2Na9VJ0YL1
         luKtn6dOLHSCSYn4YJrM2y4O5KEiCA20NkHI/L0Mkk5vqXzqnPJgWBwlE/cmbru6YUZm
         BY4ucdxwztJhF32a0pdXTZQlx6ahcVA7Ydo1I81tnq0SwZYMrWO/dMpEdk4Mc41FdaW/
         Zr5/BAXPIng3eXi1lnNZYdizvqB+EVDwsvGMGrJzNzszCbP0kcGIfm+BsofSaHnnu+PI
         Nnnw==
X-Gm-Message-State: AJcUukfP/drJxZuFC/KuIzq+J2K8RleXdEzRi+l/tNSkfAHRfxaoIJxf
        Hb7CZAARt52P3JX9+3DgbrH3zw==
X-Google-Smtp-Source: ALg8bN4LVGdrNflpToPu7R9czul7RQOtNw9JpZEVkxbcEEd1feqZh6dBdnAJ+ilPRgPQUdhEiEUylw==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr29676094wmc.0.1548942006556;
        Thu, 31 Jan 2019 05:40:06 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 21/35] ARM: davinci: cp-intc: add a new config structure
Date:   Thu, 31 Jan 2019 14:39:14 +0100
Message-Id: <20190131133928.17985-22-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
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
 include/linux/irqchip/irq-davinci-cp-intc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
new file mode 100644
index 000000000000..9b0c7d6189eb
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-cp-intc.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_CP_INTC_
+#define _LINUX_IRQ_DAVINCI_CP_INTC_
+
+#include <linux/ioport.h>
+
+struct davinci_cp_intc_config {
+	struct resource reg;
+	unsigned int num_irqs;
+};
+
+#endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
-- 
2.20.1

