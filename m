Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6F0C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D0A208A4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="XBNWf9LX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="XBNWf9LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D0A208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933059AbeGHLai (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:30:38 -0400
Received: from fallback20.mail.ru ([185.5.136.252]:51698 "EHLO
        fallback20.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932839AbeGHLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=1GtLc9LIypSE57FGr9NCZ1HMHdzucjVgWBGRNkCD/zE=;
        b=XBNWf9LXVE3tO3PGw/ZU/OqXt+wYWVFse3zwO/EdrZJYvRcu6ioa+Og5A1IgXTmt9dczK8fpOVAxW+YXOhN2rZbk7LW6406IragYd1u8w82PM5eBTf8f59adFKfRrWZnkMKDX1jSBi3zE+oEIPkkhXvP8QieY6YPsUSvFFng0FE=;
Received: from [10.161.64.55] (port=33446 helo=smtp47.i.mail.ru)
        by fallback20.m.smailru.net with esmtp (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1fc7tV-00084S-1g
        for linux-kernel@vger.kernel.org; Sun, 08 Jul 2018 14:30:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=1GtLc9LIypSE57FGr9NCZ1HMHdzucjVgWBGRNkCD/zE=;
        b=XBNWf9LXVE3tO3PGw/ZU/OqXt+wYWVFse3zwO/EdrZJYvRcu6ioa+Og5A1IgXTmt9dczK8fpOVAxW+YXOhN2rZbk7LW6406IragYd1u8w82PM5eBTf8f59adFKfRrWZnkMKDX1jSBi3zE+oEIPkkhXvP8QieY6YPsUSvFFng0FE=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1fc7tD-0006m8-0l; Sun, 08 Jul 2018 14:30:03 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sergey Larin <cerg2010cerg2010@mail.ru>
Subject: [PATCH 2/2] mtd: rawnand: docg4: specify bits_per_cell
Date:   Sun,  8 Jul 2018 14:29:24 +0300
Message-Id: <48cec9b431a42375cd9033b225f3573002574f17.1531045014.git.cerg2010cerg2010@mail.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
References: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
X-7FA49CB5: 0D63561A33F958A554D453D5DD83F5CF58CA4CFEA04898E7D9EFDDE8C26AAA4F0A6AB1C7CE11FEE36925688D23FC3BD3BA3038C0950A5D36B5C8C57E37DE458B4C7702A67D5C33162DBA43225CD8A89FBFBFE0634520CEB9DBDD88700051DECD5DEFFFEC831EE3A743847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148F3F936871CC6C13B42623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 77CB7D53813D46933669B4271CC84AE01731BF08933530B12FF99E8B2EA5F8D8B7CBEF92542CD7C8D694F0A6A4F3F64130860A92898D06F0CCD8808EE49729257A5E07228308AC44B7D4B47F40347D15B4A721A3011E896F
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5F820787F1C858A4F0926D2AF02552A6E972C79495CAA6155462275124DF8B9C938130EB80001CEACE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C9005EB82917A46D95276974DB752BF41E6BB83D58C3F4BF15D519BBFB9D4C9B76856CAD91EC71FC00F3837D2A27E1A8065646C7A2150F6097340301919DCEDD5454186FA049C4F996C4B5FEEDEB644C299C0ED14614B50AE0675
X-Mras: OK
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes WARN() in nand_is_slc().

DoC G4 is 2-bit MLC, so set bits_per_cell value according to this.

Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
---
 drivers/mtd/nand/raw/docg4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index bbed8ea7858c..82d97a16e246 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1250,6 +1250,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	nand->pagemask = 0x3ffff;
 	nand->badblockpos = NAND_LARGE_BADBLOCK_POS;
 	nand->badblockbits = 8;
+	nand->bits_per_cell = 2;
 	nand->ecc.mode = NAND_ECC_HW_SYNDROME;
 	nand->ecc.size = DOCG4_PAGE_SIZE;
 	nand->ecc.prepad = 8;
-- 
2.18.0

