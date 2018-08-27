Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFEAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76441208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DphGq5w8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76441208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeH0WMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:12:02 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:33841 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:12:01 -0400
Received: by mail-qk0-f201.google.com with SMTP id y130-v6so15782646qka.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LAC4lPRFAZrMekw3Lexgm7vPdkcUn2SKE9dVuS2id48=;
        b=DphGq5w8fTA9P8btDTfJ5zSuWiUqkBsipbNJxSd7AT4lppFQdUFZ7KcGBCWyFe2JHF
         zNxZX2FhCYu43b/IeOBZCbXdujXfe/LR95aihqQDqRHSr0qN7Esqp/mZCm3RKFTkM2JI
         NnJV/Q0j9ej7C9LkQtgTYXRYN+ORfkEs5uW9D4t/T008ILWC91S7gruY/ZEL8VcaIxoJ
         w+FAVDRcKLxSz9Brwu/H/4+lgCdQkr8lYSYq3z0hwEaMlO2W951NPlUeO1tQJHoNexIz
         nUs1vXR0fAXQKew+CHMlMCHJ6w06xyWcwPaVywsB9voxpegnM9NLJgA9Qyy3K7euPu93
         eV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LAC4lPRFAZrMekw3Lexgm7vPdkcUn2SKE9dVuS2id48=;
        b=kmym9T1GyXUynKJnhPVi39jHFCtqWH6XeVDp128jGcuYyJF5/GixFoWn++JJIJZWx6
         QzLpEbMwbWl5cpZ6D8R72NmItp+2mJk0LBRR8WwdAJBeUQFypztgyCmKDJIRseS05T2y
         7smGszXejUGDf3dBSanPKV5Wwtv7Jco7qgYoxBje9M111sxy14GQ2ZGvieEazghgfmpH
         raJgT+UjvvtAc5NalLJoINum9KZN9muYPN9EQlf3nwG8CtUI7M6mYsMjQvah6y3nquq7
         JdO0HFykjfHiRPGKJJA98s7V6YVp5XedHPMP2/LQPbmCT/5+HocFr3xPgIRAJlsjisIi
         k3IQ==
X-Gm-Message-State: APzg51D5BubcHZSLFi7XsBB0AgTx+JIIrzutn7hZsfz9bhNKUBMz5n91
        ZOUE3/cuaDrK/BPcHrjdqfBd8mZ0
X-Google-Smtp-Source: ANB0VdbmG4hN7pxOWdGSPXQU1ed0WVpXNJdaeXCiEkipM68M07KQqqjfRb/Uo7asbLA6hKM3qChfTEDh
X-Received: by 2002:aed:3ed7:: with SMTP id o23-v6mr8800812qtf.4.1535394258988;
 Mon, 27 Aug 2018 11:24:18 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:10 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-15-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 15/20] platform: goldfish: pipe: Remove reduntant casting to (void)
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

Casting to (void) is no-op.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index cab1935a04c5..fb37499731a4 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -368,7 +368,7 @@ static int wait_for_host_signal(struct goldfish_pipe *pipe, int is_write)
 	set_bit(wake_bit, &pipe->flags);
 
 	/* Tell the emulator we're going to wait for a wake event */
-	(void)goldfish_cmd(pipe,
+	goldfish_cmd(pipe,
 		is_write ? PIPE_CMD_WAKE_ON_WRITE : PIPE_CMD_WAKE_ON_READ);
 
 	while (test_bit(wake_bit, &pipe->flags)) {
@@ -748,7 +748,7 @@ static int goldfish_pipe_release(struct inode *inode, struct file *filp)
 	struct goldfish_pipe_dev *dev = pipe->dev;
 
 	/* The guest is closing the channel, so tell the emulator right now */
-	(void)goldfish_cmd(pipe, PIPE_CMD_CLOSE);
+	goldfish_cmd(pipe, PIPE_CMD_CLOSE);
 
 	spin_lock_irqsave(&dev->lock, flags);
 	dev->pipes[pipe->id] = NULL;
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

