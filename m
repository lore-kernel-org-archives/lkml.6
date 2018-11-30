Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BB8C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A71920863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wfmUM94t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A71920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeK3PhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:37:15 -0500
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:51885
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbeK3PhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PogRoODy8CheOFo3C1LeqzmHIQLApDfacYBn7a85oUg=;
 b=wfmUM94tmD7S20M05Dbn1K8dljz4OTFR5pgESj1o3/kiokGQoRLnbMlv6hPJ+gE/Jl46KgV91TVj9LPQnVNemzZ2R8ASqoVCE+ryPHBxgfgOXjCdOHYbMVaW5l+vzviKEK3QrqlgAiLJH5HmvXgt33UQCJKrWEKcqYgr4n+//xI=
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com (20.177.50.90) by
 VI1PR04MB3182.eurprd04.prod.outlook.com (10.170.229.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 04:29:12 +0000
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359]) by VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359%2]) with mapi id 15.20.1339.031; Fri, 30 Nov 2018
 04:29:12 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 4/4] doc: lpspi: Document DT bindings for LPSPI slave mode
Thread-Topic: [PATCH V2 4/4] doc: lpspi: Document DT bindings for LPSPI slave
 mode
Thread-Index: AQHUiGU+2wJxwALiREybRqYs4xbk9w==
Date:   Fri, 30 Nov 2018 04:29:12 +0000
Message-ID: <20181130042753.28756-5-xiaoning.wang@nxp.com>
References: <20181130042753.28756-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181130042753.28756-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To VI1PR04MB5021.eurprd04.prod.outlook.com
 (2603:10a6:803:59::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3182;6:kkx9vUWHOwkjmr2GrFlHaC0hgl7NlbWR/kqwj+m5JqZmG54y8cAuMuE0nBLmNop1GpxM996eVuLB8uT4wsaWCkpK5SmBiIHssYED1aojAyEVDQlNLiz1ABjAoIc7kiD9mhQ4GrOYqkxDDacwu3GJEk+Vm/AmxcCYx8P3JhW03kNcG05EPB5mPMHvddt5s64g9SxC2SlQZySqm+dbnlxuoTaymGlbAT6yaBXuzQV8Z1GbRzbuZyv84ncFlmAmWU99rCXnBw6rGY2fUpw2kM5NoZxvjbDRWgCyAdJ38PPuKHuZuYW6fFrRDUzcr11VGakWDMAp9YlIY9O/eFh5SUgGSl3SHJh5Cfr+5f0LwkkMschbB6ZzS9CxBWGXMuakMF574NdPqTWZH5Z34ifpjKCYaCLtSApWFAykXw0MIARHpyhRg6U50nJaCerZGZ+gwVNAB+0ybOifF0D5dRN/EIgS1A==;5:s6FJpwmK+zmVz9yACivgF43JcxuP2IQD0lEW9d0e8Gm4GxWnOCu7mJw2oAAOW4pRPh0MHlYZyIFuZi33FQdKONjLwLgMzSW9R4sIv8UiLFgpz8Svd4u34/VyoJ/TEIz44qu1OhkSyVEod0i3yuAtp3lk4XvzZhpilh7ppCfKxaA=;7:UU/PwhhmiS8qmoqQwULrJJFCbMFn8N4bp63kainymSjbOO5Q4Y7QsuSWsnXdPOKsbMm6ywT/wGP9XkWMgfO2pfWbphgKhVbM81zGbMzc+rKcQnI/hSRiJFIcIOGB93WjoDDM1mUimLniHT67FxXC7Q==
x-ms-office365-filtering-correlation-id: ce517dab-b2c5-4705-dd95-08d6567c60aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3182;
x-ms-traffictypediagnostic: VI1PR04MB3182:
x-microsoft-antispam-prvs: <VI1PR04MB318288CD1D55BA3F0CF4F37CF3D30@VI1PR04MB3182.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3182;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3182;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(189003)(199004)(14454004)(97736004)(478600001)(105586002)(8936002)(6512007)(386003)(66066001)(7736002)(1730700003)(8676002)(5640700003)(26005)(81156014)(25786009)(81166006)(54906003)(186003)(2906002)(2501003)(102836004)(305945005)(53936002)(256004)(14444005)(6506007)(76176011)(5660300001)(316002)(11346002)(2616005)(1076002)(6486002)(6436002)(99286004)(486006)(106356001)(52116002)(446003)(476003)(6916009)(36756003)(6116002)(71190400001)(71200400001)(68736007)(86362001)(575784001)(2351001)(3846002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3182;H:VI1PR04MB5021.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2P8onG3eEInISxf3KXJ8TwRzXLiH4uVJyDOaxCYrVJAYAkDy9g4I09EBKCdDApegkCdflP2o/R341EoI8RUumDxZAMQIG9iJnKc21swPS7IH27ScNpEsjGwkwfAn2OowFRimQ8yAWAegJXD0BXIjY4NmP/7pPGxrEjolB8i21UHjIZVS9QN7yEpgiDsJ5O6NZ1q5pieDAP5jzz5lLB3eYj6rAhZI1s84ge7DUJYdUh+IJ+eAlrkZfEy+TOoi87s53QlrG9m8l4P2oen7jcf/oHRKBcfle98fR1RUUm3xRu30cmkm5LVFo9+wBksRmG36b/OtQAKFvn+WrBebatv8FMwlLSBLsXoPrcg4HW8+mgg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce517dab-b2c5-4705-dd95-08d6567c60aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 04:29:12.2872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "fsl,imx8qxp-spi", it does not exist in spi-fsl-lpspi.c driver
for now.

Add introductions of interrupt-parent and spi-slave.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Docu=
mentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 8d178a4503cf..9e44d85e0a68 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -3,10 +3,12 @@
 Required properties:
 - compatible :
   - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX=
7ULP soc
-  - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX=
8QXP soc
 - reg : address and length of the lpspi master registers
+- interrupt-parent : core interrupt controller
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
+- spi-slave : spi slave mode support. In slave mode, add this attribute wi=
thout
+	      value. In master mode, remove it.
=20
 Examples:
=20
@@ -16,4 +18,5 @@ lpspi2: lpspi@40290000 {
 	interrupt-parent =3D <&intc>;
 	interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 	clocks =3D <&clks IMX7ULP_CLK_LPSPI2>;
+	spi-slave;
 };
--=20
2.17.1

