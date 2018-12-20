Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA11EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F88217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ1BR/AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbeLTRVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:21:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40084 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbeLTRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so2392647edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/kPgrFxRe9kUUhR6JvSGe7kcKeba4lxi/88gm/plt0=;
        b=CJ1BR/AO0ih1f+DP+DfQFXhHrbg92p0RLKThfHhu6dLQAMfBjW3Vyl0Z8fFiI7d5hs
         TNLtOan3SCv5wDNv1ieQlt+YZ5HhvMw3d4gS+RP2wyFgQGSIfvgSqW00fHisVTrjyGN0
         aoq+lBAaJFjT+sfYfjSTMi1YLhelF7Kq0cNal1oZpHCyZDGtQrqKzPDKwLdm/rfdcH/F
         HA8vvrzKV988ZXIExyywhUt6WtnMY5WFP2Uj0TxmUft4pOuRoOX2/eGxRZl8sHmOwRg3
         xkFVBOMAyq1lhbiFTMTKyMt0hfYlnfuE2Y4L2bG4zqmQ+7v1zbBCA/fi2Skxcp2r3LzI
         5Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/kPgrFxRe9kUUhR6JvSGe7kcKeba4lxi/88gm/plt0=;
        b=Dwm4ALLPFULzYo5Q4vVK/JLs1B86eKSJob4pjoeTti50z0bzLoGwoi9b3L+dIhpo2T
         /xVL0zvNf92vTJ4yiqqlhQ15BHxKSGAJiRIIMG6t7IYPEvC0FYeljhX8msqp39uNJCnY
         GqtnweOWQh1Bv4uWNUPoIzjkxMVeyGkcdKIDE9gRMRC7uZmxLOCBUkIDXeJ4xS/gpLv/
         Otclkql3zH9YCYVeJ9/VU0mqAtI3gzrLz/L5vJ28wFOZ+/trJNWqP92NBV0GSHvqxLdg
         UhLvFH7QIjlZv+HCw4HcGI7teOWW+xINMq4sKSls7/aCwb/1JpWzER8dEd46lNZrpUB5
         NcbQ==
X-Gm-Message-State: AA+aEWY9pkzBjVGY41E1M6uByrrFS0FIAvmJk6t1VyRQi4Th/VtT/ykg
        paCs3DJYmDX5IRSS44luUsg=
X-Google-Smtp-Source: AFSGD/WVr0qTwXjv91Lw+hg1dTzHEI1JLspKIuP1k9mJ1e/5nf7NkpanIx5l+HOXzXdHeDMtsT42KQ==
X-Received: by 2002:a50:924e:: with SMTP id j14mr24702381eda.142.1545326427886;
        Thu, 20 Dec 2018 09:20:27 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id e53sm6296661ede.90.2018.12.20.09.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:27 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 15/19] mailbox: platform-mhu: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:58 +0100
Message-Id: <20181220172002.9016-16-thierry.reding@gmail.com>
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

Cc: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/platform_mhu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
index e13201a5cec6..d2502c5be130 100644
--- a/drivers/mailbox/platform_mhu.c
+++ b/drivers/mailbox/platform_mhu.c
@@ -163,7 +163,7 @@ static int platform_mhu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mhu);
 
-	err = mbox_controller_register(&mhu->mbox);
+	err = devm_mbox_controller_register(dev, &mhu->mbox);
 	if (err) {
 		dev_err(dev, "Failed to register mailboxes %d\n", err);
 		return err;
@@ -173,15 +173,6 @@ static int platform_mhu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int platform_mhu_remove(struct platform_device *pdev)
-{
-	struct platform_mhu *mhu = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(&mhu->mbox);
-
-	return 0;
-}
-
 static const struct of_device_id platform_mhu_dt_ids[] = {
 	{ .compatible = "amlogic,meson-gxbb-mhu", },
 	{ /* sentinel */ },
@@ -190,7 +181,6 @@ MODULE_DEVICE_TABLE(of, platform_mhu_dt_ids);
 
 static struct platform_driver platform_mhu_driver = {
 	.probe	= platform_mhu_probe,
-	.remove	= platform_mhu_remove,
 	.driver = {
 		.name = "platform-mhu",
 		.of_match_table	= platform_mhu_dt_ids,
-- 
2.19.1

