Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23202C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7842064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxaZsDQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7842064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeJ3HC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:02:29 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:37556 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbeJ3HC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:02:29 -0400
Received: by mail-it1-f201.google.com with SMTP id m8-v6so11536568iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mG2S9tUK8zz8hDnqMvMwrCJG5jQKX8H8/29N2Wb7ZT8=;
        b=TxaZsDQzzwwBOWUF4XIYa1HuxzYyoIwMbuoJFGyDfM0YPiit72QoRn8H95EvqLbN2N
         IFtjGYC6Is7XSjlRLdQwqGZ9AaN50hfqpC1VJMRlBbhZLslwGzQe58Vji0C+RMYJ5Vlm
         JvCJNN/D1z2yzwCh/Vg/e3ZMWYhTOtrZwhtIPZDLEVRBpCbKL8ZyC79olAX3k60FfFrD
         n3vy9r9rKsrpZVjIGpSY6/FTBM5ZejNPQ7aJfvRA7TmDA18Z7aTc848NBYwDFG0LlODW
         Wt+kKt5vuD8Wb0S/u8mlpELgLdevAbxpCiXxJMn+m0PuNVEtkyIhhSmUCp4khP+tmo4o
         ta1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mG2S9tUK8zz8hDnqMvMwrCJG5jQKX8H8/29N2Wb7ZT8=;
        b=Hakru/PoWPca+rit0xCYlmxBUjN0ICGafrEf55o+EyPky6RMfjQlxfvxlRL06N4uya
         UN+2Ft2JT+8S+035qMtnoIaRgG0Vu++GNnTfCm8YKY8sDHs6QfMHx/pToVU2I64ydRy+
         KWOOxl++PqkuyT+Z+tB9c7HEB6c+p52D/rvyb6iW89LGPeIkl4iTzMF3GaMKrgKwcMbw
         ZRkRMd3HtnjyYC6fv3GIMIT9nPw7UsS7k/SnQN9oWZIP//axmYWdr/qcaH2v+B+i5fvI
         qOH25i+90+646+FlgLt4SVR8gy5mufBX5FegDhrCYM0gE10yyu1Ov7iyNP80hl7fsxpq
         7dBQ==
X-Gm-Message-State: AGRZ1gIgejdNcsR4GSph7/zTRsh3EUs5dp/BQLdMTytx21GM3kz+vral
        zJ4VLFLPX644N2jD9iKbGTckpvedU9VIXlhNCf/mXHN6cwZA15xJHCJzCk+T2S5icjDNfjnhFRO
        /2y6KqVv1EyUFzjqvqPP1bce+E9NP9eJyUuxQHvPsvyxDeXW6RyrasPJdjiK4NRoFp9f7Gw==
X-Google-Smtp-Source: AJdET5d0egaQoGq6BA6nCbUwAQgN93kBvzZjjH3y3cpCGFj0MlMPvvLYzgkA96EzcQc//2YnWnZUWVhpMMc=
X-Received: by 2002:a24:390c:: with SMTP id l12-v6mr12219112ita.28.1540851111166;
 Mon, 29 Oct 2018 15:11:51 -0700 (PDT)
Date:   Mon, 29 Oct 2018 22:10:37 +0000
Message-Id: <20181029221037.87724-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [RFC PATCH] Implement /proc/pid/kill
From:   Daniel Colascione <dancol@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     timmurray@google.com, joelaf@google.com, surenb@google.com,
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
 fs/proc/base.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7e9f07bf260d..923d62b21e67 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -205,6 +205,44 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
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
@@ -2935,6 +2973,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
 #endif
+	REG("kill",       S_IRUGO | S_IWUGO, proc_pid_kill_ops),
 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
 	ONE("stat",       S_IRUGO, proc_tgid_stat),
 	ONE("statm",      S_IRUGO, proc_pid_statm),
-- 
2.19.1.568.g152ad8e336-goog

