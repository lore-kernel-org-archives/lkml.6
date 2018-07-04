Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D4BC6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0047E24434
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2m5IPZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0047E24434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeGDAGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:06:43 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:46384 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbeGDAGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:06:40 -0400
Received: by mail-pf0-f172.google.com with SMTP id l123-v6so1740711pfl.13;
        Tue, 03 Jul 2018 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MFfHaKF2R7Xhw9hlx3obs9Uz6ResU7Al+XsBY/V2Th0=;
        b=I2m5IPZLb6zY1/eNfCzGSp7akx8254oIKLOxaByyKei6hMdJkIMAgH99zB2ZcsFZd9
         JK6dXPGRSdifB/O0TVa8irQEMISDElhpVGCVVcAc8Zqpo51G3gCuETEBeQzRLDNqtH1k
         U4P5KMu2QEl8BKXi7osSawz+tQ4ba1APyfMrEeEDjaJZLezcPDZ+U2Vj1hCDhhyhtkYD
         fAECL7Dfwk5UwovOI/Laza+C6pOtwU9YWmEvCDwHdkCU9004fW9ZCbn9XRN3qB+hzoeS
         SokiV1HaQ4QXpcSXXw0jEHrAqgWjhOMMA3L9p4Btr59J2vUlWJEfpmBnv0KPqXCvaVxl
         G7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MFfHaKF2R7Xhw9hlx3obs9Uz6ResU7Al+XsBY/V2Th0=;
        b=SS0l3oWgVzPq2GdLhoSvZoqaWZVNbusQ76X9LYYFoAyg2IB3oE2p7Dde8kLwpMDov/
         e0QQoOgBIqbPCTGcWzHhmfdxcQJgF+nDA2DP69ymbvugzVDcdXTK9TkVArkuP2GiFy+E
         ZJRjr5Jq0L9BPdGWDQiqPDlzVEdFmR/4HQhOOu0X9fLrs6ORX1FcnwgNOvNfPAo8G+dV
         rvCEz3d0zdnSoVeoJLDHQJ0u0HcOQmaowwLibUQVqTaOWeeBpMLoz0GzRfPsPy5tZZUz
         Okv2kKOWil4KSoZ2uB/1GGKBZZt7QSM/ZbmSM4SNFtaG7z1Zn03vgRpNlpxN4qXuTf0Q
         rOIg==
X-Gm-Message-State: APt69E3fbLEYwpBvL69MGq4QMUmH2buwNBi6WiKeei8XSkrJ3t83E22s
        /CPAM+uGdOEZ6Nnul8FFzKmozip3
X-Google-Smtp-Source: AAOMgpeKP3A12PXWXVsvwe+8ncIwGHC1ADshcAxqgflue5wZz4LQTzllqp8v2ZG4pK68J/zhL+FF9Q==
X-Received: by 2002:a62:40dc:: with SMTP id f89-v6mr31416509pfd.194.1530662799865;
        Tue, 03 Jul 2018 17:06:39 -0700 (PDT)
Received: from 192-168-1-6.tpgi.com.com (110-175-8-199.static.tpgi.com.au. [110.175.8.199])
        by smtp.gmail.com with ESMTPSA id 14-v6sm4124032pfw.19.2018.07.03.17.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 17:06:38 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     ncardwell@google.com, edumazet@google.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: [net-next,v2] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
Date:   Wed,  4 Jul 2018 10:06:08 +1000
Message-Id: <20180704000608.17360-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 contains the following suggestions by Neal Cardwell:

1) Fix up units mismatch regarding msec/jiffies.
2) Address possiblility of time_remaining being negative.
3) Add a helper routine tcp_clamp_rto_to_user_timeout() to do the rto 
calculation.
4) Move start_ts logic into helper routine tcp_retrans_stamp() to 
validate tcp_sk(sk)->retrans_stamp.

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
 net/ipv4/tcp_timer.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3b3611729928..d129e670d02a 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,39 @@
 #include <linux/gfp.h>
 #include <net/tcp.h>
 
+unsigned int tcp_retransmit_stamp(struct sock *sk)
+{
+	unsigned int start_ts = tcp_sk(sk)->retrans_stamp;
+
+	if (unlikely(!start_ts)) {
+		struct sk_buff *head = tcp_rtx_queue_head(sk);
+
+		if (!head)
+			return false;
+		start_ts = tcp_skb_timestamp(head);
+	}
+	return start_ts;
+}
+
+static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	__u32 rto = icsk->icsk_rto;
+	__u32 elapsed, user_timeout;
+	unsigned int start_ts;
+
+	start_ts = tcp_retransmit_stamp(sk);
+	if (!icsk->icsk_user_timeout || !start_ts)
+		return rto;
+	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
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
@@ -166,14 +199,9 @@ static bool retransmits_timed_out(struct sock *sk,
 	if (!inet_csk(sk)->icsk_retransmits)
 		return false;
 
-	start_ts = tcp_sk(sk)->retrans_stamp;
-	if (unlikely(!start_ts)) {
-		struct sk_buff *head = tcp_rtx_queue_head(sk);
-
-		if (!head)
-			return false;
-		start_ts = tcp_skb_timestamp(head);
-	}
+	start_ts = tcp_retransmit_stamp(sk);
+	if (!start_ts)
+		return false;
 
 	if (likely(timeout == 0)) {
 		linear_backoff_thresh = ilog2(TCP_RTO_MAX/rto_base);
@@ -407,6 +435,7 @@ void tcp_retransmit_timer(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	__u32 rto;
 
 	if (tp->fastopen_rsk) {
 		WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
@@ -535,7 +564,8 @@ void tcp_retransmit_timer(struct sock *sk)
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

