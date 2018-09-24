Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1116ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF962086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJvlIyFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF962086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbeIXS77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:59:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37240 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbeIXS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:59:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so2125693pgq.4;
        Mon, 24 Sep 2018 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4OR+7QjftOZzjGgAgxRBxdeRcGac0vGVIHllmaTmn24=;
        b=MJvlIyFFP6qGwKh2PoHXhAO83FBBUusjFrfPZJ565c0wMvMf4R+HhjlcWM3oQjrYCP
         e5HlVla5Gb8315MDVDohgrUHwMxhEY8c03+6LyyoSKQr5iBPkSgX4q9zZs1P2uIbtki2
         4HvytkSW00Wj7S2w21QsGIYV+qMzz78k3SbgoK5V4E8S7xv2YBJ0F/+Qafrpxsc2v+kM
         SxWam4h8VFs+my92bF5EPEzfp8m94+gzclCKXFTfG1yH/U/YCjnjofOd5t8wpSMpbZOE
         CtHirUGURUcTV0CgNLodkDVhdzNp+G9D63nos11rYzJMrjDCm5bDV3Ue8weNuouZ0X9s
         aguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4OR+7QjftOZzjGgAgxRBxdeRcGac0vGVIHllmaTmn24=;
        b=aMtbb93YhtT92568Y3qalKHkh/cmxEv8Urb96N76AfFuacr7Vis5x0h+zeJ17fn9To
         +xJOJp7aaVzlXfB4mAMCK6wsrtrSr/0i/uYt17efcFLwURLowrC2lL4Cx62rS2eAMiQq
         CiH9mphT8nbTS7UGCJM0evbuPWYwyjCQQp6MtRv1v/HM8sgAlE1rGjlIgjGoiR7sWljW
         SHb3nuPpO267uKbna37mD13eWMop4rq9Nm+qeEoP9oCGU0fkddCp+nYBXJB1r7B8Olyf
         0Nm/Hzu8XjGi6AB08QzOFSMMc8NzSt4plPgUOtdiBcYswLGh5hEffMfnYRLTf9FRybru
         UgmA==
X-Gm-Message-State: ABuFfoicIV8gWbc42IAHHW6+AG0i9GFODPccGMOAWHJYzSi2lpAGl1/5
        aB4xSnfG24lH0iTnHd1GYQI=
X-Google-Smtp-Source: ACcGV61lh5oZars+8rpNELxRWM2575h0U2YYMALvbeqPsSXOjN5cXfQZgVU+G0vsrA057UuGngd/rg==
X-Received: by 2002:a63:28c7:: with SMTP id o190-v6mr9459230pgo.84.1537793875118;
        Mon, 24 Sep 2018 05:57:55 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id u25-v6sm48679555pfk.177.2018.09.24.05.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 05:57:54 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 net-next] tcp: expose sk_state in tcp_retransmit_skb tracepoint
Date:   Mon, 24 Sep 2018 20:57:29 +0800
Message-Id: <1537793849-32396-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After sk_state exposed, we can get in which state this retransmission
occurs. That could give us more detail for dignostic.
For example, if this retransmission occurs in SYN_SENT state, it may
also indicates that the syn packet may be dropped on the remote peer due
to syn backlog queue full and then we could check the remote peer.

BTW,SYNACK retransmission is traced in tcp_retransmit_synack tracepoint.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/tcp.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index ac55b32..2bc9960 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -56,6 +56,7 @@
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
 		__field(const void *, skaddr)
+		__field(int, state)
 		__field(__u16, sport)
 		__field(__u16, dport)
 		__array(__u8, saddr, 4)
@@ -70,6 +71,7 @@
 
 		__entry->skbaddr = skb;
 		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
 
 		__entry->sport = ntohs(inet->inet_sport);
 		__entry->dport = ntohs(inet->inet_dport);
@@ -84,9 +86,10 @@
 			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
-	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c",
+	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s\n",
 		  __entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
-		  __entry->saddr_v6, __entry->daddr_v6)
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  show_tcp_state_name(__entry->state))
 );
 
 DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
-- 
1.8.3.1

