Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479473-3-13671474319064448579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521479470; b=lgNNMylDtsX/Xn+v0JkmXqAdVu4DZeasxR9BUlxEooqsbl1
    CoGOSqwuykrHJAcyVkYlP+WhN86xJrnR417AXVL3wLJVgFFZNmkR1k3RzPpulFnS
    5T6SkoHIEkq4qAH++PuvRKUIwhyDrWiFwpnN3HrfsV8DRNnZZl1KmkzFXMGn0PTq
    +Vjw8iI9qigfbHCsXu+x0OT06m1dgZ0+zoi4kz2x5yTjZcUaE5TveTwy6RuILcqz
    d4NxdUjEv91Wuycw9E84A5q6Jgo/zKG/PfYALYRmecXVaw9J4p/E2iwUJaI7nHvb
    cg2Pe0CYKZ6/XOKYxP/DUJRekX0rCsQ6O7+iMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479470; bh=hEvSNM
    dt0S+Z/0Aq6X9c6sDHRtkEHxE1s4axnpyfAq8=; b=kKMGZRk5w8lIbb4iq4Revh
    TX8UNP6SR7YMEl4nSEEGYiOWeHCwQOU2RNLJd5f3erdLSX9L2G0aU4bd0Ue1vyGs
    0HxmA34NRH4lZF71Ezstpvtu7IwLg6i68E8xnDzIZYsw9mxc9BEud7iEA+sP+yCY
    bVJoOZS3U1NXtXSyua2+7pIwnxNTIA5WSVIzckaIsIpEUUEtzcS59kPSg91t4uYD
    zdKlblGYhMyhZPIe+BZ00m4enaPcFdkYOEekKFdZmvmm8aQF/BTex/cxBigyobys
    aPCxS9l+vnn5yxrZzCHSRGR5I/q5lEPyV6Aj2pI+sKrxtC0ESwyKcOizpLu2b6/g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PmMMWSMg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtfeeljeenucevlhhushhtvghrufhiiigvpeegge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PmMMWSMg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtfeeljeenucevlhhushhtvghrufhiiigvpeegge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967866AbeCSRKx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:10:53 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:62326
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966632AbeCSQKj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Talat Batheesh <talatb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 123/167] net/mlx4: Fix the check in attaching
 steering rules
Thread-Topic: [PATCH AUTOSEL for 4.4 123/167] net/mlx4: Fix the check in
 attaching steering rules
Thread-Index: AQHTv5xxJ0k4swKQlUKt1N5+dJsQWg==
Date: Mon, 19 Mar 2018 16:07:56 +0000
Message-ID: <20180319160513.16384-123-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:byQZAvMlHXzhh9Hc8p9t7f9vy7ks+hJCUtCgdY2OUh7MIK5r1dldPUfMHI0v/sTx9HNMwRTVeVBltc4UT+mUfwuDkcjaSo3Y1k8UnuEw55G98uKWLaRVHrpp1uLpKqDD31S43iJYKzBclwklbhOXxBUtej8nlL+nJAYjRP1dJuLPAmz9lhtxIuhYTx9zah3cmQqsylIcVdgE0kvU6sVtpmAk8D3ZdrTR+PCotM4/2irY6xkXPg5Yw9UweBoFlOYK;20:MV2kBpwlmGv2HCZOsVvQpMDDgTO0J4uo0SZlK+RwviadeRFGvFWWKqf3+mfAlQ1eIhrdvYjLIJO612PwdIi7f9q0YsyId7bbTbbCKM1oDOxvrlmRlwfT2OMg5s7qu7zlE4uIMyUU4wrNsxm8ez0rq6ed8GA0d+7KOXUYv3weiuc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fc31473-8bb6-4a71-8579-08d58db3f276
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045F9D6EE37FFE4EDB56CA8FBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(5890100001)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(102836004)(8936002)(6512007)(7736002)(3280700002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(2906002)(14454004)(81166006)(316002)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(59450400001)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3G0EjtvWmZHQZds7X9j3lntUPWzslq2G6IFHslMZtOogx9Sblbl1h+Sk3Ql80H95Z9Nq7HlS2UwYqW9yvdx1j2jQ9x1Kho7OlYrf8L1N8LR0JAJ27UBtF+le2QWPHSTdo7hqVMHOMPqDZmrBqdvPUSJV0i6SjaoNOhgomWrkBtsCheApE+SbkkLcjQmvVTg8sW0i2CtlPVdG+5MqmqCs2cksRAc+8wGPxcONHVW/8UGKETRQRExGPi41Lx+0afMnlNNLk+0aDbfqCN/apZLQUtxfbGlYpNXBvbEC87btOHd3M8IXnKPgwE1Z9UJg1d4jMLv/xgFSW8zSq6v4tUuZNw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc31473-8bb6-4a71-8579-08d58db3f276
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:56.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
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
index d9bb185f7320..ddb5541882f5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1513,11 +1513,6 @@ static int mlx4_en_flow_replace(struct net_device *d=
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
index 1d4e2e054647..897d061e4f03 100644
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
index d8359ffba026..d73370541e92 100644
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -381,6 +381,19 @@ static void mlx4_qp_free_icm(struct mlx4_dev *dev, int=
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
index fe052e234906..bb1018882199 100644
--- a/include/linux/mlx4/qp.h
+++ b/include/linux/mlx4/qp.h
@@ -465,6 +465,7 @@ struct mlx4_update_qp_params {
 	u16	rate_val;
 };
=20
+struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, u32 qpn);
 int mlx4_update_qp(struct mlx4_dev *dev, u32 qpn,
 		   enum mlx4_update_qp_attr attr,
 		   struct mlx4_update_qp_params *params);
--=20
2.14.1
