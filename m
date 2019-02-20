Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C722421773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThcRlPEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfBTFSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:47 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40728 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfBTFSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:10 -0500
Received: by mail-it1-f195.google.com with SMTP id i2so12615465ite.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUA0fpNPrsgd3wqYoPcgo7+fQEmuYu8Eq+Elruxjn5o=;
        b=ThcRlPEOFZ3ZPFw7+sau+/TtSEu2eXfOfHdRXqLvWPxOIqibig/X3piW1+kAvbqSnn
         flik26BqPg0m2nwdQbyFniwnG4G/f6gTokTDB5HAHQXz93GBRaSj6o12L2WVr0Lc3nse
         ql0FdMcDN9a3fbw3NyFmnR824r71R6GGHJ48iVMSiEOJvAKUq/ED1KLyCR5aW6vjIleS
         p8vS/ngcbGmYPza/csuD62xAlN19OEtPiYw+TlX1uEpCbXEMUjFVUatg6glyZDkzddXD
         ySLH/v6I4myc9Jv+qky1S/HXu2TheTo7R06qcHQ5xmQQ1bHUxvSnheoILz7ZV0wPPQaK
         u0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUA0fpNPrsgd3wqYoPcgo7+fQEmuYu8Eq+Elruxjn5o=;
        b=bdzSHcjXtyrR0Zet8KA2XIxQBzWrr/U7bOuLISYFbxZvWcw4noxeIQjWhTsAu56G1D
         2pWJgZs+b5AQQ2fL/k4pfnLIHwK2E0/utdqdE8o2VworPsY5/pSYXsj7mKsmNVAB8yFO
         fnDxE1KFj+N8jrX2gzmfMyQrVuHlxj1CU07iL4tc2zEaxOQJIWEb2pu25s0T65ur3i76
         T2ogwFXX/SxahXUKlB23zq+ajAc/scbvKSNAXC7wp1Wtq+4/we87vZloRa69JABmx0Cu
         MYdBMo5DdRm41jBCi2/Mo1sYgMDTIVKYToi1QD1GVtaccxMkjz/LFCRLfaFRaBseHpJH
         u4sA==
X-Gm-Message-State: AHQUAub9BQRNKOWa1Ef22RzA2Jp2NOhNdclc0Q7j5jCOzTmTrXbhEvPP
        U62AZQQpz8Vf2cfJfPCidho=
X-Google-Smtp-Source: AHgI3IYfOY6AVdBVoUEAC3NAlhDUya4qC9b05XxHVpg61F1AFmPbxAt2/xf4qT4tx8ex5bPIs6Wwyw==
X-Received: by 2002:a5d:85c5:: with SMTP id e5mr17584007ios.125.1550639889213;
        Tue, 19 Feb 2019 21:18:09 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:08 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 03/10] staging: mt7621-mmc: Remove references to nonexistent mt7621_spi_ops
Date:   Tue, 19 Feb 2019 22:17:47 -0700
Message-Id: <20190220051754.12195-4-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This struct does not exist, and when it is looked up in the
compatibility tree, it returns null.  Remove these nonfunctional lines.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index b509f9fe3346..d260b42ff328 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -58,8 +58,6 @@ struct mt7621_spi {
 	unsigned int		speed;
 	struct clk		*clk;
 	int			pending_write;
-
-	struct mt7621_spi_ops	*ops;
 };
 
 static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
@@ -330,13 +328,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	struct resource *r;
 	int status = 0;
 	struct clk *clk;
-	struct mt7621_spi_ops *ops;
 	int ret;
 
 	match = of_match_device(mt7621_spi_match, &pdev->dev);
 	if (!match)
 		return -EINVAL;
-	ops = (struct mt7621_spi_ops *)match->data;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, r);
@@ -375,7 +371,6 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	rs->clk = clk;
 	rs->master = master;
 	rs->sys_freq = clk_get_rate(rs->clk);
-	rs->ops = ops;
 	rs->pending_write = 0;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
 
-- 
2.20.1

