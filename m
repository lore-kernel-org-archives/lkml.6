Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A94C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C113220870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C113220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeLKTeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:34:22 -0500
Received: from mout.gmx.net ([212.227.15.19]:38069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbeLKTeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:34:16 -0500
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWBpJ-1gvMxT2drN-00XLBD; Tue, 11
 Dec 2018 20:33:34 +0100
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH 2/7] [DSA] add helper functions
Date:   Tue, 11 Dec 2018 20:33:09 +0100
Message-Id: <20181211193314.10695-2-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:Q/my6UytJVxyZLtJc7lh5FOPR8E+ADY9dIGQJ6QokjLi/F4DiGf
 6YXNBT8dwo2tASrHjKJ0CTlhZxNHf+mRzlED69h8/IjldXLg78KujPVtRfkiIgE5cPO2YnY
 M6iUHKu8Vw4yPN3RNfZg3QUEn3L7HvZSS/wJnhnux4ROIWF/tE93C1preTXR+vfs2fuCxyK
 JvGS2b9zyKQ6jwBcPl34A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9uJAsunHCT8=:JA4PNchNUuqM1nHmmGKkYd
 249Xh7Yb4Baaa1PyJHKwYAy6o7Vwk2Nzlj1nE85GZ0+5zFA1IY9MJ0e1TvuD/P8y3FBuvK6ub
 2I1SbUwl+eWg8EJCDrB0zDWFBFhcvvuLstzhy7+OcMGjGqw/N/gVJLrEPyN/12aBgR3EZ1Suj
 gcL+oQNlhinrJ0Tr1qVMsiy6C1ekkxu4ZLGhLxf905WJUk8ALRYeUBRg0WP1H/vwK3TIcgl2N
 94EiQFKPcngLLx6aFtiNj6zgMxVxr9+35qf2RpxKzzRTDywQlS4P1SuzEo0+VlU79zjy8Wc1Q
 SKJ2z4ooPLloS0iXhjuIIa4Ri4iYfb3GgnLTRaO11L4xUGZ2nPKBGFPXHRzYNM7ZQb486xWoA
 LdHJB2yzjIFiej9Dmzvb7VUoFEwVrRwinFPYsTJ1ZMQZiKsIHnIAvJXWVxjnyoylmZcwBJ8O4
 L3cMouXLQX93IugSNjiedMlQAiaYTVm19KVvcfRz9QCwMelH7Sou7EGpWaJLUxIggPoYd9HyM
 +S0O19S16cQ7mgm426BXfg3/saSFIa2tEUMqWJMqpN8D0d37OZHNhupUY3yTvxeyvnVwMMLgi
 nwFVt6OyVFQVJETweKv0u1z6RW4mojl3BiJycgLKHL2yKLH966jtA9Q2ZK9K0gjXvWZosXiHA
 3g7rBFqlTcESfsizXECHAd10bnvzGqbRQstPvD5yvy97upni144f5IsHRRU4ufQQjDEygbw3X
 ImSNWoxRK7RiEyBPbMsAmfcfFq7zw7GTAwP0vONwVd1W4wXjja80MGw5sJuzOvy6MvUuFAMmJ
 hY8TcAd6plUZWmQSduaFKqaWrmXo10xX4TWL4F37pTrkBUFyyklJ1uPuGEiYz8Y5mP2qQ4F1y
 wgTZYTied0AufIIdtTGqtZIQ6juAACNJtvI08fzkaOsZ6C/IIM+9a3YCg/7vg5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0033-dsa-multi-cpu.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 include/net/dsa.h | 18 ++++++++++++++++++
 net/dsa/dsa2.c    | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 3efa81e08993..612942ac56de 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -319,6 +319,12 @@ static inline unsigned int dsa_towards_port(struct dsa_switch *ds, int device,
 		return ds->rtable[device];
 }
 
+
+static inline bool dsa_is_upstream_port(struct dsa_switch *ds, int p)
+{
+	return dsa_is_cpu_port(ds, p) || dsa_is_dsa_port(ds, p);
+}
+
 /* Return the local port used to reach the dedicated CPU port */
 static inline unsigned int dsa_upstream_port(struct dsa_switch *ds, int port)
 {
@@ -331,6 +337,18 @@ static inline unsigned int dsa_upstream_port(struct dsa_switch *ds, int port)
 	return dsa_towards_port(ds, cpu_dp->ds->index, cpu_dp->index);
 }
 
+static inline u8 dsa_port_upstream_port(struct dsa_switch *ds, int port)
+{
+	/*
+	 * If this port has a specific upstream cpu port, use it,
+	 * otherwise use the switch default.
+	 */
+	if (ds->ports[port].upstream)
+		return ds->ports[port].upstream;
+	else
+		return dsa_upstream_port(ds, port);
+}
+
 typedef int dsa_fdb_dump_cb_t(const unsigned char *addr, u16 vid,
 			      bool is_static, void *data);
 struct dsa_switch_ops {
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index a1917025e155..77420675e9ed 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -255,6 +255,24 @@ static void dsa_tree_teardown_default_cpu(struct dsa_switch_tree *dst)
 	dst->cpu_dp = NULL;
 }
 
+static int dsa_user_parse(struct dsa_port *port, u32 index,
+			  struct dsa_switch *ds)
+{
+	struct device_node *cpu_port;
+	const unsigned int *cpu_port_reg;
+	int cpu_port_index;
+
+	cpu_port = of_parse_phandle(port->dn, "cpu", 0);
+	if (cpu_port) {
+		cpu_port_reg = of_get_property(cpu_port, "reg", NULL);
+		if (!cpu_port_reg)
+			return -EINVAL;
+		cpu_port_index = be32_to_cpup(cpu_port_reg);
+		ds->ports[index].upstream = cpu_port_index;
+	}
+	return 0;
+}
+
 static int dsa_port_setup(struct dsa_port *dp)
 {
 	struct dsa_switch *ds = dp->ds;
-- 
2.17.1

