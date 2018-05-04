Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeEDVXN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:23:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36405 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeEDVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:23:12 -0400
X-Google-Smtp-Source: AB8JxZodZLGT4xDfdsmgMlvUaBXiyBXQHPi7Q3UvExKYja5PLgv9k88ot2SsDAqG3zbs+4PR7XXUdg==
Date: Sat, 5 May 2018 00:23:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, mhocko@suse.com,
        penguin-kernel@I-love.SAKURA.ne.jp
Subject: [PATCH] elf: don't hash userspace addresses
Message-ID: <20180504212308.GA7564@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -379,8 +379,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 
 	if ((type & MAP_FIXED_NOREPLACE) &&
 	    PTR_ERR((void *)map_addr) == -EEXIST)
-		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
-			task_pid_nr(current), current->comm, (void *)addr);
+		pr_info("%d (%s): Uhuuh, elf segment at %lx requested but the memory is mapped already\n",
+			task_pid_nr(current), current->comm, addr);
 
 	return(map_addr);
 }
