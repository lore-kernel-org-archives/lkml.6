Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C02DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE5B2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="M4k0TZjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfBLHOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:14:43 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37564 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfBLHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:14:36 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1C7DPdV019269;
        Tue, 12 Feb 2019 16:13:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1C7DPdV019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549955612;
        bh=Cxo+nXTM0mDOF2OjW40lPL0MRI8BxhjckTRFkxa+L8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4k0TZjPOGPdeO/Yk6e3L38TJi6a9WG84ecuAVW3uGmjmCk2GEZpj1sqsXQCpokb+
         yg0RHjtXos4agwU0AbO91MTpdgMc65ml0f8y3h5TRZ7Nv/KwLukmCYVTsXIvEfw2aB
         Kvz8gzZfjnWsWtHdwhSX/MIN49ADGBdZ5xFh2PBTAlV5HhtUO72DZh3R+jXHu7iUFs
         e9YJ3r+Z1e29c02v3M9F8OrO76d5He7AuDuQDdvx5qIcV9dztkS56g49O1EFwJPiQ3
         ygQvl/zPGYlOqjuR7yY/uQbtjASGv6ZNbdEH7FGz3AIaLCyIXTYrM6r5oMkasi7hs8
         aoPyjE3mQxk6w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 07/10] mtd: rawnand: denali_pci: rename goto labels
Date:   Tue, 12 Feb 2019 16:12:59 +0900
Message-Id: <1549955582-30346-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Documentation/process/coding-style.rst says, choose label names
which say what the goto does. The out_<action> label style is already
used in denali_dt.c. Rename likewise for denali_pci.c

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mtd/nand/raw/denali_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
index 48e9ac5..02eb599 100644
--- a/drivers/mtd/nand/raw/denali_pci.c
+++ b/drivers/mtd/nand/raw/denali_pci.c
@@ -84,20 +84,20 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!denali->host) {
 		dev_err(&dev->dev, "Spectra: ioremap_nocache failed!");
 		ret = -ENOMEM;
-		goto failed_remap_reg;
+		goto out_unmap_reg;
 	}
 
 	ret = denali_init(denali);
 	if (ret)
-		goto failed_remap_mem;
+		goto out_unmap_host;
 
 	pci_set_drvdata(dev, denali);
 
 	return 0;
 
-failed_remap_mem:
+out_unmap_host:
 	iounmap(denali->host);
-failed_remap_reg:
+out_unmap_reg:
 	iounmap(denali->reg);
 	return ret;
 }
-- 
2.7.4

