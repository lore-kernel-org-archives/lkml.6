Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86C9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4E52151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0ulGM8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4E52151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeKVB3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43541 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731231AbeKVB3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:30 -0500
Received: by mail-ed1-f68.google.com with SMTP id f4so5095858edq.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwU08G+VkQHQpvrVUWFcEHI2wbKrBDSdfvI/Gd4xUg8=;
        b=o0ulGM8RBxC2FT4Hnn0LLLBw9T+KNPzbA3t6TATR3dUhGsHeWSZOPBlvzFx1Q2uwOy
         5l6nV3gbrOEEO+4VwwbDmYKpfO4QE6OLKpBNEU7Xi/+g6aYdgRhJfnBrRWRBLalmTL/i
         xGWibYV2suem+ZMAENI0D9CVRE7d9eJ/J1tj3Omf0MeBJuEJfHBL7NIFLqkpPIyw5TP9
         NUW9FnHEwa+7JRF+Qa9Fkoh3V6U3emLiS8H3RK1uz/YbdaRuIsaor/E39GcdfH7htSIN
         JeN6tTMiN82R/4Se/zShouGISvshONrwoBertecuWYBc9fzbU2J+hQt0SBR+oEXV/KwC
         qdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwU08G+VkQHQpvrVUWFcEHI2wbKrBDSdfvI/Gd4xUg8=;
        b=LOsN4+mZGMCUAC8ks7m7f0wtWXW8Tir0NrlvmA8oLgr4gGvcotf6OybBCQwq1cq3L3
         2wF41ZYZKGX9DsaayazOTaJhJMVPC3Hv4hNIuDdWX44zLTBuXSTK3oMY8hjuQD0vp8bS
         wFpX3ki1CTqPfRzyEw2bgzSXxDCwxdz7+D2BmgBQxP53odD/sS2DQrHWz4FnX+0oyuGB
         gy/cJehfPFmuClqVUn5z5uHeOpp349NMjoyjAXQxNfyQ794NyFzArPYKGRaJjXQZ6KaA
         n+GvTW111bQm5w+H5a6jpx85CJAiDKLjNtbJUE/07jKPgf+mgXh0/oQ+UQty4fEe3uOn
         f4jw==
X-Gm-Message-State: AGRZ1gJ1rVls39MvjmM/KEMesrpPCEWbyy1LkIyulXQ3FbAxsfC0DLpR
        dySw503zgGd0H8q1B/KHHUo=
X-Google-Smtp-Source: AJdET5d0aXkLgwHGaY4gA7QOH2iLcL8CTf6+1vA57EqEMqAuZ1GtVKg/jMeko8dVjH3yciXBTtwJIQ==
X-Received: by 2002:a17:906:4e14:: with SMTP id z20-v6mr5124055eju.187.1542812084507;
        Wed, 21 Nov 2018 06:54:44 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id j31sm10144887eda.46.2018.11.21.06.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:43 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] mailbox: altera: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:19 +0100
Message-Id: <20181121145429.7582-10-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121145429.7582-1-thierry.reding@gmail.com>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

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

