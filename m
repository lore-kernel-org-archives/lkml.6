Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08ACC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A7E20811
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKKUpkyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfBKHKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:10:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53182 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfBKHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:10:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so15348523wml.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pJDTP7mCsklk3nViQJv5AOFah5JzvwIeag63XXIc8Dw=;
        b=BKKUpkyqjg9udhTObxCCbnmHJx5z55WAGysCuLMZfBc6MXepdXSoQ92sB5spKnPLf7
         NtA/kvRmOX4H4fgU5uH+yE+ZamIGfZL6XbdibbfI/7yPG6dD133KlS9bpZKmLk1rW+/m
         p1LeaohUyiGdFWcRky9GF6mVV8uJS2XC0wrL0lkNYX0C/JJkCw2g+1deFpXQKF863+z0
         4J5SLqqvropXhW0/MZw5j77lJl+PlSjFbKSVKS2b1IQ64fbo9uHELKRI4AxnWGezNQCr
         17eU3CMU7MjvJ16uxvLBI2mW2o0lMQ3yNCeT2lyvyXy+tvLYYrTDo9UmXWN0bX/3PsdO
         dpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pJDTP7mCsklk3nViQJv5AOFah5JzvwIeag63XXIc8Dw=;
        b=PMBL1gxZVxpfD62EWhkv29RCctKib4cv0FFKd/UrshEYwG7WC1T9wEO5Btv1d0Jr34
         lizPbx/WQGGVkk8uo/eQNLLSPvDpLPTwzeRiZmjqqg3TbnItWmFCFWs6/UbT/q36eFR7
         7gNXPSW3VJYW+2UMjhqPxeNhNSQI/O9C1CzUjeTRGYqvAZuCmWYmGZ8z8ZLc0I8sC//N
         2616OzLHcg3AsGsBNGhejPIMSi6ikfYqAJpH6DCdXg4n4wRJ63jgsbvDgpuQiyycK3fB
         I5mfHKBE4zbt36jRRCDMvDMuW9CRNwgdo1syWCV9ojvpuxzVO8zR9fpg0AuAFeg3KE5t
         IW8Q==
X-Gm-Message-State: AHQUAuYN3bAdzv3NLq2aEAT2NvkO5SHjwvJsNcaaNH6mbbDXkrKenVQT
        uJI1Q1frAIj5hj0i1R854eJqSbdM
X-Google-Smtp-Source: AHgI3IaxBRUz0nS0fKqllnaWXY68uGxW1k8mkQkq5wrXFuvwFcvL3EZYda1+ruOSGwvXxcqgcNwvBw==
X-Received: by 2002:a1c:35ca:: with SMTP id c193mr7878275wma.146.1549869028650;
        Sun, 10 Feb 2019 23:10:28 -0800 (PST)
Received: from sahara-ad.darkmatter.uae (bba391524.alshamil.net.ae. [83.110.105.110])
        by smtp.gmail.com with ESMTPSA id v132sm11085632wme.20.2019.02.10.23.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Feb 2019 23:10:28 -0800 (PST)
From:   kpark3469@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     keun-o.park@darkmatter.ae, peter@hurleysoftware.com,
        jslaby@suse.com, maninder1.s@samsung.com,
        gregkh@linuxfoundation.org
Subject: [PATCH] tty: pty: Fix race condition between release_one_tty and pty_write
Date:   Mon, 11 Feb 2019 11:09:15 +0400
Message-Id: <1549868955-13528-1-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahara <keun-o.park@darkmatter.ae>

Especially when a linked tty is used such as pty, the linked tty
port's buf works have not been cancelled while master tty port's
buf work has been cancelled. Since release_one_tty and flush_to_ldisc
run in workqueue threads separately, when pty_cleanup happens and
link tty port is freed, flush_to_ldisc tries to access freed port
and port->itty, eventually it causes a panic.
This patch utilizes the magic value with holding the tty_mutex to
check if the tty->link is valid.

Fixes: 2b022ab7542d ("pty: cancel pty slave port buf's work in tty_release")
Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
---
 drivers/tty/pty.c    | 7 +++++++
 drivers/tty/tty_io.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 00099a84..ef72031 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -116,6 +116,12 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 	if (tty->stopped)
 		return 0;
 
+	mutex_lock(&tty_mutex);
+	if (to->magic != TTY_MAGIC) {
+		mutex_unlock(&tty_mutex);
+		return -EIO;
+	}
+
 	if (c > 0) {
 		spin_lock_irqsave(&to->port->lock, flags);
 		/* Stuff the data into the input queue of the other end */
@@ -125,6 +131,7 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 			tty_flip_buffer_push(to->port);
 		spin_unlock_irqrestore(&to->port->lock, flags);
 	}
+	mutex_unlock(&tty_mutex);
 	return c;
 }
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 23c6fd2..6c4a206 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1446,10 +1446,13 @@ static void release_one_tty(struct work_struct *work)
 	struct tty_driver *driver = tty->driver;
 	struct module *owner = driver->owner;
 
+	mutex_lock(&tty_mutex);
 	if (tty->ops->cleanup)
 		tty->ops->cleanup(tty);
 
 	tty->magic = 0;
+	mutex_unlock(&tty_mutex);
+
 	tty_driver_kref_put(driver);
 	module_put(owner);
 
-- 
2.7.4

