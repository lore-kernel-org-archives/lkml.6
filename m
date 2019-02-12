Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E03C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D58720818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pDok3eT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfBLKlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:41:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33955 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfBLKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so2125228wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=;
        b=pDok3eT4L7i0miBraC0DtB/RJ8s/FpyKfn3aRHCQZXTtOIyvcxzQ6A4TdRRwdkjb/0
         pZQ/U4k03bg2S18HCcZ9OmpS3oSFe8r0H15TXvaA6Q8vzAwEhmY/Pb4QjSRVxGt0cM7Y
         nFARVR1QlAjckDDEs4u6UCS+1wARyuayOLKVcJUQeFaleH/f0QrNz1AMfKzft5PSyJGj
         zIiuh0wwJUqEAkcIuFoRB+WRcyyruM+4a06MA+h2R8l8uuFS9q96ZIz8qgyr/L1NosZk
         23Q8VhroQZfxzGk6SfZMgLO/junNhYlpvDx75WE55+DqtIHvC7Fd29SSP/hr40z4FNOy
         pMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4I38YIiHSc0ZdT9iV5cSNguHO1bDo83hHtu+LVNIPe0=;
        b=bo1bsEXML6pA/++TzBZT3GfASCe0gtYtPkSRy2mC4Ue2IrBDQlIdUflxVi1Q9NVKXV
         uP32PHl/pEEgAhTCtZmQbbM2NH6pJzozvxTtJSikUiBgOmcksb7tvRHY4pkycsVNWbG4
         7EeWVQ99FedVveKc7MhaVGCxpcZ/wmoOWi7eQn9S/86NtJ080ZqwOFbvRTD69CZydIcr
         JKEWRmYSYLN8WPQxzcvtfhGd4t+frx1ItOVMhp5QCIQqjb6LHEqPK4//soIvwofU08uU
         qbEFvZMuvwVbaQzAhXIIi02JFw2i95RH/DcESAkKtEuPwNs5M6PGRAZW3ch4BZPjD6gg
         MYpQ==
X-Gm-Message-State: AHQUAuaajatSoNw81NXIvWf3l93f07L5YoKY/N67dgMSYX2gKAmIxnha
        Fy7ouv4ffXxkilLAFRaIHUfkaQ==
X-Google-Smtp-Source: AHgI3IYyzonvJQpn4K5gOlcJOHGtqyl4DYQjw59CLzlKc2GSdWKTLCojSkK8BzkU6/3jwFifIFUFfA==
X-Received: by 2002:adf:f903:: with SMTP id b3mr2498681wrr.82.1549967958092;
        Tue, 12 Feb 2019 02:39:18 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 18/37] ARM: davinci: aintc: unify error handling
Date:   Tue, 12 Feb 2019 11:38:16 +0100
Message-Id: <20190212103835.7768-19-brgl@bgdev.pl>
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

Instead of dumping stack traces, just print a specific error message
in aintc driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 1b2eeddfabd1..2afaf19dc46c 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -91,8 +91,10 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 
 	davinci_aintc_base = ioremap(config->reg.start,
 				     resource_size(&config->reg));
-	if (WARN_ON(!davinci_aintc_base))
+	if (!davinci_aintc_base) {
+		pr_err("%s: unable to ioremap register range\n", __func__);
 		return;
+	}
 
 	/* Clear all interrupt requests */
 	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
@@ -125,20 +127,28 @@ void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 	}
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
-	if (WARN_ON(irq_base < 0))
+	if (irq_base < 0) {
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
+		       __func__, irq_base);
 		return;
+	}
 
 	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
 						config->num_irqs, irq_base, 0,
 						&irq_domain_simple_ops, NULL);
-	if (WARN_ON(!davinci_aintc_irq_domain))
+	if (!davinci_aintc_irq_domain) {
+		pr_err("%s: unable to create interrupt domain\n", __func__);
 		return;
+	}
 
 	ret = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
 					     "AINTC", handle_edge_irq,
 					     IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
-	if (WARN_ON(ret))
+	if (ret) {
+		pr_err("%s: unable to allocate generic irq chips for domain\n",
+		       __func__);
 		return;
+	}
 
 	for (irq_off = 0, reg_off = 0;
 	     irq_off < config->num_irqs;
-- 
2.20.1

