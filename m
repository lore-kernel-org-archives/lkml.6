Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0823C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50692133F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50692133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeLKTem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:34:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:51571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeLKTeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:34:15 -0500
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsCdj-1hamJM3fcl-013wyj; Tue, 11
 Dec 2018 20:33:36 +0100
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
Subject: [PATCH 3/7] [DSA] adding handling of second CPU-Port
Date:   Tue, 11 Dec 2018 20:33:10 +0100
Message-Id: <20181211193314.10695-3-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:uULslvaJwqYnz381Koxpp6SKyzdTC4qeUILpCFIU4cdT8rKSU56
 iv/wHJ6crRXZ/tTwcyFwxGkf8fi9XMcpX08h7hsiMoaUzBNf7gG7URiKAKS6pIHeEmAZxSz
 CofnXo9NEkz0YCFB2C/LjRBv0M2+OZcSVf3kLjI9C37axiUhtijlR/0RUzG7/3fSEEQPrEx
 xYxLjEitSJkFVYBU+lxEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ek4UThKCdyQ=:meMDkmieU45Eup87jixZrk
 FYAlrUIMSYNp119ik5EV9+s1Gwx84nXo9SrCSG/G9Q9tGzOYTcnPCD1nEtEwOvA+MT7J8ovUH
 N1dYWMa5MW5o+aLpH7GT6R7yxgZg6ftYUWfv48ORI1UtQtWHKi63h8nV1fflVEoZ4Y1ietwWK
 o3liUs8DoqiHDoZ+EbwiAamJd76Q6TH9unSf4zEBIO6WjOaMh0IVRqHfZvvqmBOgNiNJbYFx2
 Y9ZuI0cpr91mDEI2wDT5KYUxXEMCZ03sst6vbFpwIzVd1xCGmDW1h6/uHvwRUj1OUryZpcTbC
 C+FzVbkOxGXeRolng7+NXaPENhol7G5UH3nQ2qtZEWb0j1T7foHhR/ogTwMQm7OVks4VrEvug
 r7kXkbC6bAkxyEB19BuMjvFynCzdTlLxDKI4Nyj2EvSMWcojIw4d6rBcHcljyzmDWxL23M/sZ
 wZXFqelrqY6EojZYjGTkOtHZkFauTYL8ON35nh5gRQ0UBpkY5JEo97Vs42likl4BBrJJEatB5
 490LOV0zCLrx41XUsLsEu3IfpE08uCS9KeU6HrvPm690T1QU0mtV7I0awh270y1l+0Sp8mL8D
 UW3x7SDhXulGHYFaE9ReabvE0XqtEY4FCCn6y7fNnn1vjozFrQC9ULYW84EtLnhqWa6Sr3M9s
 U/0ntKQ3k8aBA6cvVJ1IRaGkw/59pBu2s4+QYHEYDPLMIfwZhVpFb0mDg7jyRQG/Xfn2zOri7
 yGVWEtb7s1feRfgRr8Bx/hqO//1ahvWV061/RT4ZrgXjLKdF2vI5GBucoflPZemLdxyf5VND1
 qyAGRokZOZCmj4X+H2S2unEuuJj63lp4nlRBVE/6SdWQTuwmQygC/CIIZIQsao5hXfyUa+H9v
 wQlr6P82Lp0x+uKB3hLdaKu3/5rJWj3as7MTThsmBTU0jMOFK6+S+C5M14F+4/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0033-dsa-multi-cpu.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 net/dsa/dsa2.c  | 18 ++++++++++++++++++
 net/dsa/slave.c |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 77420675e9ed..4a6ebfe647f0 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -303,6 +303,8 @@ static int dsa_port_setup(struct dsa_port *dp)
 				ds->index, dp->index);
 			return err;
 		}
+		if (dp->master)
+			dp->master->dsa_ptr = dp;
 		break;
 	case DSA_PORT_TYPE_DSA:
 		/* dp->index is used now as port_number. However
@@ -323,12 +325,17 @@ static int dsa_port_setup(struct dsa_port *dp)
 		devlink_port_attrs_set(&dp->devlink_port,
 				       DEVLINK_PORT_FLAVOUR_PHYSICAL,
 				       dp->index, false, 0);
+		err = dsa_user_parse(dp, dp->index, ds);
+		if (err)
+			return err;
+
 		err = dsa_slave_create(dp);
 		if (err)
 			dev_err(ds->dev, "failed to create slave for port %d.%d\n",
 				ds->index, dp->index);
 		else
 			devlink_port_type_eth_set(&dp->devlink_port, dp->slave);
+
 		break;
 	}
 
@@ -344,6 +351,14 @@ static void dsa_port_teardown(struct dsa_port *dp)
 	case DSA_PORT_TYPE_UNUSED:
 		break;
 	case DSA_PORT_TYPE_CPU:
+		dsa_port_link_unregister_of(dp);
+		if (dp->master)
+			dp->master->dsa_ptr = NULL;
+		if (dp->ethernet) {
+			dev_put(dp->ethernet);
+			dp->ethernet = NULL;
+		}
+		break;
 	case DSA_PORT_TYPE_DSA:
 		dsa_port_link_unregister_of(dp);
 		break;
@@ -598,6 +613,9 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *master)
 	dp->master = master;
 	dp->dst = dst;
 
+	dev_hold(master);
+	ds->ports[dp->index].ethernet = master;
+
 	return 0;
 }
 
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 7d0c19e7edcf..f0fdb9e5d05f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1312,11 +1312,11 @@ static void dsa_slave_notify(struct net_device *dev, unsigned long val)
 int dsa_slave_create(struct dsa_port *port)
 {
 	const struct dsa_port *cpu_dp = port->cpu_dp;
-	struct net_device *master = cpu_dp->master;
 	struct dsa_switch *ds = port->ds;
 	const char *name = port->name;
 	struct net_device *slave_dev;
 	struct dsa_slave_priv *p;
+	struct net_device *master = ds->ports[port->upstream].ethernet;
 	int ret;
 
 	if (!ds->num_tx_queues)
@@ -1355,6 +1355,7 @@ int dsa_slave_create(struct dsa_port *port)
 	p->dp = port;
 	INIT_LIST_HEAD(&p->mall_tc_list);
 	p->xmit = cpu_dp->tag_ops->xmit;
+	p->master = master;
 	port->slave = slave_dev;
 
 	netif_carrier_off(slave_dev);
-- 
2.17.1

