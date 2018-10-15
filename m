Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07541C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1482208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7tUSrR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1482208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJPD0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:26:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39483 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeJPD0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:26:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id n14-v6so3146605lfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dibga34hLMVCgSOfwDffM77KybhlXTCzc0Iv6FEvork=;
        b=u7tUSrR4MWoM+BUWJL1qj07MLVVOQ+OzJT7ZLic7c/lghchr8s/3KqzPSna+AYW30P
         FEDGc07Igc1R12MT5mRiPEvAr1QHT6u2LemtevGbqYeFLGUEJzlHNJX75sXrhPq9H1Tf
         O4uDd31WY9AknqOoILabYDrNTW4fYRl41HLgKCrgQiU40VGdzOMN1E9B2QAiQfOZ8j7F
         B8DU5ffbssVLMKp7G7QjJ5pKsJf4N4FfSf0upkwn/WPCmUs+EfHT+18GQZYn53cW4QKO
         MxkSXJT0aYjMqTfjHWOKw48kQksSeoeKdsp4tFwVklFYhshs+q2INC5WPfKktOPLHcrS
         4T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dibga34hLMVCgSOfwDffM77KybhlXTCzc0Iv6FEvork=;
        b=G/9v1FGYQT9K5ZSMP9ZacxvKW/76o25cmjtP21xpekIB2fMHqz/mwX7rcfhJVrEYSO
         geaX9zlLscMnZBm4vS1mqAcIUO5ODnNLSAiD1nlemb4qDnl0Fj3o66Ppr9SGOfaHXYwV
         paf3aEhnPeLrBfp3S2C1fYS3YX2PBQw6FYNyYziMBiQVbCCVJX8PWEY2aCoyJUvDpDPB
         JwiHLDvLteqEJzDmavsnw3wLgWAe46e15nRsXDy6Bfm3eK+oymb6xjeR/JFopn551sq+
         8AiE0RXUEXJgLf7C9TkMdB9viDUA2qvBvitHFzSSg2ESbWwWCLyFfZFEdPhdYW0oL4pA
         2dEg==
X-Gm-Message-State: ABuFfohZg/uSKVcN2SSO+nh/E/u3dq8Aj0x0zTzFLFSGKH/PlB9MWvVI
        4Y1ubl87gltmoDRby060An4=
X-Google-Smtp-Source: ACcGV61b9bn1nMW9RBTGCwX7rjTc8onV90pa1+NQ1dqJRnIMLlFD6xs82emi+q943UygoLMkfG8ydw==
X-Received: by 2002:a19:d155:: with SMTP id i82-v6mr10417870lfg.127.1539632405294;
        Mon, 15 Oct 2018 12:40:05 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id l3-v6sm2658830lji.60.2018.10.15.12.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:40:04 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 2/3] mtd: rawnand: ams-delta: Stop using legacy .IOADDR_R/W
Date:   Mon, 15 Oct 2018 21:41:29 +0200
Message-Id: <20181015194130.21764-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181015194130.21764-1-jmkrzyszt@gmail.com>
References: <20181012204101.26274-1-jmkrzyszt@gmail.com>
 <20181015194130.21764-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace use of legacy .IOADDR_R/W with runtime calculations based on
priv->io_base.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changelog:
v3:
New patch, split out from former PATCH 2/2 on Boris request - thanks

 drivers/mtd/nand/raw/ams-delta.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 5ba180a291eb..46193db6d368 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -75,7 +75,7 @@ static const struct mtd_partition partition_info[] = {
 
 static void ams_delta_io_write(struct ams_delta_nand *priv, u_char byte)
 {
-	writew(byte, priv->nand_chip.legacy.IO_ADDR_W);
+	writew(byte, priv->io_base + OMAP_MPUIO_OUTPUT);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
@@ -87,7 +87,7 @@ static u_char ams_delta_io_read(struct ams_delta_nand *priv)
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	res = readw(priv->nand_chip.legacy.IO_ADDR_R);
+	res = readw(priv->io_base + OMAP_MPUIO_INPUT_LATCH);
 	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
@@ -211,8 +211,6 @@ static int ams_delta_init(struct platform_device *pdev)
 	nand_set_controller_data(this, priv);
 
 	/* Set address of NAND IO lines */
-	this->legacy.IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
-	this->legacy.IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
 	this->legacy.read_byte = ams_delta_read_byte;
 	this->legacy.write_buf = ams_delta_write_buf;
 	this->legacy.read_buf = ams_delta_read_buf;
-- 
2.16.4

