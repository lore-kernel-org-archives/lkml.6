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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC698C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918B22145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNK9vGXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbeLQPCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35241 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbeLQPCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:43 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so11023901edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LzDGaOZmIC9BOg/YRP3H7aJ4/OY1zEEka7OyXwNmg4=;
        b=cNK9vGXIyYuije9Xj+KZYdR58PFDLWF5pIYiMU3ZoHD3e9xOaAhEVEnGQ+GjA0PKJR
         5tWMEfrVuP3xtnmRr4b2mTb5wkFsTFieZccyZ/6q65K+TgO6L9xh8jK72/GYvUfIVQYK
         KikhBiLDrwdHicGa9jWpOeK3Ep56BeBtKfl8IN0QHAG4msiIx52ALWrkDlgUOSCnSM4g
         uBmDpzAg3AbUfx0FnE1kwx2D1jiXQjz1sCLs+/7HuhiHy71KUBFyfH/2hfkBWntPrOai
         fHGwlCJRVlZ+9VBuBK7yELuTIxCvGY/amXkcPrwirIidF0n9QHTVEIi7dOQl8iUrqLcs
         dDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LzDGaOZmIC9BOg/YRP3H7aJ4/OY1zEEka7OyXwNmg4=;
        b=jHO96gspCAUWb8R8ySXRntxiMgx2l/X5dA8IpXEug8St0YTSM9ivjlYfGFVIFsVcWl
         6Wu/7NJySZJvrVyEa8Jp+/l/2QNWKfMJJqPk9EHQkP43roJ7V7jalTW3dO0Z9nVk/Okr
         Z/DXTQcX2ZztmODF1LDJsWYVp/uGkz9JSgkvyWUg0mVu6ZziUnzJdVEFCpAvLXugJx00
         EpLUN1JOojdFJLb6JfnbLIbNOCSiU0WIgmRuQZ3oRm90BF+HLt2Mlx5c1KqyNqv25woO
         0m3SSeWeT+S3NwmcU5Kj4/EavNhdqrc4oMjgsKMd40Px6GCwsYvK90c8nCFDPH4fTl1b
         s2Zw==
X-Gm-Message-State: AA+aEWZiC4i2oCne+zyLgTheqNNioqaU7Sl2zzUEgr7VyopLgrLFTqBl
        N6RuNz7VQWmptqrOimCXPUU=
X-Google-Smtp-Source: AFSGD/WPpCyBy6x2b2/S0SsHQKvcymz4VdiPgyQvoT6cGARJe41toST3be8tdgA4I/pNAY0RpT7zBg==
X-Received: by 2002:a50:ae64:: with SMTP id c91mr13060996edd.222.1545058961810;
        Mon, 17 Dec 2018 07:02:41 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id g40sm3773415edg.39.2018.12.17.07.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:40 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 08/19] mailbox: imx: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:06 +0100
Message-Id: <20181217150217.32435-9-thierry.reding@gmail.com>
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

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/imx-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 363d35d5e49d..774362a05159 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -324,14 +324,13 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	imx_mu_init_generic(priv);
 
-	return mbox_controller_register(&priv->mbox);
+	return devm_mbox_controller_register(dev, &priv->mbox);
 }
 
 static int imx_mu_remove(struct platform_device *pdev)
 {
 	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&priv->mbox);
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
-- 
2.19.1

