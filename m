Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AFA20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dg7z4uoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AFA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGKDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:03:39 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:29742
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbeLGKDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSVOiCvjMtqrDhjnCJvsJnI8PU2vwKfA9m06MTqZ9PY=;
 b=Dg7z4uoa49fMOmfjaYxOmRwFsDzpEl2eZIt06GgrkaqOZR1x0okRin0ZAVg/KQvOcT4k3Zo/nKo9iCRwCntMZBB7/N4sJD6/dIl65vOErV8gWCUKa6LyFi2PiGz0Jc5uMcLPGYwKvh7tw4z6N7GUIYxWmYSKF2c2uyNxJulTiQc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 10:03:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 10:03:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/3] clk: imx: imx7ulp: add arm hsrun mode clocks support
Thread-Topic: [PATCH 2/3] clk: imx: imx7ulp: add arm hsrun mode clocks support
Thread-Index: AQHUjhQdQKfld4FIY0izoXoEYuJ1eQ==
Date:   Fri, 7 Dec 2018 10:03:34 +0000
Message-ID: <1544176659-32022-2-git-send-email-Anson.Huang@nxp.com>
References: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3946;6:MmIvLLb2hJSt6ONhaMH7kYwyA2W64dXdyA7tBh7tOt2TK/5IselIji7z9HwYnSJ15Xo0l3wDmniz4b2BmYSDOlfJYCxTslfNVriKnCN6rz26R/J3Q4lpfs0SSVV/R2eOzsgcvTti9ZjygAUBjPBu2y+xYAdCnfs7aHpPf/TSI69/1+Ft0OCNZ8BzYi547oAj8M0LA2qcs4UonFZ8mlSmDkLFZuw/Uz72YL8WaOTW8wPMVP0pdBaI2rU01tGVyiKjwp8CPgZsVts+GdNtMf8nh+6SomitUBADCjKkGxw+uiBgsHG6FjCHXgZ4q76SxvVJKG+EWB9moS+QxKQ0TKdmXzvrXn3KH+eP35Nz/6Fg6cSUg+56vPUr645KJikfFn+JpfCZKHZQF25ub9Fk3pvGe3Cpt/AKXNu1VM5xJpvTQbpyzel4IMIkfWqh6v1t3+W8gYdPXbQkBLUIbeXSU9DUSA==;5:qmnAtL1GzU92fGoaWs4O5n+scfEqtdwKdP2VFQZOywcH4iJVhn7rrlkHZ1ulzosRXDcX778GJ0etInzNve0P39q9N2WpYQj77bIwXILxy67iq/D/KiLiWUaN8xqrIkHMjQkMesm/+mz/IthuNltHyI5a9tGy0xqs6DvKxtHy/I0=;7:j1At8ZLtQvYyyOgCdh23r+6BfsudgtkM+r0WXpJW3moj5fzIRSySeoZKoAIL3QgXU4DcC3/moA5/ktVRTWpf5ml2rp0A4fDE5J6yIJvMe9YDzlaHy8KP9G2sVtsq1UAew9GTw/soQ/fjgNT7IgYDfg==
x-ms-office365-filtering-correlation-id: bb0ce9af-d7f7-44f0-551e-08d65c2b3fb5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB39469236A85D94C95383F380F5AA0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3946;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3946;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(189003)(199004)(99286004)(305945005)(66066001)(7736002)(81156014)(2616005)(81166006)(446003)(102836004)(11346002)(476003)(26005)(97736004)(71190400001)(2201001)(2501003)(4326008)(36756003)(25786009)(478600001)(7416002)(5660300001)(86362001)(71200400001)(110136005)(316002)(3846002)(6116002)(68736007)(6486002)(2906002)(6506007)(6512007)(105586002)(6436002)(53936002)(186003)(106356001)(8936002)(14454004)(8676002)(52116002)(50226002)(14444005)(76176011)(386003)(256004)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fwcxc/2QqCqhOapT/mfHMNVTH2/FUI1z2AEpYFdLoTjtS+vSL3377WGhsgYtPFZxBjrutSDSlhXEGbxg7gN84UvHFkc/Kdg+k8R3OWag02MTUEXUvk2CVVs8ghG7dzUO8QlRX3H9pJKS/7RdvpNIXF6wKqDDBr1QWsTxNx17V+7HwKbTArLLvRzYY8wuk/Un+Hp4EgF0i++Js0J7kRR6n0vbR7kXEX3n4ibtXP4QyQ5w5nS+mDF9UVsbMouBLliWAvdEMpbSuqa9trB0Snro/FP96vIIyAeRlMbyJXYvX6JFM8N5pS16bge6fDSxEjXksr78o1yFAbk7k6kQIUj49ZLzhnRMu8gTMGgUfphuG2k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0ce9af-d7f7-44f0-551e-08d65c2b3fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 10:03:34.3742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP has a Cortex-A7 CPU which can run in RUN mode
or HSRUN mode, it is controlled in SMC1 module. The RUN
mode and HSRUN mode will use different clock source for
ARM, "divcore" for RUN mode and "hsrun_divcore" for HSRUN
mode, so the control bits in SMC1 module can be abstracted
as a HW clock mux, this patch adds HSRUN mode related
clocks in SCG1 module and adds "arm" clock in SMC1 module
to support RUN mode and HSRUN mode switch.

Latest clock tree in RUN mode as below:

 firc                                 0        0        0    48000000      =
    0     0  50000
    firc_bus_clk                      0        0        0    48000000      =
    0     0  50000
    hsrun_scs_sel                     0        0        0    48000000      =
    0     0  50000
       hsrun_divcore                  0        0        0    48000000      =
    0     0  50000

 sosc                                 3        3        3    24000000      =
    0     0  50000
    spll_pre_sel                      1        1        1    24000000      =
    0     0  50000
       spll_pre_div                   1        1        2    24000000      =
    0     0  50000
          spll                        1        1        2   528000000      =
    0     0  50000
             spll_pfd0                1        1        1   500210526      =
    0     0  50000
                spll_pfd_sel          1        1        0   500210526      =
    0     0  50000
                   spll_sel           1        1        0   500210526      =
    0     0  50000
                      scs_sel         1        1        0   500210526      =
    0     0  50000
                         divcore      1        1        0   500210526      =
    0     0  50000
                            arm       1        1        0   500210526      =
    0     0  50000

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 3b7507f..4e18f62 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -29,6 +29,7 @@ static const char * const ddr_sels[]		=3D { "apll_pfd_sel=
", "upll", };
 static const char * const nic_sels[]		=3D { "firc", "ddr_clk", };
 static const char * const periph_plat_sels[]	=3D { "dummy", "nic1_bus_clk"=
, "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
 static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_clk",=
 "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk"=
, };
+static const char * const arm_sels[]		=3D { "divcore", "dummy", "dummy", "=
hsrun_divcore", };
=20
 /* used by sosc/sirc/firc/ddr/spll/apll dividers */
 static const struct clk_div_table ulp_div_table[] =3D {
@@ -102,10 +103,12 @@ static void __init imx7ulp_clk_scg1_init(struct devic=
e_node *np)
=20
 	/* scs/ddr/nic select different clock source requires that clock to be en=
abled first */
 	clks[IMX7ULP_CLK_SYS_SEL]	=3D imx_clk_hw_mux2("scs_sel", base + 0x14, 24,=
 4, scs_sels, ARRAY_SIZE(scs_sels));
+	clks[IMX7ULP_CLK_HSRUN_SYS_SEL] =3D imx_clk_hw_mux2("hsrun_scs_sel", base=
 + 0x1c, 24, 4, scs_sels, ARRAY_SIZE(scs_sels));
 	clks[IMX7ULP_CLK_NIC_SEL]	=3D imx_clk_hw_mux2("nic_sel", base + 0x40, 28,=
 1, nic_sels, ARRAY_SIZE(nic_sels));
 	clks[IMX7ULP_CLK_DDR_SEL]	=3D imx_clk_hw_mux_flags("ddr_sel", base + 0x30=
, 24, 1, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARE=
NT_ENABLE);
=20
-	clks[IMX7ULP_CLK_CORE_DIV]	=3D imx_clk_hw_divider_flags("divcore",	"scs_s=
el",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_CORE_DIV]	=3D imx_clk_hw_divider_flags("divcore",	"scs_s=
el",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
+	clks[IMX7ULP_CLK_HSRUN_CORE_DIV] =3D imx_clk_hw_divider_flags("hsrun_divc=
ore", "hsrun_scs_sel", base + 0x1c, 16, 4, CLK_SET_RATE_PARENT);
=20
 	clks[IMX7ULP_CLK_DDR_DIV]	=3D imx_clk_divider_gate("ddr_clk", "ddr_sel", =
CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
 							       0, ulp_div_table, &imx_ccm_lock);
@@ -218,3 +221,29 @@ static void __init imx7ulp_clk_pcc3_init(struct device=
_node *np)
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc3, "fsl,imx7ulp-pcc3", imx7ulp_clk_pcc3_init=
);
+
+static void __init imx7ulp_clk_smc1_init(struct device_node *np)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	void __iomem *base;
+
+	clk_data =3D kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
+			   IMX7ULP_CLK_SMC1_END, GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num =3D IMX7ULP_CLK_SMC1_END;
+	clks =3D clk_data->hws;
+
+	/* SMC1 */
+	base =3D of_iomap(np, 0);
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_ARM] =3D imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, =
arm_sels, ARRAY_SIZE(arm_sels), CLK_IS_CRITICAL);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE(imx7ulp_clk_smc1, "fsl,imx7ulp-smc1", imx7ulp_clk_smc1_init=
);
--=20
2.7.4

