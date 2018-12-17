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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F715C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCE720874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmIM2Jea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387837AbeLQPDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38725 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLQPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so11009916ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3rsKFW04x7SNb9/m8whEnCmz/CJYUBzTpBQOd4qbbfs=;
        b=UmIM2JeaD9/1//r3fPCZxeet9HcIdtB8rDDi9qRHWc0GnYfciirsjqL6lmO2ShSbZq
         hkFN9ISEf2QGr5kkBl8ztJMxQUs+5gSOtFF/Ey1WjgytaPitJx+GwuV8D4AriZhaHNhZ
         CHVplSu6BjvOpUnJsgn0XDO+dNdzckoOR02Ba/2zfKQ9y5+YqYSIjchdOgyWywERz9Wv
         TIkgct1NDFvrNjA5Dj/0Mms7fAt7rWklYVvZ4s6qNZsBrwWYTJJLa0oide8gdjDOceR2
         h/pS6cB2xw5goTK40OLJGIzRMXNEbH6ReDNVgBG9q5DBI807dvrZWwyo7Nu6QFGDC4d/
         CelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3rsKFW04x7SNb9/m8whEnCmz/CJYUBzTpBQOd4qbbfs=;
        b=Oa7D77Gph/Rl3aP1ptEj0R4YQgVDFemySwmNTc4FKC1qHMRrGNqNV1X6q6VWRYIx6B
         87kqAA/bfyUpgUD44P1OJPEc+qWxVrU/bTohfrLne61ONX3hin0vJamykXDpLtgnZFQ5
         rI3uf7x+tyu8kdWT+9rgca5lio+OYCQUenCfSk3JjmxqTu9/IwYCpV8pMn2eezmqwt8N
         4oNhoF6+4ihKw7XxHdjgs5DYg7ccH3e/dR98a5l5IxZRDlcnFYlQQL6Mn65F6RqPXQ5R
         II3K5sW2X2x71BKGg3mldeiwVRYPQA6xzdpdfrssopWbulm8aRiSxHYxXtLGJmmiWhVD
         gZRw==
X-Gm-Message-State: AA+aEWYAXDffI06MXyjREmFJfsh9J0IeO0clCUxbutsjeGc5As790F45
        YqUZ2HIoXBsKeMNLZlkrT9c=
X-Google-Smtp-Source: AFSGD/WSs61cCwDiscNbVQ9M+Y2kcJZWDcTgivq8vyc27rsWKIQyzEgjTNSSbu5R1lrrH7mx8TSHyQ==
X-Received: by 2002:a50:b1af:: with SMTP id m44mr13001857edd.47.1545058978775;
        Mon, 17 Dec 2018 07:02:58 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 49sm3823646edz.59.2018.12.17.07.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:57 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v2 12/19] mailbox: mtk-cmdq: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:10 +0100
Message-Id: <20181217150217.32435-13-thierry.reding@gmail.com>
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

Cc: Houlong Wei <houlong.wei@mediatek.com>
Cc: HS Liao <hs.liao@mediatek.com>
Cc: CK Hu <ck.hu@mediatek.com>
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

