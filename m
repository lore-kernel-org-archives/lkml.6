Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F42C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00BE20449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gfgHhJCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfBLKjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33111 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbfBLKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so2131169wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Hwye1NlQfpROfiatGP4AAPQ8WZ+X3wpSFiN169P8MI=;
        b=gfgHhJCIMdwQyiwFGV1QkFfJAo/DDHvP+0/W4htvK6gnnLaReXahhbh5X74EFkBBfr
         sKc4L8uQ2ODt66SDQXUryWorKbMbxWYx0Vpi5SNsosTd3CsR4t75neGvePx2UBLCA78C
         ipcJlrHYVRryoueriLI/jIT36jpGFvy6z1GXJHmOgE4JE+kryJa+aAjgAD4PfU+exRDT
         QuMf+gGATYsaB0uHAY5L95hFytaZNmdkEblwyLBD0WfFf92WPlSf5Y82Q5iI1TtipcS7
         6TX+OTLvfQ4WURPzfgC9Dg2WeQ/j5AUUaCoBgui3yfzWCYus2dqshT2nDPiupSI2FWHO
         dj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Hwye1NlQfpROfiatGP4AAPQ8WZ+X3wpSFiN169P8MI=;
        b=A5kVgA23qInx3pzUaIWKtpx5sCP3PArGEaqvhZF+kJriSkRHWFXdUcKjmJDcmyrGPr
         jAcD1ua+Iv5clJPoep3ffPSBpWZsOmM+lhLqIvMLXnLsdsFXav36MFMxurNUkP0e74FN
         7izPsA9elv+vjXs6N0XtDvqhUjf0+39ulDJK+fAOXRnTqk2D23sMYBsyiFkyfJ9Nn7me
         NMC/6svEGz8CqhLNtJPFPgyxObfQ3wZd2jVwOQ4LagzLeaYZryhjhEQqBJ21bazHmIAN
         uNzM2IfvQtHii0T1u4iGj7NycDnUoZx1Y8TE0Q8OtqkoQdQYNjq6EDnvQeRIsN3qOh6Z
         520Q==
X-Gm-Message-State: AHQUAuYiyuy+qT/eae7n0xdRmhk9OesW/vn80rvyq7aK2np/1EPUHpuH
        eI+IZSbmI/mZII/tN8WxG0mCuw==
X-Google-Smtp-Source: AHgI3IZzJrN9VqLpqD7nqk+Dht2iIf2+d7+v4HQuiBiFinrky53GVdpUqe79GPK45WLE4hPlxLlhsA==
X-Received: by 2002:a5d:42c3:: with SMTP id t3mr2257680wrr.232.1549967959188;
        Tue, 12 Feb 2019 02:39:19 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:18 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 19/37] ARM: davinci: aintc: request memory region before remapping it
Date:   Tue, 12 Feb 2019 11:38:17 +0100
Message-Id: <20190212103835.7768-20-brgl@bgdev.pl>
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

Add a missing call to request_mem_region() before calling ioremap() to
make sure the region is not being used by anyone else.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/irq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 2afaf19dc46c..2b6943731af9 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -86,9 +86,18 @@ davinci_aintc_handle_irq(struct pt_regs *regs)
 void __init davinci_aintc_init(const struct davinci_aintc_config *config)
 {
 	unsigned int irq_off, reg_off, prio, shift;
+	void __iomem *req;
 	int ret, irq_base;
 	const u8 *prios;
 
+	req = request_mem_region(config->reg.start,
+				 resource_size(&config->reg),
+				 "davinci-cp-intc");
+	if (!req) {
+		pr_err("%s: register range busy\n", __func__);
+		return;
+	}
+
 	davinci_aintc_base = ioremap(config->reg.start,
 				     resource_size(&config->reg));
 	if (!davinci_aintc_base) {
-- 
2.20.1

