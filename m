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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9BC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC54214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eys4Xlh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC54214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeKVB3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35284 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731263AbeKVB3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so5134426edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzxUjnNAbhwN7r8Fc+mRz4FPenni3nOPBCv/QJaSIwE=;
        b=eys4Xlh+WPcRKF02gF5sKMa+zrz0wsGdAHMT5jPltLCuVkt+i9nYjkWcxyQcdWnZe7
         LE3DA4pRW2/vjykQiYAd4AKN2UVEnOoU/Hposubure9ZZtwH9aOdv5w+TaHWnx2QyZoo
         VxwAYsiaRNkDAnomi5WXYg1mLwFHUtu3xVJQCDEEI1w93jgjDg42Ac4Ps+6CVN6A5+gL
         NSCH2RJo1vMyfZ3CRAbWkQ1fFlT3d8G8weLa2di915ZhKDjO1LqIldXtrPHqDppT7Bzn
         j/HM0EQPNYenPYM4o2YZ0YhlaEqSy5ACOzu/bJmr/sTRQ5RWT3bvoCwexbFbF9iNr2XQ
         5E8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzxUjnNAbhwN7r8Fc+mRz4FPenni3nOPBCv/QJaSIwE=;
        b=S7nAxsff9FDheStuaXSCGCzaMY0/NodOS+ZdshDwe+cMlz26KqaWCB/bOXrzjBhmB+
         XTH9f8knJEd3JZkAPHHl6Z6vLbB7BROl/JHzd3HL2ncxQsW3qJ2dauhr/yDPJFfyLONg
         ryY9dO3/rY9K3/gcoeuefYnKZHCShMZK4XgzblHD3YccD6Wa7cU4lVTuay/MlLPM0lYK
         f4elouu/VnhU2vsgnnosMdgwIyNshQ4qMMMY1UW+SMoIk5EHkCbYHA50gTfyc67qePa5
         7lI8WlaFDrHMprYKTp/ln0k89Auy6ChZyNdGcowuK08+7+ilNDODtnwZ05jmbVJH9ATw
         etXg==
X-Gm-Message-State: AGRZ1gJLKrhc/sA6b9luoIvnkNdHIaJ81lDZSR8QUmO+4Ei1pI1jEDb1
        IJLuTAkhkbA+azzzZSW3/No=
X-Google-Smtp-Source: AJdET5c3q+bh+VzBwmmXl8Ne+mnxTI1OnN24e2vH1HFRLtZMkUxn/MzysQmOB8XzYFP1znbhcjWZCQ==
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr5366870eji.106.1542812088958;
        Wed, 21 Nov 2018 06:54:48 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id d15-v6sm3293932ejc.31.2018.11.21.06.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:48 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] mailbox: mtk-cmdq: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:22 +0100
Message-Id: <20181121145429.7582-13-thierry.reding@gmail.com>
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
 drivers/mailbox/mtk-cmdq-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index f7cc29c00302..d9c3ec3667a8 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -337,7 +337,6 @@ static int cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&cmdq->mbox);
 	clk_unprepare(cmdq->clock);
 
 	if (cmdq->mbox.chans)
@@ -524,7 +523,7 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
 	}
 
-	err = mbox_controller_register(&cmdq->mbox);
+	err = devm_mbox_controller_register(dev, &cmdq->mbox);
 	if (err < 0) {
 		dev_err(dev, "failed to register mailbox: %d\n", err);
 		return err;
-- 
2.19.1

