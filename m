Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A8EECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADB320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mne381Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADB320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeINXIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:08:39 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:51019 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINXIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:08:39 -0400
Received: by mail-io1-f74.google.com with SMTP id z25-v6so9248654iog.17
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7QOYKPqhtaY+2w3BOR1NgpJSjhAF6X9lJ1zs6A9mc+8=;
        b=mne381Wh830u3fNxKBEjrzsYtEg6PfKSRybt4pcVZqg4cLW9tRzCAoCUXYVDnxSqwa
         PTPBZb0suXL2czl7CQ7xHDboysSWbKJpOn8tiyBq2ylc4puHVv+MH0ONYPDZ7p2CffPt
         uHWRgRz95v3kOTXEsApBBQIbOkorEtEr661vypWdEgx9Eedr4GZvMdu9GQ9W3dP9rBzd
         /SxvW5bYJgMjeeqfXwsYWfP/AWK56iYFS+pL86nW4rgaIN9q3zi39jfYR7i7Fm+jZOne
         vEGNoCOq1Jt6mQtcxgU5ai5Kgxneuahq+v4cBHvFxVewY4lTgtnFNW0mVH7PQ7Ptm5lb
         r/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7QOYKPqhtaY+2w3BOR1NgpJSjhAF6X9lJ1zs6A9mc+8=;
        b=jzemqIrynC5tQLZbOfA/9ruW8Pjnq+FJeOX3YLO9AG7uKqcagC91pCrMGWAl1gGOHE
         RxUsXDZSgxfTzaP8ayrTz4XpRr8fzhkMu/9XFa9vuYGdXgRe5+vkNF2cdUQXaCen5KYI
         9gzIPGUaIgd05CKKQEHU/EPyk+9D7ubZJdP7CSySSipOyYwbTiK2guFDKTiJcF+R1jo/
         WkRMOPuwKKgVq20PObFp+ZAz3C3Z4+NASByriyweW8pyzR/IUwBUZd19HRb5iA4Kbfbm
         3TZTbGreRT5x92fmFAA4TiudDL7HKqH3M+ueyOegeoYi5mA3boXchiJNxEKOuEuBNaLO
         wx0w==
X-Gm-Message-State: APzg51AsiTy2OIo8pfydHlsc0LNsKxGsk1lEtwy691FtNjY774cTt/r6
        2B1fuePo8M7DUKyQ+XhXM8a89g5Q
X-Google-Smtp-Source: ANB0VdbXuIwGGWK6smMwCiWCmSCcDfUZVqcdbXENRkPeDZOCDKs7t9r952KU1nM//DJYR8UqAJz37EsO
X-Received: by 2002:a24:b713:: with SMTP id h19-v6mr2950181itf.28.1536947584850;
 Fri, 14 Sep 2018 10:53:04 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:19 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-18-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 18/21] platform: goldfish: pipe: Rename PIPE_REG to PIPE_V2_REG
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

PIPE_V1_REG will be introduced later for v1 support.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c      |  4 ++--
 drivers/platform/goldfish/goldfish_pipe_qemu.h | 18 +++++++++---------
 drivers/platform/goldfish/goldfish_pipe_v2.c   | 16 ++++++++--------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 8a65cdfd6555..d963b7485ce5 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -102,8 +102,8 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	 *  reading device version back: this allows the host implementation to
 	 *  detect the old driver (if there was no version write before read).
 	 */
-	writel((u32)PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
-	version = readl(base + PIPE_REG_VERSION);
+	writel((u32)PIPE_DRIVER_VERSION, base + PIPE_V2_REG_VERSION);
+	version = readl(base + PIPE_V2_REG_VERSION);
 
 	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
diff --git a/drivers/platform/goldfish/goldfish_pipe_qemu.h b/drivers/platform/goldfish/goldfish_pipe_qemu.h
index 0ffc51dba54c..599b69f0baa1 100644
--- a/drivers/platform/goldfish/goldfish_pipe_qemu.h
+++ b/drivers/platform/goldfish/goldfish_pipe_qemu.h
@@ -62,19 +62,19 @@ enum PipeFlagsBits {
 	BIT_WAKE_ON_READ   = 2,  /* want to be woken on reads */
 };
 
-enum PipeRegs {
-	PIPE_REG_CMD = 0,
+enum PipeV2Regs {
+	PIPE_V2_REG_CMD = 0,
 
-	PIPE_REG_SIGNAL_BUFFER_HIGH = 4,
-	PIPE_REG_SIGNAL_BUFFER = 8,
-	PIPE_REG_SIGNAL_BUFFER_COUNT = 12,
+	PIPE_V2_REG_SIGNAL_BUFFER_HIGH = 4,
+	PIPE_V2_REG_SIGNAL_BUFFER = 8,
+	PIPE_V2_REG_SIGNAL_BUFFER_COUNT = 12,
 
-	PIPE_REG_OPEN_BUFFER_HIGH = 20,
-	PIPE_REG_OPEN_BUFFER = 24,
+	PIPE_V2_REG_OPEN_BUFFER_HIGH = 20,
+	PIPE_V2_REG_OPEN_BUFFER = 24,
 
-	PIPE_REG_VERSION = 36,
+	PIPE_V2_REG_VERSION = 36,
 
-	PIPE_REG_GET_SIGNALLED = 48,
+	PIPE_V2_REG_GET_SIGNALLED = 48,
 };
 
 enum PipeCmdCode {
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 2332aa4bfcea..862ef3a56388 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -259,7 +259,7 @@ static int goldfish_pipe_cmd_locked(struct goldfish_pipe *pipe,
 	pipe->command_buffer->cmd = cmd;
 	/* failure by default */
 	pipe->command_buffer->status = PIPE_ERROR_INVAL;
-	writel(pipe->id, pipe->dev->base + PIPE_REG_CMD);
+	writel(pipe->id, pipe->dev->base + PIPE_V2_REG_CMD);
 	return pipe->command_buffer->status;
 }
 
@@ -276,7 +276,7 @@ static int goldfish_pipe_cmd(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
 
 /*
  * This function converts an error code returned by the emulator through
- * the PIPE_REG_STATUS i/o register into a valid negative errno value.
+ * the PIPE_V2_REG_STATUS i/o register into a valid negative errno value.
  */
 static int goldfish_pipe_error_convert(int status)
 {
@@ -673,7 +673,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	/* Request the signalled pipes from the device */
 	spin_lock_irqsave(&dev->lock, flags);
 
-	count = readl(dev->base + PIPE_REG_GET_SIGNALLED);
+	count = readl(dev->base + PIPE_V2_REG_GET_SIGNALLED);
 	if (count == 0) {
 		spin_unlock_irqrestore(&dev->lock, flags);
 		return IRQ_NONE;
@@ -1181,15 +1181,15 @@ int goldfish_pipe_device_v2_init(struct platform_device *pdev,
 
 	/* Send the buffer addresses to the host */
 	write_pa_addr(&dev->buffers->signalled_pipe_buffers,
-		      dev->base + PIPE_REG_SIGNAL_BUFFER,
-		      dev->base + PIPE_REG_SIGNAL_BUFFER_HIGH);
+		      dev->base + PIPE_V2_REG_SIGNAL_BUFFER,
+		      dev->base + PIPE_V2_REG_SIGNAL_BUFFER_HIGH);
 
 	writel(MAX_SIGNALLED_PIPES,
-	       dev->base + PIPE_REG_SIGNAL_BUFFER_COUNT);
+	       dev->base + PIPE_V2_REG_SIGNAL_BUFFER_COUNT);
 
 	write_pa_addr(&dev->buffers->open_command_params,
-		      dev->base + PIPE_REG_OPEN_BUFFER,
-		      dev->base + PIPE_REG_OPEN_BUFFER_HIGH);
+		      dev->base + PIPE_V2_REG_OPEN_BUFFER,
+		      dev->base + PIPE_V2_REG_OPEN_BUFFER_HIGH);
 
 	platform_set_drvdata(pdev, dev);
 	return 0;
-- 
2.19.0.397.gdd90340f6a-goog

