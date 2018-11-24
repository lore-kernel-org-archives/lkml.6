Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111FCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAC320868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCcO91dC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAC320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbeKXNIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:08:42 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37842 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbeKXNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:08:41 -0500
Received: by mail-yb1-f196.google.com with SMTP id d18-v6so5383031yba.4;
        Fri, 23 Nov 2018 18:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hrOEtlonuB1U5QzQkcsCs/4usy8txTR7j9JJ5Nf0UmE=;
        b=lCcO91dCkmKhe1EReuCymmwvTKAaOW5syUevMezQPrKX6xo9Vlt5ajjzdcPl0EnBJ8
         RBgaOs957kHvszTtwveYDsJBmmr7Z7xrVHPUMxQ/3Dbm1b6D1P3MVIWGXiOyuYzJFgOl
         YUlnnqn/uf9bWgJmXT19mSuWlHe+1qYy1jC314WaGVKvXccE5FImUGjkSkVRTa3AgrvG
         AlkiNkTmO5bXrZ7fiks84gzI3Dt1rXPA9+i9QRVGe9qhLPbbi7s7cKR3ggKtxfAezSFO
         EKTdzoCRP45zZ6ePg+UoUkxBD3UwSuE4N54pzQQq1OmEHdortmMiUjxtKF/AqIsIuzOA
         Y7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hrOEtlonuB1U5QzQkcsCs/4usy8txTR7j9JJ5Nf0UmE=;
        b=CO7BQXysQbD68LWNaNkTAlRy/WoembjJqFsDyO73HWOL7Al653KId/rrX1CqQrIbpM
         t3n6QnE/WnrrN97LUGL8Mcwj9Q+V2LdYS7CSwwEw6PHI9ELjkMN6hblqS+2LK6fV56xO
         IJA3lTz2mn5W+L1NGgKmA+SBs9L73d8USQrJyunwcJBUQE6rOSj7bbN0FEl12nhuyUDj
         tveLGRVzPxLsKERRDbOprcCCxDLveGpfZy4FI5X5E+nPFXqoNjah11O+bYUL7LnhICJn
         Aadj4Ur48/V4bLdIeCKKcFz4qi2G5zGOJjjdYTW2lFMfmtMMOgCwisWMqLrsc8tb4OWk
         sAew==
X-Gm-Message-State: AA+aEWboZt9EpLK6rV/W8RC6XE1oSUiGVwTZim6lbMZBHW6vkjxyTK3x
        6BJGq1n6wiY2pcdMPHzeF4w=
X-Google-Smtp-Source: AFSGD/Ubc2l39DjxBw6awuaDxZo6DxGIzs/PA8LBj2f9nJwJxotOlRvCCqDOMR8gkSu7eQVcF62ofg==
X-Received: by 2002:a25:bc82:: with SMTP id e2-v6mr18312864ybk.456.1543026122502;
        Fri, 23 Nov 2018 18:22:02 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-213.hsd1.ca.comcast.net. [98.234.52.213])
        by smtp.gmail.com with ESMTPSA id w1sm6947292ywd.49.2018.11.23.18.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:22:01 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org, deller@gmx.de, dhowells@redhat.com,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 2/8] sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
Date:   Fri, 23 Nov 2018 18:20:29 -0800
Message-Id: <20181124022035.17519-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181124022035.17519-1-deepa.kernel@gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING options, the
way they are currently defined, are not y2038 safe.
Subsequent patches in the series add new y2038 safe versions
of these options which provide 64 bit timestamps on all
architectures uniformly.
Hence, rename existing options with OLD tag suffixes.

Also note that kernel will not use the untagged SO_TIMESTAMP*
and SCM_TIMESTAMP* options internally anymore.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: deller@gmx.de
Cc: dhowells@redhat.com
Cc: jejb@parisc-linux.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: linux-afs@lists.infradead.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/include/uapi/asm/socket.h  | 23 ++++++++++++++++-------
 arch/mips/include/uapi/asm/socket.h   | 23 ++++++++++++++++-------
 arch/parisc/include/uapi/asm/socket.h | 23 ++++++++++++++++-------
 arch/sparc/include/uapi/asm/socket.h  | 24 ++++++++++++++++--------
 include/uapi/asm-generic/socket.h     | 23 ++++++++++++++++-------
 net/compat.c                          |  6 +++---
 net/core/sock.c                       | 16 ++++++++--------
 net/ipv4/tcp.c                        |  6 +++---
 net/rds/af_rds.c                      |  2 +-
 net/rds/recv.c                        |  2 +-
 net/rxrpc/local_object.c              |  2 +-
 net/socket.c                          |  8 ++++----
 12 files changed, 101 insertions(+), 57 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 065fb372e355..00e45c80e574 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -51,13 +51,9 @@
 #define SO_GET_FILTER		SO_ATTACH_FILTER
 
 #define SO_PEERNAME		28
-#define SO_TIMESTAMP		29
-#define SCM_TIMESTAMP		SO_TIMESTAMP
 
 #define SO_PEERSEC		30
 #define SO_PASSSEC		34
-#define SO_TIMESTAMPNS		35
-#define SCM_TIMESTAMPNS		SO_TIMESTAMPNS
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		19
@@ -66,9 +62,6 @@
 
 #define SO_MARK			36
 
-#define SO_TIMESTAMPING		37
-#define SCM_TIMESTAMPING	SO_TIMESTAMPING
-
 #define SO_RXQ_OVFL             40
 
 #define SO_WIFI_STATUS		41
@@ -115,4 +108,20 @@
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
 
+#define SO_TIMESTAMP_OLD         29
+#define SO_TIMESTAMPNS_OLD       35
+#define SO_TIMESTAMPING_OLD      37
+
+#if !defined(__KERNEL__)
+
+#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
+
+#define SCM_TIMESTAMP          SO_TIMESTAMP
+#define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
+#define SCM_TIMESTAMPING       SO_TIMESTAMPING
+
+#endif
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 71370fb3ceef..b9553f770346 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -65,21 +65,14 @@
 #define SO_GET_FILTER		SO_ATTACH_FILTER
 
 #define SO_PEERNAME		28
-#define SO_TIMESTAMP		29
-#define SCM_TIMESTAMP		SO_TIMESTAMP
 
 #define SO_PEERSEC		30
 #define SO_SNDBUFFORCE		31
 #define SO_RCVBUFFORCE		33
 #define SO_PASSSEC		34
-#define SO_TIMESTAMPNS		35
-#define SCM_TIMESTAMPNS		SO_TIMESTAMPNS
 
 #define SO_MARK			36
 
-#define SO_TIMESTAMPING		37
-#define SCM_TIMESTAMPING	SO_TIMESTAMPING
-
 #define SO_RXQ_OVFL		40
 
 #define SO_WIFI_STATUS		41
@@ -126,4 +119,20 @@
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
 
+#define SO_TIMESTAMP_OLD         29
+#define SO_TIMESTAMPNS_OLD       35
+#define SO_TIMESTAMPING_OLD      37
+
+#if !defined(__KERNEL__)
+
+#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
+
+#define SCM_TIMESTAMP          SO_TIMESTAMP
+#define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
+#define SCM_TIMESTAMPING       SO_TIMESTAMPING
+
+#endif
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 061b9cf2a779..37cdfe64bb27 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -34,10 +34,6 @@
 #define SO_BSDCOMPAT	0x400e
 #define SO_PASSCRED	0x4010
 #define SO_PEERCRED	0x4011
-#define SO_TIMESTAMP	0x4012
-#define SCM_TIMESTAMP	SO_TIMESTAMP
-#define SO_TIMESTAMPNS	0x4013
-#define SCM_TIMESTAMPNS	SO_TIMESTAMPNS
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		0x4016
@@ -58,9 +54,6 @@
 
 #define SO_MARK			0x401f
 
-#define SO_TIMESTAMPING		0x4020
-#define SCM_TIMESTAMPING	SO_TIMESTAMPING
-
 #define SO_RXQ_OVFL             0x4021
 
 #define SO_WIFI_STATUS		0x4022
@@ -107,4 +100,20 @@
 #define SO_TXTIME		0x4036
 #define SCM_TXTIME		SO_TXTIME
 
+#define SO_TIMESTAMP_OLD         0x4012
+#define SO_TIMESTAMPNS_OLD       0x4013
+#define SO_TIMESTAMPING_OLD      0x4020
+
+#if !defined(__KERNEL__)
+
+#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
+
+#define SCM_TIMESTAMP          SO_TIMESTAMP
+#define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
+#define SCM_TIMESTAMPING       SO_TIMESTAMPING
+
+#endif
+
 #endif /* _UAPI_ASM_SOCKET_H */
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 7ea35e5601b6..ca573641fc6c 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -33,7 +33,6 @@
 #define SO_PROTOCOL	0x1028
 #define SO_DOMAIN	0x1029
 
-
 /* Linux specific, keep the same. */
 #define SO_NO_CHECK	0x000b
 #define SO_PRIORITY	0x000c
@@ -45,19 +44,12 @@
 #define SO_GET_FILTER		SO_ATTACH_FILTER
 
 #define SO_PEERNAME		0x001c
-#define SO_TIMESTAMP		0x001d
-#define SCM_TIMESTAMP		SO_TIMESTAMP
 
 #define SO_PEERSEC		0x001e
 #define SO_PASSSEC		0x001f
-#define SO_TIMESTAMPNS		0x0021
-#define SCM_TIMESTAMPNS		SO_TIMESTAMPNS
 
 #define SO_MARK			0x0022
 
-#define SO_TIMESTAMPING		0x0023
-#define SCM_TIMESTAMPING	SO_TIMESTAMPING
-
 #define SO_RXQ_OVFL             0x0024
 
 #define SO_WIFI_STATUS		0x0025
@@ -109,4 +101,20 @@
 #define SO_SECURITY_ENCRYPTION_TRANSPORT	0x5002
 #define SO_SECURITY_ENCRYPTION_NETWORK		0x5004
 
+#define SO_TIMESTAMP_OLD         0x001d
+#define SO_TIMESTAMPNS_OLD       0x0021
+#define SO_TIMESTAMPING_OLD      0x0023
+
+#if !defined(__KERNEL__)
+
+#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
+
+#define SCM_TIMESTAMP          SO_TIMESTAMP
+#define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
+#define SCM_TIMESTAMPING       SO_TIMESTAMPING
+
+#endif
+
 #endif /* _ASM_SOCKET_H */
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index a12692e5f7a8..dc704e41203d 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -46,21 +46,14 @@
 #define SO_GET_FILTER		SO_ATTACH_FILTER
 
 #define SO_PEERNAME		28
-#define SO_TIMESTAMP		29
-#define SCM_TIMESTAMP		SO_TIMESTAMP
 
 #define SO_ACCEPTCONN		30
 
 #define SO_PEERSEC		31
 #define SO_PASSSEC		34
-#define SO_TIMESTAMPNS		35
-#define SCM_TIMESTAMPNS		SO_TIMESTAMPNS
 
 #define SO_MARK			36
 
-#define SO_TIMESTAMPING		37
-#define SCM_TIMESTAMPING	SO_TIMESTAMPING
-
 #define SO_PROTOCOL		38
 #define SO_DOMAIN		39
 
@@ -110,4 +103,20 @@
 #define SO_TXTIME		61
 #define SCM_TXTIME		SO_TXTIME
 
+#define SO_TIMESTAMP_OLD         29
+#define SO_TIMESTAMPNS_OLD       35
+#define SO_TIMESTAMPING_OLD      37
+
+#if !defined(__KERNEL__)
+
+#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
+
+#define SCM_TIMESTAMP          SO_TIMESTAMP
+#define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
+#define SCM_TIMESTAMPING       SO_TIMESTAMPING
+
+#endif
+
 #endif /* __ASM_GENERIC_SOCKET_H */
diff --git a/net/compat.c b/net/compat.c
index 47a614b370cd..720ab07276b0 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -219,7 +219,7 @@ int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *dat
 	}
 
 	if (!COMPAT_USE_64BIT_TIME) {
-		if (level == SOL_SOCKET && type == SCM_TIMESTAMP) {
+		if (level == SOL_SOCKET && type == SO_TIMESTAMP_OLD) {
 			struct timeval *tv = (struct timeval *)data;
 			ctv.tv_sec = tv->tv_sec;
 			ctv.tv_usec = tv->tv_usec;
@@ -227,8 +227,8 @@ int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *dat
 			len = sizeof(ctv);
 		}
 		if (level == SOL_SOCKET &&
-		    (type == SCM_TIMESTAMPNS || type == SCM_TIMESTAMPING)) {
-			int count = type == SCM_TIMESTAMPNS ? 1 : 3;
+		    (type == SO_TIMESTAMPNS_OLD || type == SO_TIMESTAMPING_OLD)) {
+			int count = type == SO_TIMESTAMPNS_OLD ? 1 : 3;
 			int i;
 			struct timespec *ts = (struct timespec *)data;
 			for (i = 0; i < count; i++) {
diff --git a/net/core/sock.c b/net/core/sock.c
index 6d7e189e3cd9..cf990db9b2a0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -814,10 +814,10 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 			clear_bit(SOCK_PASSCRED, &sock->flags);
 		break;
 
-	case SO_TIMESTAMP:
-	case SO_TIMESTAMPNS:
+	case SO_TIMESTAMP_OLD:
+	case SO_TIMESTAMPNS_OLD:
 		if (valbool)  {
-			if (optname == SO_TIMESTAMP)
+			if (optname == SO_TIMESTAMP_OLD)
 				sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
 			else
 				sock_set_flag(sk, SOCK_RCVTSTAMPNS);
@@ -829,7 +829,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 
-	case SO_TIMESTAMPING:
+	case SO_TIMESTAMPING_OLD:
 		if (val & ~SOF_TIMESTAMPING_MASK) {
 			ret = -EINVAL;
 			break;
@@ -1182,16 +1182,16 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		sock_warn_obsolete_bsdism("getsockopt");
 		break;
 
-	case SO_TIMESTAMP:
+	case SO_TIMESTAMP_OLD:
 		v.val = sock_flag(sk, SOCK_RCVTSTAMP) &&
 				!sock_flag(sk, SOCK_RCVTSTAMPNS);
 		break;
 
-	case SO_TIMESTAMPNS:
+	case SO_TIMESTAMPNS_OLD:
 		v.val = sock_flag(sk, SOCK_RCVTSTAMPNS);
 		break;
 
-	case SO_TIMESTAMPING:
+	case SO_TIMESTAMPING_OLD:
 		v.val = sk->sk_tsflags;
 		break;
 
@@ -2118,7 +2118,7 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 			return -EINVAL;
 		sockc->mark = *(u32 *)CMSG_DATA(cmsg);
 		break;
-	case SO_TIMESTAMPING:
+	case SO_TIMESTAMPING_OLD:
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
 			return -EINVAL;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 252048776dbb..496848ab0269 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1870,13 +1870,13 @@ static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
 		if (sock_flag(sk, SOCK_RCVTSTAMP)) {
 			if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-				put_cmsg(msg, SOL_SOCKET, SCM_TIMESTAMPNS,
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
 					 sizeof(tss->ts[0]), &tss->ts[0]);
 			} else {
 				tv.tv_sec = tss->ts[0].tv_sec;
 				tv.tv_usec = tss->ts[0].tv_nsec / 1000;
 
-				put_cmsg(msg, SOL_SOCKET, SCM_TIMESTAMP,
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
 					 sizeof(tv), &tv);
 			}
 		}
@@ -1896,7 +1896,7 @@ static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 
 	if (has_timestamping) {
 		tss->ts[1] = (struct timespec) {0};
-		put_cmsg(msg, SOL_SOCKET, SCM_TIMESTAMPING,
+		put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_OLD,
 			 sizeof(*tss), tss);
 	}
 }
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 65387e1e6964..eeb4639adbe5 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -430,7 +430,7 @@ static int rds_setsockopt(struct socket *sock, int level, int optname,
 		ret = rds_set_transport(rs, optval, optlen);
 		release_sock(sock->sk);
 		break;
-	case SO_TIMESTAMP:
+	case SO_TIMESTAMP_OLD:
 		lock_sock(sock->sk);
 		ret = rds_enable_recvtstamp(sock->sk, optval, optlen);
 		release_sock(sock->sk);
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 727639dac8a7..04e30d63a159 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -550,7 +550,7 @@ static int rds_cmsg_recv(struct rds_incoming *inc, struct msghdr *msg,
 	if ((inc->i_rx_tstamp != 0) &&
 	    sock_flag(rds_rs_to_sk(rs), SOCK_RCVTSTAMP)) {
 		struct timeval tv = ktime_to_timeval(inc->i_rx_tstamp);
-		ret = put_cmsg(msg, SOL_SOCKET, SCM_TIMESTAMP,
+		ret = put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
 			       sizeof(tv), &tv);
 		if (ret)
 			goto out;
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 0906e51d3cfb..15cf42d5b53a 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -202,7 +202,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 
 		/* We want receive timestamps. */
 		opt = 1;
-		ret = kernel_setsockopt(local->socket, SOL_SOCKET, SO_TIMESTAMPNS,
+		ret = kernel_setsockopt(local->socket, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
 					(char *)&opt, sizeof(opt));
 		if (ret < 0) {
 			_debug("setsockopt failed");
diff --git a/net/socket.c b/net/socket.c
index f1ede2a64985..dfc5742ccfbb 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -670,7 +670,7 @@ static bool skb_is_err_queue(const struct sk_buff *skb)
  * before the software timestamp is received, a hardware TX timestamp may be
  * returned only if there is no software TX timestamp. Ignore false software
  * timestamps, which may be made in the __sock_recv_timestamp() call when the
- * option SO_TIMESTAMP(NS) is enabled on the socket, even when the skb has a
+ * option SO_TIMESTAMP_OLD(NS) is enabled on the socket, even when the skb has a
  * hardware timestamp.
  */
 static bool skb_is_swtx_tstamp(const struct sk_buff *skb, int false_tstamp)
@@ -722,12 +722,12 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 		if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
 			struct timeval tv;
 			skb_get_timestamp(skb, &tv);
-			put_cmsg(msg, SOL_SOCKET, SCM_TIMESTAMP,
+			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
 				 sizeof(tv), &tv);
 		} else {
 			struct timespec ts;
 			skb_get_timestampns(skb, &ts);
-			put_cmsg(msg, SOL_SOCKET, SCM_TIMESTAMPNS,
+			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
 				 sizeof(ts), &ts);
 		}
 	}
@@ -747,7 +747,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	}
 	if (!empty) {
 		put_cmsg(msg, SOL_SOCKET,
-			 SCM_TIMESTAMPING, sizeof(tss), &tss);
+			 SO_TIMESTAMPING_OLD, sizeof(tss), &tss);
 
 		if (skb_is_err_queue(skb) && skb->len &&
 		    SKB_EXT_ERR(skb)->opt_stats)
-- 
2.17.1

