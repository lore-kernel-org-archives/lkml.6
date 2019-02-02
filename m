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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB9C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAE22086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsbELLsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfBBPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:35:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39168 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbfBBPf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:35:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so4376191pgp.6;
        Sat, 02 Feb 2019 07:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G/ZOX5IzLI29gUz6rZeb7aWODlXJ0AEiUmqVvANVxp8=;
        b=NsbELLsjTbs2MU54pHC+gaxFzBsQUnYwQJ+/p3K3qJnI/W7br1Xzoqj19+scVs0LzS
         P31GvMPd8P4kibw8ktm+qMJ15DpJKZEnONj0UsVgYRGHdOG9MJyfCx2Od21u0AYSA+xB
         0p+saOVxOfXEE57lYUWq7GnwflfAk1dmjb+/Us3XR8UNB5KqgyVDc34TW7/OUKKahkuY
         yPDPWANmEuWYxn4Iyp0rR9Qwqhb7yQyI65v0gsj1Vi7RXsJxn9BzzRdycOmkcJDD7R3O
         Ubjeol3xxQMSAR/zeZDiQ5fkOaSjTgyyflAWqioXQ4S71Yn8sOHpq+7meQDsiytTgGTi
         5x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G/ZOX5IzLI29gUz6rZeb7aWODlXJ0AEiUmqVvANVxp8=;
        b=TQaNS6cxj6oYh+20RxKiwVloea6oAGiI9ImAkj3KJnQwJH16yuA8mV7W1oz8yyGW0r
         CE74mGcNnps5992z0MnyxL5OUTZrkZpg99PRNYH/3UBU+J3wiq/PahWpWxz5Hfs8sTT7
         1AnubLBGkwvUKjfuVCRsIwkqOzbUVMoYxF9o//xJW3iU0PWzdLFWXx6AP5inB1hldgC1
         e+Vmft6uCX8ixxyPmjDfVljD3mE6HYu9s2bqfsnJawNqzUAwo57zEIVbj4VlyIT1VrGD
         wKW3uWYnAPZTZ6YFR8fanVFyvum+vkYkhr9q+JqXp5fQdZ4TeAayPFWOxYlNLC4t6ubS
         fpFw==
X-Gm-Message-State: AJcUukcYhF4t0Xxd4N5pt8lhOSP8/38TZwUd5S4itnZfTs4IM6rLpQsJ
        rwBehpTcd3toTVyK9C9rueY=
X-Google-Smtp-Source: ALg8bN6BigtXidnCtlXt8KCg2oN3toYFT05S8yJ8DgkWIFv2TZnqlqhsocXWsdqWLRWfXp1A7/6TfQ==
X-Received: by 2002:a62:99dd:: with SMTP id t90mr43634524pfk.179.1549121756426;
        Sat, 02 Feb 2019 07:35:56 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id m20sm16221611pgb.56.2019.02.02.07.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:35:55 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        chris@zankel.net, fenghua.yu@intel.com, rth@twiddle.net,
        tglx@linutronix.de, ubraun@linux.ibm.com,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Subject: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
Date:   Sat,  2 Feb 2019 07:34:51 -0800
Message-Id: <20190202153454.7121-10-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202153454.7121-1-deepa.kernel@gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
This is the y2038 safe versions of the SO_TIMESTAMPING_OLD
for all architectures.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
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
 arch/alpha/include/uapi/asm/socket.h  |  5 +++--
 arch/mips/include/uapi/asm/socket.h   |  5 +++--
 arch/parisc/include/uapi/asm/socket.h |  5 +++--
 arch/sparc/include/uapi/asm/socket.h  |  5 +++--
 include/linux/socket.h                |  8 +++++++
 include/uapi/asm-generic/socket.h     |  5 +++--
 include/uapi/linux/errqueue.h         |  4 ++++
 net/core/scm.c                        | 27 ++++++++++++++++++++++++
 net/core/sock.c                       |  8 ++++++-
 net/ipv4/tcp.c                        | 30 +++++++++++++++------------
 net/smc/af_smc.c                      |  3 ++-
 net/socket.c                          | 13 +++++++-----
 12 files changed, 88 insertions(+), 30 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index aab11eec7c22..934ea6268f1a 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -117,19 +117,20 @@
 
 #define SO_TIMESTAMP_NEW        63
 #define SO_TIMESTAMPNS_NEW      64
+#define SO_TIMESTAMPING_NEW     65
 
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
 #endif
 
-#define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
-
 #define SCM_TIMESTAMP           SO_TIMESTAMP
 #define SCM_TIMESTAMPNS         SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING        SO_TIMESTAMPING
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 11014f684d9f..110f9506d64f 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -128,19 +128,20 @@
 
 #define SO_TIMESTAMP_NEW        63
 #define SO_TIMESTAMPNS_NEW      64
+#define SO_TIMESTAMPING_NEW     65
 
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
 
-#define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
-
 #define SCM_TIMESTAMP           SO_TIMESTAMP
 #define SCM_TIMESTAMPNS         SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING        SO_TIMESTAMPING
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index cbc4b89c2fe4..bee2a9dde656 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -109,19 +109,20 @@
 
 #define SO_TIMESTAMP_NEW        0x4038
 #define SO_TIMESTAMPNS_NEW      0x4039
+#define SO_TIMESTAMPING_NEW     0x403A
 
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
 #endif
 
-#define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
-
 #define SCM_TIMESTAMP           SO_TIMESTAMP
 #define SCM_TIMESTAMPNS         SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING        SO_TIMESTAMPING
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 85127425b294..2b38dda51426 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -110,19 +110,20 @@
 
 #define SO_TIMESTAMP_NEW         0x0041
 #define SO_TIMESTAMPNS_NEW       0x0042
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
-
 #define SCM_TIMESTAMP          SO_TIMESTAMP
 #define SCM_TIMESTAMPNS        SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING       SO_TIMESTAMPING
diff --git a/include/linux/socket.h b/include/linux/socket.h
index ab2041a00e01..6016daeecee4 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -349,9 +349,17 @@ struct ucred {
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
+struct timespec64;
 struct __kernel_timespec;
 struct old_timespec32;
 
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
index f22d3f7162f8..2713e0fa68ef 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -112,6 +112,7 @@
 
 #define SO_TIMESTAMP_NEW        63
 #define SO_TIMESTAMPNS_NEW      64
+#define SO_TIMESTAMPING_NEW     65
 
 #if !defined(__KERNEL__)
 
@@ -119,13 +120,13 @@
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
 #endif
 
-#define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
-
 #define SCM_TIMESTAMP           SO_TIMESTAMP
 #define SCM_TIMESTAMPNS         SO_TIMESTAMPNS
 #define SCM_TIMESTAMPING        SO_TIMESTAMPING
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
index 14b987eab10c..a9d1ecce96e5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -890,6 +890,8 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 
+	case SO_TIMESTAMPING_NEW:
+		sock_set_flag(sk, SOCK_TSTAMP_NEW);
 	case SO_TIMESTAMPING_OLD:
 		if (val & ~SOF_TIMESTAMPING_MASK) {
 			ret = -EINVAL;
@@ -921,9 +923,13 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
 			sock_enable_timestamp(sk,
 					      SOCK_TIMESTAMPING_RX_SOFTWARE);
-		else
+		else {
+			if (optname == SO_TIMESTAMPING_NEW)
+				sock_reset_flag(sk, SOCK_TSTAMP_NEW);
+
 			sock_disable_timestamp(sk,
 					       (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
+		}
 		break;
 
 	case SO_RCVLOWAT:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4e9388bf104a..cab6b2f2f61d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1844,22 +1844,22 @@ static int tcp_zerocopy_receive(struct sock *sk,
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
 
 /* Similar to __sock_recv_timestamp, but does not require an skb */
 static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
-			       struct scm_timestamping *tss)
+			       struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	bool has_timestamping = false;
@@ -1873,8 +1873,10 @@ static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
 						 sizeof(kts), &kts);
 				} else {
+					struct timespec ts_old = timespec64_to_timespec(tss->ts[0]);
+
 					put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
-						 sizeof(tss->ts[0]), &tss->ts[0]);
+						 sizeof(ts_old), &ts_old);
 				}
 			} else {
 				if (new_tstamp) {
@@ -1898,20 +1900,22 @@ static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 		if (sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE)
 			has_timestamping = true;
 		else
-			tss->ts[0] = (struct timespec) {0};
+			tss->ts[0] = (struct timespec64) {0};
 	}
 
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
 
@@ -1952,7 +1956,7 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
 	long timeo;
 	struct sk_buff *skb, *last;
 	u32 urg_hole = 0;
-	struct scm_timestamping tss;
+	struct scm_timestamping_internal tss;
 	bool has_tss = false;
 	bool has_cmsg;
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c4e56602e0c6..369870b0ef79 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -291,7 +291,8 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
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
index 1de96abd78d3..d51930689b98 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -706,7 +706,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 {
 	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
-	struct scm_timestamping tss;
+	struct scm_timestamping_internal tss;
+
 	int empty = 1, false_tstamp = 0;
 	struct skb_shared_hwtstamps *shhwtstamps =
 		skb_hwtstamps(skb);
@@ -752,20 +753,22 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
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
+		if (sock_flag(sk, SOCK_TSTAMP_NEW))
+			put_cmsg_scm_timestamping64(msg, &tss);
+		else
+			put_cmsg_scm_timestamping(msg, &tss);
 
 		if (skb_is_err_queue(skb) && skb->len &&
 		    SKB_EXT_ERR(skb)->opt_stats)
-- 
2.17.1

