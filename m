Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04920C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DB520C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouA9hr5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DB520C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbeGLAn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:43:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43156 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732617AbeGLAn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:43:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id v13-v6so3368918pgr.10;
        Wed, 11 Jul 2018 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QQx5GUOJSEuuE3kWdLWdNlTZN80TLXfY5U3KhTXiau8=;
        b=ouA9hr5MMdYcO1m/VcPhTNmAas6daSVGe+NavdmFIoZHIii0G8HH43p22D29fIdhAh
         eP/Ebr6h6Zu/gzeyxVyEBRAYDzYtu5VsCD4NTm8foY+gCRzbqXq2Lh1Y3xqSwJqyDtM5
         wZiSdwGbxmklDGlFe8UY79x5qBddzKS9390onhREpllFhpNJrDFFGNdMVHVdy3b7ABps
         qsV8VWh++t+UySF1cBiFfOx6df3tvnVWzLqJ2GTBkyJ6uz8Oo7W+azRm4NFYIeRWzCWD
         4Mjpy81b9BJ/Pf6gZ7mpMIbDv2EhjkXsIS7b2IDNqBqV4K4SHWgLSQILH28zwV/k/n9v
         ij7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QQx5GUOJSEuuE3kWdLWdNlTZN80TLXfY5U3KhTXiau8=;
        b=ejj3EQdnsRjhF8g3ETRQm1oxWfUmRb969Mi9jQM783ZSNhu0gxzmQPwoSEYQcgA2Vk
         fDEB3LkCFNYNEe/Qh01hBAQaUYOQ7Nxy4YJSCYEGHDWur91lasMZblQKmi/udnkuLX3o
         kyL90+4/TkZK334zZ3xTRLZCddmf54Va2gpq9t42+g3J4Ouldl522Bh8723mIhguZOeN
         tyCj37qiMFvNa7cuNVhcRWNSCQB4bDUC0ywCoM6cfcZzyuKCSnt+XnpHriMWdkjQUEcR
         keQW+q7oT+vkBUASRCvfJJT9+Fn9XJQ9otw8yWS1H4edzg/NZjKUFEbYnTbIrkpNIAjj
         Meaw==
X-Gm-Message-State: AOUpUlHPcmaM1ebEPlhRh1X686MC1ndltSQ4gOFDLP+QYqM3xXhA0q7P
        7yazhdGDUwmKbIl3xUwBCMx88eoN
X-Google-Smtp-Source: AAOMgpe8SHwUEcg3TAZYllu2cU8yQPLSIqQkQH/uHVNZCYl5tQBW3uQBGz0tRGGn1tPXRCABJclgSQ==
X-Received: by 2002:a62:9042:: with SMTP id a63-v6mr104468pfe.52.1531355823475;
        Wed, 11 Jul 2018 17:37:03 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com (121.243.221.203.dial.dynamic.acc02-aubu-gou.comindico.com.au. [203.221.243.121])
        by smtp.gmail.com with ESMTPSA id z11-v6sm16981646pff.162.2018.07.11.17.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 17:37:02 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [net-next, 1/3] tcp: convert icsk_user_timeout from jiffies to msecs
Date:   Thu, 12 Jul 2018 10:36:25 +1000
Message-Id: <20180712003625.2551-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for an upcoming patch that improves the socket
TCP_USER_TIMEOUT option accuracy. Implement Eric Dumazets idea to convert 
icsk->icsk_user_timeout from jiffies to msecs. To eliminate the 
msecs_to_jiffies() and jiffies_to_msecs() dance in future. 

There will 3 patches in this series. [net-next, 2/3] will create a seperate 
helper routine called tcp_retransmit_stamp() as per Neal Cardwells suggestion. 
Finally [net-next, 3/3] will implement a new routine called 
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

