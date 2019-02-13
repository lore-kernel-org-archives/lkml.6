Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B639AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F21222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QZ+V9uTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390996AbfBMJAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:00:01 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:53877 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390977AbfBMI74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:59:56 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="27631549"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 01:59:55 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 01:59:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPw2T2m6kmmj4wWbdyHd+t0TGyg9Z/DkqW49vDPvr2k=;
 b=QZ+V9uTkD58VjJcSvNCcGifdaRoReed2vvvXHxAQJvtHOvhGq9p5L88ynatUr68nU9mSZcm3Y9WBviUONH0BAS84B8ONt7FZ0rqttHHSrPDlrS4uemHOJAI3yfFcdTyI9cyCKUwvMB1GXLKUEsb0+Wa/qOQoT7l9Vu2Lxc5+kFw=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 08:59:52 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 08:59:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 03/11] dt-bindings: memory: atmel-ebi: add sam9x60 compatible
Thread-Topic: [PATCH 03/11] dt-bindings: memory: atmel-ebi: add sam9x60
 compatible
Thread-Index: AQHUw3p7x3NpzSUXUEKSSlFHsgR+5w==
Date:   Wed, 13 Feb 2019 08:59:52 +0000
Message-ID: <20190213085930.31578-4-tudor.ambarus@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190213085930.31578-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0085.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b264240-f6d1-4766-f97c-08d691919d86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR11MB0019;23:oM+PIxryIfvU/dSZ77DLdGJGtEAEsnebLl7oIVP?=
 =?iso-8859-1?Q?60xqxtwl6A71Jq7OWUFvwT06fZoCUsUJzX/Pih5LCmOGKbmizi3WYtPtPe?=
 =?iso-8859-1?Q?QQp4GeT3wFALL4hYg6P3Ht6GqayHX3INmjR4jftaF8QZrsyWrQXTAbc9te?=
 =?iso-8859-1?Q?rQBZHKV6hPotbGKGYOw3OiVbPbXDcOYni+fnkp6bI7V4heTpw+2f6w4jea?=
 =?iso-8859-1?Q?02CWMeXs6T7exTZJ5NlIcDrjj8kl+Ej263sKLT0B5sw4NwkiVxSjS+E81N?=
 =?iso-8859-1?Q?nS7bRzUXVNjRZE0RMzvf1TuH+aFbFCZVG8pTF3PIxF/EKZwWlt/DpvHbz+?=
 =?iso-8859-1?Q?bfsJEnDKfjWNBnGGmNx7nUXD+s7t1Wy3LHoDNh2iouos7bA9kTFYqSqSCg?=
 =?iso-8859-1?Q?X6BYsUVSdNv4vGT463CjmL84DKN/qfaqHM2GEfjIntWZmlDbvu0UrZzX7i?=
 =?iso-8859-1?Q?IakEf14zaqjEuIxYEWGnKG3V8IP3/tV3HispnKRKKmRUXJtv9u/KLjXcWP?=
 =?iso-8859-1?Q?lxSQHjy/+Xvi5mHvAspV/g58k7SWV5Ce5PaorchxjM4A91GO9YfW1gkJ3E?=
 =?iso-8859-1?Q?z076e8cKJ+nRN/pbjxG/03yjcANevunwxhI9qAr93BUaZCG7ilhumMco22?=
 =?iso-8859-1?Q?leVww1XUKZ2eBE1X2Ta8HMaXdaVAOp/RGsVZliUXBAkYhb1w++h9ibzeUm?=
 =?iso-8859-1?Q?PU+ENzQg23/I9LBGa0yX7LbPHlzXTWVAmfqBDeIRuD4DOhXnCfHGum2KPM?=
 =?iso-8859-1?Q?zdOCQtzb6j/IUE6MHKHpBzJv0XT0abuis3kdDqTIQhPWts+pt6G0tU2Rmm?=
 =?iso-8859-1?Q?yYZMqi3iQMNZH9s5SjOkZWsku1hPfJ5wMebHeXZz+hrBWcj4ZXsQbsIepL?=
 =?iso-8859-1?Q?IN9VCbJ4JvkZ0LX65hy2g6uvcYXa+EUDORrjb28niRBgQYQwTp2ozHn0hh?=
 =?iso-8859-1?Q?AvYjOFoRONPjEqy04/yJts8W5eW0JkTKX7H+jXCLENFKn+RKkCn6HlophK?=
 =?iso-8859-1?Q?mIR2h/Xmppy5UgTyNSI2JnAxrV/2SQoAcCZ4PSb51Zmzo2D6cE4iGIBpS+?=
 =?iso-8859-1?Q?sl+7wrD6oQ/akwS8flOuNMJVT0GC5hufN8wX+t16FIxRJowhfrqbsu5dy5?=
 =?iso-8859-1?Q?kNym0y0QNdlwnQnm+McYj43D3KW4yv3lKidR+ufCTHoFiAS/ozG1hjYXZj?=
 =?iso-8859-1?Q?ZaYavDkXG/Apw5/FK2a9ZqxrT/NdmX7UGCqxD9ZFYAGsfkfITyMUd8ut5Z?=
 =?iso-8859-1?Q?ZJqt+J6nYhhwEv/9sJO3FByHWqjHga2Mms3xHmqOuhhIU9VECMM1EteBko?=
 =?iso-8859-1?Q?h1xhkl2nYzxiHdV5rxMsM/uIntXinsXB0owlGzih9ow6aA6E/uBCI4QqjO?=
 =?iso-8859-1?Q?2XO1IjRYdIdXbIElq7JuEsjxxONgv?=
x-microsoft-antispam-prvs: <BN6PR11MB00195B9E22BF818C4B56A33DF0660@BN6PR11MB0019.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(81166006)(50226002)(106356001)(7416002)(6436002)(54906003)(2201001)(1076003)(81156014)(26005)(110136005)(476003)(102836004)(107886003)(8936002)(6512007)(6486002)(4326008)(446003)(2616005)(316002)(8676002)(4744005)(105586002)(99286004)(66066001)(486006)(6116002)(3846002)(186003)(11346002)(86362001)(2906002)(72206003)(71190400001)(14454004)(76176011)(53936002)(71200400001)(478600001)(68736007)(6506007)(386003)(2501003)(52116002)(97736004)(7736002)(305945005)(256004)(25786009)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kd/z2F+zVrmGXZITwz35dJUF/5DvymGbn7RHJaAZ+46UWX9NccTIbtt3RhCLJ8z9GSS/RFRvOgE/LWhBGOxhCwArf+oniiECTs+IJn7b836PvN0vuPiVBPahDgbuVEKd+9htRvNnLH8qACRz/OmNz195QYFgwEMZsljHEVmEhIQx6f5BPa23WIcaQgA+XvhR6STPJsAoTx3SIb5r3y9sqC4vBi1sUmKylzHDo+oyywC+iPQgs6gk+G5LRK509lERvYzEEVnUn51mWgOTI22Ry8TN31N/DPdA/CFWzsX2xD0uSkQ2e8HTSJnEEDjFHUOWUmaRyGtn9QcfCTSvUUWEMZRJWj1OuP7+oguAs6pOeXbFHK3sOFo8UUnOJLrpfgXbQvBaS1Sp77dAdzLKNKoPj7VXTOnsE7/dPMZ3MZFptYU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b264240-f6d1-4766-f97c-08d691919d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 08:59:48.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Add compatibility string for the sam9x60 EBI.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel,ebi=
.txt b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
index 9bb5f57e2066..94bf7896a688 100644
--- a/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
@@ -15,6 +15,7 @@ Required properties:
 			"atmel,at91sam9g45-ebi"
 			"atmel,at91sam9x5-ebi"
 			"atmel,sama5d3-ebi"
+			"microchip,sam9x60-ebi"
=20
 - reg:			Contains offset/length value for EBI memory mapping.
 			This property might contain several entries if the EBI
--=20
2.9.5

