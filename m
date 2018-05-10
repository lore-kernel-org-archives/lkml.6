Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756346AbeEJBxR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:53:17 -0400
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:6400
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756003AbeEJBxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:53:16 -0400
From: Jacky Bai <ping.bai@nxp.com>
To: Stefan Agner <stefan@agner.ch>
CC: Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Thread-Topic: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Thread-Index: AQHT4eiNBt8kJKQq8U6qTMNFXpuE4aQkQcSAgAE2FqCAAGLggIAAU4kAgAB2S1CAANdLgIAAwsUQ
Date: Thu, 10 May 2018 01:53:10 +0000
Message-ID: <HE1PR04MB311361C15FDC2EAE3AA1FE3587980@HE1PR04MB3113.eurprd04.prod.outlook.com>
References: <20180418124908.3079-1-stefan@agner.ch>
 <20180502073807.GE3443@dragon> <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
 <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
 <152580354289.138124.13657232356773397650@swboyd.mtv.corp.google.com>
 <HE1PR04MB3113135433766196E708685887990@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <ae5b239a57bd7e3f3e62cc23a1c3788e@agner.ch>
In-Reply-To: <ae5b239a57bd7e3f3e62cc23a1c3788e@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB0860;7:mQlFB9YDVTUto/soJLC4ImvgzYdPaZu95JxAcqsQAP2eIqvE60yqlV3NKbA8qJUNNODDxl8OLgo1sjgSixS1VbbF3oyekCzcUosyA3Yr/RgfBIf/muA+O+1QP1PMpU/WrfCpkgFLtDP46luqryuvbeIm+BMR3waLqoTWgIM7nHR6wGmhkST/FSHN/f/zHcacna4NIz16dKbJfvnFcZlhjKBdPekrnA2L/qLklhxsOan3uPL+kqUJv0uuMzIdPDnE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB0860;
x-ms-traffictypediagnostic: HE1PR04MB0860:
x-microsoft-antispam-prvs: <HE1PR04MB0860F81DB276231CEF792CC987980@HE1PR04MB0860.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB0860;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB0860;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(346002)(376002)(396003)(52314003)(189003)(199004)(377424004)(2900100001)(229853002)(2906002)(5250100002)(3846002)(6116002)(3660700001)(81166006)(68736007)(305945005)(81156014)(7736002)(66066001)(8676002)(86362001)(3280700002)(6916009)(5660300001)(6436002)(14454004)(74316002)(99286004)(33656002)(25786009)(26005)(186003)(4326008)(486006)(11346002)(6246003)(478600001)(446003)(476003)(93886005)(54906003)(102836004)(316002)(53546011)(6506007)(55016002)(9686003)(7696005)(105586002)(53936002)(97736004)(8936002)(106356001)(76176011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB0860;H:HE1PR04MB3113.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mOkKoIRxdNLgxa1K/UAW3yhLl1qvc0zwMDQQPFvmVD6c5q0vZny2uq2w5XtV9m2ux4LZgfwGOuBZOl97yWnOwJvlTfNFZqhfDA4w+Mp0Um6t9tE4zi4kwck4Au5PJK4lQiS4JsGXPSjXNixmrGO1nyHA55RpZIJP3qIU6U1tJoMgIoRFIV84CU5YQfoig5Xz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1d48ea53-1c9a-431b-6e61-08d5b618c917
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d48ea53-1c9a-431b-6e61-08d5b618c917
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 01:53:11.0300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB0860
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4A1rPRD024247

> Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
> 
> On 09.05.2018 03:26, Jacky Bai wrote:
> >> Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate
> >> change
> >>
> >> Quoting Stefan Agner (2018-05-08 06:20:03)
> >> > On 08.05.2018 09:32, Jacky Bai wrote:
> >> > >
> >> > > I have tried two 6ULL board, I don't meet such issue. System can
> >> > > boot up successfully with commit 6f9575e55632 included.
> >> > > Anyway, the change in this patch is ok for me. it is no harm to
> >> > > the BUS clock change flow.
> >> >
> >> > Hm, that is interesting, maybe it is because we use a different SKU?
> >> > Or maybe bootloader?
> >> >
> >> > I tested here with a 800 MHz clocked variant on a Colibri iMX6ULL
> >> > using U-Boot 2016.11.
> >> >
> >>
> >> I'll throw this into fixes today because it fixes something to be
> >> useful. It's still interesting to see what's different between the two setups
> though.
> >
> > Thanks.
> >
> > I will find some 800MHz parts and have a try with different bootloader later.
> > Will let you know, when I have some results.
> >
> 
> FWIW, I tried two SKUs here:
> MCIMX6Z2DVM05AA (528Mhz)
> MCIMX6Z2CVM08AA (800MHz)
> 

 MCIMX6Z or  MCIMX6Y ? I think i.MX6ULL should be 6Y.

Jacky

> Both run at 396MHz in U-Boot, and both freeze and the same location.
> 
> --
> Stefan
