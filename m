Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1646C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B520D20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGgvnpJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B520D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeLFHcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:32:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33023 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbeLFHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:31:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so11370208pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UAI3OUKoprsOY9OdCB9E22gIwtD9enXDzWD/fAxr8E=;
        b=kGgvnpJD5ZK67Nrw9ngrxknNuTTD+rwOxBm+CTJ4vmBQ897PoeLijHC7L22hZ1DCTh
         OFlCryuu3SpzKSJk+BiHLHquV94Auz63D/hN4pq3814QIZABHcp5rmtKEMSHU0GHYcJu
         FNXeXPV8QjAfVx+82IX8JEtXjrY/61VwZBGSzkSebo6rqSGEuH0AlAFuUczPm6/hg2Ju
         DF5BRKs1l+lHt9fu46k+onK3noefXuZ4Z8a3JCr2kzDuY5awJWaIYnQ/froXrHWWWYkf
         f/ejsqzg/zQeJ6PrQBEKXbgmBz39HLeYIb0nZQ/bY3iPioktGV2xjHAz8OztGIFS3dgU
         vEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UAI3OUKoprsOY9OdCB9E22gIwtD9enXDzWD/fAxr8E=;
        b=Bei+iDPlugytxLZUFm6ETrDXO7hYTJiFNxFyiS5We5zU/BnjMrURR+EMF/AFcGieN9
         oPaTmLld+I4adWyEFNyPYjGWpYFBhsArb85wrXqMRBr1CYpOhoeFgjVPNnbyhWknMiFD
         mle8U3KQKhHB+08smYqLN8bysSnXEFbDKC1e/fELXXIkfKz8SIUArNBjrLdgDHHTrrJG
         EeK44oyznQMC8KhCUlC2muYgTlCfF5aNeL/C3lc8npqUi9ZeJ0ayjCVb8/7aErePTkgv
         snb1x9D1liQji46GG0TLglqLo9qw8cA/ccP4rWNyO6QPOnKW9EsPk/gF6X+5/p6bmQb8
         bgpA==
X-Gm-Message-State: AA+aEWZ1Qyr4nTpNd8LehGaEnaiPCmIpOIa1oDO1DTiL0csrwUCTWVVw
        XufRbCRLsO7KeUfY14PxZ4c=
X-Google-Smtp-Source: AFSGD/VUxg/Qt4R+bt4RCmL2WIGr0OLVj2NYMaKR7gAkMctBajPQDNHXsbzrJ4HblmDzb1xk6ZDmAg==
X-Received: by 2002:a63:5c41:: with SMTP id n1mr21009907pgm.1.1544081506464;
        Wed, 05 Dec 2018 23:31:46 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:31:45 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] irqchip/irq-imx-gpcv2: Share reg offset calculation code
Date:   Wed,  5 Dec 2018 23:31:22 -0800
Message-Id: <20181206073125.7255-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move identical offset calculation code into a small helper function
and make use of it in the rest of the code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index cbed00319315..b262ba8b2652 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -28,6 +28,11 @@ struct gpcv2_irqchip_data {
 
 static struct gpcv2_irqchip_data *imx_gpcv2_instance;
 
+static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
+{
+	return cd->gpc_base + cd->cpu2wakeup + i * 4;
+}
+
 static int gpcv2_wakeup_source_save(void)
 {
 	struct gpcv2_irqchip_data *cd;
@@ -39,7 +44,7 @@ static int gpcv2_wakeup_source_save(void)
 		return 0;
 
 	for (i = 0; i < IMR_NUM; i++) {
-		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
+		reg = gpcv2_idx_to_reg(cd, i);
 		cd->saved_irq_mask[i] = readl_relaxed(reg);
 		writel_relaxed(cd->wakeup_sources[i], reg);
 	}
@@ -50,17 +55,14 @@ static int gpcv2_wakeup_source_save(void)
 static void gpcv2_wakeup_source_restore(void)
 {
 	struct gpcv2_irqchip_data *cd;
-	void __iomem *reg;
 	int i;
 
 	cd = imx_gpcv2_instance;
 	if (!cd)
 		return;
 
-	for (i = 0; i < IMR_NUM; i++) {
-		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
-		writel_relaxed(cd->saved_irq_mask[i], reg);
-	}
+	for (i = 0; i < IMR_NUM; i++)
+		writel_relaxed(cd->saved_irq_mask[i], gpcv2_idx_to_reg(cd, i));
 }
 
 static struct syscore_ops imx_gpcv2_syscore_ops = {
@@ -97,7 +99,7 @@ static void imx_gpcv2_irq_unmask(struct irq_data *d)
 	u32 val;
 
 	raw_spin_lock(&cd->rlock);
-	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
+	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
 	val = readl_relaxed(reg);
 	val &= ~(1 << d->hwirq % 32);
 	writel_relaxed(val, reg);
@@ -113,7 +115,7 @@ static void imx_gpcv2_irq_mask(struct irq_data *d)
 	u32 val;
 
 	raw_spin_lock(&cd->rlock);
-	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
+	reg = gpcv2_idx_to_reg(cd, d->hwirq / 32);
 	val = readl_relaxed(reg);
 	val |= 1 << (d->hwirq % 32);
 	writel_relaxed(val, reg);
-- 
2.19.1

