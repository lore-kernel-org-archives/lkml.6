Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808382087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnq/fq1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfAHFXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:23:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38848 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfAHFXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:23:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so1196368pgc.5;
        Mon, 07 Jan 2019 21:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tAhRSlvBCw0jlWlEIq0KYU18kUyop4luzyQAUajikNU=;
        b=pnq/fq1nrzFtTMiE5UoQbAHmSN+Du0v7pZ15O4bPg7rGRYVYNIIvVTFKGpQ+sVMaf+
         bIDwSbSXVRcVXQ+hxFMFdbgZBcKPASXmys8a1hBQzxKO+HI0ViCW4ywf4BcBBaczMDau
         rWXcHnl+NguPFKZOneQFOafV7mKPMTI5b0MTluUD4DkcWbtkRpkeJHkHXRw5PwdLFJPL
         7x5AQqXhZ1cmNvCRQbpk3lthD6/CUqG+8UbP7nzk0qdWC/A0j8/I2Gb2o/TwFPmjiYam
         2b8PDEYVrL12VmBPgZGpjaBLtVVJRVjzKQsZpSRyM71bN9fDhbCwdiYlwD8vIfE7JSCA
         kdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tAhRSlvBCw0jlWlEIq0KYU18kUyop4luzyQAUajikNU=;
        b=sx6lixOwV9deadG10+FzJIanzw5EK0JJs8dc5yyGKR44AlIVu5qRh5Xd2EYv5myZ0Z
         CWpp4kLruU6aeRm5c3Mj3mQz5cPJ1QmfnsCjuT2C8sklsodLktir9TOdbCZ33m9WuZYq
         zi40UImx70QA1snnfL0adLXLImuKSOq4MIBdsaEKCrYKdC0iwk2to5SGLPDY/o6eXBz0
         VZEOYHmxY7A4o9Px4KqACkgLOeN8avd5rd5zaPnPQ/TnxyV0lF5pUMEvPWfasFMMAcMg
         1Aw90Kw4hn3Tzc/aOsNRFtNaB+VChMcdqsKJfn3UMixvMbWknCuJopYM1CtagkutFA2W
         c9qg==
X-Gm-Message-State: AJcUukegq4k6wB++GWMUR3zWbzILN5ClZq4m4AY6YrNKFCeuPTUtkKOs
        aIgxVGyEVjzhwC+Uk95GfzOhzAU8
X-Google-Smtp-Source: ALg8bN4t04GVa0fMQUhLGrokSOg8J4Jdz/oAQltCP50PXpmCuFSFZSsSUhVJQu+DHBe01xD0NuiPuw==
X-Received: by 2002:a63:de04:: with SMTP id f4mr325595pgg.292.1546925025124;
        Mon, 07 Jan 2019 21:23:45 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id x127sm102710626pfd.156.2019.01.07.21.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:23:44 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 3/3] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Date:   Mon,  7 Jan 2019 21:22:55 -0800
Message-Id: <20190108052255.10699-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108052255.10699-1-deepa.kernel@gmail.com>
References: <20190108052255.10699-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new socket timeout options that are y2038 safe.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: ccaulfie@redhat.com
Cc: davem@davemloft.net
Cc: deller@gmx.de
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: cluster-devel@redhat.com
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/include/uapi/asm/socket.h  | 12 +++--
 arch/mips/include/uapi/asm/socket.h   | 11 ++++-
 arch/parisc/include/uapi/asm/socket.h | 11 ++++-
 arch/sparc/include/uapi/asm/socket.h  | 11 ++++-
 include/net/sock.h                    |  4 +-
 include/uapi/asm-generic/socket.h     | 11 ++++-
 net/core/sock.c                       | 64 +++++++++++++++++++++------
 7 files changed, 98 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index ea3ba981d8a0..3d800d5d3d5d 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -118,19 +118,25 @@
 #define SO_TIMESTAMPNS_NEW       63
 #define SO_TIMESTAMPING_NEW      64
 
-#if !defined(__KERNEL__)
+#define SO_RCVTIMEO_NEW          65
+#define SO_SNDTIMEO_NEW          66
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
+#if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 4dde20d64690..5a7f9010c090 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -128,18 +128,25 @@
 #define SO_TIMESTAMPNS_NEW       63
 #define SO_TIMESTAMPING_NEW      64
 
+#define SO_RCVTIMEO_NEW          65
+#define SO_SNDTIMEO_NEW          66
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define        SO_RCVTIMEO             SO_RCVTIMEO_OLD
+#define        SO_SNDTIMEO             SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define        SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define        SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 546937fa0d8b..bd35de5b4666 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -109,18 +109,25 @@
 #define SO_TIMESTAMPNS_NEW       0x4038
 #define SO_TIMESTAMPING_NEW      0x4039
 
+#define SO_RCVTIMEO_NEW          0x4040
+#define SO_SNDTIMEO_NEW          0x4041
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define        SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define        SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index bdc396211627..5a5b073c3299 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -110,18 +110,25 @@
 #define SO_TIMESTAMPNS_NEW       0x0042
 #define SO_TIMESTAMPING_NEW      0x0043
 
+#define SO_RCVTIMEO_NEW          0x0044
+#define SO_SNDTIMEO_NEW          0x0045
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO	SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO	SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define        SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define        SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 98965a9a2bf4..6679f3c120b0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -292,8 +292,8 @@ struct sock_common {
   *	@sk_peer_pid: &struct pid for this socket's peer
   *	@sk_peer_cred: %SO_PEERCRED setting
   *	@sk_rcvlowat: %SO_RCVLOWAT setting
-  *	@sk_rcvtimeo: %SO_RCVTIMEO_OLD setting
-  *	@sk_sndtimeo: %SO_SNDTIMEO_OLD setting
+  *	@sk_rcvtimeo: %SO_RCVTIMEO setting
+  *	@sk_sndtimeo: %SO_SNDTIMEO setting
   *	@sk_txhash: computed flow hash for use on transmit
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 9e370586fb19..5b4da6eacc9f 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -112,19 +112,26 @@
 #define SO_TIMESTAMPNS_NEW       63
 #define SO_TIMESTAMPING_NEW      64
 
+#define SO_RCVTIMEO_NEW          65
+#define SO_SNDTIMEO_NEW          66
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING	SO_TIMESTAMPING_OLD
+
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define        SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define        SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/net/core/sock.c b/net/core/sock.c
index 42914ca3186c..5e1c6dafee65 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -335,18 +335,31 @@ int __sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(__sk_backlog_rcv);
 
-static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
+static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen, bool old_timeval)
 {
-	struct __kernel_old_timeval tv;
 
-	if (optlen < sizeof(tv))
-		return -EINVAL;
-	if (copy_from_user(&tv, optval, sizeof(tv)))
-		return -EFAULT;
-	if (tv.tv_usec < 0 || tv.tv_usec >= USEC_PER_SEC)
+	struct __kernel_sock_timeval stv;
+
+	if (old_timeval) {
+		struct __kernel_old_timeval tv;
+
+		if (optlen < sizeof(tv))
+			return -EINVAL;
+		if (copy_from_user(&tv, optval, sizeof(tv)))
+			return -EFAULT;
+		stv.tv_sec = tv.tv_sec;
+		stv.tv_usec = tv.tv_usec;
+	} else {
+		if (optlen < sizeof(stv))
+			return -EINVAL;
+		if (copy_from_user(&stv, optval, sizeof(stv)))
+			return -EFAULT;
+	}
+
+	if (stv.tv_usec < 0 || stv.tv_usec >= USEC_PER_SEC)
 		return -EDOM;
 
-	if (tv.tv_sec < 0) {
+	if (stv.tv_sec < 0) {
 		static int warned __read_mostly;
 
 		*timeo_p = 0;
@@ -358,10 +371,10 @@ static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 		return 0;
 	}
 	*timeo_p = MAX_SCHEDULE_TIMEOUT;
-	if (tv.tv_sec == 0 && tv.tv_usec == 0)
+	if (stv.tv_sec == 0 && stv.tv_usec == 0)
 		return 0;
-	if (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT/HZ - 1))
-		*timeo_p = tv.tv_sec * HZ + DIV_ROUND_UP(tv.tv_usec, USEC_PER_SEC / HZ);
+	if (stv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1))
+		*timeo_p = stv.tv_sec * HZ + DIV_ROUND_UP((unsigned long)stv.tv_usec, USEC_PER_SEC / HZ);
 	return 0;
 }
 
@@ -890,11 +903,13 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVTIMEO_OLD:
-		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval, optlen);
+	case SO_RCVTIMEO_NEW:
+		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval, optlen, optname == SO_RCVTIMEO_OLD);
 		break;
 
 	case SO_SNDTIMEO_OLD:
-		ret = sock_set_timeout(&sk->sk_sndtimeo, optval, optlen);
+	case SO_SNDTIMEO_NEW:
+		ret = sock_set_timeout(&sk->sk_sndtimeo, optval, optlen, optname == SO_SNDTIMEO_OLD);
 		break;
 
 	case SO_ATTACH_FILTER:
@@ -1114,6 +1129,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		u64 val64;
 		struct linger ling;
 		struct __kernel_old_timeval tm;
+		struct  __kernel_sock_timeval stm;
 		struct sock_txtime txtime;
 	} v;
 
@@ -1233,6 +1249,17 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 
+	case SO_RCVTIMEO_NEW:
+		lv = sizeof(struct __kernel_sock_timeval);
+		if (sk->sk_rcvtimeo == MAX_SCHEDULE_TIMEOUT) {
+			v.stm.tv_sec = 0;
+			v.stm.tv_usec = 0;
+		} else {
+			v.stm.tv_sec = sk->sk_rcvtimeo / HZ;
+			v.stm.tv_usec = ((sk->sk_rcvtimeo % HZ) * USEC_PER_SEC) / HZ;
+		}
+		break;
+
 	case SO_SNDTIMEO_OLD:
 		lv = sizeof(struct __kernel_old_timeval);
 		if (sk->sk_sndtimeo == MAX_SCHEDULE_TIMEOUT) {
@@ -1244,6 +1271,17 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 
+	case SO_SNDTIMEO_NEW:
+		lv = sizeof(struct __kernel_sock_timeval);
+		if (sk->sk_sndtimeo == MAX_SCHEDULE_TIMEOUT) {
+			v.stm.tv_sec = 0;
+			v.stm.tv_usec = 0;
+		} else {
+			v.stm.tv_sec = sk->sk_sndtimeo / HZ;
+			v.stm.tv_usec = ((sk->sk_sndtimeo % HZ) * USEC_PER_SEC) / HZ;
+		}
+		break;
+
 	case SO_RCVLOWAT:
 		v.val = sk->sk_rcvlowat;
 		break;
-- 
2.17.1

