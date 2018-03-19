Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493229-2-7756870652756311802
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
    t=1521493229; b=B1ZLtQEhnvWW0EqMpeKilOwwCmixsF+NqxLiZDcvY0uofDx
    OYZVA/JtbGSXK8QnBDMWLzZOhLbpbOMxbM4Dw0CwY5G1wyH+fTy5TFStwXeHuxWL
    N7dqOZl3L9ZTifhd62k2XJnjg6kd4WhcYrq73+/T3QkVrjZG9+PncpG/U20EwESL
    nIkePaM7nHWrPleAmAaUlWLwq5XDSftBpago+eWzYfnoDgfEMla1ONOpcbnr517k
    RQ0GZk7F8MJ4vwOIEvqa45WkoHJpFeoOk2lCWyKiqquzzoFzjML+LGc7W3EUzh2o
    68187ag3yqJZjX3RMj0ROO9+3Snm118YIVP9Shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493229; bh=zmHoRe
    Q1C9nVfMdOgWKge8BXfzZ8RD2ljczadpOhTkg=; b=DKXU0egR5LweC29MRZfG+5
    OnrFW9Ym/qx+QXdpjiGbB+8xxJatcY7uk2usFcoC3MZ7eBXjA8NCqVIj84FmXLw7
    wNWkSkYYfua3Tyil+NpnIhE3BffgXOW5DstYees6Ep0GuB+z9zE+JDSSICsXU72W
    wNvrJs//hWkcXz2ot2/Xsw73NkNcntLB4+j5uCviNcbn/GLCw8uwGW8n9JCsazCc
    3aft4kLs48Ax8qceKE7fmhyLe/MrKutRJwuBqpJBidczT4BhtR8FS2Lrn8p48GV5
    yjH1XWQCRGFGISVdGIVYBFEHfgBppTOyPYrHMkUUrrXEaUrMR3WDAgsv6IjB/nDg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H2qdiWjq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheeiheenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H2qdiWjq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelheeiheenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965495AbeCSQCx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:02:53 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934989AbeCSQBs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moni Shoua <monis@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 129/281] net/mlx4_en: Change default QoS
 settings
Thread-Topic: [PATCH AUTOSEL for 4.9 129/281] net/mlx4_en: Change default QoS
 settings
Thread-Index: AQHTv5tl1TgbKlP8pUaOf7tRk22W9w==
Date: Mon, 19 Mar 2018 16:00:26 +0000
Message-ID: <20180319155742.13731-129-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:9R6/A/YMEDnQbgNmcCRcockvmKmT7dhJY4P5t7GRVJWku7HBoPrjlMbBtRPs4wnGlB5VSqr34+bwk98lORSMpLksikigNbeMC9s12kODEkicJH3DG/Z6Bw+BYnjRvj/AAB4qVjQ4u4w/NOx2wV5tUyxIRXzQjEA2EwdnSLGSmrVMpBJgwSJ9bgr67vf6uCGHN4PV6WAw3ovdybqyb8zGZABwa1kayg/YpQr1mR88aK2XTG3KRzmqiPPL62ckkm3w;20:+EjJ/ZW5FoVpWgZJdMNAaihWjwepQ2FMhTAUrukuFn7cV9Ev9s9NOkSXUXoJ2Yu9JElQZa4pbcpckQ7kqUUfyXPwpdVYKI1xFxjpTldL8u1pHs3oRXvi7uJ5CvH+fQUfKHH1ZL5f22yrCwo3fq8dmY9l74bfmGux3OyJP0GSn1w=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca85ea79-2327-40db-706e-08d58db2b6f1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091989AE6773B6BD3458477CFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: unTosbach4ZUnLFq1l67TlUVPs6uKl/cThvCaDHsH8lr+pFk8zNPEUODBmbmkPQTCeyirKi8EV1ZQoyYnpdzceZEC/XrNs1LV6H+OVPm3UCpQx7XMt9ZhNnQ8MYA/WEN3FM3/hruKneoiNAcgTg3MbOMCsCxYiVFFj42xpV/coyA6jOCKDdSBFfwf95DKXUJvF8WQQdMtlJU72DLwkfmX1jfu4wZubMh5XSADRkSV6fKSh4MOOvQ/L+fvM6QPuciCnwFQ0M3zGyjt05TGzgdDifxiOW583ogZCPQWAQgNbhfHnYCE0At4rWyM8eslXwcYj7xB/zhLbSuJz8Quuodtg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca85ea79-2327-40db-706e-08d58db2b6f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:26.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index b04760a5034b..d98827adec9b 100644
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
index d223e7cb68ba..0160c93de6d3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3125,6 +3125,13 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, in=
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
index df0f39611c5e..18f221d8a04d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -472,6 +472,7 @@ struct mlx4_en_frag_info {
 #define MLX4_EN_BW_MIN 1
 #define MLX4_EN_BW_MAX 100 /* Utilize 100% of the line */
=20
+#define MLX4_EN_TC_VENDOR 0
 #define MLX4_EN_TC_ETS 7
=20
 enum dcb_pfc_type {
--=20
2.14.1
