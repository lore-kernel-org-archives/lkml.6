Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3CFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D652241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pRyz7JK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D652241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeKMDSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:18:51 -0500
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:46124
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727185AbeKMDSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC1g8vGASIuIvg57X5xHlXTEtVWJxKGXWsTjCRg8EVI=;
 b=pRyz7JK2IPp9SNOfbZ10ldEUmqruyGFuHmcvw8VnBA5OLMTDW3p/P7RTOWfCzApxZwdZnMNVwfLGOKI5TWck8FXa8EfiUpTGlttLFtgQaGEvBvdNh7PN411AtVCqvqa2D9G0I54tUWiJPWaiNiPSqd58vQ2vsLNW1PDs621a/Ds=
Received: from DM5PR02MB2233.namprd02.prod.outlook.com (10.168.173.147) by
 DM5PR02MB3371.namprd02.prod.outlook.com (10.164.152.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 12 Nov 2018 17:23:45 +0000
Received: from DM5PR02MB2233.namprd02.prod.outlook.com
 ([fe80::d16b:1d19:d06e:50dc]) by DM5PR02MB2233.namprd02.prod.outlook.com
 ([fe80::d16b:1d19:d06e:50dc%2]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 17:23:44 +0000
From:   Jiaying Liang <jliang@xilinx.com>
To:     Jiaying Liang <jliang@xilinx.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Thread-Topic: [PATCH v5 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
Thread-Index: AQHUdVgcP3DYeMM1mUmtiv85ca0+nKVMbhjg
Date:   Mon, 12 Nov 2018 17:23:44 +0000
Message-ID: <DM5PR02MB22330CCAECBB13E7474EA4F2B0C10@DM5PR02MB2233.namprd02.prod.outlook.com>
References: <1541457421-14820-1-git-send-email-wendy.liang@xilinx.com>
 <1541457421-14820-3-git-send-email-wendy.liang@xilinx.com>
In-Reply-To: <1541457421-14820-3-git-send-email-wendy.liang@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jliang@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR02MB3371;6:eycMb2J/+Dg89qNRz9y6ctMDvmqzQQaYVnpgQwRS9J1ViitfYP3kGtigQ5UD34O28mJ9bdWShsL+PPU3VGrD9iaSy53AIEvltlkqvQmu2Cus0zO3el4zbs4KnlsItUIEluUFESjvq4BUcQLoUORIZPro9qhjTYvHQyHSYfPJmw3hicD4r1DI1oCR4JAkU7Ou7lqb8EnwhUX8SDjGwg1KHnwJ0aszph8+U2/qOvDeqSTf6UxsCZWwBNRvxX3IuBLouAo3uZoubEJtVhHmmHFbcCDIGRuIEoAtkivdjGV4p2EOaYgKuqhZl18KvvTJn1JmsIJQexqXyRCAtzhlUfZ6hEAYyjGw6w6C1iMhPAXmJTXZolD3tkFUly0z3psu9wEKgxQfOuiyXoQls7lwmPREPRaT5MI68RR3xB9rZRvUb97SUXXcKTmC4X+3TUEj+DkFi3PLupsU/EAFzNoARo8cDQ==;5:kuCkm793gKCB5BRc9ocR7IrXX2B2uSyi0YZ/ocrwlDw6nYuer6tIWXwUY5kmwNhmXz+Q7fI5dfpfyD29lyun5WinZzbL8tBZe/orwh1hxyP+3VifQ3GzzA/FcRTO0hMPlXZWeDkx4G+UUNG2wr4A5fFbSAw6YcRgLSk823N7kwc=;7:VN2KKNjAtcbTAIH790K3LrKF7nik+kzHxQDq051IQr2OjpuLYY04Et1+lvFwIdq25YXacd8oYEA1O1mFlkiNeTC21Jr1u8W1nf+R9G0M20VqDxGv+x3Ku9uNoiVF4qR3umVrO/Dus7wqzxA1Bg0J9Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(13464003)(2906002)(15650500001)(6116002)(3846002)(14454004)(68736007)(7736002)(54906003)(26005)(110136005)(316002)(9686003)(2900100001)(55016002)(478600001)(105586002)(5660300001)(305945005)(33656002)(8936002)(81166006)(81156014)(106356001)(71190400001)(74316002)(8676002)(186003)(71200400001)(11346002)(229853002)(102836004)(6246003)(6436002)(6506007)(53546011)(2501003)(97736004)(4326008)(53936002)(14444005)(256004)(486006)(476003)(446003)(86362001)(39060400002)(7696005)(99286004)(66066001)(25786009)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3371;H:DM5PR02MB2233.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 99007ddf-476d-4446-b3ff-08d648c39945
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB3371;
x-ms-traffictypediagnostic: DM5PR02MB3371:
x-microsoft-antispam-prvs: <DM5PR02MB3371678E8A9040D70E350446B0C10@DM5PR02MB3371.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(85827821059158)(180628864354917)(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231382)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR02MB3371;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB3371;
x-forefront-prvs: 0854128AF0
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wexrnTLH1b8NYGUg5Dd9nN6VyYhn+h2hZ7lZmOatzemnzBdsi4BepSqqgzG3708l+9Qx9WH6gdn0p8lkHclfiZ89mTEkVxBKnsF+ld2a5NpNP6gicOxRLlB83hQWee2YF6zOvt8fUuxCddSL6TpBegUmhkVhRgS231Wv0Evm/9SLuvRB+uP8gGdcroCkGXKCVSMzsnXB6s8avXMEjyOCM9ljBxDQoADOog0xQ/lPAs0f6gR1ro6mkAmwRmaJ0IhDFimk31WVji+FjoiT1C21kfqbzAReSBp0m363Bzm8zYEXSwpnHwx3JtjrgVVyLSy4BI/FBM/I6/Lm1hL7M4M/vFwiMtOfswVPByDA/IZETlc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99007ddf-476d-4446-b3ff-08d648c39945
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 17:23:44.6183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping, any comments?
Thanks,
Wendy

> -----Original Message-----
> From: Wendy Liang [mailto:wendy.liang@xilinx.com]
> Sent: Monday, November 05, 2018 2:37 PM
> To: jassisinghbrar@gmail.com; Michal Simek <michals@xilinx.com>;
> robh+dt@kernel.org; mark.rutland@arm.com
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Jiaying Liang <jliang@xilinx.com>
> Subject: [PATCH v5 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
>=20
> Xilinx ZynqMP IPI(Inter Processor Interrupt) is a hardware block in ZynqM=
P
> SoC used for the communication between various processor systems.
>=20
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> ---
>  .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt   | 128
> +++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-
> mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-
> mailbox.txt
> new file mode 100644
> index 0000000..18fd7b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.
> +++ txt
> @@ -0,0 +1,128 @@
> +Xilinx IPI Mailbox Controller
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to
> +manage messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents.
> +Each IPI agent owns registers used for notification and buffers for mess=
age.
> +
> +               +-------------------------------------+
> +               | Xilinx ZynqMP IPI Controller        |
> +               +-------------------------------------+
> +    +--------------------------------------------------+
> +ATF                    |                     |
> +                       |                     |
> +                       |                     |
> +    +--------------------------+             |
> +                       |                     |
> +                       |                     |
> +    +--------------------------------------------------+
> +            +------------------------------------------+
> +            |  +----------------+   +----------------+ |
> +Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> +            |  |  Registers     |   |                | |
> +            |  |                |   |                | |
> +            |  +----------------+   +----------------+ |
> +            |                                          |
> +            | Xilinx IPI Agent Block                   |
> +            +------------------------------------------+
> +
> +
> +Controller Device Node:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Required properties:
> +--------------------
> +IPI agent node:
> +- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
> +- interrupt-parent:	Phandle for the interrupt controller
> +- interrupts:		Interrupt information corresponding to the
> +			interrupt-names property.
> +- xlnx,ipi-id:		local Xilinx IPI agent ID
> +- #address-cells:	number of address cells of internal IPI mailbox nodes
> +- #size-cells:		number of size cells of internal IPI mailbox nodes
> +
> +Internal IPI mailbox node:
> +- reg:			IPI buffers address ranges
> +- reg-names:		Names of the reg resources. It should have:
> +			* local_request_region
> +			  - IPI request msg buffer written by local and read
> +			    by remote
> +			* local_response_region
> +			  - IPI response msg buffer written by local and read
> +			    by remote
> +			* remote_request_region
> +			  - IPI request msg buffer written by remote and read
> +			    by local
> +			* remote_response_region
> +			  - IPI response msg buffer written by remote and
> read
> +			    by local
> +- #mbox-cells:		Shall be 1. It contains:
> +			* tx(0) or rx(1) channel
> +- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
> +			connected to.
> +
> +Optional properties:
> +--------------------
> +- method:              The method of accessing the IPI agent registers.
> +                       Permitted values are: "smc" and "hvc". Default is
> +                       "smc".
> +
> +Client Device Node:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Required properties:
> +--------------------
> +- mboxes:		Standard property to specify a mailbox
> +			(See ./mailbox.txt)
> +- mbox-names:		List of identifier  strings for each mailbox
> +			channel.
> +
> +Example:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +	zynqmp_ipi {
> +		compatible =3D "xlnx,zynqmp-ipi-mailbox";
> +		interrupt-parent =3D <&gic>;
> +		interrupts =3D <0 29 4>;
> +		xlnx,ipi-id =3D <0>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +
> +		/* APU<->RPU0 IPI mailbox controller */
> +		ipi_mailbox_rpu0: mailbox@ff90400 {
> +			compatible =3D "xlnx,zynqmp-ipi-mailbox";
> +			reg =3D <0xff990400 0x20>,
> +			      <0xff990420 0x20>,
> +			      <0xff990080 0x20>,
> +			      <0xff9900a0 0x20>;
> +			reg-names =3D "local_request_region",
> +				    "local_response_region",
> +				    "remote_request_region",
> +				    "remote_response_region";
> +			#mbox-cells =3D <1>;
> +			xlnx,ipi-id =3D <1>;
> +		};
> +		/* APU<->RPU1 IPI mailbox controller */
> +		ipi_mailbox_rpu1: mailbox@ff990440 {
> +			compatible =3D "xlnx,zynqmp-ipi-mailbox";
> +			reg =3D <0xff990440 0x20>,
> +			      <0xff990460 0x20>,
> +			      <0xff990280 0x20>,
> +			      <0xff9902a0 0x20>;
> +			reg-names =3D "local_request_region",
> +				    "local_response_region",
> +				    "remote_request_region",
> +				    "remote_response_region";
> +			#mbox-cells =3D <1>;
> +			xlnx,ipi-id =3D <2>;
> +		};
> +	};
> +	rpu0 {
> +		...
> +		mboxes =3D <&ipi_mailbox_rpu0 0>,
> +			 <&ipi_mailbox_rpu0 1>;
> +		mbox-names =3D "tx", "rx";
> +	};
> +	rpu1 {
> +		...
> +		mboxes =3D <&ipi_mailbox_rpu1 0>,
> +			 <&ipi_mailbox_rpu1 1>;
> +		mbox-names =3D "tx", "rx";
> +	};
> --
> 2.7.4

