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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA2AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A3F214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teoeqMKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A3F214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbeKVBac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:30:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46643 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbeKVB3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so5077172edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EyVziiB/0GWu5wJeWSCZfSDEtwS95v0+fVFBean3lO4=;
        b=teoeqMKIDbUSXGTrK5XEElevykq1L5DwpZUhTsVRpjgSn5NlhlAEVsfYRkwZeH97Kj
         K9mpHQO9IGJ6TveD1RiXsKFppcd2PcKI1Kp90mdSfz9Cacyd4FfsSuOOHdMhBVArIdBq
         8ayzvaaGN+jX1W1bcFga55/iLbLBltHHCI0ak0t+7N2691YUpgpbn9qvV4WID8le5YBr
         gduMsFOtF28Pk4sVp+z8dhllpM+oqhtr9XL+6dKrwOriJIv0BsXZ6fyeI7HxilywhaIp
         di99cd5inWieySyfxNyUdvNl/ab1PbrZqLt93uQJu9AwmI1eCzPwqlZwrKatzy2J3Bea
         x+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EyVziiB/0GWu5wJeWSCZfSDEtwS95v0+fVFBean3lO4=;
        b=Sn1x019OlicVgJn7j3iuku0C0U2Koww4yyJ9xR7iFY0IsDqew8TeJMKR856bNenUUt
         7zqY9WoruUihlTyfGKtuAXDKnA6TaJkBDyzv/jt+/7qSKq38ePjVP1kdlOKPacqemZy5
         w9w0uTCs+jgVxfPPDcy1YSGeNyKrOeQz46qBmHw+jiOw/h4lmnJqLoXWSWWgYTtfkbO1
         ZrtU363xaPpCw+QA6ikwChvPtAJXJKOJ3JMA/Gi+bCtByg/qpSXZHzKTLYsa66w2Nyri
         qhevsMh9TXZg955xSNEUxl2IUcderoUEpuM/y7uDT+DpMZGpUo5SeWabYngydTzdoEaA
         ElOA==
X-Gm-Message-State: AA+aEWavtHSzWTt7cQB4bquQCD6I8gWaYhSuWWEQ4qL2Ve77EzRGr7Kz
        C4P/G4Dkmc3K15/Oi7BA6Os=
X-Google-Smtp-Source: AFSGD/VX3kWYkU3RqX/fIhWHko35ggOY6u4xIYLKsqEdKuQ9PtDbDTsY9y3SDTGms9IAFfXxL8ZVKQ==
X-Received: by 2002:a50:9dc1:: with SMTP id l1mr6013369edk.272.1542812085969;
        Wed, 21 Nov 2018 06:54:45 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id w10sm9448432eda.77.2018.11.21.06.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:45 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] mailbox: sti: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:20 +0100
Message-Id: <20181121145429.7582-11-thierry.reding@gmail.com>
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
 drivers/mailbox/mailbox-sti.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index 779d41262ef0..adf82b85dbb2 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -462,7 +462,7 @@ static int sti_mbox_probe(struct platform_device *pdev)
 	mbox->chans		= chans;
 	mbox->num_chans		= STI_MBOX_CHAN_MAX;
 
-	ret = mbox_controller_register(mbox);
+	ret = devm_mbox_controller_register(&pdev->dev, mbox);
 	if (ret)
 		return ret;
 
@@ -480,7 +480,6 @@ static int sti_mbox_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, mdev->name, mdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't claim IRQ %d\n", irq);
-		mbox_controller_unregister(mbox);
 		return -EINVAL;
 	}
 
@@ -489,18 +488,8 @@ static int sti_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sti_mbox_remove(struct platform_device *pdev)
-{
-	struct sti_mbox_device *mdev = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(mdev->mbox);
-
-	return 0;
-}
-
 static struct platform_driver sti_mbox_driver = {
 	.probe = sti_mbox_probe,
-	.remove = sti_mbox_remove,
 	.driver = {
 		.name = "sti-mailbox",
 		.of_match_table = sti_mailbox_match,
-- 
2.19.1

