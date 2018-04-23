Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeDWVvY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:51:24 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36599 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeDWVvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:51:22 -0400
X-Google-Smtp-Source: AB8JxZocVuviHFcHOkbhCKCXiRQbvTu1IH6N+/hJ/jHTjTFKToEufWtn560eJY/UNaeMqTvrHVTkcQ==
Date: Tue, 24 Apr 2018 00:51:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: use "unsigned int" for sigqueue length
Message-ID: <20180423215119.GF9043@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's defined as atomic_t and really long signal queues are unheard of.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/array.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -260,7 +260,7 @@ static inline void task_sig(struct seq_file *m, struct task_struct *p)
 	unsigned long flags;
 	sigset_t pending, shpending, blocked, ignored, caught;
 	int num_threads = 0;
-	unsigned long qsize = 0;
+	unsigned int qsize = 0;
 	unsigned long qlim = 0;
 
 	sigemptyset(&pending);
