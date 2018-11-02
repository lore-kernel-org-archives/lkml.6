Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F758C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41682081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41682081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeKCApD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:45:03 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:45:03 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDy9C-1gQGTA1v5I-009xLM; Fri, 02 Nov 2018 16:37:08 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MDy9C-1gQGTA1v5I-009xLM; Fri, 02 Nov 2018 16:37:08 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Flavio Leitner <fbl@redhat.com>,
        Gao Feng <gfree.wind@vip.163.com>,
        Thierry Du Tre <thierry@dtsystems.be>,
        Yi-Hung Wei <yihung.wei@gmail.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: [PATCH] openvswitch: fix linking without CONFIG_NF_CONNTRACK_LABELS
Date:   Fri,  2 Nov 2018 16:36:55 +0100
Message-Id: <20181102153705.1664786-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:urUdUvoTEdrqek+SKJTQs2jQeQgrpSU97Fo622stFo9wXsiMdk0
 PR44sBdwgkd2fHw8XexyV9OZzKMOplk26JcG+ON64YOI5kFi5oAJmE7MHXJeFUN9n/O+WLw
 pdNTW5BY9NvdBf0DNGYXqfZbRdqk2thF3SaYUeT8os/zkenUsds/cpdJ2VOlhLYXs6UqJg3
 vbl4qe9zD0CLw4HgonaTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6lrbs4gOJAk=:42gvTR4v9Sz1k2ejgvKP2X
 LI0tdyov+VefpmcC7AuZKBh6bW4v0JDQoiO8bgT3jCYYz/x5Cjs0G/4sTZZZ2yrA+33AIU/V1
 CJvl06NiUK7KnWH2+Z/GhjHIrnr5qrZ06y3JuYpMGGKC08gDAtXxX1E816Z+P3tn5kSszLbQy
 VBelmv/VIs44A2sEHF9aPcTthqaj4qEjxc5rccw48xX9KyEy/7oxLXR7Wk6CUQ332p9Wcx7a8
 dNf82x+aET1cqXQiv485RJHWOwSeapXsWZvwoSnemm46E8H6FapEyIoDJuOUb/NtsTwQp/mtN
 1QgBc/ywQ+4PqMqKfm8yTZbdwCYWCDO6xwUtLTmQi0y3vUJgmmL6FjD+RGIe3e7SpQQg8HF2C
 k/0VB90xIsBKcp/tj2JZlo6wTTdkaczuAwS7OUKJpdiAOE0RapaKYxSO1ARy3qqNxE8GQlcUd
 R9Dh6zhnABFwco84kKRJ60tKu9NdREzxhWHSHtubTIVkPiZUJEAvYeu3+zzlcr2ERUwlKgVwM
 fc4aYucMQPN9JabTrw4JCf2BwnVC2rHd/C6ej5iVE7BQswlNJWN8ncopcjQ0+4qZMXlXjjVUZ
 2p+/mjZWDuurWPWu/3+SBCCGvkrZI9C7gLlypkQgUu2p9/Nlpy2bnYuu9fhZY2P+JymDUfvA3
 ICQXkhsofTTGrcSg57R/aWY5fcGyXrB3oL76SfZvAkFaYFWxkCmyU2e2ZtXx/SFMm+nY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is enabled, the compiler
fails to optimize out a dead code path, which leads to a link failure:

net/openvswitch/conntrack.o: In function `ovs_ct_set_labels':
conntrack.c:(.text+0x2e60): undefined reference to `nf_connlabels_replace'

In this configuration, we can take a shortcut, and completely
remove the contrack label code. This may also help the regular
optimization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/openvswitch/conntrack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 6bec37ab4472..a4660c48ff01 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1203,7 +1203,8 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 					 &info->labels.mask);
 		if (err)
 			return err;
-	} else if (labels_nonzero(&info->labels.mask)) {
+	} else if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
+		   labels_nonzero(&info->labels.mask)) {
 		err = ovs_ct_set_labels(ct, key, &info->labels.value,
 					&info->labels.mask);
 		if (err)
-- 
2.18.0

