Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA70C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D99C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbGMpnwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D99C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeLKQhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:37:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36257 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeLKQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:37:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so7388977pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wa82Ew3EEO0OmG3HK41kwHA4nBqZOw+bVBkKKSudUBo=;
        b=WbGMpnwp5VzjfAs0yFvhafLYjuw9M8pahX/5gUsVCwghOsyg+JCw9epZr0tpCfVDfd
         d1K9DKe6JfS4j61vbk6Z3M9ginRTOyo+GVK9BIWdyeNZiUqggnsjit0YaPsHi0Uyl05Z
         iIgqXCcBWdhHzEeg+knQ48CcHKnHZs5L8Y/l8TGxvJpq5TKwzrztthVmCC8YfzNpC+Js
         2AfDsHWMHgAL/JqF4Z9CsG+UjAsAvOgpPPnyeeFLeEa3YNzGxP+NSOuSBYQw9lSnWPnU
         TngwsYLMUqKAhiMFPiAqTjXwjwACQAEuXHLDRvVGjCsSc6Uk/5e9smIDu3pMR7LjNaPW
         1rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wa82Ew3EEO0OmG3HK41kwHA4nBqZOw+bVBkKKSudUBo=;
        b=sX3ILj5g4G2M7k99GZ9jq1GSjS8BlYD2Rih9hJhs77vxSX9MYf7Tglammr55YUueNs
         WYYyVeq9e0DwNxYu3e8LxjRJFD6l2F/6FbLJ5a1aAqVKNEEB1DqncG/tsI7pszCL+nPj
         x3pq/RGuEyq0cY9Q1rDRe0jKQgFajnvlZVluaZnd4uFbPNi71akIZFokGDLHyapGpcz0
         Pv7/3j4E2bH9DO/X+e+9VQm6/Di98138lAGD6ZQY3X97ozv9h64DRR92Buwm3MI43Btv
         4wmHHtRkz99fh53Gy7kjJGg0jb7c61NOFMYCxONxYUUC4jtMeDuQuYmaXj6TUet4lWKi
         KK8Q==
X-Gm-Message-State: AA+aEWaVpAsbkFtCJEPyPuwusOtvNLLNt0BmgDyf9pC56OIDcHs0H7C5
        sRvKkeily92nEaf34xbde+4=
X-Google-Smtp-Source: AFSGD/UrTuGMRm/bpeCDBv0M/KqHpfD01QTEaeEmpaOkliRAz9t/248/xI18h/CFdGOfGGL5BSnhYA==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr16779140pfe.152.1544546267250;
        Tue, 11 Dec 2018 08:37:47 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id w10sm18576817pgi.81.2018.12.11.08.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 08:37:46 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] timekeeping: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Tue, 11 Dec 2018 11:37:44 -0500
Message-Id: <20181211163744.22133-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/time/timekeeping_debug.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index 238e4be60229..a937300df452 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -28,7 +28,7 @@
 
 static unsigned int sleep_time_bin[NUM_BINS] = {0};
 
-static int tk_debug_show_sleep_time(struct seq_file *s, void *data)
+static int tk_debug_sleep_time_show(struct seq_file *s, void *data)
 {
 	unsigned int bin;
 	seq_puts(s, "      time (secs)        count\n");
@@ -42,18 +42,7 @@ static int tk_debug_show_sleep_time(struct seq_file *s, void *data)
 	}
 	return 0;
 }
-
-static int tk_debug_sleep_time_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tk_debug_show_sleep_time, NULL);
-}
-
-static const struct file_operations tk_debug_sleep_time_fops = {
-	.open		= tk_debug_sleep_time_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(tk_debug_sleep_time);
 
 static int __init tk_debug_sleep_time_init(void)
 {
-- 
2.17.0

