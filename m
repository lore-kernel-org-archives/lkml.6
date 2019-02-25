Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F52C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40E62146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="BgLO5PD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBYNNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:13:05 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:26348 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbfBYNNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:13:04 -0500
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 66/3B-18573-CD9E37C5; Mon, 25 Feb 2019 13:13:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSWUwTURSGezsLI6F6LRgOFTRpxAWYSlGT+uA
  WY9LE/UEfFMUBBtrYBTslFOMCQVQgEuNOIwouaMCgVFERCFo1EdypESj6UCwCLqhATHgxdjpV
  8e0/5/vvWW4OQyjv0yqGd9h5m4Uzqelw0jCfWcS+GxJSk4vcc3QnfX5a19gSr/v55rBc57l3l
  l5O6usfxOubnO/D9K7aElo/6pqxgdxCGS3pVscOynCztSIsp49yDJaVEgWolyxF4QyJrxMw7j
  lKiYESl8vB4z1MSEEvAt/Qk0AwiaGxFs59+YZEEIWvI3hXNioXAYFXQG/r16COxKvhVPsILeo
  ovAY6Po6FdArcOvKWFDWJ4+FGRWOwqAJvA2efJ/hWiTVQ0OwO6kl4Pow8OohEjXAcjBXWEVKv
  aPD6zwc9gDFcanlJSHoaDH34RUn+NDjU9jVMyifB8y4/krQaarqdlKTjoPN8WSi/Foo9Q2HiY
  oC9CL5fHSclkADlRdWUBHoioO9xfwiYwF1/J9Q5FkYartGSqY2Cyz4XLa2TAd8rn4fGmAG1R3
  ykZHpFQP2BO7S0TxJUNY/QR9E854T1nBOQpBOhpvoz4Qx+2VRor/CTVYisRbp0mzHbYDdzRhO
  rTU5mtdoUVrt4EZuyQKfhdrOchs9l83jBzmo1XJ6gEfLNGaZMjYW3u1DgmjJzHg7fRZ1Xst0o
  hpGrpylK/UKqcnK6NTPfwAmGNFuuiRfcKJZh1KAYHgiwqTY+m3dkGU2Bk/yDgYlQRym8IlYIO
  ZxZMGZLqAOxzP0LvkpCSVqsFl4VrbgxGDBh0WTItfwt8eewO1GcKlKBZDKZMiKHt5mN9v/5Jx
  TNIHWkIkmsEmG02P92+hQYQh4YonzMKg5h5/4hVQGyk2caSqidpaqtU1JvHn/9qierO0Zf7T3
  Y0+t8kXQqrbGwaMmqmcv3T3d1xui6HL73Gx52ybIG6loXFr1tWded6IrN2DPs2P50c8MuPNa/
  sWz2XE3dzlnWi7erYBkrS1j5ksg15ZesMJw27z22lHI/eHZC9mN94ra0pk1t+x6Nz9tarCYFA
  6dNIGwC9xvsQFHX0wMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-25.tower-268.messagelabs.com!1551100380!1847839!1
X-Originating-IP: [104.47.8.53]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6889 invoked from network); 25 Feb 2019 13:13:00 -0000
Received: from mail-am5eur03lp2053.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.53)
  by server-25.tower-268.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 25 Feb 2019 13:13:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XQa0hHW70iD2k7WWwLA+7zyGGGF89NkT8incs1VAx4=;
 b=BgLO5PD0Os7atfa/tmqZS9hIvv0CGG+mr1zsvXZQnZhIfWJTKjwacWCnjpay8dm1Zq37cX1V7sybZPz4NEwnCAyPYbG25YDuU/OxYTViMJo/3Fw74Dg3AX4jr22OvML12XLPSOoAdQFWUeN0PFoCFhXkemPFU6y2Ee7e10Xd/Vo=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1887.EURPRD10.PROD.OUTLOOK.COM (52.134.26.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 13:12:58 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::11b1:dc26:b933:c0%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:12:58 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] regulator: da9063: Use struct_size() in devm_kzalloc()
Thread-Topic: [PATCH] regulator: da9063: Use struct_size() in devm_kzalloc()
Thread-Index: AQHUyg7m35/vT0XhCkOPcBP4LeU2aKXwg0aw
Date:   Mon, 25 Feb 2019 13:12:58 +0000
Message-ID: <VI1PR10MB23520F07E8CBE05C0483698EFE7A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190221175714.GA3104@embeddedor>
In-Reply-To: <20190221175714.GA3104@embeddedor>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba5abb7a-886c-4e95-5401-08d69b22f652
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1887;
x-ms-traffictypediagnostic: VI1PR10MB1887:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR10MB1887;23:R30JzzU5FMfrCwlRErjZT1k1F84AanjfFKjhmxXJh?=
 =?us-ascii?Q?25KRKQjoeUJ5m/Z/CC4B1T6XOL9nHEEW1io13PBbWi3Zhe1x7x3y5wVGmCQY?=
 =?us-ascii?Q?K7lcUfa/wG/qaG4RNy9ORiLjSogDcFotSHlccLgzyVfRRQDOyouuzVwHsiFG?=
 =?us-ascii?Q?btt8A9HO+DEhzgne/hVtkvvfARbDKzWRgwemif/8avE0S58Qqt1jxbTFI9eu?=
 =?us-ascii?Q?iZMi28kg9ye8REJqtsk0sfN/Uv/uxpwrGYV8m2FJIY5wWAdIbs31WI+SkeI9?=
 =?us-ascii?Q?loWbBYUS5KItrsw3SZnT/tuNnVkTEy7o3vMw5Elrp+Ed3HhIKTJaUyBZt5iV?=
 =?us-ascii?Q?cELYgMXBCEHJpvRMhNhkgnetAzWFj6MCn4I21BS/yOekdFMi8y8xyGs/gNLn?=
 =?us-ascii?Q?IutGI66tqGS+2f+24E5i1fe/IQ97OFeXwwVZmAA5QmJ+hpPvjqOBH4cX+bNc?=
 =?us-ascii?Q?yJaUL1bG4+JbXv49r8AnObMhBaDYBw/1piBB9I3Rkf7MwXEVzDqsTGaa2wbQ?=
 =?us-ascii?Q?N213Y1WgC18Sdd+rCEedOsqKrh4Akr/P7w6NzF68mV0U3/zKzJpD70I/ovc5?=
 =?us-ascii?Q?6/WJG/hzP1mKxtXovFW8lUZkWuXGbRL/OXvrbgCyBbYv6tKwbdysY+Lv+IQs?=
 =?us-ascii?Q?TRZgu24+Le6AC3nU6MfkJChTJL7hlPrY55P7Mu5Gk5GHnS/oaC6LJUmqJxje?=
 =?us-ascii?Q?QD8A93t+tl0qf9mVyS1kSmN0Oz0UwKSbLmJVJjKTpnf38RyLlX+Pveyd+/6g?=
 =?us-ascii?Q?U3scCiieQRt9KHH46yYZ/MFJYpXlFBbh1lTnekR8KnkxF6db4GQwPXcwLJC9?=
 =?us-ascii?Q?V7F2mOnxMXpNMtf+kbbkg1mVZrGVgnQffp+Q6NphuAGPFlsJ+QKCs+yWRM1o?=
 =?us-ascii?Q?KTj7659LY6+pDvdg8zn5UWViguczUcpdILNzQYbYsyIVDelLP/2/NKlRPI6Y?=
 =?us-ascii?Q?OnccagEHQYhpp5MLoP6nlfEw4e6ZIIkNnMMVT8cG0d4uOPHzskie6n3p2Ny3?=
 =?us-ascii?Q?krUasHB15wU/kMglyiLnkMH+UI2UZmnsWJIFXDYDVkmVM9FW+G30WO9bG56d?=
 =?us-ascii?Q?/PZjR/Y86klJ5UFC2Ch9jdg5m0HQQNRLIwTKlWmATvhD75icix8JCvlY8Xvo?=
 =?us-ascii?Q?e6DJBQpF8oE9BeLbRHZ+EiN3ps3DyiV/+L4t7VPIWAlOdzpgC1F8oT35a0fA?=
 =?us-ascii?Q?ML1Cu4PK/KlmpXEJqXgp5fd5UsEdUeUTKNs?=
x-microsoft-antispam-prvs: <VI1PR10MB18877AA5541F69D0F3C4D9A0F57A0@VI1PR10MB1887.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39850400004)(396003)(199004)(189003)(110136005)(33656002)(71200400001)(71190400001)(478600001)(2906002)(55016002)(102836004)(9686003)(8936002)(53546011)(97736004)(5660300002)(99286004)(6506007)(76176011)(53936002)(66066001)(7696005)(316002)(4744005)(86362001)(6436002)(68736007)(486006)(7736002)(186003)(305945005)(11346002)(229853002)(8676002)(81156014)(3846002)(6116002)(446003)(81166006)(4326008)(6246003)(256004)(25786009)(106356001)(74316002)(476003)(26005)(105586002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1887;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CWA6tZ0II8mEDT1+Cvx2/W5AwGG8SeIImee7USpsBj+AYU/YW2XIxLkHCRBmma+ikrBHKmcZejxQGSyCqaJmr86yqApRp+imA+UhyEuljWRZIofM/xLelHQY2EPMvIEuSOcn8cjC8+ns7EqEVfMAnYWj3jq3FQA27D/1Pixdx3baW4jEPmdFF/oGKCSeRzE5L2nc3mWZ8V22wUVsfXtLHvK57/H0EWABk/GXT0Mlvu9NlPec3s+WJiONfymbN5/y5kDuQyuCuGIT6+3FK3NyvTapi40gwWOWrwxK9bPfZYpkYpG3tuilLcZEJtilLCJkAz88y9ecoAJATE2EqP42oCIClGeTfKHrrGFyeWNPVi3nHhP84jwIbN5q6WKYwEFvm3iYIoN2DpBTm5/1Oarp8WaA+a5t7+HZHEcNxCoiaPs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5abb7a-886c-4e95-5401-08d69b22f652
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:12:58.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On 21 February 2019 17:57, Gustavo A. R. Silva wrote:=20

> Subject: [PATCH] regulator: da9063: Use struct_size() in devm_kzalloc()
>=20
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>=20
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>=20
> size =3D sizeof(struct foo) + count * sizeof(struct boo);
> instance =3D alloc(size, GFP_KERNEL)
>=20
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Thanks,

Regards,
Steve

