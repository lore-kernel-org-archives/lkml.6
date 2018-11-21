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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E153214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxkuHlQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E153214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbeKVBaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:30:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39349 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbeKVB3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so5115336edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RujL8WsQvcB7xiRXcSS7PfIPsyH+7pFl/LY+KC0guMY=;
        b=jxkuHlQv7nOJkeB5rAviB8C3x0PlGP93g9Xhp1kuB1PDDQt4yfPE2Lsg4NalnY826m
         g352GurGcQrfpw6MxUyRsHkcY8N/X+OJg/d2pgneacClB2NHOPiwCo5aba0H8rqlmr5/
         ls1anK+1vy55Q8HPjzeff8pSh/bTrQ4ow+w/z59i/RqMJ1aHcDO1qDDxL1jxMu4FPjrT
         JKGJS4bYKACpvERwqq57l8E0I9vBcLh+je2Pd3JjG1cDZXh3ZNhhi85xnnWFARlgn8Gs
         XuxP7LLe6iFKBoVeZOeAGAhxR/A1fc1FwdYEqisI+58gMAsDjFmY6AljA1W4HDHq19+M
         tmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RujL8WsQvcB7xiRXcSS7PfIPsyH+7pFl/LY+KC0guMY=;
        b=UmJ0p7pv+8oSufzFQ6M/ByJgllAvqCt2My1it94LibUm/nRWpHfRirhJAH28T5u4V5
         iTlvWa/h0cCsrtFsZ9Icyaakjey4pHxe7srDts9VBQyEBlaumz3pngN1KbZQkF9AAlC7
         KaPCRlkdPLRg6EmwVVfkzWS9AOWJIkhgTdKTbm8jC4aYrO18NpCXCZtHLSu1rtvW+mlj
         A50Rhy0V42FVyTKstD8nrLCKK0nxIvz0DpVpOdDbCjXVRMDQVJP/SvykSJaZ6UdzoJq6
         TIz7+Qv2P50OhH61OMvSmEMPukkybE6OBv7PiXkbav+c8zjgaZ5Uqf3zY9LigJcHnYc9
         Ul2Q==
X-Gm-Message-State: AA+aEWbrt58O9+o5PEcBzcJsYr2ParPH3RzkfUkxfZaPfd7wTeS3T7z3
        iypC6uGUkBoVYkKW9wdXJwwp/Kd1
X-Google-Smtp-Source: AFSGD/V7zEpBQlIOJ1F/euYQOGfcCOoFwgbWV6IP3igxJITPcUqqKWYxMDo0fR+3IdeVIyWf2X0b+A==
X-Received: by 2002:a50:9226:: with SMTP id i35mr6155769eda.8.1542812099631;
        Wed, 21 Nov 2018 06:54:59 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id 49sm9467179edz.59.2018.11.21.06.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:59 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] mailbox: ti-msgmgr: Use device-managed registration API
Date:   Wed, 21 Nov 2018 15:54:29 +0100
Message-Id: <20181121145429.7582-20-thierry.reding@gmail.com>
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
 drivers/mailbox/ti-msgmgr.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 713d701b6568..1be1f432d6a5 100644
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

