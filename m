Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0041C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E8120828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgdLuhm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeL3Qcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 11:32:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45562 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeL3Qcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 11:32:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so11919424pgc.12;
        Sun, 30 Dec 2018 08:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WuKbljrDZ08rtkHbJbGPqIyK9R7ns2wCb+V+pgdOQ4g=;
        b=lgdLuhm7tuoeqtkEFitpdIm8atWcTexzdtYvOhg8JfBlejqHPewAs8sO9kb22+us39
         c+8tgOeP+e1nkUZxy0haNzs0UdXl0S0Iueu4jsG2cSYQHbK2AaUciX/ZJjrU825IDrhf
         InfhKgp/aZ+bkl5XRS9hK5oRE2yIPfinv7lZN/1e8IHCZ/oG5hwBqgdU209GuUrjs3CU
         REiBLgvzW+WpxlImwEh5q9DynJ4Iq0eL9TuSdGC9cR6LFSHn9EGO3HErJNnE/dOucT6A
         NYqsR2iZ+q2wnPiH7W0VzErENJufoQPeOUP2RSJTFpNk6tEJjlQKt7NTJ1nwklYrS4YU
         XEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WuKbljrDZ08rtkHbJbGPqIyK9R7ns2wCb+V+pgdOQ4g=;
        b=RkOKMpBPBvVazPNI0yLzAAzS3oh2mOJ/QgNRGd+LVHtqxf7NR6ThHnAr1lAJMDpfhb
         zH9zX4rPN7Ya4PBE/W9Zs/Sp5EtJ8dyrTm9Nf1OZFq21emaBhurSOWqvgcdnrUX9XkXZ
         aU+MOz72Q7Bfrm7wrM3fuQermdYTuJydbkwJv8Iybv+ZDGzRcygZYy4Z+SP3KU72+Z/a
         6Yhnv/hIJJHA/h/JGPBTYlgH7hQYNXhquncpHqWcAp3GDd280n813/MSBnBO5TMhMF11
         hL6cPU5xykC5q82sSRfElqRd3l2Ynl+dUA3C0obJXILNz0mkrwnc6lvPiol3KqYY2mEk
         DTxA==
X-Gm-Message-State: AJcUukdEgWaTKipESYK3CVaBOh+eEQSVSw91FUF18t5Y8qwKGbq4sNTO
        mGBJ80CNn+0Vduo1sAf7khQ=
X-Google-Smtp-Source: ALg8bN7BbiA8OrAMvGK3JjYHR6d6vCEfOMUlXdeo1TU+oTeORJEZzTFkZmC3EpEF/ODE6Ev6kOKwiw==
X-Received: by 2002:a63:3204:: with SMTP id y4mr4930307pgy.41.1546187572958;
        Sun, 30 Dec 2018 08:32:52 -0800 (PST)
Received: from ap-To-be-filled-by-O-E-M.8.8.8.8 ([14.33.120.60])
        by smtp.gmail.com with ESMTPSA id b68sm69538989pfg.160.2018.12.30.08.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 08:32:52 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        mcgrof@kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH net 4/4] net: bpfilter: disallow to remove bpfilter module while being used
Date:   Mon, 31 Dec 2018 01:32:45 +0900
Message-Id: <20181230163245.21329-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpfilter.ko module can be removed while functions of the bpfilter.ko
are executing. so panic can occurred. in order to protect that, locks can
be used. a bpfilter_lock protects routines in the
__bpfilter_process_sockopt() but it's not enough because __exit routine
can be executed concurrently.

Now, the bpfilter_umh can not run in parallel.
So, the module do not removed while it's being used and it do not
double-create UMH process.
The members of the umh_info and the bpfilter_umh_ops are protected by
the bpfilter_umh_ops.lock.

test commands:
   while :
   do
	iptables -I FORWARD -m string --string ap --algo kmp &
	modprobe -rv bpfilter &
   done

splat looks like:
[  298.623435] BUG: unable to handle kernel paging request at fffffbfff807440b
[  298.628512] #PF error: [normal kernel read fault]
[  298.633018] PGD 124327067 P4D 124327067 PUD 11c1a3067 PMD 119eb2067 PTE 0
[  298.638859] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[  298.638859] CPU: 0 PID: 2997 Comm: iptables Not tainted 4.20.0+ #154
[  298.638859] RIP: 0010:__mutex_lock+0x6b9/0x16a0
[  298.638859] Code: c0 00 00 e8 89 82 ff ff 80 bd 8f fc ff ff 00 0f 85 d9 05 00 00 48 8b 85 80 fc ff ff 48 bf 00 00 00 00 00 fc ff df 48 c1 e8 03 <80> 3c 38 00 0f 85 1d 0e 00 00 48 8b 85 c8 fc ff ff 49 39 47 58 c6
[  298.638859] RSP: 0018:ffff88810e7777a0 EFLAGS: 00010202
[  298.638859] RAX: 1ffffffff807440b RBX: ffff888111bd4d80 RCX: 0000000000000000
[  298.638859] RDX: 1ffff110235ff806 RSI: ffff888111bd5538 RDI: dffffc0000000000
[  298.638859] RBP: ffff88810e777b30 R08: 0000000080000002 R09: 0000000000000000
[  298.638859] R10: 0000000000000000 R11: 0000000000000000 R12: fffffbfff168a42c
[  298.638859] R13: ffff888111bd4d80 R14: ffff8881040e9a05 R15: ffffffffc03a2000
[  298.638859] FS:  00007f39e3758700(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
[  298.638859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  298.638859] CR2: fffffbfff807440b CR3: 000000011243e000 CR4: 00000000001006f0
[  298.638859] Call Trace:
[  298.638859]  ? mutex_lock_io_nested+0x1560/0x1560
[  298.638859]  ? kasan_kmalloc+0xa0/0xd0
[  298.638859]  ? kmem_cache_alloc+0x1c2/0x260
[  298.638859]  ? __alloc_file+0x92/0x3c0
[  298.638859]  ? alloc_empty_file+0x43/0x120
[  298.638859]  ? alloc_file_pseudo+0x220/0x330
[  298.638859]  ? sock_alloc_file+0x39/0x160
[  298.638859]  ? __sys_socket+0x113/0x1d0
[  298.638859]  ? __x64_sys_socket+0x6f/0xb0
[  298.638859]  ? do_syscall_64+0x138/0x560
[  298.638859]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  298.638859]  ? __alloc_file+0x92/0x3c0
[  298.638859]  ? init_object+0x6b/0x80
[  298.638859]  ? cyc2ns_read_end+0x10/0x10
[  298.638859]  ? cyc2ns_read_end+0x10/0x10
[  298.638859]  ? hlock_class+0x140/0x140
[  298.638859]  ? sched_clock_local+0xd4/0x140
[  298.638859]  ? sched_clock_local+0xd4/0x140
[  298.638859]  ? check_flags.part.37+0x440/0x440
[  298.638859]  ? __lock_acquire+0x4f90/0x4f90
[  298.638859]  ? set_rq_offline.part.89+0x140/0x140
[ ... ]
Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 include/linux/bpfilter.h     |  2 ++
 net/bpfilter/bpfilter_kern.c | 20 ++++++--------------
 net/ipv4/bpfilter/sockopt.c  | 21 ++++++++++++++++-----
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
index 8ebcbdd70bdc..d815622cd31e 100644
--- a/include/linux/bpfilter.h
+++ b/include/linux/bpfilter.h
@@ -12,6 +12,8 @@ int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 			    int __user *optlen);
 struct bpfilter_umh_ops {
 	struct umh_info info;
+	/* since ip_getsockopt() can run in parallel, serialize access to umh */
+	struct mutex lock;
 	int (*sockopt)(struct sock *sk, int optname,
 		       char __user *optval,
 		       unsigned int optlen, bool is_set);
diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 33d6b159ba88..eedb83863cb0 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -13,9 +13,6 @@
 extern char bpfilter_umh_start;
 extern char bpfilter_umh_end;
 
-/* since ip_getsockopt() can run in parallel, serialize access to umh */
-static DEFINE_MUTEX(bpfilter_lock);
-
 static void shutdown_umh(void)
 {
 	struct task_struct *tsk;
@@ -36,13 +33,6 @@ static void __stop_umh(void)
 		shutdown_umh();
 }
 
-static void stop_umh(void)
-{
-	mutex_lock(&bpfilter_lock);
-	__stop_umh();
-	mutex_unlock(&bpfilter_lock);
-}
-
 static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 				      char __user *optval,
 				      unsigned int optlen, bool is_set)
@@ -58,7 +48,6 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 	req.cmd = optname;
 	req.addr = (long __force __user)optval;
 	req.len = optlen;
-	mutex_lock(&bpfilter_lock);
 	if (!bpfilter_ops.info.pid)
 		goto out;
 	n = __kernel_write(bpfilter_ops.info.pipe_to_umh, &req, sizeof(req),
@@ -80,7 +69,6 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 	}
 	ret = reply.status;
 out:
-	mutex_unlock(&bpfilter_lock);
 	return ret;
 }
 
@@ -99,7 +87,7 @@ static int start_umh(void)
 
 	/* health check that usermode process started correctly */
 	if (__bpfilter_process_sockopt(NULL, 0, NULL, 0, 0) != 0) {
-		stop_umh();
+		shutdown_umh();
 		return -EFAULT;
 	}
 
@@ -110,22 +98,26 @@ static int __init load_umh(void)
 {
 	int err;
 
+	mutex_lock(&bpfilter_ops.lock);
 	err = start_umh();
 	if (!err && IS_ENABLED(CONFIG_INET)) {
 		bpfilter_ops.sockopt = &__bpfilter_process_sockopt;
 		bpfilter_ops.start = &start_umh;
 	}
+	mutex_unlock(&bpfilter_ops.lock);
 
 	return err;
 }
 
 static void __exit fini_umh(void)
 {
+	mutex_lock(&bpfilter_ops.lock);
 	if (IS_ENABLED(CONFIG_INET)) {
+		shutdown_umh();
 		bpfilter_ops.start = NULL;
 		bpfilter_ops.sockopt = NULL;
 	}
-	stop_umh();
+	mutex_unlock(&bpfilter_ops.lock);
 }
 module_init(load_umh);
 module_exit(fini_umh);
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index de84ede4e765..2611f7a7f3d1 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -14,10 +14,12 @@ EXPORT_SYMBOL_GPL(bpfilter_ops);
 
 static void bpfilter_umh_cleanup(struct umh_info *info)
 {
+	mutex_lock(&bpfilter_ops.lock);
 	bpfilter_ops.stop = true;
 	fput(info->pipe_to_umh);
 	fput(info->pipe_from_umh);
 	info->pid = 0;
+	mutex_unlock(&bpfilter_ops.lock);
 }
 
 static int bpfilter_mbox_request(struct sock *sk, int optname,
@@ -26,20 +28,28 @@ static int bpfilter_mbox_request(struct sock *sk, int optname,
 {
 	int err;
 
+	mutex_lock(&bpfilter_ops.lock);
 	if (!bpfilter_ops.sockopt) {
+		mutex_unlock(&bpfilter_ops.lock);
 		err = request_module("bpfilter");
+		mutex_lock(&bpfilter_ops.lock);
 
 		if (err)
-			return err;
-		if (!bpfilter_ops.sockopt)
-			return -ECHILD;
+			goto out;
+		if (!bpfilter_ops.sockopt) {
+			err = -ECHILD;
+			goto out;
+		}
 	}
 	if (bpfilter_ops.stop) {
 		err = bpfilter_ops.start();
 		if (err)
-			return err;
+			goto out;
 	}
-	return bpfilter_ops.sockopt(sk, optname, optval, optlen, is_set);
+	err =  bpfilter_ops.sockopt(sk, optname, optval, optlen, is_set);
+out:
+	mutex_unlock(&bpfilter_ops.lock);
+	return err;
 }
 
 int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
@@ -61,6 +71,7 @@ int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
 
 static int __init bpfilter_sockopt_init(void)
 {
+	mutex_init(&bpfilter_ops.lock);
 	bpfilter_ops.stop = true;
 	bpfilter_ops.info.cmdline = "bpfilter_umh";
 	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
-- 
2.17.1

