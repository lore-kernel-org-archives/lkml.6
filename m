Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ECD206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD0rHn+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfAPTvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:51:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51591 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfAPTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:51:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so3362612wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k64bXiDLD8y4J+sFwU9ZB1mbo+fWhQ/eojU0UDFVhoY=;
        b=LD0rHn+d7FbWTKXzvEf0NJGCt7Gbp+8z9MzKGnkBQJL7a8RUi4qwMMD7G6+khEJFsF
         DQdd3Tmd0+mdnHlfmV+srrnkMFx3Bv1GXFcLOEQuB2ix6xNefFljcTlacyU+ow+bHfSu
         4sS54kFKvxEIcG09NaCiGclzbGTLkas7kcBH+JpIhz7so7kgjpkroFF20PZy+fYTnBPs
         qs/xnbv8mvDTBajJ9IK5odp6M4Dt0+Bq5BViH9IijH3zA3rGd88iho2hTBl30J3Jone9
         bQwX1eShY6728bPKIRvusjGIHw/57S+1mH1eFLLIyj7xncG8dlZb3Bh+Yvf3uL+0pzsw
         ZPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=k64bXiDLD8y4J+sFwU9ZB1mbo+fWhQ/eojU0UDFVhoY=;
        b=lJvMG2cSeECVUe+NKjIkktd46GPcl043tb3dUUvf4PjG5hC4E4wJ9jMG5Q2eOlv90H
         rJ1rhKQKNes+K0MqG2lnK8b4lscTGTzwfvFOgh1M87w0NTbHMlffY1c+N41AQkdfi+gX
         VlQBGrpvdHklqvuqBW3NdSopBKGGNMNtUzf8QxEN4O6vZOxKCbE3Jd8RjEAqgcJWkI97
         vgSuioxuSXwLCrBdVsbUt34D0kSX87Ll2kTxNAhEZoeRdj7CEQqc0wyXe3FVp6nkIQj/
         ueUOuFEaEnaz0sA5FJJ1Q6q0s2Soyht0aWClktqz430dSDUEmh9yEwOInohopMLA9bJs
         EOnQ==
X-Gm-Message-State: AJcUukc57IkVaZsBhnblhkTt93c75Ch0xSb91C/fpgXlmQKv+frHfZ9Q
        p752mAs7zuZbJnlcggLRSAU=
X-Google-Smtp-Source: ALg8bN7uJ6s49Or0KMged3nfrwbJcS9UvXUEDSmdbmzD3EODccDL8h7Rcw21bjFEdtMGBkI8jCxkiQ==
X-Received: by 2002:a1c:1801:: with SMTP id 1mr9463749wmy.153.1547668281775;
        Wed, 16 Jan 2019 11:51:21 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id v6sm34245521wrd.88.2019.01.16.11.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:51:20 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 3CCBA11423A3; Wed, 16 Jan 2019 20:51:19 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: Annotate implicit fall through in nand_command/nand_command_lp
Date:   Wed, 16 Jan 2019 20:50:03 +0100
Message-Id: <20190116195004.2499-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1).

This commit removes the following warnings:

  drivers/mtd/nand/raw/nand_legacy.c:332:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/mtd/nand/raw/nand_legacy.c:483:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/mtd/nand/raw/nand_legacy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_legacy.c b/drivers/mtd/nand/raw/nand_legacy.c
index 43575943f13b..f2526ec616a6 100644
--- a/drivers/mtd/nand/raw/nand_legacy.c
+++ b/drivers/mtd/nand/raw/nand_legacy.c
@@ -331,6 +331,7 @@ static void nand_command(struct nand_chip *chip, unsigned int command,
 		 */
 		if (column == -1 && page_addr == -1)
 			return;
+		/* fall through */
 
 	default:
 		/*
@@ -483,7 +484,7 @@ static void nand_command_lp(struct nand_chip *chip, unsigned int command,
 		chip->legacy.cmd_ctrl(chip, NAND_CMD_NONE,
 				      NAND_NCE | NAND_CTRL_CHANGE);
 
-		/* This applies to read commands */
+		/* fall through - This applies to read commands */
 	default:
 		/*
 		 * If we don't have access to the busy pin, we apply the given
-- 
2.19.2

