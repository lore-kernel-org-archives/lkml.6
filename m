Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948BEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7C320870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 02:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DntKt7Bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7C320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeKXNJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 08:09:23 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38805 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbeKXNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 08:08:47 -0500
Received: by mail-yw1-f66.google.com with SMTP id i20so5430277ywc.5;
        Fri, 23 Nov 2018 18:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PB1FmyTUCyZQ9GsjxSKL8mHqAhf60uMLU8nvOtxuurQ=;
        b=DntKt7BsQ8Basy+S3r+aa1Z2vr0+DG622IsuPGr9pRSEW0KKDiACbcR/RR5xbEAXJ/
         KgXNiqoyWJHyWTxFR7/4y6BpzoW1LdZyrf/uyvUvRpXaxHYVArPe8RZb+PT1Yy9wKThn
         Rrgbebq/KG9HzgFrPi1d/yByVBQilT7EfW3XOPnO4yMQ3pZZE34DjBb5Pop8xavDdBJg
         /QEpHR5SbUAcyQ/hXtB+dGbU6U+egtcecV47qdujuZzbGnHc9d0lEEEJUgvIN25gayTR
         mwJlGQM12RPhDIEXys+I/YBgqSe4tzi8npVt9kZX92WXQdO5dqe/UbkeNKIvCL3k/Onu
         56bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PB1FmyTUCyZQ9GsjxSKL8mHqAhf60uMLU8nvOtxuurQ=;
        b=RRqWvqjFVDjP1fU8N5IjTIqpXJx0cISMTzxq6n0qQZVVnyNjDTnZ4fEQKdJo3NLZ4e
         geiqrs+TiZeIsfF0WOLJ3kiI5o3TOi0+cc2ZmZ4Sj2Qr6++wWp6VF63ZyUAbfvh1vL2D
         mahnKBxd5ccKITh95inDjL5o+jTTxFe0u08XzFembtDRAEPUA7KiXqztSVA89n++Ti+3
         S+bmQPE7uYYzwm3wkJNqGsME5kx0pYfrQMLMfLIbSGL+QzQfrpP4AsGT843lt7fdfeMl
         MiAfj8gxoBfY01f81E4CFj/OWOKG6P/qvPxDqAPR5oGSfPDaaGhsRjUWClxJ9K9S/c0C
         uwrA==
X-Gm-Message-State: AGRZ1gIoA6JrZjU+3QNA8U3OpsvzAYIfI+7SFIydnjjlbcNIuro9u83y
        F/GuYc4ek7RSzAhuwMnWAwo=
X-Google-Smtp-Source: AJdET5dQmQC91fHM7ePiHc6U7qQbWeCXRA3gvNEl3D3Pova90yXIQLJIEKgDVP9P8QKZ9hBCbnI2lw==
X-Received: by 2002:a81:2b09:: with SMTP id r9-v6mr19267282ywr.155.1543026129054;
        Fri, 23 Nov 2018 18:22:09 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-213.hsd1.ca.comcast.net. [98.234.52.213])
        by smtp.gmail.com with ESMTPSA id w1sm6947292ywd.49.2018.11.23.18.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:22:08 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org, isdn@linux-pingi.de
Subject: [PATCH 5/8] socket: Use old_timeval types for socket timestamps
Date:   Fri, 23 Nov 2018 18:20:32 -0800
Message-Id: <20181124022035.17519-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181124022035.17519-1-deepa.kernel@gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of y2038 solution, all internal uses of
struct timeval are replaced by struct __kernel_old_timeval
and struct compat_timeval by struct old_timeval32.
Make socket timestamps use these new types.

This is mainly to be able to verify that the kernel build
is y2038 safe when such non y2038 safe types are not
supported anymore.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: isdn@linux-pingi.de
---
 drivers/isdn/mISDN/socket.c | 2 +-
 include/linux/skbuff.h      | 6 +++---
 net/bluetooth/hci_sock.c    | 4 ++--
 net/compat.c                | 6 +++---
 net/ipv4/tcp.c              | 2 +-
 net/rds/recv.c              | 2 +-
 net/socket.c                | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 15d3ca37669a..4ab8b1b6608f 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -103,7 +103,7 @@ mISDN_ctrl(struct mISDNchannel *ch, u_int cmd, void *arg)
 static inline void
 mISDN_sock_cmsg(struct sock *sk, struct msghdr *msg, struct sk_buff *skb)
 {
-	struct timeval	tv;
+	struct __kernel_old_timeval	tv;
 
 	if (_pms(sk)->cmask & MISDN_TIME_STAMP) {
 		skb_get_timestamp(skb, &tv);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a2e8297a5b00..e2dc01330cb1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3453,16 +3453,16 @@ static inline ktime_t skb_get_ktime(const struct sk_buff *skb)
 /**
  *	skb_get_timestamp - get timestamp from a skb
  *	@skb: skb to get stamp from
- *	@stamp: pointer to struct timeval to store stamp in
+ *	@stamp: pointer to struct __kernel_old_timeval to store stamp in
  *
  *	Timestamps are stored in the skb as offsets to a base timestamp.
  *	This function converts the offset back to a struct timeval and stores
  *	it in stamp.
  */
 static inline void skb_get_timestamp(const struct sk_buff *skb,
-				     struct timeval *stamp)
+				     struct __kernel_old_timeval *stamp)
 {
-	*stamp = ktime_to_timeval(skb->tstamp);
+	*stamp = ns_to_kernel_old_timeval(skb->tstamp);
 }
 
 static inline void skb_get_timestampns(const struct sk_buff *skb,
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 10dfd20c748e..32aff3755480 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1400,9 +1400,9 @@ static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
 
 	if (mask & HCI_CMSG_TSTAMP) {
 #ifdef CONFIG_COMPAT
-		struct compat_timeval ctv;
+		struct old_timeval32 ctv;
 #endif
-		struct timeval tv;
+		struct __kernel_old_timeval tv;
 		void *data;
 		int len;
 
diff --git a/net/compat.c b/net/compat.c
index 720ab07276b0..8dea66c96926 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -209,8 +209,8 @@ int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *dat
 {
 	struct compat_cmsghdr __user *cm = (struct compat_cmsghdr __user *) kmsg->msg_control;
 	struct compat_cmsghdr cmhdr;
-	struct compat_timeval ctv;
-	struct compat_timespec cts[3];
+	struct old_timeval32 ctv;
+	struct old_timespec32 cts[3];
 	int cmlen;
 
 	if (cm == NULL || kmsg->msg_controllen < sizeof(*cm)) {
@@ -220,7 +220,7 @@ int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *dat
 
 	if (!COMPAT_USE_64BIT_TIME) {
 		if (level == SOL_SOCKET && type == SO_TIMESTAMP_OLD) {
-			struct timeval *tv = (struct timeval *)data;
+			struct __kernel_old_timeval *tv = (struct __kernel_old_timeval *)data;
 			ctv.tv_sec = tv->tv_sec;
 			ctv.tv_usec = tv->tv_usec;
 			data = &ctv;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d6eb5f542fcf..805d9965a210 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1864,7 +1864,7 @@ static void tcp_update_recv_tstamps(struct sk_buff *skb,
 static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			       struct scm_timestamping *tss)
 {
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 04e30d63a159..435bf2320cd3 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -549,7 +549,7 @@ static int rds_cmsg_recv(struct rds_incoming *inc, struct msghdr *msg,
 
 	if ((inc->i_rx_tstamp != 0) &&
 	    sock_flag(rds_rs_to_sk(rs), SOCK_RCVTSTAMP)) {
-		struct timeval tv = ktime_to_timeval(inc->i_rx_tstamp);
+		struct __kernel_old_timeval tv = ns_to_kernel_old_timeval(inc->i_rx_tstamp);
 		ret = put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
 			       sizeof(tv), &tv);
 		if (ret)
diff --git a/net/socket.c b/net/socket.c
index c7455349a3c1..d3defba55547 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -721,7 +721,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	if (need_software_tstamp) {
 		if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-			struct timeval tv;
+			struct __kernel_old_timeval tv;
 			skb_get_timestamp(skb, &tv);
 			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
 				 sizeof(tv), &tv);
-- 
2.17.1

