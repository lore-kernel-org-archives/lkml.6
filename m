Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeC1Gc0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:32:26 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:4416
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750703AbeC1GcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:32:24 -0400
From: Abel Vesa <abel.vesa@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peter Chen <peter.chen@freescale.com>,
        Irina Tirdea <irina.tirdea@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "b29396@freescale.com" <b29396@freescale.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: imx7d: Move clks_init_on before any clock operations
Thread-Topic: [PATCH] clk: imx7d: Move clks_init_on before any clock
 operations
Thread-Index: AQHTxdc1YpQzA8igDUOrK2F+FU3FY6PkL0qAgAECD4A=
Date: Wed, 28 Mar 2018 06:32:18 +0000
Message-ID: <20180328063217.nztxaphgo3uojop5@fsr-ub1664-175>
References: <1522160607-7104-1-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5C23Va4Frrpqgw8LxEJbfj+cE6xeS3362QzyRn=_wi7JQ@mail.gmail.com>
In-Reply-To: <CAOMZO5C23Va4Frrpqgw8LxEJbfj+cE6xeS3362QzyRn=_wi7JQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1085;7:6NoGgBefJMf3F2IbSzcf1DeIgc+gP0MSmjwErqApNOzMepGTP9S7Der54fCkNrksCZTY1rHBcmxa58zvMtxxwkfsYFCw9lQYVQ2KcD7/QcB0c1JNObjhTsnfi0WxO6H5m37o9N2Rn4qcbXCqyuk9rvld7d3aBp3lsu5pO5BupEE3OuT8AU+Sr79vpr4kO16ea5y6lFTuG5+ETc73glaWEDwlogde2O70cH9KWle78/60pqrqf0bZn2/XGXMAHWcZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0b1ef24-2703-496c-8df8-08d59475a766
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1085;
x-ms-traffictypediagnostic: VI1PR04MB1085:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB1085A7CF9943D89B0CD8A887F6A30@VI1PR04MB1085.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(101931422205132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR04MB1085;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1085;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(39860400002)(376002)(396003)(346002)(39380400002)(199004)(189003)(53546011)(106356001)(1411001)(76176011)(7736002)(97736004)(2906002)(99286004)(446003)(4326008)(105586002)(305945005)(33896004)(53936002)(5660300001)(54906003)(5250100002)(486005)(486005)(6246003)(14454004)(316002)(6436002)(2900100001)(1076002)(6506007)(39060400002)(3846002)(186003)(81166006)(81156014)(6116002)(102836004)(229853002)(66066001)(3660700001)(9686003)(8936002)(3280700002)(33716001)(59450400001)(478600001)(6486002)(25786009)(8676002)(6916009)(11346002)(26005)(476003)(68736007)(6512007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1085;H:VI1PR04MB2144.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Uey7/sbLX+wLuJPRBSsRCyCnTyLIyFks24OXw+lYJFidWsEX//LhkdV6rt1UyadbPNaOfkIN5FC5y2I6A9mqI1XjNKkYw5IkY1lmCtLcWiYtgavw1aL70AXHKOOZM3nw5sYUHPoaXhN3myXqQW8u5Z4nR3rvDI68IysBGX1iKfQ27KHpmFo80PGi1z6ev9xVRoKiOTZsryIe+rlDWtecCzPGwbHAIHV1KbM5B51OShUCI6toKupnhub+eNl1GFEsaDHE+AwSsZNiqqQFbS+1yOZNVrc6Mp/U7N2iTHt55uwH0VjRrrhsGxjL8+dVXwlMEEWDEIoeMEPHg0KGkQq9BQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EB36A3017568A41BC97264C7EDA58AD@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b1ef24-2703-496c-8df8-08d59475a766
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 06:32:18.1362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2S6WVK7010811

Hi Fabio,

On Tue, Mar 27, 2018 at 12:08:39PM -0300, Fabio Estevam wrote:
> Hi Abel,
> 
> On Tue, Mar 27, 2018 at 11:23 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> > From: Dong Aisheng <b29396@freescale.com>
> >
> > For init on clocks we should move it at the first place in imx7d_clocks_init()
> > before any clock operations, else the clock operation may fail in case the clock
> > is still not on.
> >
> > Acked-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> 
> Thanks for your patches.
> 
> You sent 4 patches today touching the same file.
> 
> Please annotate the sequence of the patches (1/4, 2/4, etc) so that
> the maintainer can clearly know the order the patches should be
> applied.

Yep, my bad. I'll resend as a patchset now.
-- 
