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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08274C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1EA2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1ihEl42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbeLQPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45456 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbeLQPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so10969973edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YepPy6as3jukggX9s7UBN1QkOSHdCi3CElLuLrebsDg=;
        b=K1ihEl42cHdNPn7uBM6gJn0FHaUlvipHmQ6tAAaoFYwMkURpm1SUAcO1a7LipoiHId
         NfTTVC2JfHJ7Q8riKkQj1h8JMWVlBew2KaULTQfO+XhsxSP2x4PNOUjO44arzyDf42q3
         iCGBnQ5cMYKu3ldKGwMUWVh6kU/FGzb55mZScxI1oRnIPusj9ZwT+HQl6hbTrBMzXAS6
         BdMrIwdvilb27Up35bKzavvUM+1gVj/rnX9tTshuIoRXEG6mn3qp7CfhXOSn/7WgsbLe
         hLFdXTcZ58nncKW9oSjyKdjesdWNpeIFLEyejJL/+5IA3fGTzr8m0zefh9TC3EdpK34f
         38wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YepPy6as3jukggX9s7UBN1QkOSHdCi3CElLuLrebsDg=;
        b=dgpJ6UZvsGvKN6Us+MRjZt4T9+dscA10Pml2NDjpxceFOZLX3C84wwJ+mw6O7TpxKk
         37oLauQY8sBsfTDT1aqN97dgiEMMthb5gxm4UHUvfxSANJDgym79TXcneKYpwLjOR2Ya
         fTIlSU7m8xfnK5dK/nVbCWC62aw2bsr9u7X1GP6LLA1VTmkBG6SEoHYyoMaOYCN35BpT
         3b2lJhJ3JhxEJCVIXaJidw+zJAbJiAvgqqme1E6ZHBh0fkr4SQI9uwVq3QWhR0Rwj9Ad
         90dXD0VNX1oCkpQ10FSoRadEFepP72oKjDLSiK8zdBRbItHkbzQ37MGeBqgRgudDrSGy
         gx5w==
X-Gm-Message-State: AA+aEWZZ0a1jCfJ+4zW6pL8ED4fxZ2axhMj7v9507h6FTxwbwBDUK7wg
        qHH4STeG6y87CYPFh+OqOBXOp4Pl
X-Google-Smtp-Source: AFSGD/W60IrJB824hXsv5E9sVkFiXVbkGyoZOOGEB/u/4xr4YZXIIpuclIEBedgYumIK+HeHyB5CkQ==
X-Received: by 2002:a17:906:b1b:: with SMTP id u27-v6mr5948109ejg.67.1545058975612;
        Mon, 17 Dec 2018 07:02:55 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id k32sm3903843edb.42.2018.12.17.07.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:54 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Duc Dang <dhdang@apm.com>,
        Feng Kan <fkan@apm.com>
Subject: [PATCH v2 11/19] mailbox: xgene-slimpro: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:09 +0100
Message-Id: <20181217150217.32435-12-thierry.reding@gmail.com>
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

Cc: Duc Dang <dhdang@apm.com>
Cc: Feng Kan <fkan@apm.com>
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

