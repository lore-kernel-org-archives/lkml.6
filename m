Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42250C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17AC20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oL2wVreS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17AC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbeKEXNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:13:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39311 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeKEXNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:13:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so4498316pla.6;
        Mon, 05 Nov 2018 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ry0GDNt4C7cfDwbS6w3Pb7pQgsDHUwve/m6FsDzN1HY=;
        b=oL2wVreS9NHQUIcIiT7A2Q2L++5AtnODnLsDnE8AEssHyBwRaeMYCFaq+xqN7ukCJA
         YD1aUwc1Kr4o7IKuxPBO4E1521lyw+eDvHSTMlAqUn4aSXf4LAZE0HY4fziLfPCXKv2A
         PXP150arjhz67yjGFbUkMl+MNSI/v6nRjJe6xtJWVM3YjpYHKyHpMWxlO5is4CnRua0t
         YiYjnqBkmgu2Ad7IJ7UZdmfpNePAep4Yw+fp3bG2RdavTshAnZ1iSyMMqsa0c2QC/q7V
         gGwf1gLiwIwp2xI08YyxVlRmThyRGrXm8DJ+APSjoHWsZgsgoFZs+D3hmTH3UmCKBDXl
         IGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ry0GDNt4C7cfDwbS6w3Pb7pQgsDHUwve/m6FsDzN1HY=;
        b=SpRBpU+4apY4bFU1zTyUnnf26+xymyo2gkFHWeCXelRWECaS1a7AQ97BSG18Q72Rju
         PHFcoL14+0EYhp6xtAc1Z2cNyWFW7fsxIKqH3nXLcYFueQjZGaG2+v9ZZ1DytGC8xdH6
         qCcc4VQSin120I6nm5aOH7g4yGb7gPyYiN7LzkS3PpP5yLrL5gVXSJ+IbXO71dIYXFST
         UAT8AKb5L21Qm7QsK693vN/9omeqORlUNZlbTdajZ6CL0abkJakBa6wMCNVFfzEQTN5F
         pvOyZMFDPtm31kgxNrtB4DqMj7+y4NW1ZKT/r7ipQaTZOwQPDda3kn7MhJ8EtFVm4SuU
         QRaQ==
X-Gm-Message-State: AGRZ1gKt6RYyzkfXlToDtce5DBBg1f8OhKKrigKKljmF/6nq/mVzCJ0g
        P4g1lGWld7VdmanTzRsM3JA=
X-Google-Smtp-Source: AJdET5c1XCKh7ELErFm3jYnpMKXDu5684bnOMBj3bamR8qX6BG1z0zk8SX2IOaJwWApC/tY7vJK2NA==
X-Received: by 2002:a17:902:8214:: with SMTP id x20-v6mr3556419pln.224.1541426005727;
        Mon, 05 Nov 2018 05:53:25 -0800 (PST)
Received: from localhost.localdomain ([2405:204:50af:daf6:e066:ba43:1e0f:f613])
        by smtp.gmail.com with ESMTPSA id 18sm8250226pgl.50.2018.11.05.05.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 05:53:25 -0800 (PST)
From:   Suraj Singh <suraj1998@gmail.com>
To:     edumazet@google.com
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suraj Singh <suraj1998@gmail.com>
Subject: [PATCH] staging: net: ipv4: tcp_westwood: fixed warnings and checks
Date:   Mon,  5 Nov 2018 19:23:05 +0530
Message-Id: <1541425985-31869-1-git-send-email-suraj1998@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed warnings and checks for TCP Westwood

Signed-off-by: Suraj Singh <suraj1998@gmail.com>
---
 net/ipv4/tcp_westwood.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/tcp_westwood.c b/net/ipv4/tcp_westwood.c
index bec9caf..0b4c67a9 100644
--- a/net/ipv4/tcp_westwood.c
+++ b/net/ipv4/tcp_westwood.c
@@ -43,11 +43,10 @@ struct westwood {
 };
 
 /* TCP Westwood functions and constants */
-#define TCP_WESTWOOD_RTT_MIN   (HZ/20)	/* 50ms */
-#define TCP_WESTWOOD_INIT_RTT  (20*HZ)	/* maybe too conservative?! */
+#define TCP_WESTWOOD_RTT_MIN   (HZ / 20)	/* 50ms */
+#define TCP_WESTWOOD_INIT_RTT  (20 * HZ)	/* maybe too conservative?! */
 
-/*
- * @tcp_westwood_create
+/* @tcp_westwood_create
  * This function initializes fields used in TCP Westwood+,
  * it is called after the initial SYN, so the sequence numbers
  * are correct but new passive connections we have no
@@ -67,14 +66,14 @@ static void tcp_westwood_init(struct sock *sk)
 	w->accounted = 0;
 	w->cumul_ack = 0;
 	w->reset_rtt_min = 1;
-	w->rtt_min = w->rtt = TCP_WESTWOOD_INIT_RTT;
+	w->rtt_min = TCP_WESTWOOD_INIT_RTT;
+	w->rtt = TCP_WESTWOOD_INIT_RTT;
 	w->rtt_win_sx = tcp_jiffies32;
 	w->snd_una = tcp_sk(sk)->snd_una;
 	w->first_ack = 1;
 }
 
-/*
- * @westwood_do_filter
+/* @westwood_do_filter
  * Low-pass filter. Implemented using constant coefficients.
  */
 static inline u32 westwood_do_filter(u32 a, u32 b)
@@ -94,8 +93,7 @@ static void westwood_filter(struct westwood *w, u32 delta)
 	}
 }
 
-/*
- * @westwood_pkts_acked
+/* @westwood_pkts_acked
  * Called after processing group of packets.
  * but all westwood needs is the last sample of srtt.
  */
@@ -108,8 +106,7 @@ static void tcp_westwood_pkts_acked(struct sock *sk,
 		w->rtt = usecs_to_jiffies(sample->rtt_us);
 }
 
-/*
- * @westwood_update_window
+/* @westwood_update_window
  * It updates RTT evaluation window if it is the right moment to do
  * it. If so it calls filter for evaluating bandwidth.
  */
@@ -127,8 +124,7 @@ static void westwood_update_window(struct sock *sk)
 		w->first_ack = 0;
 	}
 
-	/*
-	 * See if a RTT-window has passed.
+	/* See if a RTT-window has passed.
 	 * Be careful since if RTT is less than
 	 * 50ms we don't filter but we continue 'building the sample'.
 	 * This minimum limit was chosen since an estimation on small
@@ -149,12 +145,12 @@ static inline void update_rtt_min(struct westwood *w)
 	if (w->reset_rtt_min) {
 		w->rtt_min = w->rtt;
 		w->reset_rtt_min = 0;
-	} else
+	} else {
 		w->rtt_min = min(w->rtt, w->rtt_min);
+	}
 }
 
-/*
- * @westwood_fast_bw
+/* @westwood_fast_bw
  * It is called when we are in fast path. In particular it is called when
  * header prediction is successful. In such case in fact update is
  * straight forward and doesn't need any particular care.
@@ -171,8 +167,7 @@ static inline void westwood_fast_bw(struct sock *sk)
 	update_rtt_min(w);
 }
 
-/*
- * @westwood_acked_count
+/* @westwood_acked_count
  * This function evaluates cumul_ack for evaluating bk in case of
  * delayed or partial acks.
  */
@@ -207,8 +202,7 @@ static inline u32 westwood_acked_count(struct sock *sk)
 	return w->cumul_ack;
 }
 
-/*
- * TCP Westwood
+/* TCP Westwood
  * Here limit is evaluated as Bw estimation*RTTmin (for obtaining it
  * in packets we use mss_cache). Rttmin is guaranteed to be >= 2
  * so avoids ever returning 0.
@@ -243,7 +237,8 @@ static void tcp_westwood_event(struct sock *sk, enum tcp_ca_event event)
 
 	switch (event) {
 	case CA_EVENT_COMPLETE_CWR:
-		tp->snd_cwnd = tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);
+		tp->snd_cwnd = tcp_westwood_bw_rttmin(sk);
+		tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);
 		break;
 	case CA_EVENT_LOSS:
 		tp->snd_ssthresh = tcp_westwood_bw_rttmin(sk);
-- 
2.7.4

