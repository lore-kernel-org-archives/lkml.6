Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437B5C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D7E262D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyX6Ekxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D7E262D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965336AbeF0NSB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:18:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34286 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeF0NQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:16:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id q24-v6so3075550edr.1;
        Wed, 27 Jun 2018 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a0Pd4mw7Q5aTNDA6SDFTQadlX948ALFZiafBA88Rw6I=;
        b=RyX6EkxfLcoZlBKpxFI1x0IDF5e+6lAku183P11kgI9JR/u11ZCO5pzMEU0cNLnkok
         787Qk81NumjKRA7LtjhBzEfCt6uWK0BWVTGXmRwzNtPb9UygfrcEjrKegoecPpZlwYzB
         I2Mn+XDbClJz3SycMA0oVG0vmjSYYml9IZ2m2yoY2FLVd1TFkitiW3dxsjI704ydkdRi
         hPFGtfxqg6T8XLU69X3eJM7NxacJ/EJoOTbVhtUJSu0uK/7U8/oKBbxbM+ey/m6vR4xq
         LQlmxGQJfZWk28qUq3GuqHL3wL0NeietCWLzq10Y+yRblQGDKTspbBPFmzdgIsVHdTgf
         gcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a0Pd4mw7Q5aTNDA6SDFTQadlX948ALFZiafBA88Rw6I=;
        b=pl+NQHYDNNVz+/R1U1m7VBTjBmwkh5aAEhtm7p9dDqX9MZd0uNeU4g8SK3Hbtl+2fH
         iGcUbpt34jhemSuiCKCc8/JdzcjTpkmei04yNYqryQLLTvyxRAznrNVc/5AeHoYOZyZs
         itKemLFTkg+7ntS7RD6T415ehQcRyassBfKGOt0HNiq+APZ4R/95MrcWhT9b5XtNqgR2
         gn7vsB2gYGo+iQBdUbQn9xybnLCKkicr8Kvm/t/bLKTz0Fyt0KIAG0e2lfy62B+2DLAy
         ZYOfSMU5E1gkv1pM6QKK0SfbirwEs6ViKMsf7r7d5Tmbz0ribd1L5QGTpZqDLk+YJ9E1
         En7Q==
X-Gm-Message-State: APt69E1/srd/2oIsOHlnMf2fL2R1Y1PxkDoj9k3Kp1OIgx26PXmfJrlI
        arwo8t59ic7YXaTnB0UKVw==
X-Google-Smtp-Source: AAOMgpdkp1+ED2HFl52IJn80SrFe3aYUWo5b7CMdeNsS5zPdoRhPWBXJRvQ5MUqYbmr8RV3k236Neg==
X-Received: by 2002:a50:83c5:: with SMTP id 63-v6mr5751833edi.276.1530105379295;
        Wed, 27 Jun 2018 06:16:19 -0700 (PDT)
Received: from carbonite.sagemdenmark.dk ([130.228.251.5])
        by smtp.gmail.com with ESMTPSA id i34-v6sm1953000edc.29.2018.06.27.06.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:16:18 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: [RFC PATCH v2 1/6] mtd: spi-nor: atmel-quaspi: Typo fix
Date:   Wed, 27 Jun 2018 15:16:04 +0200
Message-Id: <20180627131609.13681-2-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627131609.13681-1-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just minor typo fix. Fixed in preparation of new driver.

Signed-off: Piotr Bugalski <pbu@cryptera.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 6c5708bacad8..bdbfaa632dbf 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -67,7 +67,7 @@
 #define QSPI_CR_LASTXFER                BIT(24)
 
 /* Bitfields in QSPI_MR (Mode Register) */
-#define QSPI_MR_SSM                     BIT(0)
+#define QSPI_MR_SMM                     BIT(0)
 #define QSPI_MR_LLB                     BIT(1)
 #define QSPI_MR_WDRBT                   BIT(2)
 #define QSPI_MR_SMRM                    BIT(3)
@@ -563,7 +563,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
 
 	/* Set the QSPI controller in Serial Memory Mode */
-	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SSM;
+	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SMM;
 	qspi_writel(aq, QSPI_MR, mr);
 
 	src_rate = clk_get_rate(aq->clk);
-- 
2.11.0

