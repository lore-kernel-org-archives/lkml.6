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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA3A2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTJ8W4iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbeLQPDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46598 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbeLQPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so10979193edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFNTWqFhpeKazwnOj39UERk6OY0Ka+1WIfdnXbFYyQU=;
        b=rTJ8W4ivtQ+0ZutMxNy/tJLyPtCuIOtImFOokbcfTPC85oPVzSbmDD4i1U0YjVOYvH
         E7UyLDKHmmqTZr4Pn2d/9bw3sPFK5GwUedWW0qD0zl2oJLst3DbS4B4WwyUes9XICaSf
         jiRYYVy0pkEo6SxBA2zcDV6ELMWodrBgNTFaMZ5OUBPn6usFNrlAWGNRW12bRTDXXBn/
         Cr3YbTdGna3UOrhR1HzZJUWqWBr/2Gv0cdSYjSnvfgJzidEkhYPvT9M7C1YygWG5vQgB
         evyKkg0FMdr9syaeVjMtg1500ZDt95yV5azsMJmObB31URzL5hMRry9pN1FWsO0U91xH
         4lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFNTWqFhpeKazwnOj39UERk6OY0Ka+1WIfdnXbFYyQU=;
        b=nNuWZlBTXzdfSFMrQwI32XfKyl/jXfJpqb+mLwSTBX9rvuh1Xb4KF5teUjkUmTkbfi
         b5+5yZTmxiUzK7duwKvFSWBN3R6iwgmxfB7mibb7YvUhc9m77gplb6EmIZY3WCpSrZak
         CrHh7xypFfG0xZsPaPPIygXD9ayf6y6CHtK/HloRI2vkhiyNDT/I1tf+KoM72oOuzF/d
         iUhfkw9jT5uwQb3FAptGcjrmZJocnk0kbL89+BVrSWDdYtIxFj8XLm2lJocHrpOG4MJq
         LG4/YTMsQkZgf6RreAeUHXHJc38kRErtG1yQUUtmbhxUBYNW4ZCrkkZktOwQsfiLpPpi
         i9pw==
X-Gm-Message-State: AA+aEWbz4ahI7azp9IkLUG/dbrm0fWnBxeytWMhf8irtYVx2GqVPBHiT
        e0vPhFxJIZjSH0PiQ0BxPCk=
X-Google-Smtp-Source: AFSGD/UX2vcD5YSZVvD//sx0fhxrN65p7ITg1lmD7RFPU2toLNl42SyXDmuq6wsa8icZOghm32URYw==
X-Received: by 2002:a17:906:2615:: with SMTP id h21-v6mr10566645ejc.21.1545058980855;
        Mon, 17 Dec 2018 07:03:00 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e35sm3905275eda.13.2018.12.17.07.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:03:00 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v2 13/19] mailbox: mtk-cmdq: Remove needless devm_kfree() calls
Date:   Mon, 17 Dec 2018 16:02:11 +0100
Message-Id: <20181217150217.32435-14-thierry.reding@gmail.com>
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

