Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35779ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7C420877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/0gJnR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7C420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeGQErb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:47:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44915 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeGQEra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:47:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so8391249pgp.11;
        Mon, 16 Jul 2018 21:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hUXxUhSxD5PkHE46++U5JcnIKk4Odh7gkgebdsTHbLY=;
        b=G/0gJnR3N7nIoSX8xhAGdj6n3JydmB6TVEHLxkNJXgNJtvDMTtbimo0IwnXrHez7ym
         Hq7WTRbJJPdtzMLLvEz/zC5yX2QOeT/sTdE5HKR0fIFhS4B2iHAHQOGqiJfgc+oqdUxu
         WSdidYC8WfUhIx95yp5eFtI7wg9fDPF+N21233pL4Wv8K2t51YmV0OT4htcoB1zf1Q3g
         +jBIFL1ZudOkviEfa5xZ144HJKI+hqemc7xD72BjtojWttzeZH4gMU65Q/qmtVreFt98
         0dbTv1mfzp1JXkWpYkENkpt7+QGo09L85ZM4bvlemITb1hCanZ45+rSW9w69BCHBFoMm
         advg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hUXxUhSxD5PkHE46++U5JcnIKk4Odh7gkgebdsTHbLY=;
        b=CKGUOjQh3S64CNB4twdijFpYbxxNveGSPjDXq+u22UuczYnLRSA3kt7KFdCstKCw5A
         mIQboM8WEMxS8znRQbJkx6k1/8Vek9gK4yvM1nwPgwqqsqkUlUa+2xd1A2NgJs6zVsNr
         z8vwkgVS+rFqB09zZncMnCCAAy8cjF3wH1K/xK5UKbAFmZtbUSHxJV6XPNSZF6oOdoGA
         TcoRRWWHdW+ka3tiS9Qz9KEuvqs+n2/YC5H2vVihKhEfjpNabEiKcDnOPZepqyDEAJt5
         /LosrPhySX8xb4kvfeW5H4TMa7ZpIn9+fxAPtuj+HVpDrmA8sBaqE3SJFE56SfniBfV1
         XfhQ==
X-Gm-Message-State: AOUpUlGoAk+PRKJHe0Y94mFz2X5cOl/FBJf5AjKmI3jQN67hLkPSMl9H
        zTqqPVMI2/3JiEqEpyPqTMs=
X-Google-Smtp-Source: AAOMgpeoC+v2coW5NsUJIfOfAOgs0WdwZHf2yorBEjTqgFK7w8xwykFLpGMLYn1/sdqYcda5bj3+Ew==
X-Received: by 2002:a63:6b03:: with SMTP id g3-v6mr18053806pgc.57.1531801016523;
        Mon, 16 Jul 2018 21:16:56 -0700 (PDT)
Received: from 192-168-1-101.tpgi.com.com (14-202-218-81.tpgi.com.au. [14.202.218.81])
        by smtp.gmail.com with ESMTPSA id v30-v6sm72135915pgn.80.2018.07.16.21.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:16:55 -0700 (PDT)
From:   Jon Maxwell <jmaxwell37@gmail.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH net-next v1 2/3] tcp: convert icsk_user_timeout from jiffies to msecs
Date:   Tue, 17 Jul 2018 14:16:01 +1000
Message-Id: <20180717041602.31100-3-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 fixes fuzzy Indentation.

Create a seperate helper routine called tcp_retransmit_stamp() as per Neal 
Cardwells suggestion. To be used by the final commit in this series and 
retransmits_timed_out().

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

