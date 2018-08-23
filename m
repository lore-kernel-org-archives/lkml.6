Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77822C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C90208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s/3AAyF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C90208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeHWSdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:33:08 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:27680
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732062AbeHWSdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zmHMupoGU8SRWPi4SFVMevkaA5Y2AP452ZR2aCs+X8=;
 b=s/3AAyF6oFoRMT3GR1LYWYKvqugAF5Ez0YX1hBCGpmY9yi6sYRxQNx07KchZGCEG4/ZygAZqg8fCFQS3MD96E8ijPil5KOwwZMlHefJO36SeP57d6CNNxvHMR1LXyfv55Y23RvGRo9blAoeR1MvnvQe/M5TrPvmZU6AydNB5yUY=
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com (20.177.32.218) by
 AM6PR04MB5015.eurprd04.prod.outlook.com (20.177.34.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Thu, 23 Aug 2018 15:00:04 +0000
Received: from AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::d35:5e30:4789:7bb3]) by AM6PR04MB4789.eurprd04.prod.outlook.com
 ([fe80::d35:5e30:4789:7bb3%2]) with mapi id 15.20.1059.023; Thu, 23 Aug 2018
 15:00:04 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
        Ramneek Mehresh <ramneek.mehresh@nxp.com>,
        Ying Zhang <ying.zhang22455@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>
Subject: RE: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
Thread-Topic: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
Thread-Index: AQHUOLbptRQH2lOrRUSo17aX7O7Hy6TJ/sYAgANuUvA=
Date:   Thu, 23 Aug 2018 15:00:03 +0000
Message-ID: <AM6PR04MB47899CE5F871731749E59636F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-5-git-send-email-vabhav.sharma@nxp.com>
 <20180821101652.GA18139@e107155-lin>
In-Reply-To: <20180821101652.GA18139@e107155-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [139.167.224.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5015;6:YkWdbeoawYt7Qy7hGMjj8QUwxPQFRGVrZuD3627KI3pXJn9aRCyTF1Em4UGEkFjI1tgpLDlsivELj9TdE9kcl3Zd3AxyypKwvZH+Og/K/cIdN9vwqvSzjXlvD4P2wX6EU/HyBRLBHkfzK9H1w0/IXKLPItfi5qTtNJUdk+1jMhY9KMpAVWTnjkfYUTzdNuSmo2cP4apUlfqr1VpTsN/9cAHqs1QmGFlsMyBViSXO2Wcf+IMUV97fP6e9ro061ZUXsqqpeiaXXkia69swcIm+fB2KR49vlDK+xHEDY79eijS6SMbT36HLGeL4HU0fYBUnTfNzEmcObS0SIVcmPYuVpwxbTFnrKUzaRHGBdbvXA+cTNRPpk+cVHzEFIh0ULR6eAh6EnkVX+XdL19f+LzBLsf/IBqfO7RCvb5H/ej8JxCxY7dPd/Zgw6j7grbbj4Gv0ldBrINK9198O3yqzz+ORWg==;5:e9I9K54BV0927RIlxLv/UdbimkyzSKqVuwW6om+izJfhSC9QbE5+QE6Wl3iNKcGhGkkDEol+aREDES6PZnVxLe6nCO54lcuNMpj64gr7Wvg03EjQAyifklx7VSKZRGD0XXgzlfUg14hIWMG+kPAVFyVTxd/R7btdOuYj0UwRTWQ=;7:ljFoHk0h1Lc0Bj6ZY3QmTfcVQ3GVxSF9hASv5E5IimxCzvxlKET75eZqD/auZq2Ev7TTzJvcCy/0Cro7uMy1XvO0QGwsC0PZQvVwJg2bcHtL6Ktqb0uFPBPv3vlFrxFpTzBhlc7LmoFxCb92OXb4pBXMs/8pUFhJ0ZxYbDGIW+BhzBEXaOlGEv/Q79VcOOD4dqbxyLdXiKJn08vZPI7huaqs6DuJ2K4JK9l29n2YAyblYAl5SJBxaC5b2zw1hweY
x-ms-office365-filtering-correlation-id: b99ff2a1-f13e-42da-6d18-08d609091b95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5015;
x-ms-traffictypediagnostic: AM6PR04MB5015:
x-microsoft-antispam-prvs: <AM6PR04MB50153025A254F2D07C51758CF3370@AM6PR04MB5015.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM6PR04MB5015;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5015;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(376002)(136003)(13464003)(189003)(199004)(5250100002)(5660300001)(3846002)(8676002)(81156014)(106356001)(8936002)(81166006)(33656002)(105586002)(229853002)(97736004)(478600001)(6116002)(2906002)(14454004)(68736007)(316002)(186003)(53936002)(486006)(6916009)(305945005)(54906003)(25786009)(26005)(102836004)(6246003)(76176011)(7696005)(6436002)(99286004)(6506007)(476003)(86362001)(74316002)(11346002)(2900100001)(9686003)(55016002)(256004)(66066001)(14444005)(7416002)(7736002)(446003)(4326008)(44832011)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5015;H:AM6PR04MB4789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2LjrE9eHl4kIf8+GBlmfzTxTvgGXLeqB5WVj9bc4eqYY5XRvkNH9ZX6kS7hx9Y1V8N/DUls4GREqoX3XpVkz8IsDcRooR8A1RhWMjK4REfR+/m2Wu1rf7K1JTMuKUrdo18nbJuBxwomdxW/y6PcUr62vq7bCugKgVRhJQ7n99L6Mbs0CVWUqIflq2hWnPsxmfpnx+2qD5XwWQuW5m+0iOU2bfraS/lfie1n5HESIapsuoZhpSbOCE2SfizwxJjrmEvnSPJZPogD1RMWStwi9m72TPG7gJ7P1ds9p7YJ/FlTM+iF41rtesSWEYM/xyWRHDDNQx7CQwwi3eW+KqX2sz2b7UzVOOT/H7jRtR0VR8lQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99ff2a1-f13e-42da-6d18-08d609091b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 15:00:03.9535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Tuesday, August 21, 2018 3:47 PM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; mturquette@baylibre.com;
> sboyd@kernel.org; rjw@rjwysocki.net; viresh.kumar@linaro.org; linux-
> clk@vger.kernel.org; linux-pm@vger.kernel.org; linux-kernel-
> owner@vger.kernel.org; catalin.marinas@arm.com; will.deacon@arm.com;
> gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com;
> linux@armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com>; Udit Kumar
> <udit.kumar@nxp.com>; Ramneek Mehresh <ramneek.mehresh@nxp.com>;
> Ying Zhang <ying.zhang22455@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>; Priyanka Jain <priyanka.jain@nxp.com>; Yogesh
> Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Sriram Dash
> <sriram.dash@nxp.com>; Sudeep Holla <sudeep.holla@arm.com>
> Subject: Re: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
>=20
> On Mon, Aug 20, 2018 at 12:17:15PM +0530, Vabhav Sharma wrote:
> > LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.
> >
> > LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor
> > cores in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8
> > I2C controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011
> > SBSA UARTs etc.
> >
> > Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
> > Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 572
> > +++++++++++++++++++++++++
> >  1 file changed, 572 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > new file mode 100644
> > index 0000000..e35e494
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -0,0 +1,572 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree
> > +Include file for Layerscape-LX2160A family SoC.
> > +//
> > +// Copyright 2018 NXP
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/memreserve/ 0x80000000 0x00010000;
> > +
> > +/ {
> > +	compatible =3D "fsl,lx2160a";
> > +	interrupt-parent =3D <&gic>;
> > +	#address-cells =3D <2>;
> > +	#size-cells =3D <2>;
> > +
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		// 8 clusters having 2 Cortex-A72 cores each
> > +		cpu@0 {
> > +			device_type =3D "cpu";
> > +			compatible =3D "arm,cortex-a72";
> > +			reg =3D <0x0>;
> > +			clocks =3D <&clockgen 1 0>;
> > +			next-level-cache =3D <&cluster0_l2>;
>=20
> If you expect to get cache properties in sysfs entries, you need to popul=
ate
> them here and for each L2 cache.
Rather sysfs, If Entry is not present then print  "cacheinfo: Unable to det=
ect cache hierarchy for CPU 0" appears in boot log which is bad saying some=
thing is not present.
Either this print is require change to debug instead of warning.
>=20
> [...]
>=20
> > +
> > +	rstcr: syscon@1e60000 {
> > +		compatible =3D "syscon";
> > +		reg =3D <0x0 0x1e60000 0x0 0x4>;
> > +	};
> > +
> > +	reboot {
> > +		compatible =3D"syscon-reboot";
> > +		regmap =3D <&rstcr>;
> > +		offset =3D <0x0>;
> > +		mask =3D <0x2>;
>=20
> Is this disabled in bootloader ? With PSCI, it's preferred to use
> SYSTEM_RESET/OFF. EL3 f/w may need to do some housekeeping on
> poweroff.
No, PSCIv0.2 is used and control passes to EL3 fw via smc call, psci node i=
s present in the file.
This node is not required and keeping it in case PSCI is not used.
>=20
> > +	};
> > +
> > +	timer {
> > +		compatible =3D "arm,armv8-timer";
> > +		interrupts =3D <1 13 4>, // Physical Secure PPI, active-low
>=20
> The comment says active low but the value 4 indicates it's HIGH from
> "include/dt-bindings/interrupt-controller/irq.h"
Thanks, I will change the entries to existing definition IRQ_TYPE_LEVEL_LOW=
,GIC_PPI which is self-explanatory and not require comments
>=20
> > +			     <1 14 4>, // Physical Non-Secure PPI, active-low
> > +			     <1 11 4>, // Virtual PPI, active-low
> > +			     <1 10 4>; // Hypervisor PPI, active-low
> > +	};
> > +
> > +	pmu {
> > +		compatible =3D "arm,armv8-pmuv3";
>=20
> More specific compatible preferably "arm,cortex-a72-pmu" ?
Sure.
>=20
> --
> Regards,
> Sudeep
