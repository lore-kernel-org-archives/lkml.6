Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933386AbeEIB0o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:26:44 -0400
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:11072
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933134AbeEIB0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:26:42 -0400
From: Jacky Bai <ping.bai@nxp.com>
To: Stephen Boyd <sboyd@kernel.org>, Stefan Agner <stefan@agner.ch>
CC: Shawn Guo <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Thread-Topic: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
Thread-Index: AQHT4eiNBt8kJKQq8U6qTMNFXpuE4aQkQcSAgAE2FqCAAGLggIAAU4kAgAB2S1A=
Date: Wed, 9 May 2018 01:26:38 +0000
Message-ID: <HE1PR04MB3113135433766196E708685887990@HE1PR04MB3113.eurprd04.prod.outlook.com>
References: <20180418124908.3079-1-stefan@agner.ch>
 <20180502073807.GE3443@dragon> <56a409cf76a3eaa713cb4f0bbe1e39b6@agner.ch>
 <HE1PR04MB311395765D3DC03D5960DBA3879A0@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <4188ee25bd5179b57d09e4624dcfbfbb@agner.ch>
 <152580354289.138124.13657232356773397650@swboyd.mtv.corp.google.com>
In-Reply-To: <152580354289.138124.13657232356773397650@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB3291;7:QMJ3p4VqI1qQZk/mueOapgpCRWwDuYsx3LxU1Ebn1a9qx4KCv+ZL6CXtUHZoMcKcHdXiHuOM37tGG2Vcze4qXIu7dsSK4fj8qh3J5isW6H83H7oO8WjLglQrqNX00WOw48Klxg8Zq7GuiEk67L3Xzx4pFjphUIn3EUhyDz/LMLEKwoMchVJ75oWkVQV5yXspV1WzvPCF3tyRZEDAy7psTrvLj67OE4XGyb+M/A24qYTEcBq3yhwW6rkKRg/YK+Se
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3291;
x-ms-traffictypediagnostic: HE1PR04MB3291:
x-microsoft-antispam-prvs: <HE1PR04MB3291C22485DD1D6B7F7769F287990@HE1PR04MB3291.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR04MB3291;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3291;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(377424004)(52314003)(189003)(199004)(4326008)(2900100001)(3846002)(105586002)(5250100002)(486006)(106356001)(14454004)(25786009)(3280700002)(3660700001)(11346002)(6116002)(446003)(2906002)(9686003)(53936002)(6246003)(55016002)(476003)(68736007)(478600001)(93886005)(316002)(53546011)(54906003)(110136005)(86362001)(81156014)(74316002)(76176011)(7696005)(81166006)(8676002)(8936002)(186003)(66066001)(26005)(33656002)(229853002)(102836004)(6436002)(5660300001)(305945005)(7736002)(99286004)(97736004)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3291;H:HE1PR04MB3113.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: P/lsCOPOidVyQImmTN0eQ37t3dzsZ/50MbwXZ9ODbjt46PgqZrTX56uCXEbO83XD70M33hgRmF1Qd+0QH3pFDEbdSBgkcBd4bKCn76AD1pTubLw6KNITlOM2Xzq0wYRg8gyV4C0pKMwxq1lqAEZomNgeFtrU/FxfPGikxpbSTMghtr6esL0MYXz+OL8YJW1+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5c1d3444-bbc0-42f5-7161-08d5b54be94f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1d3444-bbc0-42f5-7161-08d5b54be94f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 01:26:38.2546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3291
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w491Qo06028112

> Subject: Re: [PATCH] clk: imx6ull: use OSC clock during AXI rate change
> 
> Quoting Stefan Agner (2018-05-08 06:20:03)
> > On 08.05.2018 09:32, Jacky Bai wrote:
> > >
> > > I have tried two 6ULL board, I don't meet such issue. System can
> > > boot up successfully with commit 6f9575e55632 included.
> > > Anyway, the change in this patch is ok for me. it is no harm to the
> > > BUS clock change flow.
> >
> > Hm, that is interesting, maybe it is because we use a different SKU?
> > Or maybe bootloader?
> >
> > I tested here with a 800 MHz clocked variant on a Colibri iMX6ULL
> > using U-Boot 2016.11.
> >
> 
> I'll throw this into fixes today because it fixes something to be useful. It's still
> interesting to see what's different between the two setups though.

Thanks. 

I will find some 800MHz parts and have a try with different bootloader later.
Will let you know, when I have some results.

Jacky
