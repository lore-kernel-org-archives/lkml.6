Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585C1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F5F20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSdoEPD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F5F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeKUVkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:40:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43206 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeKUVkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:40:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so3653905lff.10;
        Wed, 21 Nov 2018 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GEY4Eg/HyBux+h94i0R3Me7aHdi4FQExdO6ecAY2kg8=;
        b=fSdoEPD4EYSMpQ0bLrJrz2xELWJ9+cHimuDX5KKGx9MMgkOOFsguXqF7E9zlik6HtB
         9p4Bmys+PbPamWwAHt1iHrLwsuI5GEd0n2sp7MeWszGX1WjwtVtsj3B9YrFlCK46KO9r
         VbGVL3tWFBR4dHv9xawfjxDa2jSVVCJO6sLU9+to8TGLo3UliR391HlFsxvUmIP2aywj
         FLXBhF+Lb01RoXNx2g5hCIk/UVrKtUzyhtq4BL26eKZpcLWtQhY1En3Et/nMhflyho5o
         q4zQgPWMzJozWpj/pQ8I1Ai+WVD0H6ScThlgYKGuVt+WXqnOu6EGdSKtpt6OIjsTG+Mv
         KcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GEY4Eg/HyBux+h94i0R3Me7aHdi4FQExdO6ecAY2kg8=;
        b=Ln95vLWnsa6uSYJAa856KDFWrc5aila8Rs+/wbWSme45UEIU7+n9cMj2GZT62ALwTN
         kv3n6pkaVhJHywdrsQ39fTlgqU6m9BIV5xLoNK8ATP9uw92SNpOAIgmQuo5I1L5+CvCB
         CMw9mrrbw7chgMy7OVBDUNedjp8q0P9lkkmErTulo/NCIayZ7QyHIODIrfCcm5ZmGLpN
         O8bFKAIQuFWImOF4pJ4MVVVA0iKAoNCm5VMAUoMzU9sa0lGAf1oCHXD5bVn8PMyYZWZH
         2HkcBRYhzzD89jNSUjoJIeXb2sCFbg8UJjpi/FHxR2s8FmKk9Wh2yAeXrY4ig7lx1fbk
         uhKw==
X-Gm-Message-State: AGRZ1gKjHGNpw5OyZHjDunMRJEt5rB802AQxjlIlQLQ3R9fVOShLvExM
        NueCqTfEK0aI2DtwpwTECWo=
X-Google-Smtp-Source: AJdET5f8WSAo1r+yASJCCLVo/f7dN6rSkx0J1Ir4NQ6gzuzZob/aelqVPrliQMoack9I/rORP+uC8A==
X-Received: by 2002:a19:d486:: with SMTP id l128mr3305420lfg.114.1542798375418;
        Wed, 21 Nov 2018 03:06:15 -0800 (PST)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id x11sm7280047lfd.81.2018.11.21.03.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:06:14 -0800 (PST)
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
Subject: [PATCH v4 1/4] ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
Date:   Wed, 21 Nov 2018 12:08:03 +0100
Message-Id: <20181121110806.32076-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181121110806.32076-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
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
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 3d191fd52910..30c0d18f372e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -312,7 +312,8 @@ static struct platform_device ams_delta_nand_device = {
 	.resource	= ams_delta_nand_resources,
 };
 
-#define OMAP_GPIO_LABEL	"gpio-0-15"
+#define OMAP_GPIO_LABEL		"gpio-0-15"
+#define OMAP_MPUIO_LABEL	"mpuio"
 
 static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
 	.table = {
@@ -324,6 +325,14 @@ static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
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
2.18.1

