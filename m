Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2140D20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw2/eePu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfAHTX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:23:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37459 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAHTX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:23:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so5250924wrt.4;
        Tue, 08 Jan 2019 11:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5oSJDxoCazN3KzrgpOc6wuOGWs1JYq2oF/3l8gpACjk=;
        b=dw2/eePuzhRw+V8c3HsUrfu7498oKRfGi7xNHxiTJnDFvPZIx3ocCHPlsKioDIaPoG
         pYiLlCeEvaOpN2UhgLH727LD39DEToPadTp/fhx+XGuIaybRbMXeod6yix+ZXnQ72itV
         o/Boq0WJEBJCDQG78KNLiZFyoogOcXJGiPGzwBaCHBjD6og6DKYhZkrjyEMMyU2C3n0h
         ra0FCIoOunG7U6+e8rnH4sLbxlYHD0IRPvUUCa6MXTyU6ws2P5A18UAEwqgBqO5J2kHr
         XDB3Zs+HJcvlkPTYxs3PVJKXE0B9i0DE5gOkDStJCGJSExp0sb3v1UfGlCDLNh6Who5B
         jsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5oSJDxoCazN3KzrgpOc6wuOGWs1JYq2oF/3l8gpACjk=;
        b=N8jkBWKM8SZXzX2S6UMmqj0xd6AsNTdp+tBON7Sudb9Gmxo164AMF7cwCJb5icLDMQ
         B1ALUd6fc2jm8QZpqeQuHSToFU02mr00uAdzG/YxV9TGfjpADHNoB1uV4xGbQGvKJymy
         ugkU6wUdmw5l0p1hl1lGmV6KogDemYVBOW/Ajcye8jLpiJioBjwiubptJKRmBNaLrIKv
         q/IzZY5ytwWoscvz2+n6dnml+7Ow1Cn0AY5ff/0SE1vPhA02lmz9YdOjrmarq+F7ZRjv
         c99nxSXVWsQevLd3oh12sXaJ6h72XJEhMJHnVYdlAggFnufFPwkUWjZeNvwjg8Zb+BJ8
         oYAA==
X-Gm-Message-State: AJcUukcksgWf+yMeZmrFMeEuFs5NVU6fbxJI3/BtBli+BhC3gtHEGtcv
        EZcSRLWWWP98gtprtgxSZ1qSAQQ=
X-Google-Smtp-Source: ALg8bN7QGM0YgXPVeG3xE9sSrKVRRTN+AUeidFSdBAbWz6sp2SqaZ9OhbWpL/JUEOEJ5JQK8WKaQPA==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr2640763wru.154.1546975433714;
        Tue, 08 Jan 2019 11:23:53 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id s16sm46424082wrt.77.2019.01.08.11.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:23:53 -0800 (PST)
Date:   Tue, 8 Jan 2019 22:23:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mateusz.stepien@netrounds.com,
        a.fatoum@pengutronix.de, adobriyan@gmail.com
Subject: [PATCH v2] proc: fix /proc/net/* after setns(2)
Message-ID: <20190108192350.GA12034@avx2>
References: <20190107162336.GA9239@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107162336.GA9239@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc entries under /proc/net/* can't be cached into dcache because
setns(2) can change current net namespace.

v2:
write test,

add dummy ->d_revalidate hook: necessary if /proc/net/* is pinned at
setns time.

Fixes: 1da4d377f943fe4194ffb9fb9c26cc58fad4dd24 ("proc: revalidate misc dentries")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reported-by: Mateusz Stępień <mateusz.stepien@netrounds.com>
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c                           |    4 
 fs/proc/internal.h                          |    1 
 fs/proc/proc_net.c                          |   20 ++++
 tools/testing/selftests/proc/.gitignore     |    1 
 tools/testing/selftests/proc/Makefile       |    1 
 tools/testing/selftests/proc/setns-dcache.c |  129 ++++++++++++++++++++++++++++
 6 files changed, 155 insertions(+), 1 deletion(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -256,7 +256,7 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
-		d_set_d_op(dentry, &proc_misc_dentry_ops);
+		d_set_d_op(dentry, de->proc_dops);
 		return d_splice_alias(inode, dentry);
 	}
 	read_unlock(&proc_subdir_lock);
@@ -429,6 +429,8 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
 
+	ent->proc_dops = &proc_misc_dentry_ops;
+
 out:
 	return ent;
 }
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -44,6 +44,7 @@ struct proc_dir_entry {
 	struct completion *pde_unload_completion;
 	const struct inode_operations *proc_iops;
 	const struct file_operations *proc_fops;
+	const struct dentry_operations *proc_dops;
 	union {
 		const struct seq_operations *seq_ops;
 		int (*single_show)(struct seq_file *, void *);
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -38,6 +38,22 @@ static struct net *get_proc_net(const struct inode *inode)
 	return maybe_get_net(PDE_NET(PDE(inode)));
 }
 
+static int proc_net_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	return 0;
+}
+
+static const struct dentry_operations proc_net_dentry_ops = {
+	.d_revalidate	= proc_net_d_revalidate,
+	.d_delete	= always_delete_dentry,
+};
+
+static void pde_force_lookup(struct proc_dir_entry *pde)
+{
+	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
+	pde->proc_dops = &proc_net_dentry_ops;
+}
+
 static int seq_open_net(struct inode *inode, struct file *file)
 {
 	unsigned int state_size = PDE(inode)->state_size;
@@ -90,6 +106,7 @@ struct proc_dir_entry *proc_create_net_data(const char *name, umode_t mode,
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_seq_fops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
@@ -133,6 +150,7 @@ struct proc_dir_entry *proc_create_net_data_write(const char *name, umode_t mode
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_seq_fops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
@@ -181,6 +199,7 @@ struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_single_fops;
 	p->single_show = show;
 	return proc_register(parent, p);
@@ -223,6 +242,7 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
 	p = proc_create_reg(name, mode, &parent, data);
 	if (!p)
 		return NULL;
+	pde_force_lookup(p);
 	p->proc_fops = &proc_net_single_fops;
 	p->single_show = show;
 	p->write = write;
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -10,4 +10,5 @@
 /proc-uptime-002
 /read
 /self
+/setns-dcache
 /thread-self
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -14,6 +14,7 @@ TEST_GEN_PROGS += proc-uptime-001
 TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
 TEST_GEN_PROGS += self
+TEST_GEN_PROGS += setns-dcache
 TEST_GEN_PROGS += thread-self
 
 include ../lib.mk
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/setns-dcache.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright © 2019 Alexey Dobriyan <adobriyan@gmail.com>
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
+/*
+ * Test that setns(CLONE_NEWNET) points to new /proc/net content even
+ * if old one is in dcache.
+ *
+ * FIXME /proc/net/unix is under CONFIG_UNIX which can be disabled.
+ */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+
+static pid_t pid = -1;
+
+static void f(void)
+{
+	if (pid > 0) {
+		kill(pid, SIGTERM);
+	}
+}
+
+int main(void)
+{
+	int fd[2];
+	char _ = 0;
+	int nsfd;
+
+	atexit(f);
+
+	/* Check for priviledges and syscall availability straight away. */
+	if (unshare(CLONE_NEWNET) == -1) {
+		if (errno == ENOSYS || errno == EPERM) {
+			return 4;
+		}
+		return 1;
+	}
+	/* Distinguisher between two otherwise empty net namespaces. */
+	if (socket(AF_UNIX, SOCK_STREAM, 0) == -1) {
+		return 1;
+	}
+
+	if (pipe(fd) == -1) {
+		return 1;
+	}
+
+	pid = fork();
+	if (pid == -1) {
+		return 1;
+	}
+
+	if (pid == 0) {
+		if (unshare(CLONE_NEWNET) == -1) {
+			return 1;
+		}
+
+		if (write(fd[1], &_, 1) != 1) {
+			return 1;
+		}
+
+		pause();
+
+		return 0;
+	}
+
+	if (read(fd[0], &_, 1) != 1) {
+		return 1;
+	}
+
+	{
+		char buf[64];
+		snprintf(buf, sizeof(buf), "/proc/%u/ns/net", pid);
+		nsfd = open(buf, O_RDONLY);
+		if (nsfd == -1) {
+			return 1;
+		}
+	}
+
+	/* Reliably pin dentry into dcache. */
+	(void)open("/proc/net/unix", O_RDONLY);
+
+	if (setns(nsfd, CLONE_NEWNET) == -1) {
+		return 1;
+	}
+
+	kill(pid, SIGTERM);
+	pid = 0;
+
+	{
+		char buf[4096];
+		ssize_t rv;
+		int fd;
+
+		fd = open("/proc/net/unix", O_RDONLY);
+		if (fd == -1) {
+			return 1;
+		}
+
+#define S "Num       RefCount Protocol Flags    Type St Inode Path\n"
+		rv = read(fd, buf, sizeof(buf));
+
+		assert(rv == strlen(S));
+		assert(memcmp(buf, S, strlen(S)) == 0);
+	}
+
+	return 0;
+}
