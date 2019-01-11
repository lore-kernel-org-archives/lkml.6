Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E124C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530A72177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UcqrgStj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfAKIpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:45:32 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:52450
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfAKIpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0cC8yw6ECqoTxs1zwosT+/Nj2O08P0pYIqidQZP+bA=;
 b=UcqrgStjpurLw1UoVWtFHTbCpV4X/e6nDNRAvBMi6TFSWCjcjshWqdoFfep0gB0TwQ543KYCsmfbn4Gz9mZi62gMobqcNT0WjTZE0/Lt/r+OgGgo37sa6/Rh7Umt8JfiEppzeJoxAeMymD7unnxkKuap2rVC4UithdVDVTRe3IA=
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com (20.177.53.224) by
 VI1PR04MB5312.eurprd04.prod.outlook.com (20.177.52.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 08:45:27 +0000
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::4d4c:bb1d:2598:39ea]) by VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::4d4c:bb1d:2598:39ea%3]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 08:45:27 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] arm64: dts: ls1088: add smmu device node
Thread-Topic: [PATCH 1/2] arm64: dts: ls1088: add smmu device node
Thread-Index: AQHUlo1oSPDChwILUE2cs2d7WwpBEaWp5VwAgAABYYA=
Date:   Fri, 11 Jan 2019 08:45:26 +0000
Message-ID: <VI1PR04MB44805B25ED8EB8B74E6E8EBBE6850@VI1PR04MB4480.eurprd04.prod.outlook.com>
References: <1545109016-1779-1-git-send-email-nipun.gupta@nxp.com>
 <20190111083956.GF32649@dragon>
In-Reply-To: <20190111083956.GF32649@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-originating-ip: [14.143.254.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5312;6:NgQ1R3iOl0HVrrEN5HF9v4topJ7wzakpbDv/R3y50ybOrqZiCcaQDvzTVljySVNv6g7yzNnR4bs+JSwFNNQcrbbLlkbx2Ppz/Fzr2punsV/83W29cy1D5p0FAYsE+sTle6RwCrPbX7gUCHDJgUUxryX9l7PrH7Aj2P4wNSisp+taDLFSrfJ3qnbDcLKqpP8UAr162LF/XOauxe6cfEuavoNsSU5oSiP67HyeOItdnlRy/7dt7Wacwtta/gVY1EO5g/cfW2eorJ55wJcL5frssyxPJq3CHDcfIe3XSfbxHDpxUY2bn12yPI6AhRmyBDoz6MxTApx06eYY7mVRYE+ex6E+ImyAdEojWLs1m1OQARKD8pJ0w2EFV63kY8QhSTJV2ZcOkZK1pSUY6WS6qyDTf7rimfYxdfNyn/d7U3M8ELM/FXP6j95sEGNmc4r+vPHl5lMDLlvs8sJdWTIV/YzNEQ==;5:OyZ4gTgVEOA/7RWn0nrCchWwdEHNsu3+rgoDKGBiXiOclS51SyjMa2D6S23XFaktzDzu7oOX8PKNxO6QsHI852hUkFpMn/I33C2HCSaZxGFsqkvlNaWON3kQ7rxICmP5/GSSuOhP3t9Io1Nm5o1niffRWeo/s4JkbV6hZoOrrSyUKGO95j3hmEngd60QNCTGHZ6D1ncFxNFKQdy2ASo1Qw==;7:CwG+tuirPfQiSvdUALR2er+gJwh+N+2mBrEbGLCMVEcif2U5dtYb/BO9qzjluyS4YhUSNcSVZNUwRzCDEouFCaCdynMkuZ3rWwIBm4P48tKtmubQTU2brWa2nS5T1Pbn4px9oRn/QHUknLq/vblpgw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 28f3295b-854d-411c-2029-08d677a12270
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5312;
x-ms-traffictypediagnostic: VI1PR04MB5312:
x-microsoft-antispam-prvs: <VI1PR04MB5312B43EEFBA254ECE70663FE6850@VI1PR04MB5312.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(13464003)(68736007)(33656002)(45080400002)(105586002)(106356001)(966005)(14454004)(97736004)(478600001)(14444005)(256004)(316002)(54906003)(55236004)(6506007)(102836004)(486006)(186003)(446003)(476003)(99286004)(53546011)(7696005)(11346002)(26005)(55016002)(78486014)(71200400001)(71190400001)(8936002)(76176011)(81166006)(305945005)(8676002)(81156014)(7736002)(6246003)(86362001)(575784001)(5660300001)(6116002)(3846002)(66066001)(44832011)(6436002)(25786009)(74316002)(4326008)(53936002)(9686003)(229853002)(6306002)(2906002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5312;H:VI1PR04MB4480.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z+wQJdg3PzEmrbgWKrvWLwyQz7kLXO0o54lB3/oq8HEKGTnImW8WhwdPJlYAxCEujjq5Kehg9ZIMIkYrwihzLj0PeqA+qa35+NekqDSfr3uSXDPuv4/P8WM/WdfEetEc7/nLFbxvWde1YjEXvKyi1Mn0DKRH/yqUfSOpsmGSYia/hg9w2W935m6bicYegGoimMr/lYg8e7Dh9JJ/ltyB0ddb5ag0PltSSalChjpbSHTe0oT6WvBRATnFVWUNW7hN1N2BW9IYJveXH8f62SgvG2z7qd06mK77YzFmb3mN0Qj5B6K8wZqWUdb9IrEwxCe6YGNdPpP9PC8TJH3lXNmahfPbnPO9cXvYxaq/a5PykRJbyG+ZXbG7RV75dHHsrL+h0sK+oJT5DsN3ZN/upB5Qgmy04PPmLuLzsvh8L0Ub19I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f3295b-854d-411c-2029-08d677a12270
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 08:45:26.9623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, January 11, 2019 2:10 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
> mark.rutland@arm.com; robin.murphy@arm.com; will.deacon@arm.com;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] arm64: dts: ls1088: add smmu device node
>=20
> On Tue, Dec 18, 2018 at 04:51:58AM +0000, Nipun Gupta wrote:
> > This patch also adds the iommu-map property in fsl-mc node, so
> > that fsl-mc can use iommu.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > ---
> > These patches are based over:
> > git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git,
> > as there are couple of changes related to fsl-mc bus in this tree:
> >
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor
> e.kernel.org%2Fpatchwork%2Fpatch%2F1021020%2F&amp;data=3D02%7C01%
> 7Cnipun.gupta%40nxp.com%7C32db0a82c058487b3b9b08d677a0686c%7C686
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636827928177177279&amp;s
> data=3DowEtCHfG%2Bc4pjO5lkb0TODYs6xORn2jXgLv4qJ95u8o%3D&amp;reser
> ved=3D0
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 92
> +++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > index de93b42..dec0c2d 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > @@ -576,6 +576,7 @@
> >  			reg =3D <0x00000008 0x0c000000 0 0x40>,	 /* MC portal
> base */
> >  			      <0x00000000 0x08340000 0 0x40000>; /* MC
> control reg */
> >  			msi-parent =3D <&its>;
> > +			iommu-map =3D <0 &smmu 0 0>;	/* This is fixed-up by
> u-boot */
> >  			#address-cells =3D <3>;
> >  			#size-cells =3D <1>;
> >
> > @@ -641,6 +642,96 @@
> >  				};
> >  			};
> >  		};
> > +
> > +		smmu: iommu@5000000 {
>=20
> We are trying to keep the nodes with unit-address sorted in the address.
> I move the node to where it should be, and applied both patches.

Thank you.

