Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA8FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A363217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7KAz1AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbeLTRUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43580 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbeLTRUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so2378285eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0jXNL7oWFU6ApRdFdNc3qYVT1ktSOznt6gVCE4poEI=;
        b=e7KAz1ALVRqQ9cSJHl/jUjZHCJJrazVENLfTaQDBtkiI5cmpKSdJAk/MCOqXs4RFw6
         RI5psOa8nbMYbCSdcbObW0vhsTdY+eHg2ob0GNi6J4shvxmGpfuXHuJWz/SLT+psu9FR
         fSNm2MvDLF7aYlB188sQyol9aLCY2q74idGUmaj2RFBweitMh+gvcrBvl13b9ofgmU0l
         UGqT8E0+7CHULlZPLd0jpCboyAD8cV/dKGvn4fUVkQzMtEcTdDLPdE99MZESAQ1tkZvM
         p/XgP8FFUach3NMjobdyFiq+Evat6v3E7yVBnswd1VtihK8Gzw2GRB16GABgUwTzCi48
         a1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0jXNL7oWFU6ApRdFdNc3qYVT1ktSOznt6gVCE4poEI=;
        b=YmXq02IYQ6LsgU67U8wGgx/HNvKw4BRF5y7ESleU1O9B1QeGwnyl/0xh6YHcrg9Rfw
         6X4CYE9Ffg3IsyhPzWGeyho8J19LrpyNFv1ykq0xcssI+kTvp7K820zoFdWQQbKI4XzG
         gq7MIgFwtAYEpYwW+X0P3JGZEzZPTy8EbNHEh5oRv66YA/oIECPDzSH3DvuLPFrWQBM0
         xnekVy37nRjy3hArFppRL4YXQjk6d1ryF/5ZAmmqT1hVVKr68JMk8UGlyWUI5JesopFA
         m/mQQuASVywLljDO0+chC/nzOAXcpFDzmmoyy9HoQUVyS7jSI1pWgW0RRCq5NOk5EBwg
         BDPg==
X-Gm-Message-State: AA+aEWY/jMfCdrmb+0F8n/mnW0YynOB6WwQDaBI4siu3/gJpI4W7n/n2
        FK9ial8mTomcmz1wmP7ye4o6HcLL
X-Google-Smtp-Source: AFSGD/WILuwHdh1VvzjYvLOz5dbITxpJ3p1rC/U5i0pCl5TXJaaRL4iks9pkdRqS7egPGQmKx/o1ww==
X-Received: by 2002:a50:ea8d:: with SMTP id d13mr24273018edo.126.1545326409446;
        Thu, 20 Dec 2018 09:20:09 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 97sm6354355edq.45.2018.12.20.09.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:08 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v3 03/19] mailbox: bcm2835: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:46 +0100
Message-Id: <20181220172002.9016-4-thierry.reding@gmail.com>
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

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/bcm2835-mailbox.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
index bb3ee728169d..39761d190545 100644
--- a/drivers/mailbox/bcm2835-mailbox.c
+++ b/drivers/mailbox/bcm2835-mailbox.c
@@ -172,7 +172,7 @@ static int bcm2835_mbox_probe(struct platform_device *pdev)
 	if (!mbox->controller.chans)
 		return -ENOMEM;
 
-	ret = mbox_controller_register(&mbox->controller);
+	ret = devm_mbox_controller_register(dev, &mbox->controller);
 	if (ret)
 		return ret;
 
@@ -182,13 +182,6 @@ static int bcm2835_mbox_probe(struct platform_device *pdev)
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
@@ -201,7 +194,6 @@ static struct platform_driver bcm2835_mbox_driver = {
 		.of_match_table = bcm2835_mbox_of_match,
 	},
 	.probe		= bcm2835_mbox_probe,
-	.remove		= bcm2835_mbox_remove,
 };
 module_platform_driver(bcm2835_mbox_driver);
 
-- 
2.19.1

