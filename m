Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D4C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D3A2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtFrAfVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D3A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJOWuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:50:11 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:37460 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOWuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:50:10 -0400
Received: by mail-yb1-f202.google.com with SMTP id z1-v6so10911627ybf.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=skPo9n3gJ0r883DlIgyRJNK0owHXQQkA65/aZWoFfg8=;
        b=QtFrAfVjPPQ2Tr3XxN0vMHJPlx4u3ViGggs7evqL6KnbNbMsPzu8CGnsqT0P2vWD+a
         7dMBu2onDbJ1TmFE/5iBLeHwTtutfDw/c7chFgu8BR9vGfraMX16iHTZNBw986lTmxsp
         wLUWX41mpq0VfgfI+qwu6RuJxaTBKU3zJs3Sdv6DezLWGExgI/K6Mcs12zmAljOI175r
         VLnrR9h+lX8ZFxTLkdqyU80w0SStpHFH72fWj6jdpl+XUvivDx0shYOdIN2P+ez/ARqM
         w+uuCV5CMJ9UF0cA9wiZoVRP1b3drgj98Jd1BYMk9oLD4XHlPST+wTPaaxNBAOo0UPHF
         KdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=skPo9n3gJ0r883DlIgyRJNK0owHXQQkA65/aZWoFfg8=;
        b=kD4ehyCKl1BwxTvkd6WvXOXpCKY1v05bgVuWyBSJaRs6gIQAgfbSpwRdFFWKVQLky6
         6/egrfuEfRT7pj/c8Y2y5fmza99WCESYwbjcfeyOqXtMSiHonNQOxs9pclTeOwr5K6q9
         MH6s91OWopjcanj/LzlDz8YI8Y3sneW9AhuFumuP6Vxs3RAdk85MZ3/XgxHjlPmBcdIe
         8e9CzbNv4mukAJOjsU1G3j406qbwIxJIsKveXyGaZ7uB35Up4yxwiz+lIpy0/5GyvkEz
         PzVAYLhw3UF+O4TgL1YyOUX69fcKWZxe7caah96wbmj5ptf9ENfkIxm6fzX9WFcm+1cT
         2xxA==
X-Gm-Message-State: ABuFfoiBbq6xPY6EkRCxkSbF/R+g88Y/I12FgEm6xd1fQG02h3QCfOjG
        akTo8INA3YIa35OV1vO3a1d2DkTKGw==
X-Google-Smtp-Source: ACcGV62QRnUMgbBoMiDkUUnkFcxESHQnxsVOArxhVur2wEYncopqWIXiqkA9WiH443Y6hi59M2PGzc6A0w==
X-Received: by 2002:a81:2f50:: with SMTP id v77-v6mr10509834ywv.1.1539615871706;
 Mon, 15 Oct 2018 08:04:31 -0700 (PDT)
Date:   Mon, 15 Oct 2018 17:04:19 +0200
In-Reply-To: <20181015150420.2096-1-jannh@google.com>
Message-Id: <20181015150420.2096-2-jannh@google.com>
Mime-Version: 1.0
References: <20181015150420.2096-1-jannh@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 2/2] pipe: remove ->can_merge from pipe_buf_operations
From:   Jann Horn <jannh@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My last commit "splice: don't merge into linked buffers" made the
"can_merge" field in struct pipe_buf_operations redundant: Whether a buffer
is mergeable is now a property of the buffer, not of the operations struct.
Get rid of it.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/pipe.c                 | 4 +---
 fs/splice.c               | 4 ----
 include/linux/pipe_fs_i.h | 7 -------
 kernel/relay.c            | 1 -
 kernel/trace/trace.c      | 2 --
 net/smc/smc_rx.c          | 1 -
 6 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 4e2eee77f855..b1ad3271c175 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -227,7 +227,6 @@ void generic_pipe_buf_release(struct pipe_inode_info *pipe,
 EXPORT_SYMBOL(generic_pipe_buf_release);
 
 static const struct pipe_buf_operations anon_pipe_buf_ops = {
-	.can_merge = 1,
 	.confirm = generic_pipe_buf_confirm,
 	.release = anon_pipe_buf_release,
 	.steal = anon_pipe_buf_steal,
@@ -235,7 +234,6 @@ static const struct pipe_buf_operations anon_pipe_buf_ops = {
 };
 
 static const struct pipe_buf_operations packet_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = anon_pipe_buf_release,
 	.steal = anon_pipe_buf_steal,
@@ -379,7 +377,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		struct pipe_buffer *buf = pipe->bufs + lastbuf;
 		int offset = buf->offset + buf->len;
 
-		if (buf->ops->can_merge && offset + chars <= PAGE_SIZE &&
+		if (offset + chars <= PAGE_SIZE &&
 		    (buf->flags & PIPE_BUF_FLAG_MAYMERGE)) {
 			ret = pipe_buf_confirm(pipe, buf);
 			if (ret)
diff --git a/fs/splice.c b/fs/splice.c
index 111977c80dfd..fb7412b2eadb 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -138,7 +138,6 @@ static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
 }
 
 const struct pipe_buf_operations page_cache_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = page_cache_pipe_buf_confirm,
 	.release = page_cache_pipe_buf_release,
 	.steal = page_cache_pipe_buf_steal,
@@ -156,7 +155,6 @@ static int user_page_pipe_buf_steal(struct pipe_inode_info *pipe,
 }
 
 static const struct pipe_buf_operations user_page_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = page_cache_pipe_buf_release,
 	.steal = user_page_pipe_buf_steal,
@@ -326,7 +324,6 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 EXPORT_SYMBOL(generic_file_splice_read);
 
 const struct pipe_buf_operations default_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = generic_pipe_buf_release,
 	.steal = generic_pipe_buf_steal,
@@ -341,7 +338,6 @@ static int generic_pipe_buf_nosteal(struct pipe_inode_info *pipe,
 
 /* Pipe buffer operations for a socket and similar. */
 const struct pipe_buf_operations nosteal_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = generic_pipe_buf_release,
 	.steal = generic_pipe_buf_nosteal,
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8893711f9171..03d3529c7654 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -81,13 +81,6 @@ struct pipe_inode_info {
  * in fs/pipe.c for the pipe and generic variants of these hooks.
  */
 struct pipe_buf_operations {
-	/*
-	 * This is set to 1, if the generic pipe read/write may coalesce
-	 * data into an existing buffer. If this is set to 0, a new pipe
-	 * page segment is always used for new data.
-	 */
-	int can_merge;
-
 	/*
 	 * ->confirm() verifies that the data in the pipe buffer is there
 	 * and that the contents are good. If the pages in the pipe belong
diff --git a/kernel/relay.c b/kernel/relay.c
index 04f248644e06..db3e419c25a6 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1175,7 +1175,6 @@ static void relay_pipe_buf_release(struct pipe_inode_info *pipe,
 }
 
 static const struct pipe_buf_operations relay_pipe_buf_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = relay_pipe_buf_release,
 	.steal = generic_pipe_buf_steal,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bf6f1d70484d..820eff45e907 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5803,7 +5803,6 @@ static void tracing_spd_release_pipe(struct splice_pipe_desc *spd,
 }
 
 static const struct pipe_buf_operations tracing_pipe_buf_ops = {
-	.can_merge		= 0,
 	.confirm		= generic_pipe_buf_confirm,
 	.release		= generic_pipe_buf_release,
 	.steal			= generic_pipe_buf_steal,
@@ -6823,7 +6822,6 @@ static void buffer_pipe_buf_get(struct pipe_inode_info *pipe,
 
 /* Pipe buffer operations for a buffer. */
 static const struct pipe_buf_operations buffer_pipe_buf_ops = {
-	.can_merge		= 0,
 	.confirm		= generic_pipe_buf_confirm,
 	.release		= buffer_pipe_buf_release,
 	.steal			= generic_pipe_buf_steal,
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index bbcf0fe4ae10..413a6abf227e 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -136,7 +136,6 @@ static int smc_rx_pipe_buf_nosteal(struct pipe_inode_info *pipe,
 }
 
 static const struct pipe_buf_operations smc_pipe_ops = {
-	.can_merge = 0,
 	.confirm = generic_pipe_buf_confirm,
 	.release = smc_rx_pipe_buf_release,
 	.steal = smc_rx_pipe_buf_nosteal,
-- 
2.19.0.605.g01d371f741-goog

