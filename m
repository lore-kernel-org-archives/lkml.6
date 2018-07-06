Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99876C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A93E23F16
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A93E23F16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbeGFNA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:00:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbeGFNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:00:26 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MWSUM-1fczhF4AlG-00XbBL; Fri, 06 Jul 2018 15:00:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?M=C3=A1t=C3=A9=20Eckl?= <ecklm94@gmail.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "Pablo M. Bermudo Garay" <pablombg@gmail.com>,
        Felix Fietkau <nbd@nbd.name>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: conntrack: add weak IPV6 dependency
Date:   Fri,  6 Jul 2018 14:59:52 +0200
Message-Id: <20180706130005.3640993-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:ceghUajkeFq9CBwXS/1CopdxdW/Uwa8EgyejHZl7h/NmHNnYjcP
 t2wCamvDsnIBzOqkV/BIrbW1Y5eqMFauruKHmroQsA06tS1xc4x4Lzi8Ow9OmqlEwFNLLJb
 GDGCyI9mqDTkmP+oKFudUsWHG0rCROGhvdXRyU1dCpPQ/rgwN+d0sv59jsiwVF+8cnkmBKO
 yU6WHqwM+BO+RST+t2sdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KPeFrAS0K0I=:DoqTIvMsKoUr3inSIv+8vI
 pzJwhidrOSoSgg1b4swJ7QEAf5aqfX19y2/XJ8PeuBND8YaS5kYPlNPGh3Ndhnowq0a/o6qv7
 tgl2SaPSVdk0INB1oJLZcOih8Iv6m/OecnCtxKWZMQ/UN/ZmL2NPUQkH20ViR2VjLlvG+qNEl
 yqtKQP8fiVpxl6BNpaZnuF6sja7xgDhuBlzTSUu1d2eVhzcJu9p/axhBi732NzK81uCoBhN+v
 ODL2RJP+n6llUSfT6fHxPKgCYpFFqlrlUMV7Vm4WFrO3nE1Zz6FoBcWedefILxACJ6kYjFLyY
 82R6o5mbpy2LEi/hSgvQTIfRkiTAROiqPIUqip4A9N+UZlj8jhcbDOU3bjFHVjtZWeFTk3FbC
 OslbscHq8iFcUOiJ40H+GJytnjXcOWKryfho02S355uzgyNtKaZR59eMtMJXpn3mHyU+10Ldv
 GgYUMv8K0+Krv3P35gQAl4NSyoBxGbKLPCn2rUJJiNkE1cEnyu0B9CQluH1gQ2/9ml747IrXY
 dWv8bBEywj4sRbeY631SSk1MaIcSap/foaHi1DRg207WcdFo61CdJrhkzhPYt3bmQZaQ/FQ2m
 yz3z+BANEEaz53HanO5GRPYcDajWcuVemL1oT42LlC0VAo8a/JUiNc7E4ACHx+lOSZMyod7sD
 vB42JeqOGVrac137uw/P30dXD4NiDREIJLFA7UxNIitb1NLCBE/tnEiPkkFYM7FTKb0U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the conntrack module contains code for ipv6, we can no longer
have it built-in while IPv6 itself is a loadable module:

net/netfilter/nf_conntrack_proto.o: In function `nf_ct_netns_do_get':
nf_conntrack_proto.c:(.text+0x88c): undefined reference to `nf_defrag_ipv6_enable'
net/netfilter/nf_conntrack_proto.o:(.rodata+0x178): undefined reference to `nf_conntrack_l4proto_icmpv6'

This adds a dependency on IPv6 that makes it possible to still build
the conntrack module with IPv6 disabled, but avoids the broken configuration.

Fixes: 66c524acfb51 ("netfilter: conntrack: remove l3proto abstraction")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/netfilter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 74df382bf2ba..e42c38c99741 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -49,6 +49,7 @@ config NETFILTER_NETLINK_LOG
 config NF_CONNTRACK
 	tristate "Netfilter connection tracking support"
 	default m if NETFILTER_ADVANCED=n
+	depends on IPV6 || !IPV6
 	select NF_DEFRAG_IPV4
 	select NF_DEFRAG_IPV6 if IPV6
 	help
-- 
2.9.0

