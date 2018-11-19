Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC4C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33B120823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Th6UM8aQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33B120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeKSXR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:17:26 -0500
Received: from mail-eopbgr1410125.outbound.protection.outlook.com ([40.107.141.125]:51026
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728818AbeKSXRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+1FuBRi9T2O9zE0EwqlmKmM+ntcWYy+GVIU8NMAL/M=;
 b=Th6UM8aQ4X6V+NY9ShmuXXoWNlMiyttrWIDHZu1KLlOZtTEuCIYBzzPht1DLE4yQ73jJNr64l5EDRf7K/hsiesei0iIcUgycX3m+kAtpO3WA8VDHyjzmyiPoKrkxZTzcPlEOnAuGgTO3RFev8pG7BsLBmkT1OaRWqPTGttMzFwo=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1851.jpnprd01.prod.outlook.com (52.133.161.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Mon, 19 Nov 2018 12:53:46 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.047; Mon, 19 Nov 2018
 12:53:46 +0000
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
Thread-Index: AQHUfb0RmyNdBSsmakSgPhksP0TsX6VSj8kAgAACxACABFCrgIAAC2+AgAAg3oA=
Date:   Mon, 19 Nov 2018 12:53:46 +0000
Message-ID: <TY1PR01MB17695E8ED56BBC03AAA7FD8FF5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-2-phil.edworthy@renesas.com>
 <20181116160128.pkuya6rwqm4schdn@pengutronix.de>
 <20181116161122.hhvslbzdujxpk3up@pengutronix.de>
 <TY1PR01MB17697C2C8BCE98009EBDECF7F5D80@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20181119104603.qzuvpoha622l4xvy@pengutronix.de>
In-Reply-To: <20181119104603.qzuvpoha622l4xvy@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1851;20:FqwtjNb2N96LCTMxtLZ/xGkMiLscsDG60qchtah9LsC9zHcSn4eJT8Z2y61m7/u9Uw9BH5VhUhOFpQcqzuME/IxfHlSsfHsyfkRaQNvWbvrTpKJwZMNczOQxsTsxVoOOKR2zJqYvj0LpUNKxtN7bQpjzIqkIeQbpo1Lkfv+RBIE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 15a99a6e-129e-4b30-057e-08d64e1e0b71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1851;
x-ms-traffictypediagnostic: TY1PR01MB1851:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-microsoft-antispam-prvs: <TY1PR01MB1851F32262ACCA34659FCC53F5D80@TY1PR01MB1851.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231431)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1851;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1851;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(99286004)(2906002)(93886005)(14454004)(71190400001)(71200400001)(478600001)(102836004)(26005)(3846002)(76176011)(186003)(53546011)(6506007)(25786009)(66066001)(7696005)(6116002)(44832011)(11346002)(476003)(256004)(446003)(486006)(66574009)(105586002)(106356001)(7416002)(2900100001)(5660300001)(74316002)(305945005)(7736002)(6916009)(6436002)(316002)(229853002)(97736004)(81166006)(33656002)(55016002)(4326008)(54906003)(9686003)(8936002)(6246003)(81156014)(8676002)(68736007)(53936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1851;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ul8OzcDuZ8zUNB1znB4WbYbS+eAYergh303Xj+ksPFF+fD9VUR3ZohLWvaLVpb3VFaoLM4Ui1ot+fIB7jD7J1oyg1qq5/Gvjdm3o5r3fEdI4BI7Ja56m/EGrMLWyzEvgRwIBIMMHFKp6vQbb9o3YB/f7l9tLr8UvSB9C6Illb6wyeLuag9EFI6aMtBu+dNd6P01hePkAGMTihDVVz8A0EjWzNVnIMI+IZNmxs1JWaNgoRb60OXTFnvPqDP1RMu3xof1OrLW7oUlL+rHqafImFlSRd0sF/32XboSZPv9lXA2FdB0kcBxI1ue9xhdQzUDBg9YxrZYTMnau673kxr3EGi90V4SFBFvj+C9YVXsllNQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a99a6e-129e-4b30-057e-08d64e1e0b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 12:53:46.5534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 19 November 2018 10:46 Uwe Kleine-K=F6nig wrote:
> On Mon, Nov 19, 2018 at 10:41:42AM +0000, Phil Edworthy wrote:
> > On 16 November 2018 16:11 Uwe Kleine-K=F6nig wrote:
> > > On Fri, Nov 16, 2018 at 05:01:28PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > Other than that I think the patch is fine
> > >
> > > Thinking again, I wonder why not just do:
> > >
> > > static inline struct clk *clk_get_optional(struct device *dev, const =
char
> *id) {
> > > 	struct clk *c =3D clk_get(dev, id);
> > >
> > > 	if (c =3D=3D ERR_PTR(-ENOENT))
> > > 		return NULL;
> > > 	else
> > > 		return c;
> > > }
> >
> > Unfortunately, underneath this __of_clk_get_by_name() returns -EINVAL
> > when looking for a named clock, and the "clock-names" OF property
> > can't be found or the name is not in that prop. This is because the
> > index returned by of_property_match_string() will be an error code and
> > is then currently always passed to __of_clk_get().
> >
> > If, as you said, I split the patches into one that fixes the error
> > code, and then adds clk_get_optional() like above, it will make more se=
nse.
>=20
> Sounds like a good plan.
Now that I have removed of_clk_get_by_name_optional(), I see that clk_get()
deals with __of_clk_get_by_name() returning -EINVAL and -ENOENT the same
way. In both cases, clk_get_sys() will return -ENOENT... i.e. I no longer n=
eed to
modify __of_clk_get_by_name().
All I need is a simple wrapper just as you have outlined above.

> > btw, do we need to add of_clk_get_by_name_optional()? I only added it
> > as a counterpart to of_clk_get_by_name(), but it may not be needed.
>=20
> I don't need it. Given that it is easy to add when someone has a need, I'=
d say,
> skip it for now.
I'm wondering if we actually need clk_get_optional(). For me at least, I ju=
st
want devm_clk_get_optional(). That would get rid of the arch patches.

Thanks
Phil
