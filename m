Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeBZNPF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:15:05 -0500
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:33639
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752449AbeBZNPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:15:02 -0500
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: Colin King <colin.king@canonical.com>,
        Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        inus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: imx: fix unsigned check if nfuncs with less than
 or equal zero
Thread-Topic: [PATCH] pinctrl: imx: fix unsigned check if nfuncs with less
 than or equal zero
Thread-Index: AQHTrvnwlIEEua2LxUKAPWlm3f9MXKO2p4Fw
Date: Mon, 26 Feb 2018 13:14:59 +0000
Message-ID: <AM3PR04MB3063FA8C1B267634A8B1A5180C10@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <20180226120418.3589-1-colin.king@canonical.com>
In-Reply-To: <20180226120418.3589-1-colin.king@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB419;7:NkGXAqjnGHqoqy/u+PWoxl6Bwr7HFCo6MxHgXsOJGTsaQ2rqP5Wo0SqhT0ZisqK+GJJ+RYIGs08KSHoXTXh97gzSiLkOn8HTASa/MnYmFj0G+BdAKX7PVX0fNz0c3MZ4vnYVqj44JlK6YjVdqzWFo3VWi7yIOYXJ2WYBcGs70AF0I1tr9ofuVxxiH6SSFcC+bXfB26MFpgnjPKp9DfBnVOcoU/5XxGwpqM3EwGaGuKDvlQhasafFLdphM3BTwBTh
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff9293c3-7bff-4683-abff-08d57d1af014
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB419;
x-ms-traffictypediagnostic: AM3PR04MB419:
x-microsoft-antispam-prvs: <AM3PR04MB41938931DC2FEEEC68163B580C10@AM3PR04MB419.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501161)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB419;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB419;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(39380400002)(199004)(189003)(13464003)(7696005)(102836004)(6246003)(26005)(6436002)(99286004)(186003)(54906003)(81166006)(3280700002)(76176011)(55016002)(39060400002)(5660300001)(86362001)(105586002)(6506007)(53546011)(9686003)(106356001)(53936002)(3660700001)(14454004)(59450400001)(2900100001)(316002)(6116002)(3846002)(74316002)(68736007)(2906002)(2501003)(4326008)(2950100002)(97736004)(81156014)(8676002)(66066001)(7736002)(25786009)(110136005)(33656002)(478600001)(5250100002)(229853002)(8936002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB419;H:AM3PR04MB306.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: W3QJFGaibU++9V0Rcn3rK74l5RYE0op0qgNwwUqjReRdNF84c/nS8JH3QQdgs9yOwLsGOYbFOV3HShrA5YXr9A1FTHIfHyECZ1P/yJ5I65fSPzLdip8QVaTxBKdChxuiWc42tJn4iz6oxmM1zru9gpKZNtFZDMlbAd1tsWqB0ns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9293c3-7bff-4683-abff-08d57d1af014
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 13:14:59.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB419
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QDFBBi000739

> -----Original Message-----
> From: Colin King [mailto:colin.king@canonical.com]
> Sent: Monday, February 26, 2018 8:04 PM
> To: A.s. Dong <aisheng.dong@nxp.com>; Fabio Estevam
> <festevam@gmail.com>; Shawn Guo <shawnguo@kernel.org>; Stefan
> Agner <stefan@agner.ch>; inus Walleij <linus.walleij@linaro.org>; linux-
> gpio@vger.kernel.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] pinctrl: imx: fix unsigned check if nfuncs with less than or
> equal zero
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The unsigned integer nfuncs is being error checked with a value less or equal
> to zero; this is always false if of_get_child_count returns a -ve for an error
> condition since nfuncs is not signed. Fix this by making variables nfuncs and i
> signed integers.
> 
> Detected with Coccinelle:
> drivers/pinctrl/freescale/pinctrl-imx.c:620:6-12: WARNING: Unsigned
> expression compared with zero: nfuncs <= 0
> 
> Fixes: ae75ff814538 ("pinctrl: pinctrl-imx: add imx pinctrl core driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c
> b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 24aaddd760a0..1e8ca83352d0 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -605,8 +605,8 @@ static int imx_pinctrl_probe_dt(struct
> platform_device *pdev,
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device_node *child;
>  	struct pinctrl_dev *pctl = ipctl->pctl;
> -	u32 nfuncs = 0;
> -	u32 i = 0;
> +	int nfuncs = 0;
> +	int i = 0;
>  	bool flat_funcs;
> 

I saw 'i', later used, is converted to u32 unconditionally. (GCC did not complain)
e.g.
radix_tree_insert
imx_pinctrl_parse_functions

And of_get_child_count seems can't  return a minor value.

So does something like below look better?

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index c976ffe..4259209 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -612,7 +612,7 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
                nfuncs = 1;
        } else {
                nfuncs = of_get_child_count(np);
-               if (nfuncs <= 0) {
+               if (nfuncs == 0) {
                        dev_err(&pdev->dev, "no functions defined\n");
                        return -EINVAL;
                }

Regards
Dong Aisheng

>  	if (!np)
> --
> 2.15.1
