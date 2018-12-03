Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E1AC65BB0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDBE2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WXqepTxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDBE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeLCFUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:20:36 -0500
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:7186
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbeLCFUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx5PtoLRLqMA7rj3bQYP/8UL/v7ftundbgJKa+rGfBo=;
 b=WXqepTxweYPPDn4xgO4yIQ3T/hHy4+yxyooL17e2QIov+A7Py4pJhPwM/9tzoT5B+DFg3Thcyq0lVrbwBbG1gBiCBOjvqZR1vXtOy/RWdZLoywlVggkrnZjF2IvVyETIuzU/KeWlI8IHFpo6mT3i9F8xQMK+kOvhf/FDtuM5YJs=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4138.eurprd04.prod.outlook.com (52.135.130.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Mon, 3 Dec 2018 05:20:31 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%5]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 05:20:31 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND V2 4/4] ARM: dts: imx7s: Add flexcan stop mode wakeup
 support
Thread-Topic: [PATCH RESEND V2 4/4] ARM: dts: imx7s: Add flexcan stop mode
 wakeup support
Thread-Index: AQHUisfp/sdCXuUyuUe3+R+pU/pfjw==
Date:   Mon, 3 Dec 2018 05:20:31 +0000
Message-ID: <20181203051753.1532-5-qiangqing.zhang@nxp.com>
References: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181203051753.1532-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4138;6:O5a0LLzeo/iiX5HtctdtckR0EaZpGILIivXuTFSHRZeAAEkCmYwynl1WRNrzpCM76VXwBK8fwY8XdTgjhR5aHp3bTaxJmUT3DJ6X7AAGyDFtQzPpCPk35Vq1Q2n1a30HteVnVdeRId4RmRjm2fvHQ3JikgGT3lT8NeLDNHGI62/j4k7yLyBBhk4qTTuZT4qWHSzLGTi3PY8+e6RKiEg7KA5MK+bgZ2c7h5Hfhg3eopbtr+Vk0+YfufCzqriYp5ea+x3B6+K5lPaXTU8qdPKM9Y13eCbsTyDCANmIkgF28fDJYSYJ7m+/PXfMbOqY7+Cbo8JEyqL0A6MZ0ZZJQEu5CZ2lZXleFgoO46GoOv2D+Oud85IN9cx3nQHfqHhlkZXdme6U20kP+8Ul7If9vo/Z1MLoLS01llH2sBf3ppcom/DdDC/nui1dwFoVlMF201HyvzsRpcRyvpDjSLh33IIatA==;5:dEa05URmyq3uAeIG9SOr0GvAI3ZGFb+5yqZY5WPx4Bx3fKUtjdX9cCbLo8kJ1SiVKt9vj0Mn0PbXNl3h3g23k9Y/++eBhdZwCNSTfL5RJrWXgfWtkfNNhvb/yZrIcjiC8epa+3wKHTxgIclMryqgOMciIufRfv0fflNebgHOwRY=;7:H4OVElxxRu7Uruj4bH/LkQm7pX1xCRge9WWO98OI3zL/Q4oWLf3jKOC2gwMJqaz657w235bgh6FFX13li1YtRXjjfYj0H7aeu4RJdnO16bbYZbcYS/QntOc/tUvmaSsf8oze/VxgxkwU9MCQLwa77w==
x-ms-office365-filtering-correlation-id: 492c4ce9-f699-4761-1367-08d658df0b67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4138;
x-ms-traffictypediagnostic: DB7PR04MB4138:
x-microsoft-antispam-prvs: <DB7PR04MB4138CFF2027235BBF2021E54E6AE0@DB7PR04MB4138.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4138;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4138;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(136003)(39860400002)(376002)(366004)(189003)(199004)(6512007)(2906002)(81156014)(478600001)(11346002)(8676002)(6486002)(446003)(110136005)(14454004)(486006)(81166006)(476003)(2616005)(71190400001)(53936002)(25786009)(6436002)(316002)(68736007)(54906003)(4326008)(50226002)(86362001)(2501003)(186003)(8936002)(66066001)(105586002)(106356001)(7736002)(97736004)(5660300001)(305945005)(14444005)(76176011)(102836004)(52116002)(99286004)(217873002)(6506007)(386003)(3846002)(6116002)(71200400001)(256004)(26005)(36756003)(1076002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4138;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n46IQgGLiHrf86kOsDzoPmEYnkf4Wht1bkiq6JjvMKooX9xHT0feEHwjX2fDsRm5dNTI6yUfEIay2G2yvklVtx7oFJ9UlAhB+KWsAfDavwihyPhfzm1jVbtbTBTLfBaz0WSNL3uG8ijCreyK7mUo4f1CSIT6YXA2kH6lFzbJi+oBbol0VjTl1klxADvOVC5CpHH65CajmkZMUbULWPB+QEn321CtZ8Lp7jHiuwsvGzNFxrdVMcOJix2lub8gL7tNXTzU3Ri0fBe7UqSah+pzY8OpuuIqmxc95wvvjtGcFh8sMLSEkeLuVetnzpBLzKuIbNSEDPgAKmhxW5xEM4kKis3EU7YdRDnskAVfHEdCX3o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492c4ce9-f699-4761-1367-08d658df0b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 05:20:31.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aisheng Dong <aisheng.dong@nxp.com>

Add stop-mode property which is required by stop mode wakeup
feature.

Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 477901c2061c..11ea993c48cc 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -873,6 +873,7 @@
 				clocks =3D <&clks IMX7D_CLK_DUMMY>,
 					<&clks IMX7D_CAN1_ROOT_CLK>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 1 0x10 17>;
 				status =3D "disabled";
 			};
=20
@@ -883,6 +884,7 @@
 				clocks =3D <&clks IMX7D_CLK_DUMMY>,
 					<&clks IMX7D_CAN2_ROOT_CLK>;
 				clock-names =3D "ipg", "per";
+				fsl,stop-mode =3D <&gpr 0x10 2 0x10 18>;
 				status =3D "disabled";
 			};
=20
--=20
2.17.1

