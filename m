Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91D4C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A08204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1+DzCVp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A08204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeIMXB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:01:57 -0400
Received: from mail-eopbgr690040.outbound.protection.outlook.com ([40.107.69.40]:26344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbeIMXB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tate2hFYfTE0+CUdP2MHIkRrsiAwF4i3ok8IgnISPLg=;
 b=1+DzCVp057hSLLtIltUPmVOi18l95VRr20V3IRS8aJaqLHji7Ga+VnWGKTeydVWiXTCaJxmBh1kf2N4+rf5zKAVH9vT4wBnKnqXuT+7P2KH+tsbemQ7xI/0X9w1T0/OMsfHk4b5s2NAXGlRbWpHZH3lD65jXzuum1cBffWBpwcE=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1367.namprd02.prod.outlook.com (10.161.171.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.15; Thu, 13 Sep 2018 17:51:20 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1122.020; Thu, 13 Sep 2018
 17:51:17 +0000
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
Thread-Index: AQHUNZZmk8R+8nI1IUOvMk0TistbVaTJEcsAgCWWaUA=
Date:   Thu, 13 Sep 2018 17:51:17 +0000
Message-ID: <CY1PR02MB2138C05E97C1EFAEA921CB5CB81A0@CY1PR02MB2138.namprd02.prod.outlook.com>
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
x-originating-ip: [71.202.42.125]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1367;6:PY0t4R3sUj0lPNKIxQzIOIsmtQ0hs99QQ6ZkfmMlqnJfDU8buOiBr/6a+yqoccxJN21GVLkQ2gvJyu4vJPElp/PPoNbD2x9vMMr4ZKh+Ojcym2UU2ZkXAqQMa29/O+kz50m9olwcrl2wCqi8Al58qljeelgCWTPjDPBPv7pId63gDKsyOteTqhKyQUN6vP9g2XB1FhOdPei4PYFINrfgVeuMVGEmgwi1eavqopV6AK5VRiJxl92QvomWwkHeO/v0UlvKl3lilpMRbDlr1oGu91k2BXy47KA5or8cdSSnDel0ns9ABgfMU0fN7gHtC9uQ4rMfTGZjMXqVKhsAAp0+gOy7/uwbukGqcQ+cxg47tv1zcswTDZji2jTpAkEM2mo+4ChF+OcEvyZ2qd5tVKv3ni1oSpfkoG3n8vruMwGIMPg294o8RfKetlhxlIEmuBEYvvPWgypjuGuidqmSNPJ6Ew==;5:CVE8qSsOGdLUnR/jof74h/1JjdeVNE4QCZKlwrot3eEChngDP52FyIP4Z2MIWIVw+SSAbG+prESstV+DJqXNFfd3RRqlI5Nqi6QU62rIJKcLCOfrcjv55SyFFDVrRP+w56naWRWziGOQLPdYOU9jZK346CZdWRLolWz1BBhKTOQ=;7:rzXXiIByLKXGvXxMW6ZuH5aeo1NyNVrajkKPg38XnoACV2TuOLBo4FME997vtfHMrTu+v6WULGvq6cMLniUSGkYkp18aDrJyc+2NVPKN/QWEKAfnn4FJegQhQ1lnBMQ5enJd3LQrousuwqZy8GsTviBEkz0zQYDQltlJ85Vb6vkjWw1FJAcc1tuSfYYl9YMqPvIlIH+5gD84ryVblpjZYOcrHifDWLzFWxpX0NyvCmsXuql0BrOSUt/VPTI87cXc
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(13464003)(8676002)(14454004)(72206003)(105586002)(3846002)(6116002)(106356001)(478600001)(55016002)(54906003)(99286004)(316002)(33656002)(9686003)(53936002)(97736004)(6436002)(229853002)(5250100002)(76176011)(7696005)(4326008)(6246003)(107886003)(39060400002)(25786009)(6506007)(102836004)(53546011)(66066001)(68736007)(476003)(26005)(81166006)(81156014)(446003)(11346002)(256004)(186003)(8936002)(6916009)(486006)(2900100001)(5660300001)(86362001)(74316002)(2906002)(7736002)(7416002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1367;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: a75230a2-cced-424f-6105-08d619a181b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1367;
x-ms-traffictypediagnostic: CY1PR02MB1367:
x-microsoft-antispam-prvs: <CY1PR02MB1367188E94720AB96FACC68AB81A0@CY1PR02MB1367.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(269456686620040)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:CY1PR02MB1367;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1367;
x-forefront-prvs: 07943272E1
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6QzgwvDWKHISJAeIZ4ITj0ElziQST6VIx6+07MO5VT7TuXMV4egTYgOpCOJsjVuVcXjFpz1JBSMSXZ+/36B8GwEk796feYVA+oUZ2GFlz8E3Q5ACjOHHJQlqs+IPvxA992CV3ykNa1SYIqkF2ZpZWz36Gv5Oik2XUGULW7cUukUF6iXEJvGSjOkGVxDEyFknhYuIR0sf2TXFagCgK4Di1Z/y3cW9bo9BQMkV5gfBYz347HZXKCEctHTtkv/gtoM2mgR8Op+t/zoQc9F3z/ExzVxoschpDQnZRMYG49CTvEjmoZfzAUHTcfvNJUMzjGKQ7C01sAv9+jkWwTKEJbv7zEWbH5YOicPnjFeW1ddhE2M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75230a2-cced-424f-6105-08d619a181b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 17:51:17.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1367
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
[Jolly] We have more than one Ids for GPU device. Also they don't have pare=
nt child relationship and hence are defined as flat hierarchy. (shown in ex=
ample below)

Thanks,
Jolly Shah

>=20
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
