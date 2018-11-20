Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2137EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A60820851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="X7peNSJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A60820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeKTVWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:22:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35753 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbeKTVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:22:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id v1-v6so832472plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mziPTVU1rfjrdouy70s41HPPU5bO7uov6jZEZv/rG1s=;
        b=X7peNSJHKKbvNQRsr9yKP0ac3il02EUvNPqDqNvslZhw/ZypHmWW9OtbeuPusLt2nT
         FMEdPDIcq8IMex+sycoCrfyA49C3/dY6XCw1Eu62zPjCUH8irLwd8J6V+d7P6De+VQEC
         VBTYBUl7aYcF/HwMa1iVO06pOQcnf3xcuCkmW8EkQDK90qHoudgrFcCbvjfAwtkS9vA/
         83AEPNwNrA7tAyPD4xHuqQeWgr8SKa0R7PwRofOhlVAfySDPLzpzJpnrx6QoeCMTbUOX
         hdwo+zq0VFgj3IVLurX6BRoApX5Gh0dLjb4qcdDsNEn6ZrVMYOT4ryV3AumfbZjpszQQ
         LyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mziPTVU1rfjrdouy70s41HPPU5bO7uov6jZEZv/rG1s=;
        b=V/CxTpDHJzF0NnXCsY66MPKuiDlYSwfbVRwWL92TRIBD9u0SisBYFEWLE4WYEoHu0Q
         +IzmZoQdqMpYCqTf7MoZS4p2vYJmdJI8T/DjOQJFDroFpBA2HtIfz4IEuZAF4+l9ltS0
         XZ0TsLrExi8G43lELS6oiCQtwcEm+7ZqAguWa39DuM8pkGZ3QTX1ImU07x/dNLRUKNGP
         +kUKC4A8z4Wxaaa1lf+MARK6IcVt5Kz0I4OTye+Z6xmblkSG9Pzph2ch9JrGuaZCT/U0
         8XNQJXcgAQI4BwWYO7bJ/IplWF4Klib0sxnfsJCCibfSYKq7fpLnzT9Rz9kr1+OWR4Dn
         lAFQ==
X-Gm-Message-State: AA+aEWYQd24znX3pWVkFli98cMDVYj7R8X0AbHb4baOB9pPYCwkZsXx6
        GQRTbKr9Ak5opj9yxtk0GSJhPg==
X-Google-Smtp-Source: AFSGD/UgIjxarTAB/JeJBxlWmGDYiVnz+xLOAIdcb/LgItH+OSrn4Ilm2oZgBCGZipNjlj99J6Q9Dw==
X-Received: by 2002:a17:902:e08b:: with SMTP id cb11mr1676554plb.263.1542711225183;
        Tue, 20 Nov 2018 02:53:45 -0800 (PST)
Received: from localhost.localdomain ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id g26sm11478524pfh.61.2018.11.20.02.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:53:44 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v2] procfd_signal.2: document procfd_signal syscall
Date:   Tue, 20 Nov 2018 11:51:24 +0100
Message-Id: <20181120105124.14733-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120105124.14733-1-christian@brauner.io>
References: <20181120105124.14733-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 man2/procfd_signal.2 | 208 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 man2/procfd_signal.2

diff --git a/man2/procfd_signal.2 b/man2/procfd_signal.2
new file mode 100644
index 000000000..889bb426f
--- /dev/null
+++ b/man2/procfd_signal.2
@@ -0,0 +1,208 @@
+.\" Copyright (C) 2018 Christian Brauner <christian@brauner.io>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.\"
+.TH PROCFD_SIGNAL 2 2017-09-15 "Linux" "Linux Programmer's Manual"
+.SH NAME
+procfd_signal \- send signal to a process through a process descriptor
+.SH SYNOPSIS
+.nf
+.B #include <sys/types.h>
+.B #include <signal.h>
+.PP
+.BI "int procfd_signal(int " fd ", int " sig ", siginfo_t *" info ", int " flags );
+.fi
+.SH DESCRIPTION
+.BR procfd_signal ()
+sends the signal specified in
+.I sig
+to the process identified by the file descriptor
+.IR fd .
+The permissions required to send a signal are the same as for
+.BR kill (2).
+As with
+.BR kill (2),
+the null signal (0) can be used to check if a process with a given
+PID exists.
+.PP
+The optional
+.I info
+argument specifies the data to accompany the signal.
+This argument is a pointer to a structure of type
+.IR siginfo_t ,
+described in
+.BR sigaction (2)
+(and defined by including
+.IR <sigaction.h> ).
+The caller should set the following fields in this structure:
+.TP
+.I si_code
+This must be one of the
+.B SI_*
+codes in the Linux kernel source file
+.IR include/asm-generic/siginfo.h ,
+with the restriction that the code must be negative
+(i.e., cannot be
+.BR SI_USER ,
+which is used by the kernel to indicate a signal sent by
+.BR kill (2))
+and cannot (since Linux 2.6.39) be
+.BR SI_TKILL
+(which is used by the kernel to indicate a signal sent using
+.\" tkill(2) or
+.BR tgkill (2)).
+.TP
+.I si_pid
+This should be set to a process ID,
+typically the process ID of the sender.
+.TP
+.I si_uid
+This should be set to a user ID,
+typically the real user ID of the sender.
+.TP
+.I si_value
+This field contains the user data to accompany the signal.
+For more information, see the description of the last
+.RI ( "union sigval" )
+argument of
+.BR sigqueue (3).
+.PP
+Internally, the kernel sets the
+.I si_signo
+field to the value specified in
+.IR sig ,
+so that the receiver of the signal can also obtain
+the signal number via that field.
+.PP
+The
+.I flags
+argument is reserved for future extension and must be set to 0.
+.PP
+.SH RETURN VALUE
+On success, this system call returns 0.
+On error, it returns \-1 and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EBADF
+.I fd
+is not a valid file descriptor.
+.TP
+.B EINVAL
+An invalid signal was specified.
+.TP
+.B EINVAL
+.I fd
+does not refer to a process.
+.TP
+.B EINVAL
+The flags argument was not 0.
+.TP
+.B EINVAL
+The calling process and the target process are neither located
+in the same pid namespace nor is the calling process's
+pid namespace an ancestor of the target process's pid namespaces
+(see
+.BR pid_namespaces (7)).
+.TP
+.B EPERM
+The caller does not have permission to send the signal to the target.
+For the required permissions, see
+.BR kill (2).
+Or:
+.I uinfo->si_code
+is invalid.
+.TP
+.B ESRCH
+The process or process group does not exist.
+Note that an existing process might be a zombie,
+a process that has terminated execution, but
+has not yet been
+.BR wait (2)ed
+for.
+.SH CONFORMING TO
+This system call is Linux-specific.
+.SH NOTES
+The
+.BR procfd_signal ()
+system call will only send signals to processes which either are in
+the same pid namespace or are in a descendant pid namespace of
+the caller.
+.SH EXAMPLE
+The following program demonstrates how to kill a process with
+.BR procfd_signal ()
+.SS Program source
+.EX
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+int
+main(int argc, char *argv[])
+{
+    int ret;
+    char buf[1000];
+
+    if (argc < 2)
+            exit(EXIT_FAILURE);
+
+    ret = snprintf(buf, sizeof(buf), "/proc/%s", argv[1]);
+    if (ret < 0)
+        exit(EXIT_FAILURE);
+
+    int fd = open(buf, O_DIRECTORY | O_CLOEXEC);
+    if (fd < 0) {
+        printf("%s - Failed to open \\"%s\\"\\n", strerror(errno), buf);
+        exit(EXIT_FAILURE);
+    }
+
+    ret = procfd_signal(fd, SIGKILL, NULL, 0);
+    if (ret < 0) {
+        printf("Failed to send SIGKILL \\"%s\\"\\n", strerror(errno));
+        close(fd);
+        exit(EXIT_FAILURE);
+    }
+
+    close(fd);
+
+    exit(EXIT_SUCCESS);
+}
+.EE
+.SH SEE ALSO
+.BR kill (2),
+.BR sigaction (2),
+.BR sigprocmask (2),
+.BR tgkill (2),
+.BR pthread_sigqueue (3),
+.BR rt_sigqueueinfo (2),
+.BR sigqueue (3),
+.BR signal (7)
-- 
2.19.1

