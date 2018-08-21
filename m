Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52AD21735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tgEbhQkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52AD21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeHUJHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:07:53 -0400
Received: from mail-by2nam01on0063.outbound.protection.outlook.com ([104.47.34.63]:11584
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbeHUJHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53mD9Dh9TaNRpGDlkNwGcU6BoQ/yDwvjF14CPA6ieBw=;
 b=tgEbhQkIXXZQ5V5NPxBUSsbUKNgOQOdUFdx7DgTybTCew/g9mNaiBh1tGx6/83r3IzEaGHNLa1my4TXCXFvRo5AMYU3DUCPvcjnzfaZFYMRHxX9lM4s9OQiZEtBbMBLqBg0Gsw5fucrtj3TMd6JE813IIui0OvmgloCGj8kfHkI=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3213.namprd02.prod.outlook.com (10.164.133.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.19; Tue, 21 Aug 2018 05:47:20 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68%2]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 05:47:18 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: RE: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Topic: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Index: AQHUNiz1pd9TJsD6BkCdX9soxsgc9aTIl58AgAEHRSA=
Date:   Tue, 21 Aug 2018 05:47:18 +0000
Message-ID: <MWHPR02MB2623F315C6D4C9775CDA08D8AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180820143324.61af9027@bbrezillon>
In-Reply-To: <20180820143324.61af9027@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3213;6:mIigh9W8mB2gET1K7s1QuutWFtSIYL3KIuJyCnsx/5lC/Z570uyZt14+D+1Jj1AqUcw4LH+nscZQM6MrPhvWIRCy9dCzmnaHdb6MThUAie+h31uUJqBMn3Zdq5ETqIht5r/IjbKPgaFSvG+lLC0bMvm1aJngjC55ZIkoAQY74XOk0f8+v7aWbaj57pEBnSqbIXFwxoj1UMM327MO6CzDY9WjD1EGxSrLCQEMLRildmZmOi0KozBnVRYNOwvQRga0klqO9XYMzbS3DMESMthbb0Uw5CMhAsn4n2CUb3NXnaQK8IzamSIwVWIDKYkqw7VXxsFQSCweCu/8EAxsmmsPAIbNjVZ6/b1Q4nIXZyHVE6fqwar/dO8n3q8bmptrqcBdGhA56NcsXb7gcNtatkc9QVPvp9djapceAB27KEK73B6YTPvdm2wwmFgHR/Ldg0TRQT91fSrlGaqTfrt2Uj59Dw==;5:IrVBHQMEQXmy0xm41S4gb/x987r8f6UF37vS+m6aucjDaUQUSFy4WiYvXiyLWLr+ZfmZaJTCeSJCXjfd2AF6Av382JZu/w3q6ITbi32BZNileAU4QZ7lR5SJG13CMbzBX5E6D4aKzPfC0uaUYOVz8QUs4wN4jI6XJU7LdufVNSQ=;7:GAU2vBQuSLg45lIfRAl49iay0XERzwm2cE9O8yy1txAx1l0Y4dT/aAD5F55CsbvYt4yu9Vx6Oqhu+SnWzb5jFrYhKOknCpFS2azKnddQGibNjYMQiInU8L3653S1qmi2n3yg3J8gpowaFHY/0SCqSMlTxBZPMCFDruxPRE771T7HWDkAtgETHWjMBePIgGTFXICLOefIVus36tO7k3ijGoLc5vONYtiwFlY72Z+AYtSM+zlMIInneuQE9/cU4YqI
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(13464003)(486006)(5250100002)(9686003)(53546011)(26005)(86362001)(256004)(8676002)(55016002)(14444005)(7696005)(6306002)(6116002)(6436002)(53936002)(217873002)(6506007)(81156014)(316002)(186003)(81166006)(66066001)(446003)(476003)(99286004)(102836004)(11346002)(7416002)(478600001)(5660300001)(3846002)(14454004)(39060400002)(25786009)(4326008)(229853002)(105586002)(2906002)(68736007)(54906003)(74316002)(305945005)(8936002)(2900100001)(6246003)(106356001)(97736004)(7736002)(6916009)(33656002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3213;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 223793f0-42d6-4999-bb59-08d607298ebe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3213;
x-ms-traffictypediagnostic: MWHPR02MB3213:
x-microsoft-antispam-prvs: <MWHPR02MB321318181D7AAD63AA5E7B5DAF310@MWHPR02MB3213.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR02MB3213;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3213;
x-forefront-prvs: 0771670921
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4aCmSY8TkwXprXMyDXrJj3UU5MyGo3Zanl2hBpkg0Li2XZFF/D1RjyWF9dzUJWCVNydHgJdG5vEeShw1CmiVSytwtQ+6ER2zmUhOa88jNIgPH3cu2aMxJccQZDAbqe19sWEsIqsBDxE8D89gWjrAzmwndkI2tA4KhUV2bw9Hvwm6+BIB8889qpQnJmdOayuvJQ1opnoiu/LP7YDr5r4xMt87/Fawo24XqmF1vh5yLGG3icusXKi08IFZ64Lcpw8Jk5JvIATGbkQRI63oK7PcMFINyt3Ar/QmMWV7izeozkKj9CgjM3S86c+D4y1cmzOsB0UAuHXCR+d4oLL4zcUUdf7b6Lh9yP8S4f0VobN52iY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223793f0-42d6-4999-bb59-08d607298ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 05:47:18.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, August 20, 2018 6:03 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; kyungmin.park@samsung=
.com;
> absahu@codeaurora.org; peterpandong@micron.com; frieder.schrempf@exceet.d=
e; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <mich=
als@xilinx.com>;
> nagasureshkumarrelli@gmail.com
> Subject: Re: [LINUX PATCH v10 1/2] dt-bindings: mtd: arasan: Add device t=
ree binding
> documentation
>=20
> On Fri, 17 Aug 2018 18:49:23 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > This patch adds the dts binding document for arasan nand flash
> > controller.
> >
> > Signed-off-by: Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com>
> > ---
> > Changes in v10:
> > - None
> > Changes in v9:
> > - None
> > Changes in v8:
> > - Updated compatible and clock-names as per Boris comments Changes in
> > v7:
> > - Corrected the acronyms those should be in caps changes in v6:
> > - Removed num-cs property
> > - Separated nandchip from nand controller changes in v5:
> > - None
> > Changes in v4:
> > - Added num-cs property
> > - Added clock support
> > Changes in v3:
> > - None
> > Changes in v2:
> > - None
> > ---
> >  .../devicetree/bindings/mtd/arasan_nand.txt        | 38 ++++++++++++++=
++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mtd/arasan_nand.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > new file mode 100644
> > index 0000000..234d7ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > @@ -0,0 +1,38 @@
> > +Arasan NAND Flash Controller with ONFI 3.1 support
> > +
> > +Required properties:
> > +- compatible:		Should be "xlnx,zynqmp-nand" or "arasan,nfc-v3p10"
>=20
> In your example it's not an "or" since both are defined.
In our previous discussion (https://lore.kernel.org/patchwork/patch/748901/=
)
We decided to have compatible strings like " compatible =3D "<soc-vendor>,<=
ip-revision>", "arasan,<ip-revision>";"
So it should be either of these.
so I will write something like below
"Possible values are  "xlnx,zynqmp-nand"=20
			"arasan,nfc-v3p10"
And in example I will mention any one compatible.
Is it ok?
>=20
> > +- reg:			Memory map for module access
> > +- interrupt-parent:	Interrupt controller the interrupt is routed throu=
gh
> > +- interrupts:		Should contain the interrupt for the device
> > +- clock-name:		List of input clocks - "sys", "flash"
>=20
>      clock-names
Ok, will correct it in next version.
>=20
> > +			(See clock bindings for details)
> > +- clocks:		Clock phandles (see clock bindings for details)
> > +
> > +Optional properties:
> > +- arasan,has-mdma: Enables DMA support
>=20
> Can't you detect that based on the compatible (or thanks to a register). =
If it's something you
> choose when configuring the IP and can't detect at runtime I guess it's f=
ine.
There is no way to select DMA when configuring the IP.
But it has internal DMA and there is a register to select PIO or DMA while =
starting a transfer.
So if user really don't want DMA, then we will never set DMA in the code ba=
sed on DT property.
>=20
> > +
> > +For NAND partition information please refer the below file
> > +Documentation/devicetree/bindings/mtd/partition.txt
> > +
> > +Example:
> > +	nand0: nand@ff100000 {
> > +		compatible =3D "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
> > +		reg =3D <0x0 0xff100000 0x1000>;
> > +		clock-name =3D "sys", "flash"
> > +		clocks =3D <&misc_clk &misc_clk>;
> > +		interrupt-parent =3D <&gic>;
> > +		interrupts =3D <0 14 4>;
> > +		arasan,has-mdma;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>
> > +
> > +		nand@0 {
> > +			reg =3D <0>
> > +			partition@0 {
> > +				label =3D "filesystem";
> > +				reg =3D <0x0 0x0 0x1000000>;
> > +			};
>=20
> Hm, not sure you need to define partitions in this example, but if you do=
, please define your
> partitions in a 'partitions' subnode:
>=20
> 			partitions {
> 				compatible =3D "fixed-partitions";
> 				#address-cells =3D <1>;
> 				#size-cells =3D <1>;
>=20
> 				partition@0 {
> 					reg =3D <0x0 0x1000000>;
> 					...
> 				};
> 				...
> 			};
>=20
> > +			(...)
Ok, just now I saw Documentation/devicetree/bindings/mtd/marvell-nand.txt, =
I will update it accordingly in  next version.
> > +		};
> > +	};


Thanks,
Naga Sureshkumar Relli.
