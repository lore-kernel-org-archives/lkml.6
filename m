Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B50C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F612077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lfAP0LEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F612077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbeIBRmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:42:04 -0400
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:16848
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727489AbeIBRWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1tapYsrFZvaG1cnAFgDQGJw0PvO1IynvrnA/F3gGOw=;
 b=lfAP0LEnC8qUku2vdHEsmBxXuQdzvTAtpYvWC5lfHC7HPmsf6pjsXDR1lh/IV8+rjGhn39WmHvX3zcwXeglxxTzmxvyN8x3b9rTCtDRkB4GheSlELAnZjcLcthyyERuEAWLVoUGN/EGSMp5b2HZleudzYfl/5BaobxTb7zSCUl4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:06:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arun Parameswaran <arun.parameswaran@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 11/89] net: phy: Fix the register offsets in
 Broadcom iProc mdio mux driver
Thread-Topic: [PATCH AUTOSEL 4.14 11/89] net: phy: Fix the register offsets in
 Broadcom iProc mdio mux driver
Thread-Index: AQHUQr2/YR1RYsIraUeSwO6TNHSy6Q==
Date:   Sun, 2 Sep 2018 13:06:22 +0000
Message-ID: <20180902064918.183387-11-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:6NUvbfx4JNq+satdiGgVm6CYoJOUBplcR00cU02GdlDMUgoNP4DbFADX6ylbMImsuN2TxFXp8BN8SX3PrSkwXxWJqpAmvsl19lgj4U/do1qGXXvgaZRjPcfrgDKMejWiHAh1Uht2sUtXqvPrfVYfshvNKVvCpSQIWVWREXzN/0y+rTJ/qT3hi4xjxIHAS6kcrfat2QnvNziLw/95VGGdRtzab3hUj1uHLGYUffCoH4Ta9pjj6OKQlx8wVELGO4qfftQY5S+GC3+3sMRxkARJKgZ4fG/rLBn09gdcGFyM0peGAXjyT4wUP+7LKxg1fzA1YhrQ/jH9ZCO9R8U8UErZLzn4G1arx6ftJejEYKoLffwHEjlHw9B8cvAnJLpC/ClgJ7v/qwcI2ZDAPLgXEyH18cYbETx1A+t6bVXItcEUyGANlgQhB7rbLSQyDWIFWXXtWLEE9JTkUaAGmk8vGW0Yjg==;5:Uk+aIAGoNwxeP5cZY0PMqw6OpJKN1XPUQys+HgarIVAC5BXSWs6koCnma6BE4SbyLwidTxoeT+yihLxkZWmbxGbvOSEotZRXi1NAGUBYXKnhgEiQe5cOYc4T+oBRBZfM6axHUqI+8MSG6wOhIUOMGjZCpK2J8mhVaq890c3MfAg=;7:A3awUakK+htQ/GeyJDBc8khPm0tXfg6oYeH4C5lVbJVs4ejQ+eLdgvluO6L8+wZaW2im5Zh/rRXGgdcS86HFWa9r7zeEI6woxdA9sijo3p2pJ2VatInzTyvvih5DcyDLr1ArTCOFfGR0sOzflg5JXIGtlz5zuLwn95bJGTXoXGIg32SimpaJceSIJhSROWgPBhWwiSOJ+Ec5n/W4VRz0Wu+AqOcr9ii2OH0jPMoi9l8yVIR+XXZ1CA8B/PMo3Pxn
x-ms-office365-filtering-correlation-id: 8d998d68-eabf-4a1a-f192-08d610d4e2a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822DBDCCA1DCBD115861B38FB0D0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(256004)(6512007)(486006)(86612001)(97736004)(68736007)(478600001)(446003)(11346002)(25786009)(8676002)(10090500001)(8936002)(2906002)(575784001)(110136005)(86362001)(107886003)(4326008)(186003)(26005)(6346003)(76176011)(6486002)(53936002)(2616005)(476003)(72206003)(10290500003)(6506007)(81166006)(81156014)(66066001)(22452003)(99286004)(102836004)(5660300001)(217873002)(106356001)(2900100001)(1076002)(7736002)(2501003)(14454004)(5250100002)(305945005)(3846002)(54906003)(36756003)(6436002)(105586002)(316002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: NW85CEvUS5ZhxIhE32qm0Ji9AbORZ5JmWgFRzTixDzloXBS3NatLhR5txxumbv83fBz9CuwHmHS/6pQH3GmWcLqNLw+ZUGcuvulK945GDC2VjikoHjSSXVD0e2+YQhYInCxa2C83cTHWJ+qeGY8QT2gZTynwtIMFgO/7ZrfYFjmRygtmLuwzYY69QrqH/5taJeCs4WbbY4Ea1v5xX99NpRUxrRwJUNvvTXFRXU1Aq9HWw0/AHU+zbE18K40ytsibDEruVECroVJMKxXe6glVlx5+IzF6+zA5rGJVQKq8U+7shbx/V20v5+Jz5aVclqWHeTGMWdJyzIjOcap5YtBsHHfzDah4RUk0iaMTkPXYT10=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d998d68-eabf-4a1a-f192-08d610d4e2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:22.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
