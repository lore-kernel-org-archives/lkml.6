Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81C5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBF52089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIxSv1M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBF52089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJOWuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:50:08 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:45951 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOWuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:50:08 -0400
Received: by mail-ua1-f74.google.com with SMTP id c9so1061784uad.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iyDE8NnRHXGUj+mrrGahTGfEtbQ6Dv/IBRddY6oIEjQ=;
        b=VIxSv1M116xvnMupu2kUQzZdB8q6HRSFDxDDNmyDX59w1V98ykqj81ppNvRH+I/mXO
         qyl65SmIU9KmYlSTRFtL5ijMi8wTIYFypw5VcjC/nKfDONV7cIBwZKJwt4Mr9My9QIF0
         wD0dgW7DoXXQv53JHd/hPDmfN1LxNXMYjBhlsYcSEaxw+18JXl04rSLINWi4W1H7rc/3
         5LWc8wkNwGJlHgm0uoZ2m0aPXqeMDymo47mFheO8OK0xM/38W7lSq6ik8j8os4JHhVEr
         r4SilP3rGUHqn0N+/qkCDAKkAaxXU3dkmW9RTyMhF5tD5Omn18L9h+hs8t8panKUfYQL
         aOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iyDE8NnRHXGUj+mrrGahTGfEtbQ6Dv/IBRddY6oIEjQ=;
        b=BQCsQQLoE0oF2PUedqaNEFzs90rgLL2/SyJn0NlCj6gT4/Cpyf8cN/6iBqRPGebMFj
         xO/F1P4OrsfCNOfyWpAEOCYG3/qyG1gVHvbK6+2M2A+e0OKYpcBscowtuWP+m69ZudWA
         mcycwEH+RFJWhiYbPLpyOn12/8SveGBbXycs2YjwPCwMAgk2NiLUdCO4iEEtbjk3tzjH
         mphmtzo8FksARDbE2BZu3orJRmARDhSVJipHOmSXcwIZZ3XDwDicQOChp18WPAzvrYYv
         r4T+gq/hrMELhb0UElBDAj+TMkWCri5M6qKC74xEO+Cnei8zg7b8p3ObuhSY/+ni3QtU
         V3aw==
X-Gm-Message-State: ABuFfohXbu+WiLwZkaOizLW6/oN9VsO4IafKDNthSOMBbGaq7UWlNXT5
        FcZBebV+Vuw9K5EELdovgp4Z175GwQ==
X-Google-Smtp-Source: ACcGV62hGzBbfZFTUVdwgCf8OOhIEdh3lwBeATP4cphXOKi86QJ7ce2YIVqhy5zw7AGX9+N+ZdhCZeq+Tw==
X-Received: by 2002:a1f:c4c2:: with SMTP id u185mr11982763vkf.19.1539615868846;
 Mon, 15 Oct 2018 08:04:28 -0700 (PDT)
Date:   Mon, 15 Oct 2018 17:04:18 +0200
Message-Id: <20181015150420.2096-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 1/2] splice: don't merge into linked buffers
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

Before this patch, it was possible for two pipes to affect each other after
data had been transferred between them with tee():

============
$ cat tee_test.c

int main(void) {
  int pipe_a[2];
  if (pipe(pipe_a)) err(1, "pipe");
  int pipe_b[2];
  if (pipe(pipe_b)) err(1, "pipe");
  if (write(pipe_a[1], "abcd", 4) != 4) err(1, "write");
  if (tee(pipe_a[0], pipe_b[1], 2, 0) != 2) err(1, "tee");
  if (write(pipe_b[1], "xx", 2) != 2) err(1, "write");

  char buf[5];
  if (read(pipe_a[0], buf, 4) != 4) err(1, "read");
  buf[4] = 0;
  printf("got back: '%s'\n", buf);
}
$ gcc -o tee_test tee_test.c
$ ./tee_test
got back: 'abxx'
$
============

Fix it by explicitly marking buffers as mergeable and clearing that flag in
splice_pipe_to_pipe() and link_pipe().

Cc: <stable@vger.kernel.org>
Fixes: 7c77f0b3f920 ("splice: implement pipe to pipe splicing")
Fixes: 70524490ee2e ("[PATCH] splice: add support for sys_tee()")
Signed-off-by: Jann Horn <jannh@google.com>
---
Cleanup in the next patch, to simplify backporting.

 fs/pipe.c                 | 5 +++--
 fs/splice.c               | 6 ++++++
 include/linux/pipe_fs_i.h | 8 ++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index bdc5d3c0977d..4e2eee77f855 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -379,7 +379,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		struct pipe_buffer *buf = pipe->bufs + lastbuf;
 		int offset = buf->offset + buf->len;
 
-		if (buf->ops->can_merge && offset + chars <= PAGE_SIZE) {
+		if (buf->ops->can_merge && offset + chars <= PAGE_SIZE &&
+		    (buf->flags & PIPE_BUF_FLAG_MAYMERGE)) {
 			ret = pipe_buf_confirm(pipe, buf);
 			if (ret)
 				goto out;
@@ -439,7 +440,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			buf->ops = &anon_pipe_buf_ops;
 			buf->offset = 0;
 			buf->len = copied;
-			buf->flags = 0;
+			buf->flags = PIPE_BUF_FLAG_MAYMERGE;
 			if (is_packetized(filp)) {
 				buf->ops = &packet_pipe_buf_ops;
 				buf->flags = PIPE_BUF_FLAG_PACKET;
diff --git a/fs/splice.c b/fs/splice.c
index b3daa971f597..111977c80dfd 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1593,6 +1593,9 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			 */
 			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 
+			/* We can't merge data into a buffer we don't own. */
+			obuf->flags &= ~PIPE_BUF_FLAG_MAYMERGE;
+
 			obuf->len = len;
 			opipe->nrbufs++;
 			ibuf->offset += obuf->len;
@@ -1667,6 +1670,9 @@ static int link_pipe(struct pipe_inode_info *ipipe,
 		 */
 		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 
+		/* We can't merge data into a buffer we don't own. */
+		obuf->flags &= ~PIPE_BUF_FLAG_MAYMERGE;
+
 		if (obuf->len > len)
 			obuf->len = len;
 
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 5a3bb3b7c9ad..8893711f9171 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -8,6 +8,14 @@
 #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
 #define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
+/*
+ * Set this flag if the generic pipe read/write may coalesce data into an
+ * existing buffer. If this is not set, a new pipe page segment is always used
+ * for new data.
+ * When pipe data is copied by reference (as in the tee() syscall), this flag
+ * must be cleared on the copy.
+ */
+#define PIPE_BUF_FLAG_MAYMERGE	0x10
 
 /**
  *	struct pipe_buffer - a linux kernel pipe buffer
-- 
2.19.0.605.g01d371f741-goog

