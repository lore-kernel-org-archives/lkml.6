Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21488ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7A02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjNhfcAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7A02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbeGRBW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:22:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37347 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbeGRBW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:22:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so1203526plc.4;
        Tue, 17 Jul 2018 17:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MYTRioSUhjVk7i1bOukYD6jQ9ixb9FQH+G1HinngLWg=;
        b=BjNhfcAmfCfcWtjL8Yn/vCNPbN4SI0qBofejJxWJNir71/UGzeM0nuzTJHSYJkwNod
         LWzJUPeiTBHGNp1JmcnP+1E1XI4STiUxz/lAB/P0uBBu14Iw6vHvFjVOOrbsKbhVre93
         xEYFqF0vTpCGgtjOiR36IT7v4g8abVamC04hQ3rjXTPg3q4riLrW5Hd2D7U1FD/4ficE
         6FEIbpFEgkeZHrjdbFvA7fLJRKATRhLAhX9VjEh1eJ8Z3ISGIeWX4R1xGXZFhXt45nZO
         BK25xkpWe04EQt2FTf7AZESYBExqS1IbSILSc5ESkWhwpfUN0iwU3p0pCXpGdxlcYhkU
         dR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MYTRioSUhjVk7i1bOukYD6jQ9ixb9FQH+G1HinngLWg=;
        b=i/XWdgNiJEt0kSsCSCdk4MHlSJ7GPm/sOd7r7lRDl/4tTfQRN7fFJ8ppBCYmG84F8H
         lb0DBzSKSwuPPWgJlbrvLHXKeFRyOi37nyEoToINbr+PkVYZeeAx7QUrSJ6kOJ9I7XO5
         0QWAhh345ZyxaHBnS+iT5S9KSfEhXpthAJ9bCPNT5fz2Dg/TR+hvJkCFtQTvOLUCQsuG
         gayiROG7mnCTWak2mlZE4Aa0mA2NeB7IANBwU6upiIe61XouaU+VrkFdeIBE5o68kypP
         BzOfkKOS4j6gF14pXaVfgzur11Fc2Hr1F6Z2hSuLGnps25ThtRUrzPwvTRMq/GkxRF4P
         8xGg==
X-Gm-Message-State: AOUpUlH8VDcmGxQtPUPsG7vMmxW4c5O1QQmkisOJKlLM8O6SPRSOiA6h
        EiDqOicnbMJQcUXf/wOgphw=
X-Google-Smtp-Source: AAOMgpfjokCCQtGsb/E8xaL8w8mNU7usEIao4ht0avvwlOPJ2lhRRzZgwy7HKao/5z8nWkAlFaNDBg==
X-Received: by 2002:a17:902:7c0a:: with SMTP id x10-v6mr3618413pll.77.1531874836371;
        Tue, 17 Jul 2018 17:47:16 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com ([61.68.123.183])
        by smtp.gmail.com with ESMTPSA id b62-v6sm9190775pfm.97.2018.07.17.17.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:47:15 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, eric.dumazet@gmail.com, ncardwell@google.com,
        David.Laight@aculab.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: tcp: Add tcp_retransmit_time() helper routine
Date:   Wed, 18 Jul 2018 10:46:38 +1000
Message-Id: <20180718004639.30154-3-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a seperate helper routine as per Neal Cardwells suggestion. To 
be used by the final commit in this series and retransmits_timed_out().

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/ipv4/tcp_timer.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index fa34984d0b12..d212f183dd2d 100644
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
+		if (!head)
+			return 0;
+		start_ts = tcp_skb_timestamp(head);
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

