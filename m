Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8024FC4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D1E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RYV5DEzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbfAaNkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:40:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40400 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbfAaNj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:39:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so3315898wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QanIhRSlQl6wGHvoamzYhAaZ9CMIQGcX9Hv3iPJ8S+I=;
        b=RYV5DEzoSKU1PBmHiU+He6LaLOSZF9P8/gPImBjiYXmwPl55MEFXg3Sr2j8Q1gYTib
         VDlAC0vJdGwISB1akfFzpCza+a7zwLwo4+aPPUGdMmZFcrFyO1f6Qs+VzKhrc6OEOF35
         pE4NwzDZ7HCVvy1IHudHxqo2XCLXK8DLjS8+WtpArwly1k/j9Pzs6A8gii2gpDqr/sIz
         nor04x9qyEbFkjIivz5+6AsF63IcrpONel+9djbvh0lNk+QBT47lZLcLZucvH2S2WKtb
         qxioHWXWjeVg8ky0kdEGcVqqIn+Adv2oDzgdQ41gfCaNdug3XAD8fmXkUZvXUWaxEPwl
         vYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QanIhRSlQl6wGHvoamzYhAaZ9CMIQGcX9Hv3iPJ8S+I=;
        b=RQIjNB/38E0/ZBWPod2HxJ+NC8Z5+dTnpy4arg19WaOGFffOlvzDKrE4OG8EBEn5Uv
         jt8NHUeM+58gePyBxNIP05BbZMQUgLto884kmJA8gSx+OHVeeadl98yfimwrx+LePbHr
         mQ6omybKusnBx6vK2pV8cLn0qDd+DPPOYgJMT2uvjQcJUE+Ynsv+0d4aLz8Gw9rwnNF3
         9ohJTgL9gMJ5m+/d9UBfYOb8sui9fiVJdasfcBmyJXfHZ30+lq7N2NzlHAPKoUUO7/Ka
         dwBYsUVrmvN69epANL5pASNj+qXhULqAQsYJ7Ky9WVCM83zUmyvnVPMOh1jbdjHPMV0t
         X0IQ==
X-Gm-Message-State: AHQUAubVmjA5HLJuwulz6q8+/oUVnh6sJNSvjIoeEtplW0wL8c+NAp1Q
        dIwFXP89RSRPxVGHN+1nhxhEFg==
X-Google-Smtp-Source: AHgI3IZO5qofrDBCfkoDg3bkSTWpbu5tdvIda2Dk0kIwZYe6DPteyHFBgoZzNC5yiSO9+3GFgO/C0A==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr7692879wrr.329.1548941996310;
        Thu, 31 Jan 2019 05:39:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:39:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 12/35] ARM: davinci: aintc: drop the 00 prefix from register offsets
Date:   Thu, 31 Jan 2019 14:39:05 +0100
Message-Id: <20190131133928.17985-13-brgl@bgdev.pl>
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

Since no offset goes past 0xff - let's drop the 00 prefix for better
readability. While we're at it: convert all hex numbers to lower-case.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index c43aee686b78..b31821e89a46 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -18,17 +18,17 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-#define DAVINCI_AINTC_FIQ_REG0		0x0000
-#define DAVINCI_AINTC_FIQ_REG1		0x0004
-#define DAVINCI_AINTC_IRQ_REG0		0x0008
-#define DAVINCI_AINTC_IRQ_REG1		0x000C
-#define DAVINCI_AINTC_IRQ_IRQENTRY	0x0014
-#define DAVINCI_AINTC_IRQ_ENT_REG0	0x0018
-#define DAVINCI_AINTC_IRQ_ENT_REG1	0x001C
-#define DAVINCI_AINTC_IRQ_INCTL_REG	0x0020
-#define DAVINCI_AINTC_IRQ_EABASE_REG	0x0024
-#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x0030
-#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x004C
+#define DAVINCI_AINTC_FIQ_REG0		0x00
+#define DAVINCI_AINTC_FIQ_REG1		0x04
+#define DAVINCI_AINTC_IRQ_REG0		0x08
+#define DAVINCI_AINTC_IRQ_REG1		0x0c
+#define DAVINCI_AINTC_IRQ_IRQENTRY	0x14
+#define DAVINCI_AINTC_IRQ_ENT_REG0	0x18
+#define DAVINCI_AINTC_IRQ_ENT_REG1	0x1c
+#define DAVINCI_AINTC_IRQ_INCTL_REG	0x20
+#define DAVINCI_AINTC_IRQ_EABASE_REG	0x24
+#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x30
+#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x4c
 
 static void __iomem *davinci_aintc_base;
 static struct irq_domain *davinci_aintc_irq_domain;
-- 
2.20.1

