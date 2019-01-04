Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD3E21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UnCSZMf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfADQ1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:27:18 -0500
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:14624
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfADQ1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIt1y8llgjsX9LYWJSgjFJZue5zwWtBSXYlr6wEJXh8=;
 b=UnCSZMf3Ukk7ydo0Gz7fP9MKudDoDGJIgh68ujfYfJOxrzJFNq+km0/2bzEZYG7rbi2W+DUT1vx0mLKWUvEJBh2KmTDjn/D5d1hZJWCjj+SCdVNJxgZRNbyq+Km29PYQBKA3NFTvfwiEtJGolgzEq42ATiUA/rL201BvBbAjiEQ=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3759.eurprd04.prod.outlook.com (52.134.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 4 Jan 2019 16:27:05 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 16:27:05 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Cosmin Samoila <cosmin.samoila@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: Document support for ak4497
Thread-Topic: [PATCH 2/2] ASoC: dt-bindings: Document support for ak4497
Thread-Index: AQHUpEpULemyN2qL6Ui1aA6D/yuQ+Q==
Date:   Fri, 4 Jan 2019 16:27:04 +0000
Message-ID: <20190104162649.13103-3-daniel.baluta@nxp.com>
References: <20190104162649.13103-1-daniel.baluta@nxp.com>
In-Reply-To: <20190104162649.13103-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0085.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::38) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3759;6:Le+M0dq7YPPmZHsxaAKvdnA+WVbKXdz4j0bVVR/dZID2PrfD8J0ZN00FzO390Gzf7RlAvho+ScC8jcJnJXEwVl0BLkS1AAz3yrX7GAUmm2YXq0v+FIiuflDCvpKGG5BYLWLrYbxwiu8X5ylRovhwKhDUFooWoTxWgVg+qaJ6Dp8Vt9sHjNx0MPpkmXdo5DRaf7gmh8Z6XXrcNFmTcrw7wPZkMyg+luBeGOlKXnMwNk0G0Bgb4fY1p4A8jkCHjEeWvGRAyGjwoFfTj5S+QtE+8j27Jk22J/WVul/UkCYjy5yh86ullTy7M7fTQ5YuNXyDdiO0ioTItJvMnOLDZIPiFHkTCB1veYsf7UqP+sGYHF8ur5CxZxxoY1IZZ3EqpUwY0hiH/VozsWJS65J+B/pwWAvejzCeqBUlfFxCpjbqzN69ONqnm18JtIICTIzgt/478hjHTyW0ZQjrf41EmtaUxg==;5:u23XNO+vXDYaLV4QhZdfEz7vSQ9VkWClmSQ9As276GFL2veBpY2yfH4LXFurDbMCfu2c3HovzQJQmOmU/lMAGwGSvQfar5dBt5lhOXKjLu1RNtL+DjjVZA+HyUKkYGGqBscgrEEJ7MtPDsrA3dMo2wEOmLDgWU7txJpxSHR3KgE=;7:H0ZnI3XALeCH5sHO6cdDz4glvxpJdTxNcxkrXfEKQufkDwgpOtYacnecmAZtPJyiZ/Kp4TfNVtvG7rD8ASGjz5YhsRlOaoTwv4kqZVppLyXo13w1qdJFCJGrmWmzJmhbVd8ydREqahWvfGfurHMj0w==
x-ms-office365-filtering-correlation-id: ebb3848e-e1cb-4c3c-ba0e-08d672617683
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3759;
x-ms-traffictypediagnostic: VI1PR0402MB3759:
x-microsoft-antispam-prvs: <VI1PR0402MB3759A632E5B2993DAE576ACCF98E0@VI1PR0402MB3759.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3759;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3759;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(8676002)(4326008)(54906003)(316002)(44832011)(76176011)(305945005)(8936002)(99286004)(81156014)(2906002)(486006)(81166006)(53936002)(446003)(1076003)(25786009)(110136005)(105586002)(2501003)(36756003)(7736002)(52116002)(476003)(39060400002)(2616005)(11346002)(71200400001)(71190400001)(256004)(6116002)(3846002)(68736007)(106356001)(6512007)(14444005)(14454004)(6436002)(86362001)(575784001)(6506007)(478600001)(186003)(50226002)(386003)(5660300001)(66066001)(6486002)(102836004)(26005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3759;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FGZXNuFeX8fFiaQFJxMx7WJE3uBVSabpY15QoJlKU4yiUf5dwT2ZVWl8TpWkLH3lG1FKz67UWYri4irHdxI64qKDiNaCd4HlvcCugKKuAAJnFYoSdqXZbv5meZ3ydz3CBXNFZRg9bzZr7hkQisdtNp4IuoH1YGpdmr2Wfs+T/iRQ2ptRaa2PBvZ1yJZjnLQThKlu/mz38NACOvf/AQ2GPN86Df/5lIuh3pe1HvLoZQ1Qv6dOStxp/RfBA2fPF2C/ylJGnTeqAk9Gv0QvDa0t++O65fB0Es1eO3fUK+VJCsREor3hR8sc0V2MpTfj0Keq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb3848e-e1cb-4c3c-ba0e-08d672617683
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 16:27:04.0539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ak4458 driver supports also ak4497 codec.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documenta=
tion/devicetree/bindings/sound/ak4458.txt
index 7839be78448d..e5820235e0d5 100644
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -4,7 +4,7 @@ This device supports I2C mode.
=20
 Required properties:
=20
-- compatible : "asahi-kasei,ak4458"
+- compatible : "asahi-kasei,ak4458" or "asahi-kasei,ak4497"
 - reg : The I2C address of the device for I2C
=20
 Optional properties:
--=20
2.17.1

