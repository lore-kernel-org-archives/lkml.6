Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E0C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3CC213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3CC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJIX2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:28:19 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48509 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJIX2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:28:19 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MsIfc-1fqSjD2rT0-00thRQ; Tue, 09 Oct 2018 18:10:33 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MsIfc-1fqSjD2rT0-00thRQ; Tue, 09 Oct 2018 18:10:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christian Brauner <christian@brauner.io>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rtnetlink: mpls: ip_valid_fib_dump_req() requires CONFIG_INET
Date:   Tue,  9 Oct 2018 18:10:00 +0200
Message-Id: <20181009161031.1003047-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:gYU7UJ5LP7ExJd37mcfS6X2eohe8grJumnPMznB/MYZMZKhbhi4
 ODLImYjUUNblwjFohhyRtZprosbU8eBu0atAEzUjnJcivOSu7NGEHUBDPoHyyKU/triqRVL
 UwMD3L2O16guCJZER3qruhLf8P8ApRmmq0HXdnGubkEPiTbgFlfLm0kx6GCDpTEiwdgrYgf
 KIoE4DyEgBwuIQiHKLpPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HEoUs3kZzss=:L7ylgr1OsUltW7ZbByyW0h
 cTynn9a2QQwZnKl2sEny/nuG28nQbhX+B2YdsRTagp9ItsPjy5e3HlRRsrPLoeliGdnsu8N9+
 C/wfHl78uw1N7C1qzSLAzePZ9Bky+dmmFgVFCJivCXcxnfhk596nOs/kAy4Ts0WVyOIGVDCD0
 0wYxP2dwuPMzM5b4jPLzOOT+tEpHK1LfBUYp5z3bxC/YZ3JbvicRCH7Eeg1yM3Idm0Tdoz9Sl
 Ws+GX6rQQqnn1JWBh3qNJoXi5fZ+aO+kc/w25KH006t1+WQAun3fIPoiKkQMZJjykGkUkbB2/
 pn3aY6Yk+k3pCyW9sg0BFq3xSTy5RcBBmA1yLvloJMIoAvtKBOooe1+SOEMFnqwnfFc+wYMxe
 5TaeXnvzjxjWmrgtFi4f4Ds/BAcbyxrPYEolWiNX/xblpTaiXUhNnju/I3qHo4GLC9PEjuKZa
 0rY3DC8uy0+c3k4MCQEc7FfzC9ahcqFF/n/fKxRzWyfO2UWzN40N3t0lwwxQ7iFTNEWvXlcs8
 QZeRkzQyZEVVfe/dS3BnAlqJrIEwmQJflCLqLOJHgyg/O0a6zyBzh5XvapwHJKPp30gGvFGll
 +yCdl5gZRg4qLeb/+NvtShc1Lt8ysYDEt5iU58dfuLAWWvws7XdM+aJYtTXegf2j65jyD+79w
 TFieC/IuK8p0ZFrBk0fUZbkMRCS0DGP9ebDDVLWTTHXoAHGn6PcfpCw7wHTX+dP7rMSo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added call to ip_valid_fib_dump_req() causes a link error
in configurations that enable MPLS but not IPv4:

net/mpls/af_mpls.o: In function `mpls_dump_routes':
af_mpls.c:(.text+0xed0): undefined reference to `ip_valid_fib_dump_req'

With the added IS_ENABLED() check we get the previous behavior
back in that configuration, and skip the check.

Fixes: e8ba330ac0c5 ("rtnetlink: Update fib dumps for strict data checking")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/mpls/af_mpls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 7f891ffffc05..99ff6114d513 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2041,7 +2041,7 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
 
 	ASSERT_RTNL();
 
-	if (cb->strict_check) {
+	if (IS_ENABLED(CONFIG_INET) && cb->strict_check) {
 		int err = ip_valid_fib_dump_req(nlh, cb->extack);
 
 		if (err < 0)
-- 
2.18.0

