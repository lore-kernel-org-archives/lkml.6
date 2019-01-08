Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7306FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AF52070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha8Uq2c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfAHRZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:25:02 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35958 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfAHRZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:25:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so2022673pgm.3;
        Tue, 08 Jan 2019 09:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4xqkQBXxToRNOV/fppJ7klWDC5/DBZ60dY2jrEDIRTo=;
        b=Ha8Uq2c8mj02Vtj9k8cD1N7rUFyZ8qjot331HfHAfJ510OSSRVOZcr667p7RW4QDdy
         8X8TS7UofjgcQTqfD8jWAZojHjDIgdjuHSxuezJ/WgYLGvY+jAPP3zURdLTNZZ2oVh1i
         JsUz0kf7dGmFcU2RfbPj+Q36kE5j+9EyDIIRt/a1f0PS7SaYwYHQkLxtHuZ7zd+2XG5l
         IOHJwWLPfwF3QJFUB0iJIWY7OIxfozxlevYPsiZovT4Z29iG86kl7KFaP22Hnpzb5Sex
         FZuNax+VGxEeK1QvaY+SA94CKAEZN5Dk40XxEJq/Ybrb+QlbBO+jQ4f57VEO1S66xNdS
         8M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4xqkQBXxToRNOV/fppJ7klWDC5/DBZ60dY2jrEDIRTo=;
        b=tuS8Mx4VXzpI6zEVptxI2Qn4BjqqxnFBWnC1Sv90kCjzPECg1cZQ4r8bOl2S51b5Y5
         5AxZz+9KGkkTFXsxIWO7eGpApOTdQNkPYQAXzanQ7VMbv1czSlq4hKPSiVsT8YeZ5bGI
         teL6XJEfc7q6huP9Wi9QjPYztiHVZnkQFH7TnFc9hk8zwOXgFAY2GPVcWIxr1jO3zsh1
         rYp57A6rjSroymvomxvlFGOuwsGDt+e01O75FaTUptFNuLlQlTFa3GmOWzzOwMTUT7Jz
         0yeU1jSp5T1FlWs/rBhcwwmAlbNRlvXOxVNNsxsm5vippPOxh1rAEswOkJqzZAx/c6w7
         +Fag==
X-Gm-Message-State: AJcUukdlVQ/nuJQx+fNSbuuhGvNVHEaCPd00pEJm7RHkNKJsRPPTGtwC
        zvmjvCnBMiu90RKn/8/Q2rs=
X-Google-Smtp-Source: ALg8bN7k/X1KXqsUADSRoWpsbGXkhPYZdIGB/eJGQAPep9XquFWIURe6h54EDBSLBq9EMBjd1+jb2g==
X-Received: by 2002:a63:1444:: with SMTP id 4mr76861pgu.430.1546968300455;
        Tue, 08 Jan 2019 09:25:00 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id p7sm107959651pfa.22.2019.01.08.09.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:24:59 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net v4 3/4] net: bpfilter: restart bpfilter_umh when error occurred
Date:   Wed,  9 Jan 2019 02:24:53 +0900
Message-Id: <20190108172453.12211-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpfilter_umh will be stopped via __stop_umh() when the bpfilter
error occurred.
The bpfilter_umh() couldn't start again because there is no restart
routine.

The section of the bpfilter_umh_{start/end} is no longer .init.rodata
because these area should be reused in the restart routine. hence
the section name is changed to .bpfilter_umh.

The bpfilter_ops->start() is restart callback. it will be called when
bpfilter_umh is stopped.
The stop bit means bpfilter_umh is stopped. this bit is set by both
start and stop routine.

Before this patch,
Test commands:
   $ iptables -vnL
   $ kill -9 <pid of bpfilter_umh>
   $ iptables -vnL
   [  480.045136] bpfilter: write fail -32
   $ iptables -vnL

All iptables commands will fail.

After this patch,
Test commands:
   $ iptables -vnL
   $ kill -9 <pid of bpfilter_umh>
   $ iptables -vnL
   $ iptables -vnL

Now, all iptables commands will work.

Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v4 : check stop flag in the load_umh() to avoid a double-create UMH

 include/linux/bpfilter.h         |  2 ++
 net/bpfilter/bpfilter_kern.c     | 37 +++++++++++++++++++++++---------
 net/bpfilter/bpfilter_umh_blob.S |  2 +-
 net/ipv4/bpfilter/sockopt.c      | 11 +++++++++-
 4 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index 70ffeed280e9..8ebcbdd70bdc 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -15,6 +15,8 @@ struct bpfilter_umh_ops {
 	int (*sockopt)(struct sock *sk, int optname,
 		       char __user *optval,
 		       unsigned int optlen, bool is_set);
+	int (*start)(void);
+	bool stop;
 };
 extern struct bpfilter_umh_ops bpfilter_ops;
 #endif
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index a68940b74c01..c0fcde910a7a 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -16,13 +16,14 @@ extern char bpfilter_umh_end;
 /* since ip_getsockopt() can run in parallel, serialize access to umh */
 static DEFINE_MUTEX(bpfilter_lock);
 
-static void shutdown_umh(struct umh_info *info)
+static void shutdown_umh(void)
 {
 	struct task_struct *tsk;
 
-	if (!info->pid)
+	if (bpfilter_ops.stop)
 		return;
-	tsk = get_pid_task(find_vpid(info->pid), PIDTYPE_PID);
+
+	tsk = get_pid_task(find_vpid(bpfilter_ops.info.pid), PIDTYPE_PID);
 	if (tsk) {
 		force_sig(SIGKILL, tsk);
 		put_task_struct(tsk);
@@ -31,10 +32,8 @@ static void shutdown_umh(struct umh_info *info)
 
 static void __stop_umh(void)
 {
-	if (IS_ENABLED(CONFIG_INET)) {
-		bpfilter_ops.sockopt = NULL;
-		shutdown_umh(&bpfilter_ops.info);
-	}
+	if (IS_ENABLED(CONFIG_INET))
+		shutdown_umh();
 }
 
 static void stop_umh(void)
@@ -85,7 +84,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 	return ret;
 }
 
-static int __init load_umh(void)
+static int start_umh(void)
 {
 	int err;
 
@@ -95,6 +94,7 @@ static int __init load_umh(void)
 				 &bpfilter_ops.info);
 	if (err)
 		return err;
+	bpfilter_ops.stop = false;
 	pr_info("Loaded bpfilter_umh pid %d\n", bpfilter_ops.info.pid);
 
 	/* health check that usermode process started correctly */
@@ -102,14 +102,31 @@ static int __init load_umh(void)
 		stop_umh();
 		return -EFAULT;
 	}
-	if (IS_ENABLED(CONFIG_INET))
-		bpfilter_ops.sockopt = &__bpfilter_process_sockopt;
 
 	return 0;
 }
 
+static int __init load_umh(void)
+{
+	int err;
+
+	if (!bpfilter_ops.stop)
+		return -EFAULT;
+	err = start_umh();
+	if (!err && IS_ENABLED(CONFIG_INET)) {
+		bpfilter_ops.sockopt = &__bpfilter_process_sockopt;
+		bpfilter_ops.start = &start_umh;
+	}
+
+	return err;
+}
+
 static void __exit fini_umh(void)
 {
+	if (IS_ENABLED(CONFIG_INET)) {
+		bpfilter_ops.start = NULL;
+		bpfilter_ops.sockopt = NULL;
+	}
 	stop_umh();
 }
 module_init(load_umh);
diff --git a/net/bpfilter/bpfilter_umh_blob.S b/net/bpfilter/bpfilter_umh_blob.S
index 40311d10d2f2..7f1c521dcc2f 100644
--- a/net/bpfilter/bpfilter_umh_blob.S
+++ b/net/bpfilter/bpfilter_umh_blob.S
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-	.section .init.rodata, "a"
+	.section .bpfilter_umh, "a"
 	.global bpfilter_umh_start
 bpfilter_umh_start:
 	.incbin "net/bpfilter/bpfilter_umh"
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index c326cfbc0f62..de84ede4e765 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -14,6 +14,7 @@ EXPORT_SYMBOL_GPL(bpfilter_ops);
 
 static void bpfilter_umh_cleanup(struct umh_info *info)
 {
+	bpfilter_ops.stop = true;
 	fput(info->pipe_to_umh);
 	fput(info->pipe_from_umh);
 	info->pid = 0;
@@ -23,14 +24,21 @@ static int bpfilter_mbox_request(struct sock *sk, int optname,
 				 char __user *optval,
 				 unsigned int optlen, bool is_set)
 {
+	int err;
+
 	if (!bpfilter_ops.sockopt) {
-		int err = request_module("bpfilter");
+		err = request_module("bpfilter");
 
 		if (err)
 			return err;
 		if (!bpfilter_ops.sockopt)
 			return -ECHILD;
 	}
+	if (bpfilter_ops.stop) {
+		err = bpfilter_ops.start();
+		if (err)
+			return err;
+	}
 	return bpfilter_ops.sockopt(sk, optname, optval, optlen, is_set);
 }
 
@@ -53,6 +61,7 @@ int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 
 static int __init bpfilter_sockopt_init(void)
 {
+	bpfilter_ops.stop = true;
 	bpfilter_ops.info.cmdline = "bpfilter_umh";
 	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
 
-- 
2.17.1

