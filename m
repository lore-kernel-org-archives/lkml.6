Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C52C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B29216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s5PRa59o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B29216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeI0T56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:57:58 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:56206
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeI0T56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d2x6U+HsPh3x/qk3xGO/w7gctz+xwQpAYQdJcWS8i0=;
 b=s5PRa59o8I1dOS78ugsB72O27ndW53PShrVyL3bsMXwC4sEdPt1ASKP3e47z5vG2JyhW1N+kIb1hcNj1PsGu+d0MhkZj0XSEt4l8iBiJQJ8iFAfBZlhHAGHl/IxzEolPLzSzJzE0okq9r0Ko/+CvGqb5iHJTu8NzyJCPTIqQIYA=
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) by
 AM6PR04MB5174.eurprd04.prod.outlook.com (20.177.35.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 13:39:34 +0000
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::acea:2e54:277d:6e77]) by AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::acea:2e54:277d:6e77%5]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 13:39:34 +0000
From:   Madalin-cristian Bucur <madalin.bucur@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Roy Pledge <roy.pledge@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: RE: [PATCH v2 00/22] SMMU enablement for NXP LS1043A and LS1046A
Thread-Topic: [PATCH v2 00/22] SMMU enablement for NXP LS1043A and LS1046A
Thread-Index: AQHUVZwG5yLI/x0ZME+4kUxXl4pUnaUEIrsw
Date:   Thu, 27 Sep 2018 13:39:33 +0000
Message-ID: <AM6PR04MB400811E9B5AD3DD1646D1B9CEC140@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5174;6:ecxpk5Bd8QFeJe/PJXFuNB2GZAMMm3n4qneFV+OgeMel8YXjOxdBBqkOftaOZJdYA/oJoMlHXr1MCNuAmbKsxdZrvoSEXlvwna7vFRa2qQDsz+smhc3UAW5yYV1D77lxJK3Jn7IVUfvErDv4mBg8n9lmhxJe4H7KKBSvOJk5nda1tgajsa+pZG2B2uzhne3R8eGoymhMnR5FCzOWFt2U1+iFfzK8fvp6iqVhW4uEP8+lD8+PmKLMkMV0ya8ALh2XJ15nTIs55Pdtft2TJrD1f+PZpaQBDtC6ACW89lAgTwVp3pe3rKi5UdKrsS2t3uCXlHtzvQ+OPH/sAGnPjQtRwH5hqrEbcOqskMU/wUmvF94rwSyhrCdHiKFYxp1QCA5wvBIpcfLfe1GNfZSda31hXWB7eecbVg0Q1Y+9S/HyWfWBcLNYhLMHN+XJOWN6AilKHhB21v0Fueq/bY4MwxDA4Q==;5:QxRWO6Kgx7TcHd+ooKWUdlakM6O7igOBBDXVdLdWxOxRESqQ2f0Et3KjjOQlVqLSypyrRGqyVTo3Ufp0lCs8M+7/atD2Db9YDjNkhVZ/UiwzrrU53Rbia9LzGLm8t3p/aHvrJbRGGR9oP4uZQvZUnhc+UIr4WBk+9SXXvzG32cM=;7:jZixMhJh5OIfvq5qhlCZM0aECZR52S501p1zoUgKbgNjZw65bAdjpHPYn/RVeunF0a8a4eXWxHqsS3ByO18dVgOysv3ONR+xwaYBrzUCkyA5Vl19vTgRnOsEYNEC3VB25k2gRVXgP1BsOm8vtOonDuJ0ByhTFJewZx1O5ZN/ON3VdnCyeZPV9p8a9iHQHObqXq73f+sNfHttwOUwQRlhaFhTJhEKZffGE16sbOqllU2vHtlbfDTuf0+ZA/4k/9KB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3f14e8cd-a5c1-45c8-5bca-08d6247ea90f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5174;
x-ms-traffictypediagnostic: AM6PR04MB5174:
x-microsoft-antispam-prvs: <AM6PR04MB517456E3B2CC6B07B68F5FD0EC140@AM6PR04MB5174.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(9452136761055)(258649278758335)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB5174;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5174;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(136003)(13464003)(189003)(199004)(71200400001)(486006)(71190400001)(54906003)(3846002)(6116002)(316002)(2501003)(5250100002)(102836004)(81156014)(6506007)(97736004)(99286004)(26005)(81166006)(256004)(110136005)(7696005)(14444005)(76176011)(8936002)(105586002)(106356001)(53546011)(8676002)(7736002)(55016002)(6436002)(25786009)(68736007)(14454004)(5660300001)(305945005)(6246003)(2900100001)(53936002)(2906002)(446003)(86362001)(476003)(33656002)(478600001)(11346002)(9686003)(4326008)(66066001)(229853002)(74316002)(34290500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5174;H:AM6PR04MB4008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PZ8MXpPJA1DFL6eDH7/WwCs4LVwH0GauQzpSYrqDsE4Z9+XL5lSkhqbfjmykMx6RxmYclJqm4yNcW099Oz1316/A5kF+/x7KtKk0JHejNmmOD6A0/jKpJujm/jUEVmHV/b5mbLPD9UjL+r4K6TbGQxTsWQUh1ZG7bgOaCB/NyFJNV9BRKtVpW9I8CqdsDESE0D+svEWSZPI8zHQKgn4ZQNyBqNUhctW/03oY/rh0vj2tokcVIiaozXwLGCTRNW+4SooEzbCJXjaUSjBCAA4REiBSMSvu4q7xXpDhmfUCj2eLRjy0Pw6nW1gOAMjBdZr6OjyywL3SNTOGPQcyrkJKZd0JMNkv+GUbZP5QgbYAHn0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f14e8cd-a5c1-45c8-5bca-08d6247ea90f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 13:39:33.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: laurentiu.tudor@nxp.com [mailto:laurentiu.tudor@nxp.com]
> Sent: Wednesday, September 26, 2018 4:22 PM
> To: devicetree@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Roy Pledge <roy.pledge@nxp.com>; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; davem@davemloft.net; shawnguo@kernel.org; Leo Li
> <leoyang.li@nxp.com>; robin.murphy@arm.com; Bharat Bhushan
> <bharat.bhushan@nxp.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Subject: [PATCH v2 00/22] SMMU enablement for NXP LS1043A and LS1046A
>=20
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> This patch series adds SMMU support for NXP LS1043A and LS1046A chips
> and consists mostly in important driver fixes and the required device
> tree updates. It touches several subsystems and consists of three main
> parts:
>  - changes in soc/drivers/fsl/qbman drivers adding iommu mapping of
>    reserved memory areas, fixes and defered probe support
>  - changes in drivers/net/ethernet/freescale/dpaa_eth drivers
>    consisting in misc dma mapping related fixes and probe ordering
>  - addition of the actual arm smmu device tree node together with
>    various adjustments to the device trees
>=20
> Performance impact
>=20
>     Running iperf benchmarks in a back-to-back setup (both sides
>     having smmu enabled) on a 10GBps port show an important
>     networking performance degradation of around 40% (9.48Gbps
>     linerate vs 5.45Gbps) and around 30%-35% with iommu.strict=3D1.
>     If you need performance but without SMMU support you can use
>     "iommu.passthrough=3D1" to disable SMMU.
>=20
> The patch set is based on net-next so, if generally agreed, I'd suggest
> to get the patches through the netdev tree after getting all the Acks.
>=20
> Changes in v2:
>  - dropped confusing comments in smmu interrupt property (Robin)
>  - add an intermediate simple-bus for usb to fix dma size issue (Robin)
>  - use defines instead of numbers in smmu interrupt definition
>  - drop redundant double iommu_get_domain_for_dev() call in few qbman
>    patches
>=20
> Laurentiu Tudor (22):
>   soc/fsl/qman: fixup liodns only on ppc targets
>   soc/fsl/bman: map FBPR area in the iommu
>   soc/fsl/qman: map FQD and PFDR areas in the iommu
>   soc/fsl/qman-portal: map CENA area in the iommu
>   soc/fsl/qbman: add APIs to retrieve the probing status
>   soc/fsl/qman_portals: defer probe after qman's probe
>   soc/fsl/bman_portals: defer probe after bman's probe
>   soc/fsl/qbman_portals: add APIs to retrieve the probing status
>   fsl/fman: backup and restore ICID registers
>   fsl/fman: add API to get the device behind a fman port
>   dpaa_eth: defer probing after qbman
>   dpaa_eth: base dma mappings on the fman rx port
>   dpaa_eth: fix iova handling for contiguous frames
>   dpaa_eth: fix iova handling for sg frames
>   dpaa_eth: fix SG frame cleanup
>   arm64: dts: ls1046a: add smmu node
>   arm64: dts: ls1043a: add smmu node
>   arm64: dts: ls104xa: set mask to drop TBU ID from StreamID
>   arm64: dts: ls104x: add missing dma ranges property
>   arm64: dts: ls104x: add iommu-map to pci controllers
>   arm64: dts: ls104x: make dma-coherent global to the SoC
>   arm64: dts: ls104x: use a pseudo-bus to constrain usb dma size
>=20
>  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 106 ++++++++++----
>  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 102 ++++++++++---
>  .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 136 ++++++++++++------
>  drivers/net/ethernet/freescale/fman/fman.c    |  35 ++++-
>  drivers/net/ethernet/freescale/fman/fman.h    |   4 +
>  .../net/ethernet/freescale/fman/fman_port.c   |  14 ++
>  .../net/ethernet/freescale/fman/fman_port.h   |   2 +
>  drivers/soc/fsl/qbman/bman_ccsr.c             |  22 +++
>  drivers/soc/fsl/qbman/bman_portal.c           |  20 ++-
>  drivers/soc/fsl/qbman/qman_ccsr.c             |  28 ++++
>  drivers/soc/fsl/qbman/qman_portal.c           |  35 +++++
>  include/soc/fsl/bman.h                        |  16 +++
>  include/soc/fsl/qman.h                        |  17 +++
>  13 files changed, 438 insertions(+), 99 deletions(-)
>=20
> --
> 2.17.1

For the fsl/fman and dpaa_eth:

Acked-by: Madalin Bucur <madalin.bucur@nxp.com>

Thank you
