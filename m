Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1339B2080F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTtXupSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfBFPPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:15:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44536 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731295AbfBFPPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:15:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so5573495lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7i5TG/t7krTxrSFOOeDg/EJWJxJIJAdFcbbzBw6va+M=;
        b=UTtXupSolKIqRi6KFTrnqF2LTxc12e+dmHp5xHjFkhA4EKj3tdzCsLrDvRk8q5NKHd
         bzwmtEcFMFpWHweaurAnmTSLQmiraKMOuhnw6Gy/7dYK1hB93NeMUIfTeIyleWJDpWN9
         bX4zCBz9I8O95xC3m/1F9pzSD13Nbyp+ZEptaL76vZ3BaDYvwyffVE11bPEOIdH9IKo2
         7A1P43iAuB+UNmZROLvzEzLgnFx69Erd91KW21TvwzTTiWS39TzfIQDesSEdUd0UCq0y
         kXMiT4tFGNZ/NaJMvMGZjOhp2S7oBO98IfZd3iOW0lCzHVz0lCENDK60znEOhz9hU1Dr
         t+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7i5TG/t7krTxrSFOOeDg/EJWJxJIJAdFcbbzBw6va+M=;
        b=AHKzX0Hv6mIwCzIkcwXYxkOGQjwtjY9UQxYP0Jsqzk6mv9bCmZjRXp7rnBA90GkdH9
         oCWL2bdHop4pOR4PC14fHdrhZZPlCNBvuzYekkVvV9XnMYph1bOPi8F/XBjDlOBJpH+3
         gI1q1YbYrHcbQc9ZKU6v4WwlTEnjBIVOKntecSbzYhXofS8BhOoOqdOU8Tn94qekAT+t
         Pco6dxDF9WtO0aFrMbZdXIpQ0C14jBWOR8uOz7tXFbWcJ9vHaC0mI5AvqynpFeXCdvPy
         lk0LswGwnkwaK5sM05luxBXZW/MzAZZak+5Z8JYai5W7zBi4GQEaCb0O9/oaROh+IVqB
         671w==
X-Gm-Message-State: AHQUAuaV7pz/xTeRVhq7d0LxsRdUqSVEFAHLibkSU1KhpI6mSb32gf9X
        jt0xgglHyqNVZ4UnzjFTerY48Q==
X-Google-Smtp-Source: AHgI3IYJgk1mn8XhH8o0Z1YVGeQ24abxd3Jvik28nCegOxsO6LQpQ/FK/BuH/7ldTPei8yib6QoMow==
X-Received: by 2002:ac2:520f:: with SMTP id a15mr921769lfl.110.1549466131488;
        Wed, 06 Feb 2019 07:15:31 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e14-v6sm3793499ljl.43.2019.02.06.07.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 07:15:29 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Subject: [PATCH] genirq: introduce irq_chip_mask_ack_parent()
Date:   Wed,  6 Feb 2019 16:15:21 +0100
Message-Id: <20190206151521.6574-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hierarchical irqchip never before ran into a situation
where the parent is not "simple", i.e. does not implement
.irq_ack() and .irq_mask() like most, but the qcom-pm8xxx.c
happens to implement only .irq_mask_ack().

Since we want to make ssbi-gpio a hierarchical child of this
irqchip, it must *also* only implement .irq_mask_ack()
and call down to the parent, and for this we of course
need irq_chip_mask_ack_parent().

Cc: Brian Masney <masneyb@onstation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Marc/Tglx: can you please ACK this so that I can include
it when fixing up the SSBI GPIO hierarchy.
Brian: please add this to your patch series so you can
fix up the hierarchy on the SSBI GPIO (will send patch).
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index def2b2aac8b1..9a1a67d2e07d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -605,6 +605,7 @@ extern void irq_chip_disable_parent(struct irq_data *data);
 extern void irq_chip_ack_parent(struct irq_data *data);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
 extern void irq_chip_mask_parent(struct irq_data *data);
+extern void irq_chip_mask_ack_parent(struct irq_data *data);
 extern void irq_chip_unmask_parent(struct irq_data *data);
 extern void irq_chip_eoi_parent(struct irq_data *data);
 extern int irq_chip_set_affinity_parent(struct irq_data *data,
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 4a30beb7ac2d..aeacd58ed7fb 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1279,6 +1279,17 @@ void irq_chip_mask_parent(struct irq_data *data)
 }
 EXPORT_SYMBOL_GPL(irq_chip_mask_parent);
 
+/**
+ * irq_chip_mask_ack_parent - Mask and acknowledge the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ */
+void irq_chip_mask_ack_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	data->chip->irq_mask_ack(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_mask_ack_parent);
+
 /**
  * irq_chip_unmask_parent - Unmask the parent interrupt
  * @data:	Pointer to interrupt specific data
-- 
2.20.1

