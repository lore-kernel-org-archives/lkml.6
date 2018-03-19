Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476056-2-4455651047842711816
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
    t=1521476055; b=dPgZiZh9yqJeb6WEdDY5toLwp2dOl7u+3i7gclGBc/6+C6v
    oeCx3Fwz4GieoOSySmWfs89Tx7HW+YAlrjnoxqGQK6RsY9iOek2j6USTY1Yal7J0
    Ogz1rigQSXvMy9Bcns7p6I7F06S1IRGUGFb9g3YLYfAthg1NDvBB+5rsGbaeXLvE
    TASfayQW84oUBsjo7WWCdhU2grSjfyFvTHMdlqPNNrKjmanFVIWov7vS75/BxNwX
    tmdAsmiNhemoayfbvEbc1PzVRUgyUkA3/sJXZFlQK5KD+taznRZz7yG4sf2mEoyX
    jZ6aClpioAYfPehKSd/A9kqHFKvMuH621Z67JOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476055; bh=8ul9LT
    I9Zfam9Ymdg4QgWJ+hg3qCDpYCm05V6dDwrOk=; b=ZaDYRt4KUkHKHOeo/dqd16
    4uRXOLEBbMuP2Ibk0tklT+bEYfuvnamA/GAOnipVzXJqKR2ack7rM7WPTMEA43pV
    XR8Mv5ZesvHgqqq37t+eh4nqKMI6zyVIFjXhUeVadTvGBfvNSogHcqrDieGybbYH
    G5/+iBsiN6SgL/813PoqTyqQF5Jj3eS8CjJQ/ASkRPvgZ4ZCR+m74SXf1kmrd7xO
    Ph7Tf9oHcOYXcnWDDSiycsUWpfiaYecqKaImW29Kt/KAnzzygGg91zbhJ2BuF/Qm
    wb45TeKdG7K35QXy42KcMdIdPO5Jr3IDybQzjtM2cCdrztcely3DeNKRptYcHXJg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Uu56A4/2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtgeehleenucevlhhushhtvghrufhiiigvpeejge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Uu56A4/2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtgeehleenucevlhhushhtvghrufhiiigvpeejge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966915AbeCSQOK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:14:10 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:53605
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966898AbeCSQOF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Talat Batheesh <talatb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 070/102] net/mlx4: Fix the check in attaching
 steering rules
Thread-Topic: [PATCH AUTOSEL for 3.18 070/102] net/mlx4: Fix the check in
 attaching steering rules
Thread-Index: AQHTv50lZytOoSpAQ0Ov1d6QJC8XTg==
Date: Mon, 19 Mar 2018 16:12:57 +0000
Message-ID: <20180319161117.17833-70-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:ODSiyFn7iap40nW0YLHLyXXmJVW5gF5NZbCI6tFAQF/6UtcbIPF5yVxN23AH0shYOwUz7Jvif4jcx3GlRsCE9qjfsx70eAHC7OoXI7KY/E/qULJxHwOF5wSP5/xSUs99JEj7B8o8FFhjyx51p4fkDp+JPctRjlqEFF3+PLAii2ZhZGTk2XkARbKmGYPEliU+wlWCVMfB36qLv0RokcvTkGsJX2o57h2VYDbTWIRTEHKNRXzJkZauR7rCpum8CvAG;20:XAC39gXkxskZ0/bAa8QAihact7ckr9JLaxks9JUCYIwTzZBGnFHrCzva6FJZOeQlGy6tFDELPmh+DqeVlUZL4GAhawKVmP5DJdvxrami6Rova+8kVyrfig9NtgptuHTaiSG2W1niUX2JvBVOQIIdEPDb3jPnXFd6jXGpyGNMXZM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32847c89-4df4-4198-1f0f-08d58db46c1d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106355C947B2C3BE719155D6FBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(5890100001)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(59450400001)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: l+qrJOz0CXAJteWKmklyFHwfNibqL1sNsg6up6sjsjmQlDJY6XXQF7J28KVnw/xOH4+4MPTEaFTki3jFO2xrdXsaUP00ieaNpI0kJn2KBffTptYxDjl/mcfVntzWEfUQJXS5TBC+ulkB/6fnABfuc98X2WJJfielP6JUzKsWdoWhFzQ7mL+cztpqEw4X1UXBeuf3UMnUWqT3Re1ageaEBfRfYmQZ2v5JrDeTgT33D8tyyVstjA9oPm0v9QZKhciTr5Oxlxtuq1cBSORUInapLEEPNHeYqpzsmW47swfWxkwhhaWMA6gSe0Vifg7HaoP7gNkwx+M9XmMGiwATyjbRyg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32847c89-4df4-4198-1f0f-08d58db46c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:57.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index 17b3950e04a7..ae83da9cd18a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -946,11 +946,6 @@ static int mlx4_en_flow_replace(struct net_device *dev=
,
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
index 872843179f44..c704e7bcda9d 100644
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
@@ -1006,6 +1012,7 @@ int mlx4_flow_attach(struct mlx4_dev *dev,
 	else if (ret)
 		mlx4_err_rule(dev, "Fail to register network rule\n", rule);
=20
+out:
 	mlx4_free_cmd_mailbox(dev, mailbox);
=20
 	return ret;
diff --git a/drivers/net/ethernet/mellanox/mlx4/qp.c b/drivers/net/ethernet=
/mellanox/mlx4/qp.c
index b295eeb2af69..87e00742d401 100644
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -358,6 +358,19 @@ static void mlx4_qp_free_icm(struct mlx4_dev *dev, int=
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
index 5f4e36cf0091..30a73892a8d6 100644
--- a/include/linux/mlx4/qp.h
+++ b/include/linux/mlx4/qp.h
@@ -437,6 +437,7 @@ struct mlx4_update_qp_params {
 	u32	flags;
 };
=20
+struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, u32 qpn);
 int mlx4_update_qp(struct mlx4_dev *dev, u32 qpn,
 		   enum mlx4_update_qp_attr attr,
 		   struct mlx4_update_qp_params *params);
--=20
2.14.1
