Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC561C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CF120850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JwFP7RiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfARHxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:53:55 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:33312
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfARHxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq9n+xbQIsdt642iVhTE1Zweaj3XQec8wWfxPR3BPR8=;
 b=JwFP7RiPDC6FSi8arYtAYlaVq8f8IZhhZFxu3nPc15RoncDQ6KNlXiYDuWVcdUel6tgC7fyzuGNhz61JSat3wnZno1qU+HFSI137ik6UAehUktn7/rfqU8PXi+rsVzVGRII/JrAYYrzTO85ZRHDJRI0c6NAZB9F1r3WoWvZtkac=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6001.eurprd04.prod.outlook.com (20.178.114.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 18 Jan 2019 07:53:49 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 07:53:49 +0000
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
Subject: [PATCH 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Topic: [PATCH 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
Thread-Index: AQHUrwLykX6+N3XFgUO8ens4SoCdhg==
Date:   Fri, 18 Jan 2019 07:53:49 +0000
Message-ID: <1547797668-30342-3-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6001;6:TFCXYd+bMaHInv+iNa/oPPnFDhgVLQS3UxlWXGELx6ciohjOqGrMS+5o35ZSJWunnFQMKwagEltl8lPCHXWtGWK1G8+oa6o+bG+aty9QJP6tdtJM2usOG1eHibi2Na6ILD0w5HHcyH7ckGey30p2A0vurHxEAQS1+w5hwA9EaxHQ1uMQNaT2EtInPGenhf/DErvZoLlvD7za30FbuSf4peEfnXPBCq7lPZes6A25HhXELi+WhPIr3sQjHyPfUwkEg5ZmpdDqER3kHdMilYCvqXj5xRvEkQ5c2/QKWF+lPAo04RgP4b25nD0L+Q7TVHlfR5NYaggvrCj9KwXYSYdACXmN3j4CcqR2bTpz7KaOi9SKeZmhxo0qi1klo2MHkcPNoundyebCe/fnCZReEcPRvu/hqa7aAyrOyVCBeBlgMbMa23xAClCyqB8HP5WdIsNKxsjmJT4K/tjkUJGlDqGzGA==;5:LuU1Rr2oxjLPBiRYUD9MK0ZjaBZanPsT3xw5ySVe3LMgI6e8oIt/kgb/ZRrKUgF5ZZoAdCzFmEMy8rp5HKpG2aY71dUFJj7g/C3UOn6yO8UeRqA+QUExTuRZRKX9YxNNzONAjZ07dYBTqucwpHzo8h+KUdr7Hlwpf6luSsS1S1VgMtXVnzYpTdANDOxzOPD+jfkzuOynvQwxMrjpTvNLKA==;7:UTeKpJ0eefxTl8azZXJ5AzXVNoMMaXdkciLX3zUYSpMikbq2SeaYObqPIy3qgKK9UaIs7aky9eh9mXP7HC9P96srkGkN2ELZeORbukSXeXsVNTz/VoGyBCPmLNL2ma2BI288O2P9eX4/FbB8IRidLA==
x-ms-office365-filtering-correlation-id: 614bafe8-bd6d-4942-e1ad-08d67d1a14f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6001;
x-ms-traffictypediagnostic: AM0PR04MB6001:
x-microsoft-antispam-prvs: <AM0PR04MB60018EB163B070623F4A8817809C0@AM0PR04MB6001.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(7736002)(486006)(54906003)(81156014)(316002)(256004)(6486002)(305945005)(53936002)(99286004)(44832011)(8936002)(8676002)(36756003)(81166006)(6512007)(2501003)(5660300001)(6116002)(446003)(3846002)(2616005)(5640700003)(11346002)(50226002)(97736004)(26005)(105586002)(6506007)(71190400001)(71200400001)(2351001)(476003)(186003)(102836004)(6436002)(76176011)(4326008)(25786009)(52116002)(386003)(86362001)(6916009)(2906002)(68736007)(66066001)(478600001)(14454004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6001;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U6U1M1QiXEj9EnzFB8AXRJL590u/3zuhezNqW0r/DsBDpmNeh+hOSf5qlbnXUQtc69oxcQYnKqTK1zkRjRZMubLyDYuEyTpuR8rErwAnrjtbvf0Z7iWb07lzfd2SqAPkT4kE9zBM0sNMTDCRj3le8YfbICQNDwEsfny4QNnf5GW8O37MK+fHhk/fFPOYODNms5Xhk0rNhfbygTXVYm1sTBOWGzRpwLIEpdqePVUro96KmQ2u8ZicqWvgena6MpESaq1qnby22GRc7dLUSRQD3Y15kj2p42a8UOzbDtjSEyHQ3iFEIf7ZmwUnIH6bivjBg/B2qk14nVgavOmz5Vhuyd/OQCGvL4TKXUvjlVXZUsq/zdnUXhoHe+GCSoNiSzvapmCHrV8N15KR4g8fEyBii3yRK/zwqj2kQG2LGqno6PA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614bafe8-bd6d-4942-e1ad-08d67d1a14f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 07:53:45.6060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6001
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
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +=
++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irq=
steer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqs=
teer.txt
index eaabcda..beeed4a 100644
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
+  from output 0 to 7. NOTE at least one output interrupt has to be specifi=
ed.
 - clocks: Should contain one clock for entry in clock-names
   see Documentation/devicetree/bindings/clock/clock-bindings.txt
 - clock-names:
--=20
2.7.4

