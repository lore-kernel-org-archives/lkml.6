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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA3AC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482D0214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOAV3Q4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482D0214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbeKVB3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39301 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbeKVB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so5114091edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+g0p5nWEzeTlzn8krfddSnGEmrnpqUmVQ9WbyXeR9w=;
        b=rOAV3Q4oY7tbFC5SdTNFJXu0m+kpJYIEocVIDlBPtej0VkhPY7t4TuVD9QMXxz8Rkj
         8IGComT37rs+9r1JgSj6W+fyEK3ja40nlzeixsYMTEriUucVKRQbZ8wQTO6veZYMAWTE
         UMGHNuxglk6nCzdNO9FF/jjbAWs9iOY3JrNuGpaPHhzlu/jAMy56zqDbmUE8MdjBysPQ
         R+vgY40EvvzCSn0IE1d73Xjj3WSzaWc0/61BL7Eb3SaPY/I9Mvb6ScZ/7GeB0kwWH1EA
         ZGQjhMibGsJPFqrjwA681CSZJq3HyGpCyJ7qgjRqjrd5OqSotGDu7kAPaM9GxjrGOhZv
         nAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+g0p5nWEzeTlzn8krfddSnGEmrnpqUmVQ9WbyXeR9w=;
        b=Igk/ByIvnc9PEF2eJ9lrcJq2yDjZnrMcQAk2p/SUyqWZyRo5OWU9My9BbfxxB52eBp
         /oippbVr6SZBZAA4u380RxWZscB9UCtkfrf3llwM7lITTd89IDADyjkTA02WKZXC6rJq
         vKPfa5gx5whXQGTjI117M0nBZweHO1FpWFEEwRpzTJIoNzVE12WYhff86iNaaG8wB4Gw
         cTcEXrwjdhk4GVWaKBNa1+rjgSqYNTRBH7JJT35ONsfLSi6KB75eY+nzQAdSa1cA8I0c
         THIyhs58QHJEVcCnNhoihRnHSX63PhfcouOkk/BxLpWgQEH3l//5cApxYPARcmZ8O6mz
         0feA==
X-Gm-Message-State: AGRZ1gLynMEOMR96Np1JO6OXqv2jbQ7ZztabXdmB1rDxX8sm8lI89HBx
        abRZPI1hf5awNH931nmYbS4=
X-Google-Smtp-Source: AJdET5f10o1XRss0Y4nXHIFiTVXm6bkSoUek7ERcGb0tkN/CHKCFcWCvyl6KNeiX5h8zCyM86NnUKg==
X-Received: by 2002:a17:906:d144:: with SMTP id br4-v6mr5143870ejb.18.1542812074060;
        Wed, 21 Nov 2018 06:54:34 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id e35sm7652741eda.13.2018.11.21.06.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:33 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] mailbox: arm-mhu: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:12 +0100
Message-Id: <20181121145429.7582-3-thierry.reding@gmail.com>
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

