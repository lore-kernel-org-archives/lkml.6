Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E5BC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 14:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9AF2170B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 14:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZAgYI4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9AF2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeHYRyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 13:54:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35878 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeHYRyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 13:54:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so4173315wmj.1;
        Sat, 25 Aug 2018 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s/lezIyIiPkTk9bWADp/s4dd+qQ7Vdsz2ayDh8LCkzI=;
        b=lZAgYI4UeVli0StX/yfQEKbaVLZr3qdX9/i08fw6ibOxIPJZdFHMtBLkbABYfIrDLc
         8z8pVuebOw/JxpOjzGPDLo6XCvZpUhJYFuRcBkHsnTTzos/frJ1L1sr9x23Oj5EPf+ZN
         PDYO2UHzc822eRIZKKLfJrWyfxfh1wLVZ13j5EFL0G5vqQC1yKzRyFSPjZfh8igzm1Co
         ORm1Zjl8gBZ9XCJCqweG+VH7HjOKxZsn9gSRzjcTkVg9raBRtLanQ7Jq6FStku+KIfq+
         MOF0gPLnIfe6TQEF9vm4O6pnZCiEmSsNllrYc7I1lV/PtPx2mJFRTCqH0JFTVclGFKAN
         zmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s/lezIyIiPkTk9bWADp/s4dd+qQ7Vdsz2ayDh8LCkzI=;
        b=WVW+6C03ZxTE2boPbVyigQhcmCXnXvFLFiUvmRowNiI464W41cIPBU+MG2CmH6SEbN
         Ejq9vEnRSGlQK5M/OAPm/OmAKaHZBguPMmgnFe2QPudWBP0Xx5kiAxAFvk5XlHDXrNno
         59UDJ02jHrGyCzItl3pcZKqY00B4RcKP0abscPW7qrXk5NG3k9qCZTCwjMfzhlg6ypl5
         Z8ozOpknGTYWLhfaoP52kCc75/++qts781G7FCRKNkxafaPY9f7tE0txfn2QvthRp6mO
         bS4i7FQ2WyyOnWeSs9m9rOrdXZ/02o+276I3AwtLv9lys4L1Phcz0/Jxvksy7rNww7Jm
         WXow==
X-Gm-Message-State: APzg51C3zr4EvUJs6InwGw1X616ZN6BPg8lRqYPXigcjsQPR9UIFw2G1
        d8tmisBMiMgkJshYQ11fC/0=
X-Google-Smtp-Source: ANB0VdbSADMKCcr0js5R7BVPS166ia8TWz5O49sE/C2D0INXaT/URj9PGzfs8ZAb8OTGpbllPSt5cQ==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr1235500wmr.138.1535206548440;
        Sat, 25 Aug 2018 07:15:48 -0700 (PDT)
Received: from localhost.localdomain ([192.135.27.140])
        by smtp.gmail.com with ESMTPSA id u65-v6sm5791361wmd.31.2018.08.25.07.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 07:15:47 -0700 (PDT)
From:   Ahmed Abdelsalam <amsalam20@gmail.com>
To:     davem@davemloft.net, dlebrun@google.com, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, amsalam20@gmail.com
Subject: [net-next] ipv6:sr: Use the right next-hop value for neighbor discovery in End.DX4
Date:   Sat, 25 Aug 2018 16:15:41 +0200
Message-Id: <20180825141541.960-1-amsalam20@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRv6 End.DX4 behaviour supports the use-case of L3VPN,
where a FIB lookup in a specific tenant table at the egress
PE is not required [1].

In the implementation of the behaviour, after the packet being
decapsulated, the lookup in the routing sub-system is done based
on next-hop specified form the control plane (using iproute2) or
the destination address of the packet.

However, the neighbour discovery process always fall back on the
destination address of the packet (in ip_finish_output2 ()),
if "rt_gateway" value is not present in the "struct rtable rt".

nexthop = (__force u32) rt_nexthop(rt, ip_hdr(skb)->daddr);

This patch makes sure that "rt_gateway" has the value of
the next-hop configured from the control plane.

The patch is tested for inner IPv4 packets having destination
address different from the next-hop configured using iproute2

[1] https://tools.ietf.org/html/draft-filsfils-spring-srv6-network-programming-05

Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>
---
 net/ipv6/seg6_local.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 60325dbfe88b..d346f0d19c09 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -374,6 +374,8 @@ static int input_action_end_dx4(struct sk_buff *skb,
 	if (err)
 		goto drop;
 
+	((struct rtable *)skb_dst(skb))->rt_gateway = nhaddr;
+
 	return dst_input(skb);
 
 drop:
-- 
2.11.0

