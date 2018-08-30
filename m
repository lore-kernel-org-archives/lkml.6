Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20CBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD122082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx03mtGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD122082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeH3XFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37606 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeH3XFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so9003265wrr.4;
        Thu, 30 Aug 2018 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I+V9O+J09+ESFMr1dY4PF7vqVL3mWhx37+fApLNutyc=;
        b=fx03mtGoum4+HwhhL/qhLqWiMq2R3CtQ7TeNNIDZbgOClIfZjN6In/lQFO4q8v2Dx4
         jHy+JTHn1DcGr0fkWTXr1AtZdxhgPOuZItd66P/9T8rrft3xH6RDlLBGnCeq5g6Cu5NU
         jI9MbHnAXSTK9CLI72ms/8qk/Mw/DhfqGJPjUoR5uNew2tHoL5kcKNBUXuC3m0O2M8yQ
         4QrvnQMWRONF2vI11Ngv+i/1LoF7+Q+koYCS6KJvc2lTENxT2ubMwnBoJyjL3qYkrSvb
         Cwzxz34Q0Sndhb1djxVkEDfU9qCmQIx7EIm1PVqZ37KUWL+tULALWe5pVAEuWsyzezXl
         uXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I+V9O+J09+ESFMr1dY4PF7vqVL3mWhx37+fApLNutyc=;
        b=DqlWC29Kfoj/tGUDoFRckhpYHgbyUl0nNURSPHs0QAYYCL+vGcFJYxLiK1mFku1UM4
         Y6ycXrdBFeVy+T8wWjZ17seIgPc4dH/T7u3XKeqhOrJAeLoDeeZn0mFjyQNH89Lr9Rfx
         p/FJhMz0geDcSfulSOhRe7dxei9sp19cI8HA7+nOxe6dTokqKYMuT1DDuHQcGO1P0w3v
         4noZDkHNiFm6uEm02nzz/s7Qq6JE9m/xUCt8XVyEkIWN1rlr5iU7oIq8OSewC+TebIYJ
         AKZY97zN/giUxOFaJk77q51gRLFYcRIuo9yodOP11Y+a3ngkUASjD6YQVVwO1XfcQuIx
         0l9w==
X-Gm-Message-State: APzg51Az+yktSpq/QivE+HhcBD4wZfN1psxi1WH+iTpCIlk+Twvgohgw
        iGurbB0pnDRg+Qbx6lSz3aA=
X-Google-Smtp-Source: ANB0VdYy02/TiJd1eUIVRP4PxJdOxSOUfmya8Rk5fScvfNvg6tGJ5IwdWX2GOCkGyH+D4ibJw67fdg==
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr7929996wrp.184.1535655699445;
        Thu, 30 Aug 2018 12:01:39 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:38 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 07/13] ata: ahci_sunxi: Bypass PHY init when using the new binding
Date:   Thu, 30 Aug 2018 21:01:14 +0200
Message-Id: <20180830190120.722-8-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new binding split sata in two (ahci + PHY).
ahci_sunxi must not mess with PHY when the new binding is in use.
So when we detect sub-nodes, bypass the PHY init code.
This is a temporarly workaround for the period where DT and ata code
will be merged from separate tree.
When both new binding and PHY driver will be merged, a new patch which
remove all PHY code from ahci_sunxi.c will be sent.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ahci_sunxi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 631610b72aa5..a09d189c6dda 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -96,6 +96,15 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 	u32 reg_val;
 	int timeout;
 
+	/*
+	 * When using the new binding, the presence of a sata port node
+	 * means that PHY is handled by the PHY driver.
+	 * */
+	if (of_get_child_count(dev->of_node)) {
+		dev_info(dev, "Bypassing PHY init\n");
+		return 0;
+	}
+
 	/* This magic is from the original code */
 	writel(0, reg_base + AHCI_RWCR);
 	msleep(5);
-- 
2.16.4

