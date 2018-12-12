Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22178C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E256920851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E256920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeLLCQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:16:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLCQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:16:09 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBC2G07X102748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 18:16:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBC2G0Wg102745;
        Tue, 11 Dec 2018 18:16:00 -0800
Date:   Tue, 11 Dec 2018 18:16:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yangtao Li <tipbot@zytor.com>
Message-ID: <tip-5b20c6fd6a60e182243da31c47f2ebff5b0e3d57@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tiny.windzz@gmail.com, mingo@kernel.org, hpa@zytor.com
Reply-To: tiny.windzz@gmail.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20181211163744.22133-1-tiny.windzz@gmail.com>
References: <20181211163744.22133-1-tiny.windzz@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Convert to DEFINE_SHOW_ATTRIBUTE
Git-Commit-ID: 5b20c6fd6a60e182243da31c47f2ebff5b0e3d57
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5b20c6fd6a60e182243da31c47f2ebff5b0e3d57
Gitweb:     https://git.kernel.org/tip/5b20c6fd6a60e182243da31c47f2ebff5b0e3d57
Author:     Yangtao Li <tiny.windzz@gmail.com>
AuthorDate: Tue, 11 Dec 2018 11:37:44 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 11 Dec 2018 18:13:35 -0800

timekeeping: Convert to DEFINE_SHOW_ATTRIBUTE

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: john.stultz@linaro.org
Cc: sboyd@kernel.org
Link: https://lkml.kernel.org/r/20181211163744.22133-1-tiny.windzz@gmail.com

---
 kernel/time/timekeeping_debug.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index f811882cfd13..86489950d690 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -19,7 +19,7 @@
 
 static unsigned int sleep_time_bin[NUM_BINS] = {0};
 
-static int tk_debug_show_sleep_time(struct seq_file *s, void *data)
+static int tk_debug_sleep_time_show(struct seq_file *s, void *data)
 {
 	unsigned int bin;
 	seq_puts(s, "      time (secs)        count\n");
@@ -33,18 +33,7 @@ static int tk_debug_show_sleep_time(struct seq_file *s, void *data)
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
