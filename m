Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD7EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1D6217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3L2oyLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbeLTRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:21:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33200 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387868AbeLTRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so2420464eds.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PBex8woGQungQQ8B1o/PKC1WPxNLYtAwp4faI4sz6M=;
        b=D3L2oyLzSwAWv8lcSu7PZE8IUgnW+351Lbt41lMp3dl9MqJPlQggfJsCroIilSMtEQ
         uB27WWsSYEeLrRaeeYk7ce2HeCboGTDqif0YB5edCCnN6DSRSLmGMj1iYeMDILLCTwiG
         N9IuzOf74ICAF3L/bCf7P6xLvvQSI7A18Ez/qsXmwm+RvIi6Y7+/E+No1GH6Ur4VCo2X
         GoZdOnCPDE/5QZ6jpKUBLDSdCmoh64GA3Wvl49O0vZsWh2OTk4UILqLxXDGvyfbvazKe
         t9LAM6GO4gHGhlHl+EuE+ikS7XSCj+8GySU0blgZVBYuLiH9ntOFUtP2lVOlj5AzCleo
         PUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PBex8woGQungQQ8B1o/PKC1WPxNLYtAwp4faI4sz6M=;
        b=ShNTtfzM6tRfe+5k03QHAdhWj+35E329RPGM2g2kGRGyc5ZTHDtIOwFAFWG3wP75BW
         dibjpSY42D5W4ML/gM1gawW3BxTPxTksxfjeQx5hQqVgKm4Lp6oh4bXcMZfAt6y3j0Dj
         I7J5ARX/DODcBijkSkr1AOjZFTnqRGX1p2tO66qhCW3X+Ty3yWmejHI/Ihp08sHpkS9w
         OZ5OTglm+XF82kPSxTDTpxvOfVKZKk8EXAafYqI8jCBGU64f1l2+UqrcjPx2NLrOxZ4o
         ugi1b+gVHbkY2bzbTbSM77ZmLHkAkw9c4Fl4CdfVE0sWOrOvszO8izc7b1x1Br4UTrRp
         0ncQ==
X-Gm-Message-State: AA+aEWZAXCc37iwOQzX/kB9jwngLr+38HLDdMvzC6cCoxz5yQg+5OlRK
        +ciV27Huk4qmnuWq3pkxpb4=
X-Google-Smtp-Source: AFSGD/V9Nv2rf6SMW1M4WQ4n2iuf0tajYfj2ZopLYo7bfOvW81NrrYfRg00FsC24eYwU12ywIo2b/A==
X-Received: by 2002:a17:906:35d9:: with SMTP id p25-v6mr20602004ejb.40.1545326421748;
        Thu, 20 Dec 2018 09:20:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id n29sm6210608edd.40.2018.12.20.09.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:21 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/19] mailbox: xgene-slimpro: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:54 +0100
Message-Id: <20181220172002.9016-12-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220172002.9016-1-thierry.reding@gmail.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
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
 drivers/mailbox/mailbox-xgene-slimpro.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mailbox/mailbox-xgene-slimpro.c b/drivers/mailbox/mailbox-xgene-slimpro.c
index b8b2b3533f46..8f397da1150b 100644
--- a/drivers/mailbox/mailbox-xgene-slimpro.c
+++ b/drivers/mailbox/mailbox-xgene-slimpro.c
@@ -224,7 +224,7 @@ static int slimpro_mbox_probe(struct platform_device *pdev)
 	ctx->mb_ctrl.ops = &slimpro_mbox_ops;
 	ctx->mb_ctrl.num_chans = i;
 
-	rc = mbox_controller_register(&ctx->mb_ctrl);
+	rc = devm_mbox_controller_register(&pdev->dev, &ctx->mb_ctrl);
 	if (rc) {
 		dev_err(&pdev->dev,
 			"APM X-Gene SLIMpro MailBox register failed:%d\n", rc);
@@ -235,14 +235,6 @@ static int slimpro_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int slimpro_mbox_remove(struct platform_device *pdev)
-{
-	struct slimpro_mbox *smb = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(&smb->mb_ctrl);
-	return 0;
-}
-
 static const struct of_device_id slimpro_of_match[] = {
 	{.compatible = "apm,xgene-slimpro-mbox" },
 	{ },
@@ -259,7 +251,6 @@ MODULE_DEVICE_TABLE(acpi, slimpro_acpi_ids);
 
 static struct platform_driver slimpro_mbox_driver = {
 	.probe	= slimpro_mbox_probe,
-	.remove = slimpro_mbox_remove,
 	.driver	= {
 		.name = "xgene-slimpro-mbox",
 		.of_match_table = of_match_ptr(slimpro_of_match),
-- 
2.19.1

