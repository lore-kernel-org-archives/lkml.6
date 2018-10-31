Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B717C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81C620821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLO5ZWpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81C620821
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbeKAA56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:57:58 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:38267 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbeKAA56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:57:58 -0400
Received: by mail-oi1-f201.google.com with SMTP id b5-v6so12411817oic.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xMXOUAqOuiGNilrIStKzzJOhwgVgJCnbOl44GID08p8=;
        b=ZLO5ZWpEKXEK4s/W4FMGez/BYUqlESuNmaPEE+Qfca309wbNAE25fPkqckVWqHf32G
         3P5x4tpKOVyj5a3npdOrCMwi+18x9+o0+aOJaH7jcjTRwuUUaT81kU6fmAN5mcO5ofTR
         ELgUkE5JG5QZIanC7m82k0XMLaBtYvX3jJlaCWm7/6exYFqOkEzEaNVB8ASssbVz2Bwx
         /+KjNLNEGtfQSObqyhlkiBwfUJnpgehWNSmDER0ZP7Yi+9jlZpGAGxt7rSGxelmtHjPg
         wppXWsDXsRnjD0IjK2gUgORfmPyrXyscZfWeIdXottxHwQC8MHvPXlKfk4XTRwCaHMHr
         +1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xMXOUAqOuiGNilrIStKzzJOhwgVgJCnbOl44GID08p8=;
        b=Ao+IUU69iTwskfNB4ex2LhVVwI2WwrJ0aNhzPVZ1ZB/CGRp6Oz73xyQp+a9hlU3wSS
         dNyI2o70HUF0E3mIJs1B8z4AzQTRovAFMdW0aZ5Ac/151fUpDvtP4z04YHnvKMsQhUp9
         Fc5cRoT4LIAdDhZhQbr/diUZSXFJmXC9MkUb+c5SWOxTVXBaIvJa9S/Y307J1F6EwZ6M
         unnBo9As+ZYHZ0i1pEI5KqjNlcclgMMN9EUTZIF8BxEoqt54xKAeQsBt7I4O6J7tS4E7
         n+6ryPDT3SgM42bFE0KZlB1Qy2Ve1Z6NhfXLyxcNytsPlLXC/mKw6qc7wgvGw9tqCbYk
         LROw==
X-Gm-Message-State: AGRZ1gJAJbZdeCP5X9K8t5v7D8j9Tz2DAngbF0RRuNnIDtV9yZHIRtmz
        Ebm9/XExR0kZU55qxGqrYtasHgdtxppV4e/Zm7Z1L0FbUCNO9hZMc5QZ9+ALX2ExXzgR0K3Iqex
        7CF68RErH0KwlFcFYy+yMw7BuBf25L54nz5wyAjL4k0R/bhMdWAiIkA9aink7l36zgHSvoA==
X-Google-Smtp-Source: AJdET5e9rdOvXPY+ScKG6dxlX+zNMKXf57xUma2ufGzp4GQE8mqAg1E54kBW1VK/7Zy6Ioo9+3HQYoGDvB0=
X-Received: by 2002:a9d:5264:: with SMTP id q36mr2361031otg.0.1541001561560;
 Wed, 31 Oct 2018 08:59:21 -0700 (PDT)
Date:   Wed, 31 Oct 2018 15:59:12 +0000
In-Reply-To: <20181029221037.87724-1-dancol@google.com>
Message-Id: <20181031155912.45088-1-dancol@google.com>
Mime-Version: 1.0
References: <20181029221037.87724-1-dancol@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v3] Implement /proc/pid/kill
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

Note that the write(2) to the kill file descriptor works only if it
happens in the security context as the call to open(2), where
"security context" is defined as the set of all ambient user IDs
(effective uid, fs uid, real uid, and saved uid) as well as the
presence of the CAP_KILL capability.  This check prevents confused
deputy attacks via, e.g., supplying a /proc/$(pidof httpd)/kill file
descriptor as the standard output of setuid program and convincing
that program to write a "9".

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

Turns out that checking struct user isn't sufficient, since signal.c's
permissions check also cares about effective UIDs. Let's be
extra-paranoid and bail if _anything_ relevant in struct cred
has changed.

Also, as Joel suggested, switch from goto-return to direct return.

 fs/proc/base.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7e9f07bf260d..b0e7ded96af9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -205,6 +205,72 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
 	return result;
 }
 
+static ssize_t proc_pid_kill_write(struct file *file,
+				   const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	ssize_t res;
+	int sig;
+	char buffer[4];
+	const struct cred *cur_cred;
+	const struct cred *open_cred;
+	bool security_changed;
+
+	/* This check prevents a confused deputy attack in which an
+	 * unprivileged process opens /proc/victim/kill and convinces
+	 * a privileged process to write to that kill FD, effectively
+	 * performing a kill with the privileges of the unwitting
+	 * privileged process.  Here, we just fail the kill operation
+	 * if someone calls write(2) with a real user ID that differs
+	 * from the one used to open the kill FD.
+	 */
+	cur_cred = current_cred();
+	open_cred = file->f_cred;
+	security_changed =
+		cur_cred->user_ns != open_cred->user_ns ||
+		!uid_eq(cur_cred->euid, open_cred->euid) ||
+		!uid_eq(cur_cred->fsuid, open_cred->fsuid) ||
+		!uid_eq(cur_cred->suid, open_cred->suid) ||
+		!uid_eq(cur_cred->uid, open_cred->uid) ||
+		/* No audit: if we actually use the capability, we'll
+		 * audit during the actual kill. Here, we're just
+		 * checking whether our kill-FD has escaped its
+		 * original security context and bailing if it has.
+		 */
+		(security_capable_noaudit(cur_cred,
+					  cur_cred->user_ns,
+					  CAP_KILL)
+		 != security_capable_noaudit(open_cred,
+					     open_cred->user_ns,
+					     CAP_KILL));
+	if (security_changed)
+		return -EPERM;
+
+	if (*ppos != 0)
+		return -EINVAL;
+
+	if (count > sizeof(buffer) - 1)
+		return -EINVAL;
+
+	if (copy_from_user(buffer, buf, count))
+		return -EINVAL;
+
+	buffer[count] = '\0';
+	res = kstrtoint(strstrip(buffer), 10, &sig);
+	if (res)
+		return res;
+
+	res = kill_pid(proc_pid(file_inode(file)), sig, 0);
+	if (res)
+		return res;
+
+	return count;
+}
+
+static const struct file_operations proc_pid_kill_ops = {
+	.write	= proc_pid_kill_write,
+};
+
 static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 			      size_t count, loff_t *ppos)
 {
@@ -2935,6 +3001,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
 #endif
+	REG("kill",       S_IRUGO | S_IWUGO, proc_pid_kill_ops),
 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
 	ONE("statm",      S_IRUGO, proc_pid_statm),
-- 
2.19.1.568.g152ad8e336-goog

