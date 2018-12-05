Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A8C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9897208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wPE6U43m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9897208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeLEW5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:57:23 -0500
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:28961
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727337AbeLEW5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUG+DpK5ANaSZHEYAi0TDgSBVe7BGEPIscsYzFjUufg=;
 b=wPE6U43mMeQkiwR1aPOmzpGrBiN7SmTOt980bj02Dx9L3q0/rP0S8V7iyIJ/nenvdGCIMXTs7e+PR9Nl0fdj1qYanQme+1r9VeOzCuxZdDA727K5aYzkXBy/yZ5Eb47LYAa1PnM9LY4cH3e2xIrLdSmDQ1BTrI/pgkp6EEHmBB8=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB4404.eurprd04.prod.outlook.com (52.135.148.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Wed, 5 Dec 2018 22:57:19 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::f038:ecc0:3ab5:3bbd]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::f038:ecc0:3ab5:3bbd%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 22:57:19 +0000
From:   York Sun <york.sun@nxp.com>
To:     Tracy Smith <tlsmith3777@gmail.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Layerscape behavior when a UE is detected
Thread-Topic: Layerscape behavior when a UE is detected
Thread-Index: AQHUjO1qaWrQQwRuwEuKdfrMIj+t+g==
Date:   Wed, 5 Dec 2018 22:57:18 +0000
Message-ID: <AM0PR04MB39717D1017A161D54940486D9AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
 <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
 <20181128234415.GH16830@zn.tnic>
 <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
 <AM0PR04MB3971D326D037CFB2497B1A559AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNxcpHDOn1Rkxwp8VbuN5-k08JfrgwdbN95uvMWVh1Rwg@mail.gmail.com>
 <AM0PR04MB3971DE1C9A0B3D6C938CBADD9AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNSGosbBbiBh-MF8FsnKpL3jMaS-fr_BzQAjEcPCWi7Ew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4404;6:w1+AtcHhhcgxih2RXlneHiT0QOi+nBCZ2/DkId3zsLh9xxAQ4+BlY3SIvLpuV2jeyt3qCQRz1R4g5OKm1b3cm4JiDx4tuP0ZWuT+x59U4BpqQ/Im+dNJU0O38uYEYoTvjFE27Y43EIPcmnVmILihwQpleZ7vTXNXa2IE7etXj1s8Fep4I9a9q4sS4pwoyD1qcC+wuBmN9d9vxBpGSMvqkFqlABLCHs1sZMaSRoS5GiaMH7r0xYWHNTbGa5TvSkPk/maNSXWREUbAc57y6X4Rw4y7+cie90WH5S+QGbFhhHoSi7ehN36SWrMq5hpBwJfx4AznWmGnUwVkF+dFcu+aSYJuKYvUJF+nl6QrNbt7PGXmx/4KD7D9zHM6lxZix4p3QhzOp0vP9G0XOkzZHM2H1ubSkk6TJBO6BsIRI5V3egrfciQUqYGyZ+0KGwMGHTk37u53km6OXW6uBI20wZ3Fgg==;5:PaGPIVv8TPt7Ks/nnHat/RjjwAD40/WTjYG7GYPSVegPsG3DHaUFEzLNeMURaGT9Sgj3shjLXbctW1zTJYQVI5qgCQvDmqlMdykS+b5RX9o6vrMlsp/PfJPdnuSA1oTJ6AkMjIS613RQcv1+3g74g6yBpejBxLotnEOJ1ufMeZ8=;7:IhKJBaBjdBt6XOZjQ3XtK5qtifNEM5Y+9TulEUt5dfM5GyZ1PfGEinhwHqZK/wzEaWIuGbRHRFE4+eh5B1u2HRkR+h6hKlujQn2tKw6ewnSTkLYhBlvGwHPSAXQGmyFt5Cqj5VhPwFuyxeYP0HaWPA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1f1502a3-9599-46c5-d2bc-08d65b050242
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4404;
x-ms-traffictypediagnostic: AM0PR04MB4404:
x-microsoft-antispam-prvs: <AM0PR04MB4404860E119792236E6FB5A59AA80@AM0PR04MB4404.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4404;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4404;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(446003)(486006)(102836004)(44832011)(54906003)(476003)(2906002)(6506007)(316002)(53546011)(6246003)(256004)(26005)(14444005)(3846002)(4326008)(53936002)(39060400002)(99286004)(55016002)(93886005)(66066001)(86362001)(186003)(6116002)(81156014)(33656002)(7696005)(76176011)(9686003)(14454004)(105586002)(25786009)(478600001)(1411001)(71190400001)(74316002)(81166006)(8936002)(8676002)(71200400001)(106356001)(6916009)(305945005)(229853002)(7736002)(5660300001)(97736004)(6436002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4404;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 26d3f5rqQlbjgsB9NSdGJlora2OIdikIS9rGTNMgJD2vgVJW+eL7rvWEmW5A3s83d5duHYov0HcxogrPoMRzsG4EU5HiVoLZ2nlfxQNuFF7fmQM14UbdozQ5hmYZb02PkndKQgtarWWufL+tuLBv43RC7y/HhHV6aa+v2Bl2ca1LSzsnwXyqDdbO0d94v1I+Me6JWp38+wGceLhRztFO9ar9ZfaF6yzf/YKBauxCFfo7aiZbnkrlSNW8SyHDfTpzp/u6n6vompMGlbrM5yB6fq5kGHozyV8p2J8i3VuU1x6ZBeZiUbV084F7HLyt/+580pN3kzqh++q3ATaiZQ31t9RX87uBGUlDaA0d9Dg3LI0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1502a3-9599-46c5-d2bc-08d65b050242
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 22:57:18.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 2:54 PM, Tracy Smith wrote:=0A=
>>> Question 4) If so, will a panic ever be called if there is a hardware=
=0A=
>>> uncorrectable memory failure?=0A=
> =0A=
>> No. It is up to upper layer of EDAC driver. Layerscape driver only repor=
ts CEs and UEs.=0A=
> =0A=
> Just to be clear, the upper layer of the EDAC driver will or will not=0A=
> panic when a UE is detected on layerscape?=0A=
> =0A=
> If there is no panic by the upper layer and no reset triggered by the=0A=
> layerscape CPLD or memory controller, what happens on layerscape when=0A=
> a UE is detected by the memory controller?=0A=
> =0A=
> Forcing a UE by grounding a dataline caused a reset on layerscape=0A=
> after a few seconds, but no panic. It is unclear why it reset, but it=0A=
> appears as though a WDT was tripped. The UE was reported by EDAC and=0A=
> seen in the log.=0A=
> =0A=
I can't help you on that. I never tried to force errors by grounding the=0A=
signals. You have read the driver. Do you see panic? The idea is to=0A=
report the error and let upper layer to decide what to do. Sometimes=0A=
limping forward is better than reset or panic. Again, it is not driver's=0A=
responsibility.=0A=
=0A=
York=0A=
