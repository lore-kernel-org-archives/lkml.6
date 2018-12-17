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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3725E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgNrwO/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbeLQPC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:58 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33137 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbeLQPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so11037119eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1IuluRVsrA/thWWKsP6WmiXoXw4TYsiV79YbWUKBM3c=;
        b=KgNrwO/4kcN5pAroqaykups8LzZgz+nZ/2UkFVSrxUC+YJqrEoXsYccLCB/UO8Q1Qd
         cruQO93H8s0LxZO5Js4conDa4EVwF8IOZ/N5+ggFHU0ZBqodZ62hJrkUzj1mG0DElH/j
         aeY2rbui4081p0okFJBXKfzFxQPKLCU31lyZVb9jy/BPqDPJ2Kcvo6Fr7N7oEefPnsim
         va5fzYF53jshbswIzq7xm0bGvjpREXPppGjaPomjlqn8CbqmYhYJ06gj7Jp+IJG3YK3/
         ZEYm3eJXuZCXykEjJ+zULRvdNVSiPY17LrCS8M360SLXBY7jFKKBAI8yx9Rzgfgs4ZZW
         4taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IuluRVsrA/thWWKsP6WmiXoXw4TYsiV79YbWUKBM3c=;
        b=TkpuWf0n073qOczQ13dwy1jWyLQdeSUSrc0847zq3dOIXLnLEJ0P4u+yX0WmnKt0Zz
         H74TNvTyxkKRGY4ERFgYa/qroGoJK+WSm91Fc0nG0KqYg1CYowIbS/RBTDetNfgiwyad
         8eeZ/t0erT3gJKPVWzuq/QojZjbQSI3cFXP1fDpw0eR6MUdON8/qdv+RzIQA/2lVKp2v
         aDgIwB70Q9I1HqvpFDccBMTOMoWTiYT1/WYCljD9lenyxnZbClhN9JJziuiCepHC4MpH
         AZeNz+P2QPya/1WaCNO9Z7qO3dfvjUP8Jyw30kTJQQ6Umvg7KoaxmlHJtRr0A7Juj4Rd
         e2DA==
X-Gm-Message-State: AA+aEWZ/1T/UWKQ+a5xId3M9NCWt5etQMsLj70PK23dz8pptIu6FvRjP
        6vasyqreIuAh5+qFqgdNAV4=
X-Google-Smtp-Source: AFSGD/U0KQr0fNCqhAQLbYNJm7wj5EJBN0FLsbcNfINhzOo87cF0xbsY/Vh+9ywsVrc15lamSNevxg==
X-Received: by 2002:a50:c408:: with SMTP id v8mr6086986edf.144.1545058973697;
        Mon, 17 Dec 2018 07:02:53 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 97sm3839350edq.45.2018.12.17.07.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:48 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 10/19] mailbox: sti: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:08 +0100
Message-Id: <20181217150217.32435-11-thierry.reding@gmail.com>
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

Cc: Lee Jones <lee.jones@linaro.org>
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

