Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE23208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzmOCFOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE23208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbeHGAkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:40:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45358 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbeHGAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id j143-v6so10187748lfj.12;
        Mon, 06 Aug 2018 15:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qE651b7//Tbsbpcejonm6kJTFp1EXDTRFlY4lg7NZoU=;
        b=UzmOCFOqDbEGpqK5M4xDrxNAXdA3kP3pyZWsy3bzWt+QEaIOW0BJvYmUtU0eHMSfWa
         t5oVqRitJyP6DHIEZXrdHyovb1X2Z36+gu4NJLjnfQES3lDRH7S2v9e3yapUI7mhjh83
         kn+SzD0tfX6JQV5IqXDNdFLEdYJPNEbuVpUZJV9TQSKe+hJ1bPnYIoOieYMLOVLTQzO7
         SPikvaqzL/0F0YuqFhAOJeSD562MHRn2wn0OMrX6KZWDezmsDRvMLqGvOEHHqLslcPc4
         nST822MJLIEu+ih9X92tJjWoNSpMGhYy1tVBsJtaY3+Y1cVLKcMuhduwqC/YOBJs3xxx
         wp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qE651b7//Tbsbpcejonm6kJTFp1EXDTRFlY4lg7NZoU=;
        b=CUhYR8yk3ISYPLQc3KfU8oTQd/rEn5fMq+2cGPZR2IzM5RepSkkxAdSveyJqzV29JL
         uplykiHZgCimEV8p9tQwsELh2knozGkOseKIE5x68WF2AtJ0z2W2Z5Z6A3eLlvAfUl0v
         3PN3Xvf+1zI6FfQEnf3OqLZD5JNlT+pGDXuMJEywieAh0dxvN7GnuBIn7lijTOVYgQbi
         lvef0i3eLwCo9KUporoK0mhwhk+iF6Cv6/hMHJEPDS9VXDkPZWWU1VWgzM7Ada2QcnT4
         Pqr3YTij71qk9+f6fj7VUI7jKR++PbDhalNgZMRkDwGhvpiHkB0acWgPGlKdau8EairA
         TU0A==
X-Gm-Message-State: AOUpUlEWEWqhN/Go/P9FmzfxPRTXOayFoNLEWhJNJUh/+w+dPFGdRc/R
        Kh2Wes1LFgGv5qqXhAbtetEdnR3Xsb8KXQ==
X-Google-Smtp-Source: AAOMgpfPA1GoyiViwrZ+zcc9ED1kWg0CchOueaRUSh+QIUJrLIOeXMRKB062ROUOwBPzBoziWlnPxg==
X-Received: by 2002:a19:4e06:: with SMTP id c6-v6mr11876651lfb.30.1533594571832;
        Mon, 06 Aug 2018 15:29:31 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:31 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/12] ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
Date:   Tue,  7 Aug 2018 00:29:09 +0200
Message-Id: <20180806222918.12644-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data port used by Amstrad Delta NAND driver is actually an OMAP MPUIO
device, already under control of gpio-omap driver.  The NAND driver
gets access to the port by ioremapping it and performs read/write
operations.  That is done without any proteciton from other users
legally manipulating the port pins over GPIO API.

The plan is to convert the driver to access the port over GPIO consumer
API.  Before that is implemented, the driver can already obtain
exclusive access to the port by requesting an array of its GPIO
descriptors.

Add respective entries to the NAND GPIO lookup table.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index eedacdfe9725..16f7bbe47607 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -337,7 +337,8 @@ static struct platform_device ams_delta_nand_device = {
 	.resource	= ams_delta_nand_resources,
 };
 
-#define OMAP_GPIO_LABEL	"gpio-0-15"
+#define OMAP_GPIO_LABEL		"gpio-0-15"
+#define OMAP_MPUIO_LABEL	"mpuio"
 
 static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 	.table = {
@@ -349,6 +350,14 @@ static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWE, "nwe", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_ALE, "ale", 0),
 		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_CLE, "cle", 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 0, "data", 0, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 1, "data", 1, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 2, "data", 2, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 3, "data", 3, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 4, "data", 4, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 5, "data", 5, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 6, "data", 6, 0),
+		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 7, "data", 7, 0),
 		{ },
 	},
 };
-- 
2.16.4

