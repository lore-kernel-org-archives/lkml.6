Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1132A2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kmjXea1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfAaQPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:15:53 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38358 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388307AbfAaQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:15:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="23261587"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 31 Jan 2019 09:15:50 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHTEbk25x9Flb/D9oAqFzjCnfnPfDNCVNyoxiVHJRFY=;
 b=kmjXea1iXNcDPQhH3r1wIthJbWPZqUf5y5r6vzaoFRuY0z2CY6vC+L3Xar9LZorhJ3R9nAvr/I+U3q0AoxZObvGdAPb6VRxi7xAsnlbLauvnyPRW107jDclXKoJHMfIR2K4Z0mAR/C5wTAhwUMvwLpT+JM8drdWok46I2KURK8k=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1315.namprd11.prod.outlook.com (10.173.32.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 16:15:49 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:48 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 09/10] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH v2 09/10] dt-bindings: spi: atmel-quadspi: QuadSPI driver
 for Microchip SAM9X60
Thread-Index: AQHUuYA6/sbMtxDVkEiSqq8xQrDUkg==
Date:   Thu, 31 Jan 2019 16:15:48 +0000
Message-ID: <20190131161515.21605-10-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1315;6:u4O2tOQpcV+ANXfMWsremsxm8LFC1CyDUt0LSuoyOGzmKgp2nBRzfXDWx3CXKZQWEs0X3t5x3Hul2AMXrG8/yKGvZyCgnYrlypNw6oymVVHAYBminVKBWOGuR3o6OJ8RpmbKeyQgGkZ7ASbDWbcEmgMnszAIiW9/W2/DraWtZQplLLyzDiC7f9KTEkJWbsPEJUxpFTAcYjDuIT3Lg5sx/HPbskAXRj39hqNWYWth9OmJNXgzJkVZDxgAEtLEbBaJKVl7UheMuxLSd+a53zmH/UvdzL98Ry3XXpjiQGuhdwy1peXTaYozelyt/A4fxWWGjl3T3sU/oh2N1bFiHCjYHjZ27M1C8sQFZQPHOdddEnyl5Qj0RjpMXKRVirPlxkBLnsQCzjdaqdaSUQfRX0c14gCwWZa8hwKOSRt6Oe/KUSFjc+FUtxwF45S2lgvMyZwQdBjIL37/IWq0a/Gfq5WgEA==;5:6GyLMcrm6BKPgM+2ASW5AyXuf4dfF3KzcO0QzSRKz7ILUweiLfPakd1K54s7Py7lErrC/u7vxJBJW9KtahlyJA/JTXPsDAwk3UeMs5nxN+9yS1121biJ8Rvhljfdg7WMZabl/k9NhQ/Sfvfp/pbm7KCP18zYczqUagNq3pumOBTxtWUqA7pS8R1mqNFebYgKmUSxLjKPepn01JiPeJ/fkw==;7:iIfUyM7QQmGsUcVC+koNtjiNIl3ZBWFWLDSYlMpo7vw5+jVjLg6n+EvoLeCe/DBiC5iFL894+fT+0IfpDFaZThLU6fn6FC1YsRBO3w2D0JNyj8tnAh3/VpQqtGuBUJuLSbwlOdKwnAO4RECiRFKsBg==
x-ms-office365-filtering-correlation-id: b1d275ca-f8d4-40ae-9c9b-08d687975cb6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1315;
x-ms-traffictypediagnostic: BN6PR11MB1315:
x-microsoft-antispam-prvs: <BN6PR11MB1315CE111A6C6C0D36CCC9DDF0910@BN6PR11MB1315.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(186003)(3846002)(107886003)(68736007)(386003)(6436002)(7736002)(76176011)(305945005)(105586002)(86362001)(256004)(14444005)(6506007)(52116002)(4326008)(106356001)(102836004)(26005)(99286004)(50226002)(8936002)(6486002)(2501003)(72206003)(1076003)(2906002)(446003)(11346002)(2616005)(97736004)(476003)(316002)(486006)(14454004)(54906003)(53936002)(110136005)(25786009)(8676002)(81166006)(81156014)(71190400001)(66066001)(71200400001)(7416002)(478600001)(6512007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1315;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6Hqda2Mdy2C40dD/T8YL5+t+awRPcs4XfTyUChhsFhh8CuXMhgA+Vr+PM2fwxEKg6cFn0d2HPbdn3y6UQ8+Duj6PWbfY5+BeWcTu58b2srcC2ufpzOMg+y0l8MVreDhfycV8hTbah6D0ewM/sZJi4dyId4O7q9Oge8uTsLTg4xFJg2dhHmIBHQr9Uxc+D0NQLk+CK0x357HC7/Jke/auV6JIwsbLc4Ayomt0/l5PG6juIz1CXsZOrnjSU9XGi/f/K0S+S58CMNaXi2+VrBRIvnntdOe4KrJ3LSoc9ZElcF5x6WcXt7xcZ2gekOu+BU4EYozxIYcMnGHxk5unT/R6joqkt4jBYa0UBU8ixtqtTwU8/kH3iMkIpqv2By7CSNqTFvLPgKaxa6yNbFqp/f2OlmPbJCF2Ag4dJsoUKzjG7iU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d275ca-f8d4-40ae-9c9b-08d687975cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:46.5610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1315
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
v2:
- make "pclk" mandatory even for sama5d2. Unnamed clk will be
supported in the driver.
- drop unneeded example

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Docu=
mentation/devicetree/bindings/spi/atmel-quadspi.txt
index e9dae6264d89..f949f9197636 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -1,14 +1,22 @@
 * Atmel Quad Serial Peripheral Interface (QSPI)
=20
 Required properties:
-- compatible:     Should be "atmel,sama5d2-qspi".
+- compatible:     Should be one of the following:
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
+- clock-names:    Should contain:
+		  - "pclk" for the peripheral clock
+		  - "qspick" for the system clock, when available (sam9x60)
 - #address-cells: Should be <1>.
 - #size-cells:    Should be <0>.
=20
--=20
2.9.5

