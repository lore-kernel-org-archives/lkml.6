Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C37C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0342243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="uaLStJSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0342243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbeKMRNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:13:18 -0500
Received: from mail-eopbgr820044.outbound.protection.outlook.com ([40.107.82.44]:46967
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbeKMRNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UIpsQKrOcpoGinVSYEKYbSbhF19w5vEh4TaZo7+mMY=;
 b=uaLStJSOD4OMS4+uKuSA0fiioX/u3BRJ2LumbAEa15Mq2IOix84RfFzj8YJvkdcILGnni4rUqQ+1fRvSqHlh7hO1xi5V2TH/E9NSp8XM/MuAu8+i5LXJMQU7Dlgueznm81I98BXgjW8IOvoqOnqOGhQFtPb50f5junBeptIQi6o=
Received: from DM5PR02MB2233.namprd02.prod.outlook.com (10.168.173.147) by
 DM5PR02MB2812.namprd02.prod.outlook.com (10.175.86.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 07:16:28 +0000
Received: from DM5PR02MB2233.namprd02.prod.outlook.com
 ([fe80::d16b:1d19:d06e:50dc]) by DM5PR02MB2233.namprd02.prod.outlook.com
 ([fe80::d16b:1d19:d06e:50dc%2]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 07:16:26 +0000
From:   Jiaying Liang <jliang@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Thread-Topic: [PATCH v5 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Thread-Index: AQHUdVgcP3DYeMM1mUmtiv85ca0+nKVMdyKAgADe2eA=
Date:   Tue, 13 Nov 2018 07:16:26 +0000
Message-ID: <DM5PR02MB22334437172F9379477A115CB0C20@DM5PR02MB2233.namprd02.prod.outlook.com>
References: <1541457421-14820-1-git-send-email-wendy.liang@xilinx.com>
 <1541457421-14820-3-git-send-email-wendy.liang@xilinx.com>
 <5bea0eb3.1c69fb81.20e73.a4f9@mx.google.com>
In-Reply-To: <5bea0eb3.1c69fb81.20e73.a4f9@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jliang@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR02MB2812;6:UwmiV4ZWnw7EBlrbWHcQWOQ0Srb0r4or3JEpBvqXAN5+FnHJUYQ5nnN/h8KV3EomG8iLvdxhJreyWQ9POI6VFxiSnENxInvF+WDgtdF7Qgl2eBu64/mHCd5sIQWv9ry1rRlzghQEGrNMA9CaMW1gvFIh8v20OZ2uS2QFxMj2apOG2xeuMAmENMPsi3LLkqdqEipJ0i95gFpFW8hcxcChZ1c6o+kemQW1Yyw773Ed4KcTn8gHrDyWY2HBSjS4eKZw94AeRdCSvAhdxamTa2lw5ZsIwe1dAdbi935fFfi+guPaSTLCSERI5bvay5mN3I+s6IkF2ZLxZZ1T5RABUkqqtC40KY3y587p3lnl3s/ttNntvbXpiT/hlnQpHOovG/Xcw7k+AAMuhjCIZ+7uci8e1n2byPSwmOCx+YfHHlSWXsabZ3LbPAJoiCvMc27T3h+ZOTlnvC709RbZ0sNSDd1zbQ==;5:twE3y1WxvFDeOFdraKtLB0zY+tLE/vYix6khzX8yCpq8BVFwleW3Sj6ZB+yEx/V/JDjmzM+WYvgYe8D2fDFPWIhWmqJJntmdSiknVlWjnF9wdvLvBjWbniE5Y0VGi0qX25fIYzrIuYgr2ddjMxNbfIcivR6sHgweQ00u320ITkE=;7:ufNzOpFzugo6XZpx1upGkVWZfeh8sG91aCqOKWUPywE3f0p9bG700vKrcVEbEs53pP4x+8WePD4n2gNunhPnD04CkuZxc04s0H5t8YmUsiqNQH6VnYWKRft8NGtkkKSTFF37q6so3g1BahlazOkJww==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(13464003)(199004)(189003)(6116002)(99286004)(11346002)(74316002)(8936002)(106356001)(6436002)(476003)(14444005)(446003)(53936002)(105586002)(3846002)(186003)(53546011)(316002)(486006)(6506007)(102836004)(71200400001)(71190400001)(54906003)(25786009)(7696005)(26005)(76176011)(2906002)(229853002)(305945005)(14454004)(86362001)(97736004)(39060400002)(2900100001)(55016002)(4326008)(8676002)(9686003)(81166006)(81156014)(5660300001)(68736007)(256004)(7736002)(6246003)(478600001)(33656002)(15650500001)(66066001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2812;H:DM5PR02MB2233.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 27674d62-8406-4588-6f28-08d64937ecef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB2812;
x-ms-traffictypediagnostic: DM5PR02MB2812:
x-microsoft-antispam-prvs: <DM5PR02MB2812B1F2A8DBF0A5FC3F2BFBB0C20@DM5PR02MB2812.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231406)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR02MB2812;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2812;
x-forefront-prvs: 085551F5A8
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: higTHW+w56ueyLHJdbRJdBxsUZkNqFpYgGzZJyZR32oh/fbX3ToF4zRHYSJNdd8IwMkp54ps/D1jSMMs8vo/yzGpW30a3Nut8Xlk5weALqHAcYx5pNqVIMHObafBZ/XY9b+lRshT8xM8JTApkSyKQIGo58IsrwhAbPL65dcm+ceupFhWPhne5VMaP2F9IjP/2KKJF441kxCG6D+/VVsmq6sF7e3eafcTD53UBJEfEIlCghZHl/rr8bMSVNUatjeNm3IolxzZ3bz9vRPs41CHsCGIbz6nqq75Oz3piC+HTVmttnuQFla3ZSShNq9G6tVQZO8UqXY5WzQ75KKSuFvcZUNVdYYzOEv8RpC/L9MFaj8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27674d62-8406-4588-6f28-08d64937ecef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 07:16:26.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2812
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Monday, November 12, 2018 9:56 AM
> To: Jiaying Liang <jliang@xilinx.com>
> Cc: jassisinghbrar@gmail.com; Michal Simek <michals@xilinx.com>;
> mark.rutland@arm.com; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
>=20
> On Mon, Nov 05, 2018 at 02:37:01PM -0800, Wendy Liang wrote:
> > Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block in
> > ZynqMP SoC used for the communication between various processor
> > systems.
> >
> > Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> > ---
> >  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 128
> +++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.tx
> > t
> > b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-
> mailbox.tx
> > t
> > new file mode 100644
> > index 0000000..18fd7b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-
> mailbo
> > +++ x.txt
> > @@ -0,0 +1,128 @@
> > +Xilinx IPI Mailbox Controller
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to
> > +manage messaging between two Xilinx Zynq UltraScale+ MPSoC IPI
> > +agents. Each IPI agent owns registers used for notification and buffer=
s for
> message.
> > +
> > +               +-------------------------------------+
> > +               | Xilinx ZynqMP IPI Controller        |
> > +               +-------------------------------------+
> > +    +--------------------------------------------------+
> > +ATF                    |                     |
> > +                       |                     |
> > +                       |                     |
> > +    +--------------------------+             |
> > +                       |                     |
> > +                       |                     |
> > +    +--------------------------------------------------+
> > +            +------------------------------------------+
> > +            |  +----------------+   +----------------+ |
> > +Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> > +            |  |  Registers     |   |                | |
> > +            |  |                |   |                | |
> > +            |  +----------------+   +----------------+ |
> > +            |                                          |
> > +            | Xilinx IPI Agent Block                   |
> > +            +------------------------------------------+
> > +
> > +
> > +Controller Device Node:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +Required properties:
> > +--------------------
> > +IPI agent node:
> > +- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
> > +- interrupt-parent:	Phandle for the interrupt controller
> > +- interrupts:		Interrupt information corresponding to the
> > +			interrupt-names property.
> > +- xlnx,ipi-id:		local Xilinx IPI agent ID
> > +- #address-cells:	number of address cells of internal IPI mailbox node=
s
> > +- #size-cells:		number of size cells of internal IPI mailbox nodes
> > +
> > +Internal IPI mailbox node:
> > +- reg:			IPI buffers address ranges
> > +- reg-names:		Names of the reg resources. It should have:
> > +			* local_request_region
> > +			  - IPI request msg buffer written by local and read
> > +			    by remote
> > +			* local_response_region
> > +			  - IPI response msg buffer written by local and read
> > +			    by remote
> > +			* remote_request_region
> > +			  - IPI request msg buffer written by remote and read
> > +			    by local
> > +			* remote_response_region
> > +			  - IPI response msg buffer written by remote and
> read
> > +			    by local
> > +- #mbox-cells:		Shall be 1. It contains:
> > +			* tx(0) or rx(1) channel
> > +- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
> > +			connected to.
> > +
> > +Optional properties:
> > +--------------------
> > +- method:              The method of accessing the IPI agent registers=
.
> > +                       Permitted values are: "smc" and "hvc". Default =
is
> > +                       "smc".
> > +
> > +Client Device Node:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +Required properties:
> > +--------------------
> > +- mboxes:		Standard property to specify a mailbox
> > +			(See ./mailbox.txt)
> > +- mbox-names:		List of identifier  strings for each mailbox
> > +			channel.
> > +
> > +Example:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +	zynqmp_ipi {
> > +		compatible =3D "xlnx,zynqmp-ipi-mailbox";
> > +		interrupt-parent =3D <&gic>;
> > +		interrupts =3D <0 29 4>;
> > +		xlnx,ipi-id =3D <0>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
>=20
> Both the parent and children are mailbox providers?
[Wendy] children are mailbox providers.
As the mailbox providers shared the same interrupt
And the same local IPI agent ID, and thus, use
This parent/child structure
>=20
> > +
> > +		/* APU<->RPU0 IPI mailbox controller */
> > +		ipi_mailbox_rpu0: mailbox@ff90400 {
> > +			compatible =3D "xlnx,zynqmp-ipi-mailbox";
>=20
> You can't have the same compatible in the parent and here.
[Wendy] Will remove the compatible in the child node.

>=20
> > +			reg =3D <0xff990400 0x20>,
> > +			      <0xff990420 0x20>,
> > +			      <0xff990080 0x20>,
> > +			      <0xff9900a0 0x20>;
> > +			reg-names =3D "local_request_region",
> > +				    "local_response_region",
> > +				    "remote_request_region",
> > +				    "remote_response_region";
> > +			#mbox-cells =3D <1>;
> > +			xlnx,ipi-id =3D <1>;
> > +		};
> > +		/* APU<->RPU1 IPI mailbox controller */
> > +		ipi_mailbox_rpu1: mailbox@ff990440 {
> > +			compatible =3D "xlnx,zynqmp-ipi-mailbox";
> > +			reg =3D <0xff990440 0x20>,
> > +			      <0xff990460 0x20>,
> > +			      <0xff990280 0x20>,
> > +			      <0xff9902a0 0x20>;
> > +			reg-names =3D "local_request_region",
> > +				    "local_response_region",
> > +				    "remote_request_region",
> > +				    "remote_response_region";
> > +			#mbox-cells =3D <1>;
> > +			xlnx,ipi-id =3D <2>;
> > +		};
> > +	};
> > +	rpu0 {
> > +		...
> > +		mboxes =3D <&ipi_mailbox_rpu0 0>,
> > +			 <&ipi_mailbox_rpu0 1>;
> > +		mbox-names =3D "tx", "rx";
> > +	};
> > +	rpu1 {
> > +		...
> > +		mboxes =3D <&ipi_mailbox_rpu1 0>,
> > +			 <&ipi_mailbox_rpu1 1>;
> > +		mbox-names =3D "tx", "rx";
> > +	};
> > --
> > 2.7.4
> >

