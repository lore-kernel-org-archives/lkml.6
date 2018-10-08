Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2E2C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB572085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BgtO9LPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB572085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJHWH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:07:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32950 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeJHWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:07:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so8509336pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQ1XVNYtRJ/0qJRbClwHEGcn5uUY6PGJJclayZZ+uJk=;
        b=BgtO9LPEdTUL7pHuL4hvmHA7W/VcYEKVxmflv9TcXxZu4hC6OVvP+Rp8BZNMpGoqf2
         4qrljhHBT/Y7sccDnfnqT5ec3qOkhZaw9/Wxk9NcfeIlBcuT2k00o0sFOg0clUcLZvLl
         aZm/eF/Tbap6Rt5YzVtkRiSw5M2rjuf85wSDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vQ1XVNYtRJ/0qJRbClwHEGcn5uUY6PGJJclayZZ+uJk=;
        b=lxKeJLj9/6KuRgo4RkvoqRgPUpoL88Ou+mfJ7D761W03nKpZnqdjZl7Nm1BsrYXeFV
         esLokuJfU3Pq9TRV4qMLz9h0Gptiw8dcL/B6UVRevk3ieH506lqWuwNC2ltvaubTcOtO
         OlGWjDH4yNAbHAqn5oCC/5IhDTnS/7d8YvwyoCLUziOXWpOwDV5rtnitCbUs396v2eOk
         MJAQY434kh7G+T/3p4lim/5mf8RdFQ+sDCAIfO2CAaAvaijFuZk8+/I9XFDGKsYl1fmG
         a6cTcf4dgKcVsecd+e5IuXaGp5SO0pgw7aU08xM3d/asZiDis9nt0QUq9F9ZYs5muzKs
         QZYA==
X-Gm-Message-State: ABuFfog2aJeIpVyEZNVb2TsNeqif0aKDOWM+E+7W5Y+bcZCfmqG1E5yi
        7EZFMqBQNGMiq92kyHmxIZ5KIJWgefk=
X-Google-Smtp-Source: ACcGV62TIq12bPVU/RlwA20vBCQVbst0TPmQAhZSBfNzHzwm7qxCDsFIUDB1o4esLK4V3sqmqPvALg==
X-Received: by 2002:a63:2a11:: with SMTP id q17-v6mr5683105pgq.374.1539010522007;
        Mon, 08 Oct 2018 07:55:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id i2-v6sm16217215pgq.35.2018.10.08.07.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 07:55:21 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: Fix kerneldoc for renamed i2c dma put function
Date:   Mon,  8 Oct 2018 07:55:20 -0700
Message-Id: <20181008145520.36810-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function was renamed in commit 82fe39a6bc7b ("i2c: refactor
function to release a DMA safe buffer") but this kernel doc wasn't
updated to point at the new function. Rename it.

Fixes: 82fe39a6bc7b ("i2c: refactor function to release a DMA safe buffer")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9ee9a15e7134..9200e349f29e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2270,7 +2270,7 @@ EXPORT_SYMBOL(i2c_put_adapter);
  *
  * Return: NULL if a DMA safe buffer was not obtained. Use msg->buf with PIO.
  *	   Or a valid pointer to be used with DMA. After use, release it by
- *	   calling i2c_release_dma_safe_msg_buf().
+ *	   calling i2c_put_dma_safe_msg_buf().
  *
  * This function must only be called from process context!
  */
-- 
Sent by a computer through tubes

