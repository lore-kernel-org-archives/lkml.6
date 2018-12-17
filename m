Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E43C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4667920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4uLftQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbeLQPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:04:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42212 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbeLQPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so4863719edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c64JU9MvidVPDFDYNeElkdLKByLupaWXGImYY9YcBxc=;
        b=K4uLftQhNasIyFPtH3dGCGPRDxY99YHxEoKv2RJURxoPrme5Cgmj7XWYW3sVr5qiVG
         OAz1N2xbHsJxG6kCHecfKRALAQsc06QCoIKaUiqtNe9ApCFL82KMHHrpDiyhVrmjAQdA
         Wo+QB3qOPiBSGNT4nFaTHrD09V/vGOINNXGWXiJWun+138KmhfOJlNGovSdf1n+/HKFR
         3l2XTPz0+nvrtzXghAtvwakx5zTRIWxePFaqR9+/aJINHO+kZ53DnNT47Gw9DpubNwnT
         TjzAv4ITH6xg57i1OpbuwoVyKhTMDF8SC+qxzMWMCGJ6vbGCSLZoXr78qKcjvhImPlgR
         0SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c64JU9MvidVPDFDYNeElkdLKByLupaWXGImYY9YcBxc=;
        b=X7Q1WhkziYkh+zhngf+OV+lCFBEKSBIUFMJJVMsUhOKJzoX4+x5w+zzo4wkLw7PkUi
         Rub4YVdjRfI/NO1e4O2OpFlYs3FK1yNnXs8X57WES9O1HNMAb2GcVdH5DN5SwAfrhSV5
         Hxu+ewvs5GHl1E4w6JSn+wxuieNCR4J62GIqxmExNlo2m4Odz9rgAWDkGE0dfqqJRFNm
         wfjd+EHUw149buxnKEeTFSmUHijLcj757KgiDH5dZwU/8IJCN1V88G+Eti2tOeD+8La4
         OV1t280Lr8P4+arrdHImxwXDmzdkcB1//H6EJsDeNkIFY7yd+AhjwZ9oGpsk7VeTgELL
         7aIg==
X-Gm-Message-State: AA+aEWbIfQnIWVE5yRTwq8zXBAY70/PpFKPQr+HIxb9UrdJNhzgXp/Qz
        /sRMYTnGBwYxYtUrfDo9/M4QIBT8
X-Google-Smtp-Source: AFSGD/Uf1U6X3Hx/zB60E+rI7Cle0glbM+p4NmgzVfI0ljX08UpZPOA6Uq94UqMUwZSXATKmxj5sBg==
X-Received: by 2002:a50:a4fc:: with SMTP id x57mr12832462edb.229.1545058943080;
        Mon, 17 Dec 2018 07:02:23 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id g40sm3773289edg.39.2018.12.17.07.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:22 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 02/19] mailbox: arm-mhu: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:00 +0100
Message-Id: <20181217150217.32435-3-thierry.reding@gmail.com>
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

Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/arm_mhu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 99befa76e37c..64d85c6a2bdf 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -152,7 +152,7 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 
 	amba_set_drvdata(adev, mhu);
 
-	err = mbox_controller_register(&mhu->mbox);
+	err = devm_mbox_controller_register(dev, &mhu->mbox);
 	if (err) {
 		dev_err(dev, "Failed to register mailboxes %d\n", err);
 		return err;
@@ -162,15 +162,6 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static int mhu_remove(struct amba_device *adev)
-{
-	struct arm_mhu *mhu = amba_get_drvdata(adev);
-
-	mbox_controller_unregister(&mhu->mbox);
-
-	return 0;
-}
-
 static struct amba_id mhu_ids[] = {
 	{
 		.id	= 0x1bb098,
@@ -186,7 +177,6 @@ static struct amba_driver arm_mhu_driver = {
 	},
 	.id_table	= mhu_ids,
 	.probe		= mhu_probe,
-	.remove		= mhu_remove,
 };
 module_amba_driver(arm_mhu_driver);
 
-- 
2.19.1

