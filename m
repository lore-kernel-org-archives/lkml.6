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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59CA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOiiUMh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbeLQPDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36184 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbeLQPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so11021312edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Os5+eL0aItk/r3Kt9Iy8JntVxMQN+Tu6L6XycJggpU=;
        b=GOiiUMh2OW+8dnIl9zwVmVD/deYs1V51AhaTzXpxFmtI+/md5BlqF/Cs5/w71JSk0N
         645Jt8mXtSQYQvgZU9aiTFu5jeU5w/HFk84fhnL41dZuWNg5NfBkhqoFxg+uP6V/qxWR
         BZSaxsG/mE4ACRta0fG2YXtmnxdmj73ADH5lZsa0qdH9AjaJQ4HliZau9eyST4SuA4Pl
         n5qxGuShbFKEtljLMuYPZvJdq6//eYuCI/7A/0Ms7UK94tLP20oZadrQB/xHKGFvVZvZ
         lLMlEGD02S6ZZkgVzHV3RcpELCsRflxuJ+HEmXtN1MTS3vGBGB/5xGBj0KdbxvV1dLje
         RUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Os5+eL0aItk/r3Kt9Iy8JntVxMQN+Tu6L6XycJggpU=;
        b=SkaO8Swi+ijPRJccWo5eL8vc3znnfahB+5m/9OARbBIgHset6C6uEFxEILv3n1Gf3Y
         E7+aTvpdCtCoyuAemF2aqmIo9L+f0w/ERr/B/IZK9nlhAbdAkQ6F8KKzvisu93d6qfsZ
         1gAsegF5IC7eEUIND/5XY4Ic9NBjS650ctytGtoLzp6PH1upmjadZxcTToNjdW+z725/
         1Uoc5rDDMW9lm1QbcreYLhuQlYfmN1c/ronftwENYegKFMQm+Xr1abJQWDjwajSPGC5J
         6S4DduPri2llskQqPUZh05npA1B17j74RJIzp/72fGYUVniCv5SNCuNsthe4hPef9/yt
         wUyA==
X-Gm-Message-State: AA+aEWYys8/O6r416Fila6DzzPUFxVTVSdQTJ5CqgDVWOpfKLVQewqRv
        qPtMnr0Qb6Lnvc2k7YrxsyQ=
X-Google-Smtp-Source: AFSGD/Uwc2NAER7g80chB9f7Hb4IK/IOZOAc/HZx5wHNiDCCizU+64+EsKBG1y1Z9yc+9Igs6HgvRg==
X-Received: by 2002:aa7:dd0f:: with SMTP id i15mr8017225edv.29.1545058984808;
        Mon, 17 Dec 2018 07:03:04 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w24-v6sm1939122eja.71.2018.12.17.07.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:03:03 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 15/19] mailbox: platform-mhu: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:13 +0100
Message-Id: <20181217150217.32435-16-thierry.reding@gmail.com>
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

Cc: Neil Armstrong <narmstrong@baylibre.com>
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

