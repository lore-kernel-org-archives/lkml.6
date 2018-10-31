Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B27C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5993420664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EX7JY+uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5993420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeJaXgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:36:06 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:50220 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbeJaXgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:36:05 -0400
Received: by mail-io1-f74.google.com with SMTP id q127-v6so14017377iod.17
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G9OgXTXqXs4aSm+7e0Qm/JO4NDS7yJ9L9QyroRhIkTo=;
        b=EX7JY+uG6qkg7EN6TA+fNRWQVHpdYkYe30JNw5v1QGDARFMjLoIUgG+w+vRn3020i9
         UwjCYyH/JoNsDUggGTu/re8Dpd5idipIvTC/Qr8DUrf4kDeHe0WlmGD6OgepwA+EvROC
         FCtHJfBEWYjBlS5GPMDNaVARjtLEQW3QARpKWO5dqAjsKmqJ1qUiln6xnQmPxpditsd9
         Qf+57SQ8112ZKHdGZjoz/VE6fd8v6oxmjHP8MN6GvOBjn+5uAr94o+3ZOIrwMCWeoeyL
         83dOTGG/OC3HfSatWgqf2FOedKZCiJi1X/bSbGwpgymS3Kq3g44yHa4W4U4Fi6DKW49y
         yqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G9OgXTXqXs4aSm+7e0Qm/JO4NDS7yJ9L9QyroRhIkTo=;
        b=TLxQFc+M2DXjIhmjgFenVnOkoBUfgToG9RD+GNQFS4UurYcetBqLzrGDQ19q1bKLgf
         eQMXHFVWi7sMlreMaiKOzLb4x6TOOTNwNRt0CwGm+W6XI/v/seCJ8X56xSveh6ZlvMLv
         N0kSImK6ad/N6S3lnb+DMSgeiP6dml1LOKpGNM6h1wbyx+UniOqK7W94JA6Jzx/SJvfL
         EGtDI72kCCXNIgwkpgEi6f60NyGlZgyvzyNHBDUx8u2JW2decYUw87LuwMEMJknp8dbK
         l4Rg2ZpNSvH1nYVAW1YdHOW+PzBmb98Ycj/UIpQ/qLr7obdZg0RtY/ekuF49eSRkbVjB
         EdIA==
X-Gm-Message-State: AGRZ1gL1szi2iIUM6CBhbVGJfWlHj7XQMlwFz7obfL6v60gtguy7qlmI
        SIha0XCfnFQHlT+ZX9hAkTTBEwoXQTwZLWPi7gMBTBIw+pM7dFpHRtEmO2EDYlviZoQGJ4KY09H
        HORj+UXjRVaE1PEacI+VoPX2peHFbsv4apON/Lu3aWUeWAVfotEPCJL2KuDW+njFfvXX8Jw==
X-Google-Smtp-Source: AJdET5c8aKk0i383R7w8JR/guH9Yu78G3apupxNfxlHTUyaGgK2R954ZtnVbXZca90O5Xparvwgzh7pSTqU=
X-Received: by 2002:a24:6794:: with SMTP id u142-v6mr2044403itc.9.1540996667413;
 Wed, 31 Oct 2018 07:37:47 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:37:44 +0000
In-Reply-To: <20181029221037.87724-1-dancol@google.com>
Message-Id: <20181031143744.77677-1-dancol@google.com>
Mime-Version: 1.0
References: <20181029221037.87724-1-dancol@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v2] Implement /proc/pid/kill
From:   Daniel Colascione <dancol@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     timmurray@google.com, joelaf@google.com, surenb@google.com,
        cyphar@cyphar.com, christian.brauner@canonical.com,
        ebiederm@xmission.com, keescook@chromium.org, oleg@redhat.com,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple proc-based kill interface. To use /proc/pid/kill, just
write the signal number in base-10 ASCII to the kill file of the
process to be killed: for example, 'echo 9 > /proc/$$/kill'.

Semantically, /proc/pid/kill works like kill(2), except that the
process ID comes from the proc filesystem context instead of from an
explicit system call parameter. This way, it's possible to avoid races
between inspecting some aspect of a process and that process's PID
being reused for some other process.

Note that only the real user ID that opened a /proc/pid/kill file can
write to it; other users get EPERM.  This check prevents confused
deputy attacks via, e.g., standard output of setuid programs.

With /proc/pid/kill, it's possible to write a proper race-free and
safe pkill(1). An approximation follows. A real program might use
openat(2), having opened a process's /proc/pid directory explicitly,
with the directory file descriptor serving as a sort of "process
handle".

    #!/bin/bash
    set -euo pipefail
    pat=$1
    for proc_status in /proc/*/status; do (
        cd $(dirname $proc_status)
        readarray proc_argv -d'' < cmdline
        if ((${#proc_argv[@]} > 0)) &&
               [[ ${proc_argv[0]} = *$pat* ]];
        then
            echo 15 > kill
        fi
    ) || true; done

Signed-off-by: Daniel Colascione <dancol@google.com>
---

Added a real-user-ID check to prevent confused deputy attacks.

 fs/proc/base.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7e9f07bf260d..74e494f24b28 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -205,6 +205,56 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
 	return result;
 }
 
+static ssize_t proc_pid_kill_write(struct file *file,
+				   const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	ssize_t res;
+	int sig;
+	char buffer[4];
+
+	/* This check prevents a confused deputy attack in which an
+	 * unprivileged process opens /proc/victim/kill and convinces
+	 * a privileged process to write to that kill FD, effectively
+	 * performing a kill with the privileges of the unwitting
+	 * privileged process.  Here, we just fail the kill operation
+	 * if someone calls write(2) with a real user ID that differs
+	 * from the one used to open the kill FD.
+	 */
+	res = -EPERM;
+	if (file->f_cred->user != current_user())
+		goto out;
+
+	res = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	res = -EINVAL;
+	if (count > sizeof(buffer) - 1)
+		goto out;
+
+	res = -EFAULT;
+	if (copy_from_user(buffer, buf, count))
+		goto out;
+
+	buffer[count] = '\0';
+	res = kstrtoint(strstrip(buffer), 10, &sig);
+	if (res)
+		goto out;
+
+	res = kill_pid(proc_pid(file_inode(file)), sig, 0);
+	if (res)
+		goto out;
+	res = count;
+out:
+	return res;
+
+}
+
+static const struct file_operations proc_pid_kill_ops = {
+	.write	= proc_pid_kill_write,
+};
+
 static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 			      size_t count, loff_t *ppos)
 {
@@ -2935,6 +2985,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
 #endif
+	REG("kill",       S_IRUGO | S_IWUGO, proc_pid_kill_ops),
 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
 	ONE("statm",      S_IRUGO, proc_pid_statm),
-- 
2.19.1.568.g152ad8e336-goog

