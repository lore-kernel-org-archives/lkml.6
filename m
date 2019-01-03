Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC35C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B97E20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MH3NtJ9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfACQ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:58:26 -0500
Received: from mail-eopbgr40071.outbound.protection.outlook.com ([40.107.4.71]:50099
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732436AbfACQ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2W4oPpJ9Qw1XhGSXFbQisvB9Ya9mKcKu3zYGtceLgo=;
 b=MH3NtJ9zyMfChGDNmtdH6Umz/QJoLxGTfMQJ7L4voUWFNc9Ptch+hMf5xBM4IJRAnKW02aFQotmTD1NdaaPV7FKPJlrAiQU4OEYCQsYR/7/2pM8dfJzIcUx9kCcUW5AWn8flry7ZUn9g9bZ63ZuEfuSM3MiCzOLjAUbF5J/aIXo=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3672.eurprd04.prod.outlook.com (52.133.30.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 16:58:20 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 16:58:20 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx: Remove Kconfig duplicate include
Thread-Topic: [PATCH] clk: imx: Remove Kconfig duplicate include
Thread-Index: AQHUo4WH33o9lH+uMEu23HleMCSa5Q==
Date:   Thu, 3 Jan 2019 16:58:20 +0000
Message-ID: <1546534688-17842-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0088.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::29) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3672;6:8Tdjst9Cz6kPLYXSWWRPswbtK/3PIJyamejsxBWF3oG7PdG9VmlspmfW4vfTADOy2XOZV83PrTDY+E1Lflqdk3f+VOjtCWISZukto+LS5VT40XulX8thoSGXSGrvSMEqsTBtDj55FSw2hAnY10OTqunlDm+4KhejngtEcMgyUevt4c0a50yrXhMXTY0vChvONez/hU9qjloO8AALFP3y87ARMSmTKo5fv1sijwcevTmSoi0bHHGvBfXqmT1cGDZETZXBIzWptCrWVvKqymvm+/ZvfeIs17ijYH6jeepcDZF7ZU/5MpVsu8g2KNlZlD8TF4CPnEJHd92k5XfeKY7g9+T60EqJxHlJDIck9vOi71ehTyiBOCF7UfP6KZenz9Cbg06xCz7ivrnpbJbM6TnAc0fflwwiar59zzYcPFS+/nuMGUtfyiQhKMMDYUkYcdFEIrcocKQloG8Fs2+m1f5u9A==;5:uyTpQznLz7OC6B0rmV9zoUMMcm0dPKB6N61Z6Q0EzwBxbSMpHZS7m7TwGvZuNGHWt5EBUUPGetwjOhHb3e4H8P+8ayuNdMiCQhdKSg78nH7R1iz64yXe+Izx0EO2JzL3PYWrdkk4P+ZqzzjHwDGpSWjFtIdGofYe0cdZyB8JS4ZG3fKPbLCIhnQPLHOP022Ou0oVVcJBMypeWfA1zklWbg==;7:oJp+sV4Fbq79B+XAMSalq5eF04eaGPc638ZBa+2wzUxHOYbb3fDYfxwbO4PzhK6hUsFfZIGiiZlmHrZ4EdXwxkXS2XV9nA159wC4rQ5UlO3nB6E9lLETwEe4a8xPBMg30RKMlpDRUfunar6nA3ZIxg==
x-ms-office365-filtering-correlation-id: 05823d7d-6bfb-430d-9959-08d6719ca9cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3672;
x-ms-traffictypediagnostic: AM6PR0402MB3672:
x-microsoft-antispam-prvs: <AM6PR0402MB3672B766AF72CEB8CD44A163F68D0@AM6PR0402MB3672.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3672;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3672;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(8676002)(2616005)(14454004)(66066001)(478600001)(5660300001)(106356001)(6486002)(81156014)(110136005)(54906003)(6436002)(316002)(105586002)(2906002)(8936002)(81166006)(6116002)(3846002)(476003)(14444005)(256004)(99286004)(305945005)(7736002)(102836004)(86362001)(186003)(486006)(52116002)(386003)(6506007)(26005)(575784001)(36756003)(6512007)(25786009)(53936002)(71200400001)(71190400001)(97736004)(4326008)(44832011)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3672;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /moH49YK0VANnTJYrG28Wus5NBRao6eE7F77ux0VXuhCAHA+LsnNvzC5/ITpJP19be6jMZ3kP5yX3G7bq5e0m/FSWc1my4mT19taWGDzI+eNIGMtcA3VlobV8lRMVEQNsef+ZCgvbHeJtwawOSCDPSONL0Kf8/c3qi802zvQxYq7H/SWbfvmuA2JcwCm654BR2oPaUDLApRAkfQk2N9CRRi0cgZI9Cc6GjRZPwbPgtm7ZuA57hCMpFgLWu7914RJkHhGIMjwICgyn4B5TLojNYCuyoZ5UAuRmM2zuXPEE/JP5r7ru8Yz+jsQUsE3ZqJh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05823d7d-6bfb-430d-9959-08d6719ca9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 16:58:20.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d360b130e210f2 ("clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX=
8MQ dependant")
introduced this dupplicate (and wrongfuly ordered).

Fixes: d360b130e210f2 ("clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX=
8MQ dependant")
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e5b2fe8..d2f0bb5 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -293,7 +293,6 @@ config COMMON_CLK_BD718XX
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
-source "drivers/clk/imx/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
 source "drivers/clk/imx/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
--=20
2.7.4

