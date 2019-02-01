Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30A3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BAC218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwhNskoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfBAPol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:44:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46546 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbfBAPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:44:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id e6so168300pls.13;
        Fri, 01 Feb 2019 07:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ol82hxi8909HEMV5KVUItjtWNoBQexT6N/5Ohh18zTg=;
        b=IwhNskoOB8LWCcIucG3BSPYLYKH0j+o8q1zku71OtGUFQm1mxzgoe9/995GjKTikfQ
         rz9R+oFmX6UtF1G0r+Erz10WsoZDXjhFSiOss3/NfHuD0n9plGSQIuCmp6L5NEM/7tdw
         lFPiw2HtbnTcGT7I/L7z8DaVLCJ/Wpwgf/sdbR71Nh+bbSVgY4AjF12eaHB0cmnuZjY4
         nMiXOIn0nFHood/Xah2VZ+DMLn8tiRvRNscOQF3MaG8fDqlFtyB76NO/FbMPosPfZbD9
         H0OpSGavnWQBzRexjaqo7BF/wSj+78lbdbx3dusd0uObHl7ga0o8nP2GImoct2qcvWaT
         p93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ol82hxi8909HEMV5KVUItjtWNoBQexT6N/5Ohh18zTg=;
        b=OYEv340LN3ovlb7UqIaLhVIW5aC34zLCZUVX3o3ZGKIUjuBTFViQgHBMM6hXhCLwpf
         AoFbe7TiNm/mBpTnpyHdJP3UIap8X0NHXsnNIC+Dg+nnZFfbmw4unurcJTMyea8CV/zF
         jGbF87pZz0hnYg6res7kP6P6XSCMZCLEwSwctakrrkwqXGzeHWJj3rsDBs9WKOHrX2XW
         LSvgRjN2XgZHEpiOoIeHS5L8V5aTlH3DH1rtbCjiQ5UYDtZXpdMgKRz+rpaOoJk/Vp4U
         lAlEs9OMvfIEhMcLrJeIMN1bUKxX02tTmnpxQTNzkPSdhybwRwEpkdl9nyNdXDOsJ2l+
         ekHQ==
X-Gm-Message-State: AJcUukeu+jd5VZrbiA2trXhXaVO0jz30GdcydTOLIDZXCfhPH3OWX+ee
        4DbovivFG3DQptzCu87cueRqYYoZcS0=
X-Google-Smtp-Source: ALg8bN4NfZBWzWBBzjtGpibzLeHMoqRkOPfGYskKb8rWB7EUTzIuQFgSlvzs0kQ9beoOk0nVnlUdeA==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr37803809plb.70.1549035876736;
        Fri, 01 Feb 2019 07:44:36 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id z9sm25886959pfd.99.2019.02.01.07.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:44:36 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next v4 02/12] socket: move compat timeout handling into sock.c
Date:   Fri,  1 Feb 2019 07:43:46 -0800
Message-Id: <20190201154356.15536-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201154356.15536-1-deepa.kernel@gmail.com>
References: <20190201154356.15536-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is a cleanup to prepare for the addition of 64-bit time_t
in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
unnecessarily complex and error-prone, moving it all into the
main setsockopt()/getsockopt() implementation requires half
as much code and is easier to extend.

32-bit user space can now use old_timeval32 on both 32-bit
and 64-bit machines, while 64-bit code can use
__old_kernel_timeval.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 net/compat.c             | 66 +---------------------------------------
 net/core/sock.c          | 65 +++++++++++++++++++++++++--------------
 net/vmw_vsock/af_vsock.c |  4 +--
 3 files changed, 46 insertions(+), 89 deletions(-)

diff --git a/net/compat.c b/net/compat.c
index 959d1c51826d..ce8f6e8cdcd2 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -348,28 +348,6 @@ static int do_set_attach_filter(struct socket *sock, int level, int optname,
 			      sizeof(struct sock_fprog));
 }
 
-static int do_set_sock_timeout(struct socket *sock, int level,
-		int optname, char __user *optval, unsigned int optlen)
-{
-	struct compat_timeval __user *up = (struct compat_timeval __user *)optval;
-	struct timeval ktime;
-	mm_segment_t old_fs;
-	int err;
-
-	if (optlen < sizeof(*up))
-		return -EINVAL;
-	if (!access_ok(up, sizeof(*up)) ||
-	    __get_user(ktime.tv_sec, &up->tv_sec) ||
-	    __get_user(ktime.tv_usec, &up->tv_usec))
-		return -EFAULT;
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sock_setsockopt(sock, level, optname, (char *)&ktime, sizeof(ktime));
-	set_fs(old_fs);
-
-	return err;
-}
-
 static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 				char __user *optval, unsigned int optlen)
 {
@@ -377,10 +355,6 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 	    optname == SO_ATTACH_REUSEPORT_CBPF)
 		return do_set_attach_filter(sock, level, optname,
 					    optval, optlen);
-	if (!COMPAT_USE_64BIT_TIME &&
-	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
-		return do_set_sock_timeout(sock, level, optname, optval, optlen);
-
 	return sock_setsockopt(sock, level, optname, optval, optlen);
 }
 
@@ -417,44 +391,6 @@ COMPAT_SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 	return __compat_sys_setsockopt(fd, level, optname, optval, optlen);
 }
 
-static int do_get_sock_timeout(struct socket *sock, int level, int optname,
-		char __user *optval, int __user *optlen)
-{
-	struct compat_timeval __user *up;
-	struct timeval ktime;
-	mm_segment_t old_fs;
-	int len, err;
-
-	up = (struct compat_timeval __user *) optval;
-	if (get_user(len, optlen))
-		return -EFAULT;
-	if (len < sizeof(*up))
-		return -EINVAL;
-	len = sizeof(ktime);
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sock_getsockopt(sock, level, optname, (char *) &ktime, &len);
-	set_fs(old_fs);
-
-	if (!err) {
-		if (put_user(sizeof(*up), optlen) ||
-		    !access_ok(up, sizeof(*up)) ||
-		    __put_user(ktime.tv_sec, &up->tv_sec) ||
-		    __put_user(ktime.tv_usec, &up->tv_usec))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
-				char __user *optval, int __user *optlen)
-{
-	if (!COMPAT_USE_64BIT_TIME &&
-	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
-		return do_get_sock_timeout(sock, level, optname, optval, optlen);
-	return sock_getsockopt(sock, level, optname, optval, optlen);
-}
-
 int compat_sock_get_timestamp(struct sock *sk, struct timeval __user *userstamp)
 {
 	struct compat_timeval __user *ctv;
@@ -527,7 +463,7 @@ static int __compat_sys_getsockopt(int fd, int level, int optname,
 		}
 
 		if (level == SOL_SOCKET)
-			err = compat_sock_getsockopt(sock, level,
+			err = sock_getsockopt(sock, level,
 					optname, optval, optlen);
 		else if (sock->ops->compat_getsockopt)
 			err = sock->ops->compat_getsockopt(sock, level,
diff --git a/net/core/sock.c b/net/core/sock.c
index 900e8a9435f5..a3fe0e7f49b0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -335,14 +335,48 @@ int __sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(__sk_backlog_rcv);
 
+static int sock_get_timeout(long timeo, void *optval)
+{
+	struct __kernel_old_timeval tv;
+
+	if (timeo == MAX_SCHEDULE_TIMEOUT) {
+		tv.tv_sec = 0;
+		tv.tv_usec = 0;
+	} else {
+		tv.tv_sec = timeo / HZ;
+		tv.tv_usec = ((timeo % HZ) * USEC_PER_SEC) / HZ;
+	}
+
+	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
+		struct old_timeval32 tv32 = { tv.tv_sec, tv.tv_usec };
+		*(struct old_timeval32 *)optval = tv32;
+		return sizeof(tv32);
+	}
+
+	*(struct __kernel_old_timeval *)optval = tv;
+	return sizeof(tv);
+}
+
 static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 {
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 
-	if (optlen < sizeof(tv))
-		return -EINVAL;
-	if (copy_from_user(&tv, optval, sizeof(tv)))
-		return -EFAULT;
+	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
+		struct old_timeval32 tv32;
+
+		if (optlen < sizeof(tv32))
+			return -EINVAL;
+
+		if (copy_from_user(&tv32, optval, sizeof(tv32)))
+			return -EFAULT;
+		tv.tv_sec = tv32.tv_sec;
+		tv.tv_usec = tv32.tv_usec;
+	} else {
+		if (optlen < sizeof(tv))
+			return -EINVAL;
+		if (copy_from_user(&tv, optval, sizeof(tv)))
+			return -EFAULT;
+	}
 	if (tv.tv_usec < 0 || tv.tv_usec >= USEC_PER_SEC)
 		return -EDOM;
 
@@ -1121,7 +1155,8 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		int val;
 		u64 val64;
 		struct linger ling;
-		struct timeval tm;
+		struct old_timeval32 tm32;
+		struct __kernel_old_timeval tm;
 		struct sock_txtime txtime;
 	} v;
 
@@ -1222,25 +1257,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVTIMEO:
-		lv = sizeof(struct timeval);
-		if (sk->sk_rcvtimeo == MAX_SCHEDULE_TIMEOUT) {
-			v.tm.tv_sec = 0;
-			v.tm.tv_usec = 0;
-		} else {
-			v.tm.tv_sec = sk->sk_rcvtimeo / HZ;
-			v.tm.tv_usec = ((sk->sk_rcvtimeo % HZ) * USEC_PER_SEC) / HZ;
-		}
+		lv = sock_get_timeout(sk->sk_rcvtimeo, optval);
 		break;
 
 	case SO_SNDTIMEO:
-		lv = sizeof(struct timeval);
-		if (sk->sk_sndtimeo == MAX_SCHEDULE_TIMEOUT) {
-			v.tm.tv_sec = 0;
-			v.tm.tv_usec = 0;
-		} else {
-			v.tm.tv_sec = sk->sk_sndtimeo / HZ;
-			v.tm.tv_usec = ((sk->sk_sndtimeo % HZ) * USEC_PER_SEC) / HZ;
-		}
+		lv = sock_get_timeout(sk->sk_sndtimeo, optval);
 		break;
 
 	case SO_RCVLOWAT:
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a60df252d3cc..d892000770cf 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1439,7 +1439,7 @@ static int vsock_stream_setsockopt(struct socket *sock,
 		break;
 
 	case SO_VM_SOCKETS_CONNECT_TIMEOUT: {
-		struct timeval tv;
+		struct __kernel_old_timeval tv;
 		COPY_IN(tv);
 		if (tv.tv_sec >= 0 && tv.tv_usec < USEC_PER_SEC &&
 		    tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)) {
@@ -1517,7 +1517,7 @@ static int vsock_stream_getsockopt(struct socket *sock,
 		break;
 
 	case SO_VM_SOCKETS_CONNECT_TIMEOUT: {
-		struct timeval tv;
+		struct __kernel_old_timeval tv;
 		tv.tv_sec = vsk->connect_timeout / HZ;
 		tv.tv_usec =
 		    (vsk->connect_timeout -
-- 
2.17.1

