Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6318EC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F01A2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K2Y8zp8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F01A2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbeKPV0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:26:01 -0500
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:12395
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeKPV0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cD9Bj9YXyBtf3Y1n4dkaJ0o/tUjSOKIc4IpguhCOZg=;
 b=K2Y8zp8KcKGXm46l/Hnb+Ml3/1cvlFpAoa8DPvyxX3EWoeMHrJk1NV9ZG+IHUIQM5wOeSnUt8MEm5cnFvQTimPVBV/eT4vTStHuDDBiCC4/i+4mdPlWaAN1epf6SMRmIHQOpW4N+MFXNfAMDlADwcF1goIRk0k408DQrpRgO65o=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3294.eurprd04.prod.outlook.com (10.170.231.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 11:13:58 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 11:13:58 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
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
Subject: [PATCH v5 2/5] dt-bindings: spi: add binding file for NXP FlexSPI
 controller
Thread-Topic: [PATCH v5 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUfZ14KADl+doeRU6lN/QG09PPjg==
Date:   Fri, 16 Nov 2018 11:13:57 +0000
Message-ID: <1542366701-16065-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0149.apcprd04.prod.outlook.com
 (2603:1096:3:16::33) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3294;6:NcI7TDqW4Lsxwx7Z/r214tKdWbBxm3vNMdiXIdlNw2MjsrhuuErIeflsK3aCwdSyYKA5vFZtp4Scg/1gYNyF4svfPsHozLmL40TA5BmzlM/8iUGy3IVYJ79Gv0CzKL1L8XoR8h6itmx65jHBnAhyf5MomNReLNAGQDNtGrM1GJT1GV6UDa/feRR1+1zYncQO46mUJHc48ziiIq6hUsivVhOoV4Dc9FjCPuQ+1izBs+wk/nX0n7Podw/FA94P6/zjkH4kfH49tOmgp4QWoPFL7FemKiYELS6iz++B+5BcjXZCSjKU9vJqU7CY/lHecrFUW3p1t6MbgXdZ53STIR7MSc6zDqlw7IzYISuV4AQRwkwP3P3XvE1yBcvwhINfO8Gq4iw8KeB3Z2nMyLVX7rmgFsAqlIpLE94T/Lk43GlFzbRs9X0Frz2bxkYJWLvlBGqsokx/8wHSnwoMFzCAhaBJyA==;5:OV/cYFCnEFT13w0Ldg75hys8s7Ccyeb6PscuZKwANboFXc+IYjQGycnUqjh7bXriyEvKlDxfbIlY6PLAS4/zTQy1U2/UQmCmOhUpJ8AGZLWWtZjdShXFNrkVGKKTbhSJpnrmUbYZnJrvoDKQnLFNNwbqCIxBfnT/JVK/Lcscr1A=;7:y8LcuqxsaxSQsfOOeTV0oH0s8oP9EeqHh3ffg1sqmLEmEpHVqA5dhzaNDIzvyF05IUWFSvsVM2n61y+C6KrmVUybJHFJ9AXrelp6FpjFH+86RF/WHzWz8sOBnnv5mRMZCYK1J9WfZ2RV7qIGSQodfw==
x-ms-office365-filtering-correlation-id: 307f8a81-0b86-4217-8370-08d64bb49a59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3294;
x-ms-traffictypediagnostic: VI1PR04MB3294:
x-microsoft-antispam-prvs: <VI1PR04MB3294C53E9D206B17CC7C2B0699DD0@VI1PR04MB3294.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3294;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(199004)(189003)(2906002)(81166006)(8676002)(6436002)(106356001)(81156014)(6486002)(102836004)(25786009)(53936002)(4326008)(316002)(478600001)(8936002)(7416002)(6506007)(55236004)(6512007)(386003)(26005)(105586002)(186003)(54906003)(110136005)(68736007)(14454004)(99286004)(52116002)(2501003)(2900100001)(2201001)(76176011)(3846002)(6116002)(97736004)(476003)(2616005)(36756003)(78486014)(305945005)(486006)(7736002)(446003)(66066001)(256004)(71190400001)(86362001)(71200400001)(39060400002)(11346002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3294;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iD8NWTTbHiLxduSpxjD9w3dgKBUENe2zxZVNNQ3s2dhyM5bKU6v7k+XxdTLyFnBchlNcBuP3WQT9jvghUt1obNHOPl1aL6sGsYsM804R6Fe/lRqFkV9h3zZK8Rc+IpH3S89JXrJvjd9iEVQ9sPTEfdWPJTJgKbyMkNoBvWxKfoJJpi09kOE1DlLeXrNEkQqPm6C1CwZDz41baGibhyy59F0bSHoxJ4wo0/jjzvIoy3kK8VxURNNd6t8zKn7QEH9LEOkWDPYUL3IaheHBYFiCkVaLRuhuxDgJoHfrkXcMF80zJNndCQaXYAnzARJmVsntdkpd+j/Qs9m6yguIO4BGD2cmrIsYjtxkz6E78GEm64I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307f8a81-0b86-4217-8370-08d64bb49a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 11:13:57.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v5:
- None
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- Removed node property 'big-endian'.
Changes for v2:
- Incorporated Rob review comments.
 .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 39 ++++++++++++++++++=
++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Docum=
entation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 0000000..2cd67eb
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
2.7.4

