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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AD1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834D7214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0TtLyB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834D7214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbeKVB3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39340 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbeKVB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so5114987edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQK6/coun1pZ6hQS+rMGEGe9vKZQr1TxwE/Wpo/EJp8=;
        b=h0TtLyB9LWk7WqKafWa5kLiOUkaQcE8ruH3xznI/f+qJMV6mBcPr2ONk4HjrerIbiW
         XnPOmwn/C5m3BVjJfoF6iSoSUSBAy2BR76OXSBXzsHpjjAbBY30nsCcHrtC3b+13mfXg
         YOvZMTD3M62aXE6BCS1y17zh9DdMURBXHcZh76oG/7G1oAZ7STkOFZzWX3kuG4wL12rE
         m3Ed79QIM1gehfdM0ZRU/vqnBEvLwoBIo5MKticGSRa5PjZU73TUAkUQV8JgmGQywNny
         iWiWC/MSCrmvJcDFULpKE+skW48UrZtv96tT0dHvs85DdbEVF3hIor01NC+zrXGY5ECB
         PpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQK6/coun1pZ6hQS+rMGEGe9vKZQr1TxwE/Wpo/EJp8=;
        b=K6Vk2e3vnOmeLavcDYC6gibRa9mEqlWkTFBeUCUC0ola0ujo5e7Jm+lCZvQsKaZUed
         ae6j0JBmJ2zhviTSjcTTHuzfBRt6dRCmRnbcpt6MGhrdQE5vnTMnuwoVMAFf+HUmtFqm
         wBaldKtPNpr/nvN3JmRHcpn/4LL3Uuwm9aPfqlDEY/za+1aeWmZBlpMVjnD/HvGfkwLy
         sMSY0o3zAU8TmibaOeqbni5hlNi6dFH2Jj/hA1n86bFRChyvXmfgwf1PBu8ZsBAbxL3U
         OqQdjzRPA/VbUpBHEfxc2KFX8us7EPn/bgUBreDQh7g+XlUSnHhlrTDp7jS4O0FSnSQl
         Apaw==
X-Gm-Message-State: AA+aEWY6PfJYM8aOTv4QXbuGHM53lQfi4knNK87CWrJPNWwnh1XhNVW0
        ny4XdcKv+Cx5/I+MmkGZ/B3ucGv7
X-Google-Smtp-Source: AFSGD/XCEXz7ztVlqO+tAmwYCfgEORtBqUO+1blpElhYHFWZVep45aU02iw8swR7mkgBHB/aUfGzlw==
X-Received: by 2002:a50:ad0b:: with SMTP id y11mr5794781edc.113.1542812093713;
        Wed, 21 Nov 2018 06:54:53 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id m7-v6sm1652148ejx.65.2018.11.21.06.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:52 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] mailbox: platform-mhu: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:25 +0100
Message-Id: <20181121145429.7582-16-thierry.reding@gmail.com>
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
 drivers/mailbox/platform_mhu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
index e13201a5cec6..d2502c5be130 100644
--- a/drivers/mailbox/platform_mhu.c
+++ b/drivers/mailbox/platform_mhu.c
@@ -163,7 +163,7 @@ static int platform_mhu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mhu);
 
-	err = mbox_controller_register(&mhu->mbox);
+	err = devm_mbox_controller_register(dev, &mhu->mbox);
 	if (err) {
 		dev_err(dev, "Failed to register mailboxes %d\n", err);
 		return err;
@@ -173,15 +173,6 @@ static int platform_mhu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int platform_mhu_remove(struct platform_device *pdev)
-{
-	struct platform_mhu *mhu = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(&mhu->mbox);
-
-	return 0;
-}
-
 static const struct of_device_id platform_mhu_dt_ids[] = {
 	{ .compatible = "amlogic,meson-gxbb-mhu", },
 	{ /* sentinel */ },
@@ -190,7 +181,6 @@ MODULE_DEVICE_TABLE(of, platform_mhu_dt_ids);
 
 static struct platform_driver platform_mhu_driver = {
 	.probe	= platform_mhu_probe,
-	.remove	= platform_mhu_remove,
 	.driver = {
 		.name = "platform-mhu",
 		.of_match_table	= platform_mhu_dt_ids,
-- 
2.19.1

