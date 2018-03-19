Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521499066-2-1317157522117108691
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endaca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521499066; b=MLRLgXIRtb6bhY8rg0cN7vlIotxejWtHA7ptX2BGe2dUpVJ
    4AdBn1lzruJfpQknd21Ycg6KseNIBSjuBYiwJ/uOja1yB07ODmud7hEagPCQ3PKn
    A5qdLnmWDgtTyMOnfQf1MtkmCpZT1zM7XsjFFvRJs1pmKU6bqe70puYS4XA+VoZZ
    S8ZyFB0nGaHGWMPrlYqkDSlkEowlViSJPyyh58etOXV4rlgRA1vBEhnYywWuBsB4
    60xyDQLQMThlI8Jja4JeqD3mT5Q6s3GjvZzUL/1gV4uw2xSz5rBIwFBwAcRw38Kb
    Dwj3FLeECt0D2fEz4d7YjdXoOwuwTKif/e36IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521499066; bh=lDi3ex
    dRDRhjrrgjoxpEkjT7eGt0Og3H/GXsW9pnnDM=; b=mIfRZ+gCaEpKdCogB8akK6
    tipGhYlnt+gDXpbIRDYJ/HugPTBJwIjdfiSxP4UsYjM/4oNAR9NLE8dSacgi2BAH
    RMU5qZrAkCvkeb+D0vw/Mp/uyCk+cEN5KtSi4g4n4GLG5BxjVSxdskmBssBKFYad
    1rojAWodFCCW65/ek8N49Ckk1UwixpHCIg5W5Psavz/eDyqLOHm6cdZGRvb8ukx5
    u5qmGqnfff0M3SGMPoeS9TCuRvumBVtwV6D+OouMPxmubou/u9h708dqzXP+QjqD
    rZO6NRthUzB6ROMGhX7FjRxwkQZpMXWHDWbWq9wKkDaQVMDpJuP1JJpyw9up1hOA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UxKU5qA+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeliedtfeenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UxKU5qA+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeliedtfeenucevlhhushhtvghrufhiiigvpeduje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933457AbeCSPrf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:47:35 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:4160
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933279AbeCSPrZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:47:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moni Shoua <monis@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 019/124] net/mlx4_en: Change default QoS
 settings
Thread-Topic: [PATCH AUTOSEL for 4.15 019/124] net/mlx4_en: Change default QoS
 settings
Thread-Index: AQHTv5mPnMuv8g7BuUK5aP/9UEaH9w==
Date: Mon, 19 Mar 2018 15:47:18 +0000
Message-ID: <20180319154645.11350-19-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:Haw852OOLEwOMMhp/iLtedV9rICXNUtYBcRAgaJ7p6qkplR3E7vysxMe47f+bFkDUlTCQPlA/MMCeLJ/RkoQiwNs4ZgM5qFv+dL67NKQUpF5IslcO0w9ZD5RRTH35pSQBt2DroiMw7GNgpUNXxcoBjkSPe+xwl4h4RDC5NLTBph5zTjtteGbBf7rhKueSKz67/daZj3gvoQM8JIwNhSP0iAJ2rAwfZvvFfOSOGlHB4HO6S+gEcvCYQDvcBCCMzVF;20:/dYBPo4eEfZvioJhVNbYKwnQCEiVuBncr1eVlBOF/njHO2RjJwCNY0EafaUarv59erS2NM7aL2XZopMwOS/F7AqKdSniWrhB8icr2IlnB0ly8ivr4/PcNiiu8q5quOszb1aB8vYcs5sRUYu68iuCKauWLFtikgZMGHUnPxgh8cs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: feb0b8f1-2d51-4943-5e8d-08d58db0b23b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072897E5385C0DF5678B57F4FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(39380400002)(366004)(199004)(189003)(10290500003)(26005)(305945005)(68736007)(186003)(59450400001)(25786009)(4326008)(102836004)(66066001)(6506007)(8676002)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(5250100002)(3280700002)(2501003)(76176011)(316002)(8936002)(478600001)(53936002)(575784001)(99286004)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6116002)(6486002)(106356001)(1076002)(36756003)(2906002)(105586002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: pxE+omzLRTFsdj21AkWOPZtdZdZWmD8cdRq76S9TEa8WQmlimizt2u8+xDpw18cZ3gALqt9Rw/QaNxJmDf4baunYtrW9Z1AozgmRnujtjeQhz36p7NgJlAyABF8FYwZJ8cssz2NmuPPkvKzTQbgEziAWSmrUL1JnvLnybSkcGuiHS74zdF8qLAaBC+ds/rioUnvAF9RyfQC6gdwaXz1Ah7tZFsJ9iAd1bZ3x/n69D4hmG/6whfgmzzFH7TsBTK6iRHw25inRzDPrbXgkJvl/V2MNU5CtAG2ijcRQXcU8ribxYx3CFKPv1utEyNDCeqTvvFOu4e3bYd/v6G8KQHBNHg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb0b8f1-2d51-4943-5e8d-08d58db0b23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:47:18.5287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
index 99051a294fa6..21bc17fa3854 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3336,6 +3336,13 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, in=
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
index 2b72677eccd4..7db3d0d9bfce 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -479,6 +479,7 @@ struct mlx4_en_frag_info {
 #define MLX4_EN_BW_MIN 1
 #define MLX4_EN_BW_MAX 100 /* Utilize 100% of the line */
=20
+#define MLX4_EN_TC_VENDOR 0
 #define MLX4_EN_TC_ETS 7
=20
 enum dcb_pfc_type {
--=20
2.14.1
