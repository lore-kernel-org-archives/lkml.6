Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9836CC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBDB206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBDB206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeI2VSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:18:40 -0400
Received: from mail.windriver.com ([147.11.1.11]:54632 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbeI2VSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:18:40 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8TEnltv023766
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 29 Sep 2018 07:49:48 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Sat, 29 Sep 2018 07:49:46 -0700
From:   <zhe.he@windriver.com>
To:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH v4 3/4] printk: Add KBUILD_MODNAME
Date:   Sat, 29 Sep 2018 22:48:48 +0800
Message-ID: <1538232529-72706-3-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538232529-72706-1-git-send-email-zhe.he@windriver.com>
References: <1538232529-72706-1-git-send-email-zhe.he@windriver.com>
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
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c9a0be3..b84aac0 100644
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
-- 
2.7.4

