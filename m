Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BDFC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B402082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klra96Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B402082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeJCFGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:06:25 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:57304 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:06:25 -0400
Received: by mail-pl1-f201.google.com with SMTP id v7-v6so3996721plo.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QkSX0jMYrsg+ctosVnJt3SWNB+wWVP6PkDmWoypdc8E=;
        b=klra96VbyD+TxdbIjLoP8tSWFaXHuSicDTzAqFQOjRLapp84/yJFwyx/JFeGTR4nhG
         qTXW+J8kyH4mYq+PZwtGmflatPR0u9RN8Jb6pwsGaCtNviT8nqaOK9sikvQyu5Zmd/oK
         gzUiAc01XrnIz7aH/ToWrsxl+b5JO/XTXV4JF9KWBNM17On1BbqQrUZDTslWJl3z3rt7
         uM5ryKRmdsNEaoSChCnvfMj1KSGnGIcX2QsYOB96Yf1nnyhyYByQ2mZjNSd/ii0LI9d4
         RExgS1hU29pxfzr0FLTEs4xrmZUm2iG2GLFssjSqKEKw8VgucWvexHs6VKVQKM5jD9LX
         mniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QkSX0jMYrsg+ctosVnJt3SWNB+wWVP6PkDmWoypdc8E=;
        b=qsjMmaD67RxK11oESfuahEfaCi+rqbF8UU7qLaxqwdhFNYBR43cAErayYU1taHnYw/
         rdTdsptwdubzx8T0zJTLlvn/oVMwZVas2ao3ZzRkFY0bunFsZb1BBGp/v01rwut8LO+s
         xkuHLZ1o2g5XkNbNqGOViDlItUD1Ww0M7dbd1jJp4REBEECojUrMv8mXc96QFf7gYYxt
         7kd0eQUETXu5jW+ULFNe6ITO4pQlCpQabBmcRkfbVHxEoEwfrsjEyG8byYImeY1dDTQO
         MbNo+hRPHH5L3kL+ZrJHBDj7+agKZ1wcetwPxVeZ3AaeVjg/epuuNK71k7SyOJOHWC4Q
         VN+g==
X-Gm-Message-State: ABuFfoi9xt83GUEYpiJGWxT8WEG8WxuaYWHOZvS3ocsbKjvuVn9YcG+p
        pA1AKvYS4b65LLOj9N1l9WQ2eIwE
X-Google-Smtp-Source: ACcGV63TA0uL7eADTeQL5b5XCgT8e2YPA+iIRlKcVn/49CBkB4ulXyPtx71VfIk1fup9PY6ZWXZj+UJH
X-Received: by 2002:a62:cc4e:: with SMTP id a75-v6mr8396380pfg.38.1538518850448;
 Tue, 02 Oct 2018 15:20:50 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:19:01 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-13-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 13/15] platform: goldfish: pipe: Add a dedicated constant for
 the device name
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

Create a constant to refer to the device name instead if several copies
of a string.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.h    | 2 ++
 drivers/platform/goldfish/goldfish_pipe_v2.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.h b/drivers/platform/goldfish/goldfish_pipe.h
index ee0b54bcb165..0fa6ecb32c6d 100644
--- a/drivers/platform/goldfish/goldfish_pipe.h
+++ b/drivers/platform/goldfish/goldfish_pipe.h
@@ -2,6 +2,8 @@
 #ifndef GOLDFISH_PIPE_H
 #define GOLDFISH_PIPE_H
 
+#define DEVICE_NAME "goldfish_pipe"
+
 struct goldfish_pipe_dev_base {
 	/* the destructor, the pointer is set in init */
 	int (*deinit)(void *pipe_dev, struct platform_device *pdev);
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 9857ce07d0e6..0e2a62322477 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -775,7 +775,7 @@ static void init_miscdevice(struct miscdevice *miscdev)
 	memset(miscdev, 0, sizeof(*miscdev));
 
 	miscdev->minor = MISC_DYNAMIC_MINOR;
-	miscdev->name = "goldfish_pipe";
+	miscdev->name = DEVICE_NAME;
 	miscdev->fops = &goldfish_pipe_fops;
 }
 
@@ -806,7 +806,7 @@ int goldfish_pipe_device_v2_init(struct platform_device *pdev,
 
 	err = devm_request_irq(&pdev->dev, irq,
 			       goldfish_pipe_interrupt,
-			       IRQF_SHARED, "goldfish_pipe", dev);
+			       IRQF_SHARED, DEVICE_NAME, dev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to allocate IRQ for v2\n");
 		return err;
-- 
2.19.0.605.g01d371f741-goog

