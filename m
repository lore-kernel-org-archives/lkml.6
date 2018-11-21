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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D26C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE004214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgShIrMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE004214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbeKVB3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45236 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKVB3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so5084928edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPOfAAp695fHAn5TDSsb2YJrXbpcvTnkB9qGJG0Cl0U=;
        b=hgShIrMtO/2+X6BuxejlDtyLwdpmpcuJ9w9iX1D3b6euJjr+QQBHivpRywXqOV8AvS
         eePQunIY6AaJ7BRmraCeeM3UrX6hAKTKD6MhINT1FKzHcYPfEz3NNLUFB+m3IkJJpzRe
         2R0j+pMQ2x8SgxmNZJKXRrC1vwRoY82PASIjDavEWkgq72BOYliMTXrfJBR9JR3SHE2P
         BKjUvYUcVXILxXPa9snIgBYW4QwSEjd1rwt/ZjHz8hRARgecC7nDWukUykle0/8lIx4l
         zgTLZjSDDhf8A02GeZPm7BkFs2KZ3GGBrMZDEB+BDrmP4VTtbuyKfuvwneiw6Nw6BX2F
         E0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPOfAAp695fHAn5TDSsb2YJrXbpcvTnkB9qGJG0Cl0U=;
        b=Wbw2UEIUw+KjcZ+Lx5O8cqkHdNom5/L2d8oTxh7r0ql4eQ4CmHpbsl/V8Qj671wNGw
         mfmGPyHXIU9/Cluk7bzcRcBCg4YpruhOJla2caEWMJLoyQW1QLOwppMbLZYuXMH1Og9I
         4A2iT/ReqydC1sgH5a2q58c49hfwyp/6sB94O+rMaogQ8FDDU1wjM2v4yj7gfZd5H0vC
         hX9ywUcTTo2i2Tigd5Vw03x2Dm7jYG8r2mM59Lrt9OYFJbRzb+7rRQD5bwbGK/B56jlK
         G7KUgz3WAax9xqPfLZzgMhd6M5W7Svc8RF0Gb8sMff6+HjgT3RldHqqAIGSxQG79uaIC
         +MrA==
X-Gm-Message-State: AA+aEWbTh9mgW20ZnLaCn637oE5TxVDAIj/VXBYxqcVzlyFPk/jSoMO6
        xlz28cyDanjmjaMDjrquOlw=
X-Google-Smtp-Source: AFSGD/XIx1vuAUyG/eJDZ6yT/SfH6yyNjPsTgMV8/4duISlfF9gzmDLhRDMrf8pmPltjIGxmUnBMSQ==
X-Received: by 2002:a05:6402:1347:: with SMTP id y7mr6042141edw.114.1542812075524;
        Wed, 21 Nov 2018 06:54:35 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id a11sm9062713edc.28.2018.11.21.06.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:34 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] mailbox: bcm2835: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:13 +0100
Message-Id: <20181121145429.7582-4-thierry.reding@gmail.com>
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
 drivers/mailbox/bcm2835-mailbox.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
index e92bbc533821..d48f67b25567 100644
--- a/drivers/mailbox/bcm2835-mailbox.c
+++ b/drivers/mailbox/bcm2835-mailbox.c
@@ -178,7 +178,7 @@ static int bcm2835_mbox_probe(struct platform_device *pdev)
 	if (!mbox->controller.chans)
 		return -ENOMEM;
 
-	ret = mbox_controller_register(&mbox->controller);
+	ret = devm_mbox_controller_register(dev, &mbox->controller);
 	if (ret)
 		return ret;
 
@@ -188,13 +188,6 @@ static int bcm2835_mbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm2835_mbox_remove(struct platform_device *pdev)
-{
-	struct bcm2835_mbox *mbox = platform_get_drvdata(pdev);
-	mbox_controller_unregister(&mbox->controller);
-	return 0;
-}
-
 static const struct of_device_id bcm2835_mbox_of_match[] = {
 	{ .compatible = "brcm,bcm2835-mbox", },
 	{},
@@ -207,7 +200,6 @@ static struct platform_driver bcm2835_mbox_driver = {
 		.of_match_table = bcm2835_mbox_of_match,
 	},
 	.probe		= bcm2835_mbox_probe,
-	.remove		= bcm2835_mbox_remove,
 };
 module_platform_driver(bcm2835_mbox_driver);
 
-- 
2.19.1

