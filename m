Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7ACC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3032083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JpNaolSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3032083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeHaQFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:05:02 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:11808
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727207AbeHaQFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXAPT3G2stJblvs5APIDPUVPxKCpQYFVSS1AgzF57xc=;
 b=JpNaolSPicm7OksrRD4P6Hvq5RWfGO9xOr1KPmFvhrIoES4zDZdzm0Lc33U1OB78FXYEZePLz65J7QvAmfsvjo20E3Obm4UrsX2wMqZv8AEB2jgUdj4KQQxe8vUkXYP6GSuHrdyD9nYCcBXJvhDw2t+LeEcB8PYuJpEhURynzH4=
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com (20.177.53.224) by
 VI1PR04MB1293.eurprd04.prod.outlook.com (10.162.121.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.15; Fri, 31 Aug 2018 11:57:48 +0000
Received: from VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::b53b:b04d:6745:43b]) by VI1PR04MB4480.eurprd04.prod.outlook.com
 ([fe80::b53b:b04d:6745:43b%3]) with mapi id 15.20.1080.015; Fri, 31 Aug 2018
 11:57:48 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hch@lst.de" <hch@lst.de>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 0/7 v6] Support for fsl-mc bus and its devices in SMMU
Thread-Topic: [PATCH 0/7 v6] Support for fsl-mc bus and its devices in SMMU
Thread-Index: AQHUF3aiiX6HXhExgka5QqGMpfhCq6TaFH8Q
Date:   Fri, 31 Aug 2018 11:57:48 +0000
Message-ID: <VI1PR04MB4480D192810E7DEB38895F0AE60F0@VI1PR04MB4480.eurprd04.prod.outlook.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1293;6:cDjfSR9O8qTYoqokAvBJIE9bdFmxgNkZ7bQTFDLLlthFyXKE+/3t+txipBx22gSkDx7bosU/aZ38xLRewmLw+k5fKa7lYl5BXQCTAQdOwwx44cIGwXn30iL5qKgYl989EeoFzoptDuycIeas5/C9hIx9wnta7qYftfy0IugmnLqC/gGg3ut8BY/Q9IDNpyjtOpb1dhNIyjCKutfI0sjJPvBtyXitNL6nxjdoL+UC+nNCo+FNYn7iDRZRIGJnKagFckQRvLzDkziWoGs6BJMNkIjM7XhcoXsV+n7D5FQ64SC31LguC5QlsINjPCZNEpEtlJuRg7vYHEVE8dxPxcS281ahMcjsRUZHN9qSht92B5ho7zrFRNrIJth+KW1uX8hMU7uCDKlny3ouE4n/0MkkYOstZXaPQ8AyFyil6l1R7LEUJkzaL17CJHpPRKmPS0bKOckJtslbcCUEqVA12pb5QQ==;5:wabk5vEIK8DkSjRXGICoKmXP1XdN1nr+1gOqkg6VFZ5D4KM5QWcjjXYVOSOvB1n6uLaZK92EphVee9g+nBnTQePKjtF2Rawl9ew6ac1i4l7c4escs9/za7/E4SxuiK2fRIF4+lN0DQ2/KToNnyJUhqAgQqKu6x+uRKWefd7GN8g=;7:CuRnaqXrhgiX+ilbZ4el+dZQOorB9ANrwCyBqA55iuCBOAVBnoU5lhrQgAHQMqNNUcehCY9m9zFR61b0BAWRUifh7NfAswYJmuh3UMnKnLluUO9OzZfoaH1/6wJK1xYXX5NhvCkFUp1yZA9eIt71QnfxjjHo8DpLSoyE0FnniCLy4keQp06ofx6aAL05El+qQROYRgmLsFuaFWgvcjD61Zf5XfoowCMO3z76qbpMZKLaeZFcfA1yA7TKTAHkiiS9
x-ms-office365-filtering-correlation-id: bcbcbe2c-c3c9-43c1-207b-08d60f38f89e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1293;
x-ms-traffictypediagnostic: VI1PR04MB1293:
x-microsoft-antispam-prvs: <VI1PR04MB12930B9CE26369DD044ACA51E60F0@VI1PR04MB1293.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:VI1PR04MB1293;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1293;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(54534003)(13464003)(26005)(81166006)(2201001)(2906002)(81156014)(99286004)(6246003)(53546011)(102836004)(39060400002)(8936002)(186003)(68736007)(256004)(86362001)(14444005)(55016002)(53936002)(54906003)(76176011)(2900100001)(6436002)(6506007)(110136005)(6306002)(316002)(4326008)(55236004)(25786009)(7416002)(2501003)(7696005)(5250100002)(9686003)(966005)(478600001)(6116002)(74316002)(106356001)(97736004)(3846002)(44832011)(486006)(11346002)(305945005)(229853002)(14454004)(33656002)(476003)(446003)(7736002)(105586002)(8676002)(66066001)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1293;H:VI1PR04MB4480.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: psLqTCy09dcp8ZgcQ9JZg2i8zdELkJWv11hDuUKIVUdp7q3MUJWckjClJbLF3jnjcaLggyP3335sL2cfuVxt6NdDzUUoEgNLdkr6bjob0Rzgh3X32Sohy9FeG2aF56cOjotin1p4bMVX5hurhIJSmfiTtbWXzExWm5Do0W8f9CG7PCsbAA99GsusDW4cD5EeENS42a/MK1yDCHZNsYjujk5so2BpyapgKmz5vZH/d1C05RsfXQPoS0ZLFaWwKQBYklGtw+cKEFNuIMnlv9AzUNrkYRTFwTcR8FRNZJRr4uoYV3bCAZJ7ZXuhpxq80aX+fgl/Mh2BkrYaFyFEI0XoLpU91dZmlZ0qMgZ073kxlzE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbcbe2c-c3c9-43c1-207b-08d60f38f89e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 11:57:48.1499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg/Robin,

Can you please let me know when these patches will be applied onto the tree=
.
Is there anything else pending from my side.

Thanks,
Nipun

> -----Original Message-----
> From: Nipun Gupta
> Sent: Monday, July 9, 2018 4:48 PM
> To: robin.murphy@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> robh@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> gregkh@linuxfoundation.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> bhelgaas@google.com; hch@lst.de
> Cc: joro@8bytes.org; m.szyprowski@samsung.com; shawnguo@kernel.org;
> frowand.list@gmail.com; iommu@lists.linux-foundation.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linux-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>
> Subject: [PATCH 0/7 v6] Support for fsl-mc bus and its devices in SMMU
>=20
> This patchset defines IOMMU DT binding for fsl-mc bus and adds
> support in SMMU for fsl-mc bus.
>=20
> The patch series is based on top of dma-mapping tree (for-next branch):
> http://git.infradead.org/users/hch/dma-mapping.git
>=20
> These patches
>   - Define property 'iommu-map' for fsl-mc bus (patch 1)
>   - Integrates the fsl-mc bus with the SMMU using this
>     IOMMU binding (patch 2,3,4)
>   - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
>   - Updates the fsl-mc device node with iommu/dma related changes (patch =
7)
>=20
> Changes in v2:
>   - use iommu-map property for fsl-mc bus
>   - rebase over patchset https://patchwork.kernel.org/patch/10317337/
>     and make corresponding changes for dma configuration of devices on
>     fsl-mc bus
>=20
> Changes in v3:
>   - move of_map_rid in drivers/of/address.c
>=20
> Changes in v4:
>   - move of_map_rid in drivers/of/base.c
>=20
> Changes in v5:
>   - break patch 5 in two separate patches (now patch 5/7 and patch 6/7)
>   - add changelog text in patch 3/7 and patch 5/7
>   - typo fix
>=20
> Changes in v6:
>   - Updated fsl_mc_device_group() API to be more rational
>   - Added dma-coherent property in the LS2 smmu device node
>   - Minor fixes in the device-tree documentation
>=20
> Nipun Gupta (7):
>   Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc
>     bus
>   iommu/of: make of_pci_map_rid() available for other devices too
>   iommu/of: support iommu configuration for fsl-mc devices
>   iommu/arm-smmu: Add support for the fsl-mc bus
>   bus: fsl-mc: support dma configure for devices on fsl-mc bus
>   bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
>   arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
>=20
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   7 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +++-
>  drivers/iommu/arm-smmu.c                           |   7 ++
>  drivers/iommu/iommu.c                              |  13 +++
>  drivers/iommu/of_iommu.c                           |  25 ++++-
>  drivers/of/base.c                                  | 102 +++++++++++++++=
++++++
>  drivers/of/irq.c                                   |   5 +-
>  drivers/pci/of.c                                   | 101 ---------------=
-----
>  include/linux/fsl/mc.h                             |   8 ++
>  include/linux/iommu.h                              |   2 +
>  include/linux/of.h                                 |  11 +++
>  include/linux/of_pci.h                             |  10 --
>  13 files changed, 224 insertions(+), 122 deletions(-)
>=20
> --
> 1.9.1

