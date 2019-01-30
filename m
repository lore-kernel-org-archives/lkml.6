Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC5CC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3982084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RwTCYRg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfA3NGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:06:04 -0500
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:2209
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730979AbfA3NGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4kP5XK8jTLymvBHBnpKTFPhjBNQXKJHVrntRhOn7tw=;
 b=RwTCYRg3byvGhTWby+gwmpTk9GuWjPGAyR2PfktdvEgrSHH8gOE1IZ76orldbeTtt0samW1IjjmNnxwf/9MOs+jcsSCJzPK5+QydsuM7IzFWURX1xedUQ16TFqoQXlsnHSp8A0uJae3LQglcjn7/kbUPIlgh83DhhUhzdyns7rI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 13:05:59 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::bd44:e001:ab8d:1c51%2]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 13:05:59 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH V2 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Topic: [PATCH V2 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Index: AQHUuJyLKEGaOiVVBU20WR00FlnBPg==
Date:   Wed, 30 Jan 2019 13:05:59 +0000
Message-ID: <1548853196-11447-3-git-send-email-aisheng.dong@nxp.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4211;6:44GO/P1FYGlY65v00ZlXltAi+jf+XCk7D4bcudBemow2nfehDt/WaBqTJbTzcwQs0BiKNHGUQegRs+i4kH9Z9iIEo6VvazIT00yBIWG4OPlyytj1CzAbCXTVyql+8s4LZHZTZfRFmnWFhidyUd9/PYmBBiHs+h86MFNpZ10rb0ttdvDq2fw4G5Ooh5TDBxuyMZfrYaOhDUeblMSRAAOix4rlvtG5pF/JtZ9KuscWNXISpBXUzfKq0fXtjrHwuIVs8QIC7a49TddxWWJ1JJQQcCL3slwBSguPrNbsj8XkA/hRlV1NOZM7JG7FdU3qnsqY2XgaPJ0SL0ivQlsSTf+5LJ108z4ASVsa+UEPd/rceDWxsTS7asrKET4sLXbqrKjCOSCWB4sVfMiFYIRjgb0NsAZdbs7v3lzWRFCgvDYgU/8SvSZv4EFvu2p9bPmWkZs+Ljw7wt97GtDInSJCoRBxxA==;5:r8kMGDU3Mp6MDJPXUFMIOyLNkkLHhXe5Aj5i49dLy/UpvkZexpw8zWcUjpb9EqKmy6surlwvlHPzdP8ypD0+pYpcRUuAD9rhn7IX/HVy77gDpulI1eQaYDg3Mhqwm7z2TyCCMnglUioHFhUd/VWopIe43Ts0gXdYWUqCU2qztZru6r0nyEaBJlQCKT3zcYQCpEWUXhG/0v071h6UK95y6A==;7:q7UrirLQflBJvaYjtnwToZRqlagItn32CNGyqlxKzneL8HwTgWwM6++AlIX68pR7Ym9ki/M4eCVfJHzEVPJ88Ed+z4W2Kbk+S01t6sQaqo8cTecCWFEGAvFiW2iFOzND9kyCxo+gGxZqJXqmVQgllg==
x-ms-office365-filtering-correlation-id: d84c4e91-bf29-4686-8408-08d686b3ada2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
x-ms-traffictypediagnostic: AM0PR04MB4211:
x-microsoft-antispam-prvs: <AM0PR04MB42110B92CE4423AFC40EF06580900@AM0PR04MB4211.eurprd04.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(376002)(366004)(54534003)(199004)(189003)(2906002)(54906003)(53936002)(478600001)(71190400001)(71200400001)(6916009)(52116002)(6486002)(14454004)(50226002)(6436002)(7736002)(305945005)(2501003)(105586002)(106356001)(97736004)(2351001)(6116002)(3846002)(186003)(256004)(386003)(26005)(6506007)(86362001)(76176011)(102836004)(316002)(99286004)(66066001)(36756003)(2616005)(11346002)(5640700003)(25786009)(486006)(446003)(476003)(44832011)(6512007)(8676002)(68736007)(8936002)(81156014)(81166006)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: itf1FLj/pTT0okp+J3uhIXF6O9v3XGbXeQKhiHBPGu38PhFuQmYG3q1GUXQV5roaG9vtX5fqjGKOs7JC2hESHZRhvLrwejCiUIMuBJo+WQzcP2dgEAOw383FsKyS+Y1If6ed6iL+acEP/7G8wDdTATG3HyiyBzw9Htwg9g6R4K12B4w//Rv0Ckaecl/oCIvnNhgN0DwlGlPCSVIe/l0CmFo/u6l4631ziH5nWeE7KQzWVQTGR+QBBtjZkeh4eTsZVvzgATRDGwKfbtuK8XW6gfjPn62u55lcwuZvZoVmsdws9dKyrx6OxTSoGjX137RhGAmRiSM967xSlMsDQk3/fmwGQ7ghv6zk1ni5bWlSYGzUq87ZoaVFhw3aj1wm5bssX6KM8KZ7qbMHN+aXt9IqTI//FMNsd4ZMQ3kuBB29kI8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84c4e91-bf29-4686-8408-08d686b3ada2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 13:05:55.7277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One irqsteer channel can support up to 8 output interrupts.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v1->v2:
 * remove one unnecessary note.
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +=
++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irq=
steer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqs=
teer.txt
index 6d0a41b..984ab92 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
@@ -6,8 +6,9 @@ Required properties:
 	- "fsl,imx8m-irqsteer"
 	- "fsl,imx-irqsteer"
 - reg: Physical base address and size of registers.
-- interrupts: Should contain the parent interrupt line used to multiplex t=
he
-  input interrupts.
+- interrupts: Should contain the up to 8 parent interrupt lines used to
+  multiplex the input interrupts. They should be sepcified seqencially
+  from output 0 to 7.
 - clocks: Should contain one clock for entry in clock-names
   see Documentation/devicetree/bindings/clock/clock-bindings.txt
 - clock-names:
--=20
2.7.4

