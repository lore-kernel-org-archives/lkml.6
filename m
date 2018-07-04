Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0683242F2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g3T1xK9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0683242F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934617AbeGDLpz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:45:55 -0400
Received: from mail-eopbgr40071.outbound.protection.outlook.com ([40.107.4.71]:14160
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932758AbeGDLps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdAhkSkYmhgUSwjPj9XnsBUMRsnGO8cgXZSg3VB2Zfw=;
 b=g3T1xK9k1GgYoywGq5sHYV8T7VEmoutZ2ogEmB9GC6jp2pV4YbiKQ1sQd2kJCma0yaxR74OxS2lkv5WHAhE0Aj1Ngg622i9McyR3VWpRt+ZT6xjY6JT0Yg3qifnej1S6zdBCgd0Cm8qYNyGUoLYvRBgc4s31zr9FCMhy4+wtCSg=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2784.eurprd04.prod.outlook.com (10.172.255.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Wed, 4 Jul 2018 11:45:44 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::197e:c4f9:bb4d:e560]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::197e:c4f9:bb4d:e560%2]) with mapi id 15.20.0906.026; Wed, 4 Jul 2018
 11:45:44 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
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
Date:   Wed, 4 Jul 2018 11:45:44 +0000
Message-ID: <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
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
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2784;7:VN4pnbzcRs6/YLkgOxuF8oqzwQiFmSFIM0Qc5JwsXyTJAKSyuvrPR2439pBMcaKj9e0/Y49I240BxsukKFDBV06tIF3dbefqvLc1R8LhuQAGU7YzoOIusKLWaRBTag+Cv91sLTIUnaI/Lk3mNsnyb/wlq6n5ln5UC/Tq7CUxyn4LNdTwB4Uwof3ha3uNkwXrYeLiXNgw1YEP0yFVZoYwGC4u4SbY+tE9V38wMquTodZbLKVRaE1bIfu5iZZ43d0L
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7cd70857-e62f-4967-6c32-08d5e1a3ad73
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2784;
x-ms-traffictypediagnostic: VI1PR0402MB2784:
x-microsoft-antispam-prvs: <VI1PR0402MB27842CC592E05A3FCDCD007598410@VI1PR0402MB2784.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0402MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2784;
x-forefront-prvs: 0723A02764
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(6436002)(8676002)(81156014)(6306002)(55016002)(53936002)(4326008)(9686003)(6636002)(446003)(2906002)(486006)(33656002)(105586002)(14444005)(229853002)(7696005)(44832011)(5660300001)(8936002)(68736007)(81166006)(53546011)(476003)(256004)(6506007)(6246003)(99286004)(76176011)(106356001)(305945005)(102836004)(575784001)(7736002)(6116002)(7416002)(25786009)(2900100001)(86362001)(3846002)(5250100002)(39060400002)(93886005)(66066001)(26005)(478600001)(110136005)(54906003)(316002)(74316002)(14454004)(97736004)(966005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2784;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2ox3MoFSUo3gQ7JTiKLUo+wBLgg+8FlXCYl8GkZQ/pPV1oRe0nWqlP069ZyBRZ5jSrny8F74GBDCZx+uwIhuCB/Ex/HDce4rto57OAHwZ6pjTDou+k4dqW+vPIiYoHVPufnDrcqN86Rchfuk42SU+QjcuXaxauAs6/uooDohaKr/7IbMUpzspTlYUODSU86ZpSSASqwgzM12oXHPern8J6Y24clv4fpsyjCdzrxoZMCWE6UUB8fNiNKV/+9jXvMMr9JyX/C4gYfhEMAvAyPGEYcuvYY9Ozx5QYZx40e/vby9sLlvKw1Q0KIVH/pNUrBaC7i5CjiHaYjwAlMlRd4+uXw+A5Z4o5ADcQVRe0gPNWM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd70857-e62f-4967-6c32-08d5e1a3ad73
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2018 11:45:44.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2018 2:58 AM, Logan Gunthorpe wrote:=0A=
> =0A=
> =0A=
> On 03/07/18 04:21 PM, Andy Shevchenko wrote:=0A=
>> It is an explicit call to BUG().=0A=
>> That's why we see wrong instruction trap.=0A=
> =0A=
> Ok, I think I see the problem... the code is rather confusing:=0A=
> =0A=
> Prior to the patch, IOs were BE depending on caam_little_end but if=0A=
> caam_imx was set, then it wrote two LE writes with the high one first.=0A=
> After the patch, it writes two BE writes with the high one first.=0A=
> =0A=
I think there are two separate issues here:=0A=
=0A=
1. Semantics of operations in io-64-nonatomic-lo-hi.h, io-64-nonatomic-hi-l=
o.h=0A=
=0A=
Logan, you mentioned the following (which unfortunately I somehow missed):=
=0A=
https://lore.kernel.org/lkml/c3f2e061-5ed1-5c74-b955-3d2bfb0da074@deltatee.=
com=0A=
The lo_hi/hi_lo functions seem to always refer to the data being written=0A=
or read not to the address operated on.=0A=
=0A=
OTOH, initial commit that added asm-generic/io-64-nonatomic-lo-hi.h and=0A=
asm-generic/io-64-nonatomic-hi-lo.h mentions:=0A=
797a796a13df6 ("asm-generic: architecture independent readq/writeq for 32bi=
t=0A=
environment")=0A=
- <asm-generic/io-64-nonatomic-lo-hi.h> provides non-atomic readq/ writeq w=
ith=0A=
the order of lower address -> higher address=0A=
- <asm-generic/io-64-nonatomic-hi-lo.h> provides non-atomic readq/ writeq w=
ith=0A=
reversed order=0A=
=0A=
I think we should keep the initial semantics when adding support for=0A=
io{read|write}64, i.e. "lo" and "hi" to refer to address and not to value.=
=0A=
=0A=
Actually this is the semantics intended for the CAAM patch, see the note at=
 the=0A=
end of the commit message that refers to addresses, not values:=0A=
To be consistent with CAAM engine HW spec: in case of 64-bit registers,=0A=
irrespective of device endianness, the lower address should be read from=0A=
/ written to first, followed by the upper address.=0A=
=0A=
=0A=
2. CAAM driver I/O accessors for i.MX case=0A=
=0A=
CAAM block in some i.MX parts has broken endianness for 64b registers.=0A=
For e.g. for i.MX6S/SL/D/Q even though CAAM is little endian, BARs for I/O =
rings=0A=
have to be programmed as:=0A=
I/O Ring BAR+0: unused=0A=
I/O Ring BAR+4: IOVA (32-bit little endian)=0A=
when the proper layout (for a 64b register) would have been to program IOVA=
 at=0A=
BAR+0.=0A=
=0A=
This explains why I/O accessors in CAAM driver handle things differently in=
 case=0A=
caam_imx=3Dtrue.=0A=
=0A=
Since this quirk cannot be accommodated in generic fashion, code dealing wi=
th=0A=
caam_imx has to stay.=0A=
=0A=
Horia=0A=
