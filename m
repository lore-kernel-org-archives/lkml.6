Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB598C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58CE21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxzgyLK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfBLOzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:55:06 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39646 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbfBLOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:55:01 -0500
Received: by mail-yw1-f68.google.com with SMTP id k188so1096720ywa.6;
        Tue, 12 Feb 2019 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBi4iWHzkOTf6erCHihsCZEcXXpaip/u9aLYjX+/qYo=;
        b=jxzgyLK3E/2hzKKmOdEr+FLZtRgeRc+YbXVOpT9u0DxZX0EgdBLFExYMySREDj6yjF
         yQ7Km9P/eL+6Gm8PAcKrsshN9dUL0BEttEfIUhIMGCuon7DPHpx65gE2OzPI92c5vjtU
         ukZG3Nsj42Sdu0RMFQXeZk0M0w45x770JSEIPyhamGFl+qn2JdUXexy0yvAUkfa7gQTS
         kphe+zEydlRzTiz6DFX0sqmdEL+MtxaHqC3FOSX8yGH/w2O5yum2sSlTpaRRKqgcvSEI
         jp1JePufDPJeMq1g82POl5KDBAmKmDUzP+y6Ul5Rk6OscwyXPaEjpLy/D3ZcX9byfsGY
         8JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBi4iWHzkOTf6erCHihsCZEcXXpaip/u9aLYjX+/qYo=;
        b=qEB/dORd31PE31icBRJjMnz0kEmCWi/VNGjQFvC1Alvu9JDsMm2XB/N8qsr4kzjMvJ
         mIq1l4T/QvgDQDzvi+XnC8o2CdlAj/MnuGogRYiZiWcuw6DUrTdEovY6YpANn0bTK2q/
         BLYM2gEpANWV/m+AFD3b9cyPx9oopkJXn+QnIqP3U9b3phi8+8yytzBXiXeMvYGkvZ0i
         SmLQPJb1AG5EqG1pAwK26gLhiYMyi7UFvAYsmmguc5JIkIQQPRgkaHxlZVWZpEk0DldQ
         y77qymPtmhLSn9tKGkpMgl2eK7/4q4AwtU7Drt66Tryxq/CI6xSYT0rMdqyT9mFWsJk5
         dL3w==
X-Gm-Message-State: AHQUAuaXpUsbJk/iq31LXuKQG9ZyAj+KkAkVjc8+cF9e/6slbZxaBV9N
        PsHKzSytsVwveU6L2mDkrIWVGrIoH+hqrQ==
X-Google-Smtp-Source: AHgI3IZvaQAI0dqXCpVYiCcvGd/s+4YOleD1vbbBKVAcMLckw/MtOjrqG7RK3pqX/PBW1XPkvkc28g==
X-Received: by 2002:a0d:cc08:: with SMTP id o8mr324963ywd.506.1549983301028;
        Tue, 12 Feb 2019 06:55:01 -0800 (PST)
Received: from localhost.localdomain (c-73-120-18-128.hsd1.tn.comcast.net. [73.120.18.128])
        by smtp.gmail.com with ESMTPSA id v134sm4987967ywv.90.2019.02.12.06.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 06:55:00 -0800 (PST)
From:   demiobenour@gmail.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Cc:     "Demi M. Obenour" <demiobenour@gmail.com>
Subject: [PATCH 4/4] Return -EINVAL if userspace passes bogus flags to open()
Date:   Tue, 12 Feb 2019 09:54:47 -0500
Message-Id: <20190212145450.2200-4-demiobenour@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212145450.2200-1-demiobenour@gmail.com>
References: <20190212145450.2200-1-demiobenour@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Demi M. Obenour" <demiobenour@gmail.com>

While testing the O_PATHSTATIC patch, I discovered that Linux does not
return any error if an invalid flag is passed to open(2).  This prevents
adding new flags without a (minor) risk of breaking userspace.
Therefore, add a check for invalid flags, and return -EINVAL if any are
found.
---
 fs/open.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 717afa8179c0..eeaa2eeb342a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1074,6 +1074,13 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
 	if (fd)
 		return fd;
 
+	/*
+	 * Enforce that open flags are valid, to ensure that new flags can be
+	 * added later.
+	 */
+	if (unlikely(flags & ~VALID_OPEN_FLAGS))
+		return -EINVAL;
+
 	tmp = getname(filename);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
-- 
2.20.1

