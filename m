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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52949C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2324B2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az+Al7dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbeLQPDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35300 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387771AbeLQPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so11025593edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GnSN3Juamhrv0i4JSxRC4WDdcNirO6soHmRurA9jcM=;
        b=az+Al7dVl8OZD9cJH0v6r5W4bQ/yr17DTBE/NaK3SL4MZCZR6jkmgUpfj9uybHF/NT
         6jN6xjoJeReMOT3HdpNXyC75Wb2rzwPdS0oLqf2qhZf8M4MQN0yzKfixRsF+GL0wvJeo
         D5XmgX3en15o1Db7J5jlbFUHfmySTzU5Byc/DVxQhYbKIT27G5DTersKzdjSrFKrYBza
         VbTPxHTw+Hef+GRLxn8jguHSPLtbbh2DGfr+GCJzJ3e+f9vpFhWcWzaTKyZN3yAgNSiM
         yKUUSmIHZG/37dAe3MTbrBzxtKAPE6wLXF8nk1BsXCSDy9QYo7L7ymXHjol49HuihOgb
         d2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GnSN3Juamhrv0i4JSxRC4WDdcNirO6soHmRurA9jcM=;
        b=n6bODKRBS0cS85Ys1OYlIuzOkj16bg51G+LCesI6DJUaWokOeoVcFYTW4rESZHJS0F
         PNO5Dt22zXRn5Qw/p/kjTgOGXToLLnIuvhULq2mlqteF12Br782Y/n+d0KZ4S5WXfaP1
         2jqR4f0UrVOOmgk/yi+JvWfh73tgcgGaV/asrP0g5yWUfGnMAi8TZ5ts536YFa1dpNZu
         ciE6ixq/PRds/vQiANNZJnDCG1Sd9Xe57sJ681e/1VbRFiOsfYWIHPqrfcHBlchUHq6P
         O84JLv0nYMT4uxzWMDS/Bc9QV3rUtXoUX02aPU9U6O0e5VDuMybTeH6gphx8LOsPbFi7
         AY2Q==
X-Gm-Message-State: AA+aEWZxO+QZBq4DEqvlsYXRJhx92o5aIg/UT81TofIIDNhcipZF6KNp
        cweQsateoXHYnQ//lfM8L5g=
X-Google-Smtp-Source: AFSGD/X/gDcVhu/8WNkJP2gqddIT1gLMoJNGZ0ny9BILt11ia80aWKiJ22pxzFNYL4zjOx7Z5+7izw==
X-Received: by 2002:a17:906:1dd1:: with SMTP id v17-v6mr10536196ejh.148.1545058991901;
        Mon, 17 Dec 2018 07:03:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1896641ejm.15.2018.12.17.07.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:03:11 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH v2 18/19] mailbox: stm32-ipcc: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:16 +0100
Message-Id: <20181217150217.32435-19-thierry.reding@gmail.com>
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

Cc: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Ludovic Barre <ludovic.barre@st.com>
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

