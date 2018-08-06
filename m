Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A622FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C07219F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="kQ201zWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C07219F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeHFLhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:37:32 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53124 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeHFLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:37:31 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id BCC3F5C002F;
        Mon,  6 Aug 2018 11:29:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533547755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=wMfTePY/Fk667oGzC7LwWYq7SGr5L3zaN5lpSBjgzZo=;
        b=kQ201zWTfqqNB/ZJ2MJFeosKPlSkniF/RPETv3+2NzUanXCAJrN9ipl5kzDEIkXuYr4Yq9
        anT8deE80ho3BAzasbDn1KHiPwhmgpCjWU+eaifpCaoQwHCo9cDGOI/i/ki2yq2Vrw3EaZ
        Os2PL+kewC0b7CYW7J3X2F/bPv+wnbc=
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com
Cc:     computersforpeace@gmail.com, dwmw2@infradead.org,
        marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] mtd: rawnand: vf610_nfc: align IRQ bit naming
Date:   Mon,  6 Aug 2018 11:29:07 +0200
Message-Id: <20180806092909.28980-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the IRQ DONE clear bit to align with other IRQ bits.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mtd/nand/raw/vf610_nfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index d5a22fc96878..740a91c5c86e 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -132,7 +132,7 @@
 /* NFC_IRQ_STATUS Field */
 #define IDLE_IRQ_BIT				BIT(29)
 #define IDLE_EN_BIT				BIT(20)
-#define CMD_DONE_CLEAR_BIT			BIT(18)
+#define DONE_CLEAR_BIT				BIT(18)
 #define IDLE_CLEAR_BIT				BIT(17)
 
 /*
@@ -290,7 +290,7 @@ static inline void vf610_nfc_clear_status(struct vf610_nfc *nfc)
 {
 	u32 tmp = vf610_nfc_read(nfc, NFC_IRQ_STATUS);
 
-	tmp |= CMD_DONE_CLEAR_BIT | IDLE_CLEAR_BIT;
+	tmp |= DONE_CLEAR_BIT | IDLE_CLEAR_BIT;
 	vf610_nfc_write(nfc, NFC_IRQ_STATUS, tmp);
 }
 
-- 
2.18.0

