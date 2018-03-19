Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497351-2-1336808749354090372
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497350; b=rhAMPw6+L+jCOgBn9f0N8Y0wfNzkNMZJLur3xcF2oxS0URo
    C8sh3pFKMbZY99UU0am8bef1EYTpknSAciEGZDG5fdnzBfvDdcu6Kwq1mD4T8Hg1
    o5Pejj1FuwmZzpqeLgollan4WMk24XILxq7sx3Bd/KkIb6zPrm2PRnI1dOFBdf5/
    fJ5dqzzGmsYlm6p3fPOSxOd/OlrT/pH6/A2ERaW3jeYklKsBFpvezHyr/ef+8mv8
    VRUvzwnjh4K7ZUIXqdgbvzCSugYRacZFJDfeB25QJnNg+8kU25xupRZEeNA/XpTj
    O4jts13io8hCzJZFYDwGq8kNoJjNS+qrREY6vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497350; bh=V46bM4
    tqjozHy8/8EI81Z2qy6c0BsbuvHowx3u/oOS4=; b=HvZk2OLMvPuFxHy4Ph+J53
    dC58Jl2Qc8IsM9XIUpUG1AetSXhhy7ozcUGstPof2rr7xXMZUxzXS2rHWOro7kFz
    leHL09hx0OU2WD2+Re4pnDvZ1PIBdhCthzGnCTNN1fR+A4j7hxM6PfXr+OJxPjwr
    NBdmQe1BMGRnutb4sio6zfbOwFJG0OCzxuSV+BwcuqJhH76bgIKOwSHLq+PABpVs
    UTgiGgyeWj9aEfrrv0c+xjXX7ePpPc8oQP6pFU4V1On48r1WT0ufcIJA/WXOe1pE
    oeoznphsWryzS4lGyM0IETKjvbmUupKj6GKVJAQUvS552qnwCLl/PqADyG+VaPbg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hjLQsqNB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheehheenucevlhhushhtvghrufhiiigvpeehke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hjLQsqNB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheehheenucevlhhushhtvghrufhiiigvpeehke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972276AbeCSWJH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:09:07 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:46720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934322AbeCSPyw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:54:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moni Shoua <monis@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 17/97] net/mlx4_en: Change default QoS
 settings
Thread-Topic: [PATCH AUTOSEL for 4.14 17/97] net/mlx4_en: Change default QoS
 settings
Thread-Index: AQHTv5qXewGlMS9aV0mmGGuxQ4BSyw==
Date: Mon, 19 Mar 2018 15:54:41 +0000
Message-ID: <20180319155411.12348-17-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:Wm6CDEK8R5JC94q7XBAw3ryKigUvbr0COM7RFAtpizniitdRPNwA/hNqHMM8iTY5yf55o22djzfVcmgqAlTpSKS6Ao/2Jx+qYYZ68J7mHrZO0i3h2iCuY330X6Na+YwFBie/t+0IdWna6wptqNM+32SmpxICAVywaSCf5JAQaJj7JnEkINC2g4eoZOA2asPPsIiADAQit39XAKksBO3V4AiFQMDFeFys7GFNYWq+Sh8tLufZnccql0UtJUBnzEiN;20:NV/Pne/HI0e9tmV8+YwtamXXIJP4F/6JU3JdRpdp1xWpxxTNTlo/eR8bth6kiITor2+IV/Kg77ZQP4YpOzES7me3oGZRgcsJGbZkBhDM1l+y7cdC6Qe1KR49xcRlqTpLbbYiCHR0EhB5pEdYGuVDVsYFbhmsUZNwXmAFr4nRanA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c705aec4-8cb6-4056-7485-08d58db1ba65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080675FDACDB10A0EC46A80CFBD40@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(199004)(189003)(14454004)(105586002)(6486002)(316002)(86612001)(68736007)(106356001)(36756003)(6436002)(99286004)(2501003)(5250100002)(107886003)(54906003)(110136005)(97736004)(5660300001)(22452003)(26005)(186003)(6512007)(59450400001)(102836004)(6506007)(53936002)(86362001)(575784001)(2906002)(25786009)(478600001)(66066001)(2900100001)(72206003)(7736002)(8936002)(3280700002)(4326008)(8676002)(81156014)(81166006)(10290500003)(10090500001)(1076002)(3846002)(6116002)(3660700001)(2950100002)(305945005)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EYJeBiN77wh3rLPAJXhAUH/zSspM1Ov/v5HAlUhjyTZIeCRCqXU42MudU/xuHgpHxTekg3GJZwzl2b6Hz0Ln6Zv0rBVDbA21JUwluwYjZv+0p2jL3sMbsg/FHJGZ0Z9Omc/PNyEkLnPdZ9dN6rBcXfMusrqVdiTiQtmHBc6pB3goT3+CGs4vD9bTURxHjsGcdxcZJPdAMMydzOPdyBp75sOga4Q2HDwX5Yf8lNZ6l9XTWw+h+y6Ul6RHot4EjDrvnYY2J98YoJ/zAaB8aNp4+M4DCm5851+7HtIgXKvcj/o198Lzn1avqdIuKjHmED+wcPYcZbnEN48HtUT/t04y8g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c705aec4-8cb6-4056-7485-08d58db1ba65
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:54:41.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Moni Shoua <monis@mellanox.com>

[ Upstream commit a42b63c1ac1986f17f71bc91a6b0aaa14d4dae71 ]

Change the default mapping between TC and TCG as follows:

Prio     |             TC/TCG
         |      from             to
         |    (set by FW)      (set by SW)
---------+-----------------------------------
0        |      0/0              0/7
1        |      1/0              0/6
2        |      2/0              0/5
3        |      3/0              0/4
4        |      4/0              0/3
5        |      5/0              0/2
6        |      6/0              0/1
7        |      7/0              0/0

These new settings cause that a pause frame for any prio stops
traffic for all prios.

Fixes: 564c274c3df0 ("net/mlx4_en: DCB QoS support")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c | 5 +++++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 7 +++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   | 1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c b/drivers/net/e=
thernet/mellanox/mlx4/en_dcb_nl.c
index 5f41dc92aa68..1a0c3bf86ead 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
@@ -310,6 +310,7 @@ static int mlx4_en_ets_validate(struct mlx4_en_priv *pr=
iv, struct ieee_ets *ets)
 		}
=20
 		switch (ets->tc_tsa[i]) {
+		case IEEE_8021QAZ_TSA_VENDOR:
 		case IEEE_8021QAZ_TSA_STRICT:
 			break;
 		case IEEE_8021QAZ_TSA_ETS:
@@ -347,6 +348,10 @@ static int mlx4_en_config_port_scheduler(struct mlx4_e=
n_priv *priv,
 	/* higher TC means higher priority =3D> lower pg */
 	for (i =3D IEEE_8021QAZ_MAX_TCS - 1; i >=3D 0; i--) {
 		switch (ets->tc_tsa[i]) {
+		case IEEE_8021QAZ_TSA_VENDOR:
+			pg[i] =3D MLX4_EN_TC_VENDOR;
+			tc_tx_bw[i] =3D MLX4_EN_BW_MAX;
+			break;
 		case IEEE_8021QAZ_TSA_STRICT:
 			pg[i] =3D num_strict++;
 			tc_tx_bw[i] =3D MLX4_EN_BW_MAX;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/e=
thernet/mellanox/mlx4/en_netdev.c
index 9c218f1cfc6c..c097eef41a9c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3335,6 +3335,13 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, in=
t port,
 	priv->msg_enable =3D MLX4_EN_MSG_LEVEL;
 #ifdef CONFIG_MLX4_EN_DCB
 	if (!mlx4_is_slave(priv->mdev->dev)) {
+		u8 prio;
+
+		for (prio =3D 0; prio < IEEE_8021QAZ_MAX_TCS; ++prio) {
+			priv->ets.prio_tc[prio] =3D prio;
+			priv->ets.tc_tsa[prio]  =3D IEEE_8021QAZ_TSA_VENDOR;
+		}
+
 		priv->dcbx_cap =3D DCB_CAP_DCBX_VER_CEE | DCB_CAP_DCBX_HOST |
 			DCB_CAP_DCBX_VER_IEEE;
 		priv->flags |=3D MLX4_EN_DCB_ENABLED;
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/eth=
ernet/mellanox/mlx4/mlx4_en.h
index fdb3ad0cbe54..2c1a5ff6acfa 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -476,6 +476,7 @@ struct mlx4_en_frag_info {
 #define MLX4_EN_BW_MIN 1
 #define MLX4_EN_BW_MAX 100 /* Utilize 100% of the line */
=20
+#define MLX4_EN_TC_VENDOR 0
 #define MLX4_EN_TC_ETS 7
=20
 enum dcb_pfc_type {
--=20
2.14.1
