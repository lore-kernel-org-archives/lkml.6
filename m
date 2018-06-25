Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99CCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D2E2564A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wJo1tozT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D2E2564A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeFYI7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:59:36 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:28406
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752576AbeFYI7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st7HQ1F6d9YJxiCQ1vmzDPZrlsRw/qnuOcYkhRIMwKU=;
 b=wJo1tozTtfvStcwka4uFn/risSGTWMy8PRxldc0eNOvZADAZZGdixOP8sr7DtYjnn1ibupGjY0VgXvmxHeYoE3jI60IS8odeZtnK8P+8C6s7XSrPphi7G9c9EHIXHumb8IJAoXSmSV7+8qwPPxdzXscu/EJLuVM5bWu98YbbajI=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2208.namprd02.prod.outlook.com (10.168.243.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Mon, 25 Jun 2018 08:59:33 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 08:59:33 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [[LINUX PATCH v10] 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Thread-Topic: [[LINUX PATCH v10] 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
Thread-Index: AQHUCSscPFU/PMrwLUOEuJ/raMMjQaRv5MQAgADNwlA=
Date:   Mon, 25 Jun 2018 08:59:32 +0000
Message-ID: <MWHPR02MB2623DE62699977CB69AE0DC9AF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180624224014.125cf0bc@bbrezillon>
In-Reply-To: <20180624224014.125cf0bc@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2208;7:15wW0kHQnFp3dvD8fIUS0eFQfxPjm6n0wSmgziJwOGNM4tgU93orazjNoHg3kyIsBV6x8eFFoG2W4RcQ+4MMrJryeRuhOPuX7BmfUgxYeUb/jBt+oihcI+nxhzCzyBqHE2fwLc7wQ3/0XAhEPUtOUGWvEFClslNLI1hq+PutXUD2ySu3HM/MopQfHMp0v/WKSmh1hRPNm9t1MtxTSjfq5oPfYI9frj6ea+ERMCoIoEz5hoA0QLOc4OE5j4Ueq1H1
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(396003)(366004)(376002)(13464003)(189003)(199004)(7416002)(5660300001)(25786009)(97736004)(14454004)(3660700001)(4326008)(11346002)(81166006)(81156014)(446003)(39060400002)(3280700002)(8676002)(102836004)(476003)(8936002)(6246003)(55236004)(186003)(53936002)(486006)(26005)(86362001)(2900100001)(6306002)(6916009)(53546011)(9686003)(105586002)(229853002)(55016002)(59450400001)(6506007)(106356001)(74316002)(54906003)(33656002)(7736002)(305945005)(99286004)(478600001)(966005)(5250100002)(316002)(6436002)(66066001)(7696005)(6116002)(2906002)(3846002)(68736007)(76176011)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2208;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 95953c84-02fb-4f72-b08a-08d5da79f810
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2208;
x-ms-traffictypediagnostic: MWHPR02MB2208:
x-microsoft-antispam-prvs: <MWHPR02MB2208E0AA1198745C7EC74E73AF4A0@MWHPR02MB2208.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(35073007944872)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2208;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2208;
x-forefront-prvs: 0714841678
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tcTTW7elCEG5I0GFkvkUf+cbcRYfzpTP6pNlAxa9ToeSMdwpakIlXjSlOcx12735ue7Hk2IHGflx5KYnGQTLfP7DGIQaYR0wGIMTpNJmeOT73BgogNAL4vfdnLGFt/K0PO8NYGz7nmGEDyBeY6sBuupyY5sUtVVbbHV5W+UuNoYXSWsg1Dqw740zIgOnUCkIQqK+Qn37cEkK5UXeGq9CoNrzyxf4557cAhNHoMrE5T5a4YSukZ4BtlUGtT3acG+C+B53U4rcy2kMkiqr4efGgsgfliFrfvP/oZ/2ukOReixe39fIbIOY+zu5Vh/uNe0HyfAsoyIsRjeKNyb299Ep+o++4TCCKpw7pYGn+V6PPiM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95953c84-02fb-4f72-b08a-08d5da79f810
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 08:59:33.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, June 25, 2018 2:10 AM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> marek.vasut@gmail.com; f.fainelli@gmail.com; mmayer@broadcom.com; rogerq@=
ti.com;
> ladis@linux-mips.org; ada@thorsis.com; honghui.zhang@mediatek.com;
> miquel.raynal@bootlin.com; nagasureshkumarrelli@gmail.com; Michal Simek
> <michals@xilinx.com>; linux-mtd@lists.infradead.org; linux-kernel@vger.ke=
rnel.org
> Subject: Re: [[LINUX PATCH v10] 1/4] Devicetree: Add pl353 smc controller=
 devicetree
> binding information
>=20
> Hi Naga,
>=20
> Subject prefix should be "dt-bindings: memory: " not "Devicetree: ".
Ok, I will change it.

>=20
> On Thu, 21 Jun 2018 12:12:28 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > Add pl353 static memory controller devicetree binding information.
> >
> > Signed-off-by: Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com>
> > ---
> > Changes in v10:
> >  - Corrected the typos like "should be" to "Must be" and nand to NAND e=
tc..
> >  - Removed padding to describe size-cells and address-cells
> >  - Removed timing parameters from DT, and added ->setup_data_interface(=
) hook
> >    to the driver to read the SDR timings
> >  - Modified label name from "pl353smcc_0: pl353smcc@e000e000" to
> >    "smcc: memory-controller@e000e000" as suggested by Miquel Changes
> > in v9:
> >  - Addressed below comments given by Randy Dunlap and Miquel Raynal
> >  - Typos
> >  - Added extra documentation that explains the HW ECC limitation with S=
MC
> >    (Comments given to v8: https://lkml.org/lkml/2018/3/22/23)
> > Changes in v8:
> >  - None
> > Changes in v7:
> >  - Corrected clocks description
> >  - prefixed '#' for address and size cells Changes in v6:
> >  - None
> > Changes in v5:
> >  - Removed timing properties
> > Changes in v4:
> >  - none
> > Changes in v3:
> >  - none
> > Changes in v2:
> >  - modified timing binding info as per onfi timing parameters
> >  - add suffix nano second as timing unit
> >  - modified the clock names as per the IP spec
> > ---
> >  .../bindings/memory-controllers/pl353-smc.txt      | 41
> ++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> > new file mode 100644
> > index 0000000..8b4c65e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/pl353-smc.t
> > +++ xt
> > @@ -0,0 +1,41 @@
> > +Device tree bindings for ARM PL353 static memory controller
> > +
> > +PL353 static memory controller supports two kinds of memory
> > +interfaces.i.e NAND and SRAM/NOR interfaces.
> > +The actual devices are instantiated from the child nodes of pl353 smc =
node.
> > +
> > +Required properties:
> > +- compatible		: Must be "arm,pl353-smc-r2p1"
> > +- reg			: Controller registers map and length.
> > +- clock-names		: List of input clock names - "ref_clk", "aper_clk"
> > +			  (See clock bindings for details).
> > +- clocks		: Clock phandles (see clock bindings for details).
> > +- address-cells		: Must be 1.
> > +- size-cells		: Must be 1.
> > +
> > +Child nodes:
> > + For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash"
> > +drivers are supported as child nodes.
> > +
> > +for NAND partition information please refer the below file
> > +Documentation/devicetree/bindings/mtd/partition.txt
> > +
> > +Example:
> > +	smcc: memory-controller@e000e000
> > +			compatible =3D "arm,pl353-smc-r2p1"
> > +			clock-names =3D "memclk", "aclk";
> > +			clocks =3D <&clkc 11>, <&clkc 44>;
> > +			reg =3D <0xe000e000 0x1000>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			ranges;
> > +			nand_0: flash@e1000000 {
> > +				compatible =3D "arm,pl353-nand-r2p1"
> > +				reg =3D <0xe1000000 0x1000000>;
> > +				(...)
> > +			};
> > +			nor0: flash@e2000000 {
> > +				compatible =3D "cfi-flash";
> > +				reg =3D <0xe2000000 0x2000000>;
> > +			};
> > +	};
>=20
> I had a look at the PL353 TRM, and the block diagram looks very similar t=
o the atmel
> EBI/SMC one. AHB/AXI memory ranges that are used to interact with the mem=
ories are
> assigned CS ids, which can then be used to configure the timings (and oth=
er kind of stuff). I
> think you should have #address-cells =3D <2>, the first cell encoding the=
 CS id, and the second
> one, the memory offset within the reserved range for this CS id.
> See the atmel,ebi binding [1].
>=20
To my previous patch, as per your comments, I modified reading timing param=
eters from dts
To nand_setup_data_interface() hook,
But I didn't see the CS implementation as per atmel EBI driver.
Sure, I will update like that and will send v11.

Thanks,
Naga Sureshkumar Relli

> Regards,
>=20
> Boris
>=20
> [1]https://elixir.bootlin.com/linux/v4.18-
> rc2/source/Documentation/devicetree/bindings/memory-controllers/atmel,ebi=
.txt
