Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE62C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D2120657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qH9nA06U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfAOMAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:00:42 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:23552
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729322AbfAOMAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn3iE/JFNlb4lzpaPXAGNBOdGR7Idnue3apFmeOOZ1Q=;
 b=qH9nA06UIbetRvs4B38phZdMwNNlmDuKwe5MS006tUcKtLEP0/eKk5X/4KnqQMcB3RVKf69mpI1L98InqN+u9VMFgaXpLEn/ZXw8pOPR9IKVZYY5Epzp9VZEs/y+wzsDU4aY4F67u/RKGyR1yJKK+B6Qm93JcWoB0U/Hum52p5Y=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (52.134.31.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 12:00:20 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:00:20 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP FlexSPI
 controller
Thread-Topic: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUrMnj2HaRDCPgY0i5ihL9RBjnkQ==
Date:   Tue, 15 Jan 2019 12:00:20 +0000
Message-ID: <1547553487-9936-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4301;6:d5+RYoOiMNP0voHlDF52folhtC2Lfj0OjbhbLXj1+GRFEWOZRTqHa7yHuD6vvCw/MKGNYiPKJ5pciucQ5iZPQ46H09GKf4Qlv12VV0WmtZ7oxPQMva5efIgY/MfTGrnHEZ53QFC40yGsbCIf8rVAYgPo5B4qfydWrsHybCIE6WCmZ1XWXuAMTxev5SYgpZVK8rmUVKrGewxQSOUK4fU2gZo4E9kjf5aOvLazl/8I7rQSNF0EQqRtY9cK8foAmRRdA278QGYptVhmP2TEDTQPEJJ95voTF4ggjmg8ZjGSKeLTlW77AYDlzFQBx8AeydulY0vWjex5dMCcqvEhOSjxB+oM1/RPCRaK4lfZzgBwm3NbAXys7gMgZRY/Uylh1dap0Za5yIvAm/xUef6cefQR6/M9Ze3xMULTsJf+DB0Yum39Kf84FsxJImh5wWQA4TBwOT9Je/rXqaaWHxAKndUPKw==;5:o4mDcrYooGCpM6lNH83uzO7cmMyxdSD0WIo8S9QbTMA7Zy/6SyMJyvyhNREPX9zDnVBLuoYwENuPWUN9gjjzBavxpbpl2Zftui8RtMxK7WNuPDX6CE1x4qh+nktWRN3pXqqoOsAGCvTP4wyqxyssnG2io2jPBTbjLorleue3RmPtlQhbRcqeOzTOzrRe7dl/FIAA8EprGcsIdaDstS9eyQ==;7:R0iq48GSA5T8G/G1eTFsjyrXYEawiQSZzXr9zjX6pXJZQaqvi9OElqDG5J1UnGwaa0gNHTNBzIj5Hfp8VdpeuZFH5IcDjXrmqC5d7YUri133ANE8z9XpiHvg9B0eDiFnYVCVBo+9iuP568gm41dQag==
x-ms-office365-filtering-correlation-id: 0d1d1a54-a5fc-4fb4-6c45-08d67ae105d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
x-ms-traffictypediagnostic: VI1PR04MB4301:
x-microsoft-antispam-prvs: <VI1PR04MB430130B5288DDAD3A5716D8799810@VI1PR04MB4301.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(26005)(102836004)(6512007)(25786009)(4326008)(105586002)(2201001)(86362001)(478600001)(186003)(52116002)(6436002)(53936002)(476003)(14454004)(106356001)(50226002)(8676002)(81156014)(81166006)(8936002)(7736002)(305945005)(486006)(316002)(68736007)(36756003)(7416002)(110136005)(54906003)(3846002)(6116002)(97736004)(78486014)(2906002)(6486002)(256004)(446003)(6506007)(386003)(11346002)(39060400002)(2616005)(2501003)(5660300001)(55236004)(76176011)(66066001)(71200400001)(71190400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cNhDKgm5pwIMA/nx8CUNrVrPQurfuicAc/v1/bSs1kYWRno1NcQjB4me1Ti34LhMZoHnXuhvhwS6EEJ3gW+jR/+9J3wECdB/ohRAYjY+8sDgsMgWq/GBsJl2sBg5DB/KnoRyJ2e2jrtDML4dBfYT+RjLy+i8+KhKevHmuXImk77+hKTi/+Jlx2CKgecljF1yXQkdIC9/ZBWDlHZ5vFDKtgkAorN9Of84v/gAPbmIg6/6sqDKmutRcss6x/0SSIej+IDPOKt8C6O3CPAiFr6IBAhqhsJctf5g1LER6HFvHPesw1Y+lNapbvp3eYqx9yR00D5RJllmILKgHTxROtLYAImuI+FQkikc6fh0hF6XcThLXzRAYK1JX+6GYYPSOyRZYm/lbdiQndXGYPrRwfxVKns9Za+XDneivZkli/Y2IYU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1d1a54-a5fc-4fb4-6c45-08d67ae105d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:00:15.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v8:
- None
Changes for v7:
- None
Changes for v6:
- None
Changes for v5:
- None
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- Removed node property 'big-endian'.
Changes for v2:
- Incorporated Rob review comments.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Docum=
entation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 000000000000..2cd67eb727d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -0,0 +1,39 @@
+* NXP Flex Serial Peripheral Interface (FSPI)
+
+Required properties:
+  - compatible : Should be "nxp,lx2160a-fspi"
+  - reg :        First contains the register location and length,
+                 Second contains the memory mapping address and length
+  - reg-names :  Should contain the resource reg names:
+	         - fspi_base: configuration register address space
+                 - fspi_mmap: memory mapped address space
+  - interrupts : Should contain the interrupt for the device
+
+Required SPI slave node properties:
+  - reg :        There are two buses (A and B) with two chip selects each.
+                 This encodes to which bus and CS the flash is connected:
+                 - <0>: Bus A, CS 0
+                 - <1>: Bus A, CS 1
+                 - <2>: Bus B, CS 0
+                 - <3>: Bus B, CS 1
+
+Example showing the usage of two SPI NOR slave devices on bus A:
+
+fspi0: spi@20c0000 {
+	compatible =3D "nxp,lx2160a-fspi";
+	reg =3D <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
+	reg-names =3D "fspi_base", "fspi_mmap";
+	interrupts =3D <0 25 0x4>; /* Level high type */
+	clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names =3D "fspi_en", "fspi";
+
+	mt35xu512aba0: flash@0 {
+		reg =3D <0>;
+		....
+	};
+
+	mt35xu512aba1: flash@1 {
+		reg =3D <1>;
+		....
+	};
+};
--=20
2.17.1

