Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4307EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23A82244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olwnib4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23A82244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeGCHVt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:21:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37777 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932802AbeGCHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:21:45 -0400
Received: by mail-pg0-f67.google.com with SMTP id n15-v6so544119pgv.4;
        Tue, 03 Jul 2018 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x6HXHTplj+rIQX0w5BchTHnLTXNSal+2XrkPwJFDkPk=;
        b=olwnib4uXYIcpeIE99asw7gtl74LMiDTzTHQVn07ReXeJLnsQsRwELiJxKyxvCm5QZ
         gZqx3M36nn/NAUS50x6csBqdrsYKf/PRMT3x33X913hEQ2ntWLZu3dWh88m5/T0UnJxq
         Y31VyfjHHnk1XoAK584lIs13jqMIDg4gyeobNWcanEMJk2Phz1iXrLqUD+JxSzSozat1
         qoRFI2PKJD1N5cBtY27pPdfpbfTs386i7/jmYtBphIV2HKD/Uj7cBgua4mMvkdgI7ZL+
         OjNTZ3dbpssM4J4m/MhITeVP13gpZiOxWMTlmATsP06N/ELkewtqgVodaLuQyEc5Wpd4
         2dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x6HXHTplj+rIQX0w5BchTHnLTXNSal+2XrkPwJFDkPk=;
        b=lItBXT2WiDESnjr/hE2xNEDvBrrJ6ujOiwuJWD29RrnFAXMQ5it8/ViNMpnEJhOvx7
         LBZSvRp7C2Yff17vx4leCeDV/HndK94cHz1z4hNHdocvi8mtwZDs1lIFlSqIApafH02/
         oIrmvsV7BeARaWKHaF6uPwwPxA2+/U/zxh3J17H0ZHm+mYuFPJPxZlgl1zq3Sr8P1WQI
         js8h2281VcJ23eewS6gf5m3vF8q2OERCl73aBFH8eZm/Yx7Im6uFr8C5qgRYt52EWhRI
         gIphWp9jvO6SrqNR06hs/rPSbcb0xRfGky6PZxemSbOi6LJkckrPVPXzSznjHKpsnw0Q
         53Xg==
X-Gm-Message-State: APt69E2VELt3kI596T1oCZ/0nNKzsjORd4xwmQiH8umkN21k01BvEDjI
        I9IvyYqfc0MjOIwEK3QouoQ=
X-Google-Smtp-Source: ADUXVKKGacbJ2hviVhU/lkauagetmUuW1aBcqQu//549uUAYl48unnQXPVh2quenC0VFcNaUWDCc8A==
X-Received: by 2002:a63:8c5:: with SMTP id 188-v6mr24126309pgi.97.1530602505051;
        Tue, 03 Jul 2018 00:21:45 -0700 (PDT)
Received: from 192-168-1-6.tpgi.com.com (110-175-8-199.static.tpgi.com.au. [110.175.8.199])
        by smtp.gmail.com with ESMTPSA id i12-v6sm1040956pgr.64.2018.07.03.00.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 00:21:43 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     ncardwell@google.com, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: [net-next,v1] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
Date:   Tue,  3 Jul 2018 17:21:13 +1000
Message-Id: <20180703072113.19910-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 contains the following suggestions by Neal Cardwell:

1) Fix up units mismatch regarding msec/jiffies.
2) Address possiblility of time_remaining being negative.
3) Add a helper routine to do the rto calculation.

Every time the TCP retransmission timer fires. It checks to see if there is a 
timeout before scheduling the next retransmit timer. The retransmit interval 
between each retransmission increases exponentially. The issue is that in order 
for the timeout to occur the retransmit timer needs to fire again. If the user 
timeout check happens after the 9th retransmit for example. It needs to wait for 
the 10th retransmit timer to fire in order to evaluate whether a timeout has 
occurred or not. If the interval is large enough then the timeout will be 
inaccurate.

For example with a TCP_USER_TIMEOUT of 10 seconds without patch:

1st retransmit:

22:25:18.973488 IP host1.49310 > host2.search-agent: Flags [.]

Last retransmit:

22:25:26.205499 IP host1.49310 > host2.search-agent: Flags [.]

Timeout:

send: Connection timed out
Sun Jul  1 22:25:34 EDT 2018

We can see that last retransmit took ~7 seconds. Which pushed the total 
timeout to ~15 seconds instead of the expected 10 seconds. This gets more 
inaccurate the larger the TCP_USER_TIMEOUT value. As the interval increases.

Add tcp_clamp_rto_to_user_timeout() to determine if the user rto has expired.
Or whether the rto interval needs to be recalculated. Use the original interval
if user rto is not set. 

Test results with the patch is the expected 10 second timeout:

1st retransmit:

01:37:59.022555 IP host1.49310 > host2.search-agent: Flags [.]

Last retransmit:

01:38:06.486558 IP host1.49310 > host2.search-agent: Flags [.]

Timeout:

send: Connection timed out
Mon Jul  2 01:38:09 EDT 2018

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/ipv4/tcp_timer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3b3611729928..82c2a3b3713c 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,23 @@
 #include <linux/gfp.h>
 #include <net/tcp.h>
 
+static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	__u32 rto = icsk->icsk_rto;
+	__u32 elapsed, user_timeout;
+
+	if (!icsk->icsk_user_timeout)
+		return rto;
+	elapsed = tcp_time_stamp(tcp_sk(sk)) - tcp_sk(sk)->retrans_stamp;
+	user_timeout = jiffies_to_msecs(icsk->icsk_user_timeout);
+	if (elapsed >= user_timeout)
+		rto = 1;  /* user timeout has passed; fire ASAP */
+	else
+		rto = min(rto, (__u32)msecs_to_jiffies(user_timeout - elapsed));
+	return rto;
+}
+
 /**
  *  tcp_write_err() - close socket and save error info
  *  @sk:  The socket the error has appeared on.
@@ -407,6 +424,7 @@ void tcp_retransmit_timer(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	__u32 rto;
 
 	if (tp->fastopen_rsk) {
 		WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
@@ -535,7 +553,8 @@ void tcp_retransmit_timer(struct sock *sk)
 		/* Use normal (exponential) backoff */
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
 	}
-	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, icsk->icsk_rto, TCP_RTO_MAX);
+	rto = tcp_clamp_rto_to_user_timeout(sk);
+	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, rto, TCP_RTO_MAX);
 	if (retransmits_timed_out(sk, net->ipv4.sysctl_tcp_retries1 + 1, 0))
 		__sk_dst_reset(sk);
 
-- 
2.13.6

