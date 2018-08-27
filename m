Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D50208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XG/K6V21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D50208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeH0WL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:58 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55268 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:57 -0400
Received: by mail-pg1-f201.google.com with SMTP id o16-v6so11498481pgv.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J4vJO5Ywy8DYy/g0zXHn8P/AyhW+MnXHf1uAvgvYs2I=;
        b=XG/K6V21bcCAH+9eAbPSFM9BAYjEvHKWdR8xn8epK/EB7Mjbe5UFLevsaLQ5SiVNvd
         MeYDg7L+/DPnb4yAbEDoLafCCdvI2wn/eLuExPVIaNX+UfmDIY93E+RBnaz69+MwK6lI
         BL8lf4Cq7sWGb/kvcWUEwrrCUPNGN9M2tofa7onTnsUDxnps5mJQtnq9HMZiMjBxizcd
         8fOMxW3uuNzFNMNZ4DbQy0rt+wS/cneTV4fJc4jmUxVJMzop4ejJoq4LqEZzYqv4KsPH
         /13krCm3QCXajfBWjBuu4gD5EUXaTWdi+VmOVfT8Jh4DQabBmztt+HujClOefml7LC4i
         AKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J4vJO5Ywy8DYy/g0zXHn8P/AyhW+MnXHf1uAvgvYs2I=;
        b=UhPfeGma52MoBGOqZEdXJoyP8cUueHm1QPOnd200UIYl/0MCMeiTJWOlUM2MgIFXsg
         AnZGeh1i14y3/tjMQ+RaPdDs7uc3oBUczaAcjnMvINzaDYPS2/TyRPWAETqVNxxz0ToG
         x8a3YxMKsdgsDTyLR9auMkj9HgdMqA8eTSJ9LU8WusvTWSNIVjBOHp2sQBWpkWeG43MP
         dNuT/jAhjeZ2wH1F/Kgiiy6QZeNUh1dj+7fNbXIukPf3VL1vlmHs0I22puTNc56JC56W
         ax/NZw64lCheAzIucvFuESyRzLmTGJUr2my4w9Vl4IMF3Nv8VxJ/+NB0+FRjBIaBYWLv
         /Grw==
X-Gm-Message-State: APzg51DSknxCo7KrZomNJyScptoVRrWTDcto/Rew7ActDTPnnHmLEFXN
        p/bWiSAylFQ3QpyYLrJrVhx0eYAw
X-Google-Smtp-Source: ANB0VdbEQac023wOGg+zIZ9yQ0qry2g03/ilasH/1zPThG7gQeWdpCFfl+6i/SD3S2JX2k2EvWt7xulR
X-Received: by 2002:a63:e746:: with SMTP id j6-v6mr3343926pgk.83.1535394255839;
 Mon, 27 Aug 2018 11:24:15 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:09 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-14-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 14/20] platform: goldfish: pipe: Rename 'wakeBit' to 'wake_bit'
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

checkpatch: Avoid CamelCase

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 14441e7106ba..cab1935a04c5 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -363,18 +363,18 @@ static int transfer_max_buffers(struct goldfish_pipe *pipe,
 
 static int wait_for_host_signal(struct goldfish_pipe *pipe, int is_write)
 {
-	u32 wakeBit = is_write ? BIT_WAKE_ON_WRITE : BIT_WAKE_ON_READ;
+	u32 wake_bit = is_write ? BIT_WAKE_ON_WRITE : BIT_WAKE_ON_READ;
 
-	set_bit(wakeBit, &pipe->flags);
+	set_bit(wake_bit, &pipe->flags);
 
 	/* Tell the emulator we're going to wait for a wake event */
 	(void)goldfish_cmd(pipe,
 		is_write ? PIPE_CMD_WAKE_ON_WRITE : PIPE_CMD_WAKE_ON_READ);
 
-	while (test_bit(wakeBit, &pipe->flags)) {
+	while (test_bit(wake_bit, &pipe->flags)) {
 		if (wait_event_interruptible(
 				pipe->wake_queue,
-				!test_bit(wakeBit, &pipe->flags)))
+				!test_bit(wake_bit, &pipe->flags)))
 			return -ERESTARTSYS;
 
 		if (test_bit(BIT_CLOSED_ON_HOST, &pipe->flags))
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

