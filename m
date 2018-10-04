Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F481C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347902098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZlKOwwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347902098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeJDTyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:54:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37760 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJDTyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id 63-v6so8296530ljs.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvOv02cS/5OY9CZqapWCURdGssdE7v3kGqWHFy7Kk5o=;
        b=KZlKOwwRo46FGX9QRU+hK+LGur1TFD1Z+EQhgdREcLXDqvlDXAZFne2y1oHKsfO35R
         XIq7vmcKyzTkfzJqzLd9Yj9brPOFIs4oZyQdAtWwK0L+ZE/yuKx5Ix1HNyDucuCUTGba
         SMXZmWbMOFXtcn+QfXFDlOlW1lvTSCw6idDkY2XsBoDiXKSk8LTZ7rgE0WXDuxRgWgFI
         nHVRWBwX52Drh7/I6Jy/22ZbMaeKWih2gzqpFqdxe37LH4xF6OOZy7bi3LRBe7pIAJmC
         CmW1nGTfVcz3kH0o6j9xnXSvq+B0I6tTvWnZ2Z8xyfBsJKFfKBVr3N5JT3naFVwBcbd4
         iLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvOv02cS/5OY9CZqapWCURdGssdE7v3kGqWHFy7Kk5o=;
        b=KrjUBhLHq0jDJR9kwskJciwiCNBIu04F6HT1l4MqsDpKUu6t1vzKajREH2jlfmtiuf
         wT47qP1leU9GiQ/MjHMZ6fihJeo/YrbqCZkt8ST1aRaoS7BL/EazrCyLX7JGeiaqxc91
         L3+3uWpAbt87GQRefBluvqdWAjVEZwyeezr69be8Dw+5liSAVIIusOsysP/Xq9DjB1Ym
         pWwWrSvy03ce2V6tkbs2wmUyLQ4u344/sSB5ebsSU1bjefPLH+REr+7vcV4m1xhmx1rx
         0zJQ8twPG/zSBhjNKsgPrAT5mz2wtrDMHvfzpse6cEHv+565vDAJ9ZMDB3v+HXzTLKw1
         Bk4Q==
X-Gm-Message-State: ABuFfogrYPE6LB5hHhQrsbLKl9sBqXyTZ+zWpIp20AMxxD7TTETWAvRN
        27x3QAqUb0zj1E5BekCCm4Q=
X-Google-Smtp-Source: ACcGV61tPqzvUEnswTuaKqF+ARYJftjZcVL60D0v6XrgpPtgEpRxakaXp7CPRc0XoOIFfyUa+DFtNA==
X-Received: by 2002:a2e:3006:: with SMTP id w6-v6mr1462771ljw.146.1538658083264;
        Thu, 04 Oct 2018 06:01:23 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:22 -0700 (PDT)
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
Subject: [PATCH v6 01/10] mtd: physmap_of: Release resources on error
Date:   Thu,  4 Oct 2018 15:01:01 +0200
Message-Id: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, if there was an error the memory region and the memory
map were not properly released.

This can lead a system unusable if deferred probe is in use.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/physmap_of_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of_core.c b/drivers/mtd/maps/physmap_of_core.c
index 4129535b8e46..062add8b3a6e 100644
--- a/drivers/mtd/maps/physmap_of_core.c
+++ b/drivers/mtd/maps/physmap_of_core.c
@@ -241,10 +241,10 @@ static int of_flash_probe(struct platform_device *dev)
 
 		err = of_flash_probe_gemini(dev, dp, &info->list[i].map);
 		if (err)
-			goto err_out;
+			goto err_out_release;
 		err = of_flash_probe_versatile(dev, dp, &info->list[i].map);
 		if (err)
-			goto err_out;
+			goto err_out_release;
 
 		err = -ENOMEM;
 		info->list[i].map.virt = ioremap(info->list[i].map.phys,
@@ -252,7 +252,7 @@ static int of_flash_probe(struct platform_device *dev)
 		if (!info->list[i].map.virt) {
 			dev_err(&dev->dev, "Failed to ioremap() flash"
 				" region\n");
-			goto err_out;
+			goto err_out_release;
 		}
 
 		simple_map_init(&info->list[i].map);
@@ -290,7 +290,7 @@ static int of_flash_probe(struct platform_device *dev)
 		err = -ENXIO;
 		if (!info->list[i].mtd) {
 			dev_err(&dev->dev, "do_map_probe() failed\n");
-			goto err_out;
+			goto err_out_iounmap;
 		} else {
 			info->list_size++;
 		}
@@ -329,6 +329,10 @@ static int of_flash_probe(struct platform_device *dev)
 
 	return 0;
 
+err_out_iounmap:
+	iounmap(info->list[i].map.virt);
+err_out_release:
+	release_mem_region(res.start, resource_size(&res));
 err_out:
 	kfree(mtd_list);
 err_flash_remove:
-- 
2.19.0

