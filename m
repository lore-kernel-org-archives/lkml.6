Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB25AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9160D208B4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K23Jaove"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9160D208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGDP7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:59:08 -0400
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:51664
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752173AbeGDP7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVfBQxytU3exEQx8Bh4YRRtx7EcYQS7ra4ChCSBHrJo=;
 b=K23Jaove3Pkenbjv/y+iJqtrMQ6vArsthmuZEe3VjmMlMwgEI1Gvl7qkrUjthzXeyzDP2uTopI5sX2WHR4Bnr3zpu6wbtUh5okzUQW7TF/H/N4Ct7/m06tGJ2HmkZWFkmK/iUCeBrRwlaYvPBcuAC2kkVHG61/tTqlc8tmdkHWQ=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2735.eurprd04.prod.outlook.com (10.175.22.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Wed, 4 Jul 2018 15:59:01 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::197e:c4f9:bb4d:e560]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::197e:c4f9:bb4d:e560%2]) with mapi id 15.20.0906.026; Wed, 4 Jul 2018
 15:59:01 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Thread-Topic: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
Thread-Index: AQHUEuLqSqhBIlwZxE2gYLHNo772yQ==
Date:   Wed, 4 Jul 2018 15:59:01 +0000
Message-ID: <VI1PR0402MB3485AB652FBD61CE27965D3798410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20180622194752.11221-1-logang@deltatee.com>
 <20180622194752.11221-7-logang@deltatee.com>
 <CAOMZO5DpwPsidKQ9wfe8mNTgdOpkdHHgqHMa4yQBx9uRrfFmww@mail.gmail.com>
 <CAHp75VcCNsx2sHcYG2aNiw354exTvO=NUOS9P_BTmcM3siAepg@mail.gmail.com>
 <13ea3f97-4a33-3a24-1b7e-b819be73d867@deltatee.com>
 <CAOMZO5CfUfNZd0kG=VVnH4BjP+XMpGh3bPCUrTwi_4w6YEGX7g@mail.gmail.com>
 <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com>
 <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com>
 <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com>
 <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5C7V4_SpXOcAz0KbGYScpos0HRD-aa-Zh_6M3p9EqLsLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2735;7:L5IylFo1pO8ziySxRtAuUXTEeCVPdLjkEeBAhHBdQvs3VRood/nfX5iSy2XjDvJ8mAOmDyS4Q9qRL2bGnOuFiunERh2LQtOsLPKhoYyWvHhGCmuGZM58hSmT0/hYvAeXVWwW8Ot8y2Z0jFYWoYzV89oO9XVN1zIPH9Yj8HGlCAiY6P2ts5/Jy84tzg7Lf+6hXWVigAg9UQMzp6Ln1GmTHm+rfZGQzRn8asIfG6AFNm0a5Mr88XD1LCk3/tY6rrBl
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 96750311-b168-4d37-f470-08d5e1c70f5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2735;
x-ms-traffictypediagnostic: VI1PR0402MB2735:
x-microsoft-antispam-prvs: <VI1PR0402MB2735A4DD3F2C917DD2CA07DC98410@VI1PR0402MB2735.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0402MB2735;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2735;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(966005)(9686003)(6436002)(55016002)(33656002)(6306002)(105586002)(106356001)(229853002)(478600001)(14454004)(2906002)(68736007)(4326008)(14444005)(256004)(25786009)(7416002)(6246003)(3846002)(66066001)(53936002)(2900100001)(39060400002)(97736004)(93886005)(8936002)(6116002)(316002)(5250100002)(54906003)(99286004)(6916009)(5660300001)(7736002)(74316002)(8676002)(305945005)(81166006)(81156014)(26005)(6506007)(186003)(53546011)(76176011)(102836004)(575784001)(7696005)(86362001)(1411001)(486006)(446003)(476003)(44832011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2735;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SMqu4SbCifU9DZDAIuFx9KwRUKTNF5fU+O6mCDp9EpIHmjIg0BNNsCygjLVm6WTKIAwn1NtsAFlndpJKFmdJ7p/sSRm1wclHx5P3+rVIrmubOT8LT95lTkuFRFgFA0lG2jRcfxRXZ03FLyo2j5VYy6tN2siuqV17IR4lO/7YXHLmzjjKK4FrVDhRCpZoBZloJe4iHPKZWbr/hCOMHpQ1un9TO16Czu5l1mqxmg/zHaSRj6QPBWTPwuOuRW62WyRti7RFXZWXG2Z0MZDHRfYA/xJV7lee8J1/QfRKIlArCmZi0i79G5vf1lfBi68+5saZnJypZsIGbWnEyAd8WuqvcJBfI35PkuDqEleRV0NZaxw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96750311-b168-4d37-f470-08d5e1c70f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 15:59:01.3969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2018 6:06 PM, Fabio Estevam wrote:=0A=
> Hi Horia,=0A=
> =0A=
> On Wed, Jul 4, 2018 at 8:45 AM, Horia Geanta <horia.geanta@nxp.com> wrote=
:=0A=
> =0A=
>> I think there are two separate issues here:=0A=
>>=0A=
>> 1. Semantics of operations in io-64-nonatomic-lo-hi.h, io-64-nonatomic-h=
i-lo.h=0A=
>>=0A=
>> Logan, you mentioned the following (which unfortunately I somehow missed=
):=0A=
>> https://lore.kernel.org/lkml/c3f2e061-5ed1-5c74-b955-3d2bfb0da074@deltat=
ee.com=0A=
>> The lo_hi/hi_lo functions seem to always refer to the data being written=
=0A=
>> or read not to the address operated on.=0A=
>>=0A=
>> OTOH, initial commit that added asm-generic/io-64-nonatomic-lo-hi.h and=
=0A=
>> asm-generic/io-64-nonatomic-hi-lo.h mentions:=0A=
>> 797a796a13df6 ("asm-generic: architecture independent readq/writeq for 3=
2bit=0A=
>> environment")=0A=
>> - <asm-generic/io-64-nonatomic-lo-hi.h> provides non-atomic readq/ write=
q with=0A=
>> the order of lower address -> higher address=0A=
>> - <asm-generic/io-64-nonatomic-hi-lo.h> provides non-atomic readq/ write=
q with=0A=
>> reversed order=0A=
>>=0A=
>> I think we should keep the initial semantics when adding support for=0A=
>> io{read|write}64, i.e. "lo" and "hi" to refer to address and not to valu=
e.=0A=
>>=0A=
>> Actually this is the semantics intended for the CAAM patch, see the note=
 at the=0A=
>> end of the commit message that refers to addresses, not values:=0A=
>> To be consistent with CAAM engine HW spec: in case of 64-bit registers,=
=0A=
>> irrespective of device endianness, the lower address should be read from=
=0A=
>> / written to first, followed by the upper address.=0A=
>>=0A=
>>=0A=
>> 2. CAAM driver I/O accessors for i.MX case=0A=
>>=0A=
>> CAAM block in some i.MX parts has broken endianness for 64b registers.=
=0A=
>> For e.g. for i.MX6S/SL/D/Q even though CAAM is little endian, BARs for I=
/O rings=0A=
>> have to be programmed as:=0A=
>> I/O Ring BAR+0: unused=0A=
>> I/O Ring BAR+4: IOVA (32-bit little endian)=0A=
>> when the proper layout (for a 64b register) would have been to program I=
OVA at=0A=
>> BAR+0.=0A=
>>=0A=
>> This explains why I/O accessors in CAAM driver handle things differently=
 in case=0A=
>> caam_imx=3Dtrue.=0A=
>>=0A=
>> Since this quirk cannot be accommodated in generic fashion, code dealing=
 with=0A=
>> caam_imx has to stay.=0A=
> =0A=
> Should I sent a revert of patch 46e4bf08f6388 for the boot regression for=
 now?=0A=
> =0A=
> Then the two issues you pointed out could be fixed later.=0A=
> =0A=
I guess it would be better this way.=0A=
=0A=
Thanks,=0A=
Horia=0A=
