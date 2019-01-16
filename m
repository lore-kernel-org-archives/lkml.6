Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D94C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4F620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="nOl7yNlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbfAPPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:18:49 -0500
Received: from mail-eopbgr1400095.outbound.protection.outlook.com ([40.107.140.95]:31136
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731337AbfAPPSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA+sW76ngWkgHuRQ/PbGwznsOWkwRzFqMDxyjNIa9N0=;
 b=nOl7yNlP2zkWX7NDjyYmlh18oEzmRrhR6/HiXUzw5rAKOF1of2a+M9n+1K8OwIFYaRl/6iafq8MT6DqTwVcFO5gkdzSRNcdwWvukK6/s8xfKJc6N4YBO5KvAff6ZddZytd7Ddb72tM+TWAgotLwCX0Fw4mcl5HIFfXmrSt40yQg=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1563.jpnprd01.prod.outlook.com (52.133.162.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 16 Jan 2019 15:18:42 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::84f5:1420:6fb3:ea62]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::84f5:1420:6fb3:ea62%4]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:18:42 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Thread-Topic: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Thread-Index: AQHUivk3i4Y+f5/feUuqUWNTx+pZGqVtAtEAgASlWYCAQJ6ToA==
Date:   Wed, 16 Jan 2019 15:18:42 +0000
Message-ID: <TY1PR01MB17690EDAC0E4B637FF7A81DBF5820@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
 <20181203111309.3709-2-phil.edworthy@renesas.com>
 <20181203133040.GN10650@smile.fi.intel.com>
 <TY1PR01MB1769B12A216ED3E76A40A6B7F5A90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769B12A216ED3E76A40A6B7F5A90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1563;20:8ynzqdDimtoOX088lqVenoRUjZ1U9th2NtVpo/N4I+jkn4V0/7OUZ5YkLBzsryuw/WLEP9UABs3xeePPJ20fY2ylk5L3Yqi5X2ovR4SwRL7ctBDRwBG7dDU0S66qR5iBNpsoZqGvmhaDr5mlhUDn5HO2a2EaTXEscM5Q7Se95Xk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0187b540-9eb6-42cd-1a18-08d67bc5e6a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1563;
x-ms-traffictypediagnostic: TY1PR01MB1563:
x-microsoft-antispam-prvs: <TY1PR01MB1563CFC6C0C4BA53815B52F4F5820@TY1PR01MB1563.jpnprd01.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(13464003)(189003)(199004)(51914003)(53936002)(9686003)(55016002)(8676002)(476003)(2906002)(6306002)(6246003)(86362001)(66066001)(14454004)(6436002)(186003)(93886005)(53546011)(446003)(66574012)(305945005)(8936002)(6506007)(26005)(102836004)(7696005)(7736002)(76176011)(68736007)(11346002)(81156014)(81166006)(74316002)(5660300001)(110136005)(33656002)(6116002)(54906003)(71200400001)(44832011)(3846002)(316002)(106356001)(99286004)(4326008)(71190400001)(14444005)(25786009)(486006)(478600001)(97736004)(229853002)(105586002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1563;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WkvkZUSjBLjL4wr8bNm+lHttIu4rmtzg7LLZXd7W+55f+cvMoUZcqVfncDeOoWGJgca8pPCY6FkDN+VDfBNIUu5a0qoTWzcDv9C8p5fXQI/TvYA7EF8B7z/xMbcB18wmrosMre6kLdCkqpthDu6NHlVRDT+YmQUujDmS301RRkYnr+Iye0qIJmuegH2Tna//VsmU2teAE1UPFBYN/C7+hSCKFp4EzYj3MMlcocxDAcWVoPosdzEBTrsam3+92xDLt8AbMFy6yY849gmzoaqGlyuuHU2zpdnEhlAwWhxEtvDqceQIqj/e0JR9JxOQh/4SAFfsmcCmfZzWp/I7eN0bX7yWYAjWhpcYbGxAND6KKeI3BJZqTRAC6PDC495F8DCbAXA5CmCevQ1cumU4IP4EG53tZ4LzhwLUSLooVYU6VYg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0187b540-9eb6-42cd-1a18-08d67bc5e6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:18:42.5621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any other comments on this patch and patch 2/2 (https://lkml.org/lkml/2018/=
12/3/326)?

Thanks
Phil

> -----Original Message-----
> From: Phil Edworthy
> Sent: 06 December 2018 12:31
> To: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Russell King <linux@armlinux.org.uk>; Geert
> Uytterhoeven <geert@linux-m68k.org>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; linux-clk@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH v9 1/2] clk: Add comment about
> __of_clk_get_by_name() error values
>=20
> Hi Andy,
>=20
> On 03 December 2018 13:31 Andy Shevchenko wrote:
> > On Mon, Dec 03, 2018 at 11:13:08AM +0000, Phil Edworthy wrote:
> > > It's not immediately obvious from the code that failure to get a
> > > clock provider can return either -ENOENT or -EINVAL. Therefore, add
> > > a comment to highlight this.
> >
> > > +/*
> > > + * Beware the return values when np is valid, but no clock provider
> > > +is
> > found.
> > > + * If name =3D NULL, the function returns -ENOENT.
> > > + * If name !=3D NULL, the function returns -EINVAL. This is because
> > > +__of_clk_get()
> >
> > I would start new sentence from new line (this will emphasize the
> > possible
> > variants)
> >
> >  * This is ...
> I disagree, the explanation is specifically related to the case where the
> function returns -EINVAL. Though this is a nit, so I'm not really bothere=
d
> either way.
>=20
> Thanks for the review!
> Phil
>=20
> >  Otherwise looks good to me:
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > > + * is called even if of_property_match_string() returns an error.
> > > + */
> > >  static struct clk *__of_clk_get_by_name(struct device_node *np,
> > >  					const char *dev_id,
> > >  					const char *name)
> > > --
> > > 2.17.1
> > >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >

