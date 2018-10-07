Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA833C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D3B20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbital-systems-com.20150623.gappssmtp.com header.i=@orbital-systems-com.20150623.gappssmtp.com header.b="k8NevolL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D3B20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orbital-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeJGUFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:05:44 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38545 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbeJGUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 16:05:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id g89-v6so12162723lfl.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=sP1Sxh5ebnKAOFPL0feaAq2XD5GzEUkY3OdccZOBVk4=;
        b=k8NevolLay70sUhi8GbrVRkN2qg1uW0LQK58XFKEgHD6A1ZEXaKhAYroCP0/JvTBrD
         RQsAGtUxJ+/rR7aYSfere7K5NlFhxOXdUy0saWXzzrDXwSWWQcdPcj/3+dKGkG4H8Vg/
         SwWa6VPIua6r0rZe+GeW1WIvjqH/dmMAiDqlobiXdk3CIPH3Fm+8XPf5rk0wHNru2o19
         XkjfFWqIf5hF+XhzmOlNK4BDi1a2eFt99VtU//yzYNrJl7N2zJnHW/+C58sMbCa7DdBA
         fS3W6DCKw1m5TBWtypKO7v2vBHdqyT2YNDg4tlPXbJW/uEOW4H5nVjYXktROASnt5g1y
         gLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sP1Sxh5ebnKAOFPL0feaAq2XD5GzEUkY3OdccZOBVk4=;
        b=oadswaDe4vkKuENjz2cOHXFPg6j1hNmcukB11qiCzEdwYSYawpkpRkyI1eGr8bWB8/
         T6aV8QgQjDtxYb+Tqf2X3/22LBf8LlN4N2asu7lLNQceMd0fQ9nHtDkOus4dmQPSk8RP
         ZpmwqihV7ydZ6rpIWvf2X12Z6dpk8hlAV5oHIbcXKZbD8CdgplZet6EjHZzmdQyuJlds
         OGc//7YOxyeJXvHy3PL9U4Lwfv7HMogwaT0RZXnpOE3FLs+cMRc/0F7jIsLGu37XZFGV
         xVZ9+HXI92KRzs7GONLxThJ57KJ/8RHuqYtF7e6Y4N3C6hLtyqWbacycTjNAbefSPrbJ
         x01w==
X-Gm-Message-State: ABuFfohrp5MNqk6j7/qNxFVEQNFmEUw1g85QmBmCAKBJsJUYya2mzNs3
        ucRU5omApsneGNPBvkqumMZQ3mLMBEg=
X-Google-Smtp-Source: ACcGV631/60NcoWGOaVRVGqEJGBaehvVV5DeUAyPLrGIyhCamAmnFjK2LurcfFO1zsYN4Hg386Sl4w==
X-Received: by 2002:a19:7709:: with SMTP id s9-v6mr6521028lfc.84.1538917112471;
        Sun, 07 Oct 2018 05:58:32 -0700 (PDT)
Received: from localhost.lan (81-225-58-94-no182.bredband.skanova.com. [81.225.58.94])
        by smtp.gmail.com with ESMTPSA id d126-v6sm3010155lfe.75.2018.10.07.05.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 05:58:31 -0700 (PDT)
From:   Jonas Danielsson <jonas@orbital-systems.com>
X-Google-Original-From: Jonas Danielsson <jonas@threetimestwo.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Danielsson <jonas@orbital-systems.com>,
        Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
Date:   Sun,  7 Oct 2018 14:57:45 +0200
Message-Id: <20181007125815.8392-1-jonas@threetimestwo.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Danielsson <jonas@orbital-systems.com>

This fixes a bug where our embedded system (AT91SAM9260 based) would
hang at reboot. At the most we managed 16 boot loops without a hang.

With this patch applied the problem has not been observed and the board
has managed above 250 boot loops.

The AT91SAM9260 datasheet tells us that with the instruction cache
disabled all instructions are fetched from SDRAM. And we have an errata
telling us we must power down the SDRAM before issuing cpu reset.

This means we need the instruction cache enabled in at91sam9260_reset()
At the moment it is being disabled in cpu_proc_fin() which is called from
arch/arm/kernel/reboot.c.

Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
---
 drivers/power/reset/at91-reset.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index f44a9ffcc2ab..78972bba64df 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -50,14 +50,24 @@ static void __iomem *at91_ramc_base[2], *at91_rstc_base;
 static struct clk *sclk;
 
 /*
-* unless the SDRAM is cleanly shutdown before we hit the
+* Errata 43.1.7.1 RSTC: Reset during SDRAM Accesses
+*
+* Unless the SDRAM is cleanly shutdown before we hit the
 * reset register it can be left driving the data bus and
 * killing the chance of a subsequent boot from NAND
+*
+* Since we are disabling SDRAM need to make sure that the
+* instruction cache is enabled.
 */
 static int at91sam9260_restart(struct notifier_block *this, unsigned long mode,
 			       void *cmd)
 {
 	asm volatile(
+		/* Enable I-cache */
+		"mrc	p15, 0, r0, c1, c0, 0\n\t"
+		"orr	r0, r0, #4096\n\t" /* CR_I (bit 12) */
+		"mcr	p15, 0, r0, c1, c0, 0\n\t"
+
 		/* Align to cache lines */
 		".balign 32\n\t"
 
-- 
2.14.4

