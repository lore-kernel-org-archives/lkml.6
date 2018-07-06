Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007F1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD06F2168C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD06F2168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933033AbeGFMia (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:38:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932776AbeGFMi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:38:28 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LtWRI-1gIM0C363g-010wGV; Fri, 06 Jul 2018 14:38:08 +0200
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
Subject: [PATCH net-next] netfilter: fix NETFILTER_XT_TARGET_TEE dependencies
Date:   Fri,  6 Jul 2018 14:37:58 +0200
Message-Id: <20180706123805.2852900-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:rsMkXA7g60xqn0AtYR5yX0lHu9O/zHr6pnRX7knE1x1s2LbB8Kb
 sUNHwoCzvAMNKSF/fLz1TPpG3pI21hIPYXmSXTd9xhsWwUMbDjitetCA3Dh2M1aYe/YzMWj
 KbLKc5Jau6YqJH7UxYMtZMhZMt83m0d3slMZA0Q59GH7jj757iWYXR1Tx7ZeUekfExxEQcX
 iFIO3kxy9FDpNDIuXxzvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rm/Ri3D/UQg=:7j7cQO6pQUz4l0U7zXCfTK
 8+jS71klwKQTnw4NwhET9+fehCJ1s1LxfSjh0pRX6E5TmrPRWwFv0qmQABa9t53v+3QjLjuSY
 Z6v/sj+y+2L8e6p3rTyJhTfUi88HwLLE5XkZ8N/xSR19kdNeSfDOw1zna/TTKHlcUuWkI9LYq
 wxQaAuJWnruBHMLgb2UrC8yzTktVuk091rVfJRSG2ebOwk5ovcbejAG+8JtvDyoqPJgV9FVBS
 j4RXBpSX3DecpwsfONDvWN85MPotmtBuxQXxJcg3RSVHq6dYkhM8oWPZUWerF8ahns3qRP3RM
 T2l4L7eVeudh0lk7FNiywpZF4YyCUUBu07n+mgLGcYaWacw8ljwpxCWxxWrim0lDZpkdt64Uz
 lajlYsmC/c2Rn0PEy1F04LOsOcPIGDSzyEdaL2XvbKU7kLy/JMJMxJs+ANuWlXK6/UymrRbDl
 wYBrt/bPBN2Ycsy6NiBM416thrsJPnJb3sYWNxgT3MZzryjXWP+jJEY/GH+plwQTnfvnpgW1a
 4nHN4AjtoC001uadfabHdsm5lNLIMBFACw/7CB2k+5705mK9QakpExm2QauGsPcRZR94rMgBe
 lNbMR2F48X3oOyLAXhE/SafazJK8yUB7iV2EP49FLWlQIdrQ+if+FPnBNrnDw27ZkSsJaZh/s
 J/5z2WgHS1oc+PfnfeAuBa1oUokE4LslDs0jXNl2B++tzxo59q815npxCuBpOdiq7yjo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With NETFILTER_XT_TARGET_TEE=y and IP6_NF_IPTABLES=m, we get a link
error when referencing the NF_DUP_IPV6 module:

net/netfilter/xt_TEE.o: In function `tee_tg6':
xt_TEE.c:(.text+0x14): undefined reference to `nf_dup_ipv6'

The problem here is the 'select NF_DUP_IPV6 if IP6_NF_IPTABLES'
that forces NF_DUP_IPV6 to be =m as well rather than setting it
to =y as was intended here. Adding a soft dependency on
IP6_NF_IPTABLES avoids that broken configuration.

Fixes: 35bf1ccecaaa ("netfilter: Kconfig: Change IPv6 select dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/netfilter/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 8aa4883c176a..e42c38c99741 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -985,7 +985,8 @@ config NETFILTER_XT_TARGET_TEE
 	tristate '"TEE" - packet cloning to alternate destination'
 	depends on NETFILTER_ADVANCED
 	depends on IPV6 || IPV6=n
-	depends on !NF_CONNTRACK || NF_CONNTRACK
+	depends on NF_CONNTRACK || !NF_CONNTRACK
+	depends on IP6_NF_IPTABLES || !IP6_NF_IPTABLES
 	select NF_DUP_IPV4
 	select NF_DUP_IPV6 if IP6_NF_IPTABLES
 	---help---
-- 
2.9.0

