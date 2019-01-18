Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09105C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01E820850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DQNGcGou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfARHxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:53:50 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:20679
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfARHxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ4ZIDUp9lYY1YnBYEaJiCI7aRFz6uMBJzAZu5mVeYc=;
 b=DQNGcGounHveDAVvu5ZQMyQGof12lpkvRVW/T0LReTpUWOSGHIgBwY1GscmBw3G/WxU2HMmGJL55AIBhlpaTkVv4IXNyFmh4Ay/BiBGvdePwV6toBto45aXe1bTYjPCuY1wONtVyBCBl1uI5KXBv/DHfPoPv9iHcQ8DgcD8cRzk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6001.eurprd04.prod.outlook.com (20.178.114.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 18 Jan 2019 07:53:45 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 07:53:45 +0000
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
Subject: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per channel
 instead of group number
Thread-Topic: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Index: AQHUrwLwJbVcVt8a/UCLFkmrL3vODw==
Date:   Fri, 18 Jan 2019 07:53:45 +0000
Message-ID: <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6001;6:sDzEAmbAPWAhO9OcC2Pn1Hix6sH03fWty6bpQYKIkQAfnHuwHaFk7V4b36t3BmvsVpqz7xIWBv5q1LwDe2JJpm1CNpdPvQ373sinlS3Vg96t9Xy94l2EHVvNvRWfkLW0y3jnNtBg3z+fbYpjVzcIVpQVZ7a0p1lI3r1YkrmUy3BvdYwdYXgGbsBSlgt9azB7eTQQEPmsZ/BSt0epYVrGa0vHB41Nulzh3pxBrXuMm4PVraEoYMiJA5Xv+L9f+ZItOjdHL5muqatetZjgp9GtBzC5oCT0u0cP7fTXAw/e+kE2kBZPKT+DQ5O4quASH+q4D+Fq3iB67woJdBD1jnHMYk/Z4Bmu9ZF015sCjpt1kGECcnEnCyUqa1Y/UBNBPwzhbHlQ1wihcFPQCNZcM5iNJbjffqIGswGbHdDftvoVTHmD0inA6N0IVYtGs4p6iXmZGRlDZ3Kmmaus05GP37PpEA==;5:diNJ5mMQWBiyiNheJkXJspSLW/ZGlU4n3ayuuovR/hbd6OTRSEa1lyncuXdhl+P+jNlzUfQeT2VImXUCbKukEqK2CdW4kfTzzRn08tRay2R1tcb8rlABQg97/VzAPYQLJnBz/zqAWDKKCqru4MApgHA/9ZeSRXk8QGgeAjB6Hkug+QTDL4IpFht7FilzaJO9dilsD8KkPbjEqeXgV2YLrA==;7:H2doQO4aPkDR4s91iXPQKiOr0q4GIlDXrRGMVO89v76KkSuJ5+j+GdasbMCUrPVL2upbwcVwax5RxYvuYVzlgj17LSJGITdiNQIkvD7QxaE8j6dCpNIaymzkLh3spCqfRpxVTO+biPR7P0hEbdNMRw==
x-ms-office365-filtering-correlation-id: 0dd3b988-aee0-41e1-7474-08d67d1a11fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6001;
x-ms-traffictypediagnostic: AM0PR04MB6001:
x-microsoft-antispam-prvs: <AM0PR04MB60014A455533AD29EDA98B6B809C0@AM0PR04MB6001.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(7736002)(486006)(54906003)(81156014)(316002)(256004)(6486002)(305945005)(53936002)(99286004)(44832011)(8936002)(8676002)(36756003)(81166006)(6512007)(2501003)(5660300001)(6116002)(446003)(3846002)(2616005)(5640700003)(11346002)(50226002)(97736004)(26005)(105586002)(6506007)(71190400001)(71200400001)(2351001)(476003)(186003)(102836004)(6436002)(76176011)(4326008)(25786009)(52116002)(386003)(86362001)(6916009)(2906002)(68736007)(66066001)(478600001)(14454004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6001;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NLiKVqvYAQQrQBTSPNtHjmjMpE3cXsrxm1nI/SzOuIkvUdzYDWWAxUUukqmITVg1b8QN9jrqX+JD+pXNLHrSkpeN+o91/kPRcE+JzZW7CaumxvqjRIDVc4j5drcL/RKszFEM3g9k0x7pZ4DkD8dDpIw4879n7N0IaO8pb6Ffs/7NmtDnUtFy/WpehcUj66xmPLxBlXQVyGLcbL6s4KTnx0d6dcrvROpS2lgILdycnR6bNIIf9rLKhvt4xhC9nSpxvOZReWudisT6oB605uayoPU/TV+S0JxQIDKlk2jFy5Fr9YBaly1Q5GkhVtaSDQSM7UcSiqju9AbJPvbdeu99CKhl58+h7+oCs/Am86QGVbJuHHSOIVxfB1KHpHbXTZexjBS0jkIUb9v6D26NyezgJolAywHRdHnazsu5gdirNTY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd3b988-aee0-41e1-7474-08d67d1a11fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 07:53:40.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all 64 interrupts may be used in one group. e.g. most irqsteer in
imx8qxp and imx8qm subsystems supports only 32 interrupts.

As the IP integration parameters are Channel number and interrupts number,
let's use fsl,irqs-per-chan to represents how many interrupts supported
by this irqsteer channel.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 ++=
+---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irq=
steer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqs=
teer.txt
index 45790ce..eaabcda 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.t=
xt
@@ -16,8 +16,8 @@ Required properties:
 - #interrupt-cells: Specifies the number of cells needed to encode an
   interrupt source. The value must be 1.
 - fsl,channel: The output channel that all input IRQs should be steered in=
to.
-- fsl,irq-groups: Number of IRQ groups managed by this controller instance=
.
-  Each group manages 64 input interrupts.
+- fsl,irqs-per-chan: Number of input interrupts per channel. Should be mul=
tiple of 32
+  input interrupts and up to 512 interrupts.
=20
 Example:
=20
@@ -28,7 +28,7 @@ Example:
 		clocks =3D <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
 		clock-names =3D "ipg";
 		fsl,channel =3D <0>;
-		fsl,irq-groups =3D <1>;
+		fsl,irqs-per-chan=3D <64>;
 		interrupt-controller;
 		#interrupt-cells =3D <1>;
 	};
--=20
2.7.4

