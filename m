Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46411C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084522084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3dwJTaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfBLOzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:55:01 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46579 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfBLOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:54:59 -0500
Received: by mail-yb1-f195.google.com with SMTP id 7so1104439ybp.13;
        Tue, 12 Feb 2019 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5CBOJRGTcQGmlNCKUj0Pt249I45F4hVPySjhHRNwryE=;
        b=p3dwJTaNaKkGTeOKYMqlI/sGsuuoK/mTjbzapom1ILyv6Qua0Zh16d/oOZedv6ezGg
         2lqg1gW3755SN8Ti7VNSd2JyZiT/fqT+aLADH77nzDeKAFMN9OhHnEbe13AfnevCIJLh
         g+5aosgzFhO/p5/vOGQA30eC3oZu7m2yvS5w8kmhzcVdLnR6YA2EpiCdV17S7st2/JXr
         044kR0FXdUyPLaw2IG9NaHOwEtxiHLcgx0Affzqwo+zN+/cSffC7WtrznekDJ1ACaL5P
         /l/9aM64U0oeqU2dX/d+VUgR9JbEkovLFiVpJy9Ln5l5WPW1FSWW2yXeF9JAxIxnSaw9
         2Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5CBOJRGTcQGmlNCKUj0Pt249I45F4hVPySjhHRNwryE=;
        b=UU+bWKFRv2Fo5O/p9Zocar8lSKTazTsa+iD2Q85pVj6GjbMoFrYT054y+ucvpydAgX
         zCwZS1oQb4qBuGCKOSuvInQF5wg1xwR+MNCPBUv1ERqZUe+iMVKx6RNhK1rEFYcoesf5
         UVDJwBfjuaa4jmcX0jvYjbJ+IbOgIeZSy9SbFjOsIRS8kUaBjfQ1w9foc3ue4U0Sp3Za
         yxX2yZWe8lzlqkOKIcwdBhqHGW9GarScIbId+NtixugDMue3f6OdHy9RSfYD4P0tUVnH
         lADrrb1fPj4EoexBzZsWp9P1qhohwI/s8E8BAQPA3RRTruSpStGsqsHA5XhjCWN1wHmq
         XWqg==
X-Gm-Message-State: AHQUAubtoAfit0TysoJWQ4go85ceJx4u7EYqwmLy1u0zfmIin63fH1jU
        C/fwzjNVHknvySYsEznWgjs6KuouKSJmpA==
X-Google-Smtp-Source: AHgI3IbE5eyb3heigYm7wsbkfI7cPM4Fjr4YLixP9rit9V2jL3xGQRZk02P5gQ9dPNKcU5s8y2Wcvg==
X-Received: by 2002:a25:bc83:: with SMTP id e3mr3130135ybk.164.1549983298074;
        Tue, 12 Feb 2019 06:54:58 -0800 (PST)
Received: from localhost.localdomain (c-73-120-18-128.hsd1.tn.comcast.net. [73.120.18.128])
        by smtp.gmail.com with ESMTPSA id v134sm4987967ywv.90.2019.02.12.06.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 06:54:57 -0800 (PST)
From:   demiobenour@gmail.com
To:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org (open list:FILE LOCKING (flock() and
        fcntl()/lockf())), linux-kernel@vger.kernel.org (open list),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Cc:     "Demi M. Obenour" <demiobenour@gmail.com>
Subject: [PATCH 2/4] Expose O_PATHSTATIC to userspace
Date:   Tue, 12 Feb 2019 09:54:45 -0500
Message-Id: <20190212145450.2200-2-demiobenour@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212145450.2200-1-demiobenour@gmail.com>
References: <20190212145450.2200-1-demiobenour@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Demi M. Obenour" <demiobenour@gmail.com>

This adds the file open flag O_PATHSTATIC, which ensures that symbolic
links are *never* followed, even in path components other than the last.
This is distinct from O_NOFOLLOW, which only prevents symlinks in the
*last* component from being followed.

This is useful for avoiding race conditions in userspace code that
should expose only a subset of the filesystem to clients.  This includes
FTP and SFTP servers, QEMU, and others.

Currently, O_NOFOLLOW must be set if O_PATHSTATIC is set.  Otherwise,
open() fails with -EINVAL.
---
 fs/fcntl.c                       |  2 +-
 fs/namei.c                       |  6 ++++++
 fs/open.c                        | 24 ++++++++++++++++++++++--
 include/linux/fcntl.h            |  2 +-
 include/uapi/asm-generic/fcntl.h |  4 ++++
 5 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 083185174c6d..6c85c4d0c006 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1031,7 +1031,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 54fbd2c7ba82..4c90f265c103 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3282,6 +3282,12 @@ static int do_last(struct nameidata *nd,
 	if (!(open_flag & O_CREAT)) {
 		if (nd->last.name[nd->last.len])
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
+
+		if (open_flag & O_PATHSTATIC) {
+			nd->flags |= LOOKUP_NEVER_FOLLOW;
+			nd->flags &= ~LOOKUP_FOLLOW;
+		}
+
 		/* we _can_ be in RCU mode here */
 		error = lookup_fast(nd, &path, &inode, &seq);
 		if (likely(error > 0))
diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..717afa8179c0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -940,6 +940,24 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 	/* Must never be set by userspace */
 	flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC;
 
+	/*
+	 * If nonzero, setting O_PATHSTATIC but not O_NOFOLLOW fails with
+	 * -EINVAL.  Otherwise, setting O_PATHSTATIC automatically sets
+	 * O_NOFOLLOW.
+	 */
+#define REQUIRE_NOFOLLOW_FOR_PATHSTATIC 1
+
+#if REQUIRE_NOFOLLOW_FOR_PATHSTATIC
+	/* O_PATHSTATIC doesn't make sense without O_NOFOLLOW */
+	if (unlikely((flags & O_PATHSTATIC) && !(flags & O_NOFOLLOW)))
+		return -EINVAL;
+#elif defined REQUIRE_NOFOLLOW_FOR_PATHSTATIC
+	if (flags & O_PATHSTATIC)
+		flags &= O_NOFOLLOW;
+#else
+#error REQUIRE_NOFOLLOW_FOR_PATHSTATIC must be defined
+#endif
+
 	/*
 	 * O_SYNC is implemented as __O_SYNC|O_DSYNC.  As many places only
 	 * check for O_DSYNC if the need any syncing at all we enforce it's
@@ -959,7 +977,7 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		 * If we have O_PATH in the open flag. Then we
 		 * cannot have anything other than the below set of flags
 		 */
-		flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH;
+		flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH | O_PATHSTATIC;
 		acc_mode = 0;
 	}
 
@@ -986,7 +1004,9 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 
 	if (flags & O_DIRECTORY)
 		lookup_flags |= LOOKUP_DIRECTORY;
-	if (!(flags & O_NOFOLLOW))
+	if (flags & O_PATHSTATIC)
+		lookup_flags |= LOOKUP_NEVER_FOLLOW;
+	else if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 	op->lookup_flags = lookup_flags;
 	return 0;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 27dc7a60693e..6f91e1490592 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -9,7 +9,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_PATHSTATIC)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (BITS_PER_LONG != 32)
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..314ea1cecf44 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_PATHSTATIC
+#define O_PATHSTATIC	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.20.1

