Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B305C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9B7217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0vLS5kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbeLTRU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40080 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387888AbeLTRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so2392519edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFNTWqFhpeKazwnOj39UERk6OY0Ka+1WIfdnXbFYyQU=;
        b=W0vLS5kWOBFQ91h93cUXYxuwVuBC8RMdx5Y0SAD9HxeadKiAj+e9Ac1iD0Cn7ui/Dg
         unMxCVYAv3pQU7Np5Y3XfpKzt8hQOJKK7l3PtFPv+X7XXE8I/5gBN1mrOkd/z6u8dzoq
         PFshIG+wffEIyXca0e2KISk+3ZKNMwKRb34lHOoDkCxKJhxyFK3o3Gck1FGiV01qJLdR
         lfLE1E5ppYAQ8jy2NAQUeC0zO/GO45PqIlRli4Oor5jBJyIVa3NH410klbH9LmEWBcmv
         8hMjNSNt3QdFfWXoXzt+B8jRlbs+dzoLDqtWHMsmQ/CtvDNV165r+ABsPKCOilUv/DLW
         htAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFNTWqFhpeKazwnOj39UERk6OY0Ka+1WIfdnXbFYyQU=;
        b=lSX19/Pl7WQ7HrmfZiYGXsN9+NMvxgPBmPxkoPyhDl+sEG9Qf+1mVs7bcrb878xEtJ
         ibz/WiS541KBl7n4MJWqg+123B+wjyh9Hcjk03k1oLysFNMeXIrP9nYswDbHFYp53pu9
         b630+KOMeP/ABP/QTX3Ph7pQ61gzh1zJhCpRGaD1iuWYPuE/WJrmaUa0nJx2a2b4Y6UA
         AJXJT7a7pxc9Mc/pQ9mYVkwHO5LwNugtpNu0FORZSxQpms2SfvSLbN3MG+kDScr+Xc1p
         DZA4Ni1ZdscEoYIbEwuRQGkJDUHza/i+w4AoLb9cFn0dyoKYtCBpr8dE37TIhKTiPS24
         ZcWg==
X-Gm-Message-State: AA+aEWa9t/IPaZ7F8cK6+rC0LiplPrNlkQGqe1jC1l5Hy0hwYY2E104r
        i3bfTtBJGvMzSBvKkWDcKUacv7YY
X-Google-Smtp-Source: AFSGD/UnkS8opSOrXMWylhtvzpuwAi3BPh9mTz188+04jJEg9cj2rdyG9Rao4/tkvQFQhVueFO4TpQ==
X-Received: by 2002:a50:b205:: with SMTP id o5mr23698610edd.245.1545326424896;
        Thu, 20 Dec 2018 09:20:24 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id x47sm6289437eda.91.2018.12.20.09.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:24 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v3 13/19] mailbox: mtk-cmdq: Remove needless devm_kfree() calls
Date:   Thu, 20 Dec 2018 18:19:56 +0100
Message-Id: <20181220172002.9016-14-thierry.reding@gmail.com>
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

Memory allocated through device-managed functions doesn't need to be
explicitly freed, so these calls can be removed.

Cc: Houlong Wei <houlong.wei@mediatek.com>
Cc: HS Liao <hs.liao@mediatek.com>
Cc: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index d9c3ec3667a8..22811784dc7d 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -339,14 +339,6 @@ static int cmdq_remove(struct platform_device *pdev)
 
 	clk_unprepare(cmdq->clock);
 
-	if (cmdq->mbox.chans)
-		devm_kfree(&pdev->dev, cmdq->mbox.chans);
-
-	if (cmdq->thread)
-		devm_kfree(&pdev->dev, cmdq->thread);
-
-	devm_kfree(&pdev->dev, cmdq);
-
 	return 0;
 }
 
-- 
2.19.1

