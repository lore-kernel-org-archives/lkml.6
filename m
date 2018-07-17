Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4244EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6A6208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5jBUm6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6A6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbeGQCkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37182 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbeGQCkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id a26-v6so5136319pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nzypiEWP4OlTPYQ4HJzmPiLsQyGKJm33TDsLamzLFuU=;
        b=X5jBUm6sm7rtsZgYGIJlwPG5nu15VYPczqL9YMwcUMJTUxYWDXDwpSLtvxWpVVEyZ6
         0N6WT/aYFBOJfGwBgNhN6pLHuFnsYKdbGA5oN51gAZo4GfOS/cANP7P5UdxS8xr05ewK
         Dp1AQfkCMFuZ9C3YSBv3mnglmXXHh2LEI9iNW7GUPOnSA3MSxW1U7FBSdE9cKhgYujrl
         Y2Ycqy9asoR6R5KpSUVU14AHLanGMJtm2qHR5BR6rZjlubdkaDQIen5GRJLHWGiK6gQl
         NioYPMVVX+OhAYlSY95miY+vVW46dWNgSGz0b6oYvV+LVTw0QKu0Z2kcu7HI+VHtorfw
         RCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nzypiEWP4OlTPYQ4HJzmPiLsQyGKJm33TDsLamzLFuU=;
        b=HxdtovQYjXVAXfAAdkdN2y9hLySRRTX1neDFnljSPCfMHSUexd+jKQ2Pyk4WjwACWu
         Qvfl2eJLCw44mVj2kbjywffaabk1IDQeJQRq6pCxCKPCNtq/Y55nPj3qtwLU1rSjwsTS
         YCkX6XjmDVhP0zu/laWBoAbfWEoLVsXWPYQKZT1fJyoTvKGxCN4EaGPfoBfVDjxpipkv
         bBmvFLWVKCqIfcaXa/VrKlKNJD54SGxj9kkEQ26KxGADqsO/M+DQIhkhQLCrEEs3oRWJ
         MBljCrLd6Hzyds0PSKIM4FdwgiFTNYUTkfHldg6TuqY3vLLjBPWkZs8Yyt2elnew9jZn
         TU4A==
X-Gm-Message-State: AOUpUlE/xXdslQvUKpMeOstu29Vs4RPHdccVEho2fbgttMQqkT2RlH/t
        tSSajf71tG/2iLpjAf6VHtjDGgEn
X-Google-Smtp-Source: AAOMgpdG5h0xw1LnT5goRJuJq7ZjQFVl+S5ULoXLuaIWQ/0H2ZGO0ukHCeYcS0fPuJDB0SmUxKMvmA==
X-Received: by 2002:a62:15c8:: with SMTP id 191-v6mr20189373pfv.194.1531793420488;
        Mon, 16 Jul 2018 19:10:20 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:20 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 24/32] staging: gasket: apex_clock_gating simplify logic, reduce indentation
Date:   Mon, 16 Jul 2018 19:09:18 -0700
Message-Id: <20180717020926.176408-25-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Collapse together two checks and return immediately, avoid conditional
indentation for most of function code.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 44 +++++++++++++---------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 6a22fa9a9c045..a1fec53d152b9 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -663,33 +663,31 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg)
 {
 	struct apex_gate_clock_ioctl ibuf;
 
-	if (bypass_top_level)
+	if (bypass_top_level || !allow_sw_clock_gating)
 		return 0;
 
-	if (allow_sw_clock_gating) {
-		if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
-			return -EFAULT;
+	if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
+		return -EFAULT;
 
-		gasket_log_error(
-			gasket_dev, "%s %llu", __func__, ibuf.enable);
+	gasket_log_error(
+	    gasket_dev, "%s %llu", __func__, ibuf.enable);
 
-		if (ibuf.enable) {
-			/* Quiesce AXI, gate GCB clock. */
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_AXI_QUIESCE, 0x1, 1, 16);
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_GCB_CLOCK_GATE, 0x1, 2, 18);
-		} else {
-			/* Un-gate GCB clock, un-quiesce AXI. */
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_GCB_CLOCK_GATE, 0x0, 2, 18);
-			gasket_read_modify_write_32(
-				gasket_dev, APEX_BAR_INDEX,
-				APEX_BAR2_REG_AXI_QUIESCE, 0x0, 1, 16);
-		}
+	if (ibuf.enable) {
+		/* Quiesce AXI, gate GCB clock. */
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_AXI_QUIESCE, 0x1, 1, 16);
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x1, 2, 18);
+	} else {
+		/* Un-gate GCB clock, un-quiesce AXI. */
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_GCB_CLOCK_GATE, 0x0, 2, 18);
+		gasket_read_modify_write_32(
+		    gasket_dev, APEX_BAR_INDEX,
+		    APEX_BAR2_REG_AXI_QUIESCE, 0x0, 1, 16);
 	}
 	return 0;
 }
-- 
2.18.0.203.gfac676dfb9-goog

