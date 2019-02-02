Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFC8C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C442086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRIcVOKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfBBPfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:35:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42716 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfBBPfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:35:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so4367701pga.9;
        Sat, 02 Feb 2019 07:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tYfzt6UX0nBbyILWqID9XJpzA3FkYbJ0asJ/Knlt4Mw=;
        b=rRIcVOKdDoe76vZHbJNaJ4B1lJTWuBnaEBzd25W3Nz72sNGv+R9lmaWyT7omapFQay
         ZqWbSCm6/KwBtjyA086Uo3DUeqXus2trI+MKgSuzqfDElLYbB7A8J+0mD3xhu5N7zJXI
         IJWIdPlv41LxLOjOSPTsmA7bW8ALoxzq4+zHs1J5/mRs9vYy9Gb0lK7uhLKhLasDLzz1
         N2bVi7FS/sK8BuRDMn87nqGV5of8ZXtQ7a001SjK/O4709spS5Cw7N8lDI4Fs9FF9+qx
         v6ybJ2+f50uSGQSkpDhMsThSPT4ilXWKwEWeqY3rCxQhwr/Xexhv//IZXJfLBuRMWd2A
         hOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tYfzt6UX0nBbyILWqID9XJpzA3FkYbJ0asJ/Knlt4Mw=;
        b=JRv3FIYnNxJpL1HPPgU3L1DoknaWXRrtTvdefMo9G/3coaHSzQqnBRLAC4IgDSAn1x
         TQn7KuA+yZfDovb/M1QR20payL7v74r7ME7y5n4qY0ahnZyh/dk53X59QSUM4HbJCTBH
         4rPgsPSlgvLq/eHlsBBp3bps+t4j+ddwOAUa2GnjOFCMFU+VEIk1On2OC8MbeX0d7X8F
         U8LyU3yvwvmPheIdigrapb1f6Jx71if7sDsTeuyLKjtCpmehn9qBYnA/ikgp/yuSKAD+
         IRWN74Ukc77AsRYRSMF4MbQRq4Q6ZIW0DXSREgz7Z3B44/5o/vk/4PgrhYubESTktaNx
         vubQ==
X-Gm-Message-State: AHQUAuYGeCf/NPB5WBsTwZC/xwWuLlPI5dpHyyExw43/ULiy+73ntcVK
        JzsBWTvSVUqXlqDNrNKU6VY=
X-Google-Smtp-Source: AHgI3IZ76tgUuQy/rxpzhVp+sDotTt59GXL8PedhPjG6hKeys4S1anOEPDy6Z7jUyoPDM4+gPC2oYg==
X-Received: by 2002:a63:dc0c:: with SMTP id s12mr6577905pgg.398.1549121749641;
        Sat, 02 Feb 2019 07:35:49 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id m20sm16221611pgb.56.2019.02.02.07.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:35:49 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH net-next v5 08/12] socket: Add SO_TIMESTAMP[NS]_NEW
Date:   Sat,  2 Feb 2019 07:34:50 -0800
Message-Id: <20190202153454.7121-9-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202153454.7121-1-deepa.kernel@gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SO_TIMESTAMP_NEW and SO_TIMESTAMPNS_NEW variants of
socket timestamp options.
These are the y2038 safe versions of the SO_TIMESTAMP_OLD
and SO_TIMESTAMPNS_OLD for all architectures.

Note that the format of scm_timestamping.ts[0] is not changed
in this patch.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Cc: jejb@parisc-linux.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/include/uapi/asm/socket.h  | 14 +++++++++--
 arch/mips/include/uapi/asm/socket.h   | 14 +++++++++--
 arch/parisc/include/uapi/asm/socket.h | 14 +++++++++--
 arch/sparc/include/uapi/asm/socket.h  | 14 +++++++++--
 include/linux/skbuff.h                | 18 ++++++++++++++
 include/net/sock.h                    |  1 +
 include/uapi/asm-generic/socket.h     | 15 ++++++++++--
 net/core/sock.c                       | 21 ++++++++++++++--
 net/ipv4/tcp.c                        | 33 +++++++++++++++++++------
 net/rds/af_rds.c                      |  8 ++++--
 net/rds/recv.c                        | 16 ++++++++++--
 net/socket.c                          | 35 +++++++++++++++++++++------
 12 files changed, 171 insertions(+), 32 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 992a0a6dcea1..aab11eec7c22 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -3,6 +3,7 @@
 #define _UAPI_ASM_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 /*
@@ -114,10 +115,19 @@
 #define SO_TIMESTAMPNS_OLD      35
 #define SO_TIMESTAMPING_OLD     37
 
+#define SO_TIMESTAMP_NEW        63
+#define SO_TIMESTAMPNS_NEW      64
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP            SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS          SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 0f4516c34df2..11014f684d9f 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -11,6 +11,7 @@
 #define _UAPI_ASM_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /*
  * For setsockopt(2)
@@ -125,10 +126,19 @@
 #define SO_TIMESTAMPNS_OLD      35
 #define SO_TIMESTAMPING_OLD     37
 
+#define SO_TIMESTAMP_NEW        63
+#define SO_TIMESTAMPNS_NEW      64
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP            SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS          SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 7c180321ebd6..cbc4b89c2fe4 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -3,6 +3,7 @@
 #define _UAPI_ASM_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	0xffff
@@ -106,10 +107,19 @@
 #define SO_TIMESTAMPNS_OLD      0x4013
 #define SO_TIMESTAMPING_OLD     0x4020
 
+#define SO_TIMESTAMP_NEW        0x4038
+#define SO_TIMESTAMPNS_NEW      0x4039
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP            SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS          SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index d8a1bbc3e6c4..85127425b294 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -3,6 +3,7 @@
 #define _ASM_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	0xffff
@@ -107,10 +108,19 @@
 #define SO_TIMESTAMPNS_OLD       0x0021
 #define SO_TIMESTAMPING_OLD      0x0023
 
+#define SO_TIMESTAMP_NEW         0x0041
+#define SO_TIMESTAMPNS_NEW       0x0042
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4001611a4c9f..831846617d07 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3498,12 +3498,30 @@ static inline void skb_get_timestamp(const struct sk_buff *skb,
 	*stamp = ns_to_kernel_old_timeval(skb->tstamp);
 }
 
+static inline void skb_get_new_timestamp(const struct sk_buff *skb,
+					 struct __kernel_sock_timeval *stamp)
+{
+	struct timespec64 ts = ktime_to_timespec64(skb->tstamp);
+
+	stamp->tv_sec = ts.tv_sec;
+	stamp->tv_usec = ts.tv_nsec / 1000;
+}
+
 static inline void skb_get_timestampns(const struct sk_buff *skb,
 				       struct timespec *stamp)
 {
 	*stamp = ktime_to_timespec(skb->tstamp);
 }
 
+static inline void skb_get_new_timestampns(const struct sk_buff *skb,
+					   struct __kernel_timespec *stamp)
+{
+	struct timespec64 ts = ktime_to_timespec64(skb->tstamp);
+
+	stamp->tv_sec = ts.tv_sec;
+	stamp->tv_nsec = ts.tv_nsec;
+}
+
 static inline void __net_timestamp(struct sk_buff *skb)
 {
 	skb->tstamp = ktime_get_real();
diff --git a/include/net/sock.h b/include/net/sock.h
index 2b229f7be8eb..6679f3c120b0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -805,6 +805,7 @@ enum sock_flags {
 	SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
 	SOCK_TXTIME,
 	SOCK_XDP, /* XDP is attached */
+	SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 4ef3aed31fb7..f22d3f7162f8 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	1
@@ -109,10 +110,20 @@
 #define SO_TIMESTAMPNS_OLD      35
 #define SO_TIMESTAMPING_OLD     37
 
+#define SO_TIMESTAMP_NEW        63
+#define SO_TIMESTAMPNS_NEW      64
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP            SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS          SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
+/* on 64-bit and x32, avoid the ?: operator */
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/net/core/sock.c b/net/core/sock.c
index d5ca8641968f..14b987eab10c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -868,9 +868,16 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_TIMESTAMP_OLD:
+	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
+	case SO_TIMESTAMPNS_NEW:
 		if (valbool)  {
-			if (optname == SO_TIMESTAMP_OLD)
+			if (optname == SO_TIMESTAMP_NEW || optname == SO_TIMESTAMPNS_NEW)
+				sock_set_flag(sk, SOCK_TSTAMP_NEW);
+			else
+				sock_reset_flag(sk, SOCK_TSTAMP_NEW);
+
+			if (optname == SO_TIMESTAMP_OLD || optname == SO_TIMESTAMP_NEW)
 				sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
 			else
 				sock_set_flag(sk, SOCK_RCVTSTAMPNS);
@@ -879,6 +886,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		} else {
 			sock_reset_flag(sk, SOCK_RCVTSTAMP);
 			sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
+			sock_reset_flag(sk, SOCK_TSTAMP_NEW);
 		}
 		break;
 
@@ -1245,11 +1253,20 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 
 	case SO_TIMESTAMP_OLD:
 		v.val = sock_flag(sk, SOCK_RCVTSTAMP) &&
+				!sock_flag(sk, SOCK_TSTAMP_NEW) &&
 				!sock_flag(sk, SOCK_RCVTSTAMPNS);
 		break;
 
 	case SO_TIMESTAMPNS_OLD:
-		v.val = sock_flag(sk, SOCK_RCVTSTAMPNS);
+		v.val = sock_flag(sk, SOCK_RCVTSTAMPNS) && !sock_flag(sk, SOCK_TSTAMP_NEW);
+		break;
+
+	case SO_TIMESTAMP_NEW:
+		v.val = sock_flag(sk, SOCK_RCVTSTAMP) && sock_flag(sk, SOCK_TSTAMP_NEW);
+		break;
+
+	case SO_TIMESTAMPNS_NEW:
+		v.val = sock_flag(sk, SOCK_RCVTSTAMPNS) && sock_flag(sk, SOCK_TSTAMP_NEW);
 		break;
 
 	case SO_TIMESTAMPING_OLD:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3ce41b04c0f0..4e9388bf104a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1861,20 +1861,37 @@ static void tcp_update_recv_tstamps(struct sk_buff *skb,
 static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			       struct scm_timestamping *tss)
 {
-	struct __kernel_old_timeval tv;
+	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
 		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
 			if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
-					 sizeof(tss->ts[0]), &tss->ts[0]);
+				if (new_tstamp) {
+					struct __kernel_timespec kts = {tss->ts[0].tv_sec, tss->ts[0].tv_nsec};
+
+					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+						 sizeof(kts), &kts);
+				} else {
+					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
+						 sizeof(tss->ts[0]), &tss->ts[0]);
+				}
 			} else {
-				tv.tv_sec = tss->ts[0].tv_sec;
-				tv.tv_usec = tss->ts[0].tv_nsec / 1000;
-
-				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
-					 sizeof(tv), &tv);
+				if (new_tstamp) {
+					struct __kernel_sock_timeval stv;
+
+					stv.tv_sec = tss->ts[0].tv_sec;
+					stv.tv_usec = tss->ts[0].tv_nsec / 1000;
+					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
+						 sizeof(stv), &stv);
+				} else {
+					struct __kernel_old_timeval tv;
+
+					tv.tv_sec = tss->ts[0].tv_sec;
+					tv.tv_usec = tss->ts[0].tv_nsec / 1000;
+					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
+						 sizeof(tv), &tv);
+				}
 			}
 		}
 
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index eeb4639adbe5..65571a6273c3 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -348,7 +348,7 @@ static int rds_set_transport(struct rds_sock *rs, char __user *optval,
 }
 
 static int rds_enable_recvtstamp(struct sock *sk, char __user *optval,
-				 int optlen)
+				 int optlen, int optname)
 {
 	int val, valbool;
 
@@ -360,6 +360,9 @@ static int rds_enable_recvtstamp(struct sock *sk, char __user *optval,
 
 	valbool = val ? 1 : 0;
 
+	if (optname == SO_TIMESTAMP_NEW)
+		sock_set_flag(sk, SOCK_TSTAMP_NEW);
+
 	if (valbool)
 		sock_set_flag(sk, SOCK_RCVTSTAMP);
 	else
@@ -431,8 +434,9 @@ static int rds_setsockopt(struct socket *sock, int level, int optname,
 		release_sock(sock->sk);
 		break;
 	case SO_TIMESTAMP_OLD:
+	case SO_TIMESTAMP_NEW:
 		lock_sock(sock->sk);
-		ret = rds_enable_recvtstamp(sock->sk, optval, optlen);
+		ret = rds_enable_recvtstamp(sock->sk, optval, optlen, optname);
 		release_sock(sock->sk);
 		break;
 	case SO_RDS_MSG_RXPATH_LATENCY:
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 435bf2320cd3..6bb6b16ca270 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -550,8 +550,20 @@ static int rds_cmsg_recv(struct rds_incoming *inc, struct msghdr *msg,
 	if ((inc->i_rx_tstamp != 0) &&
 	    sock_flag(rds_rs_to_sk(rs), SOCK_RCVTSTAMP)) {
 		struct __kernel_old_timeval tv = ns_to_kernel_old_timeval(inc->i_rx_tstamp);
-		ret = put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
-			       sizeof(tv), &tv);
+
+		if (!sock_flag(rds_rs_to_sk(rs), SOCK_TSTAMP_NEW)) {
+			ret = put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
+				       sizeof(tv), &tv);
+		} else {
+			struct __kernel_sock_timeval sk_tv;
+
+			sk_tv.tv_sec = tv.tv_sec;
+			sk_tv.tv_usec = tv.tv_usec;
+
+			ret = put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
+				       sizeof(sk_tv), &sk_tv);
+		}
+
 		if (ret)
 			goto out;
 	}
diff --git a/net/socket.c b/net/socket.c
index 9cc281cdb9d9..1de96abd78d3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -705,6 +705,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	struct sk_buff *skb)
 {
 	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
+	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	struct scm_timestamping tss;
 	int empty = 1, false_tstamp = 0;
 	struct skb_shared_hwtstamps *shhwtstamps =
@@ -719,15 +720,33 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	if (need_software_tstamp) {
 		if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-			struct __kernel_old_timeval tv;
-			skb_get_timestamp(skb, &tv);
-			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
-				 sizeof(tv), &tv);
+			if (new_tstamp) {
+				struct __kernel_sock_timeval tv;
+
+				skb_get_new_timestamp(skb, &tv);
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
+					 sizeof(tv), &tv);
+			} else {
+				struct __kernel_old_timeval tv;
+
+				skb_get_timestamp(skb, &tv);
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
+					 sizeof(tv), &tv);
+			}
 		} else {
-			struct timespec ts;
-			skb_get_timestampns(skb, &ts);
-			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
-				 sizeof(ts), &ts);
+			if (new_tstamp) {
+				struct __kernel_timespec ts;
+
+				skb_get_new_timestampns(skb, &ts);
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+					 sizeof(ts), &ts);
+			} else {
+				struct timespec ts;
+
+				skb_get_timestampns(skb, &ts);
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
+					 sizeof(ts), &ts);
+			}
 		}
 	}
 
-- 
2.17.1

