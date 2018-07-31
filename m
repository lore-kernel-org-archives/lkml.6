Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E514EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B5120862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DG0nYZZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B5120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbeGaRwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:52:46 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:47343 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbeGaRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:52:45 -0400
Received: by mail-qt0-f201.google.com with SMTP id b7-v6so13513299qtp.14
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j/sV6dXvNZxplbBedVac4Z0WyJu+MmPT6ZQzfhIbe7I=;
        b=DG0nYZZsyf9vHLscxZ8CBdZ9OKVftHlwgzukZ0rYr51n/QoIu4mT6gbyXkWO/R1Enj
         5YRqzkvnNd20crav7vWTq5k3q+qCaiTmrPDf7/7wHP7Ilvegjv72rA1TtV2WjlZXInJv
         wtZGAPHF/iUkBGYRukZF/pSAmHNFyTvhJvzBiwJdeTp2kBxDxWN1esLsjBGRdl0a2tPS
         kTqKaPYhjngpyZt9z50x7Bt7HDvaAhZRb12lqzwtvgSO/Fan3WfUFa1OOgm0oZU+A2LD
         5uaZYLgoqyrh/1+TPrf0QdHxisVJ8XfTXGL/FOjuhQ9168x+M88TO+23pt/8dxGGZ+PW
         tWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j/sV6dXvNZxplbBedVac4Z0WyJu+MmPT6ZQzfhIbe7I=;
        b=nJmzIetzkxtc7CiLMW8DaMr58shpyun3eSWzkwVfNuVYHuMx397/FsObZE6FHT3xb/
         iZn03xXR3Gr789ymx4PmpR6imwlin2Qk8rJv+ZcMIl4KyyxKQqsmVdfRFFfj9n4WC5C7
         JBp0aAtABcBOiOlFsBFGn2JhVBfX/ijXZjhMa6h6zvM2rrbK7mgBT0SW7oFfh7h0HpUd
         gMtTgr+BzY6mkpdNu+0yX/Rc7L0Urw+XlVIMdR7m3VlojIRXtnV7tFfLPuNrB4hrRVQ7
         CaBW4WUGYUW6e/tBWZTd6Crg6Ekt8uKfCeRPUSluBbkZEWDOghZQecedI792CVCTrTlK
         iY0g==
X-Gm-Message-State: AOUpUlEnFQILWxCdlXYvZvpEkLCn8f9/xPWYfaLMgRv5Tf3nFPn8corH
        D9jVgAS+33JkOp6fM6+X3DTla6AQVQ==
X-Google-Smtp-Source: AAOMgpdw7qUYXHKgR/7fM71gh/QN6AiNMjuk/KsCdysA5FSMwAZ8Z5izeOFs2XrBZnJAgrzeIwPc1+SxXA==
X-Received: by 2002:a0c:e801:: with SMTP id y1-v6mr12086529qvn.55.1533053503442;
 Tue, 31 Jul 2018 09:11:43 -0700 (PDT)
Date:   Tue, 31 Jul 2018 18:10:27 +0200
Message-Id: <20180731161025.189534-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH v2] fs: don't let getdents return bogus names
From:   Jann Horn <jannh@google.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, jannh@google.com
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you e.g. run `find` on a directory for which getdents returns
"filenames" that contain slashes, `find` passes those "filenames" back to
the kernel, which then interprets them as paths. That could conceivably
cause userspace to do something bad when accessing something like an
untrusted USB stick, but I'm not aware of any specific example.

Instead of returning bogus filenames to userspace, return -EUCLEAN.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
changed in v2:
 - move bogus_dirent_name() out of the #ifdef where it doesn't belong
   (kbuild test robot)

@Al: Given what Dave and Pavel said, are you okay with this?

 arch/alpha/kernel/osf_sys.c |  3 +++
 fs/readdir.c                | 33 +++++++++++++++++++++++++++++++++
 include/linux/fs.h          |  3 +++
 3 files changed, 39 insertions(+)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index c210a25dd6da..e04e51a2320d 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -40,6 +40,7 @@
 #include <linux/vfs.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
+#include <linux/fs.h>
 
 #include <asm/fpu.h>
 #include <asm/io.h>
@@ -117,6 +118,8 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
 	unsigned int reclen = ALIGN(NAME_OFFSET + namlen + 1, sizeof(u32));
 	unsigned int d_ino;
 
+	if (bogus_dirent_name(&buf->error, name, namlen, __func__))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail */
 	if (reclen > buf->count)
 		return -EINVAL;
diff --git a/fs/readdir.c b/fs/readdir.c
index d97f548e6323..fa0ac1e33230 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -64,6 +64,29 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 }
 EXPORT_SYMBOL(iterate_dir);
 
+/*
+ * Most filesystems don't filter out bogus directory entry names, and userspace
+ * can get very confused by such names. Behave as if a low-level IO error had
+ * happened while reading directory entries.
+ */
+bool bogus_dirent_name(int *errp, const char *name, int namlen,
+		       const char *caller)
+{
+	if (namlen == 0) {
+		pr_err_once("%s: filesystem returned bogus empty name\n",
+			    caller);
+		*errp = -EUCLEAN;
+		return true;
+	}
+	if (memchr(name, '/', namlen)) {
+		pr_err_once("%s: filesystem returned bogus name '%*pEhp' (contains slash)\n",
+			    caller, namlen, name);
+		*errp = -EUCLEAN;
+		return true;
+	}
+	return false;
+}
+
 /*
  * Traditional linux readdir() handling..
  *
@@ -98,6 +121,8 @@ static int fillonedir(struct dir_context *ctx, const char *name, int namlen,
 
 	if (buf->result)
 		return -EINVAL;
+	if (bogus_dirent_name(&buf->result, name, namlen, __func__))
+		return -EUCLEAN;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
@@ -173,6 +198,8 @@ static int filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
 
+	if (bogus_dirent_name(&buf->error, name, namlen, __func__))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -259,6 +286,8 @@ static int filldir64(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
 
+	if (bogus_dirent_name(&buf->error, name, namlen, __func__))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
@@ -358,6 +387,8 @@ static int compat_fillonedir(struct dir_context *ctx, const char *name,
 
 	if (buf->result)
 		return -EINVAL;
+	if (bogus_dirent_name(&buf->result, name, namlen, __func__))
+		return -EUCLEAN;
 	d_ino = ino;
 	if (sizeof(d_ino) < sizeof(ino) && d_ino != ino) {
 		buf->result = -EOVERFLOW;
@@ -427,6 +458,8 @@ static int compat_filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
 		namlen + 2, sizeof(compat_long_t));
 
+	if (bogus_dirent_name(&buf->error, name, namlen, __func__))
+		return -EUCLEAN;
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
 		return -EINVAL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 805bf22898cf..62ad476563f0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1680,6 +1680,9 @@ struct dir_context {
 	loff_t pos;
 };
 
+bool bogus_dirent_name(int *errp, const char *name, int namlen,
+		       const char *caller);
+
 struct block_device_operations;
 
 /* These macros are for out of kernel modules to test that
-- 
2.18.0.345.g5c9ce644c3-goog

