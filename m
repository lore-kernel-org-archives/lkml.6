Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B6BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F224C2147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANfDgVTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F224C2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbeGMBBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:01:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37531 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbeGMBBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:01:52 -0400
Received: by mail-pf0-f196.google.com with SMTP id x10-v6so11708817pfm.4;
        Thu, 12 Jul 2018 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Q/O03xv8uh1OrJ2NRTdJd8jyTCyIaHohZUGPgBvi6Y=;
        b=ANfDgVTp7TbUNav9iNeDdaEGO6ofm2+uDJooVSOKM6UlBXkF7U41T7DP05ak7XsY2f
         HtXeGAKrcvtx3bAjuAxBHok8/ffc6epuXkWmb5Utdju4yHqGXyWrZt2nZeT8vre0d7fQ
         OswF44Njrif0V1AuT23O/u+YGwHqcqCJEusWnl+5xhpnKkqls+1EQI9Godo4GIGVOLt+
         9wtVpNavFO/AtVnplCryuDbSjBusMK823HSAKcSzm1M1GdiTGDArQFOOduThFsAvakxk
         82z8hHXdIk2Ltj5HT3pY9kRmRthkrMwiHH+Sd10HnCxjuWQPduSpNj0Dp8q4MKQa5v/v
         GwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Q/O03xv8uh1OrJ2NRTdJd8jyTCyIaHohZUGPgBvi6Y=;
        b=GQLyrKM2lJQk728wyA0amH1HFT62uq9apt9D1LJcnpUaEB+EOlWW4bbpG0si1pv86m
         Vf0gTcYrdBl6ha2aBrG/hxbKTCQpmpVu5u16GwFKABUwBFHZcjU0VNbxLfipKO2wVHlg
         41LjEeF2DjNtsH/vxYJmARg8lBjGR//f4a6uNmrFwo4YvYVw3it83GAxgQr0N5z/8ogp
         gjVYlGoz8T1cV7KCN82ffKeCEvlGYcY4T1pAO18DKyZnvEBTG9Kwy8saAOj/kQ7JYQNv
         Mluow565ntU5O0nh7q1roKk2soqmDNWS0izndPg5YqrnDjb8vdPsnnawgqKms/WHayWD
         ILJA==
X-Gm-Message-State: AOUpUlEzrh7ILjEFIGzliDDIfDiUe8IFGlHwesmjeF7E9a6nitCylW9n
        GVk+4rolLEVELzUrekNLHmA=
X-Google-Smtp-Source: AAOMgpdqVBglakAyOg4cBlgRVmAfoSuTLKsGY/XlZzSd0922BWC/kPDyJ0HaGgVHShjrq/tqjvy+HA==
X-Received: by 2002:a62:b29c:: with SMTP id z28-v6mr4753326pfl.8.1531442987042;
        Thu, 12 Jul 2018 17:49:47 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com ([61.68.54.151])
        by smtp.gmail.com with ESMTPSA id x6-v6sm59070068pfe.30.2018.07.12.17.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 17:49:46 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [net-next, 3/3] tcp: convert icsk_user_timeout from jiffies to msecs
Date:   Fri, 13 Jul 2018 10:49:19 +1000
Message-Id: <20180713004919.18608-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final patch in this series. Create the tcp_clamp_rto_to_user_timeout() 
helper routine. To calculate the correct rto, so that the TCP_USER_TIMEOUT 
socket option is more accurate. Taking suggestions and feedback into account 
from Eric Dumazet, Neal Cardwell and David Laight. Due to the 1st commit we 
can avoid the msecs_to_jiffies() and jiffies_to_msecs() dance.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/ipv4/tcp_timer.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 8ab8c9645294..d4d4b30a6bec 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -36,6 +36,22 @@ u32 tcp_retransmit_stamp(const struct sock *sk)
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
+		return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(icsk->icsk_user_timeout -
+			     elapsed));
+}
+
 /**
  *  tcp_write_err() - close socket and save error info
  *  @sk:  The socket the error has appeared on.
@@ -544,7 +560,8 @@ void tcp_retransmit_timer(struct sock *sk)
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

