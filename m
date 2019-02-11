Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F024C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA442075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jNfPuPtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfBKM0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46937 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfBKM0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so4429831wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=;
        b=jNfPuPtPZZ1iElfR7lBREEpMmy4JVpCcJWxwmvB2x+kGyLKK3gZmxNavs+ZsWppjZQ
         OzpALHu2GQuRgyu0/XyI4fT1JpktYHsdoPQq7qIkWoHCMMefSKIJaIhtgdw1nwFDuTrD
         Gp+qbAsV+yacD86IiVX7HB+k7EgP0IgRaQbUKJMKdReAG59ja+meEnJqk0p3qm21/QFF
         6IWgxbUdCbnfJaR4rwSjdJus5nlDkUDxfUmeqinnG1fT0Fma1Ki35HeY+KMD/eM7nXPH
         3q7xriUwsoDU0x3FdbZjEdQqJjHtTVPYVqDYmie2Ms18u1MeUgnFvsS8X+OI2P4WxJz0
         SjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=;
        b=lGfHMmeahahJ4ggzO1ivVxWXZDhqvL0gM3YTlT56c0i08Oy3nRdDPssY7JFSpvu16Q
         CHKixXMCgMKt6hTlqB86Cx7lMd/LOQDslE0q2cLcnlWDTJKs7g8IwkA1y0tTkkn9oUr5
         /59EpGdgvT94+rFkbZPqljIivCKOAabJJ8COx9UUF20ZG+DZw4pTyrkYhMRk5eMP06t+
         BJTw6tyHj61ooiYzyzaW26ICdtup+dQI6F8MphTZ5PU/4fZaf8fgMk40UoQvpfHpZWMm
         +hZ0OiJ09TA2C9b3BUfgXFUMqpMNh6C9pl+dOJhEYJK9ylyo4fUxMldV57aR9HPXitSg
         agYg==
X-Gm-Message-State: AHQUAuY+LvX248V/M7LGdaOCR15oWwVFuquEVdvISzd6CiwovagchnPU
        5NyDwmC4MxYtOeNQJ0ec4y5dMw==
X-Google-Smtp-Source: AHgI3IbqIQIgpmEsKfirMG84alydoChsZyJ/cJAXGK+6oaOJTTy2ywYowbHZxmw+JPEc1CCw9ZCy3A==
X-Received: by 2002:adf:dbc4:: with SMTP id e4mr29297329wrj.320.1549888007733;
        Mon, 11 Feb 2019 04:26:47 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:47 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 28/33] ARM: davinci: cp-intc: unify error handling
Date:   Mon, 11 Feb 2019 13:26:01 +0100
Message-Id: <20190211122606.8662-29-brgl@bgdev.pl>
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

Use WARN_ON() on eny error in cp-intc initialization and drop all
custom error messages.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index f3787ae4cdbd..c1efb9390655 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -200,20 +200,16 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
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

