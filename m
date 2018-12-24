Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F49C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EA9217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Kp+VCFKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLXVVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:21:32 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:47156 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLXVVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 16:21:31 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 6449EC2F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 21:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HzB_weQ176Jo for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 15:21:30 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 3845AC37
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:21:30 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id g7so15064877itg.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 13:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=43gchWhnjuYleacimEGTo0K+ifmfHPKPUbsTzY3Migc=;
        b=Kp+VCFKtAAXat8EfZJ+egoNYEX0Iuo1Bx4EBj0iZJ9DH2h7o1CkSC9UF4QYGvdQ7aJ
         z5h3baUFHD90gJRSixMmsnNZgQ9EjtbpxWA6ZgV7My5GphHDONqKnaio7zSDKdNGS58+
         emHHMoimeNMVKamllEjinpBvh2HGgl3mgkrOrsfD6BAQVWzhyLXmOgdNOQmwUNioOJIB
         lOBghsVc/tksHVI3oJ1WML1J2+usX9r/wKnK5gByKYHVeGigHQo0M/rJ9YZwL/SwPtpa
         hGnTVTuHHBrScmQabIq4rb5Y9TJCA5yIknr8AU5yLstFckamzTUAVUjjWpNuxeCdcGPc
         pc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=43gchWhnjuYleacimEGTo0K+ifmfHPKPUbsTzY3Migc=;
        b=ALc/Kg2hwGcD7xGzd1paSibz6OHFPLkJSR3faylDI5OrBjL5hdv4wSpfhvor9bYf1u
         RPql5h6u2Dy0DgdtqHWQ1NXW3XCAvNDoX4FPq9FpQqx4vyy27VLvl4hCxMaaZjK3w+eY
         DSFECiJpaMIdAI1QjVBAUSacpGwKN8i1cOxLBMl1ONrkdNiZ3MsB3XnrvOA+lu+nhzgM
         lR9qC20ojagGixAc0xvFEnfpLvEzSn8T0EPfXrNjJb8/bhZbrUuAmiNDOX9UxDhPT1DB
         XQcvMRVy6G3bx4pZeFgONUNKPRGfIZ27y0bzC2vK6tn20yYCvBJPwvZQEXQTcUNlqNYR
         i93A==
X-Gm-Message-State: AA+aEWYBzupgys+KBTb7A6apJCeDBq08tUWN+8Fgv+uorBQi27TudY4f
        o5ZIH86LXdub0OMWz7kHIip93dZJjuKwFyOpc7tzwDED4rWXrVGlATrErQ77zaaDxkRXE1x9hSj
        8vEsiLrqxWx7lubxTeK9y79ZQMmQd
X-Received: by 2002:a02:9d4b:: with SMTP id m11mr9645097jal.121.1545686489842;
        Mon, 24 Dec 2018 13:21:29 -0800 (PST)
X-Google-Smtp-Source: AFSGD/V/JJk7MbNrGNVT1fPMQZjDNyT5BoqOOfGblM/MUd5wjcm3ZViiJFSxFUxtrkLoN/GVogiAFw==
X-Received: by 2002:a02:9d4b:: with SMTP id m11mr9645085jal.121.1545686489600;
        Mon, 24 Dec 2018 13:21:29 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id p132sm8878267itb.35.2018.12.24.13.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 13:21:28 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Arjun Vynipadath <arjun@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: chelsio: Add a missing check on cudg_get_buffer
Date:   Mon, 24 Dec 2018 15:21:21 -0600
Message-Id: <20181224212121.25596-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cudbg_collect_hw_sched() could fail when the function cudg_get_buffer()
returns an error. The fix adds a check to the latter function returning
error on failure

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
index 7c49681407ad..127b1f624413 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
@@ -1229,6 +1229,10 @@ int cudbg_collect_hw_sched(struct cudbg_init *pdbg_init,
 
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, sizeof(struct cudbg_hw_sched),
 			    &temp_buff);
+
+	if (rc)
+		return rc;
+
 	hw_sched_buff = (struct cudbg_hw_sched *)temp_buff.data;
 	hw_sched_buff->map = t4_read_reg(padap, TP_TX_MOD_QUEUE_REQ_MAP_A);
 	hw_sched_buff->mode = TIMERMODE_G(t4_read_reg(padap, TP_MOD_CONFIG_A));
-- 
2.17.1

