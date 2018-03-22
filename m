Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754961AbeCVN7Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:59:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46207 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeCVN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:59:13 -0400
X-Google-Smtp-Source: AG47ELtydBFewTgokYXBO4RnMPFQ3dHwbQc7Oa1Hzzwnry/osUIglYGpSbnC/jcErt1WZM+NabNLcg==
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v1] printk: change message to pr_info
Date: Thu, 22 Mar 2018 14:58:33 +0100
Message-Id: <20180322135833.16602-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow userspace to prevent this message from appearing in the
console by changing the log priority.

This matches other informative messages that the power subsystem emits
when the system changes power states.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 63f4c87f7a3d..704e55129c3a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2161,7 +2161,7 @@ void suspend_console(void)
 {
 	if (!console_suspend_enabled)
 		return;
-	printk("Suspending console(s) (use no_console_suspend to debug)\n");
+	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
 	console_lock();
 	console_suspended = 1;
 	up_console_sem();
-- 
2.14.3
