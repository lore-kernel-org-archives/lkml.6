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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C34C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BD021473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsaqX3qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbeLQPDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40216 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387750AbeLQPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so4960718edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AT8fPMa+Pc/4P8sCqJQJrVkSzyJBkjPCLKKsENG0o9g=;
        b=BsaqX3qc4Qjpmvu1xGqSPG47SxNlrZ5Y3+DiVYvYY3F1xDc0ANlQI2eLjFX+A2NCRj
         d4UxGp0U02/odJQSDscMaWh1mzn2IgS9boL2KPnaPUeS1toe6zCj5KrkcvxcJzqFU7nC
         KU12Nc9k80pqbUvXz3GIJqFnAN+OtOcU5vdwYas9WecNoghruD/1kVPCoUcUH5dPWWdT
         Fb6MJOQAvb7mpc/pUawo3Wn0+SjzMliwHgqVvUZedgpgWFYIf5fGb+av7GytOPmwCrbh
         OZ9SiGTFM0QuHIo8IFZIyVfi2espg6tqrJbOwuSr1azjdRcFkIz0mbBHZwtGxxDoYWzk
         n5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AT8fPMa+Pc/4P8sCqJQJrVkSzyJBkjPCLKKsENG0o9g=;
        b=AOy9Nw5xt4Oru6s5YxHtYlYKIWVlJAvgwxva+tbKUTuCqGhbE0kFe0HpoMmAIjDdYw
         RHiQeCWLQE1NM6nxiSRmoU8Ad2z2QhrCibaJ6MY2TAn/cnQ/hIODK9JlGmsUoEsZ1q9R
         4otaB46MXX5v9BTymnahLZ1K4NKQ8WPEoDy916KuYY6kiqSPAvzUBxsD7+t55xtgw0kS
         pGT2YkJQ7IuUOMceyDDMCrja4w+cfCAhUz82ZfR0G8jzXQsEzDSJCfj6ASTnhPVUUpsC
         nfavBcxIbYKaRxvuh/BMb+hLvndqzJzEA3bMfouH/TEEaIFyCoBp2HkkszPI1FhRnVE9
         /TeA==
X-Gm-Message-State: AA+aEWbAyTe+Hu0f505lzQcbbByCQ92nJcQ4QcSolXLP17DjVXpIir/v
        dEiIZUyf6SL17P9LVFa84cs=
X-Google-Smtp-Source: AFSGD/WUDHRyHu/8yFm3XyExHGbEU5IMJCvY9LHE9TrOduX4cz77xxbB7pm2tLZNjZUhCUTeSZRyvw==
X-Received: by 2002:a50:de49:: with SMTP id a9mr13419747edl.18.1545058987524;
        Mon, 17 Dec 2018 07:03:07 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s3sm3865804eda.69.2018.12.17.07.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:03:05 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 16/19] mailbox: qcom-apcs: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:14 +0100
Message-Id: <20181217150217.32435-17-thierry.reding@gmail.com>
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

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index aed23ac9550d..3cf2937be149 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -91,7 +91,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	apcs->mbox.chans = apcs->mbox_chans;
 	apcs->mbox.num_chans = ARRAY_SIZE(apcs->mbox_chans);
 
-	ret = mbox_controller_register(&apcs->mbox);
+	ret = devm_mbox_controller_register(&pdev->dev, &apcs->mbox);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register APCS IPC controller\n");
 		return ret;
@@ -115,7 +115,6 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 	struct qcom_apcs_ipc *apcs = platform_get_drvdata(pdev);
 	struct platform_device *clk = apcs->clk;
 
-	mbox_controller_unregister(&apcs->mbox);
 	platform_device_unregister(clk);
 
 	return 0;
-- 
2.19.1

