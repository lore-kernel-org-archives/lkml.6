Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D04C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195A12088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6YKD4Ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195A12088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeJHC2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:28:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32912 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJHC2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:28:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so18547415wrs.0;
        Sun, 07 Oct 2018 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=DIdN0ElFW8V7T46BZWUdclI0XkvhY1OTfzBvrEloV50=;
        b=h6YKD4AyGQu7HQ8mMJwMWIUwzvMu3yQY5dJKzyRTFnJygvwuiTcWyjxw4oUwE1Rsxy
         za5iQ9nZU78DBUdvKqLfyK8WX7zW44FccvkbyWQS0//yhYbNTSoQB8l1syZDEUs8hHDG
         EaavyJEnWRM2mjJt0aumZTMQgh91ml/35hi1t5l9PFPkJJY6S4mvHZLmN0v12BbJubox
         kKACy1YPfjSJEsv20kdN/dWOsV0EBNKUmi2++lthASdewhJJOeOf+Hkwclhn3AURJIuG
         l/zeWHUPXHIMKrlGDG42VZiaVRcJiSKCoNZD+2E8F74YjYCxgt9BI2d7beuLVH7pbma5
         lppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=DIdN0ElFW8V7T46BZWUdclI0XkvhY1OTfzBvrEloV50=;
        b=S0ar2CTCzP4Biv+CBMkVx/Sww5JNrfF/qx/yPonpHgjFqVt6+JfKFB4/AMKZPO/m4v
         l2y4voGAeHm3XU7xlB0Vbw565BN8wPgaviqxwzPX7D5s1cv/6blGCU2jr4JyrvkmF3eI
         T+jHLMN2CipBEjG4xD1HGC0smAQ1JGquUvQu+tGupFwfi/0xFCNntd/jAMtT5fAz78Qk
         8z/hfqMtFx2MymI9qGgvtgtN+CB4SWfzP9R4rrwiVE7rNf/vOD+xHfUb0dtDjhh5Hn1q
         Yq9UIrRSv5Yr7kdRVwsaRwbXz/gyPSAXcUNXQ/CTyxGoF6nlmd1MecMgm+Zk64NDS0Li
         EPNA==
X-Gm-Message-State: ABuFfohYY6H8dy5LP6q3l1+DNfKJUuiGYREyHGfdFTBpgOdWRYcqKHP+
        Tg/avO2XTkbkTpI5r2046I8=
X-Google-Smtp-Source: ACcGV60PnGasWFaslHxpXhPvaEtdgoEJooKu4ekoxcmke3q16UNWkVIQkdu9v1tCC538jc4bpxElNg==
X-Received: by 2002:adf:81e1:: with SMTP id 88-v6mr15990268wra.19.1538940022144;
        Sun, 07 Oct 2018 12:20:22 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id f1-v6sm7288353wme.23.2018.10.07.12.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 12:20:21 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
Message-ID: <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com>
Date:   Sun, 7 Oct 2018 20:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------FBEF933D0AA4BC2B4A5340DD"
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FBEF933D0AA4BC2B4A5340DD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/10/2018 11:48, Alan Jenkins wrote:
> On 05/10/2018 19:24, Alan Jenkins wrote:
>> On 21/09/2018 17:30, David Howells wrote:
>>> From: Al Viro <viro@zeniv.linux.org.uk>
>>>
>>> Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
>>> attached by move_mount(2).
>>>
>>> If by the time of final fput() of OPEN_TREE_CLONE-opened file its 
>>> tree is
>>> not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
>>> to handle detached source.
>>>
>>> That gives us equivalents of mount --bind and mount --rbind.
>>>
>>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>> ---
>>>
>>>   fs/namespace.c |   26 ++++++++++++++++++++------
>>>   1 file changed, 20 insertions(+), 6 deletions(-)

>>> The lockup seems to be a general problem with the cleanup code. Even 
>>> if I use this as advertised, i.e. for a simple bind mount.

Ah, I see.  The problem is you were expecting me to use the FD from 
open_tree() directly.  But I did fchdir() into the FD, and then "mount 
--move . /mnt" :-).

If I use the FD directly, it avoids the hang.  I used two separate C 
programs (attached, to avoid my MUA damage)...

> (I was suspicious that being able to pass around detached trees as an 
> FD, and re-attach them in any namespace, allows leaking memory by 
> creating a namespace loop.  I.e. maybe it gives you enough rope to 
> skip the test in mnt_ns_loop().

...so here's the memory leak.

# open_tree --help
usage: open_tree 3</source/path FD_NUMBER COMMAND...
# move_mount --help
usage: move_mount 3</from/path 4</to/path

Create a child namespace:

# mount --make-shared /tmp
# cd /tmp
# mkdir private_mnt
# mount -t tmpfs tmp private_mnt
# mount --make-private private_mnt
# touch private_mnt/child_ns
# unshare --mount=private_mnt/child_ns --propagation=shared ls -l /proc/self/ns/mnt
lrwxrwxrwx. 1 root root 0 Oct  7 19:23 /proc/self/ns/mnt -> 'mnt:[4026532334]'
# findmnt | grep /tmp
├─/tmp                                tmpfs                  tmpfs      rw,nosuid,nodev,seclabel,size=1247640k,nr_inodes=311910
│ └─/tmp/private_mnt                  tmp                    tmpfs      rw,relatime,seclabel,uid=1000,gid=1000
│   └─/tmp/private_mnt/child_ns       nsfs[mnt:[4026532334]] nsfs       rw,seclabel


Create a reference cycle:

# ~/test-open_tree 3</tmp/private_mnt 3 \
     nsenter --mount=/tmp/private_mnt/child_ns \
     sh -c '~/test-move_mount 4</mnt'

Attach 10MB of memory to the cycle:

# grep Shmem: /proc/meminfo
Shmem:              1464 kB
# dd if=/dev/zero of=/tmp/private_mnt/bigfile bs=1M count=10
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.00976358 s, 1.1 GB/s
# grep Shmem: /proc/meminfo
Shmem:             11704 kB

Detach the cycle, and leak all the memory:

# umount -l /tmp/private_mnt/
# grep Shmem: /proc/meminfo
Shmem:             11704 kB


--------------FBEF933D0AA4BC2B4A5340DD
Content-Type: text/x-patch;
 name="vfs_samples.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vfs_samples.diff"

diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 4ac9690fb3c4..13a32e125a74 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,10 +1,14 @@
 # List of programs to build
 hostprogs-$(CONFIG_SAMPLE_VFS) := \
 	test-fsmount \
+	open_tree \
+	move_mount \
 	test-statx
 
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 
 HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
+HOSTCFLAGS_open_tree.o += -I$(objtree)/usr/include
+HOSTCFLAGS_move_mount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/vfs/open_tree.c b/samples/vfs/open_tree.c
new file mode 100644
index 000000000000..6222e69048f9
--- /dev/null
+++ b/samples/vfs/open_tree.c
@@ -0,0 +1,54 @@
+/* fd-based mount test.
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <ctype.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <linux/fs.h>
+#include <linux/unistd.h>
+
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE 0x8000
+#endif
+
+#define E(x) do { if ((x) == -1) { perror(#x); exit(1); } } while(0)
+
+static inline int open_tree(int dfd, const char *pathname, unsigned flags)
+{
+	return syscall(__NR_open_tree, dfd, pathname, flags);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd_number;
+	char **command;
+	int mfd;
+
+	if (argc < 3 || !isdigit(argv[1][0])) {
+		fprintf(stderr, "usage: open_tree 3</source/path FD_NUMBER COMMAND...\n");
+		exit(2);
+	}
+	fd_number = atoi(argv[1]);
+	command = argv + 2;
+
+	E( mfd = open_tree(3, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | AT_RECURSIVE) );
+	if (fd_number != mfd) {
+		E( dup2(mfd, fd_number) );
+		E( close(mfd) );
+	}
+	E( execvp(command[0], command) );
+}
diff --git a/samples/vfs/move_mount.c b/samples/vfs/move_mount.c
new file mode 100644
index 000000000000..1bd2122245e2
--- /dev/null
+++ b/samples/vfs/move_mount.c
@@ -0,0 +1,47 @@
+/* fd-based mount test.
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <linux/fs.h>
+#include <linux/unistd.h>
+
+#define E(x) do { if ((x) == -1) { perror(#x); exit(1); } } while(0)
+
+static inline int move_mount(int from_dfd, const char *from_pathname,
+			     int to_dfd, const char *to_pathname,
+			     unsigned int flags)
+{
+	return syscall(__NR_move_mount,
+		       from_dfd, from_pathname,
+		       to_dfd, to_pathname, flags);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 1) {
+		fprintf(stderr, "usage: move_mount 3</from/path 4</to/path\n");
+		exit(2);
+	}
+
+	if (move_mount(3, "", 4, "", MOVE_MOUNT_F_EMPTY_PATH |
+		                     MOVE_MOUNT_T_EMPTY_PATH) < 0) {
+		perror("move_mount");
+		exit(1);
+	}
+
+	exit(0);
+}


--------------FBEF933D0AA4BC2B4A5340DD--
