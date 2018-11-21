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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D580E2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9y6SnmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D580E2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbeKVB3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42224 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbeKVB3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so5102256edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDKxi01t5e8VWtbwcHz6I82SRccgYuDoZRYkHOFG0TA=;
        b=I9y6SnmPp2gFaJHbxxSEFdWQNAJ2GBwk5sLhuGolYxRjryal7ixFHj2w7izUbEDiQ5
         WCM8+wyHayk/ykbTaZd/iZaNrA3WgsxO0ehcV5MLkNhYVam1LcwMjgnxG2vZ6SsMcUcv
         LcXreSYRcsy3qhMUFlnqRoksst0r42oFuQem9Klr69eG9eZxErsnwl9qtInAUIq/Ru0r
         8aHY1slz4lRXDUWWmPkDJy5hrfOjKgOF6iqGNC+3Gfiswrj/EYGkXrfNnn4jsdvDRpC8
         rtl1U/zkFE17GkKa9FKZSKYXTFnuYmQwKgkOJqK40ytlWIkSEa0EOOfalKioKz0lJXql
         /Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDKxi01t5e8VWtbwcHz6I82SRccgYuDoZRYkHOFG0TA=;
        b=hHUEqNo3p9I5bN2sW1w9CmIB48FJ+xMBkXXj6WUbNA0vPq1pU2pOlA4kdjcH3yioTO
         a9BU4tt1m1VelNatDqxqsFM3UeQ/UPbRwuz8IpvXjCg8vtLse6RvU5gPrjM1xZN+gEzW
         H8yd0aUDKWdJCe/bAjgc77NIbXx/LH0XR12Grba7GFj75ClwgGjNo2z9HZvt+F/DJEUg
         PXNs8xsGnbOfKIlADW7A93XqOxdTtzdRETpDy1B/qwipX56TAPuPDMyuj4z/5wgIGVPc
         qpsTEZs7laRc6hXFtTHDPTSnXIulr9CprZhII2liz/qXHiJ50kj2jD9Hm4wezZEuU8n0
         Tj9w==
X-Gm-Message-State: AA+aEWY+zXAjx8pMbuO+k+j9m8bBFzwPx/xVsA3ArgL2/g6fWMtstu+h
        AJxytJuO/p0aypSK8rBpT0Ntpuq8
X-Google-Smtp-Source: AFSGD/XuGhqxOG31vyHSMq6h1JCrXd7zHfgHw8xJXRg0AVA9yJMIKwpIK7M7zn/nERdS9ifpVxsh/w==
X-Received: by 2002:a50:c19a:: with SMTP id m26-v6mr6207118edf.82.1542812098127;
        Wed, 21 Nov 2018 06:54:58 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id c2sm13146625edv.14.2018.11.21.06.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:57 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] mailbox: stm32-ipcc: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:28 +0100
Message-Id: <20181121145429.7582-19-thierry.reding@gmail.com>
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
 drivers/mailbox/stm32-ipcc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 533b0da5235d..a338bd4cd7db 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -299,7 +299,7 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	for (i = 0; i < ipcc->controller.num_chans; i++)
 		ipcc->controller.chans[i].con_priv = (void *)i;
 
-	ret = mbox_controller_register(&ipcc->controller);
+	ret = devm_mbox_controller_register(dev, &ipcc->controller);
 	if (ret)
 		goto err_irq_wkp;
 
@@ -329,8 +329,6 @@ static int stm32_ipcc_remove(struct platform_device *pdev)
 {
 	struct stm32_ipcc *ipcc = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&ipcc->controller);
-
 	if (ipcc->wkp)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
-- 
2.19.1

