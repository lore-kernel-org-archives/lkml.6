Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B92C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2D8208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BqmaXo0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2D8208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeH0WLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:38 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53149 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:38 -0400
Received: by mail-pg1-f202.google.com with SMTP id m4-v6so11461651pgq.19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RzNeoAFkebhXg0R57+D1/uloGc/nij2JUFUJGLdnqbs=;
        b=BqmaXo0E6SpWa0Cp1YqgJsqgRf2xDDZDUPQhXgcAkvAlVvhzZQzkkLNQQjDMzMi1Vz
         S8q85U/pik22lkC9mFXkNFc309Y7rM0KWcMdPPx2+qDsuAL7fJxG0EZO47hQCHvuq7tg
         zvuSboPReCzv4HG9PAP8UmtG0HefvjOYPx4DHJco5R87wV/QIcJee0BI04LmubqCV581
         iWBqlFj5XZYqu6Um3i/Ev/KC5KRi8X4uwB6mQuZI+yKGs3uNMeTETx+vmY/jcGIfHKJH
         T+0lQA8rQx+88kQDybtdRhm4cYvEP/eiptb45nuTYVS9B4+BGYp6Q31iLfFXobOpLhVk
         T57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RzNeoAFkebhXg0R57+D1/uloGc/nij2JUFUJGLdnqbs=;
        b=MUqbyNic21l9Mjts+K6aKCXAGrqEGlUt9JtiNlSKCyVOmxNgSyOftOY1Lin/fjEkno
         VsnVXDNVx4KJq7VYW7JYSoD5+4ix2eNePiVwEv7XW7LshhL7W/6nC8yxq1rsyPy03w1Z
         WSxKZ48PmG10FsU17sbY2UxuO+CmBKArAYfpzU8WW6M5zYX9bUfsmMMJaAaGT5MCX3u+
         puYMoKMTqcpwN58Hj9w6RYDTOJmISv/BAr3hPo8e+XWW+OEo5FuCDZLZmn/W3ezAQ/Zm
         Hdgy9dvaNUW3bwfOVpOwBVuiAOB1YxRNrN7PWU3eS9tGYGBbOUTK1iFnD9RlWkRd5cL/
         FDzA==
X-Gm-Message-State: APzg51Adz2Od7nqWso74wPIyb8XR7gwpFs2q+585TsjkgbpA8JY18hlh
        F3GMvQBh+6HRFmKQ/kHt8tDN35cs
X-Google-Smtp-Source: ANB0VdZRXu+GmmdD5biX1gnuPkXkv3c7QOAeRVFVOqpDWOltB7oTlaLmE2tfEAFlTR0q9zktHx79pIN0
X-Received: by 2002:a65:430a:: with SMTP id j10-v6mr3396774pgq.92.1535394236285;
 Mon, 27 Aug 2018 11:23:56 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:03 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-8-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 08/20] platform: goldfish: pipe: Replace pr_ with dev_ for logging
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

dev_ is preferred if struct device is available.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index e9e3e791c0d4..a61cd444e8ff 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -199,6 +199,9 @@ struct goldfish_pipe_dev {
 	/* Head of a doubly linked list of signalled pipes */
 	struct goldfish_pipe *first_signalled_pipe;
 
+	/* ptr to platform device's device struct */
+	struct device *pdev_dev;
+
 	/* Some device-specific data */
 	int irq;
 	int version;
@@ -434,7 +437,8 @@ static ssize_t goldfish_pipe_read_write(struct file *filp,
 			 * err.
 			 */
 			if (status != PIPE_ERROR_AGAIN)
-				pr_info_ratelimited("goldfish_pipe: backend error %d on %s\n",
+				dev_err_ratelimited(pipe->dev->pdev_dev,
+					"backend error %d on %s\n",
 					status, is_write ? "write" : "read");
 			break;
 		}
@@ -787,6 +791,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		return err;
 	}
 
+	dev->pdev_dev = &pdev->dev;
 	dev->first_signalled_pipe = NULL;
 	dev->pipes_capacity = INITIAL_PIPES_CAPACITY;
 	dev->pipes = kcalloc(dev->pipes_capacity, sizeof(*dev->pipes),
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

