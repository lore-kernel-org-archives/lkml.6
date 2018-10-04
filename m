Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479E220877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs1dYuEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479E220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJDUZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:25:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40316 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDUZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:25:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id j62-v6so8563441edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=raX5qEj7fRXQ/iQULa01jf7rlvPVsAVNG0zX/XpZs5g=;
        b=Bs1dYuEw88RWdvlU/QKrnpxanvvHnNSDQFMCUNnhGfgzRk38FPRYfrPXesa9G65Oje
         fwRe9wYuwkFuMHMbDQVywWy0puErljO1BsdC14RW/NNTvwxWb8BfhHufi/Mu1zGHoLYQ
         XshtXDFHCNh6FQG9vZr3wBdxltd7ojT5Unb5R+5qLKhZgvqIsFpGjlwdYbC2Eum7HiIH
         8aXlt8Ar4pCksyzMcwMdxcBJw5zGPfWZuLsjLjKqhniXvfjB6uU2uOECG84l4wNSln0I
         lw/LGF0zTqdtpiC3FODvL+vXK4M03SA7WeNws9RfG/dbLQZ+f4+YXFBCEqvhAkU3mhjQ
         pOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=raX5qEj7fRXQ/iQULa01jf7rlvPVsAVNG0zX/XpZs5g=;
        b=E6tXi+524PA4+HMiQUu3zEZyo9smcPKCg4AycztOd046Oe9s5Xjbn3xvk79iz1T00Y
         b2dbPS2uuTF2tUz0xwOohFbA3FQVLunLUC+vKbFkW0znGxE3ylfd6omZiesdb+/OGtG+
         WsT/i2aTfAJxzpzRzVnwT8tGbi8UcThCt6Qove+4MDdxo6uFnO+wVe3X8GWO/0sS/Kp3
         kHjSeGMdb07amyERQrYOvpgEkJYfPvqJQf5zmdQ83fTAUBd6wkWg2ijgGZKU0Imjm2aZ
         OIcCOUO6YI/wA6NOmNKwdEXj9pyC77TrvAqeloloxOBqqz5rBvrR20W5FYkTBoNj1ira
         jNhA==
X-Gm-Message-State: ABuFfohwfo16nodF2PFDB9Kpt4IBjpv9I5KDHlM8EUzrZauvVc/+gT4Q
        ptg5qDsB/E8M+ALSuPHSAWc=
X-Google-Smtp-Source: ACcGV62M0y9IvVduVqMidTLJ3pwy/KabW35fThv4AnQreLY6qMvmNnSKU/FK3nSUQoaLDqFSS28euA==
X-Received: by 2002:a50:8a96:: with SMTP id j22-v6mr8461277edj.189.1538659910169;
        Thu, 04 Oct 2018 06:31:50 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id c24-v6sm1440569ede.73.2018.10.04.06.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:31:49 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v8 01/10] mtd: physmap_of: Release resources on error
Date:   Thu,  4 Oct 2018 15:31:46 +0200
Message-Id: <20181004133147.20215-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, if there was an error the memory region and the memory
map were not properly released.This can lead a system unusable if
deferred probe is in use.

Replace mem_request and map with devm_ioremap_resource

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/physmap_of_core.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of_core.c b/drivers/mtd/maps/physmap_of_core.c
index 4129535b8e46..ed75f1781c37 100644
--- a/drivers/mtd/maps/physmap_of_core.c
+++ b/drivers/mtd/maps/physmap_of_core.c
@@ -31,7 +31,6 @@
 struct of_flash_list {
 	struct mtd_info *mtd;
 	struct map_info map;
-	struct resource *res;
 };
 
 struct of_flash {
@@ -56,18 +55,10 @@ static int of_flash_remove(struct platform_device *dev)
 			mtd_concat_destroy(info->cmtd);
 	}
 
-	for (i = 0; i < info->list_size; i++) {
+	for (i = 0; i < info->list_size; i++)
 		if (info->list[i].mtd)
 			map_destroy(info->list[i].mtd);
 
-		if (info->list[i].map.virt)
-			iounmap(info->list[i].map.virt);
-
-		if (info->list[i].res) {
-			release_resource(info->list[i].res);
-			kfree(info->list[i].res);
-		}
-	}
 	return 0;
 }
 
@@ -215,10 +206,11 @@ static int of_flash_probe(struct platform_device *dev)
 
 		err = -EBUSY;
 		res_size = resource_size(&res);
-		info->list[i].res = request_mem_region(res.start, res_size,
-						       dev_name(&dev->dev));
-		if (!info->list[i].res)
+		info->list[i].map.virt = devm_ioremap_resource(&dev->dev, &res);
+		if (IS_ERR(info->list[i].map.virt)){
+			err = PTR_ERR(info->list[i].map.virt);
 			goto err_out;
+		}
 
 		err = -ENXIO;
 		width = of_get_property(dp, "bank-width", NULL);
@@ -246,15 +238,6 @@ static int of_flash_probe(struct platform_device *dev)
 		if (err)
 			goto err_out;
 
-		err = -ENOMEM;
-		info->list[i].map.virt = ioremap(info->list[i].map.phys,
-						 info->list[i].map.size);
-		if (!info->list[i].map.virt) {
-			dev_err(&dev->dev, "Failed to ioremap() flash"
-				" region\n");
-			goto err_out;
-		}
-
 		simple_map_init(&info->list[i].map);
 
 		/*
-- 
2.19.0

