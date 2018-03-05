Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeCEV5g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 16:57:36 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.180]:25621 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753002AbeCEV5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 16:57:35 -0500
Date: Mon, 5 Mar 2018 15:35:57 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ipvs: use true and false for boolean values
Message-ID: <20180305213557.GA12365@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.245.224
X-Source-L: No
X-Exim-ID: 1esxm3-001ikV-6p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-245-224.static.axtel.net (embeddedor) [187.162.245.224]:41084
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 net/netfilter/ipvs/ip_vs_lblc.c  | 4 ++--
 net/netfilter/ipvs/ip_vs_lblcr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 6a340c9..942e835 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -238,7 +238,7 @@ static void ip_vs_lblc_flush(struct ip_vs_service *svc)
 	int i;
 
 	spin_lock_bh(&svc->sched_lock);
-	tbl->dead = 1;
+	tbl->dead = true;
 	for (i = 0; i < IP_VS_LBLC_TAB_SIZE; i++) {
 		hlist_for_each_entry_safe(en, next, &tbl->bucket[i], list) {
 			ip_vs_lblc_del(en);
@@ -369,7 +369,7 @@ static int ip_vs_lblc_init_svc(struct ip_vs_service *svc)
 	tbl->max_size = IP_VS_LBLC_TAB_SIZE*16;
 	tbl->rover = 0;
 	tbl->counter = 1;
-	tbl->dead = 0;
+	tbl->dead = false;
 	tbl->svc = svc;
 
 	/*
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index 0627881..a5acab2 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -404,7 +404,7 @@ static void ip_vs_lblcr_flush(struct ip_vs_service *svc)
 	struct hlist_node *next;
 
 	spin_lock_bh(&svc->sched_lock);
-	tbl->dead = 1;
+	tbl->dead = true;
 	for (i = 0; i < IP_VS_LBLCR_TAB_SIZE; i++) {
 		hlist_for_each_entry_safe(en, next, &tbl->bucket[i], list) {
 			ip_vs_lblcr_free(en);
@@ -532,7 +532,7 @@ static int ip_vs_lblcr_init_svc(struct ip_vs_service *svc)
 	tbl->max_size = IP_VS_LBLCR_TAB_SIZE*16;
 	tbl->rover = 0;
 	tbl->counter = 1;
-	tbl->dead = 0;
+	tbl->dead = false;
 	tbl->svc = svc;
 
 	/*
-- 
2.7.4
