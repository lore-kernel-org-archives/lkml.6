Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0B8C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB2820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUSothco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB2820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeGYOTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:19:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33775 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbeGYOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:19:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id b17-v6so1753493pfi.0;
        Wed, 25 Jul 2018 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C4q2bG+uix1L0g40LFcxQdc8z2a4Mz/bpvjhD03gNBE=;
        b=MUSothco94eLD0/sQC0cKqLjqxrs15wNkbczonRGtZaoOLN33S2iOYoD7KYuVGzWog
         pHfm2BYCdZb72TOtDVaio8u6dxADyQmrGW5P2iVhOe2M1Vq7Q3U6kKFKo5N3bjTYZka2
         C0v5qFw4ZR+AMkXHIZxvO9Uet2CwMYq5EdEm0fvOvqoR8o5Tj5tFBfVXEIOjF0lvmcXy
         mqCt1z9efGBdpEbrl5l498lO2ZYCIO58ZIgc5rpa3XzBnoYQdFtBUda0mEjKjWDsuovH
         XuoBK+exmGSLF1NFioohG8ZDt0eltB4TJktoDE3KOHIZlfmiaIARMPBgZM1mqcxqTKrk
         TjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C4q2bG+uix1L0g40LFcxQdc8z2a4Mz/bpvjhD03gNBE=;
        b=RMRvDSQnWC9U/j4a/7NTltci7ghAqfatiFoibkZWmAv4WpPk7WPR4a1bL4enwtROv4
         xX4kvh+4r4xWavkRuHeBxJnvUbdx8O0s/QEwGJggG+65L9Q5wzGOXnNp1pjmw5XSA+f8
         xQJ4KKHEjmfF6MImTd4aVI3uNRsEv00krVgCizWQ5i8X0ziSYwpLYVUv5+MtaWsMPQu/
         CeW1eFwQ2I9RGmVv374RZHV1/HBlH3pRkv50pkko+urWh2NYgvHIR348vHnX9HGZmZN1
         6RlusM3MR2dNiLcJpVMDH+Me3g3KjvRXbNBllfDZxHL3NSDncFW3InYABaXWZe608j6x
         v8Qg==
X-Gm-Message-State: AOUpUlFT9GuVekS5ZqTfYFjfY7o9zs+UON65k5uomGMhM40+DtOjG+cu
        4NCRiAeqZvIisEPZHMOhS2BJuws+BvY=
X-Google-Smtp-Source: AAOMgpdxnqxtv3eo0Nhzvli1yQb3WluQ8eVAGvyOohAQ1zMg2ZbgRVZA18ef6dXSS7fKh16gXFCzEg==
X-Received: by 2002:a62:aa02:: with SMTP id e2-v6mr21866149pff.211.1532524045694;
        Wed, 25 Jul 2018 06:07:25 -0700 (PDT)
Received: from bogon.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id z4-v6sm25887696pfl.11.2018.07.25.06.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 06:07:24 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: add SNMP counter for the number of packets pruned from ofo queue
Date:   Wed, 25 Jul 2018 21:06:50 +0800
Message-Id: <1532524010-11855-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LINUX_MIB_OFOPRUNED is used to count how many times ofo queue is pruned,
but sometimes we want to know how many packets are pruned from this queue,
that could help us to track the dropped packets.

As LINUX_MIB_OFOPRUNED is a useful event for us, so I introduce a new
SNMP counter LINUX_MIB_OFOPRUNEDROP, which could be showed in netstat as
OfoPruneDrop.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/snmp.h | 1 +
 net/ipv4/proc.c           | 1 +
 net/ipv4/tcp_input.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index e5ebc83..c996fba 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -172,6 +172,7 @@ enum
 	LINUX_MIB_PRUNECALLED,			/* PruneCalled */
 	LINUX_MIB_RCVPRUNED,			/* RcvPruned */
 	LINUX_MIB_OFOPRUNED,			/* OfoPruned */
+	LINUX_MIB_OFOPRUNEDROP,			/* OfoPruneDrop */
 	LINUX_MIB_OUTOFWINDOWICMPS,		/* OutOfWindowIcmps */
 	LINUX_MIB_LOCKDROPPEDICMPS,		/* LockDroppedIcmps */
 	LINUX_MIB_ARPFILTER,			/* ArpFilter */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index b46e4cf..c718295 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -180,6 +180,7 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
 	SNMP_MIB_ITEM("PruneCalled", LINUX_MIB_PRUNECALLED),
 	SNMP_MIB_ITEM("RcvPruned", LINUX_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("OfoPruned", LINUX_MIB_OFOPRUNED),
+	SNMP_MIB_ITEM("OfoPruneDrop", LINUX_MIB_OFOPRUNEDROP),
 	SNMP_MIB_ITEM("OutOfWindowIcmps", LINUX_MIB_OUTOFWINDOWICMPS),
 	SNMP_MIB_ITEM("LockDroppedIcmps", LINUX_MIB_LOCKDROPPEDICMPS),
 	SNMP_MIB_ITEM("ArpFilter", LINUX_MIB_ARPFILTER),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 91dbb9a..5267121 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4980,6 +4980,7 @@ static bool tcp_prune_ofo_queue(struct sock *sk)
 	do {
 		prev = rb_prev(node);
 		rb_erase(node, &tp->out_of_order_queue);
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_OFOPRUNEDROP);
 		tcp_drop(sk, rb_to_skb(node));
 		sk_mem_reclaim(sk);
 		if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
-- 
1.8.3.1

