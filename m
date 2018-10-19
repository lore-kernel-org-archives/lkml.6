Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EDEECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3149E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MzzNdVED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3149E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeJSJJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:09:22 -0400
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:10752
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbeJSJJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkdEd4WvK15Y96jmqKhYw9gk9vnw0fm8Lix7w+p8oIA=;
 b=MzzNdVEDI4+EfYiG8KgDWDI7Vyp2hlHWVCqINm09Qj9EkK29y4ldYSC0hWspW3RhE+XLz7vEs940KttOeuwu69TFtTkWLWXuJyOUVPYSsY1kEF/sZTBam0BI+SYio+i7U8eszZ2xhmNaOL4LQTv8isbgEvSJBeof6HbsQ4XcPqc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Fri, 19 Oct 2018 01:05:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4%3]) with mapi id 15.20.1250.028; Fri, 19 Oct 2018
 01:05:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] clk: imx7d: remove UART1 clock setting
Thread-Topic: [PATCH V2] clk: imx7d: remove UART1 clock setting
Thread-Index: AQHUZ0fX/clzkbvkKUacXQAxTw3NYQ==
Date:   Fri, 19 Oct 2018 01:05:36 +0000
Message-ID: <1539910863-2352-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:203:2e::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3755;6:uyUhT5NlEE8hQ28G3PorY18fN9ZpEbKvXIVKD/mcoVuQBdlSrr7weUOjtktzOd1oB2XkdC2nTrj0a3CG2LDQzltDuuc0pjxXcrbX37RcKXwCyk0vvcvWTvOfkj6A3hZc15z3nDgjm5CSylOxhq6/zIZXi0Xe8wstNhSSUrIs4SchH1SUqpqWLvhPWf2i+MsoS4p6n+x+I23obJKpXoTTWjJmrNW64Bb2vLUp8gN2jHtM4mH8naKqpTA7NkqZgXTu2cpYj6g2WBw4UOn7cQn5wsjOfIIMBt6YsK2j+yOZZH1aHqXlhOQi6o3YS+Y8Ahs2p2tavuwQXWo6SzrdBtoCxfHjkgSHxgEtDSPoI3/8qLkG6LuLpeM9lf5JW6TV7edyA1jOzIVBJM3wyUZyo+M6yPkbPLxbGVQTs0QAzeWOmmhqCqcaOwXJxt0ewYuVtVF740iKW0cte/bAZS6Biv7IFA==;5:xqNjgac+9Sg+Y8Jmojy9DnFVlbpYx6kmnOSGbkcVlz7lLAHJEIFlpxvQCioyJX9O84Z3zOC4TCw78Oeln+47rdWf1LomlP+qrEo6LK4yYpSCwOwYkwf64vy8dntsmSBZCrQ6etu2VzwPjaU3duyfSHKyHEKAdMX9W+LlAMIhECI=;7:DGu0hpuDcDuywRVTkyYBzS8avhzqwkt86titjghYKdG5Jcu2sZDEMQtGxYOlCM1NUGUd/V1e6JOK+wq0BI4brM8PjCmPWQssbiH69LOwO/Hlo60OVwbcmTaJUB9KXa3L5Mst05s3R5m0hzeNL3pg3+ge0kJQXwo+hjp0dSZ0x9UFcmQieKYxKcbZRYAPyP9I4gTBH6f1EQOc221/VdM06qgFqHwCdwJnMriukgiYDlWrdNEmrf5FTekg2UpXQAxX
x-ms-office365-filtering-correlation-id: 51534c72-5aa8-48ba-1250-08d6355ef9f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-microsoft-antispam-prvs: <DB3PR0402MB3755E888E714B8C8CDEDFC74F5F90@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3755;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3755;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(2501003)(97736004)(4326008)(66066001)(5250100002)(50226002)(6512007)(2900100001)(68736007)(36756003)(8936002)(8676002)(86362001)(2201001)(71190400001)(71200400001)(25786009)(316002)(81166006)(81156014)(7736002)(305945005)(5660300001)(3846002)(6116002)(110136005)(2906002)(14454004)(478600001)(256004)(52116002)(6486002)(53936002)(186003)(6436002)(476003)(486006)(26005)(386003)(102836004)(99286004)(6506007)(105586002)(106356001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wp7oCVWqIUtwS1BL13U/zvfdEiGDgXFXJA0h74OgjchVjazkHiWiCMuAhc3fNwtaMUYchucNX5zaTq25vBEFRcmMeJXL1NBIcpo08PWarBCYkYfKu8DXtT2QiBUr6GlMkxm3dmp8oWzkx5+DKZc2ls28uspaIGgb8Wyc3XKVNWm7XwVn/GuRU+YVko4pcPx+1zfqqfsHF8mS/6IRsBIQepvQmkchxuCPxjnZQlfc4xanlgquwWqEPLv4Mldpmw0Vgj1ttaAERdWs5lUKxjzWeyxgf2os1uw2CHRRGwgPpkYLeVvGpIjzxVlrujfuntI4rALM7AhEPpyCLasmSkzHFtmRJ+GQtFUIgOJphiU4nBg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51534c72-5aa8-48ba-1250-08d6355ef9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 01:05:36.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are clock assignments in all i.MX7D dtb files for UART1,
below is the example in imx7d-sdb.dts, so setting UART1 clock
in clock driver is NOT necessary, actually, module clocks setting
should be done in module driver.

&uart1 {
	pinctrl-names =3D "default";
	pinctrl-0 =3D <&pinctrl_uart1>;
	assigned-clocks =3D <&clks IMX7D_UART1_ROOT_SRC>;
	assigned-clock-parents =3D <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
	status =3D "okay";
};

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index adb08f6..06c105d 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -886,9 +886,6 @@ static void __init imx7d_clocks_init(struct device_node=
 *ccm_node)
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter fr=
eq */
 	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
=20
-	/* set uart module clock's parent clock source that must be great then 80=
MHz */
-	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
-
 	/* Set clock rate for USBPHY, the USB_PLL at CCM is from USBOTG2 */
 	clks[IMX7D_USB1_MAIN_480M_CLK] =3D imx_clk_fixed_factor("pll_usb1_main_cl=
k", "osc", 20, 1);
 	clks[IMX7D_USB_MAIN_480M_CLK] =3D imx_clk_fixed_factor("pll_usb_main_clk"=
, "osc", 20, 1);
--=20
2.7.4

