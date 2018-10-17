Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DE5C5ACCE
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D9C21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXL/V97O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D9C21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJQOGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:06:12 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:11568
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbeJQOGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOjGy3/zBPn+SEbPR8LwGZsHmr+SeGkQJhOgkK7x5/U=;
 b=TXL/V97OMBQsZmYko0N0eWZiYyTsbv0ngDhkrGz5uQJENFZP2Hmk1PfJh56s/7SjisndvAG2zxWbKz3k1v8TwZxtEMRHpEazixcg4vSlAAJHj/c2N9SwYsOsoTVVEvXU4gkvv6OJH3N+qG0oXuOjlKTCs5GaHS2TK2pnn5T2COI=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3802.eurprd04.prod.outlook.com (52.134.71.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Wed, 17 Oct 2018 06:12:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4%3]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 06:12:04 +0000
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
Subject: [PATCH 2/2] clk: imx7d: remove CLK_IS_CRITICAL flag for
 arm_a7_root_clk
Thread-Topic: [PATCH 2/2] clk: imx7d: remove CLK_IS_CRITICAL flag for
 arm_a7_root_clk
Thread-Index: AQHUZeBT5yWP/06UtkGmmrLiGQA/ug==
Date:   Wed, 17 Oct 2018 06:12:04 +0000
Message-ID: <1539756441-18776-2-git-send-email-Anson.Huang@nxp.com>
References: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0023.apcprd03.prod.outlook.com
 (2603:1096:203:2e::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3802;6:W8eqdetNsunrB1YArXh6/NNM07Uo9I4EbVINObm9DVzVRfz3q9uF1VIJPNP66Ci9UHJ3n5pGvFX5CISaUnmMzGv1BhnaX6RP1PiIYfqqcUvsHE2GwgknGXUheHD3JdC2tiZxVtK6W3A54at7sxHt9N1+hUWEsDTmOWaj+CdMc/DUlPuk7E7VzFIx37hLGVf5VK2lB+5q0FJIhuiOG15nNqm9hXtdImUG4rZvmWjUeijPG9FYMI2ZvZ8tfOJGOQL4xwu3NZJnF1L8uiNel8QhslxG99OZ88cXm3Ty2NiPiznsdVxJVm92vEFQhDEAJN1wEUyDgXmBAilcrCk93uGNK+vnGEBUryQ99zCnncVzaFhs0YLvxI3CL6F4rcYpqt6WPyvBmZZ3d2En2NMfIj2ZUqJyVYo6PinpINGLuKryvuBQUAtc73ew2t9J+nSsUeaj1zM15wGyyhprB2sd8us35w==;5:5f+P8Ip8gYU43SriPl/xLuSIQR5YhQubqNqlc86/fUiVjybrTzNj5afWW32kZXGwDTdBjGTNUiHBMduftnqLUzFUqFNiqdk4oJSJR/fGeIbsEdv8EgSI+FvbTSDQvqTqOft8uUWAKxPFLUR8txv9Li9P5cVAkgO3ZIdbOWUH3qg=;7:ywq/3uFxn8NV/M6O0AM0Z/LYpTaA5pnd/IiF9qMdYbFCW7t9j6tCKeSQhlPCEWTRo9+V2i6UNOV726osZXQBE5tcEcJJCr6nGiqOpRHX+E5gvyP4tH/GhEdUG8oeAqWNL9JjD9rR2Jvo9X95afPcD/2fS3yu8K8XrY8teS8HI8p9ju21EE6cfJtcPv8tYReg4y2sIHWBPD4NI6BIUVarOnC4M9vfuulcYTqO0LFAKIXY6XvLBDxs/L7gFGM6KAEg
x-ms-office365-filtering-correlation-id: 158417a3-e5c5-4bd1-f603-08d633f7756c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3802;
x-ms-traffictypediagnostic: DB3PR0402MB3802:
x-microsoft-antispam-prvs: <DB3PR0402MB3802683F7AF9B83498842DCAF5FF0@DB3PR0402MB3802.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991092);SRVR:DB3PR0402MB3802;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3802;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(3846002)(386003)(6116002)(76176011)(2906002)(97736004)(66066001)(5250100002)(102836004)(2201001)(86362001)(2501003)(4326008)(2900100001)(52116002)(36756003)(25786009)(6506007)(99286004)(5660300001)(14454004)(68736007)(110136005)(316002)(105586002)(106356001)(186003)(71200400001)(478600001)(256004)(6486002)(14444005)(71190400001)(6346003)(8676002)(50226002)(26005)(6512007)(8936002)(81156014)(11346002)(7736002)(305945005)(6436002)(53936002)(81166006)(476003)(486006)(2616005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3802;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-message-info: JmXvpkJBxDjEAOcV73jxNp6Wto0WGsWkaORYiqIUen3TqsrUbUqSmwXXvkX1wCZtfl/1+MmaI41UQxVjPsUemHK6aw0EC6hB5s7GjO4+pDYkgkKQZpCrTC9MhMrK5xWgsmh6wIPY9NZxIJCw5lF6gIZmVZHd+ozH1YxB7quHVYsqT2aaaHdrsRvRTE4BXfVnvblC9nexnCYVRl+UYHE9IGwmeEOG6gDoeBkbGy9LiGqtyaIDRdPdiB6CJ9AY8iidOaPv6PZ/rQusGj1ZazR/fcFIAgDNsqNyrVGgvkya3F1dxRgUXJl7XEglwHHm2bKKhrW7UCjkyFTEyzv1O8admOVsBZdknxsNjncgxvMAWqE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158417a3-e5c5-4bd1-f603-08d633f7756c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 06:12:04.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7D uses virtual cpu clock of "arm" clock to be child clock
of "arm_a7_root_clk" and it is with CLK_IS_CRITICAL flag set, so
no need to add CLK_IS_CRITICAL flag for keeping "arm_a7_root_clk"
use count correct, latest clock tree is as below in clk_summary:

pll_arm_main                         1        1        0   792000000       =
   0
      pll_arm_main_bypass            1        1        0   792000000       =
   0
         pll_arm_main_clk            1        1        0   792000000       =
   0
            arm_a7_src               1        1        0   792000000       =
   0
               arm_a7_cg             1        1        0   792000000       =
   0
                  arm_a7_div         1        1        0   792000000       =
   0
                     arm_a7_root_clk       1        1        0   792000000 =
   0
                        arm          1        1        0   792000000

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 076460b..adb08f6 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -775,7 +775,7 @@ static void __init imx7d_clocks_init(struct device_node=
 *ccm_node)
 	clks[IMX7D_CLKO1_ROOT_DIV] =3D imx_clk_divider2("clko1_post_div", "clko1_=
pre_div", base + 0xbd80, 0, 6);
 	clks[IMX7D_CLKO2_ROOT_DIV] =3D imx_clk_divider2("clko2_post_div", "clko2_=
pre_div", base + 0xbe00, 0, 6);
=20
-	clks[IMX7D_ARM_A7_ROOT_CLK] =3D imx_clk_gate2_flags("arm_a7_root_clk", "a=
rm_a7_div", base + 0x4000, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
+	clks[IMX7D_ARM_A7_ROOT_CLK] =3D imx_clk_gate2_flags("arm_a7_root_clk", "a=
rm_a7_div", base + 0x4000, 0, CLK_OPS_PARENT_ENABLE);
 	clks[IMX7D_ARM_M4_ROOT_CLK] =3D imx_clk_gate4("arm_m4_root_clk", "arm_m4_=
div", base + 0x4010, 0);
 	clks[IMX7D_MAIN_AXI_ROOT_CLK] =3D imx_clk_gate2_flags("main_axi_root_clk"=
, "axi_post_div", base + 0x4040, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE=
);
 	clks[IMX7D_DISP_AXI_ROOT_CLK] =3D imx_clk_gate4("disp_axi_root_clk", "dis=
p_axi_post_div", base + 0x4050, 0);
--=20
2.7.4

