Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeCXUZU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:25:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54974 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752801AbeCXUZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:25:18 -0400
To: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Petru Mihancea <petrum@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sysctl: fix sizeof argument to match variable name
Message-ID: <e0d0531f-361e-ef5f-8499-32743ba907e1@infradead.org>
Date: Sat, 24 Mar 2018 13:23:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix sizeof argument to be the same as the data variable name.
Probably a copy/paste error.
Mostly harmless since both variables are unsigned int.

Fixes kernel bugzilla #197371:
  Possible access to unintended variable in "kernel/sysctl.c" line 1339
https://bugzilla.kernel.org/show_bug.cgi?id=197371

Reported-by: Petru Mihancea <petrum@gmail.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 kernel/sysctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-416-rc6.orig/kernel/sysctl.c
+++ lnx-416-rc6/kernel/sysctl.c
@@ -1329,7 +1329,7 @@ static struct ctl_table vm_table[] = {
 	{
 		.procname	= "dirtytime_expire_seconds",
 		.data		= &dirtytime_expire_interval,
-		.maxlen		= sizeof(dirty_expire_interval),
+		.maxlen		= sizeof(dirtytime_expire_interval),
 		.mode		= 0644,
 		.proc_handler	= dirtytime_interval_handler,
 		.extra1		= &zero,
