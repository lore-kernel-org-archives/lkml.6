Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD7FC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB7420652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lTX28n3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB7420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJDQTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:19:35 -0400
Received: from mail-eopbgr00066.outbound.protection.outlook.com ([40.107.0.66]:40224
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727150AbeJDQTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhH2RGEa9oJVJGdfW6iQqrP4AxaNKOsMuxZ2YyAV9Ic=;
 b=lTX28n3FoO+tARcx7cphM/Upm2PItPQmZUsI4dC3unYfxonyBlm2f/03PmUFeEkQYCX0kR+vlKZpwD/29E6+oASJX+gThk37/1bksaSqw/jfbDSDVE3STnd40QpN+qjperH4Ak+eOvijDEak5Xr4wI25TAnNBgU7O2GUozOA+bk=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5295.eurprd04.prod.outlook.com (20.177.51.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 09:27:07 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb%4]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 09:27:07 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
Thread-Topic: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
Thread-Index: AQHUW79YZxhjkV/EkkiB5uA/7QV9n6UOzuUAgAABlJCAAACYAIAAAC5A
Date:   Thu, 4 Oct 2018 09:27:07 +0000
Message-ID: <VI1PR04MB1038A3CE7098227B6912C6F699EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181004111822.48ab1f5c@bbrezillon>
        <VI1PR04MB1038ECE25B571117405A617799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181004112608.3ae23d99@bbrezillon>
In-Reply-To: <20181004112608.3ae23d99@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5295;6:Gs8FI1dt9zlsRlnYsDnGPF6YmKh4z/RZa1bTZEsLCuAsstKT7UePIqcNMGYnXAQcMJOSTu1y8DEEePrcdgobOdNtopQSQVDNW8t6mmd8kGaSNj8QQO3NyMZMpuYY4TgoYGb8ZH+0Mbvn1rxQNEmuPWHtMyBMoKDtGrxJWKFkv7xVusFWkhMLx+ac78C0zVusjblQGNEnaxmMZ6RwaSt2BKbAEPmR+0McxAcmkiz5QQv/lU7uUIcnNNo7vt6hrtX8FZPgRdSNgE/Ygd0CYnD+70m4b9tgs0YynbGba1Peih5s/Vd28PMkf9yjokLJz8rkiIZ5XUn+PaknhUCFsx4StQiLGxzCEBA6jpSgDKeqINQ/pp0Nl3+MvU7uN1GWeK45QBSDqRAWr3hcvuAquxJJot2AOYLnDoWb4p1HYR69kNhMGLpjRACsdUJGwyKXFn8EUEQ2CZVLtn7wBCcVZ59mMA==;5:rXjdMVTnC00iqgqpZmNjWojAvzwcUMu3FJTo2Jme2SgVuf5/hKzcQpDX8x2Fawzby3599CdxImLtKrfd8R1vYSuyyMVE2d0ofsf4E9w0Zl7jsSnIT+srC7DH6gib5b2QZ4x6YeipGypt3JBLSHzIap3sOmdx1cNr9xSl2DFOVEY=;7:o9KfufefKq8cG/l7MwZQ8gPFOJ4VRXigpoIYbWy3Kk9pSpBMfBJKOLuQLC4IiVeiUn3kThYUFC7EmESxRoZfy8SRd5bkvamfKY36pjvqB171afaVpqChw8xdHuckRewcC9pCofqwJ1tGPnd+tFYN7gP3n8uLez2/APqfBSWumHWS4yuoFtT1hY1lcz/ZxpcNMHEB2FwX1FedyufC57W3FlNunIfyKqAtBzRoEf0rc8b6cDGKfAcIuvgl2XbhDZ2O
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f89430d8-43f7-444e-38e1-08d629db8ddc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5295;
x-ms-traffictypediagnostic: VI1PR04MB5295:
x-microsoft-antispam-prvs: <VI1PR04MB52950F8E73B02224C7A96A2799EA0@VI1PR04MB5295.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(31051911155226)(9452136761055)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB5295;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5295;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(13464003)(199004)(189003)(11346002)(446003)(53546011)(99286004)(6506007)(76176011)(256004)(14444005)(2906002)(54906003)(476003)(3846002)(6116002)(66066001)(486006)(229853002)(93886005)(102836004)(81156014)(53936002)(9686003)(74316002)(8676002)(7416002)(8936002)(7736002)(55016002)(316002)(186003)(7696005)(2900100001)(26005)(6436002)(305945005)(81166006)(25786009)(86362001)(5250100002)(478600001)(5660300001)(106356001)(105586002)(4326008)(15650500001)(14454004)(39060400002)(6246003)(68736007)(71190400001)(97736004)(71200400001)(33656002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5295;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K2cmODETWrf8ogC1GwEkvHF6OI7aDXhecefSQ4DAi9tVRpVurFcgpss5Iuq8CDzJi8+h3mVjcoABIkcuAafpMapFTRgt1NV5BXaXcdoPVhY0C4fxTKyJjBrqKkYCP03/JJmdwiLqXN1eRbhX2ZWwTBYU9uOMHp6vsLfvAoYag5SzZ4wACptUdlAd8jySTVD4qliQCvTxeCV+QB+wvag/EvT2Uu6GtYkIIoeqY0tNa5+vP2v5kUBgJ9DbITEE2vz5TLC1A5Y8yMWP+Am/PKyMdyluSv34SrkG16pAsa46VRQ3vmnLjPJLRMfM5n0cl5/Zlbbf0iATgtoDHndMdfemHi+x/c1rqG8LKfOn+jJ54DY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89430d8-43f7-444e-38e1-08d629db8ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 09:27:07.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, October 4, 2018 2:56 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com=
;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
>=20
> On Thu, 4 Oct 2018 09:24:57 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Thursday, October 4, 2018 2:48 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > vigneshr@ti.com; linux-spi@vger.kernel.org;
> > > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > > shawnguo@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > computersforpeace@gmail.com; frieder.schrempf@exceet.de;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
> > >
> > > On Thu,  4 Oct 2018 14:18:40 +0530
> > > Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >
> > > > Flash mt35xu512aba connected to FlexSPI controller supports
> > > > 1-1-8 protocol.
> > > > Added flag spi-rx-bus-width and spi-tx-bus-width with values as
> > > > 8 and 1 respectively for both flashes connected at CS0 and CS1.
> > > >
> > > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > > > index 901ca346..817175a 100644
> > > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > > > @@ -42,6 +42,8 @@
> > > >  		m25p,fast-read;
> > > >  		spi-max-frequency =3D <20000000>;
> > > >  		reg =3D <0>;
> > > > +		spi-rx-bus-width =3D <8>;
> > > > +		spi-tx-bus-width =3D <1>;
> > >
> > > Why 1? The flash is already flagged with SPI_NOR_OCTAL_READ, which
> > > means only the read path will use 1-1-8 mode, so you can safely set
> > > spi-tx-bus-width
>=20
> I meant 'set spi-tx-bus-width to 8' here

Yes.

>=20
> > > here and let the framework choose the appropriate mode based on the
> > > flash capabilities.
> >
> > Ok.
> >
> > >
> > > >  	};
> > > >
> > > >  	mt35xu512aba1: flash@1 {
> > > > @@ -51,6 +53,8 @@
> > > >  		m25p,fast-read;
> > > >  		spi-max-frequency =3D <20000000>;
> > > >  		reg =3D <1>;
> > > > +		spi-rx-bus-width =3D <8>;
> > > > +		spi-tx-bus-width =3D <1>;
> > > >  	};
> > > >  };
> > > >
> >

