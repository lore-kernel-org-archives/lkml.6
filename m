Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520484979-2-7652533429456245936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520484978; b=CxEZgNvmMsJtWULjM4boIMoCwE7KGBgd1yCMA+BCpzxgXsc
    utYY07kTEeGEIExbjPlJkmkTV4ZP8R4TL8ILRilxrxzY2lNlF4VWKlB8c5KOi8En
    t1eftZ3AKR2wRXRdMuBEQRq8wlG0lMS4vVZ/ciEOeBBnNwQzv9RGzwh1aGAb0NOS
    MIjDdIUJKMrIFlJ2oHrBK/BKRirGDdexa9aB4MP96OX1EPGnr765Ue++W8q48bxY
    j9/vsgCRNGif2biHagwA5umj5FLzqtuf+KGZGCQAq/AWDdZe40VBHAnCIDpkCPVi
    8FNU52xyLX/jQCLgJtM/e403XpcJZjNZ/3QJUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520484978; bh=Hchu4i
    bT2ZyEMCGoW1zfdlA1CgZ0B/AtGz7LcG5Rb+w=; b=F1hImFvj/X2WyQd6opNY2T
    YrVzCt1GJ0ppT6q3DGZ61EXh4oQH25a1AOc0NCbzYzXbTRpd1uK3UmjK+2WuJiI8
    ta3QesP0YTDHekg/TsLR5QOpRglzbVqtqXKT14WgB4Wr/XR/oE9kE6Bb78n1MhAb
    DmXEax1FroQI4EpenaQ0fPMGkIVrSGqSgfOwgBA45j6iiiBAIAHyD7n05SD0f54r
    LFaoR83QYHgbY2iCpBmbcYPh2SR5kSbfLKbsY0WlhXR2GX95zWdt8/caFibSsYSn
    kfW0nCyPpj4vj/D2f932dJ2aWfk5E4tnAKQbU9RyceDBPcST/1yCpPj5/qkaN2lw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nsL7tJnF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nsL7tJnF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755103AbeCHE4O (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:56:14 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755009AbeCHE4K (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Richard Leitner <richard.leitner@skidata.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 09/78] net: fec: add
 phy_reset_after_clk_enable() support
Thread-Topic: [PATCH AUTOSEL for 4.15 09/78] net: fec: add
 phy_reset_after_clk_enable() support
Thread-Index: AQHTtpnDy1/RoaY5p02JtUhW7L2M2w==
Date: Thu, 8 Mar 2018 04:56:04 +0000
Message-ID: <20180308045525.7662-9-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:Kk4EoTbZQ+pc5b6UwBq+bVLxTUaHnIeI5zCABzLrTCKCxXhgguhOgtBSQRRzc3KP87PSIjUB9y5LSgYn53l1r+K3lzlrHnsX9U+wjYSCZR+YBk24V7tXrw/RLG+GW3StnK6RfKpc9Q/qrKJxFrv6e0gs+usMGgLHbVcDcWCNkbj8hFRhxI6C3Hkf5UdoslNZzMQV/0o8BcdR5ErfJfvQ1RDbbMDcsUlzGGztdct7aRbeq7dtEtACw/6zkxMe6Frq;20:2/XIfi9CBY25FYYcYgCD3ixfAYXeM+ZGKLIw6mHW1T3JBbbPgOIE0UcVL7gUVfeRTD1p7PNqcwWjY3R4o3AW21j66DdMGi6ZkhID0wFiG1ZYyg9FCDxcDG5hLcymGs+u0KIuXMrHN4cuwXkNI4jrmsDFVWo5vH8DfKaU5UABq0c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05d6fa45-1bf9-4420-9ca2-08d584b0e5ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09027CE5EDFB5C0CFA99B6FCFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(966005)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6306002)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: miCEbRb/zrCqdPycqG82afXwffc7h292X09IT5s1o02uk7knpHU/2GVumAhVNA3RjTZHI2r2oTn/drcyVhHm26Gms1FbR9Obr+N0IGp5eQ+Hgs4nApeLD4fOpIo69yXUrF6nnhl9QJ/jYVFVVyknC95MUYekPcr67aS6XhxrtnSIq0PB1K9tf3WOzproe4eR7gKFx72uwtP+/0B4oUoeSH1ar6uhHcJXj9U4DS6KkwivHo9oLAiX46fvV8Mr4if3TajKnv2P8X6TUKWDsocksHKv2LgNBRaD2R/q0anM50PugP+uHqDdiVrmuzq+pR7Fn82aYXYo9tw4rozKVqjL6g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d6fa45-1bf9-4420-9ca2-08d584b0e5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:04.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

[ Upstream commit 1b0a83ac04e383e3bed21332962b90710fcf2828 ]

Some PHYs (for example the SMSC LAN8710/LAN8720) doesn't allow turning
the refclk on and off again during operation (according to their
datasheet). Nonetheless exactly this behaviour was introduced for power
saving reasons by commit e8fcfcd5684a ("net: fec: optimize the clock manage=
ment to save power").
Therefore add support for the phy_reset_after_clk_enable function from
phylib to mitigate this issue.

Generally speaking this issue is only relevant if the ref clk for the
PHY is generated by the SoC and therefore the PHY is configured to
"REF_CLK In Mode". In our specific case (PCB) this problem does occur at
about every 10th to 50th POR of an LAN8710 connected to an i.MX6SOLO
SoC. The typical symptom of this problem is a "swinging" ethernet link.
Similar issues were reported by users of the NXP forum:
	https://community.nxp.com/thread/389902
	https://community.nxp.com/message/309354
With this patch applied the issue didn't occur for at least a few
hundret PORs of our board.

Fixes: e8fcfcd5684a ("net: fec: optimize the clock management to save power=
")
Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index a74300a4459c..90aa69a08922 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1868,6 +1868,8 @@ static int fec_enet_clk_enable(struct net_device *nde=
v, bool enable)
 		ret =3D clk_prepare_enable(fep->clk_ref);
 		if (ret)
 			goto failed_clk_ref;
+
+		phy_reset_after_clk_enable(ndev->phydev);
 	} else {
 		clk_disable_unprepare(fep->clk_ahb);
 		clk_disable_unprepare(fep->clk_enet_out);
@@ -2840,6 +2842,7 @@ fec_enet_open(struct net_device *ndev)
 {
 	struct fec_enet_private *fep =3D netdev_priv(ndev);
 	int ret;
+	bool reset_again;
=20
 	ret =3D pm_runtime_get_sync(&fep->pdev->dev);
 	if (ret < 0)
@@ -2850,6 +2853,17 @@ fec_enet_open(struct net_device *ndev)
 	if (ret)
 		goto clk_enable;
=20
+	/* During the first fec_enet_open call the PHY isn't probed at this
+	 * point. Therefore the phy_reset_after_clk_enable() call within
+	 * fec_enet_clk_enable() fails. As we need this reset in order to be
+	 * sure the PHY is working correctly we check if we need to reset again
+	 * later when the PHY is probed
+	 */
+	if (ndev->phydev && ndev->phydev->drv)
+		reset_again =3D false;
+	else
+		reset_again =3D true;
+
 	/* I should reset the ring buffers here, but I don't yet know
 	 * a simple way to do that.
 	 */
@@ -2866,6 +2880,12 @@ fec_enet_open(struct net_device *ndev)
 	if (ret)
 		goto err_enet_mii_probe;
=20
+	/* Call phy_reset_after_clk_enable() again if it failed during
+	 * phy_reset_after_clk_enable() before because the PHY wasn't probed.
+	 */
+	if (reset_again)
+		phy_reset_after_clk_enable(ndev->phydev);
+
 	if (fep->quirks & FEC_QUIRK_ERR006687)
 		imx6q_cpuidle_fec_irqs_used();
=20
--=20
2.14.1
