Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BEF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5BvTevY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbeLQPCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40173 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbeLQPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so4959501edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNOq9HM7IIA51VZQh4SQRXR3S46Yykx0FsGqyc+V3QU=;
        b=h5BvTevYoOZbW3Ut3IghJbr0Co/IHjoVjEEFXpuYgLNmXu0H3vWB0k8v2Lj5idCEz/
         b5DWZfmYKeezDwNDQEQZf8qQ2ChLKhbSTO2KXsibbhHqYG/Aqs/vkayFd0vtQRe3itue
         8DgweHT9/VNwwrr1F+V/WbvwmE9UTDcqZdSxnnrXoXcjIts8s3TVYHIHdETCwbX1fAAY
         56RGGl1NIw2yHDzeDA04+bnMMJmPM2VlyCH0qPYECBZqPj2+bD8bFK0kcAp3muTbT8EP
         UUoHUW0AXcbLrIJlGXrhORYjfjuUwpL4T59jOJ9ixi1IhHST28anh3VbBvjvjuOmK4NF
         I0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNOq9HM7IIA51VZQh4SQRXR3S46Yykx0FsGqyc+V3QU=;
        b=sPP0m/HiCe01D1Hl+MHrT0mDREe61+ZhylvIWCdXb/aMTUR/silVpZNW7Ru6IM3vVw
         vo4IDlHRHhkLX2oxllzXZZFvGGPYtTQD48sWMhU4rLi8y+FUtJTjDL5Xe97qlmrubwyi
         Hhf6GEn9IVd5WiR505zGF5a+leY485Lq8xt591iAADf5jd8n2ug2cN54gdeZ8vkZI6sG
         wstfsXYkHLobxr9KGN3Npv1iZ/UZIXlAEiu+MTP6jHdpilV6zpNuBgh7dgWGtwaoe0x/
         csFBGrY1J4bTBWlohiWKd1TXhfFFQ6X2Pip2W7MCciJIkZ440LeYwyzFwoJywStkydH7
         LLxw==
X-Gm-Message-State: AA+aEWZyuOBg/1kbzVWkqxNFmno2JgzV+aeaYT/6vuLdSqPYhITTC8wb
        /cJoUO4Rjt6K5/BHujKIzck=
X-Google-Smtp-Source: AFSGD/Xdqblkwm0rW6JB2qzjHUR5oJJBZxMEU6YgxyHnO4ZlVeKaSNTfVjJ7//KvjKzC/3yEWCpr4A==
X-Received: by 2002:a17:906:6c14:: with SMTP id j20-v6mr10539288ejr.41.1545058964806;
        Mon, 17 Dec 2018 07:02:44 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t18-v6sm1915911ejz.9.2018.12.17.07.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:43 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v2 09/19] mailbox: altera: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:07 +0100
Message-Id: <20181217150217.32435-10-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217150217.32435-1-thierry.reding@gmail.com>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mailbox-altera.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-altera.c
index bcb29df9549e..397e25ddae29 100644
--- a/drivers/mailbox/mailbox-altera.c
+++ b/drivers/mailbox/mailbox-altera.c
@@ -341,7 +341,7 @@ static int altera_mbox_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = mbox_controller_register(&mbox->controller);
+	ret = devm_mbox_controller_register(&pdev->dev, &mbox->controller);
 	if (ret) {
 		dev_err(&pdev->dev, "Register mailbox failed\n");
 		goto err;
@@ -352,18 +352,6 @@ static int altera_mbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int altera_mbox_remove(struct platform_device *pdev)
-{
-	struct altera_mbox *mbox = platform_get_drvdata(pdev);
-
-	if (!mbox)
-		return -EINVAL;
-
-	mbox_controller_unregister(&mbox->controller);
-
-	return 0;
-}
-
 static const struct of_device_id altera_mbox_match[] = {
 	{ .compatible = "altr,mailbox-1.0" },
 	{ /* Sentinel */ }
@@ -373,7 +361,6 @@ MODULE_DEVICE_TABLE(of, altera_mbox_match);
 
 static struct platform_driver altera_mbox_driver = {
 	.probe	= altera_mbox_probe,
-	.remove	= altera_mbox_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.of_match_table	= altera_mbox_match,
-- 
2.19.1

