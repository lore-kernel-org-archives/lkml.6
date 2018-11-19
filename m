Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EFC04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B8520831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="kgMywGZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B8520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeKSVFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:05:00 -0500
Received: from mail-eopbgr1400138.outbound.protection.outlook.com ([40.107.140.138]:18541
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbeKSVFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLJb9RtJVZ5MvIHVxHnqyZ5oMUJVHmLmd79znqnMYF4=;
 b=kgMywGZHopF3AUtrVjPDHIfPdVS7AG152S1d+T6tqPlLoqOeI4rT3Q3ZSo5qSzxb803koUgmct/R0ABIsT2KiHIiSqS82lktLIpWhv67mxMzOQGcfbT/0nS227SBQVNfjqjESzx/XvjOu71DPzZDuQKZtgt7TXPBW+NG5pKyego=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1609.jpnprd01.prod.outlook.com (52.133.162.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 19 Nov 2018 10:41:42 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.047; Mon, 19 Nov 2018
 10:41:42 +0000
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
Thread-Index: AQHUfb0RmyNdBSsmakSgPhksP0TsX6VSj8kAgAACxACABFCrgA==
Date:   Mon, 19 Nov 2018 10:41:42 +0000
Message-ID: <TY1PR01MB17697C2C8BCE98009EBDECF7F5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-2-phil.edworthy@renesas.com>
 <20181116160128.pkuya6rwqm4schdn@pengutronix.de>
 <20181116161122.hhvslbzdujxpk3up@pengutronix.de>
In-Reply-To: <20181116161122.hhvslbzdujxpk3up@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1609;20:4tI2DQIwCkwfdNJ8fCeGUDvETSNBGh7G3zCcpA1y6fOU7QhB06bIL7zGBwsTd7wbH+1U8urzlFgc0gO5olUhIbyH3LvfHytXPl4YpnJDlfKCjs5aDagQ3zmw3KjFscrLIy8/B/ThIW7kCGDwfXQJfzDbtOioeFZRS2LkoY8fbec=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 83c41aa9-0117-43d5-731e-08d64e0b9850
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1609;
x-ms-traffictypediagnostic: TY1PR01MB1609:
x-microsoft-antispam-prvs: <TY1PR01MB16099D6978280DB89D638691F5D80@TY1PR01MB1609.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1609;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1609;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(9686003)(66574009)(93886005)(26005)(14454004)(256004)(316002)(186003)(54906003)(5660300001)(6506007)(53546011)(102836004)(44832011)(6916009)(6436002)(99286004)(55016002)(7696005)(76176011)(476003)(11346002)(446003)(97736004)(486006)(33656002)(2906002)(105586002)(229853002)(106356001)(4326008)(74316002)(6246003)(71190400001)(2900100001)(86362001)(53936002)(71200400001)(8676002)(66066001)(81166006)(3846002)(6116002)(81156014)(7416002)(7736002)(25786009)(478600001)(8936002)(68736007)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1609;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NbqMkc2hStpOWxgG8Wk+UcFffWR0zU0OHwZnFdhxxPcEsw2QEmx0NuMgjY9vLS5NFGMGUhrTa2WlvawhRwzDVQnQ9q/KA/vHBBiJZyz9ph6FTnqFA35Dc7UHVaV83MDV5TZLcQbqmCxutyUtdWm3CiiDmKDqhiqUlc4C2ZGyIw7C3WfqVOJWyHstq2UcE6T51/WwXu0H6Q2uguW0yH+deGTktO9WTgxyTtPftiiuZ8S97Xu8/hl3Bn4+dIz3ST5LSETVokt9kRd4/MHbkG40h5pRPCqjeH3A6kjGK0Y+xreAdNWj1vJUH+VWAPkeUlTYNYPv22yW7OoN/PC382fKDTfXeEa8kVS9F8AYktVs0k4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c41aa9-0117-43d5-731e-08d64e0b9850
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 10:41:42.4858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 16 November 2018 16:11 Uwe Kleine-K=F6nig wrote:
> On Fri, Nov 16, 2018 at 05:01:28PM +0100, Uwe Kleine-K=F6nig wrote:
> > Other than that I think the patch is fine
>=20
> Thinking again, I wonder why not just do:
>=20
> static inline struct clk *clk_get_optional(struct device *dev, const char=
 *id) {
> 	struct clk *c =3D clk_get(dev, id);
>=20
> 	if (c =3D=3D ERR_PTR(-ENOENT))
> 		return NULL;
> 	else
> 		return c;
> }

Unfortunately, underneath this __of_clk_get_by_name() returns -EINVAL
when looking for a named clock, and the "clock-names" OF property can't
be found or the name is not in that prop. This is because the index
returned by of_property_match_string() will be an error code and is then
currently always passed to __of_clk_get().

If, as you said, I split the patches into one that fixes the error code, an=
d then
adds clk_get_optional() like above, it will make more sense.

btw, do we need to add of_clk_get_by_name_optional()? I only added it as a
counterpart to of_clk_get_by_name(), but it may not be needed.

Thanks
Phil
