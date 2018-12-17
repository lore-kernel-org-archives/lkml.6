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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3631420874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqvr57Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbeLQPC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41872 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbeLQPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so4393217edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFN14XEDZDFuhxnZbhaQWhQWZCH4V9KCF1XiVLIaRUU=;
        b=Iqvr57FnpW8IT2nxivRGIRE5JxJL7UlN+q3cNlyeD1V3AQdp0FHBMEhMzAVr2Mq0tG
         PAtbDqb6hTGCWt66VHWOemMTKC9CRQcRWNx7utMMJ+LUNdbEqyco1RMKWncWHLyAmpDX
         7gQqh6grVTnmrU6Gf5Rk/Hvcwh7wejRgDL8+pX+YNEhdy69BDnbfqRkNivBnGbgmABPH
         UT27tqG2t+wWZI9YcztcYVySg0/anMiThXKP6pNdLzfEX9evu17TcWheP/6niNn9oQU7
         l+3ziMPkGXkGwIRfrbYMsW6UxQ8CwHJL6mrnVG0oqPCt7qsoB8dxhS3orkYDAwd4OXPH
         GMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFN14XEDZDFuhxnZbhaQWhQWZCH4V9KCF1XiVLIaRUU=;
        b=nQ5vdsL8jlrmPqz5U/GULmyKBQiFkBtjm733eXSJvwBUc04cWaBCDb8ep1Y1AZ3iQl
         GxUnVO/cs0PkQ7zOG7X7DgrbuVD0yUukZ+raxyet0bp4GRQBrU+7hAlpfJy+/fOOGZv6
         YN6Hbz22SwnOlf7qvOApUJ0g9jm+gEEx1DMMq8ayK+HaVXEkauubr9loSRWsoUcAqcpc
         Pb7ejkAorK64pT0N5NXzXwQaiOb10GchaPnY7FXTnXd/i30jYjctYurusEiNToJXOgD7
         VtiSW/pULnJ/WrAwD99XCEsxPJSsCFD2uKJr3BDaBV+wX2jGErD7Cghjm72awqqSivN+
         Urrg==
X-Gm-Message-State: AA+aEWaKem3hV7pVggSRuzVbqzTZy+oqlQRH/SYdTiG2gXL44H7uVmdq
        KqnLvG6iouchvPwJtG5rzsk=
X-Google-Smtp-Source: AFSGD/XtjN9ifrNKTkzftH2iSjE8SRTtA35VFN6cHlZ36Ikhy3U01H0k7RCvDXIg3gmj0MYLbo6mOQ==
X-Received: by 2002:a50:86c2:: with SMTP id 2mr13168064edu.34.1545058945352;
        Mon, 17 Dec 2018 07:02:25 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e35sm3904958eda.13.2018.12.17.07.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:24 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v2 03/19] mailbox: bcm2835: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:01 +0100
Message-Id: <20181217150217.32435-4-thierry.reding@gmail.com>
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

Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
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

