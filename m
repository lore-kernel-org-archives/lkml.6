Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE32C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE09B208A1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IfnnGySk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE09B208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHYB6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:58:41 -0400
Received: from mail-eopbgr710048.outbound.protection.outlook.com ([40.107.71.48]:6694
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726720AbeHYB6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZdYx+6nJpi+hhQMMWkflVZeyRNjSZh5uURISmbXKZI=;
 b=IfnnGySkWYGcOyEnQCmW9P6ZDAHEMIEyODPsTdxJYKTWpMBcaGT9VgE4VQbbtevMM2X9+0Mt4TNQkGjHk7MnOEUQ4Ol1lhG3la2d8VN6q2CeCy1d20PUkzmxr4pONxuPIGBNL9aFdQ99SLhqY2sS1QCEIrrkPaj1OmNchcVnZJ0=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1119.namprd02.prod.outlook.com (10.163.15.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Fri, 24 Aug 2018 22:22:05 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::8e7:cd9d:9f7b:4539]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::8e7:cd9d:9f7b:4539%2]) with mapi id 15.20.1059.023; Fri, 24 Aug 2018
 22:22:03 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>
Subject: RE: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
 bindings
Thread-Topic: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
 bindings
Thread-Index: AQHUNZZmk8R+8nI1IUOvMk0TistbVaTJEcsAgAZy97A=
Date:   Fri, 24 Aug 2018 22:22:03 +0000
Message-ID: <CY1PR02MB2138CD14431A976812492D0BB8360@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
 <1534447304-12919-2-git-send-email-jollys@xilinx.com>
 <20180820194628.GA26783@bogus>
In-Reply-To: <20180820194628.GA26783@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1119;6:rbRvSJ2RZrCU9YbCngWcJylAprCzd/XZEUBWK/avSUIh4+q9Jo12Hh8V2SIQsQuJyv4vSLSHyh8D7En3p9K1JAhK2Hhi2vAdVkjyckrpjcz0dIZU7864ffh1LeAjJC7hC3WmZkPOgG8ibxiQ66aW5rRMCwNjaWGwBSfa4vn4LcqBokp6DFoSLnNomSJCxNtZqg6ry3cYrmPCfQp8PpazIFpO7YvQJE5AmdyA/nsDRK+qOnkQtuMPdGJDnWVN4PndAxnyRBja1485Y1GA/NcIGFQLVdDs/9Ei72T3fhQryWuOKLl1+/12jzCjjgdx2FFNw5Y3pVBAiwCgsyKxWnMIwdZ+a16myKpgMxNf/hU0Znl9gZ3+h+axaIQhkvQl7ggQioJK0cckzfjgeQjakdxweNw9fM2epWxPDsetHDtSTeSPJ766Jw9I4qqODoy54pcMEHEH2YjFBgWJ92cMmLAI8A==;5:2GB+vTLIxLywAKYgWnJfkWpj1GcQQNDq+K7G2jXDJlcqZkWhns8rmtxB7Qkub3/bvL6ttYESTjYl1vefYkj95oMpMILDBh7FZqeBD5WNlBKgloOsdH0e51BKVlG+w/POedSGmx+3OrmPnraM+luTcdUdLVw33JDG0faeCN/3Mbk=;7:z/vyLOqmX4cUjCeqa4ru20jZqM63dIFonmyWH0cGWVHhjA6Urjne081wQjqi6lfHhAjns284hLJpclbQbNmyXXqtyXvOHEBnwh4FsUF/l4fJnNyS0oodZH+i4qxRcrCVxqZ1333R1l/hf+LEowlmDSwNfgTgiuTLQfJo9pYPoeWJ6sbJJ8uDs1nuHWPSY6ueDh7+IyldPWEk8AgOWr9hR4dQtTIkTli1FGZsnZlpXUDwG4ch8GI3DXGDtsKYNcdd
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(13464003)(486006)(6506007)(39060400002)(26005)(68736007)(305945005)(53546011)(107886003)(53936002)(6246003)(186003)(81156014)(97736004)(105586002)(7736002)(2906002)(99286004)(81166006)(9686003)(33656002)(55016002)(476003)(11346002)(6436002)(106356001)(7416002)(7696005)(8676002)(3846002)(102836004)(6116002)(76176011)(54906003)(478600001)(25786009)(86362001)(229853002)(74316002)(5250100002)(446003)(4326008)(66066001)(256004)(2900100001)(6916009)(14454004)(72206003)(8936002)(5660300001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1119;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4556a6bd-4f48-45fb-0963-08d60a10050d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1119;
x-ms-traffictypediagnostic: CY1PR02MB1119:
x-microsoft-antispam-prvs: <CY1PR02MB1119EC90292BDFD0CF54D12DB8360@CY1PR02MB1119.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:CY1PR02MB1119;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1119;
x-forefront-prvs: 07749F8C42
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8mO5Wxq59dT69eEKbi3F7ezjQq+LFr7yczUNY5VQjicV3wxTuOA561DbNM3i1taEs7BnZHIjOL7d5wiEpKd+j1jROfl9TGyrs+DDthKMaqtp/5njXF6hCRXBw1weFdZuHvxVTxcFWVrmhcK5aqjM6+2NZsXRrp5JJdxbDN473nrzLCkfuSnABCblB4S+Um2ZjNgnBGGUyRSx3ac/8OperC3Ih5U234oWruIAU/mzq2N+j3hK/1FXFc0mCEpftl9VpMikrs/fvWYCJ4IR/ORv/veTsp6n+8UZzWs/WfLQKQABDdCcurBzziRLR2yAgw0mZgAI/xJB8s2cd9yfJ6ud/eP6erCs8oCphFyHNVXJXtw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4556a6bd-4f48-45fb-0963-08d60a10050d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 22:22:03.8592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Monday, August 20, 2018 12:46 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org;
> sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> <michals@xilinx.com>; mark.rutland@arm.com; Rajan Vaja
> <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
> bindings
>=20
> On Thu, Aug 16, 2018 at 12:21:42PM -0700, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Add documentation to describe ZynqMP power domain bindings.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 47
> ++++++++++++++++++++++
>=20
> This should be with all the other power domain bindings.
>=20

The firmware node has clock, reset and power domain subnodes. Please sugges=
t the right location for binding.

> >  1 file changed, 47 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > index d215d15..5fa10a0 100644
> > ---
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.txt
> > @@ -64,6 +64,29 @@ Output clocks are registered based on clock
> > information received  from firmware. Output clocks indexes are
> > mentioned in  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
> >
> > +-----------------------------------------------------------
> > +Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
> > +-----------------------------------------------------------
> > +The binding for zynqmp-power-controller follow the common generic PM
> > +domain binding[1].
> > +
> > +[1] Documentation/devicetree/bindings/power/power_domain.txt
> > +
> > +=3D=3D Zynq MPSoC Generic PM Domain Node =3D=3D
> > +
> > +Required properties:
> > + - compatible:	Must be: "xlnx,zynqmp-power-controller"
> > +
> > +This node contains a number of subnodes, each representing a single
> > +PM domain that PM domain consumer devices reference.
> > +
> > +=3D=3D PM Domain Nodes =3D=3D
> > +
> > +Required properties:
> > + - #power-domain-cells:	Number of cells in a PM domain specifier. Must
> be 0.
> > + - pd-id:		Domain identifier as defined by platform firmware.
> > +			This identifier is passed to the PM firmware.
>=20
> Make this a cell for the power domain consumer.
>=20

I am not clear here. Do you suggest to move pd-id property under consumer n=
odes? Right now, consumer nodes use power-domains property as below:

usb0: usb0@ff9d0000 {
                        #address-cells =3D <2>;
	          ...................................................
                        power-domains =3D <&pd_usb0>;
	};

Thanks,
Jolly Shah

> > +
> >  -------
> >  Example
> >  -------
> > @@ -78,5 +101,29 @@ firmware {
> >  			clocks =3D <&pss_ref_clk>, <&video_clk>,
> <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> >  			clock-names =3D "pss_ref_clk", "video_clk",
> "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> >  		};
> > +		zynqmp-power-controller {
> > +			compatible =3D "xlnx,zynqmp-power-controller";
> > +
> > +			pd_usb0: pd-usb0 {
> > +				pd-id =3D <22>;
> > +				#power-domain-cells =3D <0>;
> > +			};
> > +
> > +			pd_sata: pd-sata {
> > +				pd-id =3D <28>;
> > +				#power-domain-cells =3D <0>;
> > +			};
> > +
> > +			pd_gpu : pd-gpu {
> > +				pd-id =3D <58 20 21>;
> > +				#power-domain-cells =3D <0>;
> > +			};
> > +		};
> >  	};
> >  };
> > +
> > +sata0: ahci@SATA_AHCI_HBA {
>=20
> Don't use defines in unit-addresses (or reg for that matter). It's pointl=
ess
> indirection.
>=20
> > +	...
> > +	power-domains =3D <&pd_sata>;
> > +	...
> > +};
> > --
> > 2.7.4
> >
