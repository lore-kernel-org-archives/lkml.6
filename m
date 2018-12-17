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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85814C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bukem4ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbeLQPDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39740 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733222AbeLQPDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so10996574edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFd7URq0llOGke76fCy+2bqc7mubARIMKrmA5Dkc37o=;
        b=Bukem4icLQvt/EAhklo+J6GlxGB/wTn6rAoJBhYOXprIOyNSzzTvExDh6dhzl3AL/2
         cE59A2C6/IMTairvDbb/hvUxL8+S4b21J6bVokTtOd6yAcXXoAAvm4PClPacP65OGQlS
         0TjNXaZCQMWpsc1IlIVktzkDO1JmNdEGJdAa5ePrflXfFogEBVOn9mShQbb2AbJn1IZj
         0qunrWuYkKH/kzpm2oYpvN2bCWKr9GpprQCYW5Te+oKorXdv3RnYZxNvAfQG5z5451g9
         BONFHQLJU2NsqkilneRdSQ0zEjul8XuPZqaSupww6CCg6y5/AvF2skiJhss0etZ0TWuF
         LzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFd7URq0llOGke76fCy+2bqc7mubARIMKrmA5Dkc37o=;
        b=pKr1onMVoXfUkb3IFkiNwtQhd1e0gb8YU3e4KhTzNl95RBkhL93aNaZvHXYutmB0Xa
         RF0wq4Z2SpZB3iVgawjnLVHkIOgZDE/eWChagPRpHm0AIGzAp7Gn84R3PhMbLlYnz8HM
         9QpZVFXSBg1MjCJadLJi0bE12nN8H0jtKIDy6x5QAlJZSCNgEgxB6KxEWt6aFeVpI6QK
         BleII714dJ0LXoxDgQBCMiebi1gBAgOqE8jAYguvJHLzJ7SplxGv99P32hAu1isu3LvI
         gWtMxxN4tY6SUx0PPGVNjMIoDO7uhStweSGeG/U9pythBvECZRwVHdna3DBHupzni9+4
         5Lhw==
X-Gm-Message-State: AA+aEWZUcNx0I4WfmitHRvR/pqiszHZTijVi3fyp3mLVbq1O4CnqRl4n
        vNVWKXVPgiUB5WCWerYH7Jg=
X-Google-Smtp-Source: AFSGD/Wkf6NVegW7bhEiU1fpX89IqTq/LBMJF0ZqUXp/mzx2oRVjxQ3k/vZScETF9nfO27+Ev+9Gwg==
X-Received: by 2002:a50:f19b:: with SMTP id x27mr13486623edl.140.1545058990104;
        Mon, 17 Dec 2018 07:03:10 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id o6-v6sm678996ejs.32.2018.12.17.07.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:03:08 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 17/19] mailbox: rockchip: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:15 +0100
Message-Id: <20181217150217.32435-18-thierry.reding@gmail.com>
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

Cc: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/rockchip-mailbox.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index d702a204f5c1..f24a77b1a0ff 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -247,28 +247,15 @@ static int rockchip_mbox_probe(struct platform_device *pdev)
 		mb->chans[i].msg = NULL;
 	}
 
-	ret = mbox_controller_register(&mb->mbox);
+	ret = devm_mbox_controller_register(&pdev->dev, &mb->mbox);
 	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to register mailbox: %d\n", ret);
 
 	return ret;
 }
 
-static int rockchip_mbox_remove(struct platform_device *pdev)
-{
-	struct rockchip_mbox *mb = platform_get_drvdata(pdev);
-
-	if (!mb)
-		return -EINVAL;
-
-	mbox_controller_unregister(&mb->mbox);
-
-	return 0;
-}
-
 static struct platform_driver rockchip_mbox_driver = {
 	.probe	= rockchip_mbox_probe,
-	.remove	= rockchip_mbox_remove,
 	.driver = {
 		.name = "rockchip-mailbox",
 		.of_match_table = of_match_ptr(rockchip_mbox_of_match),
-- 
2.19.1

