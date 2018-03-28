Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeC1GvJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:51:09 -0400
Received: from mail-ve1eur01on0062.outbound.protection.outlook.com ([104.47.1.62]:33752
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750753AbeC1GvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:51:07 -0400
From: Abel Vesa <abel.vesa@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Abel Vesa <abelvesa@linux.com>, Daniel Baluta <daniel.baluta@nxp.com>,
        "b29396@freescale.com" <b29396@freescale.com>
Subject: Re: [PATCH] clk: imx7d: Move clks_init_on before any clock operations
Thread-Topic: [PATCH] clk: imx7d: Move clks_init_on before any clock
 operations
Thread-Index: AQHTxmCVn8njgFK+hEGH9XDIbstiQqPlNYEA
Date: Wed, 28 Mar 2018 06:51:02 +0000
Message-ID: <20180328065100.z5nxntyax7qk7jwb@fsr-ub1664-175>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
 <1522219599-10831-3-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1522219599-10831-3-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1454;7:24cb+lGUYyZPPs6R9alL+if8eXvfwIt7D5zgD9ZYxQgHtN+SO6dyBfWvuJlSoEMT8ewqzl3RRiHm1gDTydeYaS6NcLriqPirDjwu4JJ/XaRD0e74ZGR1IIWZnNVx3ThOPoVmEB0El313JDOwAZnmbsM5P3hPZEJbBaqc2InzoC2Em7BkVRJoUH7eS4wesX1ieaNgb4f+/8bT3jvDxyF/JWfb5O+0dSH5Ims3kvy9my00cH9PU24e3aDClt933emP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d11a9c3-2dfc-42f8-7c35-08d59478454a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1454;
x-ms-traffictypediagnostic: VI1PR04MB1454:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB14546C7B76ACF09719A807C3F6A30@VI1PR04MB1454.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(101931422205132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1454;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1454;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(346002)(39380400002)(396003)(376002)(39860400002)(189003)(199004)(3660700001)(2900100001)(7736002)(8676002)(6506007)(5660300001)(5250100002)(3280700002)(305945005)(76176011)(105586002)(54906003)(66066001)(33896004)(486005)(486005)(186003)(68736007)(102836004)(14454004)(86362001)(476003)(26005)(1411001)(4326008)(316002)(53936002)(6916009)(97736004)(11346002)(106356001)(446003)(6512007)(9686003)(99286004)(6246003)(81166006)(81156014)(107886003)(39060400002)(33716001)(229853002)(6436002)(8936002)(2906002)(6116002)(3846002)(1076002)(6486002)(478600001)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1454;H:VI1PR04MB2144.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MI1PfRfbBH6k24O1H+2EwwGi1tHbr7GU8/KccQTwn0WVDC7r95WOz1tXu7/5tnebbnfvOPJG544wro8KBZHY7B1VLFnZJL/zGQJgfO7BsMBFFM4kXBgVkk1/24OxYnlvotbeAEmQgKsu1STR+gCe0dC9q1jMK0P80+gknyFshJjDRYCS/qrFGZtoixsCSTIM3KNSe9wQwhqeu01IaPOQmopJwwdBqGKECrjmOas7lyPIAoA58yAfMUvtRCJEOLa7UatGjqGVLevhH2BIfOfwt8dYiGKGo3fL+EerLbGsAdQUdbfyYa7ph0g1kP9ED2frGefHVxSXyLzQ5d2Oa+zb/Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D09A0F6940C4A4CAFBCBDE87DF6D478@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d11a9c3-2dfc-42f8-7c35-08d59478454a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 06:51:02.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1454
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2S6pDuY018421

On Wed, Mar 28, 2018 at 09:46:36AM +0300, Abel Vesa wrote:
> From: Dong Aisheng <b29396@freescale.com>
> 
> For init on clocks we should move it at the first place in imx7d_clocks_init()
> before any clock operations, else the clock operation may fail in case the clock
> is still not on.
> 
> Acked-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 89bfa75..9b17805 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -433,13 +433,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>  	clks[IMX7D_PLL_AUDIO_MAIN_BYPASS] = imx_clk_mux_flags("pll_audio_main_bypass", base + 0xf0, 16, 1, pll_audio_bypass_sel, ARRAY_SIZE(pll_audio_bypass_sel), CLK_SET_RATE_PARENT);
>  	clks[IMX7D_PLL_VIDEO_MAIN_BYPASS] = imx_clk_mux_flags("pll_video_main_bypass", base + 0x130, 16, 1, pll_video_bypass_sel, ARRAY_SIZE(pll_video_bypass_sel), CLK_SET_RATE_PARENT);
>  
> -	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
> -	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
> -
>  	clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk", "pll_arm_main_bypass", base + 0x60, 13);
>  	clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_main_bypass", base + 0x70, 13);
>  	clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
> @@ -886,6 +879,13 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>  		clk_prepare_enable(clks[clks_init_on[i]]);
>  
> +	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
> +	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
> +
>  	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
>  	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
>  
> -- 
> 2.7.4
> 

Ignore this one please, mistakenly sent because of sending all the patches from the current folder.
The patchset applies on linux-next/master just fine without this one.

-- 
