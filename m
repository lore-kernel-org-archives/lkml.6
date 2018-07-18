Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF546ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831ED2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831ED2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeGRJ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:26:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46641 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbeGRJ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:26:47 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MJl7U-1febgU2loy-001DCG; Wed, 18 Jul 2018 10:49:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Herbert <tom@herbertland.com>,
        David Lebrun <david.lebrun@uclouvain.be>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yuval Mintz <yuvalm@mellanox.com>,
        Georg Hofmann <georg@hofmannsweb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: ila: select CONFIG_DST_CACHE
Date:   Wed, 18 Jul 2018 10:48:56 +0200
Message-Id: <20180718084909.1902331-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:OTL9UuTnHqQdWRZou5xbCTtkCCInNXxVoDadf1bp8uMh6AntXBw
 +H0hC+yxD55v/ViA78IiIhcePujWwd24rYG0q/8/VUlWtxdO2uJmo7e46Biegy98r4h681F
 8R/OsIqIGTrPlTyAEdL6SZ4THseKr34fmqWgwCZeBBnX/N3xJK7QsskNHtSmndSyrOxRmZp
 ZHreHQsEwv552R9e0GiMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K3RHufBueGQ=:GCtkWj9DntB4RXRx1etbz4
 Y3ZLB1BobAqXwdf4GpoGXczEKstbD0xD5qWKipnO72Q5XymHcHa4k9IpkjyzXFnOWho7Xnnzi
 wqtiZTgiBG8/Jte15YN2WW+frtDswVvFZJmcWJx/fB6Qk+jWJjEh3b8SSE+5OE+UG1NyXhgjZ
 DPsEdav3B5buK9rl4pFtCPPhcLidFt8OUmmyndNT0YbcdfX1XQZR2xAeVCwxfhgZcfp+I5XuV
 keGdY12gLOt+SQJAOZ862O7agXZkGYwZ7oUE+L7Wv/NFtkTNAfMCJQIIEv5swRtnzEsM8sDWB
 8d7FTIDAgcc8YjFZKqSLOohf2vK49BONCqFrECwSAWiE7XNOyBYkbfTElorONwf2mkK2V1cuh
 N1mi4ErGyeap2xYJLI3ANTRHDyQdr8B0z0XYJpeLcjRFLovsZi32Nw34xVuDIT+Q71yO7I6bc
 4mXP75pZy6pqekDXt7HXY8lqGrMiOaVxbEfe8NGBLt3P1xW9FGDaId0qfwqt5OYB/GGQsCmKV
 K1UDB8pXTj4kp5s2nZfuVuCpxX4hqHdqPlbAIQVaf37HIDuv++ndBHH9RiCLLXlNh4BxYpZNi
 pV09CWdjTUNVrHcyswbkdaNiwts7YaPxZ9ylDv451O0IQFkUs3Rey1IQQVASMj02SaVBzsnM2
 K7+AMgxnhRbCmNZQiciSq4aCT5Ooj8/1Zg2VyxZiJEV756pNKGHUnTL8+C/EtcjG+uQg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My randconfig builds came across an old missing dependency for ILA:

ERROR: "dst_cache_set_ip6" [net/ipv6/ila/ila.ko] undefined!
ERROR: "dst_cache_get" [net/ipv6/ila/ila.ko] undefined!
ERROR: "dst_cache_init" [net/ipv6/ila/ila.ko] undefined!
ERROR: "dst_cache_destroy" [net/ipv6/ila/ila.ko] undefined!

We almost never run into this by accident because randconfig builds
end up selecting DST_CACHE from some other tunnel protocol, and this
one appears to be the only one missing the explicit 'select'.

From all I can tell, this problem first appeared in linux-4.9
when dst_cache support got added to ILA.

Fixes: 79ff2fc31e0f ("ila: Cache a route to translated address")
Cc: Tom Herbert <tom@herbertland.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv6/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index 0eff75525da1..b3885ca22d6f 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -108,6 +108,7 @@ config IPV6_MIP6
 config IPV6_ILA
 	tristate "IPv6: Identifier Locator Addressing (ILA)"
 	depends on NETFILTER
+	select DST_CACHE
 	select LWTUNNEL
 	---help---
 	  Support for IPv6 Identifier Locator Addressing (ILA).
-- 
2.9.0

