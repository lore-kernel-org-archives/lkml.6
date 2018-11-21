Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F99C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9DD20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMxOU5k0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9DD20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbeKUVk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:40:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39762 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbeKUVkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:40:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so4452120ljh.6;
        Wed, 21 Nov 2018 03:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SvA8iB/0liNWiwDNiorEUVzgELHH4Zp2PaoIpXtjOyw=;
        b=tMxOU5k0cslZHMlIfUvBdUHmq1Ry2NwkQXvLX2RDOsV4RPSMHUkqjtJmbcfpyFeSfv
         NaByQ3siV6ebsZAm2D7yIJXG+kfozHtuM1ghNNPyJBcJ+rEEXnOKiclH92vhvFmsN8W7
         ZSbps9crF1CcA7zRnIXE9W4hqHk9KJjhn/TgrZuxpHbifIhU6XBAg7Z3HIm/0UrlxPf6
         E6DeKdoYYjhUSFU1NyD8YnbBEMy41T1+F2tPy2wBFbSB4Fnf9y9d5uMS42OCZ3iPEXio
         wM/H8ovVU1jWcEVULT74WkTtRsp+NZ/JzXY2vzpS+CGqBPLDybRcu13qLLVR5sP2ePyA
         AALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SvA8iB/0liNWiwDNiorEUVzgELHH4Zp2PaoIpXtjOyw=;
        b=BoWwSLFLMVqtnj6fz5b8XsQoD4amk3NFrWv8ZE0HmBm4gGcE2Ymg8dnH1DhhEeQdVD
         2362Gm2yGhE/WUgwUyQdQaNnGuuQIe0jiXfZQQ+ZAjqYWa/HLmbDHnOgJF8lgSasS43z
         7+c6x6xm/fj9u5gSQCY7DRksTUWX8hPElKJndW7DUbMNaDQB+wJdaOj1nlW08QiwICWT
         TGsCYI5H3/oFW+ODK4yvNw8ureUDDBZxmHKzZRVjeu4+cMnOzVZbE+daZZCngmTqfBql
         98YpqrXvhCDILcFxDYbmurQYMnxmPJ8S0xzVje/jTFdx52yTxAm70vrduT7xCFIifEtX
         7NQg==
X-Gm-Message-State: AA+aEWYMjzmkHO+61UOu6qMumpR6dSDV+roq/Hx4fxsNvZ+5hBSg82d5
        5WAqcvZjRx6DrksQ14Do+Oc=
X-Google-Smtp-Source: AFSGD/VjM/e7X735C5hPDWPwF58hLzcvook6hT6+LOsvdb25HxWODcuqc+6gxeHPVQmOAyDOf9v0NA==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr3532493ljd.137.1542798380645;
        Wed, 21 Nov 2018 03:06:20 -0800 (PST)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id x11sm7280047lfd.81.2018.11.21.03.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:06:19 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v4 4/4] ARM: OMAP1: ams-delta: Drop obsolete NAND resources
Date:   Wed, 21 Nov 2018 12:08:06 +0100
Message-Id: <20181121110806.32076-5-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181121110806.32076-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amstrad Delta NAND driver now uses GPIO API for data I/O so there is no
need to assign memory I/O resource to the device any longer.  Drop it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 30c0d18f372e..d594f60c3224 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -296,20 +296,9 @@ struct modem_private_data {
 
 static struct modem_private_data modem_priv;
 
-static struct resource ams_delta_nand_resources[] = {
-	[0] = {
-		.start	= OMAP1_MPUIO_BASE,
-		.end	= OMAP1_MPUIO_BASE +
-				OMAP_MPUIO_IO_CNTL + sizeof(u32) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
 static struct platform_device ams_delta_nand_device = {
 	.name	= "ams-delta-nand",
 	.id	= -1,
-	.num_resources	= ARRAY_SIZE(ams_delta_nand_resources),
-	.resource	= ams_delta_nand_resources,
 };
 
 #define OMAP_GPIO_LABEL		"gpio-0-15"
-- 
2.18.1

