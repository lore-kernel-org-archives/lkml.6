Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCBCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088B820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pBbfgzcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088B820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeICNSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:18:54 -0400
Received: from mail-eopbgr730077.outbound.protection.outlook.com ([40.107.73.77]:32480
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbeICNSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8YdJPITaZ0DsmBe48387f/oT16MBJ5GZOfaGBo1dFY=;
 b=pBbfgzcO1dlEzOVSwEdUihm4NYoMS3AAzXwiM0/uBicZ6fDM0EjkkeM6iTXcYVMq0TMjQc+5O4BnFq8Pxe01zjZX6v05AJN3SZp+8j4rvPlnOc3tZ1EdjQJyZHq77yKyxhiiYdidV6I43iPsdr9XkSCxqO/UmAojguJe1yp+t8k=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB4696.namprd02.prod.outlook.com (52.135.232.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Mon, 3 Sep 2018 08:59:37 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8169:d66c:a34d:e91e]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8169:d66c:a34d:e91e%4]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 08:59:37 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "atull@opensource.altera.com" <atull@opensource.altera.com>,
        "moritz.fischer@ettus.com" <moritz.fischer@ettus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
Thread-Topic: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
Thread-Index: AQHUKLXjboO8pwvbjE2osMCstNpM9qS/g6yAgB7yg0A=
Date:   Mon, 3 Sep 2018 08:59:37 +0000
Message-ID: <BYAPR02MB471047F38899D78151AC1805C20C0@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
 <20180814161917.GA26926@rob-hp-laptop>
In-Reply-To: <20180814161917.GA26926@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB4696;6:hXWa/OAAw8ZzgHNS1KyiROQh6vwc43jRw9uvEA9ZVLyM0b1kpZ9w2F1jiXvC7Tw757N4En82I6e5ien9FvrxvhdBne1e0//Be6fMedkjGT6TMjCvmEuov6eHPbJ+PSsa5aEEGcx4AeaQu0Pij7d9k1c324gyF5eltPbk2KFb/Fa1Tq0b4l0pn+F12OtuP5UUTd4H/t0yNFg5QuBhTwuUG0IitDYspPB4Z9qvx32NGNWwWdWQK84e6UfnPNamrZ4LPFO41wEmOmtFYzf/9/ibIlnm8QP9Jy+dlrvnZFe6HIfCS3fT5YnxF+4WLrw/1UMOI1JTKl7W9hndUGnhhqQHEc8nAPGdEIQKzxOeRvR3cd5Ws+29wpNXhzW8A5RCFMc5coHs9SGT85cRYwotUa5KyySat0MiFyKaAMpGftaHYAMr/mz8nu813jtVPFRiHw1nudkMa5RwW6fqak83e/gJKw==;5:6zH9Td+jSlee6xKL9kijCHBu4HeHFKna8d3d8pme6AenRqNph/P5fcOcMHwH9Epvq/aLEXmliGb0yn9K7XtmMp+F3yqr6mRugsBuCSwjXozKgRsW+B1OnoHcGZm1ugA/ruF9rQO3PjC6mfOviZRa2s3xUOc45xLc3xAVPbH/xjs=;7:+JOWTaeriiidvMxLIGrKFHD9eO/DnU7Lf28j5/Z0HN7EwPhsmtuMh97Fu/t5zXvqTP1g6rYpyTvWaXzkydjuyymhPDOUXUEdYtWDeBrPlnS+SrlzAGawVh4c9ILXnWBzJnaY+i8KlK/Rv/l9PU70yeSEJLihSHX7wEFlWTUCVCmk9fT35hMxu6JgZyYxI/IoRoMcEfh0eo+/ThmR6yvPPHoYnXMBIi1vGbije3Fm9z0FjZCFDGWUwYPunWpNaAiO
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 2113f89e-1782-4aa7-c255-08d6117b93ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4696;
x-ms-traffictypediagnostic: BYAPR02MB4696:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB469666BC197099F0DAF4BCA6C20C0@BYAPR02MB4696.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(80048183373757)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR02MB4696;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4696;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(51914003)(189003)(199004)(13464003)(316002)(54906003)(6246003)(105586002)(106356001)(6916009)(53936002)(9686003)(33656002)(86362001)(5660300001)(6436002)(55016002)(97736004)(81166006)(229853002)(81156014)(2906002)(25786009)(305945005)(7696005)(8676002)(68736007)(74316002)(8936002)(76176011)(256004)(2900100001)(217873002)(5250100002)(14454004)(478600001)(476003)(53546011)(6506007)(102836004)(66066001)(26005)(4326008)(11346002)(3846002)(39060400002)(486006)(6116002)(99286004)(7736002)(186003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4696;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: azpgX0OxrxG15Cgi8CB2jz3DZ76eD2/fYEMYTuygI1ZobcwroTUDJJZ/kmmJRG5mPJ2Qu4g1Q1MAkXK88+o1cx9ZhZIf6vYsb7YEqCSL9Q1OZL1AT8TTkG/dbK1qQ1Vh7HBflCTRKDkChFy3OS2JGakubGdDxqCkHHIqFgwr8t+rweseDPh39xhxLMb4kwzDkJp6V1BjaBX+kkbgy92cC14Zyrtg/dOmpgj9mjJnwAOS6gRH+a8JOF2g5nOxoNlvFaFwujThmVyXdM0AtI/nGkUWw9yjp6F3a01f++3mLa/jTUMLR5yMkn9xw+3wangSsZp4QnRH+b2fZcu8OIBkZ341rr9fquTSgEe2spZHFgI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2113f89e-1782-4aa7-c255-08d6117b93ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 08:59:37.5961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4696
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the providing the comments...
Please find my response inline...

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, August 14, 2018 9:49 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>; Soren
> Brinkmann <sorenb@xilinx.com>; atull@opensource.altera.com;
> moritz.fischer@ettus.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; chinnikishore369@gmail.com; Nava
> kishore Manne <navam@xilinx.com>
> Subject: Re: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
> zynqmp FPGA manager
>=20
> On Wed, Aug 01, 2018 at 03:34:56PM +0530, Nava kishore Manne wrote:
> > New bindings document for zynqmp fpga manager.
> >
> > Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > ---
> >  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > new file mode 100644
> > index 000000000000..0eac747747f5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> > @@ -0,0 +1,9 @@
> > +Xilinx Zynqmp FPGA Manager
> > +
> > +Required properties:
> > +- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
> > +
> > +Example:
> > +	pcap: pcap@00 {
> > +		compatible =3D "xlnx,zynqmp-pcap-fpga";
>=20
> How is this accessed? Via firmware interface? If so, need to define it is=
 a child of
> the firmware node.

Yes, it's uses firmware interface...
Will fix it in the next version.

Regards,
Navakishore.
