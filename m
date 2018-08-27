Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C992208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFqYcS5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C992208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeH0WME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:12:04 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34797 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:12:03 -0400
Received: by mail-pg1-f202.google.com with SMTP id w23-v6so11494473pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q2x68N8lrgJfZ6T7hgCccIIuZNvKapdrxrCil2Dgb9w=;
        b=PFqYcS5EufQ2dHl3dPvBIxcnG2eqxY61wcSLe8CrYAtJHO2auwrTXK7+nikPq7YNl1
         /9/jjwWOc0s55zUSsl4NPkA3s55/pMFf0uUuAOOz0VOIvIx7R2P5zm4ZAF9hS2Py1Hf0
         TkWVytlGPCZ2n6RQ3PFtXmCumjR1NVliD6AuiJi+9sgRNdR++C/1+2Z2pATuu0zBxJ3i
         6WX2dd3VoxoKKBZyyDmTnBsYtdLd6wDoL4hY8g69vZoMRcEPkr8XUGhhKIhgbadlPitW
         AondWhh7kGEMsqifKG2q+XToqXmlASxfziRMxKDI99Y4v8SU5anK2+c/WLWPBNxatCbO
         7h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q2x68N8lrgJfZ6T7hgCccIIuZNvKapdrxrCil2Dgb9w=;
        b=EhlCs+Ekjy0btP6u3okIRTFfE71djcnrM5wswBuJhmowVmuyvee8vOqNPSzBTSAJ8W
         KFZHYk8K2p/8iiQSvxCJnNFyMIseIolUG9hZflBvhCIauGttsoku54yB3z25prq8k0g4
         itJ//mg2SF5Zc2AJC7I5RdZwRMLoLOro+Cp45eeIsFgQsPxZh2llGwnggQOA5LFuBHJ8
         6YMIZXPTA0Y1URA7oNHJWucr0p7b67p0gEvSx5edpd20EwxIc9PSGTI8rKcuQufifNCE
         AETZDOIc7+kQ78Wjp6Cio38bKZJJPaU5iFjnbS9ZxNc1jiHUBD9Tu1BIZT36m1lb2/4m
         B2jA==
X-Gm-Message-State: APzg51CMm9cm3gPxwibFiEM5y6jjE+3SuUS2CSOpFWu9FFOGMxPX59Kj
        tJpFSo/ayovJ/sATUI0fBybZCkAV
X-Google-Smtp-Source: ANB0VdZzM20bU3/m/yrk2PYf7w2SVgpxc8W7kyxifQl0lG0jq523Z6kb7Iha1KLby+voON/mYEKx71V2
X-Received: by 2002:a63:5f15:: with SMTP id t21-v6mr3364486pgb.23.1535394261540;
 Mon, 27 Aug 2018 11:24:21 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:11 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-16-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 16/20] platform: goldfish: pipe: Rename goldfish_x to goldfish_pipe_x
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

Add "pipe" to the pipe related function names.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index fb37499731a4..95256a5c593c 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -213,7 +213,8 @@ struct goldfish_pipe_dev {
 
 struct goldfish_pipe_dev goldfish_pipe_dev;
 
-static int goldfish_cmd_locked(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
+static int goldfish_pipe_cmd_locked(struct goldfish_pipe *pipe,
+				    enum PipeCmdCode cmd)
 {
 	pipe->command_buffer->cmd = cmd;
 	/* failure by default */
@@ -222,13 +223,13 @@ static int goldfish_cmd_locked(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
 	return pipe->command_buffer->status;
 }
 
-static int goldfish_cmd(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
+static int goldfish_pipe_cmd(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
 {
 	int status;
 
 	if (mutex_lock_interruptible(&pipe->lock))
 		return PIPE_ERROR_IO;
-	status = goldfish_cmd_locked(pipe, cmd);
+	status = goldfish_pipe_cmd_locked(pipe, cmd);
 	mutex_unlock(&pipe->lock);
 	return status;
 }
@@ -349,7 +350,7 @@ static int transfer_max_buffers(struct goldfish_pipe *pipe,
 		pipe->command_buffer);
 
 	/* Transfer the data */
-	*status = goldfish_cmd_locked(pipe,
+	*status = goldfish_pipe_cmd_locked(pipe,
 				is_write ? PIPE_CMD_WRITE : PIPE_CMD_READ);
 
 	*consumed_size = pipe->command_buffer->rw_params.consumed_size;
@@ -368,7 +369,7 @@ static int wait_for_host_signal(struct goldfish_pipe *pipe, int is_write)
 	set_bit(wake_bit, &pipe->flags);
 
 	/* Tell the emulator we're going to wait for a wake event */
-	goldfish_cmd(pipe,
+	goldfish_pipe_cmd(pipe,
 		is_write ? PIPE_CMD_WAKE_ON_WRITE : PIPE_CMD_WAKE_ON_READ);
 
 	while (test_bit(wake_bit, &pipe->flags)) {
@@ -490,7 +491,7 @@ static __poll_t goldfish_pipe_poll(struct file *filp, poll_table *wait)
 
 	poll_wait(filp, &pipe->wake_queue, wait);
 
-	status = goldfish_cmd(pipe, PIPE_CMD_POLL);
+	status = goldfish_pipe_cmd(pipe, PIPE_CMD_POLL);
 	if (status < 0)
 		return -ERESTARTSYS;
 
@@ -722,7 +723,7 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 			MAX_BUFFERS_PER_COMMAND;
 	dev->buffers->open_command_params.command_buffer_ptr =
 			(u64)(unsigned long)__pa(pipe->command_buffer);
-	status = goldfish_cmd_locked(pipe, PIPE_CMD_OPEN);
+	status = goldfish_pipe_cmd_locked(pipe, PIPE_CMD_OPEN);
 	spin_unlock_irqrestore(&dev->lock, flags);
 	if (status < 0)
 		goto err_cmd;
@@ -748,7 +749,7 @@ static int goldfish_pipe_release(struct inode *inode, struct file *filp)
 	struct goldfish_pipe_dev *dev = pipe->dev;
 
 	/* The guest is closing the channel, so tell the emulator right now */
-	goldfish_cmd(pipe, PIPE_CMD_CLOSE);
+	goldfish_pipe_cmd(pipe, PIPE_CMD_CLOSE);
 
 	spin_lock_irqsave(&dev->lock, flags);
 	dev->pipes[pipe->id] = NULL;
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

