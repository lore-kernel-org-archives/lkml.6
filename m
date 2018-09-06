Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD0C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F23B206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MjYBxXZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F23B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIFLmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:42:24 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:35555
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbeIFLmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwbsuvO9edtoheWQHgET9oUtJuQFGmHOT03jdsVvMwY=;
 b=MjYBxXZlw0c3tzbh4MbO4NYYxJJrxYuL1VRbwdNwf00w0pcCI7+a1iGJFwfTMOYk4P8bzc+QtwyaZReWnAvFCViduVC+8i7j6CXlYie+BwrKF1qDnxteZhf2F0nQ3tlRqHjinzjdhjolBvjCJEYj7AnhJhakX9T8Z8J+2Sh6RQk=
Received: from AM0PR04MB4052.eurprd04.prod.outlook.com (52.134.125.22) by
 AM0PR04MB4929.eurprd04.prod.outlook.com (20.176.215.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Thu, 6 Sep 2018 07:08:16 +0000
Received: from AM0PR04MB4052.eurprd04.prod.outlook.com
 ([fe80::1125:c5bd:f992:acf7]) by AM0PR04MB4052.eurprd04.prod.outlook.com
 ([fe80::1125:c5bd:f992:acf7%3]) with mapi id 15.20.1101.019; Thu, 6 Sep 2018
 07:08:16 +0000
From:   Jagdish Gediya <jagdish.gediya@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
CC:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
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
Subject: RE: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Thread-Topic: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Thread-Index: AQHUQRXptbaEytkho0GER5HdTLKx9aTeVfEAgAHCeoCAAsT8IA==
Date:   Thu, 6 Sep 2018 07:08:16 +0000
Message-ID: <AM0PR04MB4052840603E71673747DFA7B90010@AM0PR04MB4052.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
        <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
 <20180904144627.1de264b6@bbrezillon>
In-Reply-To: <20180904144627.1de264b6@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jagdish.gediya@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4929;6:8Kd9CnaDbCh2ovpn3lIF2DbbD5h4DFsDUsoiq5GJEOlW+at3Tqm/anPtCQ/gziw+kP9qmMc/TsXYqArYI7XXr+SrEq25SSIg9QJXh4I8kCQiFDn4J8ahe9DVyTzS/6Ja7Vbj/StQdCR27o20e/hw36awg2Muft+C2LYP+5cZBqZ0RZCvmZBGZA4Y/ONJw3RshwFBeObDxAC1pxl5KR/KjAzpyTr1Qy3BgmFeF2cJnCh/Vvt9YIVxBtm4BpR1hJcgkYcdyEM3AigVActuyGQnmXfGce8dAeGLBHkcWTP2KBWOy579vcgxZubPwxwLu4fXR7uocr1v8L6GUA2x7MqzfcxB80Bbjof/ue0ccuqbmQt9CRvl+EG1U6994x5MLDNc32zRiCaLZUJY4bSBsbKNM6Tl52fq5xVXVsA8gsOz7elXeoXUiPJdMvZOGvBrLOrWauh1iWI1/TVk4O4SHhHiDA==;5:hGYoRQyuFrKfPsykwlio64pzHqkwXn71Ds/57ORJcfEHeki4E/XKTXtlWOpTHKg027er8cSby6rFLE7ENG1Pn+LBZ5jtFnp56lwhVcJPlARB9iNsohW01aOIP9/Xe0VRXlFdC1i8mpo5UgOQe5wXEWPDGuLYHB98ZiLFT/wzuMY=;7:o55gxE/Wu4zDTLMppYIlZdf3nUwdoLDva2sqt3NKW1PoPyBLWnKr3XDd2VdwLAvJblblaMSyC45eFlgukiMY99QG9dLU1+VS5UScFcnOydXoiC85pMKUo3Ic8cYGmQXX32ug+cuzWChoX6pDaZu8warWT+M0RGVXCFW+S14uQcqUYZnVlyPJugVt03iHHK8bKe+YgLcAW9iR+S9P2LCX0oT2rIJ+Uu8qTPgRcwHORWaNXf9CDGcKpDTbA79OJeJr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f9ad13ba-7c55-44bb-f6d4-08d613c784a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4929;
x-ms-traffictypediagnostic: AM0PR04MB4929:
x-microsoft-antispam-prvs: <AM0PR04MB492948FE4A1802B97A660FC090010@AM0PR04MB4929.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:AM0PR04MB4929;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4929;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(366004)(396003)(13464003)(199004)(189003)(2906002)(305945005)(7736002)(97736004)(106356001)(110136005)(33656002)(105586002)(316002)(6636002)(54906003)(68736007)(7416002)(5660300001)(81156014)(81166006)(86362001)(45080400002)(575784001)(5250100002)(9686003)(53936002)(6306002)(25786009)(4326008)(6246003)(39060400002)(99286004)(55016002)(74316002)(6436002)(8936002)(93886005)(2900100001)(8676002)(478600001)(229853002)(3846002)(6116002)(66066001)(446003)(76176011)(14454004)(102836004)(53546011)(26005)(486006)(186003)(6506007)(7696005)(256004)(11346002)(44832011)(476003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4929;H:AM0PR04MB4052.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wP+mSyrdRYKOC72AW5JVx1/1yp3VqbWbAl304ne4AzW/WnwfTD1BsSJ9oiZxGoOHPYi2caoSLmXT86v/nn0+PqolTUntu0XIAMgl7ArwXogrjrGMOBgZtnRccamApLR8RSuUfLrTA5ouRnEO75k46nfX0j514Xvn2KTRWqw7T7Xq0s0eSY6ZLpKohBocNO3k4x1tuJgH4YjQKWn5UsTyCGq0OC3iPIz4uoj0YippUn6xHue5MzhoxOf5D8r8j+kAPtUfMeyMB717iYzmdWYqvhrfP6in1BXlVm6gM28F33tLpYdtYp21uGSCUjUSwcOBnEyVzdrW/+QZfh5CoQJrw+UEi0ytFc8o1RR7EgOm41o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ad13ba-7c55-44bb-f6d4-08d613c784a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 07:08:16.3258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Currently FlexSPI controller is present in ARM SoC but NXP is coming with P=
owerPC SoC with same FlexSPI controller.

We are trying to use same binding as defined in this patch-set(tested on AR=
M64 processors) for PowerPC.
Unfortunately, It is showing issue when driver tries to parse 'fspi_mmap'.

We did some investigation and figured out that for ARM device trees Periphe=
rals nodes inside 'soc' node have absolute addresses. For in general NXP's =
PowerPC device trees, Peripheral nodes have the relative addresses to the u=
nit-address of the parent 'soc' node. =20

This creates issue for PowerPC if we follow implementation in this patch-se=
t.=20

Example of device tree used for upcoming PowerPC SoC with FlexSPI controlle=
r.

soc@f8000000 {
	ranges =3D <0x0 0x0 0xf8000000 0x4000000>;
	.
	fspi0: flexspi@20c0000 {
		compatible =3D "nxp,XXX-fspi";
		reg =3D <0x20c0000 0x10000>, <0xC0000000 0x10000000>;
		reg-names =3D "fspi_base", "fspi_mmap";
		.
		.
	}
 }=20

As we can see, Final address of 'fspi_base' (0xf8000000 + 0x20c0000) falls =
into the parent 'soc' range(CCSR) but=20
for 'fspi_mmap', It is outside of 'soc' range(CCSR). It creates issue when =
driver tries to parse 'fspi_mmap'.

As per definition of ranges, this field can't be used to solve this problem=
.=20
Please suggest how to implement the "fspi_mmap"(memory mapping address and =
length) in case of PowerPC.

Thanks,
Jagdish

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Boris Brezillon
> Sent: Tuesday, September 4, 2018 6:16 PM
> To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexS=
PI
> driver
>=20
> On Mon, 3 Sep 2018 09:54:08 +0000
> Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:
>=20
> > Dear Yogesh,
> >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > owner@vger.kernel.org> On Behalf Of Yogesh Gaur
> > > Sent: Friday, August 31, 2018 4:00 PM
> > > To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > > devicetree@vger.kernel.org
> > > Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > linux- arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> > > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh
> > > Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP
> > > FlexSPI driver
> > >
> > > Add binding file for NXP FlexSPI driver.
> > >
> > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > ---
> > >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42
> > > ++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-
> > > fspi.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > new file mode 100644
> > > index 0000000..9f07116
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > @@ -0,0 +1,42 @@
> > > +* NXP Flex Serial Peripheral Interface (FSPI)
> > > +
> > > +Required properties:
> > > +  - compatible : Should be "nxp,lx2160a-fspi"
> > > +  - reg :        First contains the register location and length,
> > > +                 Second contains the memory mapping address and
> > > +length
> >
> > Why are we overriding reg property.  Is there any special requirement.
> >
> > Can we use "reg" and "ranges" property in device tree.
> > Here "reg" represents controller registers and "ranges" represent the
> memory address of flash.
>=20
> No, ranges is not used for that. It's used when you need to convert from =
one
> address space to another, which is not what you're describing here. Check
> section 2.38 of this document [1] for more details.
>=20
> [1]https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fe
> linux.org%2Fimages%2Fc%2Fcf%2FPower_ePAPR_APPROVED_v1.1.pdf&amp;
> data=3D02%7C01%7Cjagdish.gediya%40nxp.com%7C5bdb57713bd4403a39e90
> 8d6126472a0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63671
> 6619958727753&amp;sdata=3DTB4mbWEm0opk58oPAVEOQFM0xeAFxCsqdzw
> 37BPuE3A%3D&amp;reserved=3D0
