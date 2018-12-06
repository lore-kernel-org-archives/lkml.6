Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68320C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E09920838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mutwC5rZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E09920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeLFMa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:30:59 -0500
Received: from mail-eopbgr1400090.outbound.protection.outlook.com ([40.107.140.90]:33216
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727996AbeLFMa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCeQ1DMNjeaKJnC+fsKDsP194IybAkkg/awb6d+lxK0=;
 b=mutwC5rZN5qknUG1g0OOZBAKZx3u6uQujJYQezpcqYYar30Vsxf+5TRhtSehGquqYenmtDZlOeJETll+EB7js2S8ITXFt4GUoo9jQK9u2wayvdM9kG0K7gZdERbJfsNi2/eMbN5MUH5mLlaWAXVY4ldZp3+Nm0sqOmkaynxVI0s=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1561.jpnprd01.prod.outlook.com (52.133.162.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 12:30:53 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::9dd3:2789:8699:7885]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::9dd3:2789:8699:7885%4]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 12:30:52 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Thread-Topic: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name()
 error values
Thread-Index: AQHUivk3i4Y+f5/feUuqUWNTx+pZGqVtAtEAgASlWYA=
Date:   Thu, 6 Dec 2018 12:30:52 +0000
Message-ID: <TY1PR01MB1769B12A216ED3E76A40A6B7F5A90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
 <20181203111309.3709-2-phil.edworthy@renesas.com>
 <20181203133040.GN10650@smile.fi.intel.com>
In-Reply-To: <20181203133040.GN10650@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1561;20:xB/9pCi7ydiHEkR9cfr1q1Hszy7CoWdXxjN0Yltn7rdRWD8g1NkxGGxOkImaqGCG2ftGwQRQy3W3Ue5FK+yoxsT1YPVoXqLwPGJJW5KoANQVZaCpo7DoyHu+Sc4LzhibM+V1p6k/v5G3rB3ExPFNYs+SmYwZdu4vPDHRdp73o/M=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fcaf1fb9-b9ce-4dc4-6a7e-08d65b76a9a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1561;
x-ms-traffictypediagnostic: TY1PR01MB1561:
x-microsoft-antispam-prvs: <TY1PR01MB1561CC62211FAD8A861F1BF5F5A90@TY1PR01MB1561.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1561;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1561;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(51914003)(478600001)(229853002)(74316002)(102836004)(6506007)(53546011)(76176011)(71190400001)(71200400001)(81166006)(81156014)(53936002)(55016002)(105586002)(14444005)(256004)(106356001)(9686003)(2906002)(8676002)(186003)(97736004)(6916009)(33656002)(6116002)(3846002)(54906003)(316002)(7736002)(305945005)(14454004)(446003)(26005)(476003)(11346002)(44832011)(25786009)(6436002)(5660300001)(86362001)(68736007)(486006)(8936002)(66066001)(6246003)(7696005)(4326008)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1561;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /zGu961oHRsGeLLGQQa1VH1XV9LgAkEoF3zPvF6y77iEUsdka5h9YtO59eKi++h2lLkVFOz6O42n2EKh7gFPc23OvHWXaJfJpsRRFNf2ft3Rci8htR5lxe4GJFxg4o22mzt+7i5Svb26Xnvg7OtyT08y5oaYfp9FwO8CCjFD21Q0F7HALRViJ2CRmVw7P024I/iNXqjqOKYG0IjEYiqWl6D9QaDosDeDQVS+Mcc/jJofv7qos0/NRO08CBYtF1A0SE3MJtgyMBkvpE09xQT3qu1MkOzIcTgkm1RrWyxoOsGXrXwNk2YgmSNfS/iVPx16onpNISpJaDg4mqQw7bIH0DR/695HbMqVYwvjVakbDiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaf1fb9-b9ce-4dc4-6a7e-08d65b76a9a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 12:30:52.8047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1561
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 03 December 2018 13:31 Andy Shevchenko wrote:
> On Mon, Dec 03, 2018 at 11:13:08AM +0000, Phil Edworthy wrote:
> > It's not immediately obvious from the code that failure to get a clock
> > provider can return either -ENOENT or -EINVAL. Therefore, add a
> > comment to highlight this.
>=20
> > +/*
> > + * Beware the return values when np is valid, but no clock provider is
> found.
> > + * If name =3D NULL, the function returns -ENOENT.
> > + * If name !=3D NULL, the function returns -EINVAL. This is because
> > +__of_clk_get()
>=20
> I would start new sentence from new line (this will emphasize the possibl=
e
> variants)
>=20
>  * This is ...
I disagree, the explanation is specifically related to the case where the f=
unction
returns -EINVAL. Though this is a nit, so I'm not really bothered either wa=
y.

Thanks for the review!
Phil

>  Otherwise looks good to me:
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> > + * is called even if of_property_match_string() returns an error.
> > + */
> >  static struct clk *__of_clk_get_by_name(struct device_node *np,
> >  					const char *dev_id,
> >  					const char *name)
> > --
> > 2.17.1
> >
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

