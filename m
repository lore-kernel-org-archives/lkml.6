Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeFCBgY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 21:36:24 -0400
Received: from mail-he1eur01on0059.outbound.protection.outlook.com ([104.47.0.59]:40212
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750871AbeFCBgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 21:36:21 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
Thread-Topic: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
Thread-Index: AQHT8X0hKe8UP9s1NUmhGGfUU647+KQ7rP2AgBDjVICAAUIvIA==
Date: Sun, 3 Jun 2018 01:36:13 +0000
Message-ID: <AM3PR04MB1315BD8947467077B61BB2E6F5600@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
 <1439344955.9677.1526991935718@email.1und1.de>
 <152792036327.225090.14543251343485084840@swboyd.mtv.corp.google.com>
In-Reply-To: <152792036327.225090.14543251343485084840@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0629;7:jKA9r0Cs1ttpp10eeOBWOmABF1imdFV51G5S/YyFvW8mSAA3aUez5SwrvSTQh+bLjCe3ahBcIMHLGGQ1S5luz8jtNep08Q1ZrgBZAAWwIHJgLISUaLY+mGASpliTxy8N951/EbFkVSl+cq0aRbjuuo/Phcd7ISXXr1UZ+FTRS0sollAfFPEgs8yNLlDGwAY3XxZ52CbkWLLnzN9cifK95v/ZFNcH5CWzOSb7jPGKppqTdak/17JjrtYai98F9Kgh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0629;
x-ms-traffictypediagnostic: AM3PR04MB0629:
x-microsoft-antispam-prvs: <AM3PR04MB062916B3E83AE772E32D65D3F5600@AM3PR04MB0629.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB0629;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0629;
x-forefront-prvs: 069255B8B8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(39860400002)(376002)(366004)(13464003)(189003)(199004)(53936002)(3280700002)(2906002)(9686003)(33656002)(110136005)(54906003)(316002)(66066001)(106356001)(105586002)(2900100001)(2501003)(102836004)(8936002)(26005)(6506007)(53546011)(186003)(8676002)(5250100002)(68736007)(6436002)(97736004)(99286004)(76176011)(7696005)(44832011)(486006)(476003)(74316002)(305945005)(446003)(81166006)(81156014)(55016002)(5660300001)(7416002)(7736002)(4326008)(3660700001)(6246003)(14454004)(11346002)(6116002)(3846002)(2201001)(478600001)(229853002)(86362001)(25786009)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0629;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: q3ul1IfngoAlRyFnVf+GPZ6vqiig2GUuOe4HzkueyZPn8/dPowPiNtwzJ7JQMseLD5TA5p+GmOzeHyilOTj9Rs7IKhysEHKg9ScSqvS8NYacO3Y+rf/pfdwaqf8WJIpUQ+oTyOQ/YC7k9CavTlVgsSLzCdxZiUi1cZ2kBVQdUfxT6S+u1tJWLHLVjeMr0ByZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5a42ee21-c761-4897-14a1-08d5c8f264a7
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a42ee21-c761-4897-14a1-08d5c8f264a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2018 01:36:13.8167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0629
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w531adZq009411

Hi, Stephen

Anson Huang
Best Regards!


> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd@kernel.org]
> Sent: Saturday, June 2, 2018 2:19 PM
> To: Anson Huang <anson.huang@nxp.com>; Stefan Wahren
> <stefan.wahren@i2se.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> kernel@pengutronix.de; mark.rutland@arm.com; matteo.lisi@engicam.com;
> michael@amarulasolutions.com; mturquette@baylibre.com;
> robh+dt@kernel.org; shawnguo@kernel.org
> Cc: linux-clk@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
> 
> Quoting Stefan Wahren (2018-05-22 05:25:35)
> > > +++ b/include/dt-bindings/clock/imx6ul-clock.h
> > > @@ -242,20 +242,25 @@
> > >  #define IMX6UL_CLK_CKO2_PODF         229
> > >  #define IMX6UL_CLK_CKO2                      230
> > >  #define IMX6UL_CLK_CKO                       231
> > > +#define IMX6UL_CLK_GPIO1             232
> > > +#define IMX6UL_CLK_GPIO2             233
> > > +#define IMX6UL_CLK_GPIO3             234
> > > +#define IMX6UL_CLK_GPIO4             235
> > > +#define IMX6UL_CLK_GPIO5             236
> >
> > this change looks like a breakage of devicetree ABI. You are changing the
> mean of the existing clock IDs on i.MX6ULL, which probably regress the
> combination of older DTBs with newer kernel.
> >
> 
> Agreed. Why can't we just tack on more numbers at the end?
 
Ah, yes, I saw 6ULL are at the end of 6UL, so added them in 6UL, but did NOT consider the old dtb support.

Will send out a V2 patch to fix it, and I saw Fabio also sent a patch to fix the clko1/2 definition, I will do the
V2 patch based on his patch.

Anson.

> 
> > >
> > >  /* For i.MX6ULL */
> > > -#define IMX6ULL_CLK_ESAI_PRED                232
