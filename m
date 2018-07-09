Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C728C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183CA20896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brCok35Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183CA20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932996AbeGIL0H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:26:07 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35787 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeGIL0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:26:05 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so14914424lfc.2;
        Mon, 09 Jul 2018 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cIfUb9eo9DKLMqfr4Ta/6qUjUnFMnVhhnCqRu7urTmI=;
        b=brCok35Zc7PW0gtLen6xwtk5Ve4vBwTrDCDRN0JzPtuFzwJX54N6LeTuFtXD2zY+QT
         0pDxl95wiP5xk+7D5A5O5I2oyPBCxPPTAdKVvHOCWWmqBfZWlkHwKpb7a0DlwUlp9I4y
         GMyx3UDoZqTrQd9owTsVQNYTVGBOsqrCqZAvFwBInMpagzFB6DSi9A4mY6lMVbHZfA6g
         jXA0oLyypfu3fVMBE6YQJveviFX8Oqh8Yd0vIIYTq+QOHzDQeX+s0dAfnYABUlY54kRH
         ZmV941xgXcXktl+BzqzCH+vxDLMJd34IYojFZ44gfkhDPVgWzO/9HXH2iSk6LqxuYpPl
         aU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cIfUb9eo9DKLMqfr4Ta/6qUjUnFMnVhhnCqRu7urTmI=;
        b=VCdw5HR34ZIn5z1n88gSWIYcuwJirSeE38ifO1M2bMsssBsxMfUbptI8vL4oVm5ENp
         3VyAZB712bRBqKnk2B/yUE/EVkP6IZILtOBtPGbl/op7dmAhNqDUL7vubCecgtsop7UR
         zNULK+f3R1YT+8dzb5UlbfRo2Dp4v1GNsIQF7d7D6dYlgClCZoWrFBBP6NLB97XTpYC5
         TEqPQ/NZ83P6iBjPipgo7dOGm5b0QNNWmFzAnrY1clli/FpvnaJaldY0WwYH64wFWXsr
         HI63+2LqA9tgC9++ZCrh8PICCAyfnwTZ+lmA3UGmLC5rjZ3HQ+uX5F1+8RWFaNdJrqJz
         BZ8g==
X-Gm-Message-State: APt69E2/ctjjxGHJbWgT6f0PohP4/CbWSck+z+uOjG+HHRQII7dBdS/o
        sHVQLpzCqilg5fNNRwWhG+8=
X-Google-Smtp-Source: AAOMgpeWtoRi7MFBPer1ww1PtLzg8j0mSqVaOK6LcRZwGLQmYeAtogZjKhr87EgmRInFl3z/i/mfSQ==
X-Received: by 2002:a19:eb1b:: with SMTP id j27-v6mr14613818lfh.0.1531135563849;
        Mon, 09 Jul 2018 04:26:03 -0700 (PDT)
Received: from joakim.home (host-37-191-226-123.lynet.no. [37.191.226.123])
        by smtp.gmail.com with ESMTPSA id o19-v6sm4072830lfk.65.2018.07.09.04.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:26:03 -0700 (PDT)
From:   joakim.misund@gmail.com
Cc:     joakim.misund@gmail.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp: Added check of destination specific CC before sending syn/ack
Date:   Mon,  9 Jul 2018 13:25:53 +0200
Message-Id: <20180709112554.32754-1-joakim.misund@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Misund <joakim.misund@gmail.com>

Issue:
Currently TCP stack does not check for a destination specific CC before responding to a syn with a syn/ack.
The system wide default CC is used. If the default CC does not need ECN, but the destination specific does,
the syn/ack will not carry ECT(0) which makes it eligible to drop instead of being marked at routers.
In an ECN-based network ECN marks are frequent (likely) and packet not carrying ECT(0) are likely to be dropped.
This leads to slow connection establishment, and in worst case the establishment can fail.

Signed-off-by: Joakim Misund <joakim.misund@gmail.com>
---
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_input.c  | 2 ++
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index af3ec72d5d41..347c59ac0a72 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -545,6 +545,7 @@ void tcp_send_loss_probe(struct sock *sk);
 bool tcp_schedule_loss_probe(struct sock *sk, bool advancing_rto);
 void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 			     const struct sk_buff *next_skb);
+void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst);
 
 /* tcp_input.c */
 void tcp_rearm_rto(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8e5522c6833a..973e3b5b0516 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6401,6 +6401,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		isn = af_ops->init_seq(skb);
 	}
 
+	tcp_ca_dst_init(sk, dst);
+
 	tcp_ecn_create_request(req, skb, sk, dst);
 
 	if (want_cookie) {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8e08b409c71e..550597acd48c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3256,7 +3256,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 }
 EXPORT_SYMBOL(tcp_make_synack);
 
-static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
+void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	const struct tcp_congestion_ops *ca;
-- 
2.17.1

