Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425F20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9pvhC8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfBSVuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:50:23 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42659 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfBSVuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:50:23 -0500
Received: by mail-wr1-f52.google.com with SMTP id r5so10284934wrg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bWJe1XiU9eq0UFf57PD9RI0KWe8Rs2B+gW8D+wt4MNk=;
        b=E9pvhC8oFreTg8irMs+aDcFjQPTZLGjbACKx1ayt1nQ6W6zu4vl1BET5a5RxlLRbDu
         8fwS4iB5ShYpdbcQKUhV8/Mv9+oW3kJShnj/621zXEp6eL7HV55zFS8p6TgksHnSnVqL
         Jg4ZDyvzVQLbpmYZrCfi0RUIV0fog+EWHAju8nohaYwjpv1fp+IkK2K49WDmF6ty67Xl
         YKbCbvo8j405dPk5MZoZ7+19+epY49pIQqjT/vBOoZBiC/UMFz2VBML4+0Z/IIZBwx2h
         2iUhFUYcaLQOrQ4A5H9adk+yqdysCMnqQTnSENdXPl3P3opdADW/kYXhdgvZG8PGmNty
         swCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bWJe1XiU9eq0UFf57PD9RI0KWe8Rs2B+gW8D+wt4MNk=;
        b=fg4Pjz7M4fb9miKc3S04gJ+gevjTNvAbsv0Jab88sZVqXLkuKzEPbMr7XMvPF/82bm
         cjVCV6sZG3xgw5fMNqppO1rkp4IrllPP49QMxHU7DBDVz0Y1OiGsP00qzKdr+ZYV83zu
         M/M/l4g5HjXD8g6XBQacAN6iiLM+dfTk+knGgvtCAuhWGqMQSmV/pqngBwtdv/C5Cp9e
         hJDS0Is4ZK5piLMf4UeUgAVJTAF6bUqrvSLB/vO8dfxtCIVJ3qAOthu37CPOxYLR2krg
         CsrkOCecUJEH1dYeHHWYFZ1phPATDplbvqIedu11Eqa6gwuj7cCOnq0/3Ltii/Yrya25
         lI9Q==
X-Gm-Message-State: AHQUAuYOFvA6DKWsDe/K5rGj4kEEbflssDut7h8eR0Sgpccsbsh7J4eH
        ii+870e8YWNvjkf99Pgr6Q==
X-Google-Smtp-Source: AHgI3IZO4fH2la0RoUvkxWFEVSnAND5xJG/B5waMPUWxA8kYquAOTdyijPOtcuQ3LPbtAYINM7Aq2A==
X-Received: by 2002:adf:f343:: with SMTP id e3mr20636645wrp.205.1550613020544;
        Tue, 19 Feb 2019 13:50:20 -0800 (PST)
Received: from avx2 ([46.53.242.127])
        by smtp.gmail.com with ESMTPSA id m6sm16723049wrv.24.2019.02.19.13.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 13:50:19 -0800 (PST)
Date:   Wed, 20 Feb 2019 00:50:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, matej.kupljen@gmail.com, hughd@google.com,
        darrick.wong@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] tmpfs: test link accounting with O_TMPFILE
Message-ID: <20190219215016.GA20084@avx2>
References: <20190219210900.vYcks%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219210900.vYcks%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mount tmpfs with "nr_inodes=3" for easy check.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	-ENOTEST

	fold into tmpfs-fix-link-accounting-when-a-tmpfile-is-linked-in.patch

 tools/testing/selftests/Makefile                   |    1 
 tools/testing/selftests/tmpfs/.gitignore           |    1 
 tools/testing/selftests/tmpfs/Makefile             |    7 ++
 tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c |   67 +++++++++++++++++++++
 4 files changed, 76 insertions(+)

--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -48,6 +48,7 @@ TARGETS += sysctl
 ifneq (1, $(quicktest))
 TARGETS += timers
 endif
+TARGETS += tmpfs
 TARGETS += user
 TARGETS += vm
 TARGETS += x86
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/tmpfs/.gitignore
@@ -0,0 +1 @@
+/bug-link-o-tmpfile
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -0,0 +1,7 @@
+CFLAGS += -Wall -O2
+CFLAGS += -D_GNU_SOURCE
+
+TEST_GEN_PROGS :=
+TEST_GEN_PROGS += bug-link-o-tmpfile
+
+include ../lib.mk
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright (c) 2019 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/* Test that open(O_TMPFILE), linkat() doesn't screw accounting. */
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mount.h>
+#include <unistd.h>
+
+int main(void)
+{
+	int fd;
+
+	if (unshare(CLONE_NEWNS) == -1) {
+		if (errno == ENOSYS || errno == EPERM) {
+			fprintf(stderr, "error: unshare, errno %d\n", errno);
+			return 4;
+		}
+		fprintf(stderr, "error: unshare, errno %d\n", errno);
+		return 1;
+	}
+	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
+		fprintf(stderr, "error: mount '/', errno %d\n", errno);
+		return 1;
+	}
+
+	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
+	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
+		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
+		return 1;
+	}
+
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+	if (fd == -1) {
+		fprintf(stderr, "error: open 1, errno %d\n", errno);
+		return 1;
+	}
+	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
+		fprintf(stderr, "error: linkat, errno %d\n", errno);
+		return 1;
+	}
+	close(fd);
+
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+	if (fd == -1) {
+		fprintf(stderr, "error: open 2, errno %d\n", errno);
+		return 1;
+	}
+
+	return 0;
+}
