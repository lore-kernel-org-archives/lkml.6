Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2DB43C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF36A204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuFXeFJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF36A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935391AbeFMLip (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:38:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37289 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935188AbeFMLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:38:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so1153594pgv.4;
        Wed, 13 Jun 2018 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AiAOhGc6/btvEwpfqfojLO2Bvebug21a4REIZ6DvWHs=;
        b=WuFXeFJIhVhYGnw9wltCVZ3+ir7Pne2E+urNplZlpd7lpQizusf+ryFxLUbLune134
         QEwE13utjH4NCZG/wHMIGoEUjFFKawDjLXAKJc5oMDGIk7ZgOofDwEKpV6BqQxXGX/lE
         kNPNolq9YjO9CllMgVPFERZIapPljtx28+9adbjdcTTIdL577eVHoj/FtAbDM4Q0OH2b
         kzQJHwayli8EMip0Qoe4aeJpISiBqFk+EDA3ZW1DKJEe+3mrHC4x+Q7XbNOau95aGhNm
         P6ASh2cYPHyrxzYkWuyxsIKNOAuq2He2w4o2IKQqMkYrn0+hkcOif2gP1mnfwAtmpPXv
         PWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AiAOhGc6/btvEwpfqfojLO2Bvebug21a4REIZ6DvWHs=;
        b=BFOIOBed3826s11ovebaCnJ9PIKBkJn5RoTq+ITegLUbR6WNu7cdsnV4ZKI+ahqka8
         rxp1S60SRhEJv1H8O8ujpiSmFgSpSDVh4yyZorCZiUwnD34gxGVM4VnKFt72nLw4mVAG
         MpboofObFK5nL3gaYBRK+7Cce7ZQ94YEZzo7MHrdO1I/jO8dzh9O+b02TacPOfJnTjzn
         KTIVAO1XuBryn0kFRD3QednGWP9fdSmfDq0bDzyHm9eOCYu69nvsEwU0QlqEgaFd30me
         tjTbs5edWHhotfCv+4iYS7Zyz00ZIHVhhgT98XU6JBNGErOOpmzZZ3RxiSAy7g6ydsNc
         xuMg==
X-Gm-Message-State: APt69E2BH0nsMJkv79F43qjc7rJgOkUqCYT6V04m2Ibb1DkEHBHHXWRp
        2pUTwLTc+eU6LId0rWpGbk4=
X-Google-Smtp-Source: ADUXVKIm5kYCBJqNc+9bDj2hqjLK5jQn3Bm6RA1OrW60vu25FLqfiiNx1x/hktFNBZ1y4cvOXfOmrQ==
X-Received: by 2002:a62:fb05:: with SMTP id x5-v6mr4601869pfm.210.1528889922839;
        Wed, 13 Jun 2018 04:38:42 -0700 (PDT)
Received: from bogon.didichuxing.com ([52.229.160.192])
        by smtp.gmail.com with ESMTPSA id h16-v6sm3625321pfn.80.2018.06.13.04.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 04:38:42 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: add SNMP counter for zero-window drops
Date:   Wed, 13 Jun 2018 07:38:28 -0400
Message-Id: <1528889908-15980-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be helpful if we could display the drops due to zero window or no
enough window space.
So a new SNMP MIB entry is added to track this behavior.
This entry is named LINUX_MIB_TCPZEROWINDOWDROP and published in
/proc/net/netstat in TcpExt line as TCPZeroWindowDrop.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/snmp.h | 1 +
 net/ipv4/proc.c           | 1 +
 net/ipv4/tcp_input.c      | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 750d891..97517f3 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -279,6 +279,7 @@ enum
 	LINUX_MIB_TCPDELIVERED,			/* TCPDelivered */
 	LINUX_MIB_TCPDELIVEREDCE,		/* TCPDeliveredCE */
 	LINUX_MIB_TCPACKCOMPRESSED,		/* TCPAckCompressed */
+	LINUX_MIB_TCPZEROWINDOWDROP,		/* TCPZeroWindowDrop */
 	__LINUX_MIB_MAX
 };
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 77350c1..225ef34 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -287,6 +287,7 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
 	SNMP_MIB_ITEM("TCPDelivered", LINUX_MIB_TCPDELIVERED),
 	SNMP_MIB_ITEM("TCPDeliveredCE", LINUX_MIB_TCPDELIVEREDCE),
 	SNMP_MIB_ITEM("TCPAckCompressed", LINUX_MIB_TCPACKCOMPRESSED),
+	SNMP_MIB_ITEM("TCPZeroWindowDrop", LINUX_MIB_TCPZEROWINDOWDROP),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 355d3df..b0482b1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4665,8 +4665,10 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	 *  Out of sequence packets to the out_of_order_queue.
 	 */
 	if (TCP_SKB_CB(skb)->seq == tp->rcv_nxt) {
-		if (tcp_receive_window(tp) == 0)
+		if (tcp_receive_window(tp) == 0) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
 			goto out_of_window;
+		}
 
 		/* Ok. In sequence. In window. */
 queue_and_out:
@@ -4732,8 +4734,10 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		/* If window is closed, drop tail of packet. But after
 		 * remembering D-SACK for its head made in previous line.
 		 */
-		if (!tcp_receive_window(tp))
+		if (!tcp_receive_window(tp)) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPZEROWINDOWDROP);
 			goto out_of_window;
+		}
 		goto queue_and_out;
 	}
 
-- 
1.8.3.1

