Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279F6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A53208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLvbaHVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A53208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbeHGAku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:40:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44903 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbeHGAkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so10177529lfb.11;
        Mon, 06 Aug 2018 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SWahyGay3HwJh/h6LbGc9ebdup+F8+u0inyd1av1TUw=;
        b=DLvbaHVfIveNt1OnDBxk12VwUJvePDKmfiwXglM8Uv329JWmzCEgl669za2CUifPxP
         Hy/RM5Po8w2Rizm2UAqw925zl6afSZnTysAgUv4eTEgd0o9RULFOvaNWd685MERyVlno
         /3HKK3vEbIVySzzxS1MeAcU6cr4FOyLQd6a9bXNGZlLF7pwSoHWj4RA4Dij/Nt9i2Ax5
         tKOgYi2oGqk90uBFRuoR+jeHRnty87f1pbB1vrr0aDx/G4GAOEvuDrMLsPOkfX3+9s2V
         XYhjsq5ipuSjpjvh4uvVPEUzW5NdTSWi1//1rNYc4xc/geueFlZk0u+Vkv1QPPSoq/jY
         dX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SWahyGay3HwJh/h6LbGc9ebdup+F8+u0inyd1av1TUw=;
        b=JBp9jYoOftB/9DXHVUyRc365lLu5P/NPDqmnFl7ZE+F7ZGfnORoUitOBY/0G4szJGQ
         mUhZ7z4XeJ0C1pWf3dg++0d8V/u0oSyOzthc4UtI51ygXNyB9sEYDqPghCFPDe2X1sIH
         5/cC8JwL1X1/qFJTwnKNFBC8amFMSC1yNNZsx1ACevcVC1+xUdtHwy6lJUyCzXEvcdIx
         I7Q/8RiGVVQT9SWmnqdOvEji8++kZ+ccMAYz908URMslYark0BNQybbak2FUyYXOeqCB
         GFK/WPYpyForKHdbj4HL+Oc8R+TnhWhiCfsgIxT73xAbMcqeoHh/enut6/aa7GA8c+TA
         14IA==
X-Gm-Message-State: AOUpUlH6CWaxSNMOeXuaUUWcUrE7K/RkT904Y9YoaZHg/itMfw8lup7D
        AkbHctCvsTP2kOy7wSWay60Oy/fzNt49cw==
X-Google-Smtp-Source: AAOMgpceb/pNRnyiT5iMuDkPQySRSy5cQViz00DEdxe0K16VqXpbOtlW/bnNiEeDAh+rdvIlKYft9g==
X-Received: by 2002:a19:1dcf:: with SMTP id d198-v6mr11998875lfd.144.1533594576160;
        Mon, 06 Aug 2018 15:29:36 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:35 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
Date:   Tue,  7 Aug 2018 00:29:12 +0200
Message-Id: <20180806222918.12644-7-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amstrad Delta NAND device now uses GPIO API for data I/O so there is no
need to assign memory I/O resource to the device any longer.  Drop it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 16f7bbe47607..08e732bc1cd2 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -321,20 +321,9 @@ struct modem_private_data {
 
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
2.16.4

