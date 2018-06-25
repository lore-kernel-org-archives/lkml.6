Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E122C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A884A253F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H/g3xW0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A884A253F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeFYDPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:15:35 -0400
Received: from mail-ve1eur01on0048.outbound.protection.outlook.com ([104.47.1.48]:15584
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752228AbeFYDPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSMHVbQ2YTZe20tIKDlzYcEWDmAyp66gYf0RL5zEVkI=;
 b=H/g3xW0X5pgNoNUI130gRVK3fGVeJ6Tcp9qsf5QsFg9SNJpbYMFiEge3DCElxL1/TzmdUBNx562ZR3C8WQ2YGBEFqBgZkiaDxgmbtsZW7SdQ1jbqbv6jskhbnmnTUNpMsIvYCgvhm1KrHbx6Kn+f0YzuyFRxSFSU/lZVQqggvGE=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1460.eurprd04.prod.outlook.com (10.163.186.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Mon, 25 Jun 2018 03:15:29 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%6]) with mapi id 15.20.0884.023; Mon, 25 Jun 2018
 03:15:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] clk: imx6ul: remove clks_init_on array
Thread-Topic: [PATCH 4/4] clk: imx6ul: remove clks_init_on array
Thread-Index: AQHT+ued8HM2mOMOKEKQ03xpBewYz6Rwb5VA
Date:   Mon, 25 Jun 2018 03:15:28 +0000
Message-ID: <AM3PR04MB1315492102B943B04FBC4617F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
 <1527994847-2363-4-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1527994847-2363-4-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1460;7:OI9vp/dsXtwqDwpctbDrp4SSwCGtMWTTd8H2ILNi3f034yfuX9y84xs4XEgdWthWfeDKDltCihwyn/jBV810lqi2MPP++n7CzjYwzIhynYtfUS70l64lRGesWLibJaG3D/bgTpQu+RHOE9LSk1m2dNIHlgs8gGyg+KcBWGKgTB9qkwipd44c/6I0CNkaLii2y7lxvj9exyzeASRJ8hJN76IRB3LnIsXLpp8S+NhjHAXqZE04xouPZGeIhEzCNtsu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ae1aee4c-01f3-4631-5c1c-08d5da49e73d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1460;
x-ms-traffictypediagnostic: AM3PR04MB1460:
x-microsoft-antispam-prvs: <AM3PR04MB14603904C6E64D2CB62254BAF54A0@AM3PR04MB1460.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1460;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1460;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(39380400002)(13464003)(199004)(189003)(2201001)(2900100001)(11346002)(106356001)(6506007)(229853002)(53546011)(102836004)(446003)(186003)(53936002)(4326008)(478600001)(68736007)(44832011)(55016002)(9686003)(5250100002)(486006)(2501003)(105586002)(86362001)(3846002)(110136005)(6436002)(74316002)(99286004)(8936002)(5660300001)(33656002)(316002)(7736002)(305945005)(54906003)(97736004)(3660700001)(66066001)(25786009)(26005)(14454004)(6246003)(476003)(8676002)(76176011)(81166006)(7696005)(81156014)(6116002)(2906002)(3280700002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1460;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4KW+nmQY7YhPe2sL8xS07jnIJ7IrtDHWwVz2lxnWacg/sxYRmwfYa74l3assvz7iRlzoReZn7mvbIkOW0IDtI+RfMVBjQMi7k4gs4kqipcDXdhBI/aNWMn08dJztsysIlRXGGIq+72cuQNlyOKCaxEWqXN5n8vDoLibpc0vLLS4+t+lNhuHPjs/DslBGzoTdh4rmUwR52mFb92ulm19KV5b1feorg2auCPDzL0FJhsPfrmIwEm1G1iLcEcBz7wPHgVXwjfAZQC0wJeAhB2KM/5m922QmB1SaGF/6MTeRdiRBYh+AE7x2onouxVL7vP0UR28HBaClOk+idgZ8ASIhP8Zg0yirtLrnqRvwuYelKEE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1aee4c-01f3-4631-5c1c-08d5da49e73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 03:15:28.9194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Sunday, June 3, 2018 11:01 AM
> To: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; mturquette@baylibre.com; sboyd@kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.or=
g;
> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 4/4] clk: imx6ul: remove clks_init_on array
>=20
> Clock framework will enable those clocks registered with CLK_IS_CRITICAL =
flag,
> so no need to have clks_init_on array during clock initialization now.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> 	This patch is based on "[V2,1/2] clk: imx6ul: add GPIO clock gates".
>  drivers/clk/imx/clk-imx6ul.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c =
index
> 3ea2d97..d3f7f4d 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -79,12 +79,6 @@ static const char *cko_sels[] =3D { "cko1", "cko2", };
> static struct clk *clks[IMX6UL_CLK_END];  static struct clk_onecell_data
> clk_data;
>=20
> -static int const clks_init_on[] __initconst =3D {
> -	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2,
> -	IMX6UL_CLK_AXI, IMX6UL_CLK_ARM, IMX6UL_CLK_ROM,
> -	IMX6UL_CLK_MMDC_P0_FAST, IMX6UL_CLK_MMDC_P0_IPG,
> -};
> -
>  static const struct clk_div_table clk_enet_ref_table[] =3D {
>  	{ .val =3D 0, .div =3D 20, },
>  	{ .val =3D 1, .div =3D 10, },
> @@ -129,7 +123,6 @@ static void __init imx6ul_clocks_init(struct
> device_node *ccm_node)  {
>  	struct device_node *np;
>  	void __iomem *base;
> -	int i;
>=20
>  	clks[IMX6UL_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
>=20
> @@ -336,8 +329,8 @@ static void __init imx6ul_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX6UL_CLK_AHB]		=3D imx_clk_busy_divider("ahb",
> "periph",	base +  0x14, 10, 3,  base + 0x48, 1);
>=20
>  	/* CCGR0 */
> -	clks[IMX6UL_CLK_AIPSTZ1]	=3D imx_clk_gate2("aips_tz1",	"ahb",
> 	base + 0x68,	0);
> -	clks[IMX6UL_CLK_AIPSTZ2]	=3D imx_clk_gate2("aips_tz2",	"ahb",
> 	base + 0x68,	2);
> +	clks[IMX6UL_CLK_AIPSTZ1]	=3D imx_clk_gate2_flags("aips_tz1", "ahb",
> base + 0x68, 0, CLK_IS_CRITICAL);
> +	clks[IMX6UL_CLK_AIPSTZ2]	=3D imx_clk_gate2_flags("aips_tz2", "ahb",
> base + 0x68, 2, CLK_IS_CRITICAL);
>  	clks[IMX6UL_CLK_APBHDMA]	=3D imx_clk_gate2("apbh_dma",
> 	"bch_podf",	base + 0x68,	4);
>  	clks[IMX6UL_CLK_ASRC_IPG]	=3D imx_clk_gate2_shared("asrc_ipg",
> 	"ahb",	base + 0x68,	6, &share_count_asrc);
>  	clks[IMX6UL_CLK_ASRC_MEM]	=3D imx_clk_gate2_shared("asrc_mem",
> 	"ahb",	base + 0x68,	6, &share_count_asrc);
> @@ -412,9 +405,9 @@ static void __init imx6ul_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX6UL_CLK_GPIO4]		=3D imx_clk_gate2("gpio4",	"ipg",
> 	base + 0x74,	12);
>  	clks[IMX6UL_CLK_QSPI]		=3D imx_clk_gate2("qspi1",	"qspi1_podf",
> 	base + 0x74,	14);
>  	clks[IMX6UL_CLK_WDOG1]		=3D imx_clk_gate2("wdog1",	"ipg",
> 	base + 0x74,	16);
> -	clks[IMX6UL_CLK_MMDC_P0_FAST]	=3D imx_clk_gate("mmdc_p0_fast",
> "mmdc_podf", base + 0x74,	20);
> -	clks[IMX6UL_CLK_MMDC_P0_IPG]	=3D imx_clk_gate2("mmdc_p0_ipg",
> 	"ipg",		base + 0x74,	24);
> -	clks[IMX6UL_CLK_AXI]		=3D imx_clk_gate("axi",	"axi_podf",	base
> + 0x74,	28);
> +	clks[IMX6UL_CLK_MMDC_P0_FAST]	=3D
> imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20,
> CLK_IS_CRITICAL);
> +	clks[IMX6UL_CLK_MMDC_P0_IPG]	=3D
> imx_clk_gate2_flags("mmdc_p0_ipg",	"ipg",		base + 0x74,	24,
> CLK_IS_CRITICAL);
> +	clks[IMX6UL_CLK_AXI]		=3D imx_clk_gate_flags("axi",	"axi_podf",
> 	base + 0x74,	28, CLK_IS_CRITICAL);
>=20
>  	/* CCGR4 */
>  	clks[IMX6UL_CLK_PER_BCH]	=3D imx_clk_gate2("per_bch",	"bch_podf",
> 	base + 0x78,	12);
> @@ -428,7 +421,7 @@ static void __init imx6ul_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX6UL_CLK_GPMI_APB]	=3D imx_clk_gate2("gpmi_apb",
> 	"bch_podf",	base + 0x78,	30);
>=20
>  	/* CCGR5 */
> -	clks[IMX6UL_CLK_ROM]		=3D imx_clk_gate2("rom",		"ahb",
> 	base + 0x7c,	0);
> +	clks[IMX6UL_CLK_ROM]		=3D imx_clk_gate2_flags("rom",	"ahb",
> 	base + 0x7c,	0,	CLK_IS_CRITICAL);
>  	clks[IMX6UL_CLK_SDMA]		=3D imx_clk_gate2("sdma",
> 	"ahb",		base + 0x7c,	6);
>  	clks[IMX6UL_CLK_KPP]		=3D imx_clk_gate2("kpp",		"ipg",
> 	base + 0x7c,	8);
>  	clks[IMX6UL_CLK_WDOG2]		=3D imx_clk_gate2("wdog2",	"ipg",
> 	base + 0x7c,	10);
> @@ -502,10 +495,6 @@ static void __init imx6ul_clocks_init(struct
> device_node *ccm_node)
>  	clk_set_rate(clks[IMX6UL_CLK_ENET2_REF], 50000000);
>  	clk_set_rate(clks[IMX6UL_CLK_CSI], 24000000);
>=20
> -	/* keep all the clks on just for bringup */
> -	for (i =3D 0; i < ARRAY_SIZE(clks_init_on); i++)
> -		clk_prepare_enable(clks[clks_init_on[i]]);
> -
>  	if (clk_on_imx6ull())
>  		clk_prepare_enable(clks[IMX6UL_CLK_AIPSTZ3]);
>=20
> --
> 2.7.4

