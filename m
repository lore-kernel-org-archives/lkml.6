Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9CC20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aQRRnUjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfBFLwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:37 -0500
Received: from mail-eopbgr10056.outbound.protection.outlook.com ([40.107.1.56]:41348
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730118AbfBFLwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW63vg9IbcGqzHv1JXAR/RYPUOzczW/kg2wbaXiZM0c=;
 b=aQRRnUjDvdum+CylZ+J7bRaRiIcvTs0VN/Oi3qTUBIDWZow9y37zK83z918kcheZqrqopf1p2FklDY1TB+cP031hxofk0s8TG/dCiUB1OU55lC0nQAFQZRfbFrxDqzJ1ITpqvukAUOO8yMc3vniO2oiq/Sn2L0JuoWB5hs8luuw=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3871.eurprd04.prod.outlook.com (52.134.16.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:52:02 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 11:52:02 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 5/7] staging: fsl-dpaa2/ethsw: Add switch driver documentation
Thread-Topic: [PATCH 5/7] staging: fsl-dpaa2/ethsw: Add switch driver
 documentation
Thread-Index: AQHUvhJfDP44zmMZuUWXCEkvAiWI6A==
Date:   Wed, 6 Feb 2019 11:52:01 +0000
Message-ID: <1549453888-24593-6-git-send-email-ioana.ciornei@nxp.com>
References: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0259.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::32) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3871;6:P+7VIPni+CN8/aVWe6lm5uGo5GpFmNXIOoftWyLFxfj9oGRDkQyCaaR3HZutrfmcOBoJKwJN17yAEfnK1SQk2AXDD69lvuHqtaTD+OP0O2i7gg5RIh2b13O5ObB0tkbFXe52+ONzmkcz6ae9QIrhJUwCVKa7x1y1239ImRDaWXQ2oSnQsTXZb05k8dSagpmu43pyEohy1VQwnoYq7GyL6iqE+vjeSz+ZYYT4RjIbzbV01rHtxPewh71gDvzBFi/z44DX2EkVeF1AryZEL+KwJE9cwX5AxwBPkZuqX03Tdemi5srhFXy8+Dam0n2AiGVO9nhccjAvNkO3RuRbRnU4WmsJOgg1k4j8qMc6jKVe4+LJ7pKMEtf1yGocsYsV7kjBQgLzzV8qNw36dzzNqI2t3YvVYLfJerPLTfp9+jTfH6nllhOVji26Csi8G5aSft78jAjhyu6SowptarOfeC6tJA==;5:0mhQnJoCdN5HHSZlhiZ0fNilyYsEv6+bAIMh0KBp144oB7z9BJnvYDbmm4rWr16O1Nnm0aYWzZZHnHkHxCU68BbD1czZk0mCi4DpxpI2Wy/o6NQlpRo31hBcVfQMSy0cKWCsSCqCGztt8HKJI1DfME6iTe7D+7AUTGBogAdTcII3GvkTOKmLaYf9jjvs6+XSXCSU6h90uHVv7itLSD2XCg==;7:YRS4ZgikqZjwatxZZntbSzTEPe5w8JPb1iSYP73BqxbBbqjOhS/hlXHsJdH3qZcTX1Da7EHj/ZlEGNObWcvwtpUviJtEdLQw/2k88rfc0fQmJotXW7bGKli0QXSsUQ6Js3O/SZnUQLWvavM6GyMLxA==
x-ms-office365-filtering-correlation-id: ce46c878-a887-4ce3-d3fd-08d68c29817c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3871;
x-ms-traffictypediagnostic: VI1PR0402MB3871:
x-microsoft-antispam-prvs: <VI1PR0402MB3871751817B3033461842A56E06F0@VI1PR0402MB3871.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(71190400001)(71200400001)(86362001)(36756003)(6512007)(66066001)(6486002)(6916009)(50226002)(478600001)(5640700003)(2501003)(14454004)(4326008)(53936002)(6436002)(25786009)(68736007)(54906003)(105586002)(316002)(52116002)(2351001)(106356001)(2906002)(305945005)(7736002)(99286004)(2616005)(256004)(446003)(76176011)(26005)(97736004)(486006)(476003)(44832011)(102836004)(11346002)(81156014)(6506007)(6116002)(386003)(3846002)(1730700003)(8676002)(81166006)(8936002)(186003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3871;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VHyTBuXw4n4q1OT80pNIWQcV6eKl2Ow6jfy89OcpzQapHfC2/DvidBrsqe0+fAseLl6lVCRA72bEbbJ5OWkBhMUbY3vJWfCK6FiYXy4H+S3ZWtu873JCA6w7Y83gWclEDWZcLQOhuzf9e7QeZo3j4+8rORyAfqkruocqArXDEn6TM+N3bZuQvWksof6EFikMCXcgtzAPonC+JvnA7TXhPOEeV+7kQRFtCSvF850Pn5VEvZpLH14uxzG+83jhQk3P72jb75Zdf2i3D2He8NW9c17hCwr7gyUZMOCfWVolr4C04jRN1/6HB/igPdx+7sSkvViunOSOnBFVlBayyJyllbk+gySRjswtcFnsrtiG7MBucOMt5pAJbA2opcEzfzU/EdL018CrL2SixTWkM34y/Z9CcR/0mQ9KpUz2JDJ3lsU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce46c878-a887-4ce3-d3fd-08d68c29817c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:52:01.2352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@nxp.com>

Add a switch driver entry in the dpaa2 overview documentation.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../networking/device_drivers/freescale/dpaa2/overview.rst          | 6 ++=
++++
 MAINTAINERS                                                         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/networking/device_drivers/freescale/dpaa2/overvi=
ew.rst b/Documentation/networking/device_drivers/freescale/dpaa2/overview.r=
st
index d638b5a..7b7f3590 100644
--- a/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
+++ b/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
@@ -393,6 +393,12 @@ interfaces needed to connect the DPAA2 network interfa=
ce to
 the network stack.
 Each DPNI corresponds to a Linux network interface.
=20
+Ethernet L2 Switch driver
+-------------------------
+The Ethernet L2 Switch driver is bound to a DPSW and makes use of the
+switchdev support in kernel.
+Each switch port has a corresponding Linux network interface.
+
 MAC driver
 ----------
 An Ethernet PHY is an off-chip, board specific component and is managed
diff --git a/MAINTAINERS b/MAINTAINERS
index f35c77b..77e88a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4733,6 +4733,7 @@ M:	Ioana Ciornei <ioana.ciornei@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethsw
+F:	Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
=20
 DPAA2 PTP CLOCK DRIVER
 M:	Yangbo Lu <yangbo.lu@nxp.com>
--=20
1.9.1

