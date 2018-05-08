Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbeEHHcj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:32:39 -0400
Received: from mail-ve1eur01on0088.outbound.protection.outlook.com ([104.47.1.88]:15459
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754355AbeEHHch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:32:37 -0400
From: Jacky Bai <ping.bai@nxp.com>
To: Stefan Agner <stefan@agner.ch>, Shawn Guo <shawnguo@kernel.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Thread-Topic: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Thread-Index: AQHT4eiNBt8kJKQq8U6qTMNFXpuE4aQkQcSAgAE2FqA=
Date: Tue, 8 May 2018 07:32:33 +0000
Message-ID: <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
References: <20180418124908.3079-1-stefan@agner.ch>
 <20180502073807.GE3443@dragon> <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
In-Reply-To: <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com;
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB2075;7:2NeQlgjcPFi5ntR8FwOiKKR0sf34wbgayq+9RnfP5ugY+QQKgiO7CL5KYydJ+1c3w3zs/SDrBdeRym+Ds8J2pjp05ndeG9BVE6lkaFGT8asBmZ3vgU0DtAXiUPMCZ73Tc2P3etaSsg7uQnz3wn208aQXs+hfii7bX66pOAmtloFdtFk3RzpHYRkWKCLDyByKKBoZ6eZgs0PmkuwfeqUb3vz+8Y+uKD/9SckgcwdjoTd8U9NbJW5cSFxaNZC/4FF0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB2075;
x-ms-traffictypediagnostic: HE1PR04MB2075:
x-microsoft-antispam-prvs: <HE1PR04MB207598B5E125CB6B61D58CDC879A0@HE1PR04MB2075.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB2075;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB2075;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39380400002)(39860400002)(189003)(199004)(52314003)(76176011)(7696005)(26005)(3660700001)(99286004)(33656002)(305945005)(68736007)(6116002)(3846002)(6436002)(229853002)(5250100002)(3280700002)(7736002)(186003)(8676002)(8936002)(81166006)(25786009)(45080400002)(81156014)(66066001)(966005)(5660300001)(2906002)(59450400001)(97736004)(9686003)(55016002)(6246003)(110136005)(6306002)(575784001)(53936002)(86362001)(4326008)(486006)(478600001)(2900100001)(102836004)(446003)(105586002)(11346002)(53546011)(74316002)(316002)(54906003)(476003)(106356001)(6506007)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB2075;H:HE1PR04MB3113.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: euyyLi7j+Ne/XOcjVeTL+EhXYLxqjdtW8Rr0p3RbkFno5U7aH13D114K4qks3FbTHEHc/otxXXDNAAuKmDHGueGTfTRXRdYq+wsyUNgDm4lZnKXeDi7SU4qRxVW7v6Lu23/9aEIKUe4T7V5H8V37OdyFCRUgSHOxSZu2J3CviM73+xGcl6No0jvvSMKzgEXX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 61087251-305b-47a9-53d3-08d5b4b5dd4f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61087251-305b-47a9-53d3-08d5b4b5dd4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 07:32:33.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2075
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w487WlJ7025093

> Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
> 
> Hi Jacky,
> 
> On 02.05.2018 09:38, Shawn Guo wrote:
> > Hi Jacky,
> >
> > Do you see this problem on i.MX6 ULL?  What's your take on Stefan's fix?
> 
> Any comment to this?
> 
> It is 4.17.0-rc4 is out and i.MX 6ULL is still broken :-(
> 
Hi Stefan,

I have tried two 6ULL board, I don't meet such issue. System can boot up successfully with commit 6f9575e55632 included.
Anyway, the change in this patch is ok for me. it is no harm to the BUS clock change flow.

Jacky
> --
> Stefan
> 
> >
> > Shawn
> >
> > On Wed, Apr 18, 2018 at 02:49:08PM +0200, Stefan Agner wrote:
> >> On i.MX6 ULL using PLL3 seems to cause a freeze when setting the
> >> parent to IMX6UL_CLK_PLL3_USB_OTG. This only seems to appear since
> >> commit 6f9575e55632 ("clk: imx: Add CLK_IS_CRITICAL flag for busy
> >> divider and busy mux"), probably because the clock is now forced to
> >> be on.
> >>
> >> Fixes: 6f9575e55632("clk: imx: Add CLK_IS_CRITICAL flag for busy
> >> divider and busy mux")
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> This addresses a regression ssen on v4.17-rc1 where the kernel boots
> >> during clock initialization, see also:
> >>
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpa
> >>
> tchwork.kernel.org%2Fpatch%2F10295927%2F&data=02%7C01%7Cping.bai%
> 40nx
> >>
> p.com%7C023287ec65034c4db45f08d5b419effb%7C686ea1d3bc2b4c6fa92cd9
> 9c5c
> >>
> 301635%7C0%7C0%7C636612945852594725&sdata=U0ZGid9ZBey0FXfId2dhZb
> hVl8p
> >> CcjTiexG3JHYwCA4%3D&reserved=0
> >>
> >>  drivers/clk/imx/clk-imx6ul.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/imx/clk-imx6ul.c
> >> b/drivers/clk/imx/clk-imx6ul.c index 114ecbb94ec5..12320118f8de
> >> 100644
> >> --- a/drivers/clk/imx/clk-imx6ul.c
> >> +++ b/drivers/clk/imx/clk-imx6ul.c
> >> @@ -464,7 +464,7 @@ static void __init imx6ul_clocks_init(struct
> device_node *ccm_node)
> >>  	clk_set_rate(clks[IMX6UL_CLK_AHB], 99000000);
> >>
> >>  	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz
> */
> >> -	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL],
> clks[IMX6UL_CLK_PLL3_USB_OTG]);
> >> +	clk_set_parent(clks[IMX6UL_CLK_PERIPH_CLK2_SEL],
> >> +clks[IMX6UL_CLK_OSC]);
> >>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH],
> clks[IMX6UL_CLK_PERIPH_CLK2]);
> >>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH_PRE],
> clks[IMX6UL_CLK_PLL2_BUS]);
> >>  	clk_set_parent(clks[IMX6UL_CLK_PERIPH],
> >> clks[IMX6UL_CLK_PERIPH_PRE]);
> >> --
> >> 2.17.0
> >>
