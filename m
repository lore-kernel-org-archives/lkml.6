Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B365ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91620C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uih0vf+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F91620C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbeGQMjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbeGQMjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:08 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E402145D;
        Tue, 17 Jul 2018 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829208;
        bh=queapUVKgMCCkh9UYlHU3KRbDu+xP402bFdT2YDY4Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uih0vf+j2bZ0PgJPBYtwar+1ECf0abRrHUQjGhgwrTvnjPzKZAVImQgokdN84CzLO
         ww6VhvFDCJSrc8ayDilpD2TU0cr5CQKmNzy/TFyG4RJ6g9fNuByf8oS/J3k3rGNFcl
         obCNqrZALhM38b+AhGqaVzcmrxqgk01HWpCTCiCU=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 09/17] net: Remove arp_tbl and nd_tbl from headers
Date:   Tue, 17 Jul 2018 05:06:43 -0700
Message-Id: <20180717120651.15748-10-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

No more users at this point.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 include/net/arp.h   | 3 ---
 include/net/ndisc.h | 2 --
 2 files changed, 5 deletions(-)

diff --git a/include/net/arp.h b/include/net/arp.h
index 7b503bedd9fb..fae3561db10b 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -7,9 +7,6 @@
 #include <linux/hash.h>
 #include <net/neighbour.h>
 
-
-extern struct neigh_table arp_tbl;
-
 static inline struct neigh_table *ipv4_neigh_table(struct net *net)
 {
 	return neigh_find_table(net, AF_INET);
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 078951ac54fd..6fc58a61acdd 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -72,8 +72,6 @@ struct net_proto_family;
 struct sk_buff;
 struct prefix_info;
 
-extern struct neigh_table nd_tbl;
-
 struct nd_msg {
         struct icmp6hdr	icmph;
         struct in6_addr	target;
-- 
2.11.0

