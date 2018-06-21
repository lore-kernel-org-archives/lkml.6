Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C29BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF5120652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hf8TB+kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF5120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbeFUD7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:59:34 -0400
Received: from mail-db5eur01on0073.outbound.protection.outlook.com ([104.47.2.73]:15847
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754184AbeFUD7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW/T/u2UGuI2m6DEr26f5rQPVauD0B/+pCKxqgkbUJ8=;
 b=hf8TB+kkhtuBbu3a8bAQikr2xNo4CQvEeeIkTfK2DZzMW82c9001J9KAexM7TFxX1OtduUZUCok8pG559oKTZPU6yA6kfUgPqigMlT0vs+IhjLqQ75NAv9LVGj1YgPpzEM3nXUZzwRUHDAubs7Q/gMZ7RKV5jjcPLh7h3cbpuug=
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com (10.168.33.22) by
 HE1PR0401MB2602.eurprd04.prod.outlook.com (10.168.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Thu, 21 Jun 2018 03:59:27 +0000
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::f443:9368:3f2d:6946]) by HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::f443:9368:3f2d:6946%3]) with mapi id 15.20.0863.016; Thu, 21 Jun 2018
 03:59:27 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: RE: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Thread-Topic: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Thread-Index: AQHT8EF+4+/DGDZvTkihyZH/OaiobaRqQYVQ
Date:   Thu, 21 Jun 2018 03:59:27 +0000
Message-ID: <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2602;7:NsPAuadHasrolNgZlCoqVihu0hZfFLQS/eaXpUp/Ss7Gaoi7RbuKoUclAOPvH5hWo/evOCSxr9DHBWuj869jWKzYuG+GbjCEAoGN5OEemb3IRgmIK0a+BCjAJT8SebJAHL3xHBA0mCBVZPlDmvxp3nDQ94bNrIWhTygD1ucHc9hSAIC2XUh2r3ErH0IBFr++3hIO/kulOW5u12/dpq5PYuO+TqZCAvl52yafU9ZkpDLTSwISzbNmJTcrBDN2Hzhs
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b39fbb2-f7b7-46a2-8d3d-08d5d72b624e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2602;
x-ms-traffictypediagnostic: HE1PR0401MB2602:
x-microsoft-antispam-prvs: <HE1PR0401MB26029DC8E05A85CE3A222AA3E6760@HE1PR0401MB2602.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2602;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2602;
x-forefront-prvs: 07106EF9B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39380400002)(39860400002)(54534003)(13464003)(199004)(189003)(54906003)(68736007)(97736004)(106356001)(105586002)(33656002)(3846002)(74316002)(7736002)(6116002)(305945005)(8676002)(81156014)(81166006)(8936002)(55016002)(6306002)(99286004)(9686003)(6436002)(53936002)(478600001)(3280700002)(110136005)(5250100002)(229853002)(486006)(44832011)(2501003)(186003)(6246003)(14454004)(446003)(476003)(25786009)(966005)(39060400002)(11346002)(4326008)(55236004)(6506007)(7696005)(26005)(102836004)(53546011)(76176011)(2900100001)(2201001)(86362001)(7416002)(66066001)(5660300001)(316002)(2906002)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2602;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2X664q3yLe9UT3bejGz/JTIC5hDw75PBJAbRG5uLEBOSLxy8t3Q9mbWMsM7VzRhIpuXn3tymEgN8A+sIum+QYeLcQu1IhSTWJx7igOOksUfh12yzkrQQcSugBfjzPzKkuEGYYH+x88IAVfyk972pHtfSzktBpy0zEdLnplseImpYs0a6Js16+qgq8/+Tr+vy6KDNQA2o2/8rT+4/gjq3g5Yke4X3pFeEyb+Ez+iMNbxbElgmClC7vfLIlIDjVuClPYCGBEtjH6QXAuwIOHRDfeUEL+VhZz1x5NFSoKuySoWzNIfyVaaYcRbiRiqS2NBjaZhSDGGaFVTd53hrzhlt/w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b39fbb2-f7b7-46a2-8d3d-08d5d72b624e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2018 03:59:27.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2602
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin/Greg k-h,

Will this patch-set be taken for the next kernel release (and via which tre=
e)?

Thanks,
Nipun

> -----Original Message-----
> From: Nipun Gupta
> Sent: Sunday, May 20, 2018 7:20 PM
> To: robin.murphy@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> robh@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> gregkh@linuxfoundation.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> bhelgaas@google.com
> Cc: hch@lst.de; joro@8bytes.org; m.szyprowski@samsung.com;
> shawnguo@kernel.org; frowand.list@gmail.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linu=
x-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>
> Subject: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
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
> Nipun Gupta (7):
>   Docs: dt: add fsl-mc iommu-map device-tree binding
>   iommu: of: make of_pci_map_rid() available for other devices too
>   iommu: support iommu configuration for fsl-mc devices
>   iommu: arm-smmu: Add support for the fsl-mc bus
>   bus: fsl-mc: support dma configure for devices on fsl-mc bus
>   bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
>   arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
>=20
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   6 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +++-
>  drivers/iommu/arm-smmu.c                           |   7 ++
>  drivers/iommu/iommu.c                              |  21 +++++
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
>  13 files changed, 231 insertions(+), 122 deletions(-)
>=20
> --
> 1.9.1

