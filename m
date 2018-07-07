Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C773C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A2C22511
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mL7gzcdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A2C22511
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeGGCQk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:16:40 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:39337 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbeGGCQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:16:38 -0400
Received: by mail-vk0-f74.google.com with SMTP id j68-v6so5353763vkj.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=TlDQrcrv+2J/btlJfup5HwpvIbZycK5ELu7EpFC0Ap0=;
        b=mL7gzcdwUBtkPn6wDWTOGQ7W95QR9/py3zUuEAjXm9K3Hi+iadcWaoAW5f+HHLkNMu
         /tJ+aI2Y+oO2xDhqZj7X6zXn8TfFyD+HKreTQXKcZZz+34R2W59ki0N0VTyRVDf7jMg7
         +Le9hdxYtJWoEgxjIDwQ+aJYlpKZIjSzYXJja3o8GBm6mADGAFIJCApPAM5EOKzPbHBe
         9WTnsQs5lPN/+T08Mt02Z8lRUY41EwGbXFW1koIHyy97uXGRug4w1F17YWf0ThTBwVjk
         5+Sa9365JzZKk4nREQgyc2td0sBFeg7URH4qALQCUzHlSovQFsKRINOuuwkdts+SZoNy
         WgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=TlDQrcrv+2J/btlJfup5HwpvIbZycK5ELu7EpFC0Ap0=;
        b=hjsfo3Bt3n9MlxjKR99cEeZEwdZ+Yl6jsJ2KkXhaBpvoeE/dru+qPJFwq94dPyNTss
         aeQmIhWxcQ4fTu3hbHMhZ3lXLWjH+Eq27vqBB82c7+yMh/ngVASeqKzSKKhMVcXUqZcU
         gxgmKUjOotu607WxMYwyBEfHXWbt8aEtqqZtsC5xt7NmzDvkCEN+7LZzagp6eBJKL9GQ
         I0ubysR/rg0yGpo1E0qUydMZtgLE7s0Y43SKQTeMOPE0CiDqLvNTefL/wwWw/0QoFYEf
         AEOfZfFsczscC3PkFX8LIev6XqVLlQ8sErzkbfkbtCUaZejL8b1rIbGfWm785rPnr67C
         4gVQ==
X-Gm-Message-State: APt69E0MMfMtFP3qnaCym4RSb1jJizplhhEE2h4qaJMO+WQIv6G1zo0I
        4rshARqeZFf9JSViMNXkfqL9Y8SLyw==
X-Google-Smtp-Source: AAOMgpeaOpnID0DM5adr+IAdxpqdHQGcIZR9FLew9SBvYLulY/F4lzaSIDTXeTPQlTq9vmnkQyY7LvvwLg==
MIME-Version: 1.0
X-Received: by 2002:a1f:3bc2:: with SMTP id i185-v6mr5566185vka.25.1530929798105;
 Fri, 06 Jul 2018 19:16:38 -0700 (PDT)
Date:   Sat,  7 Jul 2018 04:16:33 +0200
Message-Id: <20180707021633.185004-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] ibmasm: don't write out of bounds in read handler
From:   Jann Horn <jannh@google.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Max=20Asb=C3=B6ck?=" <amax@us.ibm.com>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This read handler had a lot of custom logic and wrote outside the bounds of
the provided buffer. This could lead to kernel and userspace memory
corruption. Just use simple_read_from_buffer() with a stack buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
NOTE: I put a "CC: stable" tag on this commit because it's a simple
change and I don't know whether bugs in this code matter; I don't
have any idea what the userland for this looks like.
If it's not important, feel free to remove the tag.

 drivers/misc/ibmasm/ibmasmfs.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index e05c3245930a..fa840666bdd1 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -507,35 +507,14 @@ static int remote_settings_file_close(struct inode *inode, struct file *file)
 static ssize_t remote_settings_file_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
 {
 	void __iomem *address = (void __iomem *)file->private_data;
-	unsigned char *page;
-	int retval;
 	int len = 0;
 	unsigned int value;
-
-	if (*offset < 0)
-		return -EINVAL;
-	if (count == 0 || count > 1024)
-		return 0;
-	if (*offset != 0)
-		return 0;
-
-	page = (unsigned char *)__get_free_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	char lbuf[20];
 
 	value = readl(address);
-	len = sprintf(page, "%d\n", value);
-
-	if (copy_to_user(buf, page, len)) {
-		retval = -EFAULT;
-		goto exit;
-	}
-	*offset += len;
-	retval = len;
+	len = snprintf(lbuf, sizeof(lbuf), "%d\n", value);
 
-exit:
-	free_page((unsigned long)page);
-	return retval;
+	return simple_read_from_buffer(buf, count, offset, lbuf, len);
 }
 
 static ssize_t remote_settings_file_write(struct file *file, const char __user *ubuff, size_t count, loff_t *offset)
-- 
2.18.0.203.gfac676dfb9-goog

