Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA97C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E30820666
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E30820666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeI2XQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:16:02 -0400
Received: from mail.windriver.com ([147.11.1.11]:62813 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbeI2XQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:16:01 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8TGki9f004931
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 29 Sep 2018 09:46:45 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Sat, 29 Sep 2018 09:46:44 -0700
From:   <zhe.he@windriver.com>
To:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH v5 3/4] printk: Add KBUILD_MODNAME and remove a redundant print prefix
Date:   Sun, 30 Sep 2018 00:45:52 +0800
Message-ID: <1538239553-81805-3-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

Add KBUILD_MODNAME to make prints more clear.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: pmladek@suse.com
Cc: sergey.senozhatsky@gmail.com
Cc: rostedt@goodmis.org
---
 kernel/printk/printk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c9a0be3..0f24d7f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -16,6 +16,8 @@
  *	01Mar01 Andrew Morton
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
@@ -2695,7 +2697,7 @@ void register_console(struct console *newcon)
 
 	if (newcon->flags & CON_EXTENDED)
 		if (!nr_ext_console_drivers++)
-			pr_info("printk: continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");
+			pr_info("continuation disabled due to ext consoles, expect more fragments in /dev/kmsg\n");
 
 	if (newcon->flags & CON_PRINTBUFFER) {
 		/*
-- 
2.7.4

