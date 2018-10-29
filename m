Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6FFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B38C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="t8O3k3pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B38C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeJ2XQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:16:30 -0400
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:32160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbeJ2XQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNzhC/Zc3PUl34f6m6rLNbjqBf3V4fE5KiqihX8kyiI=;
 b=t8O3k3pk1ZmrweO6YOWVSKQ+JNesH205YbOLw1GCWSjWbmH7iXufG5jSyHFumXs/hMvZgCsCWV4Lhkgnw71JR2a4j6oZrOvklNiiXSZP2WMprYgXJxxXY0DJJJ3lQqzjol+Y20Q9cdfwzMs3TgZ+s8wRhpwPHrrPif4Y/l4Z/qs=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (20.176.248.159) by
 BYAPR02MB5574.namprd02.prod.outlook.com (20.177.230.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Mon, 29 Oct 2018 14:27:19 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::8551:a7c9:de28:bbb5]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::8551:a7c9:de28:bbb5%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 14:27:18 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jolly Shah <JOLLYS@xilinx.com>
Subject: RE: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power
 domain driver
Thread-Topic: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP
 power domain driver
Thread-Index: AQHUXCiXuP+O1wmqNkuDthhr7zBZnKUY2XcAgALktoCAGq0KsA==
Date:   Mon, 29 Oct 2018 14:27:18 +0000
Message-ID: <BYAPR02MB40556D3EDE9892943073662DB7F30@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
 <BL2PR02MB2130719D4A82F429745DDBEEB8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
 <20181012145251.GA6489@bogus>
In-Reply-To: <20181012145251.GA6489@bogus>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 10.0.260.4
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB5574;6:M95XWhiDRDJeFFeWWINiPJHXo49q713WIccBpOpxyF1BmSCKtFHStM151tI1rKBxuUrH8qNtgBg3zaPNvySWow/UFvubJXiS8f1JpeOkWlpF9StVtbYdzDa42AhLz0wwYYtQJR/0jbI9+G2FTZu9K73aQzi3JotcXjakstSNBzR68D4/QfHWCygBYcixLL3Bq15IYY+nn/4eB1HaKI5RapZmwrEQeLRxuJnMhgvEF2mUEsHIiPHBGIuP7BnUukG1Nfw1EC+su8yPd6TlKRWPy7spsRQhIhGIJnNrvGeLyjSWBBfEdbpfev4uDbgBaT+0eeEiJ97NQ7jjFhfERAFqIyrljdVRrRJsaFZcNMVUCIg12tPAzxeH/Fj5QerFdKURKYGcd5I5F91POjrUdpqwT7C/cRCMhsYe6hZw6oRXZDzD9yBB1+KOFMB1I0iKG9lJ8MAhh5sOXtn5LZ9IlGGqzA==;5:T8FX11qRDEJrxk0EIo6vawYRvs5VD8MaOhV4CzxpIJ2GzIt6F07VfV3mh8iCkGo2CWntorazwB9RQo6SFoqC6HVvLtJFnvCJ1G7Nx2W7ATJNqoM6shvHdzKglr9PG6QbDmYKtbrRS550su0wXVQcF1OsytQcRHL6ixkYv8QrurM=;7:H3Sc0ZVOEWV4eFAi3+SsGr4SziBWUcIGatbCcLS2Mdx7g8NPKEGGjM7HApiAliKX9/VU6fFNHePO+rdjE6oxyh141MZ5bXp1rTszKwG38uCvhOnZAHnGaGpnMHdZ0aTHxgn3n5BMoxgoP6PxnrAi2Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(43544003)(189003)(199004)(13464003)(186003)(68736007)(39060400002)(53546011)(72206003)(7696005)(76176011)(5250100002)(229853002)(486006)(316002)(6506007)(8936002)(14454004)(4326008)(6116002)(26005)(6436002)(3846002)(14444005)(1720100001)(256004)(86362001)(55016002)(102836004)(966005)(54906003)(478600001)(7416002)(25786009)(2900100001)(106356001)(6306002)(5660300001)(9686003)(2906002)(6916009)(105586002)(33656002)(97736004)(66066001)(8676002)(71200400001)(107886003)(81166006)(7736002)(476003)(71190400001)(11346002)(446003)(53936002)(305945005)(99286004)(81156014)(74316002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5574;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 0d331c2d-6fb5-4e83-0e2b-08d63daaa175
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5574;
x-ms-traffictypediagnostic: BYAPR02MB5574:
x-microsoft-antispam-prvs: <BYAPR02MB557478E8FD21A5CB49F2F5ABB7F30@BYAPR02MB5574.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(85827821059158)(7411616537696)(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(4982022)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB5574;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5574;
x-forefront-prvs: 084080FC15
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EpHBb+aK+zM0i68vetBXJp2+NtavAHxzkH8Xhd8Crtl1B2DxbzseOMiaYS1IPWOsQsHnp0ucjZ6re2/q1yz5h1BUfXXrUW4RdvsgaHj3CL8ESqnWahCDsWZet/ih7FUUqkuKxwMiYdwAb8I8xXC/MmdHtDWov7JlqcyeIyuV0quQhrZNHhObtKna/nzwIZ5180F0zNR3fwsq5w9zmMs2HGazBwBts06li/EqPGRMQmy1av0u6bAruIUsrWX73DIilL0HfNdIWLAKz4AL0B4TWdgnZlrrb28CdyEuRDcvOPAfS/0ZPR78+Ir5+2QJ+X0w5VAemsy/QeSNngUY2ky2nsvViA2Pat+OH0powccsvPw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d331c2d-6fb5-4e83-0e2b-08d63daaa175
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 14:27:18.0791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 12 October 2018 08:23 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org; sean.wang@mediatek.c=
om;
> m.szyprowski@samsung.com; Michal Simek <michals@xilinx.com>;
> mark.rutland@arm.com; devicetree@vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP =
power
> domain driver
>=20
> On Wed, Oct 10, 2018 at 06:41:44PM +0000, Jolly Shah wrote:
> > Ping for comments
>=20
> Please see my comments on other ZynqMP firmware patches. In summary, I
> need to see a complete binding, not piecemeal additions.
[Rajan] Based on your suggestion to have complete zynqmp firmware binding, =
we can
have two options:

1. Use firmware node instead of having separate subnodes for dependent
drivers(genpd, reset, nvmem, etc). In this case, firmware driver
needs to take care of probing of depedent drivers. We have thought of
MFD approach to probe depedent drivers. Firmware driver would register
depedent drivers as MFD child devices from firmware probe.=20

	firmware {
		zynqmp_firmware: zynqmp-firmware {
			compatible =3D "xlnx,zynqmp-firmware";
			method =3D "smc";
			#power-domain-cells =3D <1>;
		};
	};

	sata {
		...
		power-domains =3D <&zynqmp_firmware 2>;
		...
	};

drivers/firmware/xilinx/zynqmp.c: zynqmp_firmware_probe(struct platform_dev=
ice *pdev)
	static const struct mfd_cell firmware_devs[] =3D {
		{
			.name =3D "zynqmp_power_controller",
		},
	};

	ret =3D mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
				ARRAY_SIZE(firmware_devs), NULL, 0, NULL);

2. Keep separate node for each device outside (in parralel to) zynqmp-firmw=
are node.
In this case, each firmware driver consumer is independet driver/binding.
Order of probe can be taken care by -EPROBE defer mechanism.

Example:
	firmware {
		zynqmp_firmware: zynqmp-firmware {
			compatible =3D "xlnx,zynqmp-firmware";
			method =3D "smc";
		};
	};
	=09
	zynqmp_power_domains: zynqmp-power-domains {
		...
		compatible =3D "xlnx,zynqmp-genpd";
		#power-domain-cells =3D <1>;
		...
	};

	sata {
		...
		power-domains =3D <&zynqmp_power_domains 2>;
		...
	};

Please let us know your inputs and suggest better approach so we can submit
changes accordingly.

Thanks,
Rajan
>=20
> Rob
>=20
> >
> > Thanks,
> > Jolly Shah
> >
> > > -----Original Message-----
> > > From: Jolly Shah [mailto:jolly.shah@xilinx.com]
> > > Sent: Thursday, October 04, 2018 2:24 PM
> > > To: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.or=
g;
> > > geert+renesas@glider.be; bjorn.andersson@linaro.org;
> > > sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> > > <michals@xilinx.com>; robh+dt@kernel.org; mark.rutland@arm.com
> > > Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux=
-arm-
> > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Jolly Shah
> > > <JOLLYS@xilinx.com>
> > > Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP =
power
> > > domain driver
> > >
> > > The zynqmp power domain driver communicates the usage requirements fo=
r
> > > logical power domains / devices to the platform FW.
> > > FW is responsible for choosing appropriate power states, taking Linux=
' usage
> > > information into account.
> > >
> > > This patch series is based on top of Xilinx firmware patch set:
> > > https://patchwork.kernel.org/cover/10555405/
> > >
> > > v3:
> > >  - Changed binding to have FW node as a power controller as suggested=
 by Rob
> > >  - Updated FW driver to register it as mfd child devices from firmwar=
e probe
> > >  - Move bindings location as suggested
> > >
> > > v2:
> > >  - Rebased on top of latest firmware driver patch series
> > >  - Updated driver name from zynqmp-genpd to zynqmp-power-controller
> > >  - Updated device tree bindings to move power controller node under f=
irmware
> > > node
> > >
> > > Jolly Shah (1):
> > >   drivers: soc: xilinx: Add ZynqMP power domain driver
> > >
> > > Rajan Vaja (3):
> > >   dt-bindings: power: Add ZynqMP power domain bindings
> > >   firmware: xilinx: Add APIs to control node status/power
> > >   firmware: xilinx: Add node IDs for zynqmp firmware
> > >
> > >  .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 ++
> > >  drivers/firmware/xilinx/Kconfig                    |   1 +
> > >  drivers/firmware/xilinx/zynqmp.c                   |  73 ++++
> > >  drivers/soc/xilinx/Kconfig                         |   9 +
> > >  drivers/soc/xilinx/Makefile                        |   2 +
> > >  drivers/soc/xilinx/zynqmp_pm_domains.c             | 403
> > > +++++++++++++++++++++
> > >  include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 ++
> > >  include/linux/firmware/xlnx-zynqmp.h               |  98 +++++
> > >  8 files changed, 659 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynq=
mp-
> > > genpd.txt
> > >  create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
> > >  create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
> > >
> > > --
> > > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
