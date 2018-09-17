Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88905208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YUrJM2OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88905208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeIQI5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:57:08 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:6704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729315AbeIQI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLh1GgT8xUI0UtcYBANkNVq6ya08BMz4yZj6cSTPDUY=;
 b=YUrJM2ORcJSA8DScw72aEnCK02Xcd68y/ULTWVFoy3mgkFFGe3F3iR8jArO4SQCpwsOWfbWNG1WCIoVGW+LBqpTPo6Zwmsow5mxCspYAoUKnn4spHhyOY4jgDzqcP6qofK9UBt0CpJZ1lkppHd5sfAUX8+zZ9fS6Zu+d5WiEFys=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brandon Maier <brandon.maier@rockwellcollins.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 085/136] net: phy: xgmiitorgmii: Check
 read_status results
Thread-Topic: [PATCH AUTOSEL 4.18 085/136] net: phy: xgmiitorgmii: Check
 read_status results
Thread-Index: AQHUTjKs0oRYBs0pL0u8wPR33VbVVw==
Date:   Mon, 17 Sep 2018 03:01:05 +0000
Message-ID: <20180917030006.245495-85-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:GrKNcRlFbOLqmKzS+AsSdqYtBereusXAQLWiuVi2FKb+KjWb4bH26UTMA+FyJ1ZVnZxrgyek7E74d6E8PQ+6z+kUuJVEzhoVnJJNqeLwkkOMlJUQAFb5cx2hsVmC2iKxNgucZrYkIJanLLK/LAubvQjWNcK2gDRbLXfMUiRRa67OiGwLpbFe6tF3hY+wKV8rAqIo2S84kRoz0BwUajX2GJmZfh1zfAHd+mhlyVy4GDoAyRUVAN5pBEOv9DRGsR7djIldcbI0yHWO+Bz/7BAZbPxkWuznIiU4ypjt8Ir43PUySg8Sah35LZSShY+RgnQymC/mYWOTCsZ3JOzI5DgJRN9sBf9WVm2I239MIgrj/bA383Uc72MZ7T1Z/ol0IvRU1qvBVgf9g8gEJyO5LWmZpk3jo8/fi9iPOQGLjZEASbthPL9wsWV6Wut3k7NLLtipufCqE4xhQp4aSl97J/IGkg==;5:oZxTUFqr1oO5w4S/McvAKbCE+XEq0HoImUGZjYHYnpYvZkPJOncy3i97z+Re2XRy7uThi20VkUVANS/RBpJNKRz1lzS7vsvkWz9aljDCmpALMIBOZHWDxlRytkVrTpTVejqSgC1N7af3kcXcwcVo2wfjTfRi/zlJ06yg1npWxdQ=;7:9ceq/D6bytoE+GvUWmuTVZMx9dqlrawqcclndNDKLRoajKja3vCiX/s80oBVOvycMrABb4C5L6BXo8HaAwbxE1MWYcKmgglVta8huVCO30Ew/8MHed4mJ4wBlrV0m1Jc1gkmrSdkrPesm5jOpzOtHQgCQQMB32xaQGsua7bkxG85eUL4OgUaah+CMzCSY0hbblnbuN+4G/LVtP1KS9jUuZVTYJkZnsd/EtQvOjvriNIyAu+noZSt63r1sT1+GM48
x-ms-office365-filtering-correlation-id: cb78e03e-3e95-41b0-5a95-08d61c49f0f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790B0AFA4F5FE9188D2D7A1FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(5024004)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yOOmBQ2sB7ANI51p/vOy7hrC1p4MKonk+RWuK93Y7TVBl9/zFhnUC9OqGVmQi2G4VfAYp9RgUeyP3a853m1iGEJwhIdgpf20uNT9fJVTy7QPCAzaJ52Pwar+8OsahXJOzMq/h19GdDb8puK/zWQCz89HQ6aI8/5V3Ly16Fk69MJGShuVvkAuOe1ig/HOlK22kjzF+3JrgTvkcjozwuuDWYZqnUgRiOWkCSYf66r3sbQDyFCnIl3KxjRkUcmnrgmO+Vsa8wrts1y+s+Yii9Ze5eDltftUMthE/D8EbDuBwzcqczrxObqaxj/tMAo8LMJMueaSQ1V0qB/ppAsy263vwppiVPaOz2KWEBlO0/QWiu4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb78e03e-3e95-41b0-5a95-08d61c49f0f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:05.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Maier <brandon.maier@rockwellcollins.com>

[ Upstream commit 8d0752d11312be830c33e84dfd1016e6a47c2938 ]

We're ignoring the result of the attached phy device's read_status().
Return it so we can detect errors.

Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_g=
mii2rgmii.c
index 2e5150b0b8d5..449b31319010 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -40,8 +40,11 @@ static int xgmiitorgmii_read_status(struct phy_device *p=
hydev)
 {
 	struct gmii2rgmii *priv =3D phydev->priv;
 	u16 val =3D 0;
+	int err;
=20
-	priv->phy_drv->read_status(phydev);
+	err =3D priv->phy_drv->read_status(phydev);
+	if (err < 0)
+		return err;
=20
 	val =3D mdiobus_read(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG)=
;
 	val &=3D ~XILINX_GMII2RGMII_SPEED_MASK;
--=20
2.17.1
