Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482631-2-9465262678116770852
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482630; b=X1w9UY+AKseJgtWthZIqR/dSOcb6gJmdFnsC1CrgdDObQdH
    tCEVDgiQUOlVyjrCqNz6PFcJddldKTbnuRnGznIzw8ZmNijEG6KHN0mXSqucPmHa
    x8s+6Xbbmc5rznnz/hJ0SCpImcWhNaXUYeoYvjJAZCJ97/XgKJOYIi7I1ANzNy3a
    zLsOUnlAfAKIm18HYVSInPXU2hLYdf5bvvXzAgBQkYdu85ClduicAgcnUsmCcPbr
    2UTQgnkzEwJG7ESFzVSd5o5jD+F+Y3CMnttzxoHy7xrYzsrxNsDvlE3VXc4L5Exh
    NpxizWq8waGpZ06zQ6ynvxkcPX7xRI9OallkMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482630; bh=yyguwu
    lPupyfUqSgTouLITfOtR/nSaGrEyZ443NlAvo=; b=Sj7OmVjXQAn7s6Mvd49HuW
    PCj0fPOGGyNkZjpQU8dzUf938Ua4LeuKjS4a7jnMu9gEb9J/QG6xqH2hqUdQfl6n
    ixx9ttQYT/CNTYfMPOuPwmRgcMc3//chwTjJsX/bzoBIxPF5jlFGjfTomcls2D3p
    Nr/mEx/YPEGEYFo0M/wrrM52jYZLFQ/1mru+dUqMqSz+096a8P6f14YSFQnYT/QJ
    PnNC1Mrd1u3lIsScJtsPG708zPoEPVLPielekHwgDdgpetsXN+vRMW5EnyHAeaE0
    ycX0s/hmjJzwgL9ha4gHlB8oxYkPgQyS+CbPQLIvrIE07tUawJNcpeuWU29Fq11g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oXgG0Bxc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltdegleenucevlhhushhtvghrufhiiigvpeeiud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oXgG0Bxc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltdegleenucevlhhushhtvghrufhiiigvpeeiud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965386AbeCSSDq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:03:46 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:27376
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965474AbeCSQD6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Leonard Crestez <leonard.crestez@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 186/281] net: phy: micrel: Restore led_mode
 and clk_sel on resume
Thread-Topic: [PATCH AUTOSEL for 4.9 186/281] net: phy: micrel: Restore
 led_mode and clk_sel on resume
Thread-Index: AQHTv5uNJbj2b3sp/k+MMwnviZOdXg==
Date: Mon, 19 Mar 2018 16:01:33 +0000
Message-ID: <20180319155742.13731-186-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:hH8l6CgxBcRGp1F3NP9M564XvKxBYsebdShAJ46y4belyUkoF9jOUScZateQNnFS1iPEwMv5fgJwMxqXP3HK3fX7uBU1KcTy2SFhrS4OXhERaBw6nCOxYN5u6tO873QfTWnqip4IG7G1/IqbQCSi910RT6u49nO9mhU/nPLl0sYrdHVcGRKmhD4Ia5GFgF85qRt/pF+toCZaeBpQr/OS2jncjhuNT1iP4RVTweosUJDdhbGSlrM1sfbVSuFe0bfW;20:v8WOzYmVVr1GJ4odwo/S7eBVyiVWYFtHLdzq6HT1j/4fGbappbCNISsP4f3DQ9PDWcyjhy2W7qCYSpnFPle6b343T0k/0nlcCOmguOjfGTFj1MJwaqQ9m4/a9oTdEZX4Z41PsYRAlwp0OtCFvr7akkTPbc8ZYQKMXgo0nrkq8F4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f406c53c-9424-4674-6869-08d58db3015b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077D164D0C217599CA5DE70FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(8656006)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gvC332K93OODLqoGspXnZYGWhjiVTjP9P1Y7w05YEkcKwspqoET5jQEQ4YknmqiYd+OKKqp5QqaUyZPnog8G1JI9+jqXWjIRn+K6EopSF38IvwsUyH8PqELPU0Aeu/ozIdhFdFJIDmXu4g/ySTQKEp18elbwUFDyo9ZGcvtpCpKIqJN/LujIvxHTndCtdSK+yypTW8K1pT3QtOGJAW3SpBUsvRRF73GSk44EtRLrhKejQTqQys1qnP1AQG19/cA4+/Y9667go1f4/BLDaE92RlKP9daqbEQx7vFLWvn8fNtorzZhxAZMRNcursNAQGd5gIFdTdXcuZ0thjPWe2qTFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f406c53c-9424-4674-6869-08d58db3015b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:33.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit 79e498a9c7da0737829ff864aae44df434105676 ]

These bits seem to be lost after a suspend/resume cycle so just set them
again. Do this by splitting the handling of these bits into a function
that is also called on resume.

This patch fixes ethernet suspend/resume on imx6ul-14x14-evk boards.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/micrel.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2032a6de026b..4da73e2c37cf 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -268,23 +268,12 @@ static int kszphy_nand_tree_disable(struct phy_device=
 *phydev)
 	return ret;
 }
=20
-static int kszphy_config_init(struct phy_device *phydev)
+/* Some config bits need to be set again on resume, handle them here. */
+static int kszphy_config_reset(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv =3D phydev->priv;
-	const struct kszphy_type *type;
 	int ret;
=20
-	if (!priv)
-		return 0;
-
-	type =3D priv->type;
-
-	if (type->has_broadcast_disable)
-		kszphy_broadcast_disable(phydev);
-
-	if (type->has_nand_tree_disable)
-		kszphy_nand_tree_disable(phydev);
-
 	if (priv->rmii_ref_clk_sel) {
 		ret =3D kszphy_rmii_clk_sel(phydev, priv->rmii_ref_clk_sel_val);
 		if (ret) {
@@ -295,7 +284,7 @@ static int kszphy_config_init(struct phy_device *phydev=
)
 	}
=20
 	if (priv->led_mode >=3D 0)
-		kszphy_setup_led(phydev, type->led_mode_reg, priv->led_mode);
+		kszphy_setup_led(phydev, priv->type->led_mode_reg, priv->led_mode);
=20
 	if (phy_interrupt_is_valid(phydev)) {
 		int ctl =3D phy_read(phydev, MII_BMCR);
@@ -311,6 +300,25 @@ static int kszphy_config_init(struct phy_device *phyde=
v)
 	return 0;
 }
=20
+static int kszphy_config_init(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv =3D phydev->priv;
+	const struct kszphy_type *type;
+
+	if (!priv)
+		return 0;
+
+	type =3D priv->type;
+
+	if (type->has_broadcast_disable)
+		kszphy_broadcast_disable(phydev);
+
+	if (type->has_nand_tree_disable)
+		kszphy_nand_tree_disable(phydev);
+
+	return kszphy_config_reset(phydev);
+}
+
 static int ksz8041_config_init(struct phy_device *phydev)
 {
 	struct device_node *of_node =3D phydev->mdio.dev.of_node;
@@ -715,8 +723,14 @@ static int kszphy_suspend(struct phy_device *phydev)
=20
 static int kszphy_resume(struct phy_device *phydev)
 {
+	int ret;
+
 	genphy_resume(phydev);
=20
+	ret =3D kszphy_config_reset(phydev);
+	if (ret)
+		return ret;
+
 	/* Enable PHY Interrupts */
 	if (phy_interrupt_is_valid(phydev)) {
 		phydev->interrupts =3D PHY_INTERRUPT_ENABLED;
--=20
2.14.1
