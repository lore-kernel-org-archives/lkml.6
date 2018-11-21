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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E878C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAB02151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSCtAYyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAB02151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeKVB3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38833 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbeKVB3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so5114235ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r9oQfkBSdqm3O6xqR7i3yqWzmZc0LiA/kH4iCP04Aj4=;
        b=PSCtAYyREsf5njmcCMw3hap02Cx4VqT+AMdM5pOp2enMZYRAv75i4TDnri2VPbicra
         IJDYnzeUU3IirExDap3vkhrhxFsYJsldz6uK4+svar1Uy0UZzArhUl8i+vAHhkEGDzE2
         8SLsg+Vim0Oh7z3fo/8P8zN1vrZABqDQwfGUJrZOG627XJewQ17qFuU3pMN+myPBJI4U
         cpnR7wtNY9qT14nesoCEA3Ka9bcLDTKgI68sQDut7Kkle9GJAm6Eguee/EXtu3TaHO90
         OvvQ3I20CTBXQuJMCJEkaf/7vC2cOY839k1Cc/1c8qF0Wdxn6UDCNq/Itfy6Bjl1y9nX
         bexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9oQfkBSdqm3O6xqR7i3yqWzmZc0LiA/kH4iCP04Aj4=;
        b=j/XgUhr7D8mHGtB6RGZfLhDEmtUtDBRVOMcF6s5GXdmBH7e/1ItPuKepBmZip4Flzg
         RSmrDiEU90tKokPBSlKRKYkk0xHF3yK91LaBiGZc1b+jD5roVclmx326bYiHy6uUG78p
         q1Bwh50ECnRgsJxyIDaSumWvvfGTwebnlVBN6yMRur6XkDR/gt+QT730ZaX9j1ATTX6Q
         MoH89qoT0DmkGz+du+8HoWwYKPtIl0iRwpsmNbiFTasApX8CG0+z0pyiDGHaZ5ouK+sA
         hWorTFxt0JrzFIjnqfmzSHK1joD8PXg1q+lpFPkSsi1H+Kn5STmIcPrzshpp9gCUUCV3
         QANA==
X-Gm-Message-State: AA+aEWZywU9LtYtPK0eqZgCoFEQravqk9XGKcnYuCEelZelGg6NdM7Lw
        ueTneA0ErJoe+qG1Qsu7quQ3wNvb
X-Google-Smtp-Source: AFSGD/W11KvHXhPQnmAIFso2zaqXi7KQC1Hn3c8tvAidTSpYLJmmPYdql5LkjfGNNp0PSKo58ysQTQ==
X-Received: by 2002:a50:9977:: with SMTP id l52mr5636638edb.277.1542812096687;
        Wed, 21 Nov 2018 06:54:56 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id x38sm6235305edx.24.2018.11.21.06.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:56 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] mailbox: rockchip: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:27 +0100
Message-Id: <20181121145429.7582-18-thierry.reding@gmail.com>
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
 drivers/mailbox/rockchip-mailbox.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index d702a204f5c1..f24a77b1a0ff 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -247,28 +247,15 @@ static int rockchip_mbox_probe(struct platform_device *pdev)
 		mb->chans[i].msg = NULL;
 	}
 
-	ret = mbox_controller_register(&mb->mbox);
+	ret = devm_mbox_controller_register(&pdev->dev, &mb->mbox);
 	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to register mailbox: %d\n", ret);
 
 	return ret;
 }
 
-static int rockchip_mbox_remove(struct platform_device *pdev)
-{
-	struct rockchip_mbox *mb = platform_get_drvdata(pdev);
-
-	if (!mb)
-		return -EINVAL;
-
-	mbox_controller_unregister(&mb->mbox);
-
-	return 0;
-}
-
 static struct platform_driver rockchip_mbox_driver = {
 	.probe	= rockchip_mbox_probe,
-	.remove	= rockchip_mbox_remove,
 	.driver = {
 		.name = "rockchip-mailbox",
 		.of_match_table = of_match_ptr(rockchip_mbox_of_match),
-- 
2.19.1

