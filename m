Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D4D20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwSTmCO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAGMLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:11:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfAGMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:11:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so59946pgl.6;
        Mon, 07 Jan 2019 04:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QMJufnjC2av/TaQG0Gtve4swcI6YQyf9FiBVtu4QS/Y=;
        b=mwSTmCO/JP4JX/0NMIjbu8rOAnPUv/IZE9XSS7RogoS44O+cczU2xn0Cxe7O2EjRXK
         j64rhUKMCt0KP+B6wWQQmX/q71V2ear9jeiD1keSFId6GbxFaAwg3xvoJOQkAn3WLBCJ
         9sP8vzX4mgHIZ5WIIzQxOfLQfU42rSbjvBqN2vBdtDwfb74b3IAt720d33sIL+hHGY6S
         gsF+qvZAgwKXxOo2sHt6p8y1K5pVBEdxYhbuVBC2ZKr4Klee8w+21yuMIXHmaoPw8gc5
         YPklVWQl9Jeehd8p+S31bllctTuYhze2KBW3Vf231bfxRASFF/soga9n686S/LgZO6+T
         KqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QMJufnjC2av/TaQG0Gtve4swcI6YQyf9FiBVtu4QS/Y=;
        b=oWtQ7TCnBgwBkj4RJlQXD5o0f64aV9IKnpRPCcLwc6tgAHDowCqjd3AlQ79fx++4g0
         U4Bh00siFkaKsKcTswFgF//UFYdIb0QwK+hPYzTE/+oyiqfb0IDsMUN/lJ572sX4Wgsv
         Kvncjvj42a6NFXpesj6Tmaa5mxv02Gt5G1oi9vF1YIIGByNq8xQxJjlPYLRjmJUstyBn
         BM58kAx9h1DFlWUvnmyQlgvwGXE8k2wL2rza6Z+FSNxEHsuoT2VOw9mPUbYcDzjKox+v
         EuG5WuNnFXVo+CskZKmkAGNB9rZDQ0cuqkg+1tT50dUPBY2cUH5Ini9F9XqYW9KR0lxk
         pLvg==
X-Gm-Message-State: AJcUukfuSjG+bUP5GWK+6rDf5Fd9pPhXT64RTu7h6L5KYlzWsujinhqu
        Oqf5yvztTYmqm0U+22cKsOw=
X-Google-Smtp-Source: ALg8bN5s5LVeY9D0qFLBGTh+1wL5jf2faMlhMIOJGOpo0DvKC3eXSRhRcCWKig01kGjiEj8Ss2Vkpw==
X-Received: by 2002:a62:c583:: with SMTP id j125mr63302398pfg.37.1546863061022;
        Mon, 07 Jan 2019 04:11:01 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id 125sm114569860pfd.124.2019.01.07.04.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 04:11:00 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net v3 2/4] net: bpfilter: use cleanup callback to release umh_info
Date:   Mon,  7 Jan 2019 21:10:52 +0900
Message-Id: <20190107121052.13645-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, UMH process is killed, do_exit() calls the umh_info->cleanup callback
to release members of the umh_info.
This patch makes bpfilter_umh's cleanup routine to use the
umh_info->cleanup callback.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 include/linux/bpfilter.h     | 11 ++++++++---
 net/bpfilter/bpfilter_kern.c | 23 ++++++++++-------------
 net/ipv4/bpfilter/sockopt.c  | 33 ++++++++++++++++++++++++++-------
 3 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index f02cee0225d4..70ffeed280e9 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -3,13 +3,18 @@
 #define _LINUX_BPFILTER_H
 
 #include <uapi/linux/bpfilter.h>
+#include <linux/umh.h>
 
 struct sock;
 int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
 			    unsigned int optlen);
 int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 			    int __user *optlen);
-extern int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
-				       char __user *optval,
-				       unsigned int optlen, bool is_set);
+struct bpfilter_umh_ops {
+	struct umh_info info;
+	int (*sockopt)(struct sock *sk, int optname,
+		       char __user *optval,
+		       unsigned int optlen, bool is_set);
+};
+extern struct bpfilter_umh_ops bpfilter_ops;
 #endif
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 7acfc83087d5..a68940b74c01 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -13,7 +13,6 @@
 extern char bpfilter_umh_start;
 extern char bpfilter_umh_end;
 
-static struct umh_info info;
 /* since ip_getsockopt() can run in parallel, serialize access to umh */
 static DEFINE_MUTEX(bpfilter_lock);
 
@@ -28,16 +27,13 @@ static void shutdown_umh(struct umh_info *info)
 		force_sig(SIGKILL, tsk);
 		put_task_struct(tsk);
 	}
-	fput(info->pipe_to_umh);
-	fput(info->pipe_from_umh);
-	info->pid = 0;
 }
 
 static void __stop_umh(void)
 {
 	if (IS_ENABLED(CONFIG_INET)) {
-		bpfilter_process_sockopt = NULL;
-		shutdown_umh(&info);
+		bpfilter_ops.sockopt = NULL;
+		shutdown_umh(&bpfilter_ops.info);
 	}
 }
 
@@ -64,9 +60,10 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 	req.addr = (long __force __user)optval;
 	req.len = optlen;
 	mutex_lock(&bpfilter_lock);
-	if (!info.pid)
+	if (!bpfilter_ops.info.pid)
 		goto out;
-	n = __kernel_write(info.pipe_to_umh, &req, sizeof(req), &pos);
+	n = __kernel_write(bpfilter_ops.info.pipe_to_umh, &req, sizeof(req),
+			   &pos);
 	if (n != sizeof(req)) {
 		pr_err("write fail %zd\n", n);
 		__stop_umh();
@@ -74,7 +71,8 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 		goto out;
 	}
 	pos = 0;
-	n = kernel_read(info.pipe_from_umh, &reply, sizeof(reply), &pos);
+	n = kernel_read(bpfilter_ops.info.pipe_from_umh, &reply, sizeof(reply),
+			&pos);
 	if (n != sizeof(reply)) {
 		pr_err("read fail %zd\n", n);
 		__stop_umh();
@@ -92,13 +90,12 @@ static int __init load_umh(void)
 	int err;
 
 	/* fork usermode process */
-	info.cmdline = "bpfilter_umh";
 	err = fork_usermode_blob(&bpfilter_umh_start,
 				 &bpfilter_umh_end - &bpfilter_umh_start,
-				 &info);
+				 &bpfilter_ops.info);
 	if (err)
 		return err;
-	pr_info("Loaded bpfilter_umh pid %d\n", info.pid);
+	pr_info("Loaded bpfilter_umh pid %d\n", bpfilter_ops.info.pid);
 
 	/* health check that usermode process started correctly */
 	if (__bpfilter_process_sockopt(NULL, 0, NULL, 0, 0) != 0) {
@@ -106,7 +103,7 @@ static int __init load_umh(void)
 		return -EFAULT;
 	}
 	if (IS_ENABLED(CONFIG_INET))
-		bpfilter_process_sockopt = &__bpfilter_process_sockopt;
+		bpfilter_ops.sockopt = &__bpfilter_process_sockopt;
 
 	return 0;
 }
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index 5e04ed25bc0e..c326cfbc0f62 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -1,28 +1,37 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/bpfilter.h>
 #include <uapi/linux/bpf.h>
 #include <linux/wait.h>
 #include <linux/kmod.h>
+#include <linux/fs.h>
+#include <linux/file.h>
 
-int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
-				char __user *optval,
-				unsigned int optlen, bool is_set);
-EXPORT_SYMBOL_GPL(bpfilter_process_sockopt);
+struct bpfilter_umh_ops bpfilter_ops;
+EXPORT_SYMBOL_GPL(bpfilter_ops);
+
+static void bpfilter_umh_cleanup(struct umh_info *info)
+{
+	fput(info->pipe_to_umh);
+	fput(info->pipe_from_umh);
+	info->pid = 0;
+}
 
 static int bpfilter_mbox_request(struct sock *sk, int optname,
 				 char __user *optval,
 				 unsigned int optlen, bool is_set)
 {
-	if (!bpfilter_process_sockopt) {
+	if (!bpfilter_ops.sockopt) {
 		int err = request_module("bpfilter");
 
 		if (err)
 			return err;
-		if (!bpfilter_process_sockopt)
+		if (!bpfilter_ops.sockopt)
 			return -ECHILD;
 	}
-	return bpfilter_process_sockopt(sk, optname, optval, optlen, is_set);
+	return bpfilter_ops.sockopt(sk, optname, optval, optlen, is_set);
 }
 
 int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
@@ -41,3 +50,13 @@ int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 
 	return bpfilter_mbox_request(sk, optname, optval, len, false);
 }
+
+static int __init bpfilter_sockopt_init(void)
+{
+	bpfilter_ops.info.cmdline = "bpfilter_umh";
+	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
+
+	return 0;
+}
+
+module_init(bpfilter_sockopt_init);
-- 
2.17.1

