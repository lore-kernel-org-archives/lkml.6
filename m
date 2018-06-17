Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC04C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6C720693
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiSDW07k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6C720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936760AbeFQL4N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:56:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51450 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936744AbeFQL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:56:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so9814776wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YTOWlLaqwmxcdsjEiLOkCraXlrSwCeQy9HmOjrs7KPg=;
        b=TiSDW07kEwv1tHgpceKeH8igCh7Z8MR4HSwZX1Pqaq8VLbMDNgwI0otXOXLRNH83r9
         Hk2qY9MJbHJWq6YZJSRyKz4WyrNvS44TE69X7XTV+vn4plzrNdgjJUBXR+1ucVMLWgun
         KSsYsE6t2Nc4K2QNrkMGAOYB2UqQOgMzUd7wjTlUC05zMNFQS3a3iJsARGFPVyVYtj+z
         e2kkXbO00cHwM9cHIPYbtZkLt721sKDodTZ9qBBylbAWXbRC/O/eum2KGuPEZW5vMYC+
         m+V1syBVTy9Qh2Cg4/W5p140B86Njlhp2XMMkJHBhZqdhrVZTjurK7B26rV1tWwZ7cZ2
         BY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YTOWlLaqwmxcdsjEiLOkCraXlrSwCeQy9HmOjrs7KPg=;
        b=Kw5p6AcyUKzDOVeTagIYfaNNoUiWo8o3x0B88lr8tXjdBaLKknETyJJULqJD+tRd8p
         SZCsLpaBB0UuRBIk1gbqp+CPHrbTFGJVHPsDya7ym+Tf8y5zRC2LvLHBoRuWqwMzeWvf
         bIYLuTRHJUW3giKgvOqxcdyxOomybJJWJOgVQ7DzbVxsEFiQ2oCENF0zwxifGC8193y8
         UTPswIow3MLwUC2RUSoRMcjcKcMTCIrIZfYL9evdP74u89YcX+edNrcw9YzqW34r1HPB
         vbfMkr7qMZEXV5b3jxoVRTK44VE427jYyERW2yvir2PZxOyA1Le8YdShZNEwDI81l/t7
         UewA==
X-Gm-Message-State: APt69E0JdgtWiUBbD1SafmE57M9pnKqFDu1pPPQ7k4c/TJFgBwRHC3o0
        UQrD57/GctgOc+H52Z/lXqDXFbb2
X-Google-Smtp-Source: ADUXVKLx25RM/z6PSlZSDk7rqtkqndVz3hFa2xidT+9UJxESkSp4EzqmzbX7t8UkrC9L9fnPu6mLhg==
X-Received: by 2002:a50:9e01:: with SMTP id z1-v6mr7876130ede.246.1529236570617;
        Sun, 17 Jun 2018 04:56:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:40a0:d000:ed72:69cf:6b29:5003])
        by smtp.gmail.com with ESMTPSA id j7-v6sm5489147edh.76.2018.06.17.04.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 04:56:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sparse: remove uneffective sparse disabling
Date:   Sun, 17 Jun 2018 13:53:55 +0200
Message-Id: <20180617115355.53799-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse checking used to be disabled on init/do_mounts.c and a few
related files because "Many of the syscalls used in this file expect
some of the arguments to be __user pointers not __kernel pointers".

However since commit 28128c61e ("kconfig.h: Include compiler types to
avoid missed struct attributes") the checks are, in fact, not disabled
anymore because of the more early include of "linux/compiler_types.h"

So remove the now uneffective #undefery that was done to disable
these warnings, as well as the associated comment.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 init/do_mounts.c        | 10 ----------
 init/do_mounts_initrd.c | 10 ----------
 init/do_mounts_md.c     | 10 ----------
 init/do_mounts_rd.c     | 10 ----------
 init/initramfs.c        | 10 ----------
 5 files changed, 50 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 913910e38..0d0c620d0 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -1,13 +1,3 @@
-/*
- * Many of the syscalls used in this file expect some of the arguments
- * to be __user pointers not __kernel pointers.  To limit the sparse
- * noise, turn off sparse checking for this file.
- */
-#ifdef __CHECKER__
-#undef __CHECKER__
-#warning "Sparse checking disabled for this file"
-#endif
-
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/ctype.h>
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 5a91aefa7..d1a5d885c 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -1,14 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Many of the syscalls used in this file expect some of the arguments
- * to be __user pointers not __kernel pointers.  To limit the sparse
- * noise, turn off sparse checking for this file.
- */
-#ifdef __CHECKER__
-#undef __CHECKER__
-#warning "Sparse checking disabled for this file"
-#endif
-
 #include <linux/unistd.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index 7b18c2b3d..ebee03f83 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
@@ -1,14 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Many of the syscalls used in this file expect some of the arguments
- * to be __user pointers not __kernel pointers.  To limit the sparse
- * noise, turn off sparse checking for this file.
- */
-#ifdef __CHECKER__
-#undef __CHECKER__
-#warning "Sparse checking disabled for this file"
-#endif
-
 #include <linux/delay.h>
 #include <linux/raid/md_u.h>
 #include <linux/raid/md_p.h>
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 811f22311..115407a3c 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -1,14 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Many of the syscalls used in this file expect some of the arguments
- * to be __user pointers not __kernel pointers.  To limit the sparse
- * noise, turn off sparse checking for this file.
- */
-#ifdef __CHECKER__
-#undef __CHECKER__
-#warning "Sparse checking disabled for this file"
-#endif
-
 #include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/minix_fs.h>
diff --git a/init/initramfs.c b/init/initramfs.c
index 4a1a27dba..3942b3a09 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -1,14 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Many of the syscalls used in this file expect some of the arguments
- * to be __user pointers not __kernel pointers.  To limit the sparse
- * noise, turn off sparse checking for this file.
- */
-#ifdef __CHECKER__
-#undef __CHECKER__
-#warning "Sparse checking disabled for this file"
-#endif
-
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
-- 
2.17.1

