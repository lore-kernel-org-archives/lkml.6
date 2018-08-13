Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B822AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C6221709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc/sO7oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C6221709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeHNBS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:18:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45654 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732285AbeHNBS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:18:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id w16-v6so13829062ljh.12;
        Mon, 13 Aug 2018 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vz9K13ZdWceVmktSg13RqIlA5y3YYBZB41889HPVjQw=;
        b=Sc/sO7ozOO7qtE4QOYuSezh34zlQZQF/CwIF+hc5XmTDozjQPbofdPDOH7wKsrAv09
         rsP9q0XdHyaFxIYcARAwl9mUS5wf7EBxAphKJjTm27vPROwqTf9PhFfvqGZ4GPbU2ihq
         nYHVBrhaZ7RDGyUk1meSmPV5AE68QM2PUAv2Wh7OP37QfTZ9rSu4CyxdO77XqNb6y8Fk
         2JMRGhdStE9Q8yVNIsVMsILg1X5Yi0UWf7Uj+HueCltF5LKXsDLE0Wi21lKB2AzES4wx
         iY0ybRv7kdeiTzOkKUqsjAcdZYWtv6abVoWdJ+wxA86hYQ13Pkk+/LgGpR1M/DeB/8DM
         KKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vz9K13ZdWceVmktSg13RqIlA5y3YYBZB41889HPVjQw=;
        b=nKUA3esmqEJXlgg4Vyj4/XBSf33ebrmuglnLx7N9NwlV6smzPGEMJQbQDnyoDTHEmc
         f4nyjZr105TCmNt4S+zl6yOQbB1280v6rM2NsZRyouCbBKDW5tngqsoLjmdkKWkpnobA
         PnSra/JIMnWI6BHfOl+kTxzhZS/Y1AM88zsYOrp8b+kcwYFw6XN8Slog1k3uPQGSsQCg
         3/qd+zWUrubhp54aq114j21lxlJlb2vyAJJulJGoKZf4/sNTwibAN9DEe4+j0OGlsFoI
         E/1cJlrU6Sg1lrkK7hYlHdnw684BrAye6bSCalbwMzUmvPySdAApt/ozItN5sYkAWG89
         KpEg==
X-Gm-Message-State: AOUpUlH95CUf+5B87PpLObg6/LbZrxFl0LZwIfpNRyX+tcQoWUTRPF64
        qOEgLsnmTZMyK/2NiEmHi3Y=
X-Google-Smtp-Source: AA+uWPxJN79o1XPPqE854s9dxRpDUISzRyn0pzGpzAf8KYPCwk5o0DCn2KcOhBtvHMIoatz7sqmBdg==
X-Received: by 2002:a2e:40c:: with SMTP id 12-v6mr14031781lje.146.1534199682700;
        Mon, 13 Aug 2018 15:34:42 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f136-v6sm3572702lfe.71.2018.08.13.15.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:34:42 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 4/7] mtd: rawnand: ams-delta: request data port GPIO resource
Date:   Tue, 14 Aug 2018 00:34:45 +0200
Message-Id: <20180813223448.21316-5-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180813223448.21316-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data port used by the driver is actually an OMAP MPUIO device, already
under control of gpio-omap driver.  For that reason we used to not
request the memory region of the port as that would fail because the
region is already busy.  Despite that, we are still accessing the port
by just ioremapping it and performing read/write operations.  Moreover,
we are doing that without any proteciton from other users legally
manipulating the port pins over GPIO API.

The plan is to convert the driver to access the port over functions
exposed by the gpio-omap driver.  Before that happens, already prevent
from other users accessing the port pins by requesting an array of its
GPIO descriptors.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/ams-delta.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 48233d638d2a..09d6901fc94d 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -161,6 +161,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	struct mtd_info *mtd;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *io_base;
+	struct gpio_descs *data_gpiods;
 	int err = 0;
 
 	if (!res)
@@ -261,6 +262,13 @@ static int ams_delta_init(struct platform_device *pdev)
 		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
 		goto out_mtd;
 	}
+	/* Request array of data pins, initialize them as input */
+	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
+	if (IS_ERR(data_gpiods)) {
+		err = PTR_ERR(data_gpiods);
+		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
+		goto out_mtd;
+	}
 
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
-- 
2.16.4

