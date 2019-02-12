Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03543C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26CF20449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lIhVFlgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfBLKka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:40:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37747 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfBLKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so2432274wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=;
        b=lIhVFlgpqs9i8UBs1sXVt+szDQf7hhJw4n0iFrjfUsliCeDSt/mw4N/1YIki7zYkyI
         L9uO01cEiDV2/OiqNI9uVVJMb4pf6oDFwBDB/EEiyYrCdFDq02liTAYt/r0e/6N/9NUD
         Rk33hnEc/jWDdUzM8LDLzNEWgCCTeBudpvaOW1Rq7hha8/h2cqyFqTbn9242TXp8ojQn
         eFbwPYi8QSWr02BAy0X7EbKc9LIZFbxEviiGNfas97lgfdvqPZcQiJH4vqwrFy8qqIVl
         I1WpuSRHJm0qxcau5eRIRUWjNbutYyS+3ChaEBaToxKNs3vckZ6bxdY299ZEs0zFBD4a
         DU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uTYZ0vXP8sAs8gifFLvRMBmuXz5Fy14EY7Zl2hW8P1E=;
        b=LAnNVi6I+SG31+5vd1lw0egUP84lXI/WqjKUCNcM5wK899dIsBtpn4DsTdRND6IR14
         uMUeCaiad3dMkDsoK704dCvBXjMIbFdWx1kNdyNgfrKeQVIGSg0hga9J+csZlwwwv1RU
         xf6VRJDOVokKcRGNYJhwC5HZOq66nfVphfHoa/TDIJMLNWTaAsSkfrDXMtRoN14Q/UQz
         s6YZ35e9jCvXz+7qleLjR7agEs4Ph43EGqCaiYRI5M5ZhRD/oHbkW7q6/j/TcXk5mt6w
         K0utxC/SqhRf+Cptk3PFuXQCoPYlSw7MUgbfnY9OXT+Ew5V5EdZ1zztzRpYIZJ9crGN3
         QBow==
X-Gm-Message-State: AHQUAubyl+PHyUu1jW2b4P7W8JM70Zl91A07zYiE3NWULkVAZtQzfYU7
        5P7xBra9wiH1XYh20PGfpvE44A==
X-Google-Smtp-Source: AHgI3IZvrU3Gc7o+/aYpo7ifggGgbcm6gMjvXeYm18oGwKV8y8NFJ8EJq/jsNXWqKCjxmwiwHE0uKw==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr2417784wmh.26.1549967972484;
        Tue, 12 Feb 2019 02:39:32 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 31/37] ARM: davinci: cp-intc: improve coding style
Date:   Tue, 12 Feb 2019 11:38:29 +0100
Message-Id: <20190212103835.7768-32-brgl@bgdev.pl>
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

Drop tabs from variable initialization. Arrange variables in reverse
christmas-tree order. Add a newline before a return.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 6ab56af3be6b..25221dfe8a20 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -77,12 +77,12 @@ static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 static int davinci_cp_intc_set_irq_type(struct irq_data *d,
 					unsigned int flow_type)
 {
-	unsigned reg		= BIT_WORD(d->hwirq);
-	unsigned mask		= BIT_MASK(d->hwirq);
-	unsigned polarity	= davinci_cp_intc_read(
-					DAVINCI_CP_INTC_SYS_POLARITY(reg));
-	unsigned type		= davinci_cp_intc_read(
-					DAVINCI_CP_INTC_SYS_TYPE(reg));
+	unsigned int reg, mask, polarity, type;
+
+	reg = BIT_WORD(d->hwirq);
+	mask = BIT_MASK(d->hwirq);
+	polarity = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_POLARITY(reg));
+	type = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_TYPE(reg));
 
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -150,6 +150,7 @@ static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip(virq, &davinci_cp_intc_irq_chip);
 	irq_set_probe(virq);
 	irq_set_handler(virq, handle_edge_irq);
+
 	return 0;
 }
 
-- 
2.20.1

