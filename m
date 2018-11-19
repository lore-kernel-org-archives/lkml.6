Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D789DC04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D90B20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="XPekjnFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D90B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeKTAFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:05:10 -0500
Received: from mail-eopbgr1400119.outbound.protection.outlook.com ([40.107.140.119]:17680
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbeKTAFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhcp/LLjTjfZnJyoUVldNU8/nMMQ9k4y2p84rAmsBI4=;
 b=XPekjnFp4nwFJX/YEVLZwiIDZx87lvwBFxw7k/HNQdyndI1kyZeWCIAAF+87esb+mVSH1c4MRItMv/s/M0dfi3cVLQaCyP4B0Cw6UbSdxBuOIBE7jNPmd4Yj6E6YPaDT2vLxpXzg2IxY+S4kvOntpJdy07Zh7Ifd3OxwWY2jmlw=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1439.jpnprd01.prod.outlook.com (10.174.228.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 19 Nov 2018 13:41:25 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.047; Mon, 19 Nov 2018
 13:41:25 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v6 1/6] clk: Add of_clk_get_by_name_optional() function
Thread-Topic: [PATCH v6 1/6] clk: Add of_clk_get_by_name_optional() function
Thread-Index: AQHUfb0RmyNdBSsmakSgPhksP0TsX6VSj8kAgAACxACABFCrgIAAC2+AgAAg3oCAAAQNgIAAC5BQ
Date:   Mon, 19 Nov 2018 13:41:24 +0000
Message-ID: <TY1PR01MB1769E377D88AF59EBD2A9C3BF5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-2-phil.edworthy@renesas.com>
 <20181116160128.pkuya6rwqm4schdn@pengutronix.de>
 <20181116161122.hhvslbzdujxpk3up@pengutronix.de>
 <TY1PR01MB17697C2C8BCE98009EBDECF7F5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20181119104603.qzuvpoha622l4xvy@pengutronix.de>
 <TY1PR01MB17695E8ED56BBC03AAA7FD8FF5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20181119125811.6bujcow5wf4hvfz4@pengutronix.de>
In-Reply-To: <20181119125811.6bujcow5wf4hvfz4@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1439;20:rBcqki5602tZIZFaA4jfuA6QZ4s+EjKGbG81oQEt13sQuI25UqbhB4ObshMlpiPzR0bzXUOEkLt8HoQUY+HQraOV54q2FR8T/bMbywueFffycLtV4Fct4wTygMEbaBtpSTZ0fHrCoxGzBok+mDu+5QzTbuUC1N9f4K5cFAw6mgw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4dc75dde-9fdf-4215-f2b9-08d64e24b31e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1439;
x-ms-traffictypediagnostic: TY1PR01MB1439:
x-microsoft-antispam-prvs: <TY1PR01MB1439BA903829230480B48E78F5D80@TY1PR01MB1439.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(4982022)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1439;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1439;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(6916009)(316002)(99286004)(71200400001)(2900100001)(81156014)(81166006)(186003)(8936002)(2906002)(93886005)(6116002)(3846002)(76176011)(26005)(68736007)(7696005)(7736002)(33656002)(53546011)(102836004)(71190400001)(54906003)(7416002)(6506007)(6436002)(8676002)(305945005)(229853002)(6246003)(74316002)(478600001)(44832011)(5660300001)(9686003)(486006)(53936002)(106356001)(6306002)(97736004)(105586002)(4326008)(966005)(14454004)(256004)(446003)(66066001)(55016002)(11346002)(86362001)(476003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1439;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UwkUHLCQqlKqTNzAps7sHLSgZvAIu9s90i333+jqicE6nffkLxO6+PLOpD2Mo4qi0q1GdmZqXcFcRobxHSig5qRsMVxsIDix3sdRhFArV3tdr8zkleQfBXSzSwVYf2Fcg284QfNzfgN6LLX6U9rPm+aOENatzFFyPOr1zP1uLpsmJ04HSQtnMXPQHm3chUGh+toSnwMD630TfUPaHPapg/q9SMkU/vfmMW9PwZHDkFWVFxxPxCYdxOvSTVJmouNwpEaONlZkZztD162WKe9EKHH12F2WSIuaPWhUhf3T2OFQhOmm1oH7ieVAHgdPD9vzRpPyYoSr9J9P9NdfGrWkwLl6HmcGWyROOT4sw2Q9+aA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc75dde-9fdf-4215-f2b9-08d64e24b31e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 13:41:24.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 19 November 2018 12:58 Uwe Kleine-K=F6nig wrote:
> On Mon, Nov 19, 2018 at 12:53:46PM +0000, Phil Edworthy wrote:
> > On 19 November 2018 10:46 Uwe Kleine-K=F6nig wrote:
> > > On Mon, Nov 19, 2018 at 10:41:42AM +0000, Phil Edworthy wrote:
> > > > btw, do we need to add of_clk_get_by_name_optional()? I only added
> it
> > > > as a counterpart to of_clk_get_by_name(), but it may not be needed.
> > >
> > > I don't need it. Given that it is easy to add when someone has a need=
, I'd
> say,
> > > skip it for now.
> >
> > I'm wondering if we actually need clk_get_optional(). For me at least, =
I just
> > want devm_clk_get_optional(). That would get rid of the arch patches.
>=20
> Given that clk_get_optional will be that simple, it can live in
> linux/clk.h for all implementors of the clk API, then you don't have to
> care about different archs. (Unless I'm missing something.)
You are absolutely right, I'm such a clutz sometimes!

Thanks
Phil

> I don't think it's a good idea to drop clk_get_optional even if you'd
> have to provide arch-specific stuff.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
