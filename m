Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E1BC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3DD20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="wpWh6phX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfBEPn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:57 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:27311 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfBEPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="24251477"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 08:43:54 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAZ14Bv+7RFujKIMu9kHG3I3FL8WgGRHMzCkuHzgRaQ=;
 b=wpWh6phXlO8I4TxT4wIF7F847h5u4ByvkhplcLO+8tvZhWrrLulKSrX4m0k+6Ak9fya9ccyp/VjDlIhUUsYQ1Cy7h7tTkotF6s0sge95vzMPVopjD4wJX8PEOa2/ti7Kg9LZ3DoLlwYop6Dq32Sty8mAZvt4vPDTJqE3hikXpnY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1235.namprd11.prod.outlook.com (10.173.26.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 5 Feb 2019 15:43:51 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 09/13] dt-bindings: spi: atmel-quadspi: update example to
 new clock binding
Thread-Topic: [PATCH v5 09/13] dt-bindings: spi: atmel-quadspi: update example
 to new clock binding
Thread-Index: AQHUvWmXhrhdEtEmk0SYRZHvtJSa6A==
Date:   Tue, 5 Feb 2019 15:43:51 +0000
Message-ID: <20190205154257.29529-10-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1235;6:UqxM0t8T6swZ1KK9ANcKzi/8FbvNIXr6oXqcXTqUtHs53jMUxpKS7P7OXpH0zYzUwulvsMqCvd27r6N0NDTGyJYe+hO80rAjN0l0TELQU5sXB+VKGZaF7OEfe+kfjROCXXCtbKPnXjSrT3oj+jrL8cJIFG6EhbydKIYrPXTAQ02NoxxS6NMCcqTti67nNdeY+YNgDiSsSNH553jWRLcsscFKJB3FEaa3si794jvWazHezcwFprp/qBm38Fijm196bgEB2NslIUFwXWrUmEGgwiTeJXOdMEMxyjYjYszeP5v7PGBFeCABkabqugB8TvJe2IRdKhvehnMDLotg+PW2l/URb9udFfY8Cyi2zPbE2TQQasMI2W90sVJDziRhjBFkXdPwibWJYWRvpI3w6z7f3e1KdP+s9tO98UhQbMO9hvI9hmemM1SoAWOE/I7dv5Z6dhnAHEMbigAadS/aUncbWw==;5:j4U+2ocA6/7v7vnyGSBg70KRsecuxMT+S8lOrF1QQibp+UlZDio0vx+AcG/DPJBXszSPaQs9vZMcXvjWaV+0YpEa+/DqSMc0QCHduYejrpbfD3uVuTfWqnN/yQNoPJ6LKlKofsidIh3C5cgOVVL4fT0U4+/x3MNqQ6bQAVuRB/H+yUCHAHs/26AeaKPK/7flQgneRF4AMDyCSrl8YTFDVA==;7:Oh8WwwneTod8GD05kjW0Z4f8qXdBACF7Biug9/gatgqGTANBbc6xJMmv8tv/KawY23X5WQbHPxQCTy5vCc6V4ID+k/TjHhWBP+RbGqPPi3vXyMnVab1pODRI7eaY2FKdBN3CGElYNcNeIrmHajHT+A==
x-ms-office365-filtering-correlation-id: a39566ee-e584-4a89-8d4d-08d68b80b7ef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1235;
x-ms-traffictypediagnostic: BN6PR11MB1235:
x-microsoft-antispam-prvs: <BN6PR11MB1235EDEC59C42F2B082243A9F06E0@BN6PR11MB1235.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(346002)(136003)(199004)(189003)(14454004)(7416002)(486006)(305945005)(11346002)(7736002)(2501003)(6506007)(186003)(102836004)(26005)(68736007)(71190400001)(2906002)(476003)(2616005)(106356001)(97736004)(105586002)(71200400001)(86362001)(54906003)(72206003)(446003)(36756003)(4326008)(6486002)(6436002)(4744005)(386003)(478600001)(25786009)(1076003)(316002)(110136005)(8676002)(81156014)(52116002)(81166006)(8936002)(50226002)(66066001)(6512007)(256004)(53936002)(107886003)(14444005)(99286004)(6116002)(3846002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1235;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AIoOO37fZ/oj1UzErRLTQaqCSMiQGcQGcve7BrnGyDY6mvwnwxLzkWpx6FjU4zSEJnnDLe8ZD+CE7xugbqQePiHFJ6OR8rqsLpSWvhFusdCYX0xNdaRQcGSnwxKszgH8ExkAy6FiJ1q+Ux95g5ZSwXC+A6LPbKOHmNzkcGyG382L8C+5l+opbzWXW5HvPBrnLKhr1YmayBRMIn+5rQBlipMBWLAZDiIxl3NNH/MnJyT3z/6ws/zOxXK2Np4Kc/njnFJA8orODTCtcG+E4EFapCz1WoeS8x1Pobhq5xb/OxxXYTq2C/tGzNExjCPyUsToBPID/qCxbs9j8T4Hv3KbWHt8dJQ7gyOzumum6Ljks0yh0HsQUIN7GhyAbV97oB1Ch0Cp330W0KfpuTiHvx45NZck+ZOB0Px9ZdvxQpn4mqY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a39566ee-e584-4a89-8d4d-08d68b80b7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:45.4038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1235
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Introduced in:
commit b60557876849 ("ARM: dts: at91: sama5d2: switch to new clock binding"=
)

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: no change
v4: no change
v3: new patch

 Documentation/devicetree/bindings/spi/atmel-quadspi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt b/Docu=
mentation/devicetree/bindings/spi/atmel-quadspi.txt
index b93c1e2f25dd..e9dae6264d89 100644
--- a/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
@@ -19,7 +19,7 @@ spi@f0020000 {
 	reg =3D <0xf0020000 0x100>, <0xd0000000 0x8000000>;
 	reg-names =3D "qspi_base", "qspi_mmap";
 	interrupts =3D <52 IRQ_TYPE_LEVEL_HIGH 7>;
-	clocks =3D <&spi0_clk>;
+	clocks =3D <&pmc PMC_TYPE_PERIPHERAL 52>;
 	#address-cells =3D <1>;
 	#size-cells =3D <0>;
 	pinctrl-names =3D "default";
--=20
2.9.5

