Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4305ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C31HiFon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6425B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbeGRBWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:22:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45416 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeGRBWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:22:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id 94-v6so1191253ple.12;
        Tue, 17 Jul 2018 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RqJusamQIL7japm3Kmcrl0lH6/aiRAPCWoDSN4NNiGQ=;
        b=C31HiFonyGr7EeRX8YopLTvlvpT9oLlEpigN0Ai0jqCx56XL5HdEKhAjADw70xGJdl
         QQRhIWy9ssGzFrjAsbaYlDJoQQ41qbmXcnfozFR1D2rpv5/F5L+8vvDfcmpBzQuynbjK
         zc7SlONbcb+O6wRPaogk8aB13VBgAAan0qAI7iYX9Ejgz7hrY/3etHaRTqvmf6hRyTIb
         WuvKidhR7rN1IlNQmNvCf1QZf12vNc+Zgs0/fpKdqmfH/DwbG6Fu7Qy18xlApdYwGmuj
         qhuqgjb9TQrbBtGHkYEkaAXw7kUTiN0UXF1UI707GZ006L3CkOaCSsbk8WXYkb20rfk+
         maXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RqJusamQIL7japm3Kmcrl0lH6/aiRAPCWoDSN4NNiGQ=;
        b=IVYmK1jqJJezSTec/cZ54/jRU/zwzW8GYvDKHPwKnNqxT0X0u+sW5HbkxuGF6o2i2k
         ZJ+YHVjldj/TOb4kGKnO4z3AHf05hPV0w6cpUwK9BCmLLGGTSY5akTBHEEA2STsbxKnf
         hg8t05qpFikhusYuYQNE8+R1N2PD8Fmy+4gIkV4mr1VM8zHtmAMUKyP603ZHq2A/+egd
         0bXOPmXFvbNPstya2XIQbaxn91epC0e/tahX8BiPV7Uni2CQTeaGi5399vJyOxHo/OsR
         d43xwa3aOt1QWyoOzeJ4tyLGu37+5JFV0uCte/UPoDOC7eAJJtIE7UMHmiNOT8hkNjgq
         0/BQ==
X-Gm-Message-State: AOUpUlHRrVT9RvDvAtMlwI/7mvHs1VUVy4kKxj+ldh2//jIGCM5P1dje
        xVX27DE0RK2vUr4FPTn9Z/o=
X-Google-Smtp-Source: AAOMgpdF3QqoW7tCLk1zJwi0AMfLhIbMYkhB17BQ9YT7w9kg3cC1apgTALX3McDqVsiluF7Y3jR/Og==
X-Received: by 2002:a17:902:bd93:: with SMTP id q19-v6mr3684132pls.238.1531874846984;
        Tue, 17 Jul 2018 17:47:26 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com ([61.68.123.183])
        by smtp.gmail.com with ESMTPSA id b62-v6sm9190775pfm.97.2018.07.17.17.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:47:25 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, eric.dumazet@gmail.com, ncardwell@google.com,
        David.Laight@aculab.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: tcp: Add tcp_clamp_rto_to_user_timeout() helper to improve accuracy
Date:   Wed, 18 Jul 2018 10:46:39 +1000
Message-Id: <20180718004639.30154-4-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the tcp_clamp_rto_to_user_timeout() helper routine. To calculate
the correct rto, so that the TCP_USER_TIMEOUT socket option is more 
accurate. Taking suggestions and feedback into account from 
Eric Dumazet, Neal Cardwell and David Laight. Due to the 1st commit we 
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

