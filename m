Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099E9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A722F2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLp7AaOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A722F2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbeGMAPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:15:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45234 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbeGMAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:15:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id i26-v6so10102895pfo.12;
        Thu, 12 Jul 2018 17:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UlnLBq3OMUeir439IFNBYgEOZjYSe38xuIY4a7lzsY8=;
        b=ZLp7AaOcoFR342gi1TbRKXEbLYAMBmAHpz+44ZiwXWsQnQCDf3BRsU+UX3S2tkijZt
         GxMwBR2BtYgAuPVaQq3nbZjCywYAr8R1OjmZ5YvqBjPCqcjnl6knhceoUfaLADgapX/t
         2GWI76habEN3hhObNOrVzva7RwKxlQDyE2TTY1vmW4TuyfNSeKaL6v6F4QB8dhjJJgpD
         +sdOEOMKESWuXKZ1QCrAKk+Hrtwsxg6zfJhAc/V8e5GiSfWLOy+AiXXi4AyhXc3rLfN1
         1uDPgBeEPChmBb/mwpUsNBgd1cUADdJT20miVQ7NSwI/EsKe9nzw+zkQiGoqmwCPx4Lp
         RMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UlnLBq3OMUeir439IFNBYgEOZjYSe38xuIY4a7lzsY8=;
        b=Fc4GKZLTrxgAYeB0buBVKj2Lrnyd2IP6JbKGPoVB+ICbWl6O+5PW3fPlk2r1J2u9ML
         LITLNlHrlw+D8IMtbD1WTikvbKNjyBzw7MSr8Zy6zP3vFZFoawbmQsJMYfRQA5VaLzuV
         Y0WQVOgr/lwqXQyjtl5ddIoFBXLq4SItfEsD2rGU1LCsvOO+ZMFOlCbhkCSTqQDJ0PB8
         WQQ2mp4rAt6abVbXv9VK8xFMpz1JTeXFm+qywpbI7pYCLTmyJMAMrhuzN38gmoX51kLv
         h+vJrjLKtHK8WaiCAS7NuiSkxoUfozfUjCF8bwHVk/SRshrvRoSCjN7zD8gcOPImO1mm
         IIYg==
X-Gm-Message-State: AOUpUlFMuod8SwHsqe3ax01PAXJoIEWrZ9KlLz/NoXbQNBj9RWnzJE9s
        Ym2LvCU3lCM3I7DLK7BWGpI=
X-Google-Smtp-Source: AAOMgpfRv8mTNBYc4Jkh654sFfvMrRhVLvEi7HfylOwhYk3hLK/ZKLw7b460KiD1CXeWWpeQxRK/jQ==
X-Received: by 2002:a62:843:: with SMTP id c64-v6mr4547521pfd.14.1531440184292;
        Thu, 12 Jul 2018 17:03:04 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com ([61.68.54.151])
        by smtp.gmail.com with ESMTPSA id t21-v6sm13813083pfh.45.2018.07.12.17.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 17:03:03 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [net-next, 2/3] tcp: convert icsk_user_timeout from jiffies to msecs
Date:   Fri, 13 Jul 2018 10:02:41 +1000
Message-Id: <20180713000241.17608-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a seperate helper routine called tcp_retransmit_stamp() as per Neal 
Cardwells suggestion. To be used by the final commit in this series and 
retransmits_timed_out().

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/ipv4/tcp_timer.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index fa34984d0b12..8ab8c9645294 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -22,6 +22,20 @@
 #include <linux/gfp.h>
 #include <net/tcp.h>
 
+u32 tcp_retransmit_stamp(const struct sock *sk)
+{
+	u32 start_ts = tcp_sk(sk)->retrans_stamp;
+
+	if (unlikely(!start_ts)) {
+		struct sk_buff *head = tcp_rtx_queue_head(sk);
+
+	if (!head)
+		return 0;
+	start_ts = tcp_skb_timestamp(head);
+	}
+	return start_ts;
+}
+
 /**
  *  tcp_write_err() - close socket and save error info
  *  @sk:  The socket the error has appeared on.
@@ -166,14 +180,9 @@ static bool retransmits_timed_out(struct sock *sk,
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
-- 
2.13.6

