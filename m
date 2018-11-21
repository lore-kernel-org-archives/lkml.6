Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2559C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE59214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99sXVbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE59214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbeKVB33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36708 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731201AbeKVB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so5128549edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSsL9D+x6TaWXVYwK88TTfq4um3Zmd9V8x+AG+xansI=;
        b=l99sXVbpWyqLdecGWkusQEZeJmqN6JMufE+OTzxeMzOwIcMqDBj3aIWYEsH4kbVfDT
         gWnAbMTxiAmKxlIzlqbPV7cdi8XPMjwaZE20ShArzU393IrjcuVEP+0NkXG6C55TI0JA
         4qGo2oXKU/Fi8OhNPp8GC7nriypyupNUqVzHSphnWZQOlc6lo2p1nV6C+3qfSDlj07YM
         8STviK1eIdRte+Wa2pfgABlbLX831lETrVCDSgjCYCVbrYxNTOtrIl3yLSlhAMjsUapw
         0aGVPRbAxCU94lM6JAVVAuZG6SVbu9iUvF6Saj2SBg/cuw5x1GE5jZhJuvB4xRfe2F4Z
         fSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSsL9D+x6TaWXVYwK88TTfq4um3Zmd9V8x+AG+xansI=;
        b=UuakG1/V+EC+uhj7LbDKyqqeGGCArg5LqmhzMtcjc8y73SO90umrUTUqLcXplv+0DD
         oQI4FfCz44UmNibgE9GTXDuLxWAqxIMZbmjxhShEPmSrjwjuAwL33hoBO3KLFE9rR3cx
         9ePkvxm8xjs5p9g73vxR2oKXlpDirrJO2+vD37Phju1pTrGusrHlBDPPU91Xuc7Q/Pf2
         8csQ2s9piSLl97GTJawtux5h55iHsfE5ztNVR73HTtp7XyZUCN1Q24pRSTtZ7nKd2DCs
         mhUAU2lV5UgS8BfyPcWaoI1e1QI27AdTNoEDINXv54jIJdDCw9kIyiMJU1JsSkfH6So2
         fYjA==
X-Gm-Message-State: AA+aEWYbLovFnx+uAYt/wmyJ+e7m3c5D4s7r/w/+0usf2nvyr2PE/4Hv
        Zyb8/QHTcnS0n5w6M1a09LcCzm0B
X-Google-Smtp-Source: AFSGD/XCk7RPrd2tBeYzd7gLRVKr6L1m9mx2hd1piHVFYQ6iG7hERtAVe4viDmTqTcRsbn7VtwFpnw==
X-Received: by 2002:a05:6402:694:: with SMTP id f20mr5704727edy.99.1542812081450;
        Wed, 21 Nov 2018 06:54:41 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id b49sm11178982edb.73.2018.11.21.06.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:40 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] mailbox: hi6220: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:17 +0100
Message-Id: <20181121145429.7582-8-thierry.reding@gmail.com>
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
 drivers/mailbox/hi6220-mailbox.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index 4fa9803cd204..c32cbfaf223a 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -349,7 +349,7 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 		mbox->controller.txpoll_period = 5;
 	}
 
-	err = mbox_controller_register(&mbox->controller);
+	err = devm_mbox_controller_register(dev, &mbox->controller);
 	if (err) {
 		dev_err(dev, "Failed to register mailbox %d\n", err);
 		return err;
@@ -360,14 +360,6 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi6220_mbox_remove(struct platform_device *pdev)
-{
-	struct hi6220_mbox *mbox = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(&mbox->controller);
-	return 0;
-}
-
 static struct platform_driver hi6220_mbox_driver = {
 	.driver = {
 		.name = "hi6220-mbox",
@@ -375,7 +367,6 @@ static struct platform_driver hi6220_mbox_driver = {
 		.of_match_table = hi6220_mbox_of_match,
 	},
 	.probe	= hi6220_mbox_probe,
-	.remove	= hi6220_mbox_remove,
 };
 
 static int __init hi6220_mbox_init(void)
-- 
2.19.1

