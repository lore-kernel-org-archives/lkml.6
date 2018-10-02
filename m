Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B666C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2389E20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZwKYtjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2389E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeJCFG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:06:29 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:33048 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:06:29 -0400
Received: by mail-qk1-f201.google.com with SMTP id a102-v6so3355103qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e/ryafqVIxp1dBLox1n5wIkvBi/1bodzgYh4MfpRFHg=;
        b=LZwKYtjCFE4ASBMD6i09CNRECIBg3CbQmuoXuFILTiNdYdP+GZX8L6Y80pXzGZZhN4
         bWFC3X91IsaYxQGVetzBKUN6N7QL1k+bQgVe/tggFv56qB4hob6fVtY/VYcO3e++HUDA
         SOM4nsXtMPm4QKkqQ+l/ooKYqG2Yq2U5BN06yZDyicQ4eDvzBOx1D44VC80btQiJzXSI
         VAgewb4NAjvnBgXHQA9A31fdhCAsktebncnAIW8637AwrOBRees5IzgvK6OkGd4x+yt4
         v3v8toxdI3m014Usqry9s4GCa8Bj6IZfzarJpuPh0G7p/CgPeJ2I7UNOZ6JKks70+Ig/
         e2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e/ryafqVIxp1dBLox1n5wIkvBi/1bodzgYh4MfpRFHg=;
        b=XFvoee8FpcapatO1wRgmYw3ondwFo7UjJhhIKcFwcXJ2rWz9BDOHyY2HlLMPYwU+/X
         zTfH82psjD4xa5rXSDTB79wg/rH+/cmFRVfIuvoskTFmjlckdcM0mSEjOk8NWHkudAwr
         rg+XfdCmVaWsqOfrUT4uMrK/Ht4KckEKpLVO6/GpxSEhH6kq4iZKsoCDJ7jS2j9UTW+T
         DfITS04HPhaaoDuqETevL05rLykDH0dgeamxBo0HtdSWNcTNl/4AT1jSnBxFT4Vd4f+J
         0WELoWvr2B2diGfLdhWnR3NZNJtn16kvGX9GTZYczskJ0Wi1cy26aeoTlRE42AF5g1VJ
         u4Pg==
X-Gm-Message-State: ABuFfojU/oB/IYtaBPIdeV9ZdeTSKEcnrhRuBWSHPgH+AM1RUot99PRO
        2hJ8nRncvL/ZD/ermKpLimGpASjF
X-Google-Smtp-Source: ACcGV63IHheE4q7tNu7+NY6hGeAYaAyqxBfY0UYkEQZTFlhnTovxfWBq2TEdr9wZjYOweAp05ZpWJehR
X-Received: by 2002:a37:c609:: with SMTP id b9-v6mr12847467qkj.25.1538518853633;
 Tue, 02 Oct 2018 15:20:53 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:19:02 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-14-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 14/15] platform: goldfish: pipe: Rename PIPE_REG to PIPE_V2_REG
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
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
index 7b0920e962eb..353f7ce94aa7 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -81,8 +81,8 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	 *  reading device version back: this allows the host implementation to
 	 *  detect the old driver (if there was no version write before read).
 	 */
-	writel(PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
-	version = readl(base + PIPE_REG_VERSION);
+	writel(PIPE_DRIVER_VERSION, base + PIPE_V2_REG_VERSION);
+	version = readl(base + PIPE_V2_REG_VERSION);
 
 	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
diff --git a/drivers/platform/goldfish/goldfish_pipe_qemu.h b/drivers/platform/goldfish/goldfish_pipe_qemu.h
index b4d78c108afd..24b02710769f 100644
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
index 0e2a62322477..c99317548128 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -197,7 +197,7 @@ static int goldfish_pipe_cmd_locked(struct goldfish_pipe *pipe,
 	pipe->command_buffer->cmd = cmd;
 	/* failure by default */
 	pipe->command_buffer->status = PIPE_ERROR_INVAL;
-	writel(pipe->id, pipe->dev->base + PIPE_REG_CMD);
+	writel(pipe->id, pipe->dev->base + PIPE_V2_REG_CMD);
 	return pipe->command_buffer->status;
 }
 
@@ -214,7 +214,7 @@ static int goldfish_pipe_cmd(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
 
 /*
  * This function converts an error code returned by the emulator through
- * the PIPE_REG_STATUS i/o register into a valid negative errno value.
+ * the PIPE_V2_REG_STATUS i/o register into a valid negative errno value.
  */
 static int goldfish_pipe_error_convert(int status)
 {
@@ -611,7 +611,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	/* Request the signalled pipes from the device */
 	spin_lock_irqsave(&dev->lock, flags);
 
-	count = readl(dev->base + PIPE_REG_GET_SIGNALLED);
+	count = readl(dev->base + PIPE_V2_REG_GET_SIGNALLED);
 	if (count == 0) {
 		spin_unlock_irqrestore(&dev->lock, flags);
 		return IRQ_NONE;
@@ -847,15 +847,15 @@ int goldfish_pipe_device_v2_init(struct platform_device *pdev,
 
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
2.19.0.605.g01d371f741-goog

