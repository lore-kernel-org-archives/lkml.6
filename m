Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB39C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4E820811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4E820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeLKTeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:34:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:54073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbeLKTeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:34:16 -0500
Received: from localhost.localdomain ([91.14.83.44]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MIMQR-1gawO50CBr-004BML; Tue, 11
 Dec 2018 20:33:38 +0100
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
Subject: [PATCH 5/7] [DSA] dsa multi cpu (mt7530.c)
Date:   Tue, 11 Dec 2018 20:33:12 +0100
Message-Id: <20181211193314.10695-5-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211193314.10695-1-frank-w@public-files.de>
References: <20181211193314.10695-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:5uvOk/q14HGD/2jzna7B3U2QGMeJRss93L6l5tAEsPqt/qo3/Hw
 t7VaXEHRIIA7NMGwrxTwhiX8YWXtwfc11WQHdBJ1SWuQqRvy5JKjYFxEgWMT2HoVlUUIT6C
 PCumzkRhSKMVPZOCsVVLgByZK/mcQb5qnDR0S5uAQV7A29uuY5YeCgJ4lSfy9ZgCcEVclLy
 buWSmwu++8+erchKPNfCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BMNNK1OnT98=:h1qKaSYRqTo/SAex7o6JMe
 +xB5izfUyJ8DAFJvvoIm3EWFPo+wu252uy3adsuRB+TDLCzOzpLqVCBUU8Cg5d+pzsJgVtD6R
 +JrvxIPcEYAmkJp7k3B9ag0rF6t9q36bW/N3gjwQvw0ciXHWzy/D3q7Q1gGPNOCCd8DabE8Ew
 t/nSH0vGsne50a7Yp9x8prNRbLhqqJSd9LM9jKE5ReGbQmqmr/W8+5ZfsYuI1xhOmNHVDGXr5
 +CIamvt/Q1Y+tEQuYEVcZgGAAppRmEUZOXFvR1b7fFP7KpfVIp5I7Pe3OjyHtjQGvmY7flKVk
 KY1EMIyYC59xwMmneq+n3Rjo3woBzRC1jgZNxLqh1pMqW68LdyczPleMiEmb/VMbfrR/POc0y
 oaqxTgtfkJQZ4kZ6jLN2HLHxzcAdoQ6Gq7wTU5AmaP+6zMXgIf3ryOj91zhEZgsm33xT3ry/J
 H9lYJq3A4dSIKQS2Wf0uxMo7QLnpHHqd7PaOTeOq+7JRFPm6jz10f1bASY4/tmx9g6kaBSZqG
 +oD6gOrYqCjcPxX01H5+KrJvIaAoM5E42xLEjYlA9wfJlhJdO/lzvwdGoR3WTyAg0O6i+deym
 QKencgKCp2yfsVwqvKqT4448fCGpHKxkMP+UxPFLAp31BYIEgHrdsio0iGCYsc471sGecuNmI
 cldDx7eheSeCgtI2oabkkBNPykfQ7RDS8byKYWhg2aeE6bKh1LJqbGsjFUscoLlTaiCc0+0SJ
 x6hdguX5BWoZyscaS+/6JYft7snG8zHXcm2Q3I0fO6wrqLTrI9ahmphFsBaQoxtVXfi0oaVcC
 bigyBayu9tA5z7vfabydBHxLkAPBzWVGEtbqO4x4qB8b9zG4CD+AiDlDwx9kssQAC2IuOqMoY
 Mz++mS1aqOoBenLrkpwvAXGNisUufN5V/UTbR8pTLCA1txg9tPcYzkXXhsYGB4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

based on
https://github.com/openwrt/openwrt/blob/master/target/linux/mediatek/patches-4.14/0033-dsa-multi-cpu.patch

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/dsa/mt7530.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index a6a15a063e3e..441320d4d779 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -674,6 +674,9 @@ static int
 mt7530_cpu_port_enable(struct mt7530_priv *priv,
 		       int port)
 {
+	u8 port_mask = 0;
+	int i;
+
 	/* Enable Mediatek header mode on the cpu port */
 	mt7530_write(priv, MT7530_PVC_P(port),
 		     PORT_SPEC_TAG);
@@ -690,8 +693,14 @@ mt7530_cpu_port_enable(struct mt7530_priv *priv,
 	/* CPU port gets connected to all user ports of
 	 * the switch
 	 */
+
+	for (i = 0; i < MT7530_NUM_PORTS; i++)
+		if ((priv->ds->ports[port].type == DSA_PORT_TYPE_USER) &&
+		    (dsa_port_upstream_port(priv->ds, i) == port))
+			port_mask |= BIT(i);
+
 	mt7530_write(priv, MT7530_PCR_P(port),
-		     PCR_MATRIX(dsa_user_ports(priv->ds)));
+		     PCR_MATRIX(port_mask));
 
 	return 0;
 }
@@ -701,6 +710,7 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 		   struct phy_device *phy)
 {
 	struct mt7530_priv *priv = ds->priv;
+	u8 upstream = dsa_port_upstream_port(ds, port);
 
 	mutex_lock(&priv->reg_mutex);
 
@@ -711,7 +721,7 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 	 * restore the port matrix if the port is the member of a certain
 	 * bridge.
 	 */
-	priv->ports[port].pm |= PCR_MATRIX(BIT(MT7530_CPU_PORT));
+	priv->ports[port].pm |= PCR_MATRIX(BIT(upstream));
 	priv->ports[port].enable = true;
 	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
 		   priv->ports[port].pm);
@@ -774,7 +784,8 @@ mt7530_port_bridge_join(struct dsa_switch *ds, int port,
 			struct net_device *bridge)
 {
 	struct mt7530_priv *priv = ds->priv;
-	u32 port_bitmap = BIT(MT7530_CPU_PORT);
+	u8 upstream = dsa_port_upstream_port(ds, port);
+	u32 port_bitmap = BIT(upstream);
 	int i;
 
 	mutex_lock(&priv->reg_mutex);
@@ -875,6 +886,7 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 			 struct net_device *bridge)
 {
 	struct mt7530_priv *priv = ds->priv;
+	u8 upstream = dsa_port_upstream_port(ds, port);
 	int i;
 
 	mutex_lock(&priv->reg_mutex);
@@ -902,8 +914,8 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 	 */
 	if (priv->ports[port].enable)
 		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
-			   PCR_MATRIX(BIT(MT7530_CPU_PORT)));
-	priv->ports[port].pm = PCR_MATRIX(BIT(MT7530_CPU_PORT));
+			   PCR_MATRIX(BIT(upstream)));
+	priv->ports[port].pm = PCR_MATRIX(BIT(upstream));
 
 	mt7530_port_set_vlan_unaware(ds, port);
 
@@ -1194,15 +1206,7 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 static enum dsa_tag_protocol
 mtk_get_tag_protocol(struct dsa_switch *ds, int port)
 {
-	struct mt7530_priv *priv = ds->priv;
-
-	if (port != MT7530_CPU_PORT) {
-		dev_warn(priv->dev,
-			 "port not matched with tagging CPU port\n");
-		return DSA_TAG_PROTO_NONE;
-	} else {
-		return DSA_TAG_PROTO_MTK;
-	}
+	return DSA_TAG_PROTO_MTK;
 }
 
 static int
@@ -1275,7 +1279,7 @@ mt7530_setup(struct dsa_switch *ds)
 
 	/* Enable Port 6 only; P5 as GMAC5 which currently is not supported */
 	val = mt7530_read(priv, MT7530_MHWTRAP);
-	val &= ~MHWTRAP_P6_DIS & ~MHWTRAP_PHY_ACCESS;
+	val &= ~MHWTRAP_P5_DIS & ~MHWTRAP_P6_DIS & ~MHWTRAP_PHY_ACCESS;
 	val |= MHWTRAP_MANUAL;
 	if (!dsa_is_cpu_port(ds, 5)) {
 		val |= MHWTRAP_P5_DIS;
-- 
2.17.1

