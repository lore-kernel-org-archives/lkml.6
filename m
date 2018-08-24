Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4402C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413692083A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a1fHkxyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413692083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeHYBvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:51:51 -0400
Received: from mail-cys01nam02on0076.outbound.protection.outlook.com ([104.47.37.76]:40688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726881AbeHYBvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbhodYRlgTBAeSkzn3hpl6TEI5ir3kgwBodQf9UIGkg=;
 b=a1fHkxyk2Kwo2QcjHWXo0BJeO7CzRVBooiZvcbDzVD9Lj64XMUCvL7iH0zWUr3O9GNDt8+099iGviE/FHB5CpBbzeMO6uTzu8RLjQdxH6SYIF7CwNd79WlgudsUHjRW7BtbOzfbxkPQQ+akAkL1nrjNQdkccT/7MRGlV2ukPuyE=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1261.namprd02.prod.outlook.com (10.163.16.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 22:15:15 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::8e7:cd9d:9f7b:4539]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::8e7:cd9d:9f7b:4539%2]) with mapi id 15.20.1059.023; Fri, 24 Aug 2018
 22:15:14 +0000
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
Subject: RE: [PATCH v2 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Thread-Topic: [PATCH v2 1/3] dt-bindings: soc: Add ZynqMP PM bindings
Thread-Index: AQHUNZSEIR4iIXZiTkiqEPwyxjFtnKTJEESAgAACRwCABnFVQA==
Date:   Fri, 24 Aug 2018 22:15:13 +0000
Message-ID: <CY1PR02MB213857834064CF182DA72704B8360@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
 <1534446483-12156-2-git-send-email-jollys@xilinx.com>
 <20180820194057.GA21738@bogus> <20180820194906.GB26783@bogus>
In-Reply-To: <20180820194906.GB26783@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1261;6:BHTkM6cw+gPRw3v7RRH+2auMHmLsc9EP2Td5NCPpRB6RGV+uYZHBcV8LsXKSBk5iNEbm3qcHzzeG4QclFI7BCCrTSfEx2q1Jq66IjzDNBWdrFPCEBbu6aJGrDa2pF1Y798d+d+Nyp7Fwgnnp5LC8K2ZToq7+QMO4Hb0s1waxtti6j0txviy6GqZBaZhQveX8ubIix1WQxk97y3gtajgL4tTSvBMF7KQsKTcHl1rqWk6gzea1Qdyf1r5J+r65sV5GvYtEiUMTguxUllT53b236A2fbp9Syis+r/rIZGaXSXHhsovfYqNsfOF+zdH3AeaHNfbK13kBGvDVmNsH0QMgADXFFLsh9wHvdQ6xUP2HohhMUQiHVA2GKWe6wKgtkewfJ8bkhPCpv+q3znFZxdRqce/L50hWoWU76wLxNFI7e3wNVfIMPhn9UVrwBxf7tsN5v4YoSQ0djC7FkTNXuvf8Qw==;5:u2/4bQa51y0TbnQzpJdRT7K6M3bCzWs1nNYYhR7V7GGcvSTErWw/2ZqPqd738U6S+vQ89/rspXT762UFP+KBS8t2GsO2crSv7JoDi3KNY/rdBQXjWO3PF/4e90JBoKu96tm5uF0iTJv6XPjvRId6GRge3N497iB/cvWGBg4tH9s=;7:Q41q57he8mmMfrCbrJ29N8Rn1nHRRsp6UHYMMnXDp3vEYeZdAn/ChaSatyZTnMqoSSxmwvg/e0yszIu5cjMdywccvJq6ZaEYfJJ73MDBqJLoCZUIDZmBRt3wHx98M9nJBQO5wMEYuNmDVW6M3KHH01bmRxndq1YUkdgRBuAG9u0aMdgpDgFuinxrXTfsuPXhfCjiNt7LuTWtOGn9zEV1Ac7cW8wMVmpRkz4sbXOjJrqzZ3ggOi63RRR0vuJoP06E
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(366004)(376002)(13464003)(189003)(199004)(54906003)(99286004)(186003)(81166006)(76176011)(6246003)(446003)(2906002)(5250100002)(476003)(72206003)(8676002)(478600001)(486006)(11346002)(4326008)(316002)(107886003)(81156014)(25786009)(39060400002)(7696005)(33656002)(86362001)(5660300001)(93886005)(53546011)(6506007)(229853002)(256004)(66066001)(102836004)(53936002)(106356001)(305945005)(7736002)(6916009)(74316002)(68736007)(14454004)(105586002)(8936002)(26005)(2900100001)(3846002)(97736004)(6436002)(6116002)(7416002)(9686003)(55016002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1261;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 16d7ec7e-c259-4990-7ea7-08d60a0f10ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1261;
x-ms-traffictypediagnostic: CY1PR02MB1261:
x-microsoft-antispam-prvs: <CY1PR02MB12615FA72D8EAAC28F2A529EB8360@CY1PR02MB1261.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:CY1PR02MB1261;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1261;
x-forefront-prvs: 07749F8C42
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yMBP9BKCLGfZ3eKdXRZ1KLAbriWvjSww7v3hMzjDqBrEiZgeQLDjumyKO3hv+MYQMstQFFcBKRiUDnHJdBNAyCdIc9e1jOSPws/2czsjhf35MV7gJqU9itZ8YKWH1mxEpaf4+978SBdImbpzDzY4nBnCSUrBOPJj14qnGi8N6NQ8tTh4xtTJhPXHO2rU95BuPsgXZxjmQPItXka3nJO35tk1qC5//cMxHrnvMjTzO/124cutSYP4TX74eN7HqyWnC5LG5HIxxeAcM9q12dxsh7e+xbD0pQTxOYZuUz4FsUnsBkcsRrPP0LaRZV8aayNJROHU4Pt/9bfFk1rOHbWEiU6YUUuxclFRWUWaxphhK+g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d7ec7e-c259-4990-7ea7-08d60a0f10ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 22:15:13.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Monday, August 20, 2018 12:49 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org;
> sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> <michals@xilinx.com>; mark.rutland@arm.com; Rajan Vaja
> <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v2 1/3] dt-bindings: soc: Add ZynqMP PM bindings
>=20
> On Mon, Aug 20, 2018 at 02:40:57PM -0500, Rob Herring wrote:
> > On Thu, Aug 16, 2018 at 12:08:01PM -0700, Jolly Shah wrote:
> > > From: Rajan Vaja <rajan.vaja@xilinx.com>
> > >
> > > Add documentation to describe Xilinx ZynqMP power management
> > > bindings.
> > >
> > > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > > ---
> > >  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16
> ++++++++++++++++
>=20
> Also, this should be located in bindings/power/reset/

Base firmware node has clock subnode too. Do you still suggest to move bind=
ings to "bindings/power/reset/" or keep it=20
under "bindings/firmware" ?

Thanks,
Jolly Shah

>=20
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firm
> > > ware.txt
> > > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firm
> > > ware.txt
> > > index d215d15..cb9a6b7 100644
> > > ---
> > > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firm
> > > ware.txt
> > > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > > +++ firmware.txt
> > > @@ -64,6 +64,17 @@ Output clocks are registered based on clock
> > > information received  from firmware. Output clocks indexes are
> > > mentioned in  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
> > >
> > > +-------------------------------------------------------------------
> > > +- Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
> > > +-------------------------------------------------------------------
> > > +- The zynqmp-power node describes the power management
> > > +configurations.
> > > +It will control remote suspend/shutdown interfaces.
> > > +
> > > +Required properties:
> > > + - compatible:		Must contain:	"xlnx,zynqmp-power"
> > > + - interrupt-parent:	Interrupt controller the interrupt is routed th=
rough
> >
> > interrupt-parent is implied and could be in a parent node, so remove.
> >
> > With that,
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > > + - interrupts:		Interrupt specifier
> > > +
> > >  -------
> > >  Example
> > >  -------
> > > @@ -78,5 +89,10 @@ firmware {
> > >  			clocks =3D <&pss_ref_clk>, <&video_clk>,
> <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> > >  			clock-names =3D "pss_ref_clk", "video_clk",
> "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> > >  		};
> > > +		zynqmp_power: zynqmp-power {
> > > +			compatible =3D "xlnx,zynqmp-power";
> > > +			interrupt-parent =3D <&gic>;
> > > +			interrupts =3D <0 35 4>;
> > > +		};
> > >  	};
> > >  };
> > > --
> > > 2.7.4
> > >
