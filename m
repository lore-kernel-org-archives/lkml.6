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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9018C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F48120868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYFIAalX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F48120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeKXNIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:08:54 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42888 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbeKXNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:08:53 -0500
Received: by mail-yw1-f66.google.com with SMTP id x2so5424955ywc.9;
        Fri, 23 Nov 2018 18:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sA0U0EGO08RBOdJby196R6M50QZ1o8XHMGUZGptANcw=;
        b=IYFIAalXpKOWamWN2oMQ3Om263fzUBWuK5OLrdZQQoOmjrxvRXxCdzRB9640PwNyFQ
         Stbyujxn/8NGYoUFoQ795s5Nzw5r1fSOCSOwpuUTHng6f80j53qY3tX+o0XIWEA0NBeL
         XVYgyQoIxco3JU30HR4Qjcqoz2l8Hp8+VD4wgWihQ3e/JGy0Moc2BQqZ0iRdS9atkreS
         ce3jrqg2uD8IzeUTMR62Zd7NSm5PX9Q6qSN5F9R/OZlG/hIb/+DV87W0624qjhhFSaLY
         Rgjsgw+pCJzOp9QFhKPYdm+j4sgNO1cLmPumBdWzBTr81xK64YDY7BmNZ07xVPguVWXT
         rlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sA0U0EGO08RBOdJby196R6M50QZ1o8XHMGUZGptANcw=;
        b=pi04W4mQfXvm3Ap/1P9or9TJjS9nRrsoyzX8A+AuIy7tJXcj8fPbq6Wvg+y0H7pqL2
         X4mUExULjbSPv/Yfr0QH/BTkkCS2b6r0+klcO6vw/HaKd7bXJkG4T/vfkfS+c5Jgbqmp
         rJdhOVoCMekrP4imeO/ZIBkulN7AGmyx00olA64QrFWUMy4OI+3VZcUYgd+3caX2sRac
         yzoSJrL5fGMiFcnimrhxUEm67ll1p0pR5kMjGDRxwY/EyBCFEGx6TuPDTarYkbc3ug9f
         VhU0CYrBUYaU6EfWbVlQsZob1wuO2TGM/pXcLoc5yGnSx2NDDRLPHVGu74Rm8+62VaGG
         gkQQ==
X-Gm-Message-State: AGRZ1gLsOYuOgkP57aO4cUSqyJYuLcoXyv9XJsJwEBFEpNGIGwRS1/Mt
        gNI4aHLdwNMW8/6Xi6mKMk4=
X-Google-Smtp-Source: AJdET5fhVbMC2MvhCTbQoWCMv81zxE2wuBxaR0P2SAI0Wr+b9thnedl3JaHAciGbB97sgfaqOjW1xQ==
X-Received: by 2002:a81:1b09:: with SMTP id b9-v6mr19142633ywb.248.1543026134535;
        Fri, 23 Nov 2018 18:22:14 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-213.hsd1.ca.comcast.net. [98.234.52.213])
        by smtp.gmail.com with ESMTPSA id w1sm6947292ywd.49.2018.11.23.18.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:22:13 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org, chris@zankel.net, fenghua.yu@intel.com,
        rth@twiddle.net, tglx@linutronix.de, ubraun@linux.ibm.com,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 8/8] socket: Add SO_TIMESTAMPING_NEW
Date:   Fri, 23 Nov 2018 18:20:35 -0800
Message-Id: <20181124022035.17519-9-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181124022035.17519-1-deepa.kernel@gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
This is the y2038 safe versions of the SO_TIMESTAMPING_OLD
for all architectures.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: chris@zankel.net
Cc: fenghua.yu@intel.com
Cc: rth@twiddle.net
Cc: tglx@linutronix.de
Cc: ubraun@linux.ibm.com
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-s390@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/include/uapi/asm/socket.h  |  5 +-
 arch/mips/include/uapi/asm/socket.h   |  5 +-
 arch/parisc/include/uapi/asm/socket.h |  5 +-
 arch/sparc/include/uapi/asm/socket.h  |  8 +--
 include/linux/socket.h                |  7 +++
 include/uapi/asm-generic/socket.h     |  5 +-
 include/uapi/linux/errqueue.h         |  4 ++
 net/core/scm.c                        | 27 ++++++++++
 net/core/sock.c                       | 73 +++++++++++++++------------
 net/ipv4/tcp.c                        | 29 ++++++-----
 net/smc/af_smc.c                      |  3 +-
 net/socket.c                          | 16 +++---
 12 files changed, 122 insertions(+), 65 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 352e3dc0b3d9..8b9f6f7f8087 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -116,19 +116,20 @@
 
 #define SO_TIMESTAMP_NEW         62
 #define SO_TIMESTAMPNS_NEW       63
+#define SO_TIMESTAMPING_NEW      64
 
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
 #endif
 
-#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
-
 #define SCM_TIMESTAMP          SO_TIMESTAMP
 #define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING       SO_TIMESTAMPING
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index d1752e3f1248..9fc80c5d54e4 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -126,19 +126,20 @@
 
 #define SO_TIMESTAMP_NEW         62
 #define SO_TIMESTAMPNS_NEW       63
+#define SO_TIMESTAMPING_NEW      64
 
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
 #endif
 
-#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
-
 #define SCM_TIMESTAMP          SO_TIMESTAMP
 #define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING       SO_TIMESTAMPING
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 0a45b668abd1..82f1c9447d6b 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -107,19 +107,20 @@
 
 #define SO_TIMESTAMP_NEW         0x4037
 #define SO_TIMESTAMPNS_NEW       0x4038
+#define SO_TIMESTAMPING_NEW      0x4039
 
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
 #endif
 
-#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
-
 #define SCM_TIMESTAMP          SO_TIMESTAMP
 #define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING       SO_TIMESTAMPING
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index dc8527cae5a7..5bdbb25c28d2 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -106,20 +106,22 @@
 #define SO_TIMESTAMPNS_OLD       0x0021
 #define SO_TIMESTAMPING_OLD      0x0023
 
-#define SO_TIMESTAMP_NEW         0x0040
-#define SO_TIMESTAMPNS_NEW       0x0041
+#define SO_TIMESTAMP_NEW         0x0041
+#define SO_TIMESTAMPNS_NEW       0x0042
+#define SO_TIMESTAMPING_NEW      0x0043
 
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
 #endif
 
-#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
 #define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 8b571e9b9f76..372fd77698a2 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -350,6 +350,13 @@ extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
 struct timespec64;
 
+struct scm_timestamping_internal {
+	struct timespec64 ts[3];
+};
+
+extern void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss);
+extern void put_cmsg_scm_timestamping(struct msghdr *msg, struct scm_timestamping_internal *tss);
+
 /* The __sys_...msg variants allow MSG_CMSG_COMPAT iff
  * forbid_cmsg_compat==false
  */
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 0b0fae6b57a9..2fdfb6126246 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -110,6 +110,7 @@
 
 #define SO_TIMESTAMP_NEW         62
 #define SO_TIMESTAMPNS_NEW       63
+#define SO_TIMESTAMPING_NEW         64
 
 #if !defined(__KERNEL__)
 
@@ -117,13 +118,13 @@
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
 #endif
 
-#define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
-
 #define SCM_TIMESTAMP          SO_TIMESTAMP
 #define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING       SO_TIMESTAMPING
diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.h
index c0151200f7d1..d955b9e32288 100644
--- a/include/uapi/linux/errqueue.h
+++ b/include/uapi/linux/errqueue.h
@@ -41,6 +41,10 @@ struct scm_timestamping {
 	struct timespec ts[3];
 };
 
+struct scm_timestamping64 {
+	struct __kernel_timespec ts[3];
+};
+
 /* The type of scm_timestamping, passed in sock_extended_err ee_info.
  * This defines the type of ts[0]. For SCM_TSTAMP_SND only, if ts[0]
  * is zero, then this is a hardware timestamp and recorded in ts[2].
diff --git a/net/core/scm.c b/net/core/scm.c
index b1ff8a441748..52ef219cf6df 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -29,6 +29,7 @@
 #include <linux/pid.h>
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
+#include <linux/errqueue.h>
 
 #include <linux/uaccess.h>
 
@@ -252,6 +253,32 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 }
 EXPORT_SYMBOL(put_cmsg);
 
+void put_cmsg_scm_timestamping64(struct msghdr *msg, struct scm_timestamping_internal *tss_internal)
+{
+	struct scm_timestamping64 tss;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tss.ts); i++) {
+		tss.ts[i].tv_sec = tss_internal->ts[i].tv_sec;
+		tss.ts[i].tv_nsec = tss_internal->ts[i].tv_nsec;
+	}
+
+	put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_NEW, sizeof(tss), &tss);
+}
+EXPORT_SYMBOL(put_cmsg_scm_timestamping64);
+
+void put_cmsg_scm_timestamping(struct msghdr *msg, struct scm_timestamping_internal *tss_internal)
+{
+	struct scm_timestamping tss;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tss.ts); i++)
+		tss.ts[i] = timespec64_to_timespec(tss_internal->ts[i]);
+
+	put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_OLD, sizeof(tss), &tss);
+}
+EXPORT_SYMBOL(put_cmsg_scm_timestamping);
+
 void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 {
 	struct cmsghdr __user *cm
diff --git a/net/core/sock.c b/net/core/sock.c
index 7b485dfaa400..29cc1f0f0071 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -677,6 +677,45 @@ static void setsockopt_timestamp(struct sock *sk, int type, int val)
 	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
 }
 
+static int setsockopt_timestamping(struct sock *sk, int type, int val)
+{
+	if (type == SO_TIMESTAMPING_NEW)
+		sock_set_flag(sk, SOCK_TSTAMP_NEW);
+
+	if (val & ~SOF_TIMESTAMPING_MASK)
+		return -EINVAL;
+
+	if (val & SOF_TIMESTAMPING_OPT_ID &&
+	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
+		if (sk->sk_protocol == IPPROTO_TCP &&
+		    sk->sk_type == SOCK_STREAM) {
+			if ((1 << sk->sk_state) &
+			    (TCPF_CLOSE | TCPF_LISTEN))
+				return -EINVAL;
+			sk->sk_tskey = tcp_sk(sk)->snd_una;
+		} else {
+			sk->sk_tskey = 0;
+		}
+	}
+
+	if (val & SOF_TIMESTAMPING_OPT_STATS &&
+	    !(val & SOF_TIMESTAMPING_OPT_TSONLY))
+		return -EINVAL;
+
+	sk->sk_tsflags = val;
+	if (val & SOF_TIMESTAMPING_RX_SOFTWARE) {
+		sock_enable_timestamp(sk,
+				      SOCK_TIMESTAMPING_RX_SOFTWARE);
+	} else {
+		if (type == SO_TIMESTAMPING_NEW)
+			sock_reset_flag(sk, SOCK_TSTAMP_NEW);
+		sock_disable_timestamp(sk,
+				       (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
+	}
+
+	return 0;
+}
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -852,39 +891,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_TIMESTAMPING_OLD:
-		if (val & ~SOF_TIMESTAMPING_MASK) {
-			ret = -EINVAL;
-			break;
-		}
-
-		if (val & SOF_TIMESTAMPING_OPT_ID &&
-		    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
-			if (sk->sk_protocol == IPPROTO_TCP &&
-			    sk->sk_type == SOCK_STREAM) {
-				if ((1 << sk->sk_state) &
-				    (TCPF_CLOSE | TCPF_LISTEN)) {
-					ret = -EINVAL;
-					break;
-				}
-				sk->sk_tskey = tcp_sk(sk)->snd_una;
-			} else {
-				sk->sk_tskey = 0;
-			}
-		}
-
-		if (val & SOF_TIMESTAMPING_OPT_STATS &&
-		    !(val & SOF_TIMESTAMPING_OPT_TSONLY)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		sk->sk_tsflags = val;
-		if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
-			sock_enable_timestamp(sk,
-					      SOCK_TIMESTAMPING_RX_SOFTWARE);
-		else
-			sock_disable_timestamp(sk,
-					       (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
+		ret = setsockopt_timestamping(sk, optname, val);
 		break;
 
 	case SO_RCVLOWAT:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b470f470343a..09ef0d8141fb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1847,17 +1847,17 @@ static int tcp_zerocopy_receive(struct sock *sk,
 #endif
 
 static void tcp_update_recv_tstamps(struct sk_buff *skb,
-				    struct scm_timestamping *tss)
+				    struct scm_timestamping_internal *tss)
 {
 	if (skb->tstamp)
-		tss->ts[0] = ktime_to_timespec(skb->tstamp);
+		tss->ts[0] = ktime_to_timespec64(skb->tstamp);
 	else
-		tss->ts[0] = (struct timespec) {0};
+		tss->ts[0] = (struct timespec64) {0};
 
 	if (skb_hwtstamps(skb)->hwtstamp)
-		tss->ts[2] = ktime_to_timespec(skb_hwtstamps(skb)->hwtstamp);
+		tss->ts[2] = ktime_to_timespec64(skb_hwtstamps(skb)->hwtstamp);
 	else
-		tss->ts[2] = (struct timespec) {0};
+		tss->ts[2] = (struct timespec64) {0};
 }
 
 static void tcp_recv_sw_timestamp(struct msghdr *msg, const struct sock *sk, struct timespec64 *ts)
@@ -1900,29 +1900,30 @@ static void tcp_recv_sw_timestamp(struct msghdr *msg, const struct sock *sk, str
 
 /* Similar to __sock_recv_timestamp, but does not require an skb */
 static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
-			       struct scm_timestamping *tss)
+			       struct scm_timestamping_internal *tss)
 {
 	bool has_timestamping = false;
-	struct timespec64 ts = timespec_to_timespec64(tss->ts[0]);
 
-	tcp_recv_sw_timestamp(msg, sk, &ts);
+	tcp_recv_sw_timestamp(msg, sk, &tss->ts[0]);
 
 	if (sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE)
 		has_timestamping = true;
 	else
-		tss->ts[0] = (struct timespec) {0};
+		tss->ts[0] = (struct timespec64) {0};
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
 		if (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
 			has_timestamping = true;
 		else
-			tss->ts[2] = (struct timespec) {0};
+			tss->ts[2] = (struct timespec64) {0};
 	}
 
 	if (has_timestamping) {
-		tss->ts[1] = (struct timespec) {0};
-		put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPING_OLD,
-			 sizeof(*tss), tss);
+		tss->ts[1] = (struct timespec64) {0};
+		if (sock_flag(sk, SOCK_TSTAMP_NEW))
+			put_cmsg_scm_timestamping64(msg, tss);
+		else
+			put_cmsg_scm_timestamping(msg, tss);
 	}
 }
 
@@ -1963,7 +1964,7 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
 	long timeo;
 	struct sk_buff *skb, *last;
 	u32 urg_hole = 0;
-	struct scm_timestamping tss;
+	struct scm_timestamping_internal tss;
 	bool has_tss = false;
 	bool has_cmsg;
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 80e2119f1c70..e588305e9cf4 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -280,7 +280,8 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 			     (1UL << SOCK_RXQ_OVFL) | \
 			     (1UL << SOCK_WIFI_STATUS) | \
 			     (1UL << SOCK_NOFCS) | \
-			     (1UL << SOCK_FILTER_LOCKED))
+			     (1UL << SOCK_FILTER_LOCKED) | \
+			     (1UL << SOCK_TSTAMP_NEW))
 /* copy only relevant settings and flags of SOL_SOCKET level from smc to
  * clc socket (since smc is not called for these options from net/core)
  */
diff --git a/net/socket.c b/net/socket.c
index 9abeb6bc9cfe..14fa6febfc3d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -731,6 +731,7 @@ static void sock_recv_sw_timestamp(struct msghdr *msg, struct sock *sk,
 			 sizeof(ts), &ts);
 	}
 }
+
 /*
  * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
  * or sock_flag(sk, SOCK_RCVTSTAMPNS)
@@ -739,8 +740,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	struct sk_buff *skb)
 {
 	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP) || sock_flag(sk, SOCK_RCVTSTAMPNS);
-	struct scm_timestamping tss;
-	int empty = 1, false_tstamp = 0;
+	struct scm_timestamping_internal tss;
+	int empty = 1, false_tstamp = 0, new_tstamp = 0;
 	struct skb_shared_hwtstamps *shhwtstamps =
 		skb_hwtstamps(skb);
 
@@ -756,20 +757,23 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	memset(&tss, 0, sizeof(tss));
 	if ((sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
-	    ktime_to_timespec_cond(skb->tstamp, tss.ts + 0))
+	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
 	    (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
 	    !skb_is_swtx_tstamp(skb, false_tstamp) &&
-	    ktime_to_timespec_cond(shhwtstamps->hwtstamp, tss.ts + 2)) {
+	    ktime_to_timespec64_cond(shhwtstamps->hwtstamp, tss.ts + 2)) {
 		empty = 0;
 		if ((sk->sk_tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
 		    !skb_is_err_queue(skb))
 			put_ts_pktinfo(msg, skb);
 	}
 	if (!empty) {
-		put_cmsg(msg, SOL_SOCKET,
-			 SO_TIMESTAMPING_OLD, sizeof(tss), &tss);
+		new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
+		if (new_tstamp)
+			put_cmsg_scm_timestamping64(msg, &tss);
+		else
+			put_cmsg_scm_timestamping(msg, &tss);
 
 		if (skb_is_err_queue(skb) && skb->len &&
 		    SKB_EXT_ERR(skb)->opt_stats)
-- 
2.17.1

