Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42471C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BC920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UNlMnqic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BC920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeFTOhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:37:05 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:54851
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752856AbeFTOhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3BLAcUp9ZEAwq5MJCrlHpm9JvC9j5U69dWcb4cO+Jo=;
 b=UNlMnqicLtcGR32RbzXOvSbguF4Br7tOtRZC+R/B4fvgLCIk1dza2X+Kh9XNtK4P/3DnQ5a59W7gPXFK5PGvGNGB2Zg61S35KEgXfuLOdQ2LfhGgo8TVSReoIbzytJOCjXOYnIGlWUVnmh9YATXM92p8D6GXSTf3XPZZWGPjnGk=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB4921.namprd02.prod.outlook.com (20.176.111.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 14:37:01 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 14:37:00 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     'Andrea Merello' <andrea.merello@gmail.com>,
        "'vkoul@kernel.org'" <vkoul@kernel.org>,
        "'dan.j.williams@intel.com'" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "'dmaengine@vger.kernel.org'" <dmaengine@vger.kernel.org>
CC:     "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] dt-bindings: xilinx_dma: add required
 xlnx,lengthregwidth property
Thread-Topic: [PATCH 3/6] dt-bindings: xilinx_dma: add required
 xlnx,lengthregwidth property
Thread-Index: AQHUCHIrvuKZvaHuh0+cb/F15/qdLKRpF5lAgAAeXrA=
Date:   Wed, 20 Jun 2018 14:37:00 +0000
Message-ID: <DM6PR02MB43617C120779E4BF0CF9FBEAC7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-3-andrea.merello@gmail.com>
 <DM6PR02MB43610E55E255E9DA5B9E4630C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB43610E55E255E9DA5B9E4630C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4921;7:PMLlcjti+L8xES2PAjVCZWxTAE2gz9yo0OE8RHtzC5n48LuzrE2HCGFc7o23+twjSyCnt1LrW0HWmANgJ3wemMTOmEVEKlu1h2xA2apDf3KblUwQ393TBbx2bayxliQ+P88nidqQT8Q+jShmKKyH6P5sKiu30a2C2SiInoPO1Qtqpe0pjZSFspwW5uTnXJBPOUKkB5iyH+G31Vf2WpZiQcxi0liM4m19EauzkYXzqtL9f+OTp25gMhp2Jui+3rjP
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(13464003)(2906002)(6506007)(53546011)(229853002)(2940100002)(106356001)(486006)(7696005)(76176011)(966005)(68736007)(3660700001)(6246003)(476003)(3280700002)(105586002)(2900100001)(5660300001)(14454004)(446003)(97736004)(53936002)(11346002)(86362001)(478600001)(5250100002)(4326008)(6116002)(99286004)(8936002)(3846002)(102836004)(25786009)(55236004)(33656002)(26005)(9686003)(186003)(54906003)(55016002)(110136005)(305945005)(81166006)(74316002)(6306002)(81156014)(66066001)(7736002)(8676002)(6436002)(316002)(39060400002)(142933001)(491001)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4921;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: c1a6fe53-5a77-4eaa-9e79-08d5d6bb4898
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4921;
x-ms-traffictypediagnostic: DM6PR02MB4921:
x-microsoft-antispam-prvs: <DM6PR02MB4921AAF8DCF4D5AA3CE596FCC7770@DM6PR02MB4921.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4921;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4921;
x-forefront-prvs: 070912876F
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jWxpqMgjPPhkplluWdUUMvrqkWaHSiilrkTdx6+Qx2bu9u0EHRT74BXowTAh+2jnp9CjCzlMpeTkAXP0hcm11sH4s0mSJTmhQ9Jx4j8vIeJqzCAPz9MBCJjj1+Gy433RGRDakIeWe9xWJL7ZXlY31TXI57KiK+zL+ZWbmsenCTfbnF13IeXUYrOK9Nch0ay9IQUgIGrwskv/MMfOEk3XZlLplOPdLmG69nRKwic7F/BflNvGxZmRM2n2Q3rXDB9nzVunRFYWSTHjEls84CToAMqabgFp1jaRd4i6nKEVEx1g8lNYB+oY7AUCYyNB4KkqHEDrN/It4Fel/0ddWT09bA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a6fe53-5a77-4eaa-9e79-08d5d6bb4898
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 14:37:00.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4921
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Radhey Shyam Pandey
> Sent: Wednesday, June 20, 2018 7:13 PM
> To: Andrea Merello <andrea.merello@gmail.com>; vkoul@kernel.org;
> dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 3/6] dt-bindings: xilinx_dma: add required
> xlnx,lengthregwidth property
>=20
>=20
> > -----Original Message-----
> > From: dmaengine-owner@vger.kernel.org [mailto:dmaengine-
> > owner@vger.kernel.org] On Behalf Of Andrea Merello
> > Sent: Wednesday, June 20, 2018 2:07 PM
> > To: vkoul@kernel.org; dan.j.williams@intel.com; Michal Simek
> > <michals@xilinx.com>; Appana Durga Kedareswara Rao
> > <appanad@xilinx.com>; dmaengine@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > Andrea Merello <andrea.merello@gmail.com>
> > Subject: [PATCH 3/6] dt-bindings: xilinx_dma: add required
> > xlnx,lengthregwidth property
>=20
> dt-bindings: dmaengine: xilinx_dma
>=20
> Please also include DT folks.
> >
> > The width of the "length register" cannot be autodetected, and it is no=
w
> > specified with a DT property. Add DOC for it.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.tx=
t
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > index a2b8bfaec43c..acecdc5d8d47 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > @@ -36,6 +36,8 @@ Required properties:
> >
> >  Required properties for VDMA:
> >  - xlnx,num-fstores: Should be the number of framebuffers as configured=
 in
> > h/w.
> > +Required properties for AXI DMA:
> > +- xlnx,lengthregwidth: Should be the width of the length register as
> > configured in h/w.
>=20
> One suggestion to be inline with IP property naming we can rename
> this prop to "xlnx,sg-length-width"? Please take a look at Xilinx tree
> we have this feature added in the master branch. It would be good
> to consolidate both implementations and upstream. Let me know
> if there are any followup queries.

It should be ok to cherrypick 3/6 and 4/6 (xlnx,sg-length-width)
from Xilinx tree and include it in your v2 patch series.=20

>=20
> >
> >  Optional properties:
> >  - xlnx,include-sg: Tells configured for Scatter-mode in
> > --
> > 2.17.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

