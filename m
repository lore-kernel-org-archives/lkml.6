Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D985AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AE220857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mARIrqCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfBAFF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:05:56 -0500
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:19935
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725681AbfBAFFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OdoRb1a1czrOXVcFLPFbUPT8SCfyI7ybYJuekEUO4o=;
 b=mARIrqCmqXCnnl1GqTSb4mwfG9jaRXe2kGLdbf3a26dWcnr9M3pL+as/ztV2hOybSrvmjsdMbxQVvShQRSahf5CO7GjmXpaBkNYOmYKKAVhJBqcOl7y8B6hfHqm+7CEUv9TXYfxvfPWxbhxnWBBHrkrbPmJOHnl5RlvFMRDe1PM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4109.eurprd04.prod.outlook.com (52.133.14.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 05:05:49 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%5]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 05:05:49 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Topic: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Thread-Index: AQHUrMnmG0R4tGWK7UOvqbFnAen7xaXKWTiAgAAkn1A=
Date:   Fri, 1 Feb 2019 05:05:49 +0000
Message-ID: <VI1PR04MB5726460C6F341F0DFEA8BA8899920@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20190201025405.GA19882@dragon>
In-Reply-To: <20190201025405.GA19882@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.120.0.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4109;6:NgcPvjHrEAtf2R6Grka3a+asUbVTZlgT9xIWkQgZtcsjVioag36pCvtcAb/oERoNn/5pGTSQaCijuJI3lparbQ+DypMWHjSasbMPpHhaieJ5uAoeSQk9YcdNCBNRQxu510HTWclJHNnfWblZRlyBGIME8cWTGuWqMyK0hyqJ/ijS3c4Lq/gfy/kRvyW4ra8cs2rv2WSiXU+suHe6Ik7BohInsQELRqHw7K2xYCEqJwCQOXz/BiDGLfYGwfxpLeZ3yHp0jjY6HMuHXCzy6m/r0ZXQfrMDcAOJ9VNJkiXZJEZMOmmIHONikJbnf6PhKy8KMfMqLobkF7ePSR/Op+py1yzuVSabiixtj4qrbQ+aOongC2Dl0wldaUdgwRGcE5kxkP3Cty3wSh758Zc0N6+l48ecAte5DQD0C1yPoGieiWgCN4nZyYEY2jq7YlfayXvaXlaSgcE+xr2R9wMd3CoovQ==;5:aDltuWC3uyaXq7xLkL6THd8U7nKN76y/0jNYUfSnT7iH2bERi9elwU8mmmCdOxls4/Y+65Xu+gksdkiopGCBt4l5QY2eFh0zmjcIX9V08YaVVJLuUVxb4FfpAczMdwoEMe8zKONsJk+bVr1dLeybl5bNpIEv1Fc0C7tgIV7LFVrY1+SJjVpWFiqypqUy/ByJeARBCKn2vNDRVMoG9ajxrg==;7:GvR3Ndd+/ib1K1F//qVIixsNSnd3O09USL1L+EoLA24gfPaxtRfbTjsOFYeapCQ/9sSgIyvCRPs4QEoghd6O9l87P5E1o1uyD5ZjIjUPqtN8utUzHAOdl30eEocx0D4bpBpveIQLH8xWQdAUaAPdNA==
x-ms-office365-filtering-correlation-id: 69aa749f-7813-4705-620a-08d68802eef2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4109;
x-ms-traffictypediagnostic: VI1PR04MB4109:
x-microsoft-antispam-prvs: <VI1PR04MB4109AC5CA7DBAB0113DE9FA899920@VI1PR04MB4109.eurprd04.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(366004)(13464003)(199004)(189003)(11346002)(6506007)(26005)(7696005)(53546011)(7736002)(4326008)(186003)(476003)(76176011)(6436002)(6916009)(229853002)(6306002)(86362001)(81166006)(14454004)(55016002)(99286004)(9686003)(81156014)(66066001)(25786009)(7416002)(8676002)(68736007)(305945005)(53936002)(102836004)(105586002)(6246003)(8936002)(478600001)(33656002)(97736004)(14444005)(6116002)(3846002)(54906003)(2906002)(39060400002)(966005)(446003)(486006)(45080400002)(256004)(316002)(106356001)(74316002)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4109;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TDYgXrKzxVrYRbxbp5+7Z0Hw5eDfW9K0GYgfh/bone1w67PZcThCETbOY5DSa/1e2M1DXuNI4a5INUyxwzJB7pmm0YWOd/luiwwvJhht5j9ovKY1Rm2vqnXnniscU+R2zYaBKeA6GgjQ52+TEDapw2VQZG5nH0UCYzzUWDh85dxCJG9bmfxmM0ovOYX1fBZCjdy3J/rhBepPJk04FE0h3onDJJrl27EUEysqTTnqF8qjDZIpJYfAgX2DHTmB6kmGNVzZHrwi92qLavBheGWxwHWCc18kn/Z6huiSCRZXiPBUSjTExIoQDngdsb6M6kDbf7OOx7GXlPZUcXN69i+/F0MuVOyuj8he7g+QzgHmpXq7IFcQuDOOtYe73y3ReUqIJR6ZQxqr7cVcC97DiX8NLntWoulcPAkikJZLDVyMIqk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aa749f-7813-4705-620a-08d68802eef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 05:05:49.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, February 1, 2019 8:24 AM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; bbrezillon@kernel.org;
> marek.vasut@gmail.com; broonie@kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; mark.rutland@arm.com; robh@kernel.org; linux-
> kernel@vger.kernel.org; frieder.schrempf@kontron.de;
> computersforpeace@gmail.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node propert=
y
>=20
> On Tue, Jan 15, 2019 at 12:00:26PM +0000, Yogesh Narayan Gaur wrote:
> > Add fspi node property for LX2160A SoC for FlexSPI driver.
> > Property added for the FlexSPI controller and for the connected slave
> > device for the LX2160ARDB target.
> > This is having two SPI-NOR flash device, mt35xu512aba, connected at
> > CS0 and CS1.
> >
> > Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> > Changes for v8:
> > - None
> > Changes for v7:
> > - None
> > Changes for v6:
> > - None
> > Changes for v5:
> > - None
> > Changes for v4:
> > - Incorporated Rob review comments.
> > Changes for v3:
> > - None.
> > Changes for v2:
> > - Incorporated Shawn review comments.
> >
> >  .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 22 +++++++++++++++++++
> >  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 13 +++++++++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > index 6481e5f20e69..70658946fbbe 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -50,6 +50,28 @@
> >  	status =3D "okay";
> >  };
> >
> > +&fspi {
> > +	status =3D "okay";
> > +
> > +	mt35xu512aba0: flash@0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "spansion,m25p80";
> > +		m25p,fast-read;
> > +		spi-max-frequency =3D <50000000>;
> > +		reg =3D <0>;
> > +	};
> > +
> > +	mt35xu512aba1: flash@1 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "spansion,m25p80";
> > +		m25p,fast-read;
> > +		spi-max-frequency =3D <50000000>;
> > +		reg =3D <1>;
> > +	};
> > +};
> > +
> >  &i2c0 {
> >  	status =3D "okay";
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > index a79f5c1ea56d..e3ff86201f73 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -762,5 +762,18 @@
> >  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> >  			dma-coherent;
> >  		};
> > +
> > +		fspi: spi@20c0000 {
>=20
> To keep the nodes sorted in unit-address, it should go after i2c@2070000.
>=20
> > +			compatible =3D "nxp,lx2160a-fspi";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			reg =3D <0x0 0x20c0000 0x0 0x10000>,
> > +				<0x0 0x20000000 0x0 0x10000000>;
>=20
> I would align the indentation with the above.
>=20
> > +			reg-names =3D "fspi_base", "fspi_mmap";
> > +			interrupts =3D <0 25 0x4>; /* Level high type */
>=20
> interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>; so that we can save the
> comment there.
>=20
> I fixed up all these small things and applied the patch.
>=20
Ok, Thanks.

--
Regards
Yogesh Gaur.

> Shawn
>=20
> > +			clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
> > +			clock-names =3D "fspi_en", "fspi";
> > +			status =3D "disabled";
> > +		};
> >  	};
> >  };
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flis=
t
> > s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=3D02%7C
> >
> 01%7Cyogeshnarayan.gaur%40nxp.com%7C6308464db1a541247dfd08d687f09
> 124%7
> >
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636845864632818753&a
> mp;sda
> >
> ta=3DurGFUKDP6ZZZOTXS1ccfLceCV2OBV5%2BiZq9foCu7ZX8%3D&amp;reserved=3D
> 0
