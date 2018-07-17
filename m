Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A114ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C587020877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq3mmePz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C587020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeGQErX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:47:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40382 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeGQErX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:47:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so8391231pgp.7;
        Mon, 16 Jul 2018 21:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AIUnlvdyC0NK5q4wd0AeNFsHrMdqUS1WTKMNnZhw0SY=;
        b=rq3mmePzl2GZfO1ysSjQhD0G+iAv4nj07LpFCSdsBj1aCCthEYFFJEF9Wd5iXiBFuT
         wIgJ9oFYe4KQ3MA6l+Ut1VUNLJT5XDbE7ifmB3K1TswzdudyP4vWZeM7yRCs9kunajRm
         YwjmcrVIDn+nTGABGUcAMna4lPjp/AePLSZghcPNUPX7CtMTAXV/y+QlTZ8DCEjYS8ST
         GcLaj2tFOlEl5s5mbuR/7pCAbIMRUl/G1jdHOg9ubWuyss9yAJj+RFcG83W9S5Ez+KUH
         FgeumjJsybaoMLpSqXCNjdM4HY/tJ9HpeKiA0DMLcF23Jy0tW7AttyWWV5s7MV6EmqC4
         tN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AIUnlvdyC0NK5q4wd0AeNFsHrMdqUS1WTKMNnZhw0SY=;
        b=TsJ1VUPDk6000iwHjql4WxrO7z9muxpt9VlXv01lCpAqwWTBsZ+UYEIQPxkCDj0ihb
         2eTQt6qfz2r2ts8ivLl9iAUOpX9qUmI7Tfv/rW5qp8aN1NLSrrLoQW4ehpzMt0D7cM+Z
         mwKJ5jsMQbD+ZnHc8pFbV8YzcoeLFnqQEcCGasmHLYVYm8K54Blt1fZh6k0b3PfLpJXc
         /UJrzQx0/R8W8UHEeWS9dINWTDmSgVU53aOv18Gk9h7yAeIKGM4Nb04F/5niCVIVpVXi
         Kiz+DRt4euExAKqZgBO7+e2lUlMwkcW+KjtFXUvTsGyGvdzcCgp3hWoh/q22x/RP5FkO
         BqeQ==
X-Gm-Message-State: AOUpUlHfc7pvnW6UhcxUsVfu8hj9gqVCFiCypGSO2BhXVflPMN2DOnXU
        Mcxwp7t6gZesPLCXiPMVnZk=
X-Google-Smtp-Source: AAOMgpcIpnCKX7sS6RkPyEM92YyDsAu3awgqxCpELUBjxaQDc2LamMtqFfVS5L32XZYZ9rF5Wiw2bg==
X-Received: by 2002:a63:9a01:: with SMTP id o1-v6mr17888551pge.439.1531801009090;
        Mon, 16 Jul 2018 21:16:49 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com (14-202-218-81.tpgi.com.au. [14.202.218.81])
        by smtp.gmail.com with ESMTPSA id v30-v6sm72135915pgn.80.2018.07.16.21.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:16:48 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH net-next 1/3] tcp: convert icsk_user_timeout from jiffies to msecs
Date:   Tue, 17 Jul 2018 14:16:00 +1000
Message-Id: <20180717041602.31100-2-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for an upcoming patch that improves the socket
TCP_USER_TIMEOUT option accuracy. Implement Eric Dumazets idea to convert 
icsk->icsk_user_timeout from jiffies to msecs. To eliminate the 
msecs_to_jiffies() and jiffies_to_msecs() dance in future. 

There will 3 patches in this series. [net-next v1 2/3] will create a seperate 
helper routine called tcp_retransmit_stamp() as per Neal Cardwells suggestion. 
Finally [net-next v1 3/3] will implement a new routine called 
tcp_clamp_rto_to_user_timeout() to calculate the rto so that TCP_USER_TIMEOUT
is more accurate. As a result of the final patch it won't have the 
msecs_to_jiffies() and jiffies_to_msecs() dance that David Laight was concerned
about.

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

