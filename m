Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAFBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE5B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8efW4k7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfAQJLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:11:01 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:45177
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728095AbfAQJK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBRP1/K/DcpD36V8RMJacst3n6Ifu6hE+oHxJuKrOBg=;
 b=f8efW4k7sngiIizWMR0ZEe5YdwHk3Z/F33rJGljor75+Rb/mPAbWLWQPfLezSn1yEpPgJcXODObneSYJhJM0ypbmB6s2lvXc9bA6H2xr6T+Gl9TLDdsjk7/yce0INUsbbwaqPQkttPgMw9zXH0rnXu9Cl37msXk1GEP6zLwuOPE=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2900.eurprd04.prod.outlook.com (10.175.42.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Thu, 17 Jan 2019 09:10:53 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 09:10:53 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 2/3] usb: kconfig: remove dependency FSL_SOC for ehci fsl
 driver
Thread-Topic: [PATCH v2 2/3] usb: kconfig: remove dependency FSL_SOC for ehci
 fsl driver
Thread-Index: AQHUrkSM0ZRSymVk/E62FypFY3Tsfw==
Date:   Thu, 17 Jan 2019 09:10:53 +0000
Message-ID: <20190117091135.44209-2-ran.wang_1@nxp.com>
References: <20190117091135.44209-1-ran.wang_1@nxp.com>
In-Reply-To: <20190117091135.44209-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:203:2f::31) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2900;6:hDeKKSXG2E/fpqEuGcz/ZOJT35BikVJFy6O6/+STzxRK0TV7+ICcMJ/MEktqzu1N3tnuQ4qBuHDDMBqawuNehhR2mUSCBTUK5OGS3bzo/gLeGyXBQZU5hV8Fv6QgICcq6rU5tciVRghj4TyPELZYTrZj10P6SeMxvAUezjOzYCqRc4GS5wDK0DrpBn9rA8mlqS7O7lHYdNKbcwTmQM8yzMkpM9yOD6k9q9Sgy8pJ05PF/ejTmp1niHwCy+c4zAlNYqj4vrU47eYNpVQUjyZ8c9BtLB7AqQswJmSLc5DwLVOzg8Ujcg5NCVfyaAf6o8lLOUi9KcgqlNlwlTK1eJy21gSjqSNd9vUnzF8CMvOpatVZHv5q84PLvpDFRtf+csgigPhoX4YnHbICYh09aSbUMi6w58ZIkT71kBTlZ4+uDlov3eNtgQMtluvYExpAQjRkLkqUy7sjB3NdDT5Nb5iSEg==;5:AcLM7XojMcOVcHE0wK023WUgIGb7oYKixzwGeBos65GAtpIb2YoXMX0PfkXhRac93gZV+VULVKpfiqS4vvsOjMN+rTw/edvzX66j6V2R2zT4bjrX91z8vRLwqKXgCxpllUr6rKoaiYoZdN08ap/yKiPvhFV7w5JsKR2YCVNmyLujpDLNK25ZHtbVfaYrfA9exB2+agJJynjuRIzk0YTKAg==;7:PQ5ZuWPY9TxvCCQkGXySl+6aloW6ahRpbCn3nSW14OIpE1hrjfBR2/cBxWleCkTDWsfHI119QsFfCGIdgExLXcSbz8wSs3zythGcOZ9x25DE2TOW1xMjQUfGoFqqE8zRoZqgtbx37e/Lg+hcf4g5CQ==
x-ms-office365-filtering-correlation-id: fa502b2e-5bbb-4cf3-8779-08d67c5bae47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2900;
x-ms-traffictypediagnostic: AM5PR0402MB2900:
x-microsoft-antispam-prvs: <AM5PR0402MB2900DAE178605DA18A99FC2EF1830@AM5PR0402MB2900.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(446003)(102836004)(26005)(2616005)(476003)(11346002)(2906002)(478600001)(14454004)(6506007)(386003)(76176011)(71200400001)(71190400001)(1076003)(105586002)(6486002)(106356001)(186003)(52116002)(6436002)(86362001)(50226002)(110136005)(68736007)(66066001)(3846002)(6116002)(8936002)(256004)(81156014)(81166006)(8676002)(54906003)(305945005)(316002)(7736002)(5660300001)(97736004)(4326008)(2171002)(25786009)(99286004)(53936002)(6512007)(36756003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2900;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: myQJ9bHOSrpmo1uJ0VtxMSc6rOVcJC5S0ru77kke9HOnglLmbU/RNqeLdKAbZpQqtq99XLm+mm5Qrnq9FFWjbuo5obgBLAj+HoXU/8wJPzakrd+Ija2DX67GY7DGcz+Z+H8XbXtDpEsPAWLUFwxzdWegTkx+/8WfhJZgKfCutLgBW2Ei61NsEQQUpP6yydvEPQ6Dm4fBXyDi1POMBw8RIHwWlU8x6A2wX3+xwOUnhF3sHrGWjPU/lghTO/ImcJDxhBcLiUNdP7vKHX8Go0gHaZxdWH/5faAuizlGDRGDJTi7KhkR2rBwKwFBryoIdVbKJVjN7OFoC/sQgDTyGLXpGYv+qZHLmUCn6dc+ekWr5HSLt2z1rZ6u4PIGWzLAfttdyyJcI3v7esnXO3a0FHLgJKyDtVOv3958IvOsgL87sms=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa502b2e-5bbb-4cf3-8779-08d67c5bae47
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 09:10:50.7438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_USB_EHCI_FSL is not dependent on FSL_SOC, it can be built on
non-PPC platforms.

Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - remove 'depends on USB_EHCI_HCD'
  - Move this patch to be second one to avoid breaking the build on ARM.

 drivers/usb/host/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 16758b1..11db5b2 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -179,8 +179,7 @@ config XPS_USB_HCD_XILINX
 		devices only.
=20
 config USB_EHCI_FSL
-	tristate "Support for Freescale PPC on-chip EHCI USB controller"
-	depends on FSL_SOC
+	tristate "Support for Freescale on-chip EHCI USB controller"
 	select USB_EHCI_ROOT_HUB_TT
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
--=20
1.7.1

