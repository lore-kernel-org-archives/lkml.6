Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7CFC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664ED20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664ED20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeLAQD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 11:03:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:49073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeLAQD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 11:03:56 -0500
Received: from ovpn-120-135.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MAy40-1gctPT3x1I-009wwp; Sat, 01 Dec 2018 05:52:04 +0100
From:   Qian Cai <cai@gmx.us>
To:     davem@davemloft.net
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@gmx.us>
Subject: [PATCH] net/core: tidy up an error message
Date:   Fri, 30 Nov 2018 23:51:53 -0500
Message-Id: <20181201045153.4035-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Provags-ID: V03:K1:JfK0XEf9L9e3Hv/ORKO5uZxdRhHuLGb39BHrjJvvPpYwNeQHgb+
 el9FUYbm94nZsclLnMvtQuTIHHL+vdVkWKoOAG+sZlZ4m/906bMoF12Nq6wVK0CLaHPD7dY
 RpYwoV70xRits/Nm4mf+IqCv64P/k4VSzCKN7Ij21AubafeVlZ7KvP4wPei6pFgKZh8AIVp
 XSoLF/YfQ+e9xWHjAZk3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JOfZDzfZlrI=:rzNqNKTlECsbjJ/KSNSyKd
 +vBo1y1qb0ZGQg5hW3Ty8xvqz3i5KAUoMMtQcVd/N+2Pcqm3GBfqqX2AXH1G9aenGO3i1xx2Y
 B7Psy6Yq5gzQvZ4Q/vMzWKlkTBc26yclWR2xO0jBusYRwxgmJNWvV/DLgeLKUB3YCx5XoeI7T
 nDHeRdMCcF1LtVZOa2GToUfwkflT/+rJFv80ecf+rP0bDDS/sxGMkgreREmIYUbZOEzKG17s9
 dQwokhobOe/roTIB2h7MvuBIxvKGKjWkWY590zTvbrjgPkm+lYyBoGst3b0Lc8iQ4DNiJxmtq
 nSvdLHW4EHJNzbdqb5/YlhFcGTlGu3daVTFcwSSr7f0t5uSFSzHlt4M/PSEHILUDYatmcIuom
 Iz0M3/hoAh/yVigA9gNqhcXYS4j38mLuQypSEeqCR/r9ncRgePeKY4KeOBFuo1oaLI9c/eINb
 sdflF5w1rwTHI2QI+T2Ur2xmxnIjLRT3YhDU0wvoSn4295h+W1jutU/YNzSuBA7lohcUtyz8Q
 U2embw5vWL48Z/utVIpjl0GUW++4PVnBpkKOe3jgcxEld7jFpgoY+aDEtxT8SHfeR4Y3sVFUd
 l9rtN4rEC1cccpL7yP+k3MkrEbMdhQvxaUxRGLfBl0PIgMvNydCgvNbXvsrqtawYfrLpog+1z
 hK/4INyJkCPjqRB6iolsCvwX17kkgKd33BalV+yo+y5rpL0m5loIDgt6it0mr402Q1AeTyC0y
 z7YucETBNJVJRdRwn2+fMoRNCgO7WTsFdPWS8UIp0DA7HZmt9RStaBBPw3wq7L44gXwvLUIsU
 IebLNbqiFZwCgiR19WmwjxYOTiClptE//4GwsGoXEjC9piLm5TH/xVk4dPkVy/U1lWAqtRjOh
 Twjr+wD+C9QiKysXA2UfxGA8YSClmnUIGq57UOZJo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netif_napi_add() could report an error like this below due to it allows
to pass a format string for wildcarding before calling
dev_get_valid_name(),

"netif_napi_add() called with weight 256 on device eth%d"

For example, hns_enet_drv module does this.

hns_nic_try_get_ae
  hns_nic_init_ring_data
    netif_napi_add
  register_netdev
    dev_get_valid_name

Hence, make it a bit more human-readable.

Signed-off-by: Qian Cai <cai@gmx.us>
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ddc551f24ba2..bbd7cdbbbebd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6205,7 +6205,8 @@ void netif_napi_add(struct net_device *dev, struct napi_struct *napi,
 	napi->poll = poll;
 	if (weight > NAPI_POLL_WEIGHT)
 		pr_err_once("netif_napi_add() called with weight %d on device %s\n",
-			    weight, dev->name);
+			    weight,
+			    !strchr(dev->name, '%') ? dev->name : "unknown");
 	napi->weight = weight;
 	list_add(&napi->dev_list, &dev->napi_list);
 	napi->dev = dev;
-- 
2.17.2 (Apple Git-113)

