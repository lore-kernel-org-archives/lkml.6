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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830C8214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duAu3lAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830C8214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbeKVBa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:30:59 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35267 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKVB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:24 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so5133992edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BisYbebI+HEfjXm01nCBntqdaVnmuvPJqVkA1iHiGpI=;
        b=duAu3lAd45cqHBEeNdtHgGrDCVJXiuy7XRKOZ9kLCFkFua3j9yU+s1wVqU6v8WxRK4
         wTLS/z3veHcBwcRoB849TOp9su9iKvxyao6/VLYpJ7Lb3FKCL/0gHZgFoNVFjKxO1hLQ
         UYNJN0K7paCz67sVshYdw2ZTD95aMhDqCJ0G7tEg75GoAl0J3A2av3hNgXotOISLHA5J
         Hy7jYmqxXWaX7mAH3CCjIu00u/PYLWQ5Cz1LdB2zCkkmUBGoVthArk/FYtn/kfB6dPas
         zGSxYFupjF1Nbx5CO+OTrBtkEsQBY5EWEmDZG3vQ0GEZBAKSBOBNBIzrxNEpUHapIGTc
         8UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BisYbebI+HEfjXm01nCBntqdaVnmuvPJqVkA1iHiGpI=;
        b=qoA9zeadfKvAVzkPwz8kkX2hRwolPeT22iZA611mfC240lz+rslRGPBmUKFPQ4dToa
         8Huyh/d3BGaeeJucvo/PS+E1MkUo2TvgCKk965GcmqIXbNeNblwCwRrsdqEf5WcQ6CaC
         WMMyFc1BgKa8OSB6V5c0/V/EnfX+dbqfKixDXpZ8OYL8OwkVva0y9OYeEQ9KnnGe3+fc
         /egogSZ3r1o5LKOPeqsVlDhVvpXkfdGwqHpH3zjBj+m7zM5XLo7Ye4gC1ru9iuaqLruf
         3ddiLHUVXQEUoJ/GeW1lmd0IUeL5Pfo8B6uvTZ6A0yyKLvRe8xEH3HL9bn05j2aFmAiJ
         ghwg==
X-Gm-Message-State: AA+aEWZ9FksGgMgx4mWOBzPYOG6vAQ/AaJMcx/sAgocvyT+nqb6srj1S
        IqLcgZKX0C+S81a1nB0cTzg=
X-Google-Smtp-Source: AFSGD/UfhaxsIHE4h4XhWx95ztYq7jdflue4MMHoRSWSfzTGhFRxJqf/LI8eT2imJQLszdhR21FSRg==
X-Received: by 2002:aa7:db0e:: with SMTP id t14mr2915706eds.292.1542812078609;
        Wed, 21 Nov 2018 06:54:38 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id p22-v6sm7702036ejb.76.2018.11.21.06.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:37 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] mailbox: bcm-pdc: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:15 +0100
Message-Id: <20181121145429.7582-6-thierry.reding@gmail.com>
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
 drivers/mailbox/bcm-pdc-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 4fe7be0bdd11..ccf3d62af7e7 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -1471,7 +1471,7 @@ static int pdc_mb_init(struct pdc_state *pdcs)
 		mbc->chans[chan_index].con_priv = pdcs;
 
 	/* Register mailbox controller */
-	err = mbox_controller_register(mbc);
+	err = devm_mbox_controller_register(dev, mbc);
 	if (err) {
 		dev_crit(dev,
 			 "Failed to register PDC mailbox controller. Error %d.",
@@ -1641,8 +1641,6 @@ static int pdc_remove(struct platform_device *pdev)
 
 	pdc_hw_disable(pdcs);
 
-	mbox_controller_unregister(&pdcs->mbc);
-
 	dma_pool_destroy(pdcs->rx_buf_pool);
 	dma_pool_destroy(pdcs->ring_pool);
 	return 0;
-- 
2.19.1

