Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A41C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF8920881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF8920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933445AbeGIVgC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:36:02 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeGIVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:36:01 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LgGqC-1gQ0vR1ZsS-00nlbT; Mon, 09 Jul 2018 23:35:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?M=C3=A1t=C3=A9=20Eckl?= <ecklm94@gmail.com>,
        Flavio Leitner <fbl@redhat.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: NFT_SOCKET don't use NF_SOCKET_IPV6 without NF_TABLES_IPV6
Date:   Mon,  9 Jul 2018 23:35:09 +0200
Message-Id: <20180709213537.2748896-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:EQnLo/RcaPkyTdZHLouXT0pY33lEG1+rT6qlW/G50yhH0N3q2YT
 p0I54FxVSBmJMuk8RFeree0wCKeIk3yTNkGYeS+2fFwc5E9fDe43jdAj78aZ1Rtir25+kVO
 PgjUP8v0ZQg8G8gE1NADQHr/3i4oaxWJtHWwe361aX3QUALn+dzgIrRhWHH3Bnf+ixmBVjK
 wnFOqoTyA8hDnvKOkQapw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lBtSqEWjSnw=:M//ey0M6FvrjCLrsCkclLO
 OU3fuiJFkfYwivpmecVmqtHTMQwdch8FvNRCV1r7t4cRJbnPoWVmJX5B5PTpCxLjfyQhdui8Z
 SH3JkfmZh6D9N4YwOIK5JEQH0TXOO36iYkrb6WVj7DTPXFOSJJGrtgtuVq1XnBIgfAhC5QtLk
 MTJdh48CdGxEpItIL/FXy4KolHlAVAgJ5B1m9YpJMqNDusVkAcM/tTgV9nUItRQwGPKPafVuQ
 Yd60cmqklXxWQ0rPrgSqJsCw+k81i1sBXwy2hNseAvY0wy571zGmvDD7R0nihYqB7kA7Rc9yo
 f4rSXMkq9y3rhZBmf0Y4fTU1QwfsnnYpN2i7HfVuwkmE57FOJc6s7CsMgLi9/73xpOTlMLvL8
 80zhFvoUATgA4CfptU3IC1pi8xilJknRk7F+Nkoq6eL6RiycFvciK//KYKlLc4I/bwh4Soyi0
 uc1UrComr6w09WogtRW9il7Rc2c5kYMi5ls+uO00WDlHEMF1fG4E3eS8mNUEKALLolyZYYVCD
 Ecuhnwzj7chgs16GA4Yfptsgp/L+M39M4BL81/Y1PPGv987NQ2zbfp2FvA+snEvGi3nF3BDkc
 vXuStWhf4TzwV9WXAAGsoP7J2xwzx0hSGKA4s2A3gR6S4rmWDC24AoZFFjQ/JaQ8ajYqtid8p
 tktQ4LNasMUOjrg5IDsyjOoEORNRw+kPs6bD33L7UIWVYqx9BAdAy1yHp9/piIiTnCjc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now possible to build the nft_socket module as built-in when
NF_TABLES_IPV6 is disabled, and have NF_SOCKET_IPV6=m set manually.

In this case, the NF_SOCKET_IPV6 functionality will be useless according
to the explanation in commit 35bf1ccecaaa ("netfilter: Kconfig: Change
IPv6 select dependencies"), but on top of that it also causes a link
error:

net/netfilter/nft_socket.o: In function `nft_socket_eval':
nft_socket.c:(.text+0x162): undefined reference to `nf_sk_lookup_slow_v6'

This changes the compile-time check so we don't attempt to use
the NF_SOCKET_IPV6 code when it cannot be used, and make it all
compile again. That may lead to unexpected behavior when a user
enables NF_SOCKET_IPV6 but cannot use it, but seems to be the
logical conclusion of the 35bf1ccecaaa change.

Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
---
 net/netfilter/nft_socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 998c2b546f6d..e43c1939d25f 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -31,7 +31,7 @@ static void nft_socket_eval(const struct nft_expr *expr,
 		case NFPROTO_IPV4:
 			sk = nf_sk_lookup_slow_v4(nft_net(pkt), skb, nft_in(pkt));
 			break;
-#if IS_ENABLED(CONFIG_NF_SOCKET_IPV6)
+#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
 		case NFPROTO_IPV6:
 			sk = nf_sk_lookup_slow_v6(nft_net(pkt), skb, nft_in(pkt));
 			break;
@@ -77,7 +77,7 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 
 	switch(ctx->family) {
 	case NFPROTO_IPV4:
-#if IS_ENABLED(CONFIG_NF_SOCKET_IPV6)
+#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
 	case NFPROTO_IPV6:
 #endif
 	case NFPROTO_INET:
-- 
2.9.0

