Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CB02098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozCWG1g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CB02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeJDU2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:28:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35559 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeJDU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:28:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id y19-v6so8594240edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1IZGIS5kJEbSn8kTbLa5CjEl7KYJRjfT/qvBhZlRFU=;
        b=ozCWG1g/hj0EyqLiSk+t7H4MVz8VzOHsfC0JB+AsLwdmhZEhayjjO6H4mgkhIq6oi8
         MICJJF2OS87TI9TtFW1g4m2IsXxF2NZhNE5eS5ZHmaz33B6TdH5UZj2GoOlNAWJ2fbmA
         2e356x7zeBwjusXYiW6sHIYPg+miFg1x46t5KuWpu2+CsXQzVPhjwJd06MVZw++wffnX
         9EkpukcuRGCeThLn1qIoigBC4xtx5kQi7/3sG1O/XhD5Wrt1gaTtpX8IyGCed408D2MX
         +TghTmsabvbwzx9Wtf6zxM7jDwQ8VGAJQgzS11bkiYcbIDPhKwBhc60unn+tZ3FDB1Rn
         4YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N1IZGIS5kJEbSn8kTbLa5CjEl7KYJRjfT/qvBhZlRFU=;
        b=t/vieAjKNgyD8LKNcUS1Ubv8fxNI8APlD882NDtGz0SXZo6UsFVMClECPWNl8zKxNo
         YR0/KhjQgyd4DQebBvGZn/e2gzsTH8LqqqNOuZWu7Efh/+dSSRHy7KUpEkd6SjFlBLVn
         GXjr9YJNOk5UJUZsna3PhZHwGRQS/PKgcwWhY4SnaIgWoF+SvkhSIJgkFbzrmVQFLOP+
         +3kyZux49t1qPXfAfeEGjuwogQUkcVQu27FxX3G3+cFQwmemvcyMM9/kOezes/hfCWo2
         d9veZe46/kD0GoXTEpDPjqTpeFu0xJbijzB3BuOdVuF5ZV1dzMk8C16sZplyN4FYb/hg
         Zg7w==
X-Gm-Message-State: ABuFfojW7oIZ2l/eUOuZK4E/VO7s5KKT233zk7NKJja7mv9dRAYZTlNe
        hzDYIcM4VUryU/vSxG0qWD0=
X-Google-Smtp-Source: ACcGV61McXeQtwiKlVlg4suqkJsEIq0VsCBb+MirKgAIKrj5r6YV5HXIoMQW+sT2Pdf6/G2v1IWnQA==
X-Received: by 2002:a17:906:2a88:: with SMTP id l8-v6mr6688235eje.236.1538660088377;
        Thu, 04 Oct 2018 06:34:48 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id c15-v6sm1621042edm.21.2018.10.04.06.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:34:47 -0700 (PDT)
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
Date:   Thu,  4 Oct 2018 15:34:45 +0200
Message-Id: <20181004133445.20914-1-ricardo.ribalda@gmail.com>
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
index 4129535b8e46..ece605d78c21 100644
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
+		if (IS_ERR(info->list[i].map.virt)) {
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

