Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E404DC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97F720811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97F720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeLKTek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:34:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:35729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLKTeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:34:15 -0500
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVui8-1gv5yW0MwK-00X4CI; Tue, 11
 Dec 2018 20:33:32 +0100
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
Subject: [PATCH 1/7] [DSA] adding fields for holding information about upstream-port
Date:   Tue, 11 Dec 2018 20:33:08 +0100
Message-Id: <20181211193314.10695-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:6e4Tt0QPCv1129zyq1CTat5YbKXl3QuCfFVnI8ILsXDi2GCjTem
 y9EFJSDGzeyReuMagnPqrmKiAoMyiGYotXfr4phS/lZpwyoyIAUyBi4yPn933lGaJHi5f6F
 Gh/Wq+TeMg5CUEXQkTrG2gQTJaXpRZmQTBw6vUl7kF28hC9+sxZ3tzTJ11bbce6b7gv++rE
 iF0mu9Li+V5aLIRq5G3rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:48UIIgF5caM=:3VjltdEw65ve3QkcvnWep/
 ClFtD4/7B4t2vr8i4hEXl64YPQS+GphTHMQw3WpYwWuXJMv0DBRSpM52LvUi3gsJod4xlc/EI
 bwkgmSKsfu1r1PI879zu3YkVRx/08rlOWR0qdVfVbUpu3uTI8TY7G3q5Gj1uXGlVy2yhsmbac
 gif7XbRttj+XrDxg1VUghFC/jhgdOG/cHlrQP+lcbpJBWP+F7/hWcfIKLtpywm3yKZ37BZk3+
 L+z7HlMJvufiYyxkKiI658e/xLQIT4+DNW+WSVEWEeLdjAqr/00SSm+WFIIXx2u21R3Ckfd3V
 h1Kn1ryAVYSNKVkpsobNQHY/q5ipJ0fhxjhZoUpkGQ3f79gJSKLY3mBn9TwRq4feN8XIxyNQt
 9barcXf22XmQWiVAi+4YD75hWy3FEpIGMXMnubX9fXtygtWCHIF6ZhaYWbjgcETnYicgiElps
 NiswbapRgt7ODl2b/X0RKSn898cOnX1t1ZtVu8uQklo9JqYJ5ZlRTKjsy9p75FYQY5hz24weX
 /sge15oAGS2vSHkQVp7Y/DGoqb5MrehnEdp/6v9h73oV/23G0vJDuhs8t/LS61hs+12y7thH4
 IC2nAIR4cKM71Ajp46/IHfuHilMWixHumF6WwIxhSW53Yy5RjMo2laJz2/uZ/9LACPzlPr+0i
 NeeN31TK9W9gn/ubeQCOWpWX71M+3obzH/Q0MEcg6SAcgycXLcmQ2l0rG00nwGeBWGi7LyjvZ
 EcBHa/EcSdj74cpq4W2jUq96dyq8LktYaKEK4hiI7JyTEJBhy7j1gVzNWaMZpLEIlzHsv/vcn
 mubMvup3rzG4YTj5NnFN0rn2XXGyBCvq+lJ0R9JxAH8CS3BzG4Yn7xpJkQDSOJs7KfjwVJT93
 edylQgUhYMo7VU4ebjDGXPxK5K1bnQ2trJV2v6uTiGehjvoZ5ipVauqAWx2PTS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0033-dsa-multi-cpu.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 include/net/dsa.h  | 4 ++++
 net/dsa/dsa_priv.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 23690c44e167..3efa81e08993 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -203,6 +203,10 @@ struct dsa_port {
 	struct net_device	*bridge_dev;
 	struct devlink_port	devlink_port;
 	struct phylink		*pl;
+
+	struct net_device	*ethernet;
+	int			upstream;
+
 	/*
 	 * Original copy of the master netdev ethtool_ops
 	 */
diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 9e4fd04ab53c..cc0cd7675117 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -81,6 +81,8 @@ struct dsa_slave_priv {
 
 	/* TC context */
 	struct list_head	mall_tc_list;
+
+	struct net_device       *master;
 };
 
 /* dsa.c */
@@ -188,7 +190,10 @@ static inline struct net_device *
 dsa_slave_to_master(const struct net_device *dev)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_slave_priv *p = netdev_priv(dev);
 
+	if (p->master)
+		return p->master;
 	return dp->cpu_dp->master;
 }
 
-- 
2.17.1

