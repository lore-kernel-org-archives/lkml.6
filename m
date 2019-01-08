Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4752183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGjF/wMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfAHD23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:28:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37130 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfAHD1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:27:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so1207442pfb.4;
        Mon, 07 Jan 2019 19:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I1JceEop2uJTPTgoDzrlH1oKytEmNP/C6OoCew04nnY=;
        b=LGjF/wMTfoz7kQhFMhs8WmF6ELXrkZG59fcfFQOa6oAQXFsxbTJQYjy1iyuEYNPqVr
         w36SdUwAcYkWH5kJfB4rOI1BewfJylgfYFE+jWwz+rqFunZ5z6LMLkncOpQTLJHP1W78
         CT+Hgt9Tu0zQZ/oH3QYkecJjWe7qHX3cKeIljJzFUU5y0rp7i+P4hO5+TxpfaxIFdoQM
         O/6m5Fe5dblIzdz8F9gvYiblsnVr4qN1ttLe8rOztAwr2n8zf6BjkF3R1dkk59SULKH7
         cGpnhtzakzdtsDVzcbNY1kzu9pXclqlVMva61144FS22/7kz8whCwQ979lWATnsI2yAj
         wJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I1JceEop2uJTPTgoDzrlH1oKytEmNP/C6OoCew04nnY=;
        b=gvurrMJ/xhT9atS+9Ya7lixW3hnKf1mz8LAL4hyk1qOJW+npQcjNjb8Vi4Hrx5cWai
         n7k/fFfcLjiJOMJ/lJsnKPhulMFjwctM+QtBgqrqGtJKKCHsCtXMEGT8Iqyg51I1tWDj
         aP4yFv6W7BoH8VWMAy4lr8WJVIRZ4/d0Nz13DDqXQOPmOiRM36emvw/xQ/LI72m7ifPO
         JWtoCkEJ8tn1zfpLfPYFJM9DGEBp/TI+YG9uOdhE+71DgDzwQsPXp8hj1oX4yw1CMCGP
         eaKy/E75TkY07JE6oEfvyT/RcX5SDN7EtjRWxpfKuZXMFpIgQIMejrsMacWVvcReyfvn
         tLyw==
X-Gm-Message-State: AJcUukfxunZWN+IgXjkcwzf5Cidr+ZRXJ6GtpRD0w4/yQcRacVBirX7M
        abX+9Zu2xWWFzfFhE4HvmnY=
X-Google-Smtp-Source: ALg8bN4/V1uLX69Kp1+0kDwEnIOSByZxdTErkT9rttFh6cHgU9px0puv4griGlVzHTyx1/AIP5A0zg==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr87538pgv.438.1546918067922;
        Mon, 07 Jan 2019 19:27:47 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id v5sm117327735pgn.5.2019.01.07.19.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:27:47 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        isdn@linux-pingi.de
Subject: [PATCH v3 4/8] socket: Use old_timeval types for socket timestamps
Date:   Mon,  7 Jan 2019 19:26:53 -0800
Message-Id: <20190108032657.8331-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108032657.8331-1-deepa.kernel@gmail.com>
References: <20190108032657.8331-1-deepa.kernel@gmail.com>
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
 net/compat.c                | 8 ++++----
 net/ipv4/tcp.c              | 2 +-
 net/rds/recv.c              | 2 +-
 net/socket.c                | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

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
index 93f56fddd92a..85f6226d106f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3480,16 +3480,16 @@ static inline ktime_t skb_get_ktime(const struct sk_buff *skb)
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
index 1506e1632394..65228bfa4487 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1383,9 +1383,9 @@ static void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
 
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
index ad24c1c0f0a1..b6ff0899e424 100644
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
@@ -425,7 +425,7 @@ static int do_get_sock_timeout(struct socket *sock, int level, int optname,
 	mm_segment_t old_fs;
 	int len, err;
 
-	up = (struct compat_timeval __user *) optval;
+	up = (struct compat_timeval __user *)optval;
 	if (get_user(len, optlen))
 		return -EFAULT;
 	if (len < sizeof(*up))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 95eebe94ecf0..e6e2ea0ac0f4 100644
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
index 5087f9e40f3a..9cc281cdb9d9 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -719,7 +719,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	if (need_software_tstamp) {
 		if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-			struct timeval tv;
+			struct __kernel_old_timeval tv;
 			skb_get_timestamp(skb, &tv);
 			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
 				 sizeof(tv), &tv);
-- 
2.17.1

