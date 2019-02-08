Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B1DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1FF2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qdkfBUKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfBHRgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:36:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54577 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfBHRfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so4352439wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=;
        b=qdkfBUKhc0c+MqnyHXOX00G61dK4ACw5ynB90QEdhw6ZC5J3gLCSt5pJh3ade/JX0G
         0UVGjeh/lFKGPfdblPoa8AaKIZ8LrwuLkBt0U81aLEciYbQK7Q8WGv1DH5ucAR6B5TvP
         v+ffuYSi77tgGKtUHwvsuCR8pLt1uvf3NIa/au2XY9q7Nd7A0Q4rLGoTsLIK8FGzwqv2
         FW4ir0lZ7s88OBzM9J4YKQM0dGyiVetzvtXKuj7q5xRiB6GfejFfdVMkLzpKkH0CPNns
         IJGlziFZ6t7Tyz/nIM96IZkMadNqMicABII12WuuCW9SV1DrKi4+O9BoBy5zq8Y7pWim
         KUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVpMk4DVv+a2tPz6DDcxjR1CpV2M9ZT7i4uU6Q6sRTU=;
        b=kb840CAn5KCtg/bjIxOD2FoY15nRGcw49RTEIKybfo4Vn0j7AIiqmkRKxM7Z08AGu7
         650LrgktdJ1NuLOC8OweiQcQVtRjlBDQT9ye9wDO0RKpkwCwbS3pvK0j0AXIXxTIaJ20
         DrNs3rQ3O7Qgr2evy/gYzNzYUe/IFkQjLapC7YPP0VF7Gdvc+J3tQ+7/x05UIEKJhZ1k
         39Lb8r9TfDhVGADJJajmkTsWlZOKYZ3B6aG4mnJh8Astr1Rdg1+TOMZSbpGTsQ3BmAEk
         yFrBuAtDTB9b2H7p8Jc6lzqyGFD/E1GAKLRAUQn4LkdpcUtP+iHn/9SLasS81i/5AHVH
         yX4A==
X-Gm-Message-State: AHQUAubaZygHIcW5L9JF96LadWMQL57GbkJ+5o8ZhaW7Am+UBoxgrioD
        pFnuZMHdoeDineBNUTHkmF/gJg==
X-Google-Smtp-Source: AHgI3IZfdQBpIamoh+P+L8MSzoquKbELHayyn0ZizI/J0l5xr+FNc3723pXA+WZ22Ktuv72zHyMCnQ==
X-Received: by 2002:a5d:4349:: with SMTP id u9mr18215515wrr.223.1549647339671;
        Fri, 08 Feb 2019 09:35:39 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:39 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 28/33] ARM: davinci: cp-intc: unify error handling
Date:   Fri,  8 Feb 2019 18:34:53 +0100
Message-Id: <20190208173458.4801-29-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
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

