Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F199CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A86D208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JFSazq54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A86D208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbeGaOtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:49:14 -0400
Received: from mail-eopbgr680077.outbound.protection.outlook.com ([40.107.68.77]:29600
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732099AbeGaOtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26KSjFM+cCmwzoD6trzKDSWHSPouAme5Z3cyTfPmvgo=;
 b=JFSazq54TAjzGVW+LKrOwus8gVl+im23xAMf1fp0u04HqZa4XQ9wwN1QYOYgtuMDYyNSzCzNAOSpkk4+BshdMcBZ+ViTOX5eltOe0PFcC2ZR8nNDNEpQMyCEMuQo2bGEl2JBvYgoCllPc/3lQ0ju5MGR/A5mtEwIe1720JfHky0=
Received: from MWHPR0201MB3481.namprd02.prod.outlook.com (10.167.161.158) by
 MWHPR0201MB3434.namprd02.prod.outlook.com (10.167.161.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Tue, 31 Jul 2018 13:08:49 +0000
Received: from MWHPR0201MB3481.namprd02.prod.outlook.com
 ([fe80::8c23:c29e:5c0a:a63f]) by MWHPR0201MB3481.namprd02.prod.outlook.com
 ([fe80::8c23:c29e:5c0a:a63f%3]) with mapi id 15.20.1017.010; Tue, 31 Jul 2018
 13:08:48 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Nava kishore Manne <navam@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "atull@opensource.altera.com" <atull@opensource.altera.com>,
        "moritz.fischer@ettus.com" <moritz.fischer@ettus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        "atull@kernel.org" <atull@kernel.org>
Subject: RE: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Thread-Topic: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
 Xilinx zynqmp
Thread-Index: AQHUKLX2k+3ZSd5Zw0ya0meNxHewT6SpTZ/g
Date:   Tue, 31 Jul 2018 13:08:48 +0000
Message-ID: <MWHPR0201MB34811402926886136673CE68C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
 <20180801100457.25614-2-nava.manne@xilinx.com>
In-Reply-To: <20180801100457.25614-2-nava.manne@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3434;6:7dUMuUoeNvkH5YPxgJEuA/Oqt1glEAKmrC5pJg02y/0cRoSutHVhqAweJOQw1B9lAeBV+kaXKRntafXkqc2kX+wpCizNkdO2GHjddpqyC2RLkUmBIEmFliofORwPgfeN6HlNdorNFfXbze8pszT/ENILc4Ywj3tNXqkogbSkaIYguBbTdL9OJcHRI/KBfS9tfTOO/O6O9fXw7WfibBVpFzfy17GagXavMDmZas/Cy4rMsabhed8S70iZ/LTmh8mWNhOGaE42077pfW+R4mm/xc9D+xLiS3L/PY+EGt74M66nljC7DAjc5pYmwtFsoo0hrEDzs3p/drgVNILU3aJqTIAXYlxQ7dEzyGL8aZmPXA4bmUeP94RUt0owN0j//tBXo44OvzHiJKlQLdn1sxOBEAzXV9XR8/kfuMjevXyDkdgkVOA4XlPZFg92CGZIOja5/grh//TuMrZT8vDoesbsqg==;5:CZ1lfbItyypt8ycGhXZQIlhCgwN8V88TpZMJri32wMuZWgEbX51xDintAZPqIdq4WLvXOb9lTkaaGtERueiit5U087DtgjBRdawXP1AN57lqlFtlH6WY3IbXivuBN/P1RxDRBW0sDxZViKmiHfSJ1OV3Nc/fpaEqMvy0IskOMLo=;7:10o2tqq3aj0l5/LezJ36mrArvj8jfgkOeZXzEFT+52AfESN7g4XXr0vmxVwYxOEqjeosP0LlSAiOli3TXJPLtihRv1j18j6ginK/Y8NPuhylCflWlfC6jm/oEgTy7y0G+Afaj7NQx8uHVKLziYF0wEkCraaGmcNWElhZ6g/7v+FnvsB/1IG4/UquIeE7Xe3ZliT9LAEfQMUcRg9LdlMESO+t4+68p1H75CA9I0Hy2+WraPGBVMyN4tqetSUOgQiN
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: bcdc01e3-3d3b-44a1-8597-08d5f6e6c15f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3434;
x-ms-traffictypediagnostic: MWHPR0201MB3434:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR0201MB34349B5147D1B0AFCA289CD2C22E0@MWHPR0201MB3434.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(80048183373757)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3434;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3434;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(13464003)(199004)(189003)(6116002)(2906002)(9686003)(3846002)(11346002)(446003)(478600001)(53936002)(26005)(486006)(33656002)(39060400002)(476003)(6436002)(68736007)(55016002)(229853002)(305945005)(5660300001)(99286004)(575784001)(86362001)(25786009)(316002)(8936002)(2201001)(53546011)(6506007)(66066001)(74316002)(256004)(2900100001)(2501003)(6246003)(217873002)(106356001)(102836004)(5250100002)(7696005)(97736004)(76176011)(8676002)(81156014)(14454004)(7736002)(105586002)(81166006)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3434;H:MWHPR0201MB3481.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tSHVeJy+66x42WFDZf6yXXQ2zsu8ZL/2sUQj5Kechd3nyzvlRUr5/oCiIvqLHLOs5MWh+cqnDxzQ3BG1yQQI9XuvWjVTaZIFs2f7Hp/PkkVeUqWhf5ZsMeOYUo+t0r+JMg4eg40xfD2j2fPo8wgf61/jVlKZtdfSlwzhl6w+IgfJz8EVsInsVzNCm3UpuwQdTqhPO1Kmv+W5MxgwKYLzhrU5n2skolLHL5TaiHDiaLPt+zi34zKN7Q1C3jN7YlHGcpqIhmLZZ070zFBCGbazU9Vp1beJDEesS1WE4jvhjt9m72YxD7DK4kY54/kK527v/QsR4Atod+zenUxNwnWelBRVyXEFICx6Nj7+ME6yoV4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdc01e3-3d3b-44a1-8597-08d5f6e6c15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 13:08:48.7315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+Alan Tull,

> -----Original Message-----
> From: Nava kishore Manne [mailto:nava.manne@xilinx.com]
> Sent: Wednesday, August 1, 2018 3:35 PM
> To: robh+dt@kernel.org; mark.rutland@arm.com; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> atull@opensource.altera.com; moritz.fischer@ettus.com; Nava kishore Manne
> <navam@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; chinnikishore369@gmail.com
> Subject: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for
> Xilinx zynqmp
>=20
> This patch adds FPGA Manager support for the Xilinx ZynqMp chip.
>=20
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/Kconfig       |   6 ++
>  drivers/fpga/Makefile      |   1 +
>  drivers/fpga/zynqmp-fpga.c | 164
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 drivers/fpga/zynqmp-fpga.c
>=20
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> cd84934774cc..b84e3555b3e3 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -26,6 +26,12 @@ config FPGA_MGR_ZYNQ_FPGA
>  	help
>  	  FPGA manager driver support for Xilinx Zynq FPGAs.
>=20
> +config FPGA_MGR_ZYNQMP_FPGA
> +	tristate "Xilinx Zynqmp FPGA"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	help
> +	  FPGA manager driver support for Xilinx ZynqMp FPGAs.
> +
>  endif # FPGA
>=20
>  endmenu
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> 8d83fc6b1613..ef444512cb01 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_FPGA)			+=3D fpga-mgr.o
>  # FPGA Manager Drivers
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+=3D socfpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+=3D zynq-fpga.o
> +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+=3D zynqmp-fpga.o
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c new =
file
> mode 100644 index 000000000000..e4172c3a6868
> --- /dev/null
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Xilinx, Inc.
> + *
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/string.h>
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> +
> +/* Constant Definitions */
> +#define IXR_FPGA_DONE_MASK	0X00000008U
> +#define IXR_FPGA_ENCRYPTION_EN	0x00000008U
> +
> +/**
> + * struct zynqmp_fpga_priv - Private data structure
> + * @dev:	Device data structure
> + * @flags:	flags which is used to identify the bitfile type
> + */
> +struct zynqmp_fpga_priv {
> +	struct device *dev;
> +	u32 flags;
> +};
> +
> +static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      const char *buf, size_t size) {
> +	struct zynqmp_fpga_priv *priv;
> +
> +	priv =3D mgr->priv;
> +	priv->flags =3D info->flags;
> +
> +	return 0;
> +}
> +
> +static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> +				 const char *buf, size_t size)
> +{
> +	struct zynqmp_fpga_priv *priv;
> +	char *kbuf;
> +	size_t dma_size;
> +	dma_addr_t dma_addr;
> +	int ret;
> +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->fpga_load)
> +		return -ENXIO;
> +
> +	priv =3D mgr->priv;
> +
> +	if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
> +		dma_size =3D size + ENCRYPTED_KEY_LEN;
> +	else
> +		dma_size =3D size;
> +
> +	kbuf =3D dma_alloc_coherent(priv->dev, dma_size, &dma_addr,
> GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	memcpy(kbuf, buf, size);
> +
> +	if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
> +		memcpy(kbuf + size, mgr->key, ENCRYPTED_KEY_LEN);
> +
> +	wmb(); /* ensure all writes are done before initiate FW call */
> +
> +	if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
> +		ret =3D eemi_ops->fpga_load(dma_addr, dma_addr + size,
> +					  mgr->flags);
> +	else
> +		ret =3D eemi_ops->fpga_load(dma_addr, size, mgr->flags);
> +
> +	dma_free_coherent(priv->dev, dma_size, kbuf, dma_addr);
> +
> +	return ret;
> +}
> +
> +static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
> +					  struct fpga_image_info *info)
> +{
> +	return 0;
> +}
> +
> +static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager
> +*mgr) {
> +	u32 status;
> +	const struct zynqmp_eemi_ops *eemi_ops =3D
> zynqmp_pm_get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->fpga_get_status)
> +		return FPGA_MGR_STATE_UNKNOWN;
> +
> +	eemi_ops->fpga_get_status(&status);
> +	if (status & IXR_FPGA_DONE_MASK)
> +		return FPGA_MGR_STATE_OPERATING;
> +
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static const struct fpga_manager_ops zynqmp_fpga_ops =3D {
> +	.state =3D zynqmp_fpga_ops_state,
> +	.write_init =3D zynqmp_fpga_ops_write_init,
> +	.write =3D zynqmp_fpga_ops_write,
> +	.write_complete =3D zynqmp_fpga_ops_write_complete, };
> +
> +static int zynqmp_fpga_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct zynqmp_fpga_priv *priv;
> +	int err, ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev =3D dev;
> +	ret =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(44));
> +	if (ret < 0)
> +		dev_err(dev, "no usable DMA configuration");
> +
> +	err =3D fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
> +				&zynqmp_fpga_ops, priv);
> +	if (err) {
> +		dev_err(dev, "unable to register FPGA manager");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zynqmp_fpga_remove(struct platform_device *pdev) {
> +	fpga_mgr_unregister(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id zynqmp_fpga_of_match[] =3D {
> +	{ .compatible =3D "xlnx,zynqmp-pcap-fpga", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
> +
> +static struct platform_driver zynqmp_fpga_driver =3D {
> +	.probe =3D zynqmp_fpga_probe,
> +	.remove =3D zynqmp_fpga_remove,
> +	.driver =3D {
> +		.name =3D "zynqmp_fpga_manager",
> +		.of_match_table =3D of_match_ptr(zynqmp_fpga_of_match),
> +	},
> +};
> +
> +module_platform_driver(zynqmp_fpga_driver);
> +
> +MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
> +MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
> +MODULE_LICENSE("GPL");
> --
> 2.18.0

