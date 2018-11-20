Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DF720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="AirywnqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DF720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeKTVWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:22:14 -0500
Received: from mail-eopbgr1410129.outbound.protection.outlook.com ([40.107.141.129]:6174
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbeKTVWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRLec4/B40sLMkxPc8s5TslNmHflds30rdVMb7hLC7o=;
 b=AirywnqN7D3qaDQ1vei6BM9Z3DxmAqGZ/SpRT6ut1cKRjYSQi6HwWK5JY11GEfLsy7KEBwV8Ws43O2ZpsEP3Q+JJlJ4DyvjVrMnxcZ25Jj977cjuzQOyFOaiq4sg4H2dxHAQVgAtuTgtmKhGbO0yFy0y1t5qlBx1EMGxEP6FQSo=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1437.jpnprd01.prod.outlook.com (10.174.227.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 20 Nov 2018 10:53:34 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.047; Tue, 20 Nov 2018
 10:53:33 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@pku.edu.cn>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] clk: Add (devm_)clk_get_optional() functions
Thread-Topic: [PATCH] clk: Add (devm_)clk_get_optional() functions
Thread-Index: AQHUgBH/86BQSKkv2EWPF1EFJS36QaVYejqAgAADDdA=
Date:   Tue, 20 Nov 2018 10:53:33 +0000
Message-ID: <TY1PR01MB176982D5E11A665D0DCC9E31F5D90@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181119141259.11992-1-phil.edworthy@renesas.com>
 <20181120103832.GV10650@smile.fi.intel.com>
In-Reply-To: <20181120103832.GV10650@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1437;20:SoUSMmwiyhS1Amh3eIH8el9QIBFwQOezAYUHon6PLxZQFU3OJpstU8npJ7wv8ABziwMDWAr/YYAO2Kyl87Y4/dd/VfVa4AIRUOA77cKq2x8sruGvw0XWjyc3+75hEHOSFi+CJsWF6AzZL2muRAsMFu5uHWEW+KSSXyqUi+xejZk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b697d8d4-5d7f-4c1c-529b-08d64ed66ab7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1437;
x-ms-traffictypediagnostic: TY1PR01MB1437:
x-microsoft-antispam-prvs: <TY1PR01MB14377C1E3F33E2E9E4E8A743F5D90@TY1PR01MB1437.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231442)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1437;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1437;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(7736002)(8936002)(66066001)(54906003)(186003)(6116002)(3846002)(229853002)(8676002)(6916009)(44832011)(53936002)(7416002)(486006)(316002)(305945005)(55016002)(2900100001)(5660300001)(9686003)(81156014)(81166006)(6246003)(33656002)(14454004)(74316002)(71200400001)(71190400001)(105586002)(476003)(6436002)(106356001)(7696005)(25786009)(97736004)(256004)(4326008)(68736007)(26005)(86362001)(53546011)(11346002)(6506007)(478600001)(76176011)(99286004)(2906002)(102836004)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1437;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TzLrcW+tZnC9cK+FQvd40i0PpNrGjANEwpeFDLwQNwj9LtNQaWsDzKADifoWLTw2ApYvOzuJyFr44Sj2huWHG7Br75efKddGuGUPc84UTAy8PD9Krnx+fYBxlaLMQ/fNRGLimapzwUw6J4cgV1kR+XluKQSO+DQDrfELvQTNjOYZDClVl2xbBzrv0wjPM4kARzpvxfyL1UCct5dDLpv51EqTHYUdQJ/7Wf9OJsA7PIZlyprH0CrGzyjmZ/kCS0l96h5Yq+QUqtbqGHvjHV2CREZyvJG4HVB6R0b4SKk5dPGroJ17kcZHGe817VBWXWREj7z8c96DaZUwJc0T1rZCLK42ZWaSZDX7XDjGPay1MQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b697d8d4-5d7f-4c1c-529b-08d64ed66ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:53:33.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 20 November 2018 10:39 Andy Shevchenko wrote:
> On Mon, Nov 19, 2018 at 02:12:59PM +0000, Phil Edworthy wrote:
> > This adds clk_get_optional() and devm_clk_get_optional() functions to
> > get optional clocks.
> > They behave the same as (devm_)clk_get except where there is no clock
> > producer. In this case, instead of returning -ENOENT, the function
> > returns NULL. This makes error checking simpler and allows
> > clk_prepare_enable, etc to be called on the returned reference without
> > additional checks.
>=20
> >  - Instead of messing with the core functions, simply wrap them for the
> >    _optional() versions. By putting clk_get_optional() inline in the he=
ader
> >    file, we can get rid of the arch specific patches as well.
>=20
> Fine if it would have no surprises with error handling.
There shouldn't be any surprises. My earlier attempts at implementing this
were hampered by the fact that of_clk_get_by_name() can return -EINVAL
in some circumstances. By directly wrapping the (devm_)clk_get() functions
that problem goes away.

> > +	if (ERR_PTR(-ENOENT))
Huh? That wasn't the code I sent...

> > +		return NULL;
> > +	else
> > +		return clk;
>=20
> return clk =3D=3D ERR_PTR(-ENOENT) ? NULL : clk;
>=20
> ?
>=20
> > +	if (clk =3D=3D ERR_PTR(-ENOENT))
> > +		return NULL;
> > +	else
> > +		return clk;
>=20
> Ditto.
Sure, will fix both.

Thanks
Phil
