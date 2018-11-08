Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA058C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7675D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9TcNcKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7675D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeKHTVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:21:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36111 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeKHTVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:21:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id w24-v6so9302259plq.3;
        Thu, 08 Nov 2018 01:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=40O0OiiBPjRULGBSxYQTY6aVsFDkHO40gtJ3fu6SCu0=;
        b=M9TcNcKLkAQrFw1OMuIcAox3i1qd5Dw/64Om57Qo7kq2+RMFnWhUeyMoo9/0Mr8wDo
         tdHPoToYQfXqhTGJR242eltRDWrsHncLKI8StBcJ/EMJuE5fRfPjWe82mJr3MfqGadGo
         zIrp+84G78FOitV8XuLQ71xpBMIEjgufQeh9ioxuvhhizaEGsaszaOmZQyrWeq7xi5xy
         Ex6bIgZP/35EMpmYkOP6gkftWKqXQYiulONZq8eVoPVKrFVTaJKYYEiYIO6APys3ea6B
         GQ/HltSXJbgqJIvxwM7su0CX1yHLfBJvIIxFwwOfTZUKMAGFGTYcXk1iAA0g1uK8tWCl
         P7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=40O0OiiBPjRULGBSxYQTY6aVsFDkHO40gtJ3fu6SCu0=;
        b=gjKFHe7UEg/oDMMmBdQ0rTFO3fhNYd8x+x5lmJmcVg6KPcq0anz24nVGwGDuAFP/j7
         mkqQ70BYlV6R7pX+djqt4Uk4e2cKOHoUeeo7IkvVTVxoziN2AddbAClTeS9uyldc0ZB/
         ddW8Z6iXZOmC0cysirQH+QTk4Q13lb1iMrqJFpPhGSQ/C9EgqglG0S5e1IWPPoEoJ8gR
         6mIirYnmVLkEXx194a1wbfpDKZw8206hJ3VRAX0B/zgIGkZ5xpQiUoajrY2NfGK50YsT
         a+4SAIpAQ8RNyK8QwkE+8RcyszSKUMkM+Umls+giZnx1VvygRx4AdaaJJsKqWyxEKQeO
         DOdA==
X-Gm-Message-State: AGRZ1gLnwr98jStT4CNeezknGir6xDz6qy49Ozr48RxSHU5alVnCrfYw
        0XKF2JgH9vB55SetfbOj4Fo=
X-Google-Smtp-Source: AJdET5cUtDDi585l1StLGlZphTSYAoIo/YqXEf/sDYk8ijw4ADs1VBa6Rmuac8oHPrBHCAHlwSe4nw==
X-Received: by 2002:a17:902:4624:: with SMTP id o33-v6mr3895422pld.285.1541670392680;
        Thu, 08 Nov 2018 01:46:32 -0800 (PST)
Received: from localhost.localdomain ([2405:204:54a3:4742:28e4:be46:8b17:69ab])
        by smtp.gmail.com with ESMTPSA id d126-v6sm4881728pgc.32.2018.11.08.01.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 01:46:31 -0800 (PST)
From:   Suraj Singh <suraj1998@gmail.com>
To:     davem@davemloft.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        suraj1998@gmail.com
Subject: [PATCH] staging: net: ipv4: tcp_westwood: fixed warnings and checks
Date:   Thu,  8 Nov 2018 15:16:17 +0530
Message-Id: <1541670377-17483-1-git-send-email-suraj1998@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541425985-31869-1-git-send-email-suraj1998@gmail.com>
References: <1541425985-31869-1-git-send-email-suraj1998@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed warnings and checks for TCP Westwood

Signed-off-by: Suraj Singh <suraj1998@gmail.com>
---
 net/ipv4/tcp_westwood.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/tcp_westwood.c b/net/ipv4/tcp_westwood.c
index bec9caf..8879152 100644
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
@@ -73,8 +72,7 @@ static void tcp_westwood_init(struct sock *sk)
 	w->first_ack = 1;
 }
 
-/*
- * @westwood_do_filter
+/* @westwood_do_filter
  * Low-pass filter. Implemented using constant coefficients.
  */
 static inline u32 westwood_do_filter(u32 a, u32 b)
@@ -94,8 +92,7 @@ static void westwood_filter(struct westwood *w, u32 delta)
 	}
 }
 
-/*
- * @westwood_pkts_acked
+/* @westwood_pkts_acked
  * Called after processing group of packets.
  * but all westwood needs is the last sample of srtt.
  */
@@ -108,8 +105,7 @@ static void tcp_westwood_pkts_acked(struct sock *sk,
 		w->rtt = usecs_to_jiffies(sample->rtt_us);
 }
 
-/*
- * @westwood_update_window
+/* @westwood_update_window
  * It updates RTT evaluation window if it is the right moment to do
  * it. If so it calls filter for evaluating bandwidth.
  */
@@ -127,8 +123,7 @@ static void westwood_update_window(struct sock *sk)
 		w->first_ack = 0;
 	}
 
-	/*
-	 * See if a RTT-window has passed.
+	/* See if a RTT-window has passed.
 	 * Be careful since if RTT is less than
 	 * 50ms we don't filter but we continue 'building the sample'.
 	 * This minimum limit was chosen since an estimation on small
@@ -149,12 +144,12 @@ static inline void update_rtt_min(struct westwood *w)
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
@@ -171,8 +166,7 @@ static inline void westwood_fast_bw(struct sock *sk)
 	update_rtt_min(w);
 }
 
-/*
- * @westwood_acked_count
+/* @westwood_acked_count
  * This function evaluates cumul_ack for evaluating bk in case of
  * delayed or partial acks.
  */
@@ -207,8 +201,7 @@ static inline u32 westwood_acked_count(struct sock *sk)
 	return w->cumul_ack;
 }
 
-/*
- * TCP Westwood
+/* TCP Westwood
  * Here limit is evaluated as Bw estimation*RTTmin (for obtaining it
  * in packets we use mss_cache). Rttmin is guaranteed to be >= 2
  * so avoids ever returning 0.
-- 
2.7.4

