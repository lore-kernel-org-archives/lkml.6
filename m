Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7AB217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut5PbKH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbeLTRUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40060 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387816AbeLTRUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so2392057edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUC4N4hBsBCybgHnPVn0KXU+VNJl5CqmJRaVpTSN40k=;
        b=Ut5PbKH0u+8AumZu7Gghcg5k+vqabA9FZhK9jC8ix71y2zzaIuqRCV7mHDWUaqhVmt
         VV+4mj0B5/SvW2uGUZTmJkV0+3aziJIuEVIax84/Lq/QEq1FvGO96HaEg/rfd+60rn/7
         vWPGSNFkJcjGk+Ncn7pBCd1T7wlxoziKR/MU1Ymcz+qtLP7o8M2fz0n+gzySXcsgXbjd
         WS3D3xjUPNXMq9UlsyTsOx2RF3wOUzoMolgTs7nrJMJ0fWj45K4cNxPcBNd5ZqqYhZ3z
         ySiYKaNX8M0MyuY1IjOVDhL3icG5CZ0puoZYeeNoMuYMwFfN05yP7JsMSz9rzMAItuHk
         8LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUC4N4hBsBCybgHnPVn0KXU+VNJl5CqmJRaVpTSN40k=;
        b=jcwhLwVFYlNYy90VKQpFQEQt4SV83waPOV+gL+h/P69LCYhmMaQSO52dNgIKGwcubi
         kO/LawSj7mD1OrA6fOaoXxmyZHMoVBncsgIWReODZcYS6B/Q+RggUBQHVBMUAVG6p6Gf
         NS1rVrHsWuCcbruP63z9U3ueT7rpToKSwZM1AQEBnCPVVBm7ndd0OtjCp6oDHm/tQqKT
         CBBlTjlpzDeVEK2/jCDKD2u15fZuiilLhcEyOlhWX9iW0j02JfhPV6lN/ZOlnRlczfKb
         TEs8WVMUwZtpUHyNHtpi0Y01EGQBmHzp8tZl2M6UZLpC65kc/0VyicWdljRSGjQyWUWf
         SLSA==
X-Gm-Message-State: AA+aEWY8ma1Wshdf/v58O3ZbH3TH+oB67YiWChY0FiCHDxYhy9hroWwW
        zQBLfpkFMMhzz8qllHitfIA=
X-Google-Smtp-Source: AFSGD/VFK4WbvhNW9mDRRX3vQIuN/HOSffB4F/aU8New2zzbVHLRufn6fygMOA+g4Ez5e5uvhD3wzQ==
X-Received: by 2002:a17:906:8242:: with SMTP id f2-v6mr20266567ejx.125.1545326414204;
        Thu, 20 Dec 2018 09:20:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w10sm6261555eda.77.2018.12.20.09.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:13 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 06/19] mailbox: hi3660: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:49 +0100
Message-Id: <20181220172002.9016-7-thierry.reding@gmail.com>
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

Cc: Kevin Wangtao <kevin.wangtao@hisilicon.com>
Cc: Kaihua Zhong <zhongkaihua@huawei.com>
Cc: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/hi3660-mailbox.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index f9aed5d8f9f1..53f4bc2488c5 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -265,7 +265,7 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
 	for (ch = 0; ch < MBOX_CHAN_MAX; ch++)
 		chan[ch].con_priv = (void *)ch;
 
-	err = mbox_controller_register(&mbox->controller);
+	err = devm_mbox_controller_register(dev, &mbox->controller);
 	if (err) {
 		dev_err(dev, "Failed to register mailbox %d\n", err);
 		return err;
@@ -276,17 +276,8 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
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

