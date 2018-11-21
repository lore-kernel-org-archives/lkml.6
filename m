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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FEDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8D52151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxgforc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8D52151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeKVB31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39306 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbeKVB30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so5114306edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VM/n80F2UYINX5CIatmOeKqNxQPr9qlIU5iLYCtUgE=;
        b=bxgforc7JRkqYTUDxgRmMlECSsvge0tf1NR/S1H+xyXeYP7nV6upUXzk2yIXTOQP9T
         CTS6qM8ho7ohF8Vv0uCteVL+3rOwkkZlRv73j/Je/0cYF+6bCH2bwYQBlHInkEaIuhi5
         lbOyWxWZDp0KSvLvgYWfFk9Ia4AWmzVVKErxVGqtg3E86kFRWdEAn9Ec3MtzSxrX+lIs
         WUHd2PD4LSajsEJlT/qvFxC5kc2OHpU9F+YZ5qq2Fd8/M5oMYfI0hScio3syUwjqWVQL
         +ar7cU1UR1nTOTNctLXN2bMqmdZ3ak90D38WbGxqwhbsuksZnY1u33cbsfMobMbXtDgd
         bCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VM/n80F2UYINX5CIatmOeKqNxQPr9qlIU5iLYCtUgE=;
        b=HMUMgh2brqbkDdduB0TkDpqyPeNozJLT9jLyxzXUKu3WROmDlmJdGUfd8Ohx9UYyCX
         5Q/99BgJPf/v1pmPNQz0NYPVL+eHvuID2vguNByXP0yayaAb4ELD71mHrYfFq++AT3jV
         lSoDhv/+Gme1ImTZM+79vEJSDiZoYW3MLzYmxhveK1Cwg1kIsYx1NtN+fVYSvu35DyjP
         boPsPmhyLzCrc/iiolqqwNjlMi0zRqmz50aGTF7HxupXONktKlfPxXq9My5cqwh4EhUN
         EBs1gikH7UtPI2UDciFTxOZLxRZ6lII9EQXsxC+RWEO/6GaRcOxMLhViIT9o0thZcX1s
         g8Xw==
X-Gm-Message-State: AA+aEWZzCahr5b01MUSQwXDqmfZ7NneGpAMgLdRLZaH4eW235luazmKO
        dULg0MesFWc/flUQ+EDYCXc=
X-Google-Smtp-Source: AFSGD/UjAbDSD272daMUOYDUxQSMCEZv4bPZapIpHqVMUd5aNHS+uU/fabVsalXQsB2ap82If5z9mw==
X-Received: by 2002:a50:fe15:: with SMTP id f21mr5700379edt.116.1542812080024;
        Wed, 21 Nov 2018 06:54:40 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id s46sm5022239edd.9.2018.11.21.06.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:39 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] mailbox: hi3660: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:16 +0100
Message-Id: <20181121145429.7582-7-thierry.reding@gmail.com>
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
 drivers/mailbox/hi3660-mailbox.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index 3eea6b642484..17ccf69c4f4f 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -267,7 +267,7 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
 	for (ch = 0; ch < MBOX_CHAN_MAX; ch++)
 		chan[ch].con_priv = (void *)ch;
 
-	err = mbox_controller_register(&mbox->controller);
+	err = devm_mbox_controller_register(dev, &mbox->controller);
 	if (err) {
 		dev_err(dev, "Failed to register mailbox %d\n", err);
 		return err;
@@ -278,17 +278,8 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi3660_mbox_remove(struct platform_device *pdev)
-{
-	struct hi3660_mbox *mbox = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(&mbox->controller);
-	return 0;
-}
-
 static struct platform_driver hi3660_mbox_driver = {
 	.probe  = hi3660_mbox_probe,
-	.remove = hi3660_mbox_remove,
 	.driver = {
 		.name = "hi3660-mbox",
 		.of_match_table = hi3660_mbox_of_match,
-- 
2.19.1

