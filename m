Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A33C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E831B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QVzASKGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfAaNmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:42:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41127 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387634AbfAaNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so3320985wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/c5hDVe0InyzBLUgsdtqzMSd06Nl7+tp8C6D2lOYhko=;
        b=QVzASKGeM2ZFTiubzM53pWGi1midPBvfiEoRwa3CAychzozVuwi0MKky/mGeLNmnYE
         E5UU+snYpAp12nQC/vsaneIYe9jwtiyjwjSZIgkcPF6nCnD4U9w3hxMyuoGFv9APxJbI
         rkBpsug97GrsEvf/4ak1sXW65tag2xyf9UiqT1DTaWfi7GwRkgcjfWSFPvoz3+xDwm/2
         UCEFJ2B/z5usBwM8wDeL7OsfKRWAJfWLIYuHlOVUwC0JKea+FXcGJHcROXfu0J/tHxz7
         bUZzfrwGAAMiBOB1QU/oGLIU0RBkggwHwuWgBPGpNcZSrYStWf8A4zFBZQneps8XfWPz
         ckWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/c5hDVe0InyzBLUgsdtqzMSd06Nl7+tp8C6D2lOYhko=;
        b=Y9itxImPACrJL+1VLM/B0+U6aSCsCb2iHLR6DItoREb3aX4eqVBQfMulZ5WIqht26R
         Gly4r5orqrrQKwjxz+DbWu3SqG5My/cpWql+SKVYei7Ti/Ie8lJURWiWhBrpBotZdLBk
         KDv+ibPpe55hJ9J8yZiu0FOYq7S/U1zncCy8Ah/h/eTwe1aWHpNvv/a6Jea+/X6/qCuw
         VsGJAsniY9XqyNcFuUOZvIB8anenpvwhqGHHpCBFyaPuQmhfvmErp2oNWvlXz0Ag0VKd
         VFYMbfVFe+0RsYZHF/P4hut2Ntg2vMFsZEBsI7kFlt1VbMuKcz44St+jh1xXKkbho8mC
         BtTQ==
X-Gm-Message-State: AJcUukeB5m4DStv/YM4YFbdw4V3gb5INOSBqemjfy6lF3re/JXJ/Cjwu
        kjyS0+Bw1SaekFGD66tVt38MgJpkBYk=
X-Google-Smtp-Source: ALg8bN4df9GfK9msIhWH5NZz/P0rVnlqXTC1yDU1fQTVRgIetUMUVgVZ40ySMrE9AmG4wkTFSo/5jg==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr33635178wrt.63.1548941997359;
        Thu, 31 Jan 2019 05:39:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 13/35] ARM: davinci: aintc: add a new config structure
Date:   Thu, 31 Jan 2019 14:39:06 +0100
Message-Id: <20190131133928.17985-14-brgl@bgdev.pl>
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

Add a config structure that will be used by aintc-based platforms.
It contains the register range resource, number of interrupts and
a list of priorities.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqchip/irq-davinci-aintc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h

diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
new file mode 100644
index 000000000000..d488e798bbef
--- /dev/null
+++ b/include/linux/irqchip/irq-davinci-aintc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2019 Texas Instruments
+ */
+
+#ifndef _LINUX_IRQ_DAVINCI_AINTC_
+#define _LINUX_IRQ_DAVINCI_AINTC_
+
+#include <linux/ioport.h>
+
+struct davinci_aintc_config {
+	struct resource reg;
+	unsigned int num_irqs;
+	u8 *prios;
+};
+
+#endif /* _LINUX_IRQ_DAVINCI_AINTC_ */
-- 
2.20.1

