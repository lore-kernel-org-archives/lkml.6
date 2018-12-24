Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A57C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA43C21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FZlEAO98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbeLXQ50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:57:26 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:34552 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLXQ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:57:25 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 0DC43957
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 16:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EDsd8Boxnk2F for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 10:57:23 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id D08125F4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:57:23 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id s25so13813794ioc.14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eK4GXtGvYUyBJT87Mc4elwM9U41YctaNsQHEgSw94uk=;
        b=FZlEAO98CDb5Uk7sVRRSJzY9mw9mAOrwAFIylS3IvX/Y8pnITXtBCQdmlVwxcggZp1
         LPQbIdeDFxYcGpUIBama6JihqIAR6iXihl2bqpKmSQOwewfnIYYaPYZt8ztInfoqElML
         oOfB3fgktbCT1gfCRpu8wwZQgrdu1xaGymod3l0/ASzXgw33uqBgZ4Zs43oR2w/zWtX4
         FB6zci10FTjwDNfomp4wf9ornJWxVqSNSZzu6hVIK0G5TVJclgFyMuVu5kI9cM9pTwyW
         jMuG8vLSMEV4a5fCxIDIuC4dNNzBGxFVTml5vmvv5lMIBhgTwQvyRQFDlobCCS362sM5
         9bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eK4GXtGvYUyBJT87Mc4elwM9U41YctaNsQHEgSw94uk=;
        b=qtslGIBKx5OH4TtEbvXbNnbe3I2l/FCEPZe0Cf4/ojr0v2BctsbVP92ms8NjMfsB5x
         GfuIvPzzeMeMeL1KVunfH42eROM7xBbAyTmNL3xSe0fjRx/6r8ctHLd/76ZOiMgpvA4F
         9eyo7jUG6yC41zByw7FQjPQIIjJD++vBTQ9UDRq67L810nOcjWpXdohFoEEviisp4UO1
         trJl/mwzzD/L1T6iWlP3SyZ902m1iwbdLJe6nBZU6mr6JCYBO5fa3NU1sSEd57j3kjhX
         Lh+P6IM4toFBVMoh2ys8R8xbXlA01CroGlZUaDFpKehPe8Not9AaWR1rizyXHKnuzNag
         HglQ==
X-Gm-Message-State: AJcUukePNO+5OcPRDz41+Td/Oz9LEzhq76ubBPnLYRarSAxmeuCeWZ5O
        MZSisb6SppFPWUONhjiucWvgBqDBUMfTDVucUevbjwYl9iDjRRvFjKff+NKXtlMH5o9cK6nLtJp
        Vb2z5W9LpeRwxFlGLPBIbFvf1uboL
X-Received: by 2002:a5d:8e0d:: with SMTP id e13mr2141512iod.44.1545670643493;
        Mon, 24 Dec 2018 08:57:23 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4biTjbh+vN4nN7x+NVITN43Fp7qoJMefIoq4sJliSnLA4xkQErAywTQCmtt2BHGYHLiZWkpw==
X-Received: by 2002:a5d:8e0d:: with SMTP id e13mr2141498iod.44.1545670643256;
        Mon, 24 Dec 2018 08:57:23 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id p132sm8611156itb.35.2018.12.24.08.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 08:57:22 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: Add a check on the return value of platform_device_add
Date:   Mon, 24 Dec 2018 10:56:59 -0600
Message-Id: <20181224165659.18448-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In of_qcom_slim_ngd_register, the function platform_device_add() may fail.
The fix returns the error value upstream in case of failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1382a8df6c75..a2dffb2b4c88 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1329,6 +1329,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	struct qcom_slim_ngd *ngd;
 	struct device_node *node;
 	u32 id;
+	int ret;
 
 	data = of_match_node(qcom_slim_ngd_dt_match, parent->of_node)->data;
 
@@ -1348,7 +1349,10 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ctrl->ngd = ngd;
 		platform_set_drvdata(ngd->pdev, ctrl);
 
-		platform_device_add(ngd->pdev);
+		ret = platform_device_add(ngd->pdev);
+		if (ret)
+			return ret;
+
 		ngd->base = ctrl->base + ngd->id * data->offset +
 					(ngd->id - 1) * data->size;
 		ctrl->ngd = ngd;
-- 
2.17.1

