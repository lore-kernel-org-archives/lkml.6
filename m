Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965594AbeEYJs6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:48:58 -0400
Received: from mail-he1eur01on0081.outbound.protection.outlook.com ([104.47.0.81]:24312
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965287AbeEYJsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:48:52 -0400
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
Subject: RE: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
Thread-Topic: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
Thread-Index: AQHTwMOS+d4Y5SGS00il8JKLQTZXlaPeDVWAgGKL63A=
Date: Fri, 25 May 2018 09:48:48 +0000
Message-ID: <AM0PR04MB421192DFF5F41078B54FCC1A80690@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
 <1521602391-30356-2-git-send-email-aisheng.dong@nxp.com>
 <152182399342.178046.13139513462419815903@swboyd.mtv.corp.google.com>
In-Reply-To: <152182399342.178046.13139513462419815903@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4210;7:EZMb4JRW85DplmRB5VkdyeNtRHH5Yb1Xjji9zCHie/v/iJm+a9bM0w/qUJtmdlXVvyIT6CwCGmEqAr77ShXleZaFDCerRE0qAREoLYJ6Q6YEzpqEznV9jp49wW0Y6lCUSoZi1rJBd4cV/eGMxwXYn1EuvGfps/dfa6Zi+6J6wPD9eUCSqufLwgbbBrSh5h6PgpNaLT4z9MMpo/jmIrQwDPueD5v+p5r1/XveskmOlXtkN48v4LOdev311PPpoQOS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4210;
x-ms-traffictypediagnostic: AM0PR04MB4210:
x-microsoft-antispam-prvs: <AM0PR04MB42101F663BCC506B2A3B3FA480690@AM0PR04MB4210.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4210;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4210;
x-forefront-prvs: 06833C6A67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(376002)(346002)(377424004)(199004)(189003)(13464003)(57704003)(8936002)(6246003)(478600001)(3846002)(6116002)(53936002)(2906002)(14454004)(6436002)(66066001)(53546011)(7696005)(68736007)(3280700002)(76176011)(229853002)(99286004)(102836004)(6506007)(9686003)(81166006)(81156014)(55016002)(8676002)(3660700001)(25786009)(4326008)(2501003)(7416002)(7736002)(305945005)(105586002)(106356001)(86362001)(5660300001)(5250100002)(74316002)(97736004)(476003)(26005)(2900100001)(486006)(110136005)(186003)(54906003)(316002)(33656002)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4210;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: aFaoILEFMpdgiaLikNqUC8hD5TfPSEYj8g289/O5YBqhBFHKuqI5K2wS9RQCKpCx4TQ3uI/g7TcntftaV+SZ8k8rXba7OflDzdsnx7dP/B6XsA7oeRq0CDiHaUikM5tAYFpdckUuqz0/pTxgK8GLD7swAgkOmfj/J5434Ry3v14fp0/jlSwetnaEm8B70mxJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 74113800-4675-4425-1834-08d5c224b702
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74113800-4675-4425-1834-08d5c224b702
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 09:48:48.6990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4P9n3Db010503

Hi Stephen,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Saturday, March 24, 2018 12:53 AM
> To: A.s. Dong <aisheng.dong@nxp.com>; linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; hdegoede@redhat.com;
> b.zolnierkie@samsung.com; linux@armlinux.org.uk; linux-
> fbdev@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; A.s. Dong
> <aisheng.dong@nxp.com>; Stephen Boyd <sboyd@codeaurora.org>; Russell
> King <linux@arm.linux.org.uk>
> Subject: Re: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
> 
> Quoting Dong Aisheng (2018-03-20 20:19:48)
> > diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c index
> > 4c10456..4b357b2 100644
> > --- a/drivers/clk/clk-bulk.c
> > +++ b/drivers/clk/clk-bulk.c
> > @@ -19,6 +19,38 @@
> >  #include <linux/clk.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> > +#include <linux/of.h>
> > +
> > +#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
> 
> Do we need these defines? of_clk_get() is a stub function when these
> configs are false.
> 

You're right. Will drop it.

> > +static int __must_check of_clk_bulk_get(struct device_node *np, int
> num_clks,
> > +                                       struct clk_bulk_data *clks) {
> > +       int ret;
> > +       int i;
> > +
> > +       for (i = 0; i < num_clks; i++)
> > +               clks[i].clk = NULL;
> > +
> > +       for (i = 0; i < num_clks; i++) {
> > +               clks[i].clk = of_clk_get(np, i);
> > +               if (IS_ERR(clks[i].clk)) {
> > +                       ret = PTR_ERR(clks[i].clk);
> > +                       pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
> > +                              np, i, ret);
> > +                       clks[i].clk = NULL;
> > +                       goto err;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +
> > +err:
> > +       clk_bulk_put(i, clks);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(of_clk_bulk_get);
> 
> It's static, so don't export it.

Got it.
Sorry for such mistake.

Will fix and sent V3.

Regards
Dong Aisheng
