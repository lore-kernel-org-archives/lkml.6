Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07239C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B242148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 11:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SLl0uh24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B242148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391282AbeHPOjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 10:39:10 -0400
Received: from mail-cys01nam02on0040.outbound.protection.outlook.com ([104.47.37.40]:19444
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbeHPOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 10:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1cd09fkrWlQHHmJYkEwiH2WD7PpITaJP257YPVQJOY=;
 b=SLl0uh24Wdfty2TygDzGoMoS4o0CfENJ90jxOaoM/xSBPEDJ7EknCV+qri6aL3eQf8ZHU3R2cer1d2B2tsAMP1d4TC2HzRbpLrx5FRhegJe6YTs8wmy4u3Sood0c4ZZVE8QIgg0sKNZcyjldArTRmV0mZCLVFGFMLvzytPfzUJ0=
Received: from CY4PR0201MB3619.namprd02.prod.outlook.com (52.132.99.26) by
 CY4PR0201MB3410.namprd02.prod.outlook.com (52.132.98.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.19; Thu, 16 Aug 2018 11:41:03 +0000
Received: from CY4PR0201MB3619.namprd02.prod.outlook.com
 ([fe80::89f3:8315:e747:d23a]) by CY4PR0201MB3619.namprd02.prod.outlook.com
 ([fe80::89f3:8315:e747:d23a%3]) with mapi id 15.20.1038.025; Thu, 16 Aug 2018
 11:41:00 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add binding
 for Xilinx MCDMA IP
Thread-Topic: [RFC PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add binding
 for Xilinx MCDMA IP
Thread-Index: AQHUKPZtIRBmjEQhREKOeeG9VWSlVKS/gYkAgALUDQA=
Date:   Thu, 16 Aug 2018 11:41:00 +0000
Message-ID: <CY4PR0201MB3619B5EE41F221455E78D075C73E0@CY4PR0201MB3619.namprd02.prod.outlook.com>
References: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1533059173-21405-2-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180814161326.GA17341@rob-hp-laptop>
In-Reply-To: <20180814161326.GA17341@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0201MB3410;6:P502mOfWfEg+PbRea/ONdHnYfjYd8K/XSRebjHO+9FtV+QBSAdn5eybtk5pyx5b+SUg5am25at6zLTlfaL0ezZuIUnHbkMIG/ACwqn7I4f1r0g/sLSsc44cWW2D1cmHDAmCL2aIalCDK20HglLhawA5HeSEZRdO6/E0ckaxwFogW/P8EFzqgPX9JPGFKyn0xmruy+rM3OJaGJLMTtfoOA//H8j1DKICAikTZa56dyLFmAUz9VURLVghwAyMsatjzbOJ52oIEaT0gPNWDk1xDTwoQv6JAOmIPExmdb+96bmxtHzpe1XeZHMkph6beFbRIx1x/4NYPbLRiK89O071LmaeWPt/FYavsHKA6cC26yTWlkGfd9+7jI5WwIXihP7IH+nm2P3Ka2VK4Br5krR7BOxeq/IYguKg/S2CtHwNZ1LhjD/mT6wZIhKA2GxN/3uORdoFkojLgwVodpLecuDJv4g==;5:Y3VOeO5o0gc3sBlUEUQrH9k5hM9hQOhaQNpghDM3OgJv+wc2jMSBXWTLZnMZeKmpfJh/JVqNWa4kxrlbPDC2UtWIaI9km0oAfKOOTO8WWO7wweOrzSd8tnlfLmQB1MHsDV+Jpn0BCmg/92889Wj9KYFD7g81r2DwdNfqyy6UmKA=;7:GFQdSHqeLPy4Q3R4wFVrCjesgsXMvXIx94dVikT9qz7R/MNBt0VntAVSZKRstFIJI7MQKI8NGhbZmVJPfXFNpMMBF5kjV35G+mxZjuLSQUumjzFceo+dHd73ehCQwcay7HwKqt88DYH/NCtx4S3BLZ2soLaCTpns9eSg6j2Hj32JlO2P3Oy/IMIk3AcANEYkvOpaDXaiTaNAbadLVV3bxYk/CfNeE1YINFxNDwI4wyOHFtEhGeCRl1qZ3QJzCq/s
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(51914003)(13464003)(53546011)(478600001)(217873002)(68736007)(14454004)(966005)(256004)(14444005)(6506007)(8936002)(8676002)(97736004)(86362001)(316002)(81166006)(81156014)(54906003)(2900100001)(106356001)(7696005)(99286004)(229853002)(105586002)(76176011)(3846002)(74316002)(6436002)(6116002)(6916009)(66066001)(11346002)(305945005)(6246003)(7736002)(446003)(4326008)(476003)(5660300001)(186003)(486006)(6306002)(5250100002)(33656002)(25786009)(102836004)(53936002)(55016002)(26005)(9686003)(2906002)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3410;H:CY4PR0201MB3619.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 365f5dd3-85e2-4aed-dc17-08d6036d23d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR0201MB3410;
x-ms-traffictypediagnostic: CY4PR0201MB3410:
x-microsoft-antispam-prvs: <CY4PR0201MB3410BE71FFF9A22378F13DFFC73E0@CY4PR0201MB3410.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:CY4PR0201MB3410;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3410;
x-forefront-prvs: 07665BE9D1
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SDh0wn/Tf8VRg9ul5m+KXvm+To/TKgXWpbvfxkjAI2z+dWIqpWtHR7aets5bGKHwIyyH37yGHPlWhoyZ5Br7zExKQvMsHgrSg+ejYOkHZvpgUEH8XPqNb7O5lWrXpADBeyMlZQcCbg08dUq2TzHKRFp3ewg7Nx5maP5K/ig8j+++WZW65GfUXJmPU1V9Q/bO6J11GAD1VkEqQ6g9OlPlEPc1UX/D2kuDoObUED07i1VWItUJB2hrn5dtHHUSl4nZjD9GOhwwpWMG+w3FFiV1fDbqDEPc1UmaULbFY31J+EMudMh0+FLbFFhXZg3mYv8euGuWPytciE7w5Wvn+TUkC5SCuQAEFhnAzmVgIwHQDC4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365f5dd3-85e2-4aed-dc17-08d6036d23d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2018 11:41:00.6324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3410
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.=20

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, August 14, 2018 9:43 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>
> Cc: vkoul@kernel.org; mark.rutland@arm.com; Michal Simek
> <michals@xilinx.com>; dan.j.williams@intel.com; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>; lars@metafoo.de; dmaengine@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add bind=
ing
> for Xilinx MCDMA IP
>=20
> On Tue, Jul 31, 2018 at 11:16:12PM +0530, Radhey Shyam Pandey wrote:
> > Add devicetree binding for Xilinx AXI Multichannel Direct Memory
> > Access (AXI MCDMA) IP. The AXI MCDMA provides high-bandwidth direct
> > memory access between memory and AXI4-Stream target peripherals. The
> > AXI MCDMA core provides scatter-gather interface with multiple channel
> support.
> >
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> >  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 10
> > ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > index 174af2c..57bb02e 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> > @@ -11,9 +11,13 @@ is to receive from the device.
> >  Xilinx AXI CDMA engine, it does transfers between memory-mapped
> > source  address and a memory-mapped destination address.
> >
> > +Xilinx AXI MCDMA engine, it does transfer between memory and AXI4
> > +stream target devices. It can be configured to have up to 16
> > +independent transmit and receive channels.
> > +
> >  Required properties:
> >  - compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a=
" or
> > -	      "xlnx,axi-cdma-1.00.a""
> > +	      "xlnx,axi-cdma-1.00.a" or "xlnx,axi-mcdma-1.00.a".
>=20
> Please reformat to 1 per line.
Yes, I will fix it in v2.

>=20
> >  - #dma-cells: Should be <1>, see "dmas" property below
> >  - reg: Should contain VDMA registers location and length.
> >  - xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bi=
ts).
> > @@ -56,6 +60,8 @@ Required child node properties:
> >  	For CDMA: It should be "xlnx,axi-cdma-channel".
> >  	For AXIDMA: It should be either "xlnx,axi-dma-mm2s-channel" or
> >  	"xlnx,axi-dma-s2mm-channel".
> > +	For MCDMA: It should be either "xlnx,axi-mcdma-mm2s-channel" or
> > +	"xlnx,axi-mcdma-s2mm-channel".
>=20
> What's wrong with reusing the existing xlnx,axi-dma-* names?
Valid point. I think we can reuse it (Reason for adding was to follow
similar convention as of DMA , VDMA IPs).  I will address it in v2.

>=20
> >  - interrupts: Should contain per channel VDMA interrupts.
> >  - xlnx,datawidth: Should contain the stream data width, take values
> >  	{32,64...1024}.
> > @@ -68,7 +74,7 @@ Optional child node properties for VDMA:
> >  	enabled/disabled in hardware.
> >  - xlnx,enable-vert-flip: Tells vertical flip is
> >  	enabled/disabled in hardware(S2MM path).
> > -Optional child node properties for AXI DMA:
> > +Optional child node properties for AXI DMA and MCDMA:=09
> >  -dma-channels: Number of dma channels in child node.
> >
> >  Example:
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
