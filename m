Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10BAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7142A20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="tvRY6IsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7142A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756096AbeFSFbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:31:46 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46072 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755731AbeFSFbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:31:44 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BE65A8448A;
        Tue, 19 Jun 2018 17:31:43 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529386303;
        bh=AswHptxgiHG9Mkapmc8BLlORyrqKg486FqCaxfkkF+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tvRY6IsMKtQDrS3/QKDiyAIf5QZx57RlAr96PgiKdHoVJOVqd8wlE3Y2axXrAwuaq
         DT04I8QkUXxV8caz8eHGEOYCTs0yhSktc83ZTDg90eHJuBzqrR3x/cyfcS9dZsFejx
         QBL/Jpb3GdY5QgANIi7b/ThnMP7tVAZEneQPco1k=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2895400000>; Tue, 19 Jun 2018 17:31:44 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id A661B13EEAD;
        Tue, 19 Jun 2018 17:31:46 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8CB041E2626; Tue, 19 Jun 2018 17:31:43 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [RFC PATCH v2 5/6] mtd: rawnand: micron: add ONFI_FEATURE_ON_DIE_ECC to supported features
Date:   Tue, 19 Jun 2018 17:31:24 +1200
Message-Id: <20180619053125.16792-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ONFI_FEATURE_ON_DIE_ECC to the set/get features list for Micron
NAND flash.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- New

 drivers/mtd/nand/raw/nand_micron.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index e582c9e61715..d1e8f57544a0 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -66,7 +66,9 @@ static int micron_nand_onfi_init(struct nand_chip *chip)
 
 	if (p->supports_set_get_features) {
 		set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->set_feature_list);
+		set_bit(ONFI_FEATURE_ON_DIE_ECC, p->set_feature_list);
 		set_bit(ONFI_FEATURE_ADDR_READ_RETRY, p->get_feature_list);
+		set_bit(ONFI_FEATURE_ON_DIE_ECC, p->get_feature_list);
 	}
 
 	return 0;
-- 
2.17.1

