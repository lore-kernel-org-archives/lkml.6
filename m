Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC4EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB7A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2+j4jPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB7A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeGRBWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:22:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34175 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGRBWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:22:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id k19-v6so1325601pfi.1;
        Tue, 17 Jul 2018 17:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vNfuRr6So/jhUkF/7T0xI/28Y4qqh8tzZy1KJJ2JZhM=;
        b=U2+j4jPzNDXYJhj8gHKlOwCAkzAiZ8pk+eJnvN8gd8kUEwFhXkXKlY0EuRZKA5bFOM
         k1FbwsosR/5VHL1NQId3h8g7KD3+aXbnKyp+l/x0W7bp1Ejr43WuVKZ8wK0J1kCnH8v+
         wwfhqjGSAzqrs0KmSBQCRudggg+TRt5UHWLhY+t0uukNlrdXN8n+BXPGV7L1osLN9RvT
         RBwfMYhLOxE7kuThj19em9fmpPd5k26Gbln6aEF7W1o1C6mSCj4yjkYfjBqA4APH9gmP
         UEa+Ra6TrMWt8+BuGM6Jc8DtOAKPxonWXTgceb/FFrtwUQ/BKuWgiOeLVnTvp+fh1qW3
         sgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vNfuRr6So/jhUkF/7T0xI/28Y4qqh8tzZy1KJJ2JZhM=;
        b=r5Z56JnW73FzYXwrWe//wdxTRkWmSHcErxhWfXbv16zAz3M1bBZLXaCETAgQeV8rsP
         FemhmJHlzv1iDeCzMQAff9KUw3TmBfVhDZUQUHFL7ww8JdGN65NcbShBK7BNTR3hLZgK
         eu/STZ6PMKwgP4W+SUdnwxkdoUSViAPdOUcQEj84OsLpawCQd2D8P0Oq00RX+4KiZruX
         DsaCIMrAWLyNNgM8/LOFSmVRv1takQpqFMb++ZbMPQCci/ZgcoUMG92Z3765tN273O3V
         Xpf2ZLEs9ro3WdDDW2PNgECVsoGz2YnPOGPieUYTCcOzoJOcGnQoM3FayYN2+Q3wp8o8
         w+Dg==
X-Gm-Message-State: AOUpUlHb35CQWZhw2kBFzvkX0e9gz50O4fEwdfVTRQ9TjbOunArCy04C
        vC4oUJVPHHL2i+rZU32sRJk=
X-Google-Smtp-Source: AAOMgpdw4032N2jfpwSR7Eyj7EJDCrjJgsD5El7awKmdnX/bt4VYGzI6SByG//K/Cw39dunwF1WRzQ==
X-Received: by 2002:a65:5b8e:: with SMTP id i14-v6mr3664476pgr.242.1531874828683;
        Tue, 17 Jul 2018 17:47:08 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com ([61.68.123.183])
        by smtp.gmail.com with ESMTPSA id b62-v6sm9190775pfm.97.2018.07.17.17.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:47:07 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, eric.dumazet@gmail.com, ncardwell@google.com,
        David.Laight@aculab.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: tcp: convert icsk_user_timeout from jiffies to msecs
Date:   Wed, 18 Jul 2018 10:46:37 +1000
Message-Id: <20180718004639.30154-2-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit. Part of this series that improves the 
TCP_USER_TIMEOUT socket option accuracy. Implement Eric Dumazets idea 
to convert icsk->icsk_user_timeout from jiffies to msecs. To eliminate 
the msecs_to_jiffies() and jiffies_to_msecs() dance in future.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/ipv4/tcp.c       | 4 ++--
 net/ipv4/tcp_timer.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e3704a49164b..9d900162f16a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2984,7 +2984,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 		if (val < 0)
 			err = -EINVAL;
 		else
-			icsk->icsk_user_timeout = msecs_to_jiffies(val);
+			icsk->icsk_user_timeout = val;
 		break;
 
 	case TCP_FASTOPEN:
@@ -3440,7 +3440,7 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_USER_TIMEOUT:
-		val = jiffies_to_msecs(icsk->icsk_user_timeout);
+		val = icsk->icsk_user_timeout;
 		break;
 
 	case TCP_FASTOPEN:
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3b3611729928..fa34984d0b12 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -183,8 +183,9 @@ static bool retransmits_timed_out(struct sock *sk,
 		else
 			timeout = ((2 << linear_backoff_thresh) - 1) * rto_base +
 				(boundary - linear_backoff_thresh) * TCP_RTO_MAX;
+		timeout = jiffies_to_msecs(timeout);
 	}
-	return (tcp_time_stamp(tcp_sk(sk)) - start_ts) >= jiffies_to_msecs(timeout);
+	return (tcp_time_stamp(tcp_sk(sk)) - start_ts) >= timeout;
 }
 
 /* A write timeout has occurred. Process the after effects. */
@@ -337,8 +338,7 @@ static void tcp_probe_timer(struct sock *sk)
 	if (!start_ts)
 		skb->skb_mstamp = tp->tcp_mstamp;
 	else if (icsk->icsk_user_timeout &&
-		 (s32)(tcp_time_stamp(tp) - start_ts) >
-		 jiffies_to_msecs(icsk->icsk_user_timeout))
+		 (s32)(tcp_time_stamp(tp) - start_ts) > icsk->icsk_user_timeout)
 		goto abort;
 
 	max_probes = sock_net(sk)->ipv4.sysctl_tcp_retries2;
@@ -672,7 +672,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 		 * to determine when to timeout instead.
 		 */
 		if ((icsk->icsk_user_timeout != 0 &&
-		    elapsed >= icsk->icsk_user_timeout &&
+		    elapsed >= msecs_to_jiffies(icsk->icsk_user_timeout) &&
 		    icsk->icsk_probes_out > 0) ||
 		    (icsk->icsk_user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
-- 
2.13.6

