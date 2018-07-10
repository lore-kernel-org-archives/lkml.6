Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DA6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A7720779
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J02CkZ5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A7720779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933310AbeGJGw5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:52:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37710 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933127AbeGJGwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:52:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id n15-v6so1798169pgv.4;
        Mon, 09 Jul 2018 23:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6Dl6yPhzHrgqdO3XTFuP0JzmqCFNhNDpkWFbaoMG8SA=;
        b=J02CkZ5owb4C214CvO4wilTcZTnahXay50En2mVty8DytueLdOqr5mHuPTDIkt/4F4
         6Ei9l28naeAinGP1bEn5LCXG5JyvDsAV1OTmdbRYFDzMuzVsWow10471Jjqp5kMk8Znq
         4yDO6HE5a3RFBN0Srh4TZkV+Mvh/yKnAJ7zmP1Wxxx3Yfk6sdxVceRmzH+9BIaBzFVZH
         q35B3lCki89ZhFp6J1F17ThLJ6mqyhVxnuYwvTxY24XrGVscrQsyoMl1pWUUAzycsG2w
         tF2xuXNrkC6dhLItYy/jhCMoAiw0Ms1kIeQ6H6BoJ9Xw4D4i+9PWPr2mVWl8QmsIPj9W
         8gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Dl6yPhzHrgqdO3XTFuP0JzmqCFNhNDpkWFbaoMG8SA=;
        b=oAoRGjjgNjPya5aNi/v0W/9sAqQ1poB7hD5DHH8oNc1MZyxhnCueClpCOFEpdKDuXt
         oPYz0C/OtRyRxmTg9ESaLr6MKQiZmIAF89ArGAkOA1hDAGYeFAI+0uzoOtGaZUKIr60K
         O69MYNDC07mAfL1hmSbypita3i2alotSE/1rdjiNIDQsCExj0fwhX8TiczX9QRmjG1VP
         79Qxf5KiWLybqayi+W5ereQ/ZGbIAnWNiDYevG+AeCyqoJz9cxXm/8aojrhHRRrDQcXK
         WHvL8sZxTCbvp/UsHe2VYwtsMonvpsj7JNofajydgNaMSislMmzkqOKM6X5l+3Ojdqbl
         zW5A==
X-Gm-Message-State: APt69E0uTK+1+jEDPNCsFy/VB5EwNCK68yPil9ouNHCPCaKUUqPm4s/h
        MBlr+1tdpvtdlX/S4XD+fyX8K5Yp
X-Google-Smtp-Source: AAOMgpdOp2dPwI0DSUu0w5WL8pInWZ9Fd/q9PC/AiYfdoweuGbq3glZ7/nUclZAj9qdvsAPBq7J3cg==
X-Received: by 2002:a62:6882:: with SMTP id d124-v6mr24320960pfc.122.1531205549868;
        Mon, 09 Jul 2018 23:52:29 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com ([118.102.104.154])
        by smtp.gmail.com with ESMTPSA id y16-v6sm5497584pgc.73.2018.07.09.23.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 23:52:28 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, eric.dumazet@gmail.com, ncardwell@google.com,
        David.Laight@aculab.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: [net-next,v3] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
Date:   Tue, 10 Jul 2018 16:51:47 +1000
Message-Id: <20180710065147.27647-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 contains the following suggestions by Neal Cardwell:

1) Fix up units mismatch regarding msec/jiffies.
2) Address possiblility of time_remaining being negative.
3) Add a helper routine tcp_clamp_rto_to_user_timeout() to do the rto 
calculation.
4) Move start_ts logic into helper routine tcp_retrans_stamp() to 
validate tcp_sk(sk)->retrans_stamp.
5) Some u32 declation and return refactoring.
6) Return 0 instead of false in tcp_retransmit_stamp(), it's not a bool.

Suggestions by David Laight:

1) Don't cache rto in tcp_clamp_rto_to_user_timeout().
2) Use conditional operator instead of min_t() in 
tcp_clamp_rto_to_user_timeout()

Changes:

1) Call tcp_clamp_rto_to_user_timeout(sk) as an argument to 
inet_csk_reset_xmit_timer() to save on rto declaration.

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
 net/ipv4/tcp_timer.c | 49 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3b3611729928..93239e58776d 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,38 @@
 #include <linux/gfp.h>
 #include <net/tcp.h>
 
+u32 tcp_retransmit_stamp(struct sock *sk)
+{
+	u32 start_ts = tcp_sk(sk)->retrans_stamp;
+
+	if (unlikely(!start_ts)) {
+		struct sk_buff *head = tcp_rtx_queue_head(sk);
+
+		if (!head)
+			return 0;
+		start_ts = tcp_skb_timestamp(head);
+	}
+	return start_ts;
+}
+
+static __u32 tcp_clamp_rto_to_user_timeout(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	__u32 elapsed, user_timeout;
+	u32 start_ts;
+
+	start_ts = tcp_retransmit_stamp(sk);
+	if (!icsk->icsk_user_timeout || !start_ts)
+		return icsk->icsk_rto;
+	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
+	user_timeout = jiffies_to_msecs(icsk->icsk_user_timeout);
+	if (elapsed >= user_timeout)
+		return 1; /* user timeout has passed; fire ASAP */
+	else
+		return (icsk->icsk_rto < msecs_to_jiffies(user_timeout - elapsed)) ?
+			icsk->icsk_rto : msecs_to_jiffies(user_timeout - elapsed);
+}
+
 /**
  *  tcp_write_err() - close socket and save error info
  *  @sk:  The socket the error has appeared on.
@@ -161,19 +193,15 @@ static bool retransmits_timed_out(struct sock *sk,
 				  unsigned int timeout)
 {
 	const unsigned int rto_base = TCP_RTO_MIN;
-	unsigned int linear_backoff_thresh, start_ts;
+	unsigned int linear_backoff_thresh;
+	u32 start_ts;
 
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
@@ -535,7 +563,8 @@ void tcp_retransmit_timer(struct sock *sk)
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

