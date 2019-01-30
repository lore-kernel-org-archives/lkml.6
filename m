Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3DBC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A486C2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RxV9nspu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfA3PIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:50 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:57676 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbfA3PIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="23208579"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2019 08:08:47 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 08:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TG71vXqO0OqB+nWHjqNIPzPDwPgd30426H8GG2TERY=;
 b=RxV9nspuAxilRVYOjIeMcOThGQXSRxE0dRClL3CmOCGaCWPcrcKTEnFx2sUBDsfMQXfjYdboTFRBNE6xOxAgucctXjwjLAbKa/MUK/nHgymm+YlZ+knBpyuXbcPZpqPLpRYZ2orvI1iTQBU17EW6SD72rZd/sgoUTMqxgeZOIE8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1428.namprd11.prod.outlook.com (10.172.21.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 15:08:45 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 15:08:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Index: AQHUuK2xf3u2KPfoDkGm5485KIOYJw==
Date:   Wed, 30 Jan 2019 15:08:45 +0000
Message-ID: <20190130150818.24902-9-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190130150818.24902-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1428;6:FYV9AvQcZlKuG/kUR+LnYnWETLChnFPKMmwTNueG7OcioIUaTfd0PoZNem5Rqup9NdM7oFH1GFV1QLSx4Q9pC4F7mVI7vjdMfaT8XDnxESWVUapzYWDQ5RXvsimthswtNbMYVpWPIkthUosGrEOxOKcyJHbnKzhRYHgC1lOnVjYjJLjHKD4jlsYT0064idSxeH0/roXKwxoYUKrwa4qhFAxjfd9ZLe8yAS0pRSuT/lsDGsEnaQVvek3vg8GVqMvmdCQ1kkTvHK3xse6Y0oKxi2inwlnMSxcN3xBAMCUlJc1qKjLVX/cX1UlJYeh/eBVE4kdJ9WQxBKaIsDMZPQ2Mo/JJBOuNN3K5wJMsGQi14WdgapGAxe2W1k0gFJ+pkpSbOXP+sSR08YrUYyvoAm7IvyPas1E2TK2JajCuWQdVL4l/nkVp0fxMdIjAGzcr5C+XuNIvw2e0nioFAd3Rw1DWXw==;5:9S5g6qtGYGOaqwuXsPEwh21sKa63p/6NWWTPxnr0/Fmwj+WGXIKNydBVQTUHzjxR2l+lb15PqggaxkWstSM0jZFEEf/borTUpROe7IpMKvNc0KTyt+940u6bnTkNhdumPGyfxq2A4RG06TFNwfQEmZ5OolZbtlqgfYKQjL+eJ+mSRvj2kgTUi6zOUBSR8hhRj3J/WJt+fO/Nl1DwEoRUnQ==;7:gCpf+6Rc6DUF4SOf1qWhTB52QxPihpz77qlE1brWjw9Hlg5MqVd9mb/2+ackwBAhbErRYZ66yuJxjq0W60wiY/PKXwHzs3hRiXhbZbMhrP4Kix+Xc46bA552cJrpr+8aDSbCTKVZh7YiyPlH7lxMDQ==
x-ms-office365-filtering-correlation-id: f062ca55-80fd-444a-226f-08d686c4d419
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1428;
x-ms-traffictypediagnostic: BN6PR11MB1428:
x-microsoft-antispam-prvs: <BN6PR11MB142870BC1BEE6CBC9AB5E966F0900@BN6PR11MB1428.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(6436002)(68736007)(97736004)(6636002)(52116002)(6116002)(186003)(8936002)(50226002)(2501003)(66066001)(26005)(486006)(107886003)(3846002)(53936002)(4326008)(110136005)(86362001)(6486002)(71200400001)(81166006)(316002)(6506007)(102836004)(2616005)(11346002)(25786009)(476003)(71190400001)(54906003)(446003)(386003)(105586002)(8676002)(1076003)(305945005)(106356001)(2906002)(81156014)(478600001)(72206003)(7736002)(99286004)(76176011)(6512007)(256004)(14454004)(14444005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1428;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DWAma5nbTSyLJ/RSh+RUQ/9jzYXf+W8x0/Z2FmUhs7Mh61+8jQbumAljMsMI3U1M1cNC3wAqaPiZNNNXVmXN7TbdD1Yu7sFzSv62awmweu+K7VLT6E7wBkIxGqfwUypupeD/gZtqLp7kmtAL6zCbceUyKiP6yqStANc8CDTgIUNm60fUl/HwaTossSKDuYm2EpRukxCPv8rnT7Zu9i9Ax2Ud1jvh9LUP5KVSd01Rc3/fWuBYZK0ytj3YUGHGZmHc1j2t9FAy5l+JFcpGWSB7b//Rh7c9ABZKAQedGixFZg4+L6BoGX8j28vVD8hLu5cDXAQ+XQH2NbtbbzwmIrLmy1nz7nPYRjJm5QFXnI0T5mW/Ee9evTxw7cXsXFr+JIz9myXw/dupnUZ7sw0Cs4gFB9/BioPcMueK8oRxJ+XSW14=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f062ca55-80fd-444a-226f-08d686c4d419
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 15:08:43.4900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1428
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../devicetree/bindings/spi/atmel-quadspi.txt      | 28 ++++++++++++++++++=
++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Docu=
mentation/devicetree/bindings/spi/atmel-quadspi.txt
index e9dae6264d89..e7b7f297c5d7 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -1,14 +1,22 @@
 * Atmel Quad Serial Peripheral Interface (QSPI)
=20
 Required properties:
-- compatible:     Should be "atmel,sama5d2-qspi".
+- compatible:     Should be one of the following
+		  - "atmel,sama5d2-qspi"
+		  - "microchip,sam9x60-qspi"
 - reg:            Should contain the locations and lengths of the base reg=
isters
                   and the mapped memory.
 - reg-names:      Should contain the resource reg names:
                   - qspi_base: configuration register address space
                   - qspi_mmap: memory mapped address space
 - interrupts:     Should contain the interrupt for the device.
-- clocks:         The phandle of the clock needed by the QSPI controller.
+- clocks:	  - "atmel,sama5d2-qspi": the phandle of the clock needed by the
+		  QSPI controller.
+		  - "microchip,sam9x60-qspi": should reference the peripheral
+		  and system QSPI clocks.
+- clock-names:    Only for sam9x60 - should contain two strigs:
+		  - "pclk" for the peripheral clock
+		  - "qspick" for the system clock
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
=20
@@ -29,3 +37,19 @@ spi@f0020000 {
 		...
 	};
 };
+
+qspi@f0014000 {
+	compatible =3D "microchip,sam9x60-qspi";
+	reg =3D <0xf0014000 0x100>, <0x70000000 0x08000000>;
+	reg-names =3D "qspi_base", "qspi_mmap";
+	interrupts =3D <35 IRQ_TYPE_LEVEL_HIGH 7>;
+	clocks =3D  <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_SYSTEM 19>;
+	clock-names =3D "pclk", "qspick";
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+	pinctrl-names =3D "default";
+
+	flash@0 {
+		...
+	};
+};
--=20
2.9.5

