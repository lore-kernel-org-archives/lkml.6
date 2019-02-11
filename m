Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1A0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DEC22075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LAH3ZTvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfBKM0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36254 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfBKM0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so2059565wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caGR+xPQP4nJO6Pesj45R1zU4S0+ykorYdgBwjiu6dQ=;
        b=LAH3ZTvJcseL493VTuaAsp2SE095lhSFofkx0/5Q0B/QpcDeJsyGr1u+C7FI+exWt2
         tUFk80g0PLRTAa8uIvQzIlZjmziUR5sVsoZWjIwKwR8oOv2tkl6Ij0oK4AwtmQoLa335
         SDphT1u+IbEfDrSg2fgjuw+/Gfqpnb+IsybRuaMCqVZujlVg0jcaUGpibajEDttinfvw
         hT39tWFnbLUwXk9Jr2bT7xWGOqI2BkwiG4AjUdIZK0bMOZeTHCe9qkNHFbciD5EPWXSu
         q80Dz0fyVNZxtOXzYq9VreaSajJajWfft6Bf46RzbnxeE/hP4rAs74aiSjXIXMOazo6o
         rUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caGR+xPQP4nJO6Pesj45R1zU4S0+ykorYdgBwjiu6dQ=;
        b=k3E7DNBlOpJQni0VFfTxYyM6vVqPgHboeMArp4ivZ1UBTfynNOiMCLnXve8cxgL8jy
         dbf83cNgtsr7vndF3a+aIjCyR3s6TLGRouwLBgZnOrem38/qbo4sn8oVNHzJofn6CnNu
         AMLet9g8SmYUxyb0vqGuUjTOpZWxUU9cQFnjPgZcQqMHgc7L/NZavVp5vX+OssxiQOnQ
         XJ6OFBJI2Oq8Yyta2akaKPnFUQxlPMYgWiqTTaE6QiVkpkhtdBdYoJkHs6nFlxUz0CxI
         Sif6OuOLJAjqbs+PouyXxzn3aSKAhM09CNB67FvbxBseKdMxHwBk7+0LDzbx9p7jP4A7
         bLfg==
X-Gm-Message-State: AHQUAuYicEB3Txf7xDIlztrqAffWibBB0Fw4/Q8RSIYcpEd6wBxMpBVB
        33JnlAeICRVzPd/3zo+nvrrI9g==
X-Google-Smtp-Source: AHgI3IY9xcCufmEPJ3uK+Os/G3CyB2OE/d313Lz7/HnWa0M2LrjO5xO2Tnp/8169gMzfYU/np/uvoQ==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr9678759wmd.36.1549887988652;
        Mon, 11 Feb 2019 04:26:28 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 12/33] ARM: davinci: aintc: drop the 00 prefix from register offsets
Date:   Mon, 11 Feb 2019 13:25:45 +0100
Message-Id: <20190211122606.8662-13-brgl@bgdev.pl>
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

Since no offset goes past 0xff - let's drop the 00 prefix for better
readability. While we're at it: convert all hex numbers to lower-case.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 145fda7e5a35..148c23728bdb 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -19,17 +19,17 @@
 
 #include "irqs.h"
 
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

