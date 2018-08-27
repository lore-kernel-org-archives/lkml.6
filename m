Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C469C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19088208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0L7Y116"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19088208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeH1DEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43381 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1DEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id z27-v6so432701edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cF7AKAlpI4BZ3i7k+HziDUNfI5kFH2AeSgb6tL69XIA=;
        b=b0L7Y116nITEhyUArLzAn+Q67c8A6sTpsL612JcM6jBzl1VQyzBQ87oqiLPwxWP91w
         wahfYcVO/RySfl9JeA83Qs2JdeOYxO8DykzWb+nlaND0ggPvzG1s+qSmTZluZLtDeXtv
         iTmoZUKUiKP8VDYjL7MhV1Btvw+7iMgJe0qvN4+MjFffKX8GINejZqjt0nLoovpWNJJH
         jQx+9bjMmOVn30U0wrlqqiu2mHxnYJYjjxazZ36M+plYpaCcwOxWESflFw6wA3/at7Lz
         q1KYZbcSrWu2Bv8NG+w0QrSMMqXTh5Lk1RxKDqxvPfhWabdY9OkrVN5t2ldU23iPVJ8H
         7d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cF7AKAlpI4BZ3i7k+HziDUNfI5kFH2AeSgb6tL69XIA=;
        b=DCGVgjrDW4xQgHNMPkU2T8tSwKeNG6tD3FdZUivfYTMXoH+2gS7pzHAh9u1WoNMiUl
         kg+sm+Hx3xynORxNO+bIfkhXnyhB8gvh6cQ8Y5NVceFbpBL+3U5kGKJiN7lySjzHoOXf
         Bnzx+vkE16iEhck3k8fB5HHBfjeD+aOnttH1QcUgW8cjh9RhIHex8Na4KTvfkAaZDELF
         VUOZNAeAAcHiEsP0VKZWB0osnh43Cf64JxVsYuXKUPtoELay4Mgsgk7WkGfpnuU3Qy4O
         SSD9/c3m/nyfjAVlw+OcMPgN+5poAI1zE4ElItWp9oklxtKHcNtpB2IGLjcusz6uc/gW
         RBfg==
X-Gm-Message-State: APzg51Cd8sAlqfynv1ggY+IU7FaIxttkGTE3vEJSe0Vb/gE22ePxjUCu
        qa5fkFCGeiesJWOiKiYXbQ==
X-Google-Smtp-Source: ANB0Vda9j4d1AMVc37gidl1UhW+ukFgi6UmtMJSj1stgimm+xJOipIuBSwmp/KmcgRDdvSt+k1l7JQ==
X-Received: by 2002:a50:8d0e:: with SMTP id s14-v6mr18758063eds.55.1535411734540;
        Mon, 27 Aug 2018 16:15:34 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:34 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 03/13] proc: rename "p" variable in proc_readfd_common()
Date:   Tue, 28 Aug 2018 02:14:53 +0300
Message-Id: <20180827231503.26899-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use slightly more obvious "tsk" and prepare for changes in printing.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/fd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..e098302b5101 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -228,16 +228,16 @@ static struct dentry *proc_lookupfd_common(struct inode *dir,
 static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 			      instantiate_t instantiate)
 {
-	struct task_struct *p = get_proc_task(file_inode(file));
+	struct task_struct *tsk = get_proc_task(file_inode(file));
 	struct files_struct *files;
 	unsigned int fd;
 
-	if (!p)
+	if (!tsk)
 		return -ENOENT;
 
 	if (!dir_emit_dots(file, ctx))
 		goto out;
-	files = get_files_struct(p);
+	files = get_files_struct(tsk);
 	if (!files)
 		goto out;
 
@@ -259,7 +259,7 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 
 		len = snprintf(name, sizeof(name), "%u", fd);
 		if (!proc_fill_cache(file, ctx,
-				     name, len, instantiate, p,
+				     name, len, instantiate, tsk,
 				     &data))
 			goto out_fd_loop;
 		cond_resched();
@@ -269,7 +269,7 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 out_fd_loop:
 	put_files_struct(files);
 out:
-	put_task_struct(p);
+	put_task_struct(tsk);
 	return 0;
 }
 
-- 
2.16.4

