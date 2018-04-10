Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbeDJNeC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:34:02 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:64723 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752907AbeDJNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:34:00 -0400
X-IronPort-AV: E=Sophos;i="5.48,432,1517842800";
   d="scan'208";a="277780393"
From: Biju Das <biju.das@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: renesas: rcar-gen2: Centralize quirks handling
Thread-Topic: [PATCH] clk: renesas: rcar-gen2: Centralize quirks handling
Thread-Index: AQHT0MyTD4lvxsMAREeMz70E3UkXuKP5/nWg
Date: Tue, 10 Apr 2018 13:33:55 +0000
Message-ID: <OSBPR01MB210330E35EB1211C84756A96B8BE0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1523365498-16789-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1523365498-16789-1-git-send-email-geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1829;7:nO7/koStY7TKNXbHQDxMpmOyvQi9ZQhFooxYBn1+ttVUJXmgtjMFmTcKTLtnX6M7neR6dbeHj+cyXFfGaBbqVv5tbIsYJqF/pqUu1kwl8W2uOdLKS1s13YW0qy8Pqt+I582U8L1JkILi1UHr2uSpwHTGKYYHdt9ZUJzshJRvTQDqRHVPFwcubB2sz/4sOjtP3/unXFMNaLrONzlgqXZchrw9uwN7W2J2zaVTwa1ahCZDqse4tMmDPvv7dK67V2PJ;20:s0vVp+N/mxdyMPclp8xnn+C8YIETk9g+8tUC9eAukzkia4gaDGrM788YcGbPd1zH6Ab/WKPY6EFnENqS3llrvO/znwPoclXEXUIEgYCJEeNmVIQODzNngcGhXcO4JE1tZF/l1tFXiaKTZ10i9+uAlU7VrkQ9XSflXO8s7AcH1b0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44758e85-a70b-4620-ba4c-08d59ee7b562
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1829;
x-ms-traffictypediagnostic: OSBPR01MB1829:
x-microsoft-antispam-prvs: <OSBPR01MB1829BAE210FBD510E31D950FB8BE0@OSBPR01MB1829.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:OSBPR01MB1829;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1829;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(346002)(366004)(13464003)(199004)(189003)(51914003)(110136005)(54906003)(105586002)(55016002)(5250100002)(7736002)(74316002)(305945005)(14454004)(478600001)(9686003)(4326008)(59450400001)(66066001)(53936002)(316002)(6436002)(68736007)(99286004)(6246003)(5660300001)(229853002)(2900100001)(6506007)(53546011)(76176011)(7696005)(81166006)(86362001)(81156014)(3846002)(446003)(186003)(8676002)(6116002)(2906002)(3660700001)(102836004)(106356001)(476003)(25786009)(8936002)(97736004)(33656002)(11346002)(3280700002)(26005)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1829;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
x-microsoft-antispam-message-info: FOBOG6KrgHX5kVo69aV5wVRff2OT8xzPHQH1RZWjz/dD6K8jECdlHa1U3g51MYBQ2mjPRdOiYKfKhDJItJ44vzMjUDqkDf6ANolBNI+586LK89oqtBd5A/lWJ0I8tqxD5zzQX3dT4DGppff/QgeZNJeri4IyCigQcJAsJPK900GGL0Ddz5qpOxgozmYwpIwV5IANpxRaU/9bEHcUYC+5nr42c/M/3rjj6rH8WQ0gGiLYY2/Kcp5xHfR2+fvyFs4JnVGhTX0MxSiO3PsVydg93wNbau0zWxzX9abMpjU6ev4IofwLTj0Y6Oiy/0/kCtlS/n++iXUIDy2DxbOdcY9p3MZFWBBmFRj1Qek0rAGLjJxToV/Q6lDPlEeHe9hdGZ8IHHDWYdX0MewMoFNtkx5bn8AQJzKcl8b+Cj8GFBerBnY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44758e85-a70b-4620-ba4c-08d59ee7b562
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 13:33:55.9167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1829
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3ADY6lm028547

Hi Geert,

Thanks for the patch.

> -----Original Message-----
> From: Geert Uytterhoeven [mailto:geert+renesas@glider.be]
> Sent: 10 April 2018 14:05
> To: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Biju Das <biju.das@bp.renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org; linux-clk@vger.kernel.org; linux-
> kernel@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH] clk: renesas: rcar-gen2: Centralize quirks handling
>
> Introduce centralized quirks handling like on R-Car Gen3, and convert the
> RZ/G1C SD clock table handling over to it.
>
> This makes it easier to add more quirks later, if/when needed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Biju Das <biju.das@bp.renesas.com>

> ---
> To be queued in clk-renesas-for-v4.18.
>
>  drivers/clk/renesas/rcar-gen2-cpg.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/renesas/rcar-gen2-cpg.c b/drivers/clk/renesas/rcar-
> gen2-cpg.c
> index 0c49f59d5074b1c4..daf88bc2cdae177b 100644
> --- a/drivers/clk/renesas/rcar-gen2-cpg.c
> +++ b/drivers/clk/renesas/rcar-gen2-cpg.c
> @@ -261,9 +261,15 @@ static const struct clk_div_table
> cpg_sd01_div_table[] = {  static const struct rcar_gen2_cpg_pll_config
> *cpg_pll_config __initdata;  static unsigned int cpg_pll0_div __initdata;  static
> u32 cpg_mode __initdata;
> +static u32 cpg_quirks __initdata;
>
> -static const struct soc_device_attribute soc_r8a77470[] = {
> -{ .soc_id = "r8a77470" },
> +#define SD_SKIP_FIRSTBIT(0)/* Skip first clock in SD table
> */
> +
> +static const struct soc_device_attribute cpg_quirks_match[] __initconst = {
> +{
> +.soc_id = "r8a77470",
> +.data = (void *)SD_SKIP_FIRST,
> +},
>  { /* sentinel */ }
>  };
>
> @@ -333,7 +339,7 @@ struct clk * __init rcar_gen2_cpg_clk_register(struct
> device *dev,
>
>  case CLK_TYPE_GEN2_SD0:
>  table = cpg_sd01_div_table;
> -if (soc_device_match(soc_r8a77470))
> +if (cpg_quirks & SD_SKIP_FIRST)
>  table++;
>
>  shift = 4;
> @@ -341,7 +347,7 @@ struct clk * __init rcar_gen2_cpg_clk_register(struct
> device *dev,
>
>  case CLK_TYPE_GEN2_SD1:
>  table = cpg_sd01_div_table;
> -if (soc_device_match(soc_r8a77470))
> +if (cpg_quirks & SD_SKIP_FIRST)
>  table++;
>
>  shift = 0;
> @@ -372,9 +378,15 @@ struct clk * __init
> rcar_gen2_cpg_clk_register(struct device *dev,  int __init
> rcar_gen2_cpg_init(const struct rcar_gen2_cpg_pll_config *config,
>        unsigned int pll0_div, u32 mode)  {
> +const struct soc_device_attribute *attr;
> +
>  cpg_pll_config = config;
>  cpg_pll0_div = pll0_div;
>  cpg_mode = mode;
> +attr = soc_device_match(cpg_quirks_match);
> +if (attr)
> +cpg_quirks = (uintptr_t)attr->data;
> +pr_debug("%s: mode = 0x%x quirks = 0x%x\n", __func__, mode,
> +cpg_quirks);
>
>  spin_lock_init(&cpg_lock);
>
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
