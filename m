Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E14C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F285F218A6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="knB3XG2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfAHIKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:10:46 -0500
Received: from mail-eopbgr150132.outbound.protection.outlook.com ([40.107.15.132]:50333
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfAHIKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zhjn1i7bGwSBK4JdreO2DU1NYtPxF3SvdmIT10vSFyk=;
 b=knB3XG2uLnMjv+atODA/WShiPTWrz63YgOCbXIzMd9Bfj4Mp7BdN8zBzWqneSaHuqWSAtzH5yqkIByG/sgedUPDyl8Dz/iuTqsPA3XnzFYWHbSJqSbm3BuzZzfJbf/HRlipkCSkT05HRLnDiHnTiqlCzlX1rh5nV3bVZeabX7go=
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com (52.133.24.160) by
 AM6PR0702MB3736.eurprd07.prod.outlook.com (52.133.25.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.3; Tue, 8 Jan 2019 08:10:39 +0000
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b]) by AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b%5]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 08:10:39 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: edac: ARM Cortex A15 L2 asynchronous error
 detection
Thread-Topic: [PATCH 1/2] dt-bindings: edac: ARM Cortex A15 L2 asynchronous
 error detection
Thread-Index: AdSnKMGygTbg6PAeRvCigEcUcnE+bA==
Date:   Tue, 8 Jan 2019 08:10:39 +0000
Message-ID: <AM6PR0702MB3799A0BC3B07541CDBC4027EFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0702MB3736;6:1+iK3gNXeZHQ/WyfQl2WbOjLE2tvaIn8fUeyf8Oo1/QmMcf4gllV+tXp6G5ZApBxZ0kRzx+m660eU+NfEU4zSybvUcIJsGJUJaOT4zBdy4tt1ARrbPyZkTDAhRvtj0M//eZOgL/dbxz8kI2llkKLFGt6GJWeAy3u3LqA2wletjsZPJTNFdPeI08Csv5bNHEoLMUB4di/UCT4VJ8O0TjW6DHNTvxKOz1tuFToTnV8Nu/IeJh5wT5QuzTyYvlA/Wtmz/DNfd/PrW7s/sYY0021k1iqaWjKGr+Dw8yMflBlY9tnXNHQU/wCXyqS/A0SJMzl3cxF9WtJdVaMYzBVdHC9FYdP0rC3mCmlyxyYB53qLDL9wSMPBICDpVAu6y4NKGYDFYjFxaAWaJTAPcsXbwzZccByNfq9xJw/PprLNG1oflgx5EfUGK7vRnr4NY7hdI1SaQP1ZUhLhVk3vs3j/6eoVA==;5:9MZpObslopYrzYeNSF+yICH9uEK3zVhiMFLp8HR2gF85RWJXzXguFbY/YWmnbJww761QdgC4AUDQAAn1NNXoI/XuSAUZAS0G6lG2Uo0djhGVDkxZUerbhEmswRmzkvbd8MD+CO/meFdWECQMfSy8VzzFOxUIBB8Am/Nosw06TedYQvwAyr3VJ6FXgiYX4K70tT92mtX3Dd5HPQWn8ZpTbQ==;7:HpABYolunNX0qkF7OpcklgpHem9vSczFeTaCK+y4GesXbweVmWyCl2Py+AE7jvPrdSSV59/l8egw/5O6jeQTrWJRR+qxFjTAIPUgppOAxl+S+Y19KJQAdCvq2c+lS/vGvpcs8IeW1sQ6nu3YH4xDmA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(99286004)(97736004)(9686003)(86362001)(5660300001)(2201001)(7416002)(71200400001)(71190400001)(316002)(74316002)(68736007)(8936002)(55016002)(8676002)(110136005)(81166006)(53936002)(186003)(26005)(6346003)(54906003)(6506007)(3846002)(102836004)(6116002)(81156014)(478600001)(476003)(6636002)(6436002)(7696005)(14454004)(66066001)(33656002)(305945005)(25786009)(2906002)(4326008)(256004)(106356001)(105586002)(486006)(2501003)(7736002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0702MB3736;H:AM6PR0702MB3799.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 2863f539-a964-450f-a1b8-08d67540c6d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:AM6PR0702MB3736;
x-ms-traffictypediagnostic: AM6PR0702MB3736:
x-microsoft-antispam-prvs: <AM6PR0702MB373603E8B883ECD67600BF8EFA8A0@AM6PR0702MB3736.eurprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(11241501185)(806100)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0702MB3736;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0702MB3736;
x-forefront-prvs: 0911D5CE78
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: elniLPZQgkrkCZ0KguQjQztw5zAsut11kpqrmfVOgXfl2VleWKyLnFylU/qhlXiPNBFQP+NAyD523MRoT3OGe5oWk63Rkv28cLD9QIzW084EhFU7H8yEop+Pw8E6ORh57P1PbLpmXpzTc7R68eAvKrtz61/iKANwzHNySmRFsE4DJfgiBqQaD6nx6EBdbaBvNXqGmNxOCIaueh8SmOMA7J8AI6PJmLr2WO9HBq8vy6hJAeDhptYpGhjad/0TruTlXx5weyF4EA41reQImxCk0kbwmhrenjZ9bZTx+CiiWcMkNijZt58ouNqrHjjbGlEx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2863f539-a964-450f-a1b8-08d67540c6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 08:10:39.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property description + example for using the
Cortex A15 L2 asynchronous error detection driver.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
 .../bindings/edac/cortex_a15_l2_async_edac.txt     | 22 ++++++++++++++++++=
++++
 MAINTAINERS                                        |  7 +++++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/cortex_a15_l2_as=
ync_edac.txt

diff --git a/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_eda=
c.txt b/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
new file mode 100644
index 000000000000..9ad8c2497e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
@@ -0,0 +1,22 @@
+* ARM Cortex A15 L2 internal asynchronous error detection driver
+
+Support for L2 internal asynchronous error detection caused by L2 RAM
+double-bit ECC error or illegal writes to the Interrupt Controller
+memory-map region on the Cortex A15.
+
+Required properties:
+	- compatible: "arm,cortex-a15-l2-async-edac"
+	- interrupts: INTERRIRQ per CPU cluster
+
+Example:
+
+cortex-a15-l2-async-edac {
+	compatible =3D "arm,cortex-a15-l2-async-edac";
+	interrupts =3D <0 182 4>,
+		     <0 183 4>,
+		     <0 184 4>,
+		     <0 185 4>;
+};
+
+Reference:
+Cortex-A15 Technical Reference Manual, 7.7. Asynchronous errors
diff --git a/MAINTAINERS b/MAINTAINERS
index b755a89fa325..0796ad6e6490 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1094,6 +1094,13 @@ F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
=20
+ARM CORTEX A15 L2 INTERNAL ASYNCHRONOUS ERROR DETECTION DRIVER
+M:	Wladislav Wiebe <wladislav.wiebe@nokia.com>
+L:	linux-edac@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
+
 ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
--=20
2.16.1
