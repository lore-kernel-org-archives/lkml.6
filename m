Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5F3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B07020815
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CQri22m5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbeLTRCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:02:40 -0500
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:43072
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728221AbeLTRCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npb0HU6neG6jxyA+0GhkamPZy4WsdTdmcpSbwVqOnhY=;
 b=CQri22m5RNbrQEA+3n3sv4biAKTeD4eQPyQs16AlCVUsYEp0Er5KcMnNKIthJFy55TNjf6CcZMTWFnmEedOCZxvBr7L8sC9H9ANmbKdHKSVYTymvUvtB/RRdAH0DTx9RldfX4dpFnO9I26LkbyZH2tjogQYxDmR20b4AZeS3TFM=
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com (20.177.40.15) by
 AM0PR04MB4979.eurprd04.prod.outlook.com (20.177.40.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Thu, 20 Dec 2018 17:02:04 +0000
Received: from AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2]) by AM0PR04MB4994.eurprd04.prod.outlook.com
 ([fe80::f53c:adef:eddb:4a2%5]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 17:02:04 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] arm64: dts: lx2160a: Add dma-ranges property
Thread-Topic: [PATCH 2/2] arm64: dts: lx2160a: Add dma-ranges property
Thread-Index: AQHUmIW7W0c+0Qek60WT6eqPci2hKA==
Date:   Thu, 20 Dec 2018 17:02:04 +0000
Message-ID: <1545325306-1681-2-git-send-email-ruxandra.radulescu@nxp.com>
References: <1545325306-1681-1-git-send-email-ruxandra.radulescu@nxp.com>
In-Reply-To: <1545325306-1681-1-git-send-email-ruxandra.radulescu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0135.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::33) To AM0PR04MB4994.eurprd04.prod.outlook.com
 (2603:10a6:208:c7::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4979;6:PACgDS6rht6Jls6GrmwGOhKILJoFmiR2VV1Bb1MxKwBKUCjHwHVMupm7u8Xe/u2AjlRLPmKTsEKpfWvuhnyDoG2oNCMk7x4tvgCc8FE6Hk4YzWU2QCZPMReuQ4+HNDD2DCV9vUSuZwXpMAL5nCM6s8+1bDP53hz5KR1Z8xipsWtEPCLeWAAYfJOr+plPnG9TtGGc01wtaSoRHeQb7FQTgrMxurYVMrFTcY9m70euj/AG6Qq9MPoGcq2UvkqAoF39AmDvc3k8cijOObMQUUvSa4fhHv9rXYbdyq/pS5T8cfjCzo/pIg/61z4Ee27uikEO0VIFj14kzADV9mvGDqmnwto7T8rk+esYdg1reZ780vJJUsCNQzMNkjFvCZ8CTNsuhj4paa8Da1sd7bxzKZbleIZGEaQKDZgJAcH4WsglsvqWvCPDPZV5tGNbY0XDGyIZGwb0XeYP5kkSURP36yridg==;5:UcSd+UFr9Vy89+s7nd9RzexModNnHQ0TNz0yWob/WBczFi2vuIrv8rv1+G1SOU9CTlfU5YayeYH75AMVhRDtzi6joSsj9uthRVL6ynpiPSu7QNksBTEINimMr/N75rejKNXr3S9JHVJIrVBXL9dYxz1fjYU2EkWuWN64zEHsR1w=;7:33bzEkeqOCEgeyWizojW3/BnrBOmXf/JHB67Ovb9FEuVUSLI1DRmjq7hApfp4o0CMeOU6Y1dYDkBEyJe1K6VK0msz/mGl7QPlmfUFitghTCeoatWcbwF2dcz6kyGs1VTAZysuiWyBIql51xzSa1kUQ==
x-ms-office365-filtering-correlation-id: 8db05d75-0d75-4173-4657-08d6669cddb2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4979;
x-ms-traffictypediagnostic: AM0PR04MB4979:
x-microsoft-antispam-prvs: <AM0PR04MB49795A8D19EB840CFB6F792B94BF0@AM0PR04MB4979.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4979;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4979;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(5640700003)(26005)(316002)(76176011)(256004)(66066001)(52116002)(36756003)(54906003)(102836004)(476003)(486006)(386003)(6506007)(86362001)(6116002)(3846002)(68736007)(5660300001)(186003)(2351001)(2616005)(11346002)(99286004)(6486002)(2501003)(6916009)(4326008)(106356001)(25786009)(2906002)(478600001)(305945005)(6512007)(1730700003)(7736002)(81156014)(446003)(105586002)(14454004)(8936002)(71200400001)(97736004)(53936002)(71190400001)(8676002)(6436002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4979;H:AM0PR04MB4994.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z41lXj4K37YaZW9L1rYPIJu2P8FZ0C0Lx2M+o5tupnDTSF/lXxVe3p2dZHMF5herWrYZhHqgfekDZlYHHd7Ldupm6yyBR8Nf02hpSS9WGsU+e1TrsFnj6ZJ+Z+3BSOW10qy8SLsEXTcOvZn4JXanOqZetCzStKPZ256wXqQ2yyLRIM8Nvu5/vLA1lB1rZKfsbCxy4vjnWRplOfQlBRW8fQxaKC2XPJ9mU5qDaPdJ8R78nmFG1l5SmgXvZZPUgi3+y3AcWTSJRghKcBRuHbypMPmot/qDKc6NHRims/gSUadWlcnmAUvXI+nRM3l6QJN3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db05d75-0d75-4173-4657-08d6669cddb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 17:02:04.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing property from the soc node in LX2160A dts.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index 2366fd6..825624e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -398,6 +398,7 @@
 		#address-cells =3D <2>;
 		#size-cells =3D <2>;
 		ranges;
+		dma-ranges =3D <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
=20
 		crypto: crypto@8000000 {
 			compatible =3D "fsl,sec-v5.0", "fsl,sec-v4.0";
--=20
2.7.4

