Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D038CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6C1217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GX4pFZ8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbfBRQlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:41:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53730 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733255AbfBRQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:41:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so18089392wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGvoDQvf/TcY3TPTyG7XbR16hTMkjeSzNp9L7GRb7iY=;
        b=GX4pFZ8sqA7WBKwnbKopeN5ty4KD1qR4Lx+2DsllEqjQhyud3vas9JyzSOEp/9syCt
         vCR4ImzT6/jMqbyAcpTnPWy/dflmnK1DECN9VRYkgJjKXF7UGMQqkt79zI0wgkY4oEy8
         cu6cVZEqYBQ90L3xJyuV/62j1U6jfum3hL0mTOw0mMQL3W5BQ7gKc4MYp9IjcFXqz8Gv
         i8hnvNzfAybIUv7Nk7UldZ7pS8mhoXpS7cWF59+UXzpxw5zxf32+5g5l+6Ik6htcFhsR
         VIvGH1hzOEAOz8V78TNEHnRi7AYz9O2dN++Bvu2sq6Ec+iREz4cl0VZZMT8IMImdkpEk
         TyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGvoDQvf/TcY3TPTyG7XbR16hTMkjeSzNp9L7GRb7iY=;
        b=hCyvovnovqjBzlOUoYko08yO+LU7w6Dt1qNu63L+meoUaTFe1+gNjHswkzkEKvGkEU
         b7rJtKPzau0w4+/k0qC6ByHygO6EjOfU5m78tqc7EE+mdgXPKBPV93czQWRU0vkfV92/
         MdDwWJS2Gr/OhM6YDDFyDJoYnUA+myvlA9QUrfKiys6ZeNeB6TOvkr7xdMx6nijD55xJ
         o23qxMfTL1tO5EQeMOUT9LZp7c3vOQpVHamkKz9D1K9ajldR8IKWdCe5Wigvq8Y43YPe
         1tULsIlhdCgR2e2GaLTdB8c+kSdPLB0qgGL/loxkJL+8mCKk+TKbaRylqXacCJBd48es
         Jxhw==
X-Gm-Message-State: AHQUAuZkaX9smTtYXbwT6p7TNO+OfFVSE1YPeX+InNell5J6EQgBgbwW
        WGLhOGthzK83/HCdCluaR73STQ==
X-Google-Smtp-Source: AHgI3IY9dHZgQZUQjvzNdDYZfzdr2cOeJwQzl8XTb1LUphsUW1TBjxvyxTqKv6VqpgTJ7Dzpr4aAcQ==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr16733037wmf.141.1550508103425;
        Mon, 18 Feb 2019 08:41:43 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id w10sm6325442wru.5.2019.02.18.08.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 08:41:42 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 1/7] irq/irq_sim: add irq_set_type() callback
Date:   Mon, 18 Feb 2019 17:41:32 +0100
Message-Id: <20190218164138.24921-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218164138.24921-1-brgl@bgdev.pl>
References: <20190218164138.24921-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement the irq_set_type() callback and call irqd_set_trigger_type()
internally so that users interested in the configured trigger type can
later retrieve it using irqd_get_trigger_type().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 kernel/irq/irq_sim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 98a20e1594ce..83ecc65d8be2 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -25,10 +25,18 @@ static void irq_sim_irqunmask(struct irq_data *data)
 	irq_ctx->enabled = true;
 }
 
+static int irq_sim_set_type(struct irq_data *data, unsigned int type)
+{
+	irqd_set_trigger_type(data, type);
+
+	return 0;
+}
+
 static struct irq_chip irq_sim_irqchip = {
 	.name		= "irq_sim",
 	.irq_mask	= irq_sim_irqmask,
 	.irq_unmask	= irq_sim_irqunmask,
+	.irq_set_type	= irq_sim_set_type,
 };
 
 static void irq_sim_handle_irq(struct irq_work *work)
-- 
2.20.1

