Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482474-2-1214236335696269332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482473; b=V82k+KWfcT2nEtRkG2UBh7ZLOYat1s+7eRQbfeddAzXWt38
    BKyG6oBSlZASgKS0Hc3JU1LyiD8TLB9CpL7PuCajHKYnpuCWMLkXU69XdAtu1zcf
    nG+VPr2Xazpxc7v1kW876AItFMkLECWuYRLkbv2n3CZOrdqwCBrH6VzPrZKip454
    YqcmQA0WNXwjUJxsJKlGwJqTZ3Vk3nwfLaB3+MK7WpWLW70WF8oLCECxYzHlCovx
    NHM8e/elxavFnvWYcIaHuPRTt4+xFfhi2jEPdBLMtoya2kgc3yA28ZIVwlxzeaDh
    4EquD4Tps4F32TolPxXjiBGI1wOEyDOjxww+QEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482473; bh=tUF7wZ
    +K4VNZbaCXMI/RtpFxxfzmf6I02H89EHbJzq4=; b=WiOFYIvoT3YHnuk9XlIOZY
    WIrk2+p5RQ60/6/rJmd0RuYCo6jAEKvvaEyxb5gG7TCju0lT+KTPT6LAj+cZUWUb
    fpGvaK+mAA5JOvwygLnDoKmcKqo/9JhcH3d6m7MFkWSMyKrUecgufwgXCFsRJhu8
    NOyQS4rAd0CdyrFfbtsLFuVUk2V32oDTe1SvUxiUXDQpknvYiwftG//OXZTCtntL
    ZBpd4JKMcllfqjFDP3+BUCNz9f8/YIcMVZP7DhGUb/o442mkGCrTDdso4M4SvZKh
    cqx3QOgza4ALKKcxZVjoc/SAOO0ilMnEyBM4G8AWJHsUBWI1sFd9WXyxCV4Q1Zog
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b3FqyqHO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdegtdelnecuvehluhhsthgvrhfuihiivgepkedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b3FqyqHO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpedutdegtdelnecuvehluhhsthgvrhfuihiivgepkedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934516AbeCSSA5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:00:57 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:27376
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935047AbeCSQEE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Talat Batheesh <talatb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 198/281] net/mlx4: Fix the check in attaching
 steering rules
Thread-Topic: [PATCH AUTOSEL for 4.9 198/281] net/mlx4: Fix the check in
 attaching steering rules
Thread-Index: AQHTv5uVkx8aBSA8bUmt9qGyp0B2DA==
Date: Mon, 19 Mar 2018 16:01:47 +0000
Message-ID: <20180319155742.13731-198-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:nHhNZco+tqQ65aquD9KJD/ptALkmS2TXVSQ+2yZsIyFL1tAXtVf1nf3HmjoKLEewAAA7eBDmh9oAJrcl/3uBeGXI6bchIp7uiq8HhujCghS2M92i6dhQQW8ceQ+YTQbuFTGf6tvZEWUsOaG2ADczvW2FdZyPFf+wX6ZPiVP8Fx5y1pCbuKcBcfsKEwdnL7Zd4k91JAfJlRIPZFN6XrkKGkGs0MA7e88o8vp1BaY3q3olq2PdMeRRCCI1eZKy7ko4;20:BuyaHpTaiieTpogIopDXsmABFxGkkGgY3TN4gMLETE3jVT7uMkYXTDng+ibFPMqpwGKAq80psUBxcAxYnrP4YGxrF/Ug3HjJufFNesLKrzWgmuWyCosfk677IqEe84gdO5/iyJKNbe6kELpqy5M8XquixPJOg5EjhCar0uLT6Qw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 474294e1-ee3b-4f55-bfcd-08d58db3050c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10771C228BC75636C85AD177FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(5890100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(575784001)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: diBMBJmSmIdNDLaKP/kThIipnOvgpYn7qGV/sziVHrjyFDjVIijjhoNWImMAFiSNHIJkjjRpHkzD56yhDd1tJYfk9/mCPX4yINfsbx3Xs8FMq+fhRA9wyucBF1rQ19iqqioO+abRlTHLT2pOYCGRBA8CUD+uC8vwYbQovM0QIgvXAUJJU23V4atnk+aG9/gHrDHnDRryRRBPVnfr6DpCu6RM/AVfCLm/eRpgUWiXEz1/HIT+bGhCQJn/qyisWgGoYcJebMqdA+1Nfqgb1P4hOReBjGVIz58GrYxMt0k1uypeZ8bEbdfFTwuzZ30vRLvIA7ER31i5ZjQcWcPl5a3Xug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474294e1-ee3b-4f55-bfcd-08d58db3050c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:47.8621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Talat Batheesh <talatb@mellanox.com>

[ Upstream commit 6dc06c08bef1c746ff8da33dab677cfbacdcad32 ]

Our previous patch (cited below) introduced a regression
for RAW Eth QPs.

Fix it by checking if the QP number provided by user-space
exists, hence allowing steering rules to be added for valid
QPs only.

Fixes: 89c557687a32 ("net/mlx4_en: Avoid adding steering rules with invalid=
 ring")
Reported-by: Or Gerlitz <gerlitz.or@gmail.com>
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Acked-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |  5 -----
 drivers/net/ethernet/mellanox/mlx4/mcg.c        | 15 +++++++++++----
 drivers/net/ethernet/mellanox/mlx4/qp.c         | 13 +++++++++++++
 include/linux/mlx4/qp.h                         |  1 +
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/=
ethernet/mellanox/mlx4/en_ethtool.c
index 674246b189c2..bdda17d2ea0f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1520,11 +1520,6 @@ static int mlx4_en_flow_replace(struct net_device *d=
ev,
 		qpn =3D priv->drop_qp.qpn;
 	else if (cmd->fs.ring_cookie & EN_ETHTOOL_QP_ATTACH) {
 		qpn =3D cmd->fs.ring_cookie & (EN_ETHTOOL_QP_ATTACH - 1);
-		if (qpn < priv->rss_map.base_qpn ||
-		    qpn >=3D priv->rss_map.base_qpn + priv->rx_ring_num) {
-			en_warn(priv, "rxnfc: QP (0x%x) doesn't exist\n", qpn);
-			return -EINVAL;
-		}
 	} else {
 		if (cmd->fs.ring_cookie >=3D priv->rx_ring_num) {
 			en_warn(priv, "rxnfc: RX ring (%llu) doesn't exist\n",
diff --git a/drivers/net/ethernet/mellanox/mlx4/mcg.c b/drivers/net/etherne=
t/mellanox/mlx4/mcg.c
index 1a670b681555..0710b3677464 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mcg.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mcg.c
@@ -35,6 +35,7 @@
 #include <linux/etherdevice.h>
=20
 #include <linux/mlx4/cmd.h>
+#include <linux/mlx4/qp.h>
 #include <linux/export.h>
=20
 #include "mlx4.h"
@@ -985,16 +986,21 @@ int mlx4_flow_attach(struct mlx4_dev *dev,
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
=20
+	if (!mlx4_qp_lookup(dev, rule->qpn)) {
+		mlx4_err_rule(dev, "QP doesn't exist\n", rule);
+		ret =3D -EINVAL;
+		goto out;
+	}
+
 	trans_rule_ctrl_to_hw(rule, mailbox->buf);
=20
 	size +=3D sizeof(struct mlx4_net_trans_rule_hw_ctrl);
=20
 	list_for_each_entry(cur, &rule->list, list) {
 		ret =3D parse_trans_rule(dev, cur, mailbox->buf + size);
-		if (ret < 0) {
-			mlx4_free_cmd_mailbox(dev, mailbox);
-			return ret;
-		}
+		if (ret < 0)
+			goto out;
+
 		size +=3D ret;
 	}
=20
@@ -1021,6 +1027,7 @@ int mlx4_flow_attach(struct mlx4_dev *dev,
 		}
 	}
=20
+out:
 	mlx4_free_cmd_mailbox(dev, mailbox);
=20
 	return ret;
diff --git a/drivers/net/ethernet/mellanox/mlx4/qp.c b/drivers/net/ethernet=
/mellanox/mlx4/qp.c
index 6143113a7fef..99c8fc970f88 100644
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -387,6 +387,19 @@ static void mlx4_qp_free_icm(struct mlx4_dev *dev, int=
 qpn)
 		__mlx4_qp_free_icm(dev, qpn);
 }
=20
+struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, u32 qpn)
+{
+	struct mlx4_qp_table *qp_table =3D &mlx4_priv(dev)->qp_table;
+	struct mlx4_qp *qp;
+
+	spin_lock(&qp_table->lock);
+
+	qp =3D __mlx4_qp_lookup(dev, qpn);
+
+	spin_unlock(&qp_table->lock);
+	return qp;
+}
+
 int mlx4_qp_alloc(struct mlx4_dev *dev, int qpn, struct mlx4_qp *qp, gfp_t=
 gfp)
 {
 	struct mlx4_priv *priv =3D mlx4_priv(dev);
diff --git a/include/linux/mlx4/qp.h b/include/linux/mlx4/qp.h
index b4ee8f62ce8d..8e2828d48d7f 100644
--- a/include/linux/mlx4/qp.h
+++ b/include/linux/mlx4/qp.h
@@ -470,6 +470,7 @@ struct mlx4_update_qp_params {
 	u16	rate_val;
 };
=20
+struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, u32 qpn);
 int mlx4_update_qp(struct mlx4_dev *dev, u32 qpn,
 		   enum mlx4_update_qp_attr attr,
 		   struct mlx4_update_qp_params *params);
--=20
2.14.1
