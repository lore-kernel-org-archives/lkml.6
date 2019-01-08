Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F16C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99241218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GwcL7OZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfAHGE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:04:28 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:38188
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727408AbfAHGE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf3EFU+M65YTvur0Jkqdv4TyiTIBQ1wOO2PyPocvo1U=;
 b=GwcL7OZhe7zuGvM43vw5ZlWPsZN8/6RO93aEl5oi0Qnmkm2wpJwhkxL1QgZp7RwBVEpEUXQVSiMjRUgJnGmAPs8Fw68zsu1RRIAibJ+/CYmRdY/Gcd8CtyFrdW3ATrUP3j2crDsSSHtAdPNK3kK8dSWlfMJy6Zh3FeUZcyx8M8k=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2915.eurprd04.prod.outlook.com (10.175.42.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 06:04:24 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 06:04:24 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 1/3] usb: kconfig: remove dependency FSL_SOC for ehci fsl
 driver
Thread-Topic: [PATCH 1/3] usb: kconfig: remove dependency FSL_SOC for ehci fsl
 driver
Thread-Index: AQHUpxgBkJ5uhq9XMUWhOXrVWOpG3A==
Date:   Tue, 8 Jan 2019 06:04:23 +0000
Message-ID: <20190108060426.11581-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::26) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2915;6:7dPZwDcT+xw0jX4gyW6ZQvoRx2pEE0yr2mlaTZ/dbBSBFzHKJPgQvzwy4lGjxlPkSI1OY7AHMuX6i/v8NJXIB1TGW2XsbedEIRwIvAFmHiu7kWmqO+yC9FxExUJ5tetBTXQ/D8qb6TzlaqUgb6nb3WS7Z1AtsGNJ3Ww3XQ076rpXeCCrZcqYPo3yG42+pa5xA8cycNtAtokIAMlCeISeyMEeTZv2S+jJ1s7GtnFNnfEAlWWZwrYjr54V4BIpK5TwYrylLu0nbE3iFCISa5LK0rizYf2r4ezkb/ErPmyo1ozYA7oO/135DyhqU5UWU35GNGRxHyj9MdGpux9niO7silyYhip0LPr2VFmq9k+X3o9T2DdRUhIwMCOzUPFLNMwxgtZEz/UNK2zkIi6MizLJfXD1IuFQo/2k3AbMm1O3NTCwH8HX1BFUfG9TwyGDA/brU85CbFFsfETaXZU/+jaJ2Q==;5:+CXcLvON4l44JZBPe/LH4ns/ZdWa5XTJMrMULKWYo+V+RQ+4NXDW1qbHKf42ZFnBocxX0bL9+mnwOQGRDyHPo/8LAHlSh2uYw5f4w9FSON0ZZQzIPxdaP+N7bEzzUpK/Uc2geDPfw/S15n6I6wG3Q8G0GDG8Rk9/IZCOpntAq9tgoPb9oQ7f+LPOk9ygx9LnczkLcAhFU6vS+6WmoVg+mw==;7:h+vktlwA0uc6JCbsfZTcKqK4MLDgR+I4komIF2JpsncHPHH8VHBn8x58ssW6NdlTlanjm+szFDNVfvG4vOa1gtlr84OrjTABI17T3DXsTbXEu8QNZq/iAlaufYCTCuqYnY/7iDhbPBD1f11y80hjsA==
x-ms-office365-filtering-correlation-id: 6cafd5f4-b1ab-49d2-4ca8-08d6752f233f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2915;
x-ms-traffictypediagnostic: AM5PR0402MB2915:
x-microsoft-antispam-prvs: <AM5PR0402MB29156324E189EC2769E8FFEDF18A0@AM5PR0402MB2915.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2915;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2915;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(68736007)(97736004)(36756003)(478600001)(66066001)(476003)(81156014)(81166006)(25786009)(6436002)(8676002)(2616005)(54906003)(6486002)(110136005)(186003)(1076003)(106356001)(256004)(105586002)(2906002)(3846002)(71200400001)(6116002)(486006)(7736002)(71190400001)(14454004)(2171002)(50226002)(4326008)(5660300001)(99286004)(305945005)(102836004)(53936002)(52116002)(386003)(6506007)(26005)(8936002)(316002)(86362001)(6512007)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2915;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TGlfa0NPSXtnoYuHBVqwYmW+3D7EFVrW3awjnADVJO5S1giQ3atXkrPksg1uvRxB6bc5W8vtMKGijxBqhuLRUtgCzHxIpLDfn87tgLDugtlpm69olaRPMqXN7rJxLsY0M6T3CKUcb60LfVQC0d69RloMsKA0FRmyoOQM46Csdbe/U6nAA4MrFMOxR1ETDXnz1x3QJ3U+1VlDW73VhSJruteuALCVVnTLfMPM5kf0f6YSUGFXl66g928q4U7gF7l5qHKPJm5t3tqZjzeL6Q6C/nVlI9BAP07Vji0mDJcYCPRRpRMnimt0gC8ENqwDuxNP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cafd5f4-b1ab-49d2-4ca8-08d6752f233f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 06:04:21.1954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajesh Bhagat <rajesh.bhagat@nxp.com>

CONFIG_USB_EHCI_FSL is not dependent on FSL_SOC, it can be built on
non-PPC platforms.

Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/usb/host/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 16758b1..53cbc0c 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -179,8 +179,8 @@ config XPS_USB_HCD_XILINX
 		devices only.
=20
 config USB_EHCI_FSL
-	tristate "Support for Freescale PPC on-chip EHCI USB controller"
-	depends on FSL_SOC
+	tristate "Support for Freescale on-chip EHCI USB controller"
+	depends on USB_EHCI_HCD
 	select USB_EHCI_ROOT_HUB_TT
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
--=20
1.7.1

