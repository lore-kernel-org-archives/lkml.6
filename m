Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02660C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B506F20663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fce+UwE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B506F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502572AbeKWTxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:53:40 -0500
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:24416
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408801AbeKWTxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB2XDYK2YXUY/Fn39YrYQ5pNsx1fn/3TqpDZ6urTIHo=;
 b=Fce+UwE7h6L9ljxCHst6VSw4JfcfKSXLFgwPb00JcDzg7Pq9YLGCYPLJdRlvTxJChMjpqXgSvhh03VEqjJr4L0QXGSPotIFlEeseS7Alu/L3VpvWs+W3hwDfU1FNlPo5FBfeh3yC/hbzP/m/0d+nkbrti017eAYzMw2/kzn9MSE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Fri, 23 Nov 2018 09:10:09 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Fri, 23 Nov 2018
 09:10:09 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] dt-bindings: timer: gpt: update binding doc
Thread-Topic: [PATCH] dt-bindings: timer: gpt: update binding doc
Thread-Index: AQHUgwxVBuGAoI3VnkSnA7uAJmUIDQ==
Date:   Fri, 23 Nov 2018 09:10:09 +0000
Message-ID: <1542963884-20823-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3705;6:slZUaKzdNQpEfuyYED4tx0P2UFdBpnLfNf2oakI7RSsemBFmj/eEfjRjE6vuF+5pDgkd30gDoAGrW525x+ksHodZYLiBQVfpY/v33ThPVi35TC27HEtUji62qPGU9lYAFD/o7iGvY5FTdf6FfwNNpMAqwIc8sK0J193ptldfoQRiSp7T3oGLgkFcYe3Ap5LQp2qXz/GsKDw97mBbLVIUfc/wS8fvi1ah0BWI1mN/8bJKEu8DY6M/llWsQ4hFM1Nc6l3+OtAmfIyu7rdk5JoRvlfjBGK/NzLXx2ZckBhE/DjyDgd0BQgfroF/wuXw7qMeDewuaTGNmLm8iRYRahaVVuXMfD42Ry762RtpqFzLybeYX7bH1NJeby0lfIcpDnWJNrrmQ8lowm1ANnYsdF8nY8oow0ARbzXp7WwTlhKV6YgbE4fw+dw9w5vBkUfpqb34DFmo5bNsfuQxCNFW3Q11jQ==;5:af6YczDLjybyi2LQzN4v8+J1euXwPYNzsrA+nyCsmUjXDgkNHRhxffwmSPXbr2X7WQH0g/XFw8vKhmCHNPCvZOYugZJaqLvMHQAgCu4sAXgFDgFpDJmo0nAO57Ks4CKnWovXd2uVyuLDmXnGvkB6dAoqxAbmyRh5cJJ3EGWobcE=;7:sXdtrRq3BN0kho3FAgRvwFELpqycMtlQETspLdBAq5JxgcNMQ+mfG0hbxjpMLFaDf0v0Z1GGSWQQW+uSzDzzLf63RoslaxxBDwzkKcbPWalzirDyl49/oHfdSxZMIc6DBRezG0hNGv9Hr6E0OWttIg==
x-ms-office365-filtering-correlation-id: 7b544355-85fa-45da-8edc-08d65123778a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:
x-microsoft-antispam-prvs: <DB3PR0402MB37054A5C7FF31177697B6658F5D40@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3705;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3705;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(6436002)(256004)(110136005)(68736007)(316002)(105586002)(6486002)(2501003)(106356001)(66066001)(14444005)(71190400001)(2201001)(86362001)(3846002)(6116002)(71200400001)(486006)(2900100001)(2906002)(2616005)(476003)(14454004)(99286004)(1857600001)(4326008)(6512007)(5660300001)(6506007)(186003)(26005)(52116002)(81156014)(8676002)(305945005)(7736002)(36756003)(81166006)(102836004)(386003)(53936002)(97736004)(50226002)(15650500001)(25786009)(478600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IEopqaYD0lEc5i6YSMxAY6w+el+6F2oqpZ4Hru4jT9BK2vEXkRfvBw87fD/k+Su/h+rGixwtt1o8U/jw3o4RT3NyqZ0hxP0RgzhXM2Hr1RTZxvNksT1nYLPfMYBmdlrc/4KcIbbdGMGjF8soC5AQiB5UY2PvjcyZd/9KR4/7VGk0xu146TLwIcKti1iYm539x2taEWa3FK3LQ2JHy97jG36aEAaXdNxgGW1jnRC/xEfYy1vT8uvHsg9rjTvOB9UIbwuvCRVbxhaWUBiBaNJGKj0Y8NgJffDTXKrSTrBGo9XsmZ6SXj2Kjqc0Eq4HNzOD99UC0dDRYSyohTFz4lCYUehK5LveexvWQQqFddOs6fE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b544355-85fa-45da-8edc-08d65123778a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 09:10:09.6992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX GPT timer driver binding doc is out of date,
the "interrupts", "clocks" and "clock-names" do NOT match
current GPT driver implementation, update it and use i.MX6SX
as example.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/timer/fsl,imxgpt.txt       | 22 +++++++++++++-----=
----
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Docum=
entation/devicetree/bindings/timer/fsl,imxgpt.txt
index 9809b11..4e9fa16 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
@@ -2,17 +2,21 @@ Freescale i.MX General Purpose Timer (GPT)
=20
 Required properties:
=20
-- compatible : should be "fsl,<soc>-gpt"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one per timer channel.
-- clocks : The clocks provided by the SoC to drive the timer.
+- compatible : should be "fsl,<soc>-gpt".
+- reg : specifies base physical address and size of the registers.
+- interrupts : should be the clock event device interrupt.
+- clocks : the clocks provided by the SoC to drive the timer, must contain
+           an entry for each entry in clock-names.
+- clock-names : must include an "per" or "osc_per" entry, and "ipg" entry
+                is optional according to SoC design.
=20
 Example:
=20
-gpt1: timer@10003000 {
-	compatible =3D "fsl,imx27-gpt", "fsl,imx1-gpt";
-	reg =3D <0x10003000 0x1000>;
-	interrupts =3D <26>;
-	clocks =3D <&clks 46>, <&clks 61>;
+gpt: gpt@2098000 {
+	compatible =3D "fsl,imx6sx-gpt", "fsl,imx31-gpt";
+	reg =3D <0x02098000 0x4000>;
+	interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+	clocks =3D <&clks IMX6SX_CLK_GPT_BUS>,
+		 <&clks IMX6SX_CLK_GPT_3M>;
 	clock-names =3D "ipg", "per";
 };
--=20
2.7.4

