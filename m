Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED69217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDNibeqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLRJSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:18:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42958 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLRJSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:18:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so7840441pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQ9HuvvdcTQ7lMxwsWmv/JbD48ZjUinMiJnsVuuQCJY=;
        b=QDNibeqoJAudUPtueL+O6ERyu1/nP1pN1NksUFA/r8lAcQaQppnOcAjyDqYp/Kr9f7
         PnhNGBp2/rUP6yedMl7rgtFo0jP7Zdg42xT6ZdaNYYCh1CoMsJNFWQI/yfhF3AY+tSxW
         owWaoPlDT73MDyAH5ExmAOHR/xMlPVRp30zcysyM05vQ78Kbos7KJqu34AbzYBnjjEVL
         EVayE5ra6tCIdWABM53W/G+7ul37eJ45X9OSrzACnTEWehZvbAlZZCOlgbb5rOjMKJbf
         dv+C/NNUvHWEuvil9TIigX1ZPhIcZ7NcgLxOKKmuOV8WYNSpuIM0ZWsDEX0fBUfzcFcq
         kbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQ9HuvvdcTQ7lMxwsWmv/JbD48ZjUinMiJnsVuuQCJY=;
        b=ihGz3M7FZbx8h61mVxhZuBu5eCJB3bc8jOzY3Qx7dmwY6d5VCgjG5O/U/t+KNC4m7S
         MZ5TuzbYJkiSqJEylI8STcyUK+GXvWUyOuqrG37Oy8sqOvauGUDTcucO0AExgZrlWnzc
         72QDfROAVpOXOvVKcP2WRsYJdNB9U5Z7ZlUrgFk8vvuJtrnq61gW5imHE1fE+8j/gDFC
         fQ1gULCULMn/YOfZEr+xWpeQaEnflj43be6ayIQKZEEGtXQX8FIm3CvJzmkLj72btW9B
         o3uWgN+rPbFvxp1lbo2DSpMsCpfJKy0DgucXvD3yTHkK8Geti/A6e6owisrwegE5Oqfg
         fkMw==
X-Gm-Message-State: AA+aEWaWtsTjc77y3tXlrwLxCfAG8nFNsrXXT5sBHtIQnMxdYuVQ9Hyw
        hk6wTR009QhCK6wtULDeIu4=
X-Google-Smtp-Source: AFSGD/VfcYQwsqxQGO+IrPdy4ms5Q6dGzyunn9PMuTHohj5Otq4P+3VlMFlwrCBzCY3FnCp4I5x3hQ==
X-Received: by 2002:a63:9f19:: with SMTP id g25mr15088745pge.327.1545124731420;
        Tue, 18 Dec 2018 01:18:51 -0800 (PST)
Received: from localhost.localdomain ([175.223.2.245])
        by smtp.gmail.com with ESMTPSA id x3sm47667889pgt.45.2018.12.18.01.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:18:50 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Date:   Tue, 18 Dec 2018 18:18:42 +0900
Message-Id: <20181218091842.4996-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,
	
	RFC

A painful subject:

I just noticed that stock systemd (no systemd debugging enabled) on my
x86 box write()-s during shutdown to devkmsg more than before, so old
devkmsg ratelimits do not apply:

$ sudo journalctl -n 40000 -f | grep "kernel: printk: systemd-shutdow"
 kernel: printk: systemd-shutdow: 35 output lines suppressed due to ratelimiting
 kernel: printk: systemd-shutdow: 31 output lines suppressed due to ratelimiting
 kernel: printk: systemd-shutdow: 35 output lines suppressed due to ratelimiting
 kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting
 kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting
 kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting
 kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting
 kernel: printk: systemd-shutdow: 35 output lines suppressed due to ratelimiting

I know that there is a "kernel.printk_devkmsg" interface; do we
expect every systemd-enabled distro to find that out and to tweak
kernel.printk_devkmsg or shall we change the default devkmsg
ratelimit instead?


=====================================================================

Every time I reboot my systemd x86_64 box:

kernel: printk: systemd-shutdow: 36 output lines suppressed due to ratelimiting

Apparently, the default ratelimit - 10 messages max, 5 * HZ
interval - is a bit too restrictive these days, can't help
it; so increase it to "50 messages, same interval" (which is
not awfully a lot).

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 84e54250840a..0ed54f90f208 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -998,7 +998,8 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	if (!user)
 		return -ENOMEM;
 
-	ratelimit_default_init(&user->rs);
+	ratelimit_state_init(&user->rs, DEFAULT_RATELIMIT_INTERVAL,
+					5 * DEFAULT_RATELIMIT_BURST);
 	ratelimit_set_flags(&user->rs, RATELIMIT_MSG_ON_RELEASE);
 
 	mutex_init(&user->lock);
-- 
2.20.1

