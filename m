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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31FDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAD0214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb+6rc72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAD0214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbeKVB3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42188 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbeKVB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so5101519edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PBex8woGQungQQ8B1o/PKC1WPxNLYtAwp4faI4sz6M=;
        b=Sb+6rc72d1vfZrK4tzNPm3vF+cgDkp53fKsrASvMten2GlXVT5x6jH1PN4y/XphF2G
         DIUsQPwzI8ORALthWZR4CyuEcg0FTBnswH2StPrMw82ZWWVMaj2seBjn6YdMu5tzXBmw
         ri0+IvWpqnc+pX8iiU+75KoQ+NQYfhrDbUNQOrBrXsMCfUz7rjXAyIhNb6uBNQwKgsqk
         HeckMCsp5h/EKEIGYaFlnoiaaX5Zazkj9IH/R6ixMP7xqzBmZbiVQ8AlsS+cSg7tYaz0
         q14g0Ro5fyk/gVMLiuKbYl4O7xEk6zjv8OqeP+J3gGPXivPN7tDBVcVWvC+d3zeBE+sO
         eBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PBex8woGQungQQ8B1o/PKC1WPxNLYtAwp4faI4sz6M=;
        b=ndnTCbOMxM+fU6vWPEr5J00wucWM+lkvBEIsY1Xz0MYgOSqEXmZDpJwTifehrj/sbe
         Titgd0qF24uCb8gGfp8ZCGJG856yxqSWjNsH6umDWEVnxNjaXkYOzW65uAxs3JV+vDoa
         imzNhB07mb0ltgG4QqPxb9uODyb9X6GkGIdQ4LyqWKtsuq0gnoqY/oZIPK/9tbh9Xdve
         /U8ufcQa/Axe8eqEUTBQLGwOTp0G0dnHprmGp6juc1pZiEo0+fKwdu5eFZTed0G8hmh5
         E6DNGyyHvM4f6p9lN2v2QdWduk8c13dBjEgaUxoX+GHNd7lQh8C3KMJHv3fJjGTx1EYU
         LtwQ==
X-Gm-Message-State: AA+aEWamkrsuJNJP0ezsV1bdFDuIPQp9Gqe1E1iVIyVxei8xvGZH5YwY
        qP/1l+lgmgT540WCWUESjlY=
X-Google-Smtp-Source: AFSGD/VDe3L0hJipQccmYR7IbxHdHLEmWTVCM0Gx+84iTZ6VvIJaRaKPZuSrRoa6inDI6/eHSpqrSQ==
X-Received: by 2002:a05:6402:1347:: with SMTP id y7mr6042678edw.114.1542812087438;
        Wed, 21 Nov 2018 06:54:47 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id f19-v6sm3832060eje.28.2018.11.21.06.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:46 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] mailbox: xgene-slimpro: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:21 +0100
Message-Id: <20181121145429.7582-12-thierry.reding@gmail.com>
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

