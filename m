Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA91C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9011220835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB7W7dbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9011220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeJLVys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:54:48 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:52723 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:54:48 -0400
Received: by mail-wm1-f41.google.com with SMTP id 189-v6so12501647wmw.2;
        Fri, 12 Oct 2018 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=Z8cEINrQVTFAuPifFaWR3cA7/rcOv09k3XgJkaJnlGw=;
        b=SB7W7dbuU9S1o7n/64/PlAtuw3ncO0AUmR9D+FUfvRyEe4McoySoq4qa1LJCeJnFUQ
         95hCiZxMTyKfOX2gzkoXsPMZzH+jKrJxQSbxW44BK3apzXZ/FOrXsMYiAQ7WLuupMLZM
         pRBuADrDouDV1rmiB/SWzMhoE6kuDpeWbwLtuS1G62czSG31zUbxMOBiQRosRBRNES3w
         c0b2OcfisR+j+0B/5+BVgEZqte0L8ILRinuqO0gpiKUJzy4+sJy/JPsmP4j+SaXLcxgU
         m3Ny6vfHglMnjPszQgA3C4LmNIen6/82bd09EKlZodGYzWe9EPm3m/GX+DrJ9GUz9BJ5
         xWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=Z8cEINrQVTFAuPifFaWR3cA7/rcOv09k3XgJkaJnlGw=;
        b=t9br4DowNEA0yLJN475Qqf3Hr/l08+kBLwc18vBBxeceVitt0eX8DDLu0n2tRdqjG0
         q9WyH4aBRR3O5KkwpzXp27uoVr0nRs+htnzjOkaiczX6sApEh/8XxL4zy99h9ifyLevB
         hWRNxeXWnpIc83/ShDlThZFXivuI2Z0lomc0/oVfSDlmKmaIWGDOPZNzRbICef6zdfPs
         CeFKIqyemD1Go0i7gCE+y6m+ZsUHN8Snlah6+TvEGp8QY6U+qcfMCZCWyomW08ruNeiM
         Pw3gHi5jtrPB4hAJDaUXEZhHis5Ao32MLOqQJP2QVJEXNniyCBEtcjV9CHmOqPQRs8+H
         puWA==
X-Gm-Message-State: ABuFfohQ2GrxbbKQkpdbYZirvlMrcyvRq9yVizziNFulhSgJDx2x9iu/
        uIP7MfUqGcgbxvnUg2DOFAk=
X-Google-Smtp-Source: ACcGV61IDMsCh38A1kh+aqlSEWNeTt9GIxYi9DrCRuz6JN/uB2jPg3c+aExH6O32y7eR2KDbEUu1MA==
X-Received: by 2002:a1c:4c16:: with SMTP id z22-v6mr5095020wmf.89.1539354125256;
        Fri, 12 Oct 2018 07:22:05 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id 143-v6sm1730294wmv.6.2018.10.12.07.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:22:04 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <25990.1539174969@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <02ae06f0-b6af-7f3e-8ccf-b3d80d7e27b0@gmail.com>
Date:   Fri, 12 Oct 2018 15:22:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <25990.1539174969@warthog.procyon.org.uk>
Content-Type: multipart/mixed;
 boundary="------------F25C7A29E5A46BE6833D0F14"
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F25C7A29E5A46BE6833D0F14
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/2018 13:36, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> + * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
>> + * Written by David Howells (dhowells@redhat.com)
> Do you want to update that and I can take them into my patchset?
>
> David


Sure :).  I've attached a slightly updated version.

Thanks

Alan


--------------F25C7A29E5A46BE6833D0F14
Content-Type: text/x-patch;
 name="0001-vfs-tiny-sample-programs-for-open_tree-and-move_moun.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-vfs-tiny-sample-programs-for-open_tree-and-move_moun.pa";
 filename*1="tch"

From d9cbfa3398fe9e6269cc76429220d1fc1990b474 Mon Sep 17 00:00:00 2001
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Date: Fri, 12 Oct 2018 11:11:13 +0100
Subject: [PATCH] vfs: tiny sample programs for open_tree() and move_mount()

A couple of utility commands for fd-based mounts.  They were useful to
reproduce three different issues, in the original implementation of the
system calls.

Also add .gitignore for all the vfs samples.

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 samples/vfs/.gitignore        |  4 +++
 samples/vfs/Makefile          |  4 +++
 samples/vfs/move_mount.c      | 42 ++++++++++++++++++++++
 samples/vfs/open_tree_clone.c | 65 +++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100644 samples/vfs/.gitignore
 create mode 100644 samples/vfs/move_mount.c
 create mode 100644 samples/vfs/open_tree_clone.c

diff --git a/samples/vfs/.gitignore b/samples/vfs/.gitignore
new file mode 100644
index 000000000000..242ed23f90d2
--- /dev/null
+++ b/samples/vfs/.gitignore
@@ -0,0 +1,4 @@
+open_tree_clone
+move_mount
+test-fsmount
+test-statx
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 4ac9690fb3c4..3a5bb48d21a0 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,10 +1,14 @@
 # List of programs to build
 hostprogs-$(CONFIG_SAMPLE_VFS) := \
+	open_tree_clone \
+	move_mount \
 	test-fsmount \
 	test-statx
 
 # Tell kbuild to always build the programs
 always := $(hostprogs-y)
 
+HOSTCFLAGS_open_tree_clone.o += -I$(objtree)/usr/include
+HOSTCFLAGS_move_mount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/vfs/move_mount.c b/samples/vfs/move_mount.c
new file mode 100644
index 000000000000..2cc9d876078a
--- /dev/null
+++ b/samples/vfs/move_mount.c
@@ -0,0 +1,42 @@
+/* fd-based mount utility.
+ *
+ * Copyright (C) 2018 Alan Jenkins (alan.christopher.jenkins@gmail.com).
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
+#include <linux/fs.h>
+#include <linux/unistd.h>
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
+		fprintf(stderr, "Usage: move_mount 3</from/path 4</to/path\n");
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
diff --git a/samples/vfs/open_tree_clone.c b/samples/vfs/open_tree_clone.c
new file mode 100644
index 000000000000..3025d101addc
--- /dev/null
+++ b/samples/vfs/open_tree_clone.c
@@ -0,0 +1,65 @@
+/* fd-based mount utility.
+ *
+ * Inspired by http://skarnet.org/software/execline/redirfd.html etc.
+ *
+ * Copyright (C) 2018 Alan Jenkins (alan.christopher.jenkins@gmail.com).
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
+		fprintf(stderr, "Usage: 3</from/path open_tree_clone FD_NUMBER COMMAND...\n");
+		fprintf(stderr, "Clone the tree mounted at /from/path.\n");
+		fprintf(stderr, "Then execute COMMAND, passing the cloned tree as file FD_NUMBER.\n");
+		fprintf(stderr, "\n");
+		fprintf(stderr, "hint:  3</from/path 4</to/path open_tree_clone 3 move_mount\n");
+		exit(2);
+	}
+	fd_number = atoi(argv[1]);
+	command = argv + 2;
+
+	mfd = open_tree(3, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | AT_RECURSIVE);
+	if (mfd == -1) {
+		perror("open_tree");
+		exit(1);
+	}
+
+	if (fd_number != mfd) {
+		E( dup2(mfd, fd_number) );
+		E( close(mfd) );
+	}
+
+	execvp(command[0], command);
+	perror("exec");
+	exit(1);
+}
-- 
2.17.2


--------------F25C7A29E5A46BE6833D0F14--
