Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B00920877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYlmg6tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B00920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeGQEri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:47:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37345 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeGQEri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:47:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so1509224pgq.4;
        Mon, 16 Jul 2018 21:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uezl3azdLh5Sn3GBd4B2FPxH2OfjuvczCIc/zDDjr40=;
        b=EYlmg6tn1w3m9q/Ye+ZRGs5EPAsF78rF7apSUJTpeec5zJWJELaXw0vkR/+OtwjKM+
         sqyIKFP1g71RFgDrJRQccDHCvkhVujiHa2I6d0tMgHblq/tmDGodcgi2ryFIwcrAtU8I
         aiO6itf8D8rtkg1ODXe8snpVpQpe97+dlsGidqr48OMY/TIIflOx4IiqUHCAi4/puvqm
         dzaMkBz2BAv9LgA7+CbUjWp6+7P1u2rJUeEZKVtsxH5+sSE/LHCFygGKXAeA7w4RORw8
         h4gn9eG0uHqObqxZn7zOS4tz6F3h7T3v9RalHchekkdWgC+SnOwtN+X+ODAEEqsHueWx
         ESRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uezl3azdLh5Sn3GBd4B2FPxH2OfjuvczCIc/zDDjr40=;
        b=X3Ypzfh1ik5sSW+DA4IRvy0XWTtj5OfcTygwFGIpHMziTh4k4EunL5j/t7J/b+kgxU
         ZK9BUvHMtGOTQ+/awApPlGd7hgyPnMi/nwBPmKS9hfg3v2XE+fu/FqINOHMUEugt0vrW
         nOc4sjliUiWe64VMoJApkeATO83vlZC496a5sqhVpR6nGPE+VYCJtn8fpDP7wHuMN+4F
         85QYrCWP9GW1wUEET/X3s9s0JHkx4Evc2+7MGOglJC7daJEvjbyENonCQglzs485ZeR5
         PecTm2hrg4gsuQmkhAUQYrM7+IdYIGwW1OazeGC1VgafgJvPK99GjSodynZS0Ng0TPpS
         Rysg==
X-Gm-Message-State: AOUpUlHit7ymxTHzHDUGbBzFB2CojYgPQOYhYc/u10aIhC8b6eYGZn2y
        sx4sZ8+HzCQ16+f43H98zNc=
X-Google-Smtp-Source: AAOMgpd5Fm1Ci+2RnTi88wVfyT90n7iOe6GaCn3glXussBhkDhcPvu9qNu7w+RoJ+VxyL2Vf0tXbyw==
X-Received: by 2002:a63:2644:: with SMTP id m65-v6mr17773476pgm.371.1531801024075;
        Mon, 16 Jul 2018 21:17:04 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com (14-202-218-81.tpgi.com.au. [14.202.218.81])
        by smtp.gmail.com with ESMTPSA id v30-v6sm72135915pgn.80.2018.07.16.21.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:17:02 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH net-next v1 3/3] tcp: convert icsk_user_timeout from jiffies to msecs
Date:   Tue, 17 Jul 2018 14:16:02 +1000
Message-Id: <20180717041602.31100-4-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 fixes line wrap of min_t().

The final patch in this series. Create the tcp_clamp_rto_to_user_timeout() 
helper routine. To calculate the correct rto, so that the TCP_USER_TIMEOUT 
socket option is more accurate. Taking suggestions and feedback into account 
from Eric Dumazet, Neal Cardwell and David Laight. Due to the 1st commit we 
can avoid the msecs_to_jiffies() and jiffies_to_msecs() dance.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/ipv4/tcp_timer.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d212f183dd2d..a242f8874629 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -36,6 +36,21 @@ u32 tcp_retransmit_stamp(const struct sock *sk)
 	return start_ts;
 }
 
+static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 elapsed, start_ts;
+
+	start_ts = tcp_retransmit_stamp(sk);
+	if (!icsk->icsk_user_timeout || !start_ts)
+		return icsk->icsk_rto;
+	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
+	if (elapsed >= icsk->icsk_user_timeout)
+		return 1; /* user timeout has passed; fire ASAP */
+	else
+		return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(icsk->icsk_user_timeout - elapsed));
+}
+
 /**
  *  tcp_write_err() - close socket and save error info
  *  @sk:  The socket the error has appeared on.
@@ -544,7 +559,8 @@ void tcp_retransmit_timer(struct sock *sk)
 		/* Use normal (exponential) backoff */
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
 	}
-	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, icsk->icsk_rto, TCP_RTO_MAX);
+	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
+				  tcp_clamp_rto_to_user_timeout(sk), TCP_RTO_MAX);
 	if (retransmits_timed_out(sk, net->ipv4.sysctl_tcp_retries1 + 1, 0))
 		__sk_dst_reset(sk);
 
-- 
2.13.6

