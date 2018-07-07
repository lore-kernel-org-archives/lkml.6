Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E3CC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5204C20862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQdtMGBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5204C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGGDiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:38:07 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:49559 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932681AbeGGDiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:38:03 -0400
Received: by mail-yb0-f201.google.com with SMTP id t10-v6so12917739ybg.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=xwRfAR8R1iMce9FKNfNsdxRX8PFHVpGWUGEPMPwjt6Q=;
        b=lQdtMGBFUJyF0qmOKtEgFTek8nmGp5hMFT4dDbWIYWJp4vH7jWOpOVZDDBjPU5kovb
         n0X45lvB1edIJQk/hM3w1A9EmcqSJ/555KRfhPpr7agkyTjDPI5hDP/oz1RJ0UBD2LPZ
         x7z+FlhCr7xC5H1PyU553lzHiJW95ndYwDgDg5jgbvzRM1pSzpP9bn+iWKui40rb1U53
         JM9ZEDvybe2noGCvoC3siN7V43NvgyRVM8ICLUoXpf3irziEIoxG1GHhoq6r4le2Ff+8
         NF5/au8ES/iSPu3mz58/qg7YrhumwC+UlIC6Ktydnw2PgSNtV71gwehGzObgoK/A2IlI
         SmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=xwRfAR8R1iMce9FKNfNsdxRX8PFHVpGWUGEPMPwjt6Q=;
        b=UN3vqEEZ3u6EEANSf0E/uC582ZiY3k3ISFKC8KW6Q6qUzLGwoZQ0m78SbJhLNvfwTj
         n2RELe2cVTY5i3yw3p/EMmxrnq57q0NTb+w0VGZ6qfb+Os423zu11eUf2ucH5qVU1sU9
         5kITLmOSO1P7+5zIDTzU7UHfvAR+FGkT2iKBZRo+f18BVpSVPcRL6Hi/10iTTKHClUNT
         C//hd7Z+/myQq3wsp1HGfLN4CzbjhGcdggP0koj3gH/EIOItBmMdcyDTrsaD+hxg2p76
         VhZ/t1rK7pNrNamNZIArw2O0rkZcyAzLxvTYJ7g5KkW8CwdS5F06xVWfEjDTkyI5WUIY
         3E8g==
X-Gm-Message-State: APt69E2L+jwrTlqUhO+JpFxSJ95RyhVk7FfTza3cdQEe3lB/dE8Qg3ub
        94O1cA0uV/wTGwh2PmWD/YXnBVL/7A==
X-Google-Smtp-Source: AAOMgpd+okfJm07IlT2WMlgufMnTQikIfMT8mMDjcRwe6atfO+I37EQ2E7psR5sgRHaqZMFSKZa/Y2xgiw==
MIME-Version: 1.0
X-Received: by 2002:a81:5555:: with SMTP id j82-v6mr3874405ywb.132.1530934683053;
 Fri, 06 Jul 2018 20:38:03 -0700 (PDT)
Date:   Sat,  7 Jul 2018 05:37:22 +0200
Message-Id: <20180707033722.219468-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] mtdchar: fix overflows in adjustment of `count`
From:   Jann Horn <jannh@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, jannh@google.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first checks in mtdchar_read() and mtdchar_write() attempt to limit
`count` such that `*ppos + count <= mtd->size`. However, they ignore the
possibility of `*ppos > mtd->size`, allowing the calculation of `count` to
wrap around. `mtdchar_lseek()` prevents seeking beyond mtd->size, but the
pread/pwrite syscalls bypass this.

I haven't found any codepath on which this actually causes dangerous
behavior, but it seems like a sensible change anyway.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/mtd/mtdchar.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index cd67c85cc87d..02389528f622 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -160,8 +160,12 @@ static ssize_t mtdchar_read(struct file *file, char __user *buf, size_t count,
 
 	pr_debug("MTD_read\n");
 
-	if (*ppos + count > mtd->size)
-		count = mtd->size - *ppos;
+	if (*ppos + count > mtd->size) {
+		if (*ppos < mtd->size)
+			count = mtd->size - *ppos;
+		else
+			count = 0;
+	}
 
 	if (!count)
 		return 0;
@@ -246,7 +250,7 @@ static ssize_t mtdchar_write(struct file *file, const char __user *buf, size_t c
 
 	pr_debug("MTD_write\n");
 
-	if (*ppos == mtd->size)
+	if (*ppos >= mtd->size)
 		return -ENOSPC;
 
 	if (*ppos + count > mtd->size)
-- 
2.18.0.203.gfac676dfb9-goog

