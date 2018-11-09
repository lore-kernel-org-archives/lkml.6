Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB799C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B9320825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UGUGvMCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B9320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeKIWO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:14:27 -0500
Received: from mail-sn1nam02on0073.outbound.protection.outlook.com ([104.47.36.73]:55921
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727753AbeKIWO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C93v0zIGrDYufXmKfjTad8X7+/UDMPn4kEBavduFtKs=;
 b=UGUGvMCwdIFDhNabS2A8lMEION1Q6TvvyJ/Jr3Hb0hFH1rys6TnnWrjbXz/8JwBVZ+g/QMlQhgSiGZbR/7d2RgRcSQSZmJY0tppEgTbwCuBXDuB7QM2K+juziRIT0a2SuoXnyaqhq66K+ovJLSL/UIbGHD+mgC8NiE2heuFVAkA=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2429.namprd02.prod.outlook.com (10.168.204.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Fri, 9 Nov 2018 12:33:57 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::b072:267e:772b:ec2c%6]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 12:33:56 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Topic: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
Thread-Index: AQHUd+lLNqh5tQSG70at2ta/kVZ5BaVG+ymAgABk50A=
Date:   Fri, 9 Nov 2018 12:33:56 +0000
Message-ID: <MWHPR02MB26235AB9959635CAA1B2B878AFC60@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1541739641-17789-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20181109072857.75e86cb6@bbrezillon>
In-Reply-To: <20181109072857.75e86cb6@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2429;6:5n+KH7RTLTWmROExzrTw9iE9GPuFY+f2yxiC20cDmCJIOt9C9QwfkMvCA1d/RJoT4vFK6lTSD9S21+U2D8C0jzytsMA1F3HU10t18XHWSKuWQiCqYmnScp4ge0u/0ZfExqsPdCsAjRdhqt+O4xnGWLXnT2rt5A1Ou9QrS4EdY3ULizPOpiJ0YJMdOEdcOTjw43CVra/mpyf3ohQl2ZRAbT5WozU5iu1d80gMChzMy7eJfJQgyUgndrV+4y+YpQ/MjwVx18ZwxT2EGAbKrXZbx1fia4nHon62PJApfFwT6EjXZ2kV+Va6oItyAVu0G14WxJehlWRwWz0j6Mw/VotWDL+PJ/rZFpoBEC9Yx844Pg2LoYZ+PMMQwtHK22Xhwz14OyRxLniWciTnXeLnr1ogAywEtPb+Be6WQzy04XFMVG+/80AfhMPqSxDcti+ol/Jy2ISsVUgnzmBKACnGnPZ94w==;5:CwF95nbPBVsvMOS3Pm+8DDeZY2FM5RYXEAn/fDB0l6iaEt15uXmhBFvsDJcQi3qn7sNQgEh5PrbrYNYYdlKlflVvVWG4Bwo0Px+7DG07Yi4DxKAz/1QXvxlShaZmv8EWrVf5MmdV+n00zQPMLvkW+DU4A429Ab6ohwE7wD62FNQ=;7:hYrejbDcFotOglPAteVihF369JwYa43llYo1S+TzOZUnNwL6DZRnXXsO68Iu93GkvKZc51/obIJKxmxYJ7Cc3EbHotS5Dvld3DA4JKIPblAhshPDMwTrHTeEhxK/wCOeL/7pd+KHtN9MkFR8e/FibA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(13464003)(5660300001)(86362001)(39060400002)(256004)(99286004)(7416002)(81166006)(8676002)(14444005)(81156014)(8936002)(97736004)(217873002)(7696005)(71190400001)(106356001)(4326008)(478600001)(68736007)(25786009)(6506007)(76176011)(186003)(26005)(105586002)(53546011)(71200400001)(2900100001)(54906003)(316002)(102836004)(6436002)(33656002)(486006)(7736002)(305945005)(53936002)(55016002)(6116002)(229853002)(66066001)(3846002)(14454004)(2906002)(6916009)(74316002)(6246003)(446003)(476003)(11346002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2429;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: db6efa2c-9ca9-495d-7efe-08d6463f9de6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2429;
x-ms-traffictypediagnostic: MWHPR02MB2429:
x-microsoft-antispam-prvs: <MWHPR02MB24291191C9FF421E70BCAAA3AFC60@MWHPR02MB2429.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2429;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2429;
x-forefront-prvs: 08512C5403
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CvcBYT7VUfwwBmKDCu8PHbx4zpPu1k4Q8cqHRAHPSO70cyVUS7R/rDgxMuTefdcmNlmLfDepRoo/PU60/NEywLTjf14lsAhYF1PPDgai41s/IQ4s1rDPKsjZgkO/Z7Rdd3fT8e8sLGCiGg4W1KNWM7+Vvo1JL/ZavP/WQjOimEGpCUqDa2pUETwwc/gfJpJAAFOn3CABqma7a4y0xa5R0bezUX/vaXMnX8+AfNyES957/K04b58Fl73oMlv4Xwxk71n6hF5r9+EkziiD98FzW3pa4+kMgpHLbb7kuiZV2rDJcUWzGUmR7EtnhlDfVmCLFJR8ZtFDMOSLiDiDkzLJPAp3km1HN1DFB+Y7A+iwgRA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6efa2c-9ca9-495d-7efe-08d6463f9de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 12:33:56.4365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Friday, November 9, 2018 11:59 AM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; Michal Simek
> <michals@xilinx.com>; linux-mtd@lists.infradead.org; linux-kernel@vger.ke=
rnel.org;
> nagasuresh12@gmail.com; robh@kernel.org
> Subject: Re: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device t=
ree binding
> documentation
>=20
> On Fri, 9 Nov 2018 10:30:39 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > This patch adds the dts binding document for arasan nand flash
> > controller
> >
> > Signed-off-by: Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com>
> > ---
> > Changes in v12:
> >  - Removed interrupt-parent description as it is implied as suggested b=
y
> >    Rob Herring
> >  - Added missing ';' as required
> > Changes in v11:
> >  - Updated compatible description as suggested by Boris
> >  - Removed arasan-has-dma property
> > Changes in v10:
> >  - None
> > Changes in v9:
> >  - None
> > Changes in v8:
> >  - Updated compatible and clock-names as per Boris comments Changes in
> > v7:
> >  - Corrected the acronyms those should be in caps Changes in v6:
> >  - Removed num-cs property
> >  - Separated nandchip from nand controller Changes in v5:
> >  - None
> > Changes in v4:
> >  - Added num-cs property
> >  - Added clock support
> > Changes in v3:
> >  - None
> > Changes in v2:
> >  - None
> > ---
> >  .../devicetree/bindings/mtd/arasan_nand.txt        | 32 ++++++++++++++=
++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mtd/arasan_nand.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > new file mode 100644
> > index 0000000..b522daf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
> > @@ -0,0 +1,32 @@
> > +Arasan NAND Flash Controller with ONFI 3.1 support
> > +
> > +Required properties:
> > +- compatible:		Should be "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
> > +- reg:			Memory map for module access
> > +- interrupts:		Should contain the interrupt for the device
> > +- clock-name:		List of input clocks - "sys", "flash"
> > +			(See clock bindings for details)
> > +- clocks:		Clock phandles (see clock bindings for details)
> > +
> > +Required properties for child node:
> > +- nand-ecc-mode: see nand.txt
>=20
> Why is it required? Can't you fallback to HW when this prop is missing?
Yes, we can.
Do you want me to update that in driver now?=20
Looks like you have some comments in driver as well, so while addressing th=
ose I will update the code to fallback to HW ECC when=20
It is missing.

> Oh, and reg is not listed in the required props.
Which reg?
I already mention this " reg:	Memory map for module access " in required pr=
operties.

Thanks,
Naga Sureshkumar Relli
>=20
> > +
> > +For NAND partition information please refer the below file
> > +Documentation/devicetree/bindings/mtd/partition.txt
> > +
> > +Example:
> > +	nfc: nand@ff100000 {
> > +		compatible =3D "xlnx,zynqmp-nand", "arasan,nfc-v3p10";
> > +		reg =3D <0x0 0xff100000 0x1000>;
> > +		clock-name =3D "sys", "flash";
> > +		clocks =3D <&misc_clk &misc_clk>;
> > +		interrupt-parent =3D <&gic>;
> > +		interrupts =3D <0 14 4>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		nand@0 {
> > +			reg =3D <0>;
> > +			nand-ecc-mode =3D "hw";
> > +		};
> > +	};

