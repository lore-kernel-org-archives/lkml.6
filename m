Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77516C4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F92085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Oi5dsV1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfAaNlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:41:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53473 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387773AbfAaNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so2546244wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 05:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vxfm0fKbkuL8SE9c4CrhCSFAKt2dnHDzKJRVV3w+UdE=;
        b=Oi5dsV1IH5FhJX8S3ZuGU/CN53LrP0QqDD+FHNkMaT8NdpywplaK4XK29ZsbTcf30N
         NPHpXD4GACwqZ0XycIeop3T1/yvW0AshHTXnLy45JKjS+cV9V7ORtLHtYMxBEJ4/ZBXQ
         LASQpuFU48Mqfh0dxqq9+NMoxgPOwoklOGYjd7t+BBqeqUs8gqFCjR/HU8eaCCV5TZ96
         4fTNGdBCGy00uFZ9U4NJigu6JvMWdjGUqu8U26XmSdXAL7WIrtaRPc6a0serPHoGdy0E
         1uIcXs8Rm0Lh1EFK/rttuZ8EuOQjU7HCcGx4w34EJhMrGBBSFdfWZAW64tn3MYRYAv7S
         1+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vxfm0fKbkuL8SE9c4CrhCSFAKt2dnHDzKJRVV3w+UdE=;
        b=HXjS5zGR0XXswjSHzGfOKfBqmGwmvDzD1WebU0hpF4XIZWF5sxxHqjFpN8quLe401X
         7OyQt+v3TBHiu0T3NZbMxYzd2ikuY71BlNj+XglvwNDjGkbrWv1/A2D8LkxUX3+0DezW
         xvCT8UJgywuVSk1XEU38z3gV88mbBhZJwVyk+ONhAYW/quPGbTjgW/P8VjAMo5g8kMLn
         EaLVZpzW/wzzTvu3vRFFc1dqR+gxIHAdcky2D5gLNyT1RrTlUmgQZ41EBH52y2bPxpln
         3PHynE4KOC+ushPPwy39Sgsiga/1KXXws/9KV8JE3H35bGbHA4Mao8cLfZvaXAhLqvN7
         8v0w==
X-Gm-Message-State: AHQUAuZwwR4p3PzVbFAhH7lUNto7SubI3ZCq06hSwM1g0y6T4ROgnZXX
        g7s8RYfLJvDOE0V2Iytro/TWeA==
X-Google-Smtp-Source: AHgI3IbYvqW8nVCYDm7z4NeIwu8NZvfbdpzPIBEZ+pvo2Wymz8BGH4jH+TEFaNz4jnVpLHlMQrVVww==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr1297394wmj.48.1548942013583;
        Thu, 31 Jan 2019 05:40:13 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:40:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 27/35] ARM: davinci: cp-intc: unify error handling
Date:   Thu, 31 Jan 2019 14:39:20 +0100
Message-Id: <20190131133928.17985-28-brgl@bgdev.pl>
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

Use WARN_ON() on eny error in cp-intc initialization and drop all
custom error messages.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 4cd515b507f4..8d751318682d 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -187,20 +187,16 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 			DAVINCI_CP_INTC_CHAN_MAP(offset));
 
 	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
-	if (irq_base < 0) {
-		pr_warn("Couldn't allocate IRQ numbers\n");
-		irq_base = 0;
-	}
+	if (WARN_ON(irq_base < 0))
+		return irq_base;
 
 	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
-	if (!davinci_cp_intc_irq_domain) {
-		pr_err("cp_intc: failed to allocate irq host!\n");
+	if (WARN_ON(!davinci_cp_intc_irq_domain))
 		return -EINVAL;
-	}
 
 	set_handle_irq(davinci_cp_intc_handle_irq);
 
-- 
2.20.1

