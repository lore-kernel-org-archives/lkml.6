Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481361-2-17528213997163378036
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481361; b=IUtA2/dv8og2RxtF8XRL8Jq/IDlowDt9BHbbXYslj/jdeAo0C0
    f0j+YhRwGBF+Y1NJ090jAmLPBPnX71PKkzW57KY1A0ffAVKszlk9r6UcQf8oTTto
    ZHYpkOK78qCgDryHN6Z5b0exJckw1s+sKVbdpYylDbKwWbZNpqk7Y22U8nW39ivN
    artLmCmI1f4MRqP0YuZXKmUleA0A83hcJYOaxstZ2bn++3YbG24hdkE+Pm4vE/bn
    vOp588u87729gNABQ/zsP/ypdKjlNImlBOO+e4IFfWG8Wb5ROUU+Q7pJ9WN4RJZO
    4mE4tRbkVOu1tYVw2Wm0C7Jbp8ARO31fAWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481361; bh=tdgMJgpoI8h9FN6pQk2hmBHoFkF0Eu
    Ac8NArLAjT5Fw=; b=n0u7Tfa7PX4IigKTPpGvknnXaVLEG6HAzoYfCgbGx+PeyE
    6ry3V+ANy5bPjS8fAlPFHW4I2Rdy6Cm0mdZogTKI54PuR+2+d31U1UwCkTN9sKUx
    BOQtiJCmUFS7PgCSQ79n+EZi7qTxj2S4iKDyihjh3mA0LW3bdztrNdTeHDXdxcCI
    kJUNaxCE+fY5mKKiDzAH4jOxbGz9i+5mxJ6uZHc6Qsok3XJW3rLSbUGE3wyen6s2
    mi5g72OkD+z8ReDgabiDcSuWB5nfcKTgyglHxH9C/TaGaNlTk2Jdyzka60xiYger
    bUL8UeGUzSaT7xc7wNa4VGTq+6GabnN1V7yShdLg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGaS2RvBAQX5MrAaZPQH6zAr0uIAgqmFPBp9XmAfHzmROJI+Xvs0Wi94u16zaY5glaZILBDOyLKw/XDdBmLCP88TE4ygBkzwesBJMpePB54I7oIRPY8h
    qxMDlimwWkUF4s84wEsYuzjokWMENuG5WHsRVpOmDLbnEIbNDMJeBszatv6POS4IZnE+6nJ/DNaEef4mj864GgfgTAoZcZuuEjqf7AL7wnRD1Oa9rvTXV11y
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=zYHZDPIpNYb0iLdz6LgA:9 a=dN-RdG7GbiPl86Hb:21
    a=5EAwCIaXmZpp-NkQ:21 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeDKVPM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:15:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754717AbeDKSku (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <gerlitz.or@gmail.com>,
        Talat Batheesh <talatb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 068/121] net/mlx4: Fix the check in attaching steering rules
Date: Wed, 11 Apr 2018 20:36:11 +0200
Message-Id: <20180411183500.310965107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Talat Batheesh <talatb@mellanox.com>


[ Upstream commit 6dc06c08bef1c746ff8da33dab677cfbacdcad32 ]

Our previous patch (cited below) introduced a regression
for RAW Eth QPs.

Fix it by checking if the QP number provided by user-space
exists, hence allowing steering rules to be added for valid
QPs only.

Fixes: 89c557687a32 ("net/mlx4_en: Avoid adding steering rules with invalid ring")
Reported-by: Or Gerlitz <gerlitz.or@gmail.com>
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Acked-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |    5 -----
 drivers/net/ethernet/mellanox/mlx4/mcg.c        |   15 +++++++++++----
 drivers/net/ethernet/mellanox/mlx4/qp.c         |   13 +++++++++++++
 include/linux/mlx4/qp.h                         |    1 +
 4 files changed, 25 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -946,11 +946,6 @@ static int mlx4_en_flow_replace(struct n
 		qpn = priv->drop_qp.qpn;
 	else if (cmd->fs.ring_cookie & EN_ETHTOOL_QP_ATTACH) {
 		qpn = cmd->fs.ring_cookie & (EN_ETHTOOL_QP_ATTACH - 1);
-		if (qpn < priv->rss_map.base_qpn ||
-		    qpn >= priv->rss_map.base_qpn + priv->rx_ring_num) {
-			en_warn(priv, "rxnfc: QP (0x%x) doesn't exist\n", qpn);
-			return -EINVAL;
-		}
 	} else {
 		if (cmd->fs.ring_cookie >= priv->rx_ring_num) {
 			en_warn(priv, "rxnfc: RX ring (%llu) doesn't exist\n",
--- a/drivers/net/ethernet/mellanox/mlx4/mcg.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mcg.c
@@ -35,6 +35,7 @@
 #include <linux/etherdevice.h>
 
 #include <linux/mlx4/cmd.h>
+#include <linux/mlx4/qp.h>
 #include <linux/export.h>
 
 #include "mlx4.h"
@@ -985,16 +986,21 @@ int mlx4_flow_attach(struct mlx4_dev *de
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
+	if (!mlx4_qp_lookup(dev, rule->qpn)) {
+		mlx4_err_rule(dev, "QP doesn't exist\n", rule);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans_rule_ctrl_to_hw(rule, mailbox->buf);
 
 	size += sizeof(struct mlx4_net_trans_rule_hw_ctrl);
 
 	list_for_each_entry(cur, &rule->list, list) {
 		ret = parse_trans_rule(dev, cur, mailbox->buf + size);
-		if (ret < 0) {
-			mlx4_free_cmd_mailbox(dev, mailbox);
-			return ret;
-		}
+		if (ret < 0)
+			goto out;
+
 		size += ret;
 	}
 
@@ -1006,6 +1012,7 @@ int mlx4_flow_attach(struct mlx4_dev *de
 	else if (ret)
 		mlx4_err_rule(dev, "Fail to register network rule\n", rule);
 
+out:
 	mlx4_free_cmd_mailbox(dev, mailbox);
 
 	return ret;
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -358,6 +358,19 @@ static void mlx4_qp_free_icm(struct mlx4
 		__mlx4_qp_free_icm(dev, qpn);
 }
 
+struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, u32 qpn)
+{
+	struct mlx4_qp_table *qp_table = &mlx4_priv(dev)->qp_table;
+	struct mlx4_qp *qp;
+
+	spin_lock(&qp_table->lock);
+
+	qp = __mlx4_qp_lookup(dev, qpn);
+
+	spin_unlock(&qp_table->lock);
+	return qp;
+}
+
 int mlx4_qp_alloc(struct mlx4_dev *dev, int qpn, struct mlx4_qp *qp, gfp_t gfp)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
--- a/include/linux/mlx4/qp.h
+++ b/include/linux/mlx4/qp.h
@@ -437,6 +437,7 @@ struct mlx4_update_qp_params {
 	u32	flags;
 };
 
+struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, u32 qpn);
 int mlx4_update_qp(struct mlx4_dev *dev, u32 qpn,
 		   enum mlx4_update_qp_attr attr,
 		   struct mlx4_update_qp_params *params);
