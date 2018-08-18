Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA8C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 10:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810A521877
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 10:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="43+UNpFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810A521877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeHRNTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 09:19:31 -0400
Received: from mail-cys01nam02on0052.outbound.protection.outlook.com ([104.47.37.52]:46075
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725918AbeHRNTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 09:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuF5N92yfy1l1sv9DZpn9IVMLVxjI7S3WkeplI4CiME=;
 b=43+UNpFkueoL7w+3B1vpY8fOT0AWEAs0YmJ4l9Wxi6U5B+RXd9d0qNPfnXih8h8GeeG4hXocUoB7B0KAXL45AEbXtG0tjys93Dv7+RwbRCLhxoJwSXa+ozFROp3FxR2uu5Z1j/okdrQhINlojphG9GyBOdD3OHXaTRbQVk5Nd2o=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6SPR01MB10.namprd02.prod.outlook.com (20.176.73.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Sat, 18 Aug 2018 10:12:18 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644%3]) with mapi id 15.20.1059.023; Sat, 18 Aug 2018
 10:12:18 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        Edgar Iglesias <edgari@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "stefan.krsmanovic@aggios.com" <stefan.krsmanovic@aggios.com>
CC:     Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] arm64: zynqmp: Add DDRC node
Thread-Topic: [PATCH v4 4/4] arm64: zynqmp: Add DDRC node
Thread-Index: AQHUK9UzU/i+az3vrk+yPlK6UdWYl6TFYB7w
Date:   Sat, 18 Aug 2018 10:12:18 +0000
Message-ID: <DM6PR02MB52276B9FB674BC816BC28A82C13C0@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-5-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1533374735-16662-5-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6SPR01MB10;6:mqN6SwVleuQkIRpwiF2k4zCZAHVKmRE0O6q+NQi8eyrMcfbmKeEKtpeC5gZYetQNJ37TFQCl/7TSrpQm3KIoob/0xWlW7sgDAOjxd9wdN0hEnbqqRf7+rp7NMhAPF3KxVLXJVQ70GI6u/bB3xIQPztma+hGSMCTBllDyZQIKrk36pMBkzFlTqq5mb0EcAE56qxy1NujmkdvfMhxY5iIhCii79zhqjHlovdaFnyzTZuGThwm7xYj7OcXKyM1+oVkDe2jIRc7uHMPELCGumV4ricThD03MlMSvSpUUn4HXNWzcv+W9qWyM6jrGNc5NWUaWViDHEXuFGm2ddUGN9x8dqyqca/hA46R5ZiC7BuXArCnj/KYUCU4tLxRdvswfKzdP4WqEHrT2VsWlxeD30Pr0690TUkHkXk+CyUcP5FfvatOmyuA57DAyF5wdWOqT0Qq+RAz3Z9aoP/V6hy9ZroXYAg==;5:L3l0TWv8RhI0nwd36Xt9jnSDx9/5cQrbeJqmA73yYvNszzmZHud+2BucdveW7FbPDA+bPOis3ePm6OFvLoKBJjEyW90RzN0sJ5iB0xoAosZP0jPRRwDfuXRb5WQ+tenaoB3eITgCtm03qb+2Byf7xPc5w1SuncHjHXnjJBj/tSQ=;7:VkY5wUaPZyXXvA7Pl563V26HdKk9KXtf2LP9apC+Z++oL1PcBI+HPCK7dw8jXhaTpccX/mnmmTOS9bpMDsq66SoOGZUzXHCvK6uRQS1VV7ykJvvJ/gvdRjir5gDOdquk+y2vT6jbed6mNEWzXiFNUMuKaZSMUzisKgvpznLXw1Bc9X8Z38uhx3nnv9313hVWNrSCfRH1ZoyI2M8H16eoUwpXKn+9IMcEuF/mZBr7ctvwklQ2Gmd1zkn/5KjV8cvm
x-ms-office365-filtering-correlation-id: 17e309c0-3acd-47f8-8a14-08d604f31446
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6SPR01MB10;
x-ms-traffictypediagnostic: DM6SPR01MB10:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6SPR01MB10C46E125899053D9164CCC13C0@DM6SPR01MB10.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6SPR01MB10;BCL:0;PCL:0;RULEID:;SRVR:DM6SPR01MB10;
x-forefront-prvs: 076804FE30
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39860400002)(396003)(13464003)(199004)(189003)(6246003)(2201001)(53546011)(7696005)(68736007)(2501003)(106356001)(86362001)(575784001)(14444005)(256004)(76176011)(9686003)(8936002)(5250100002)(72206003)(55016002)(54906003)(110136005)(105586002)(14454004)(2900100001)(53936002)(478600001)(316002)(25786009)(8676002)(81156014)(6116002)(486006)(81166006)(229853002)(97736004)(74316002)(66066001)(2906002)(3846002)(5660300001)(446003)(102836004)(4326008)(33656002)(305945005)(6506007)(7736002)(11346002)(7416002)(476003)(99286004)(26005)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6SPR01MB10;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cl88P2lfBUJ2iMALOvX9JVxeGpLQXrlEXzB3oWNl/TtCvCwlkSFuXxaoGtgrByCX08qs3ibvs+PMrKCVqX+EJJnGo71R78tn2xrL+4P4GDhr37B65UhF9LFwJVzu4K2xca3SXJzROSR2RtvcLfsyn30UU6pVafDP29qj6QoJLwMsubO85yr4O7UOvDOOZ0GlMpGMZHP/fYHbxGiitj24/rlKZUvmDVavhh4EOjXsbaszwlCV3Ite0+jAo73Slw7iAHoBAGAzooRgqd3fYgYRhHA2Xm8/OSPtVXhREiEkkNgoWmLesK3tPEstjDHACFiuxUJmkmHhgOz2FpS0/C2xd6DGmaWxf+noFxxAaJrbwlQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e309c0-3acd-47f8-8a14-08d604f31446
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2018 10:12:18.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

> -----Original Message-----
> From: Manish Narani [mailto:manish.narani@xilinx.com]
> Sent: Saturday, August 4, 2018 2:56 PM
> To: robh+dt@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> will.deacon@arm.com; Michal Simek <michals@xilinx.com>; bp@alien8.de;
> mchehab@kernel.org; mdf@kernel.org; Edgar Iglesias <edgari@xilinx.com>;
> Shubhrajyoti Datta <shubhraj@xilinx.com>; Naga Sureshkumar Relli
> <nagasure@xilinx.com>; Bharat Kumar Gogada <bharatku@xilinx.com>;
> stefan.krsmanovic@aggios.com
> Cc: Srinivas Goud <sgoud@xilinx.com>; Anirudha Sarangi
> <anirudh@xilinx.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> edac@vger.kernel.org; Manish Narani <MNARANI@xilinx.com>
> Subject: [PATCH v4 4/4] arm64: zynqmp: Add DDRC node
>=20
> This patch adds ddrc memory controller node in dts. The size mentioned in=
 dts
> is 0x30000, because we need to access DDR_QOS INTR registers located at
> fd090208 from this driver.
>=20
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index a091e6f..7d6a3cf 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -355,6 +355,13 @@
>  			xlnx,bus-width =3D <64>;
>  		};
>=20
> +		mc: memory-controller@fd070000 {
> +			compatible =3D "xlnx,zynqmp-ddrc-2.40a";
> +			reg =3D <0x0 0xfd070000 0x0 0x30000>;
> +			interrupt-parent =3D <&gic>;
> +			interrupts =3D <0 112 4>;
> +		};
> +
>  		gem0: ethernet@ff0b0000 {
>  			compatible =3D "cdns,zynqmp-gem", "cdns,gem";
>  			status =3D "disabled";
> --
> 2.1.1

