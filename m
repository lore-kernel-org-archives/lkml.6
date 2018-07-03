Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01DBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5755E24F76
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLSZlBEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5755E24F76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932248AbeGCBRv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:17:51 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34311 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932098AbeGCBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:17:49 -0400
Received: by mail-pf0-f174.google.com with SMTP id e10-v6so156863pfn.1;
        Mon, 02 Jul 2018 18:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TRFijuv2DkpGYaIiCitgQnloeHIS2Toj7e9lhhstwTQ=;
        b=oLSZlBEzEWzVqaglmcOZycUcrXeHzt3ztYnr/ucFRf62UehyINlSUJ8wqzVgQvlzHP
         vhkMBGKetENlxz59XEnSLi76KHsLIfU82kNOexLmO67G2d70RlGdxIbVHdME9fTxEVqF
         xpWcQAh/APtRq57M5H+Bs1G93fuGO5QN22zmW/ETi9DAXBuI/qLgUWDTvmipr/+CDWOX
         CLC4Wq76+NPbdcy0Jdwb28wf+LckP0J7MgwoJWdsD7vCEN9fkf2290834cmLDMqIejMj
         phvDVd2Q3U7v+E/eMZyPgutcz+rmPd0eE7mz4quCCIpAZd/DCzrpn5fZHcFp9+vYTPDW
         6UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TRFijuv2DkpGYaIiCitgQnloeHIS2Toj7e9lhhstwTQ=;
        b=ZgAcJriFVXAIVwfUW6bfEKsDIRkUlrIpUzY8usmb7iUseec/+VaenUY45NY9eI9odG
         jj1Ad7xqBFvttWG2Ic2jbARJ+NLL2RFzcD6Ya5yPiZ5LdaV+o3KZtZmIukkr/v1QOxDY
         s6kaUv3QK7EiLPJUmGQnFrO5QavVxYRq4dkOrVvgZLCinuPoUCEXlF81BF6Wv/0AP3MM
         mIH9J5REHc8nRZiPsR//S5Ggsu6/7NziWPpiPLdfDhmRLs49rZcrfDP4567L73wye63J
         4LpP3PHM61/6BBhgX3TPgCNEMfeGQSJMUfKgKucKZADI5Ef4/76dG+itFDyYbWQoP5dn
         Tdpg==
X-Gm-Message-State: APt69E116yL2vyOD/syB/EJY7vRrh49OIBft/v3PBscvnSQ2zS+2O8We
        rJjrNOOT+kZRf8scrRvhJyIRum8Q
X-Google-Smtp-Source: AAOMgpd8GrmO5DY1RjQk2MGHxuaWfP0owTpDO/7f8CG4JjI/n/k2+BZ7Y8ZOR4mJJAUTWChE7xgUsg==
X-Received: by 2002:a62:33c4:: with SMTP id z187-v6mr27699453pfz.190.1530580668747;
        Mon, 02 Jul 2018 18:17:48 -0700 (PDT)
Received: from 192-168-1-6.tpgi.com.com (110-175-8-199.static.tpgi.com.au. [110.175.8.199])
        by smtp.gmail.com with ESMTPSA id h12-v6sm25202970pfi.114.2018.07.02.18.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 18:17:47 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH net-next] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
Date:   Tue,  3 Jul 2018 11:17:26 +1000
Message-Id: <20180703011726.8301-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fix this by recalculating the last retransmit interval so that it fires when
the timeout should occur. Only implement when icsk->icsk_user_timeout is set. 

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
 net/ipv4/tcp_timer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3b3611729928..94491a481722 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -407,6 +407,7 @@ void tcp_retransmit_timer(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
+	__u32 time_remaining = 0;
 
 	if (tp->fastopen_rsk) {
 		WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
@@ -535,6 +536,12 @@ void tcp_retransmit_timer(struct sock *sk)
 		/* Use normal (exponential) backoff */
 		icsk->icsk_rto = min(icsk->icsk_rto << 1, TCP_RTO_MAX);
 	}
+	if (icsk->icsk_user_timeout) {
+		time_remaining = jiffies_to_msecs(icsk->icsk_user_timeout) -
+			       (tcp_time_stamp(tcp_sk(sk)) - tcp_sk(sk)->retrans_stamp);
+		if (time_remaining < icsk->icsk_rto)
+			icsk->icsk_rto = time_remaining;
+	}
 	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS, icsk->icsk_rto, TCP_RTO_MAX);
 	if (retransmits_timed_out(sk, net->ipv4.sysctl_tcp_retries1 + 1, 0))
 		__sk_dst_reset(sk);
-- 
2.13.6

