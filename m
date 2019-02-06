Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AC020823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CGiNIPc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfBFQ4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:56:24 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:44246 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbfBFQ4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:56:23 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5b11b40000>; Thu, 07 Feb 2019 00:56:20 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 08:56:20 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 06 Feb 2019 08:56:20 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 16:56:19 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 16:56:17 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.55) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 16:56:17 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3606.namprd12.prod.outlook.com (20.178.197.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 16:56:15 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 16:56:15 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V13 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V13 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvirrRqFd+/7ajEuXA8RvSaEC+KXS3a4AgAAAyeCAAAx6QIAABMwAgAAG+YCAAAEXoIAAAZ0AgAADYDA=
Date:   Wed, 6 Feb 2019 16:56:15 +0000
Message-ID: <BYAPR12MB3398F7FB1337B788B7E53068C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
 <1549464441-1836-3-git-send-email-skomatineni@nvidia.com>
 <4ecd3894-a1cb-20dd-8675-26e6e84254e7@gmail.com>
 <BYAPR12MB3398A6C76EC731D259FC3EA4C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33988DCC1F4997AAF2112447C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <9c6524ec-b40b-5b0f-eb70-f9ce2c426fd9@gmail.com>
 <8eccb125-b771-fe10-492f-41dcda00c3b0@gmail.com>
 <BYAPR12MB33980C126166D851B91AB187C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190206164158.GA6205@ulmo>
In-Reply-To: <20190206164158.GA6205@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3606;6:2aNP+lo4lzUqOpbYyo1M93mFJtRk19N1aMsoaP6YvKkxMYlmrueG7yC+g3GvshX0MEZ9pMZ7u2ThbeSlOHK3UXE8RGEFfCsxWBAVqceGyR93gpzkQydpzP+ukB4VIcdveRD/9NWGVSlHHaDHjmqalMnFi4XUqthLT3HC0zpul4bwwiRoEZ3qyK8nfUq6YuRtfgEwBKBVMgAr7OKgpmdW8+jI9jQwzi33A4DgvJesLQvU644AlAEwVmLJWuLl8HLaEkbZ+kLGKGlqXxga3FLaDtMv3fREK2fAzD2x6IpSH9oZIW4CP7uVfMGZfK8v7xyXvvcTj3b97G4MgMkvcnxhRMNTR8KszEyxDXNmdvJ6M2YIc+uy99fvfBeFfCRNo+OrLfcUbDYggH4fB3y3MXRhSmSqsJTaIxzBeyj27TXY5bu8hHrdLJ1ndRWyppugFuQWwztwWry3SzaXY2CnGtI0LA==;5:Tsb5cx8kauXr7ieVt0TA+mRGIBYM5Gkk4LlzxffqagGqxGsgG2a1lnG6/9phhNqKjBM/exxT5FCC0ihkQZ0qK9KVm5OJ20codc2kwzP73l6Y2NvDk2sRbvtdiKZS4WiWfRH1HfX0vc9A6Sp8SK39dnRYwSOITncCO/YWnC6yCdPzIjJ6Bz7do5cYH/CXaR9QoRDl39gGyR70I0OFmxSnDg==;7:x7z69wW16qFTiGi8jIxmrqdTYfJ2D3ugiYARwnb9modUhDJg8XAGY+7+Y+z3ggTVv9fo8HaC6moB3DO/p2mbiFToBhKegG5sGxoAbLImbU4QsPGzO81wkA80cDukdBa1c6IVp/bdg+YM1DsuiI3QEw==
x-ms-office365-filtering-correlation-id: cd056801-93a6-49af-c532-08d68c5401b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3606;
x-ms-traffictypediagnostic: BYAPR12MB3606:
x-microsoft-antispam-prvs: <BYAPR12MB36067FCDA6EB6221183A249CC26F0@BYAPR12MB3606.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(6506007)(14454004)(102836004)(26005)(7736002)(305945005)(6436002)(33656002)(97736004)(74316002)(966005)(316002)(229853002)(93886005)(76176011)(54906003)(55016002)(9686003)(6916009)(81166006)(8936002)(99286004)(8676002)(81156014)(7696005)(71190400001)(71200400001)(86362001)(106356001)(6116002)(3846002)(105586002)(4326008)(6246003)(6306002)(25786009)(66066001)(2906002)(53376002)(53936002)(68736007)(256004)(478600001)(186003)(476003)(11346002)(486006)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3606;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E+pfAEhMDXK2t2ehxEV0rdeaAn5zbKrs5lvoo7pHQLcVDornYjORqGv0R7c1687nFqsHbfRH/6D5wUr2cZlTgqpFQS6tYu2y6YPU96J6WaXtHBi7I9eqbEt9ezMHlTwkE4YqQQFwMh1cUlcfGubXdwSOj10bgUy0XNkqeuFW9qZbTH/G/6r0VpcXgvNaG61Gb3y3/6F7S0KDtqm2svypKmOGbZSrjM5n4T1W72b4S/+82K/VflGtnlBw51kAkxAloNJaLjOGo60Oqx+dpOT6sWuqjFkpPqc1gJP29E/Cdek1zemLSHRHC7UlRYmw134DR4u3B/+CLQYWCHuHNiu05h04faLTi6ACVVM1Gg12VK4cmyGAhz8EA1QFkXPoXyOkfeYtgNI/z90+koPxTwrFa34C7yoc1DqOBZEhOr1icyk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cd056801-93a6-49af-c532-08d68c5401b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 16:56:15.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3606
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549472180; bh=i23ni7hN2NeuJP0P6bGfjMLEc+XEAuaoEfVvic3HmWk=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=CGiNIPc4IFy9Kop2fI00dD0laeNY1Oq4LIeVMx81rghjF8McAl6cJxLERLYksKyEO
         e9jZ1k2to6zj/M0VKzE3BTM/GTk2P0PhIuT2z4IHaE4rnWDDgq+yTcWSXdhuy0l7BD
         Loj6Nn81JMaDVwbJAuXJDuzklaCvUD0XCYl5FBWhgiV5UGW66x+XQ9febVOW1sgWX2
         sfGpipkc+9+jjgk7FVSVkyKABB27wiN+sWcfeArln4xZHrc3sDxi5eeNedcVt227Xl
         kABX2/5tSV1Sbhfq23kKNdUUSOPrYg56/tWXmRZPqKEtJwHs1ANINAhoG2IsI6egP+
         7dFmfj3CqqdfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >> Looking into timestamps and transactions, DMA timeouts after start=
 of DMA for I2C1 to touch during this transaction.
> > > >> While it is waiting for I2C1 DMA transfer, lots of DVC=20
> > > >> transactions happened thru DMA which are successful
> > > >>
> > > >> What is the I2C1 speed?
> > > >=20
> > > > 400KHz
> > > >=20
> > > >> Also incase if device is running slow for some reason, probably ti=
meout was not enough as this patch series changes timeout with base 100mS +=
 msg transfer time based on transfer size.
> > > >> Can you give quick try with increased timeout incase if device is =
running slow?
> > > >>
> > > >=20
> > > > Tried to increase the timeout to 1 second, doesn't help.
> > > >=20
> > > > What helped again is the I2C HW resetting after each transfer. Like=
ly that means that HW isn't programmed correctly, please carefully check ev=
ery bit.
> > > >=20
> > > > DMA-only + I2C HW reset: http://dpaste.com/26AQXFM.txt
> > >
> > > Seems I found what's the problem. Here is the fix, please include it =
to v14 if it is correct.
> > >
> > > diff --git a/drivers/i2c/busses/i2c-tegra.c=20
> > > b/drivers/i2c/busses/i2c-tegra.c index a9391c3646b6..5ad54da70304=20
> > > 100644
> > > --- a/drivers/i2c/busses/i2c-tegra.c
> > > +++ b/drivers/i2c/busses/i2c-tegra.c
> > > @@ -912,7 +912,7 @@ static irqreturn_t tegra_i2c_isr(int irq, void *d=
ev_id)  static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_de=
v,
> > >                                        size_t len)  {
> > > -       u32 val, reg;
> > > +       u32 val =3D 0, reg;
> > >         u8 dma_burst =3D 0;
> > >         struct dma_slave_config slv_config =3D {0};
> > >         struct dma_chan *chan;
> > > @@ -922,7 +922,6 @@ static void tegra_i2c_config_fifo_trig(struct teg=
ra_i2c_dev *i2c_dev,
> > >                 reg =3D I2C_MST_FIFO_CONTROL;
> > >         else
> > >                 reg =3D I2C_FIFO_CONTROL;
> > > -       val =3D i2c_readl(i2c_dev, reg);
> >  >
> >  >        if (i2c_dev->is_curr_dma_xfer) {
> >  >                if (len & 0xF)
> >=20
> > Thanks dmitry. Good catch. Didn't caught to my eyes. Yes FIFO_CONTROL=20
> > is set based on read value without masking and oring causing back-back =
DMA transfers resulting in incorrect trig levels We can directly set trig l=
evels.
>
> It might be safer to explicitly clear the trigger levels before we overwr=
ite them. Though, admittedly, this register hasn't changed in years, so it'=
s unlikely we'll ever see it change in a way that might result in breakage =
if we construct the register value from scratch.
>
> Thierry

FIFO_CONTROL has trig and flush for TX & RX and since we do TX/RX and flush=
 anyway prior to transfer, constructing from scratch should be fine as its =
same as doing mask-modify-write
