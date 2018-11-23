Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7386DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CEE20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GSWUF519"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CEE20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408625AbeKWTSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:18:49 -0500
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:25376
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731866AbeKWTSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09oZ7ZQ2/DnROxycqqbfgzFOqDMSjYemRqXDoorsPRs=;
 b=GSWUF519aA/wmo1LB1wpGDW5a63YKSfjiAafct7EUBthGuoQLDgFnz47IvKEWRm74TYt2cokVEVX3hjvFRYTQPbpKeO16CWqPKmJwgVT3gVMUFDNPvHant7SZkyxkrJL+SYwAvc2fRaeuoBixE+PHENwiyI1gTYFGEQ5yGUKl7s=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5129.eurprd04.prod.outlook.com (20.176.235.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.38; Fri, 23 Nov 2018 08:35:29 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%3]) with mapi id 15.20.1339.029; Fri, 23 Nov 2018
 08:35:29 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V6 1/2] Documentation: can: flexcan: add stop mode property to
 device tree
Thread-Topic: [PATCH V6 1/2] Documentation: can: flexcan: add stop mode
 property to device tree
Thread-Index: AQHUgwd9j5Kw+dcCB0+EZqNn/lx4kw==
Date:   Fri, 23 Nov 2018 08:35:29 +0000
Message-ID: <20181123083304.3232-2-qiangqing.zhang@nxp.com>
References: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5129;6:3CdSgq79QLFnKZiyc+OqUW8e+wud1cQQ9Uiur6pbl/JNjCB2Hkkfrzxl5mMjR3WfMeJX+HkgdYQbsqDS10hVyA2cAbIzOCe+TwsvMtXt4/ld/OTUYsWFeBeYuBh610YdMQKHeKBRw5WBQC57dgaI/yzMDgwTwFyRSpFZT1EBhkXYMED8f3czq/g5GkxLFyiwmc8D06xG3ksSuNQeFakRe0GcNiGJ/9/37gvUM4CEJBUAUMdOinTl0rlco1cKaPKq/55XJQkg7+VQJZ6RP1NVMbJ9aHN76I++BFUvUHPkQjZKr5PepNMc16XT0LYuiQ7vTT2f9xcA2E53JE05+UQZ5Sf7DjFF7g5AzRy6xR/85EM2eN0NaXwpTHyukOkdvtIBpKf7hmtxn3vncuZ7OWybJyVPSFWWPbhc2SgI7DBAJAKa4afMzjnGKJTmWca6iHZQrasnyDylJiYPbCJxTNwjIw==;5:C+U/vCE+BtfQVm6xwxZDhz09lXrpE0kTo971o+/ERGEzYPyCGqEzcvEr1gt4XKHTQXrFRHGngrfU50VQp0IWwRhVYYe0KXOMf1/DjT1zerYx2Uv17QbKrUrvzYNOWElA1F29N8hIiXTfVEVY95fYM8lvhuqa/YBiQlL2Cu8B/Z8=;7:tqyUr6Q8dVvsIIZqNjbgFOqSA5lB1ZZuPN7tn0sRJSDuuUCppG60/SZNk5GPOGjyxxG3ZQkWsPUcusXn4o8BuFbO61GKF81KgzszpPaqImQyM+6mWCAQzKKxzyI7HlXH+xZjjM5XnzCbE7aXk9LmgA==
x-ms-office365-filtering-correlation-id: 1f7de02f-7ed8-4e39-5cab-08d6511e9f97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5129;
x-ms-traffictypediagnostic: DB7PR04MB5129:
x-microsoft-antispam-prvs: <DB7PR04MB5129DFCA5F281F025D4191F5E6D40@DB7PR04MB5129.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5129;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5129;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(54534003)(199004)(189003)(2501003)(5660300001)(8676002)(446003)(14454004)(105586002)(7736002)(25786009)(305945005)(106356001)(4326008)(99286004)(2900100001)(53936002)(50226002)(8936002)(316002)(6486002)(54906003)(110136005)(6506007)(386003)(71190400001)(2616005)(11346002)(476003)(81156014)(81166006)(52116002)(68736007)(71200400001)(76176011)(6512007)(6116002)(486006)(36756003)(26005)(97736004)(102836004)(186003)(478600001)(3846002)(86362001)(256004)(14444005)(1076002)(575784001)(6436002)(2906002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5129;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a3LoyhHmCq5kGScReinDAmcPeXULK9B0LJF8mxGnTuCj0qfyLhduNjJqwP2mSRJ1gZ72iCSjCeSa3ZMhJJLGxmZLngNkx9sLmBnIRCqSYiztrmemOY9TdZ9bWR8iMt7h8m+WkdEml0B9HFHwGC+7F1D3kzR4mElZYq9s6XBmOjPHCNizqsITGkMl1mC1omcX6gf0xZmpYdacHvpWf2qafmtISVils9dIYGRoK0H2pXrpTKk7RZQuFtP5jIYxGesnR6Ql+R4B9nNOHXDCuqiGxKkt4DSP1uKxXvqe165Ye7a3JUGuILOYaUidLj6BkDBXAm+/dHf6x4qG9AYY+v0eaWsb6TkZZWwZ/XCSHYEzzhE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7de02f-7ed8-4e39-5cab-08d6511e9f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 08:35:29.1932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

The FlexCAN controller can parse the stop mode property to enable CAN
self wakeup feature.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
V2->V6:
	*no change.
---
 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Do=
cumentation/devicetree/bindings/net/can/fsl-flexcan.txt
index bfc0c433654f..bc77477c6878 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -24,6 +24,14 @@ Optional properties:
               if this property is present then controller is assumed to be=
 big
               endian.
=20
+- fsl,stop-mode: register bits of stop mode control, the format is
+		 <&gpr req_gpr req_bit ack_gpr ack_bit>.
+		 gpr is the phandle to general purpose register node.
+		 req_gpr is the gpr register offset of CAN stop request.
+		 req_bit is the bit offset of CAN stop request.
+		 ack_gpr is the gpr register offset of CAN stop acknowledge.
+		 ack_bit is the bit offset of CAN stop acknowledge.
+
 Example:
=20
 	can@1c000 {
--=20
2.17.1

