Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB91BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A41D2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="KBWWT/5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A41D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeKUSnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:43:42 -0500
Received: from mail-eopbgr1400129.outbound.protection.outlook.com ([40.107.140.129]:16704
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbeKUSnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s36n9D6RDDo9iHzTWM78ywmr6QHEa0xFO5UyzYI3ILQ=;
 b=KBWWT/5dcf6zOjXUhRZ5+BzuKMhSNTK9Bs9IqE6csb8o0TauAx/TbRMner+V9c59Wou7cyoxLH+q1sw82Gzda4k8xiJ0dd+z0s8AKl28qSqB05ZYNSMXzxqSLuHExbeQKZdbk6Dt8aPaQHxMWTEM8u1q+onZAisPqXosM/BZl0M=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB1672.jpnprd01.prod.outlook.com (52.134.227.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Wed, 21 Nov 2018 08:10:07 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::c070:7362:375f:74c5]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::c070:7362:375f:74c5%4]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 08:10:07 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "kishon@ti.com" <kishon@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] phy: renesas: rcar-gen3-usb2: follow the hardware manual
 procedure
Thread-Topic: [PATCH] phy: renesas: rcar-gen3-usb2: follow the hardware manual
 procedure
Thread-Index: AQHUgXGduWh7Uy6zz0qMrwqNmf6bZw==
Date:   Wed, 21 Nov 2018 08:10:06 +0000
Message-ID: <1542787663-32142-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: TY1PR01CA0161.jpnprd01.prod.outlook.com (2603:1096:402::13)
 To OSBPR01MB2293.jpnprd01.prod.outlook.com (2603:1096:603:26::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.144]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1672;20:RdkHK3EKtgDNyzuqRiNBsdu7Rp8m3MPa/xmzwP0F0gFvhukYY0WYYncCNYebj4zMX27hS/x2Lbq4GCy75ABcr98LLlxV2tCslBRdBRc5s5kMB6mCitcp3p9qKE8Y3ETSbFrlUnFy+eujIUJ9gnU2t4eYN0skfuiw6BX5waq/mlE=
x-ms-office365-filtering-correlation-id: e370bd88-0e5f-4b91-c57e-08d64f88bf24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1672;
x-ms-traffictypediagnostic: OSBPR01MB1672:
x-microsoft-antispam-prvs: <OSBPR01MB16726501ACA9EE29D831641AD8DA0@OSBPR01MB1672.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSBPR01MB1672;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1672;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(39850400004)(396003)(199004)(189003)(5660300001)(25786009)(478600001)(107886003)(68736007)(66066001)(14454004)(6436002)(316002)(2351001)(5640700003)(6916009)(106356001)(2501003)(105586002)(256004)(6486002)(97736004)(99286004)(7736002)(71200400001)(71190400001)(6116002)(3846002)(476003)(52116002)(81156014)(2616005)(486006)(8676002)(81166006)(86362001)(575784001)(186003)(36756003)(2900100001)(1730700003)(53936002)(1857600001)(54906003)(386003)(305945005)(6506007)(50226002)(2906002)(102836004)(4326008)(8936002)(26005)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1672;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RXWJ5/SZAI7NNl0uiWvyTC+fRa+e3NS0cHAB4iCz4UjhMhrwEqKjnShpWo+MtNfXCXU47yOfF38Vj1SEpmuv7Rs+ou+UDhfKbH8LTQBHaHDvxVuU92QIAxatyeaPkar7cou0zTk64OFZtptKhmOfPlvL/sfz9gFWs1OX0v+FlWzbaGbdL+pETLr0wx0P22KHtYS6/njeEfa/8i+80rQgGKv0hF9Rzpb3Azh35oC+qCK8707t/ntgmN2ozZXWHD26RMq+DD4K9yDj6uTfJcUA6OxQU6uCsHBrEx3Z2/MDU0XBHgTXQ3ToVrWRYHZuglNbajjT+/4j8GQ+Z0ZIMow0NXd7MZA9PQw94A3o32pEfAw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e370bd88-0e5f-4b91-c57e-08d64f88bf24
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 08:10:06.9102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies rcar_gen3_init_otg() procedure to follow Figure
73.4 of "R-Car Series, 3rd Generation User's Manual: Hardware Rev.1.00".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on the latest linux-phy / next branch
(commit id =3D 0eb86fa77f0f0c81631a030f10679a45c05df33a).

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas=
/phy-rcar-gen3-usb2.c
index d0f412c..a9e53e8 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -307,16 +307,21 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan =
*ch)
 	void __iomem *usb2_base =3D ch->base;
 	u32 val;
=20
+	rcar_gen3_set_linectrl(ch, 0, 1);
+	val =3D readl(usb2_base + USB2_LINECTRL1);
+	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
+	       usb2_base + USB2_LINECTRL1);
+
 	val =3D readl(usb2_base + USB2_VBCTRL);
 	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
-	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
-	rcar_gen3_control_otg_irq(ch, 1);
 	val =3D readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
-	val =3D readl(usb2_base + USB2_LINECTRL1);
-	rcar_gen3_set_linectrl(ch, 0, 0);
-	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
-	       usb2_base + USB2_LINECTRL1);
+
+	msleep(20);
+
+	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
+
+	rcar_gen3_control_otg_irq(ch, 1);
=20
 	rcar_gen3_device_recognition(ch);
 }
--=20
1.9.1

