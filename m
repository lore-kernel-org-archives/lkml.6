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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D060EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17C220874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buL9hPQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbeLQPCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33098 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387585AbeLQPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so11035776eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuTpf7jikp6/3iY/QtfEXR/DYPeehEWpbbHidZ8sTR0=;
        b=buL9hPQJJIRW1+zzxTZJCPjZ+KHNN9v5q/1+gfOI1G64gQrQfs57+oRv0s3mMfV2WB
         PFX8hnCQeRREQoWWp9jWdUi/MI8hLYn/HQHlTS+w/NJ9eu8xH58E2Ozv/4f7FXkqSgYZ
         9j952PIqfPOb14D8Q5XbkPvrMH848VBiIVL143JlLeVSXwP+r7SXqvvp0LFjKmtLkpEe
         b88YLYW7v0KjCOR0QAZCTrlVswhWf5IVJFaLrn0KyCQq5TJwgo/Nhdk0bUT38gcQzzlS
         KxY3ZPyNlcVoah584fO3+QFQavFgB8CDE5DS4yrDIk0aJq+/veU7dx1yhDqL5W5g3+/f
         Uv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuTpf7jikp6/3iY/QtfEXR/DYPeehEWpbbHidZ8sTR0=;
        b=K4lN91t8VLQ6JjL6iZtJAEGSh3uaUbRvX6cKZVqtn/H4yN5U0nv5qHKqy/stLnsbmd
         SfaG2f54j88sQfuIxBtrR+c5nYxxELYLOqxzSZiBGU2H3C99/ekVmroBFP7vieugORn2
         oPQ6jPMiG9xt2cZ9yaJUteKRZNl1fGxgGQofs8Few7Y9zEqfhV1Ojn6wQmsY62UMRS2C
         GspFjBdRKt7yxuYKhy3LvxpeGN5eSijOOEvOUexwHGtmP83GOk0O76vdbVMmKgjO67L2
         VvbnmoGwiJq2ZOPGWLWKp645ZuUEilbT+zt4qn/4aRss0gG/Z1XX1nUsqQFzXgjghpHU
         osQA==
X-Gm-Message-State: AA+aEWbYYSV7rqwJ79U+YFvhS+fxxWaOiXCjs9EvabMMpImhbwp4PKU3
        cPsuy+xwtfic4wN6xme8FTThRhLa
X-Google-Smtp-Source: AFSGD/XjIJbnVOIumON3uwtRplNq3PLVV5mraFqVMLMOyb1NiKrPtBL9gPnUJRzVJ7Ykh/TtG4TYEQ==
X-Received: by 2002:a50:b32f:: with SMTP id q44mr4472611edd.70.1545058947320;
        Mon, 17 Dec 2018 07:02:27 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id q10-v6sm1004537eju.47.2018.12.17.07.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:26 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Anup Patel <anup.patel@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 04/19] mailbox: bcm-flexrm: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:02 +0100
Message-Id: <20181217150217.32435-5-thierry.reding@gmail.com>
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

Cc: Vikram Prakash <vikram.prakash@broadcom.com>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Anup Patel <anup.patel@broadcom.com>
Cc: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index d7a8ed7d8097..d713271ebf7c 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1665,7 +1665,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		mbox->controller.chans[index].con_priv = &mbox->rings[index];
 
 	/* Register mailbox controller */
-	ret = mbox_controller_register(&mbox->controller);
+	ret = devm_mbox_controller_register(dev, &mbox->controller);
 	if (ret)
 		goto fail_free_debugfs_root;
 
@@ -1691,8 +1691,6 @@ static int flexrm_mbox_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&mbox->controller);
-
 	debugfs_remove_recursive(mbox->root);
 
 	platform_msi_domain_free_irqs(dev);
-- 
2.19.1

