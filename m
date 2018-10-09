Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4083AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BCA2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar-com.20150623.gappssmtp.com header.i=@cyphar-com.20150623.gappssmtp.com header.b="1cysZrsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BCA2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJIOSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:18:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35824 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJIOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:18:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so343242pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cyphar-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTgc+3WNXY0J1xBgz3j8psu8PE55h0CL+8Epu96G7E4=;
        b=1cysZrsK0zMIp0AmVDD6GVfv2FZd07HQ53tYv/sAQJBLUVZXKbS2cy4IRAlxnsNJzO
         Bcs8oXwEeoK5mtDLiBU0i7KOFczxh01lWRQl5lHt9Nt8pTrBhnlGNiC7BtOzj5SIYwJE
         Xp1WylC4jScjmnTcTOlH73ikJnudR1/1uLrKj3yNh6bb6QbQ19peddEEKIHZ4eqGfk3c
         Vpv+x3hOxSSASJK474qj++Um/lRiaESO430FAaH0WRThtfUXIOOVG1pim0bgwBqilANq
         pvhvZZL8T41O7Zs8LvJTiP0hFUxy71O03IAH4hG/KkWHoESrWZinVVu45e1Ig2iDqSob
         iYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTgc+3WNXY0J1xBgz3j8psu8PE55h0CL+8Epu96G7E4=;
        b=V8LamtEaMxEFl4Z74BWEwLxf7Ruo2vM0ku4hOPeNBREkCG/cMJjWO+mpv9i1l1LxDJ
         wH6sKXwzQNBQuVLB1XbiBTIVP7YniEwMZJepVMjCDiQnhkwisS13qC8hS4iSjSM+l2Qn
         l4iynh8Ms18rieg/V32URyyWWnmwDAZLWh0OYyvRl0n2UFaZnDtqcYcCVfBJdgB+tOUU
         jbMIJ7dgRMF1NYqufqhzZxa3t6Lx3Idd7yKRqlrnJYtpNQ3WXDY39hZU4tVxfht2kbge
         vortQ6bnBAgAOrbH50X0Q0anWGxrkE/Iy+VqWZ5Ve5YJBFnFnsS8/rg/N5XU70pWoRrt
         BdVw==
X-Gm-Message-State: ABuFfoj9exHZq13rh0BV21dHdhWCITXtN3DRs9ZQqrwuT+98ArdAhk7u
        BJ1o4eriDZ/SUUR9UkeUuxQB1w==
X-Google-Smtp-Source: ACcGV60WppR0il4ozSqte1yzgGl8Mq6AmygUG1cepCVr6WRSb/OoIFwzISQ/4SIWkJuEaH7EVCS2rw==
X-Received: by 2002:a63:ff46:: with SMTP id s6-v6mr24258119pgk.241.1539068575372;
        Tue, 09 Oct 2018 00:02:55 -0700 (PDT)
Received: from ?redacted? ([220.240.25.129])
        by smtp.gmail.com with ESMTPSA id y1-v6sm31179246pfy.89.2018.10.09.00.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 00:02:54 -0700 (PDT)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
Date:   Tue,  9 Oct 2018 18:02:29 +1100
Message-Id: <20181009070230.12884-3-cyphar@cyphar.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009070230.12884-1-cyphar@cyphar.com>
References: <20181009070230.12884-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary motivation for the need for this flag is container runtimes
which have to interact with malicious root filesystems in the host
namespaces. One of the first requirements for a container runtime to be
secure against a malicious rootfs is that they correctly scope symlinks
(that is, they should be scoped as though they are chroot(2)ed into the
container's rootfs) and ".."-style paths[*]. The already-existing
AT_XDEV and AT_NO_PROCLINKS[**] help defend against other potential
attacks in a malicious rootfs scenario.

Currently most container runtimes try to do this resolution in
userspace[1], causing many potential race conditions. In addition, the
"obvious" alternative (actually performing a {ch,pivot_}root(2))
requires a fork+exec (for some runtimes) which is *very* costly if
necessary for every filesystem operation involving a container.

[*] At the moment, ".." and "proclink" jumping are disallowed for the
    same reason it is disabled for AT_BENEATH -- currently it is not
    safe to allow it. Future patches may enable it unconditionally once
    we have resolved the possible races (for "..") and semantics (for
    "proclink" jumping).

The most significant openat(2) semantic change with AT_THIS_ROOT is that
absolute pathnames no longer cause dirfd to be ignored completely. The
rationale is that AT_THIS_ROOT must necessarily chroot-scope symlinks
with absolute paths to dirfd, and so doing it for the base path seems to
be the most consistent behaviour (and also avoids foot-gunning users who
want to scope paths that are absolute).

Currently this is only enabled for openat(2) (which has its own flag
O_THISROOT with the same semantics). However the AT_* flags have been
reserved for future support in other *at(2) syscalls (because of
AT_EMPTY_PATH many *at(2) operations do not need to support these flags
directly).

[1]: https://github.com/cyphar/filepath-securejoin

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/fcntl.c                       | 2 +-
 fs/namei.c                       | 8 ++++----
 fs/open.c                        | 2 ++
 include/linux/fcntl.h            | 2 +-
 include/linux/namei.h            | 1 +
 include/uapi/asm-generic/fcntl.h | 3 +++
 include/uapi/linux/fcntl.h       | 2 ++
 7 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index e343618736f7..4c36c5b9fdb9 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1031,7 +1031,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(25 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(26 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 76eacd3af89b..b31aef27df22 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1094,7 +1094,7 @@ const char *get_link(struct nameidata *nd)
 			if (unlikely(nd->flags & LOOKUP_NO_PROCLINKS))
 				return ERR_PTR(-ELOOP);
 			/* Not currently safe. */
-			if (unlikely(nd->flags & LOOKUP_BENEATH))
+			if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_CHROOT)))
 				return ERR_PTR(-EXDEV);
 		}
 		if (IS_ERR_OR_NULL(res))
@@ -1742,7 +1742,7 @@ static inline int handle_dots(struct nameidata *nd, int type)
 		 * AT_BENEATH resolving ".." is not currently safe -- races can cause
 		 * our parent to have moved outside of the root and us to skip over it.
 		 */
-		if (unlikely(nd->flags & LOOKUP_BENEATH))
+		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_CHROOT)))
 			return -EXDEV;
 		if (!nd->root.mnt)
 			set_root(nd);
@@ -2255,7 +2255,7 @@ static inline int dirfd_path_init(struct nameidata *nd)
 		}
 		fdput(f);
 	}
-	if (unlikely(nd->flags & LOOKUP_BENEATH)) {
+	if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_CHROOT))) {
 		nd->root = nd->path;
 		if (!(nd->flags & LOOKUP_RCU))
 			path_get(&nd->root);
@@ -2301,7 +2301,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->path.dentry = NULL;
 
 	nd->m_seq = read_seqbegin(&mount_lock);
-	if (unlikely(flags & LOOKUP_XDEV)) {
+	if (unlikely(flags & (LOOKUP_CHROOT | LOOKUP_XDEV))) {
 		error = dirfd_path_init(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
diff --git a/fs/open.c b/fs/open.c
index 80f5f566a5ff..81d148f626cd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -996,6 +996,8 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		lookup_flags |= LOOKUP_NO_PROCLINKS;
 	if (flags & O_NOSYMLINKS)
 		lookup_flags |= LOOKUP_NO_SYMLINKS;
+	if (flags & O_THISROOT)
+		lookup_flags |= LOOKUP_CHROOT;
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index ad5bba4b5b12..95480cd4c09d 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_BENEATH | O_XDEV | \
-	 O_NOPROCLINKS | O_NOSYMLINKS)
+	 O_NOPROCLINKS | O_NOSYMLINKS | O_THISROOT)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (BITS_PER_LONG != 32)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5ff7f3362d1b..7ec9e2d84649 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -53,6 +53,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_NO_PROCLINKS	0x040000 /* No /proc/$pid/fd/ "symlink" crossing. */
 #define LOOKUP_NO_SYMLINKS	0x080000 /* No symlink crossing *at all*.
 					    Implies LOOKUP_NO_PROCLINKS. */
+#define LOOKUP_CHROOT		0x100000 /* Treat dirfd as %current->fs->root. */
 
 extern int path_pts(struct path *path);
 
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index c2bf5983e46a..11206b0e927c 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -113,6 +113,9 @@
 #ifndef O_NOSYMLINKS
 #define O_NOSYMLINKS	01000000000
 #endif
+#ifndef O_THISROOT
+#define O_THISROOT	02000000000
+#endif
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 551a9e2166a8..ea978457b68f 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -99,6 +99,8 @@
 #define AT_NO_PROCLINKS		0x40000 /* No /proc/$pid/fd/... "symlinks". */
 #define AT_NO_SYMLINKS		0x80000 /* No symlinks *at all*.
 					   Implies AT_NO_PROCLINKS. */
+#define AT_THIS_ROOT		0x100000 /* Path resolution acts as though
+					   it is chroot-ed into dirfd. */
 
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.19.0

