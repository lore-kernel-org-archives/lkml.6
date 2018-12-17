Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B1A2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koPDE1dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbeLQPDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:03:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44930 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387771AbeLQPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:03:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so10980356edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kb1ONw/VBWCjH6WMyY0wKwigCD+4iKfVXK3FwoyHWPM=;
        b=koPDE1dSqp4NEegDkOGuDvVkyAuogUgPG1YWneLU3hGvQ67ATmP8/koKghRjSawUf3
         g6llpFIeCmzZoCJPSMGWUnD0ruaTZxd9/yK5TnXsvEreS2oHb2h+tnXiZsBBk/XjNOxE
         uyRxTQqGf9v8rk2SkeTvuNvMVXwrhxE7dlAEt8/Z37YUOXUs9SONEqGLTkv4uAKbyzi2
         n4yhBKF+s7/1flu5HDjOMVx3Sa8vOdEtlgZd6f9Dx5sClb/Vft5y4P9agt7Zk30gKFWk
         QQbGPHBwdXR2V1LwX5FigA1YjGzwnmEkDlIH21YW/JcRMdBqGAS8AvQNCgN7lbCrH1B9
         aQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kb1ONw/VBWCjH6WMyY0wKwigCD+4iKfVXK3FwoyHWPM=;
        b=f1RUinV/qBtkMS4moXIS8ad9Y0alrapm2fTVM1jRaTA4RIkBYiOoCJxTGRvfz2kYjX
         8gzPKCZCVPZZmnbC177y4oaCl/2+pY+86vLmn7qFiU/2HLaIxD/RUCFf9yx2BdNnp54C
         5aldqAc/kgOdTPk1mO/n6HbjPFnhyyxThP0BOZyz0Pc6cASn2hw7TSazGY0asOUEx/6/
         rwl30kC0YJwsPJ34njObMjODh5LIhEKmuAAQ8ezSp7lDnjvgg2IpjTJH3tbCohJQFVg5
         k3izSLqXpUTaIvI5izKDrHNy+6h//tVxzb3NSULWrivtOolo9wdPBdqUH9PmkeMUYHCy
         sO+w==
X-Gm-Message-State: AA+aEWZKAUcPE4NKFSsEyIWGQTVkKMvcefQ+g0QsCFCLHxwGnU7EeARv
        Esr1EYT0MaXNVr0JJXHbz4c=
X-Google-Smtp-Source: AFSGD/U/EAcG1PD1hiYboHsHnyflAaqkTgZBTATxd6ZJEEDmXSQ0SYXFCwwKyV0TDjmowwzFzKHjvQ==
X-Received: by 2002:a50:8eea:: with SMTP id x39mr12896735edx.177.1545058997207;
        Mon, 17 Dec 2018 07:03:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id n10sm3840686edq.33.2018.12.17.07.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:03:13 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 19/19] mailbox: ti-msgmgr: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:17 +0100
Message-Id: <20181217150217.32435-20-thierry.reding@gmail.com>
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

Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/ti-msgmgr.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 6f6addd51d14..88047d835211 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -817,26 +817,15 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 	mbox->of_xlate = ti_msgmgr_of_xlate;
 
 	platform_set_drvdata(pdev, inst);
-	ret = mbox_controller_register(mbox);
+	ret = devm_mbox_controller_register(dev, mbox);
 	if (ret)
 		dev_err(dev, "Failed to register mbox_controller(%d)\n", ret);
 
 	return ret;
 }
 
-static int ti_msgmgr_remove(struct platform_device *pdev)
-{
-	struct ti_msgmgr_inst *inst;
-
-	inst = platform_get_drvdata(pdev);
-	mbox_controller_unregister(&inst->mbox);
-
-	return 0;
-}
-
 static struct platform_driver ti_msgmgr_driver = {
 	.probe = ti_msgmgr_probe,
-	.remove = ti_msgmgr_remove,
 	.driver = {
 		   .name = "ti-msgmgr",
 		   .of_match_table = of_match_ptr(ti_msgmgr_of_match),
-- 
2.19.1

