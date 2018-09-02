Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23699C43143
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C849620855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BG4X694R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C849620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeIBRTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:04 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:46915
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727280AbeIBRTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1tapYsrFZvaG1cnAFgDQGJw0PvO1IynvrnA/F3gGOw=;
 b=BG4X694RAHtJUJzDLBSQfgBediKct9sVJYZawpyc4+D9uTaozuzjkjtMNoDif5gRRAYDYj5y/ni+Nx98zwXJuaLJO01ITbZo+db/V/aL9X8Oa2x2H/qiFe+X0EfXZ3UkvVTDtjoPZkD0Au4gvIjtVFoYqxAVOXKebK/nOG2TZ18=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 015/131] net: phy: Fix the register offsets in
 Broadcom iProc mdio mux driver
Thread-Topic: [PATCH AUTOSEL 4.18 015/131] net: phy: Fix the register offsets
 in Broadcom iProc mdio mux driver
Thread-Index: AQHUQr1QiJF83IM5YUWRJZtKVDoC9w==
Date:   Sun, 2 Sep 2018 13:03:17 +0000
Message-ID: <20180902064601.183036-15-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:u2IfpCG4/ZYPQDqp1jtEipbTWgiYfvVvwqAbZ6h9Ux6GFORv9KkMFJDyHpcCq5QjIzCI2r3koAElu8/dVMGlojE56VAx2rNvB8i4TxVPlMlisQpCpJLGO4aGWWpcXreUsljJGXrP72CuwTIcni9vd21o/RAq+8wmBU/nLQVZeoYCs79QcxmOLflREd854cAN/8UHTNZooS1WGMNk8ukWM7OUav+bu8Aosc1ePXAf1fIJzM+EEYdHxNEbcG9yST3nMa29V66rVmjlYMolyywHp1prU7vc69qHHKrQc85BEmMxg9P48O4c8upZwymwwfDP582+434wJ8MrXQXI2xmLGDNemvvouN49X8FdPMRtTD42+1CDK5ro6AD9OQd8A6Q7sG4pI4A9C1aKKbgqf3pmZegzjPiZ7YCUQuKi0aCdiQN076XfI7yXpBZUk9zlxVM8Rlq8PkkzeQqEhfGxjuIy2g==;5:PlkDGqoZYHwDcmZBDOATRFV2OPOh/a8P6WichDxcOZ3A/jwB+kOz56VbOJHQuRFO2OCPsIYpFnkgMHXI4ruBBl8x0ksW6H4WySckwoDWzYSt4i52GKyN5NCuWTwabRY0gOv9MlO7uVgCHlonq8Ok340EudMHNZez3dlxVmZOjNE=;7:r/zJv6UYyEBnp6lkdJ6OCgzx7Hrn2PiIuvfLpY0mOmx4967jg6ou+AlcSvCLVJaMmpncCIBq29aSNsQRdnENZcCF6Kl3OnarpePJXsJ7h1KbeR5ka/63tcunvfzqlFLP6wNVhs0pbrjlzh7oDPz0eAqZtEHl1FXEl96f2XViBSR73xNJXPhUsCLPQqQipwwsKc9iwEifQpiQ4pZ/XK+fJs6PYAVWUtJ6vNEv2o4ZLRy/Pe2EbcbUMcu1tcCw8XhC
x-ms-office365-filtering-correlation-id: a0e41a07-cb56-4475-3e88-08d610d4738b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150976CAA721AA2A0A2C388FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(575784001)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: KbZnALYa7OelEIdSreCdW8kNN0h+gTR6dlAeBnm0Q97vXRHx3w+x0lSwxltEpYCMY3JlV3LWuGOU9OhptC9VXnE6kjBMWdPaKSUy+po3eMum4dLs702tE3z9wQSzWuQRX8Fh6UvHudRs8WXUHgwXF3vzpbAuuMZhzWPQM5HnHQ+1U/2nOIvap6Hs88hM2CUm7s25SY5Dn+0gt82Ox9urpsUAyK7doyP6V+kboFqtbPr1HvkheYAzEcAouun15wCYMLoTc1Mv4AS/ZHqR4/FqGVS3AEMDy9EbF/MAs92EQmhurelPbZsNccUMj0FRbz7cY1JpRKInvabcG1VMTkg6LCLClegMPXV31RqqX1AaNYw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e41a07-cb56-4475-3e88-08d610d4738b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:17.5479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Parameswaran <arun.parameswaran@broadcom.com>

[ Upstream commit 77fefa93bfebe4df44f154f2aa5938e32630d0bf ]

Modify the register offsets in the Broadcom iProc mdio mux to start
from the top of the register address space.

Earlier, the base address pointed to the end of the block's register
space. The base address will now point to the start of the mdio's
address space. The offsets have been fixed to match this.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mu=
x-bcm-iproc.c
index 0c5b68e7da51..9b3167054843 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -22,7 +22,7 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
=20
-#define MDIO_PARAM_OFFSET		0x00
+#define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
 #define MDIO_PARAM_BUS_ID		22
@@ -30,20 +30,22 @@
 #define MDIO_PARAM_PHY_ID		16
 #define MDIO_PARAM_PHY_DATA		0
=20
-#define MDIO_READ_OFFSET		0x04
+#define MDIO_READ_OFFSET		0x240
 #define MDIO_READ_DATA_MASK		0xffff
-#define MDIO_ADDR_OFFSET		0x08
+#define MDIO_ADDR_OFFSET		0x244
=20
-#define MDIO_CTRL_OFFSET		0x0C
+#define MDIO_CTRL_OFFSET		0x248
 #define MDIO_CTRL_WRITE_OP		0x1
 #define MDIO_CTRL_READ_OP		0x2
=20
-#define MDIO_STAT_OFFSET		0x10
+#define MDIO_STAT_OFFSET		0x24c
 #define MDIO_STAT_DONE			1
=20
 #define BUS_MAX_ADDR			32
 #define EXT_BUS_START_ADDR		16
=20
+#define MDIO_REG_ADDR_SPACE_SIZE	0x250
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
@@ -169,6 +171,14 @@ static int mdio_mux_iproc_probe(struct platform_device=
 *pdev)
 	md->dev =3D &pdev->dev;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res->start & 0xfff) {
+		/* For backward compatibility in case the
+		 * base address is specified with an offset.
+		 */
+		dev_info(&pdev->dev, "fix base address in dt-blob\n");
+		res->start &=3D ~0xfff;
+		res->end =3D res->start + MDIO_REG_ADDR_SPACE_SIZE - 1;
+	}
 	md->base =3D devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(md->base)) {
 		dev_err(&pdev->dev, "failed to ioremap register\n");
--=20
2.17.1
