Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696E9C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231E021A6A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcxD45QP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231E021A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbeHGAl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:41:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36245 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbeHGAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id b22-v6so10240804lfa.3;
        Mon, 06 Aug 2018 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Ttieek8EVt2mQNwFsLifOKl+ByDrQm129q1TWk/MX0=;
        b=IcxD45QPCPRzl8lvaY9qsjTGsRNs6gWfl2bUuk41J5q5nlNd/Fj4+pM9RgOb76Q+U2
         QCaN54RsUEQdvWW5sJ6YABUFPk05R+SVe3un3mnPX5pEBfeyTIqCWgNFFhTv7DMayYO1
         UWFExZhfYv+7AKsNAu2/dSz33ocTaOIo9k8JoVwPEmic4aEPZM5DcDJByX2djQxqgyex
         YQuNwHMaR9bdjr2mRGVeR2U+QzEyRM1W4ZNJ39DSnyZRikWRiSe7o8TAIECDNENqXRUR
         msBwhq4dzMfYMLobnm2H8/kTmAjU9b2SnxkUq/L3HdWgUfgClF1aUNt7fKU4pEJnT0Rs
         eRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Ttieek8EVt2mQNwFsLifOKl+ByDrQm129q1TWk/MX0=;
        b=dd4zhobCbFz5tRhyYXnxTFuV7dqUQBPopeV/AcqSv48xr0A7KAjDsQaZQX+BVGuEMX
         VZz6xUEmgJ0It9HFFvpBrKWPWmviLCS6OhU7hvFkCwXnk2+9agaTe4ObpT3sloWrg8ht
         cOy7grgBxa82X2TD/yM2INIYN4+iw2/bE2ANGrBg1fzWYBlQW18xQyzTc2JszGjY3YQ6
         PMh7I9epiD6letht3bRoj1gwWfGp1O4QJdroKKwJmChuF5PLv8U3BVEhGBMIQgY0XlTG
         WRzkyvc9Mt0u/LMv3z2X43akOkAJXT6PmPR0ejZL8RQrhiyoqW+o1cYVF3k74LO9nxM4
         NkPQ==
X-Gm-Message-State: AOUpUlFWoP2NvH/tQ2B4LwGMMBSHybPT9k1kzgUNDHA/0+61kTcfZFbF
        HpJCjm47t5Imxd7oTf90BrQ=
X-Google-Smtp-Source: AAOMgpelyUDqoYptEF511iNccJY2bUI4ITVIU7db9touIXSemg7s5zfKdMCLVZdy7hJLf7GIx+2KPA==
X-Received: by 2002:a19:c64c:: with SMTP id w73-v6mr12902280lff.2.1533594573278;
        Mon, 06 Aug 2018 15:29:33 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:32 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 04/12] mtd: rawnand: ams-delta: request data port GPIO resource
Date:   Tue,  7 Aug 2018 00:29:10 +0200
Message-Id: <20180806222918.12644-5-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
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

