Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E173BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECE32089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JArfD4zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfAGNmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:42:00 -0500
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:2105
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbfAGNmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4MZtIOWlfherQ+v405Uzxiu2uIwgHWmEQNzePwbolo=;
 b=JArfD4zpAbazri44DB5IGDaJlOwphlyKFLTdbPZDpil5ZP+OyweE6wdMcbQLfRp5FL4vXZX2VXsYhqRp8SY1u+FSMZ6d3oHf0pqz2OlzHubDbjaQf1PIUZvED8D+Ov5MHnH6yrZzB46HgDjZ1QMa5z+nVkyaPz1X+yAIZcoXiJw=
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com (52.134.93.10) by
 AM0SPR01MB0047.eurprd08.prod.outlook.com (20.179.32.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Mon, 7 Jan 2019 13:41:53 +0000
Received: from AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::289f:9d33:465:cb4e]) by AM0PR08MB3025.eurprd08.prod.outlook.com
 ([fe80::289f:9d33:465:cb4e%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 13:41:53 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/7] drm/komeda: Add d71_enum_resources and d71_cleanup
Thread-Topic: [PATCH 1/7] drm/komeda: Add d71_enum_resources and d71_cleanup
Thread-Index: AQHUm2bh4e4gRSuN2EiCY9xUuWcr3aWj5q6A
Date:   Mon, 7 Jan 2019 13:41:52 +0000
Message-ID: <20190107134151.uwmjlks5mnkzw6j2@DESKTOP-E1NTVVP.localdomain>
References: <20181224085716.2325-1-james.qian.wang@arm.com>
 <20181224085716.2325-2-james.qian.wang@arm.com>
In-Reply-To: <20181224085716.2325-2-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.54]
x-clientproxiedby: LO2P265CA0342.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::18) To AM0PR08MB3025.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0SPR01MB0047;6:7KPUqgA3WWln2VPtgIA8uaS4dg39eP0xu+97i1pDtMTZtngGzWHS//K/hecIZOkLvh5sOxXvuXuWxDifawyz0NeAMeZFweMq50ML0kYAiQTidTVZMytBPhHrbd01lQjMqa922Rn7u7abmtWprK/aEJ5K7xqYg2JmBAmJJnFxR7zdtAFr4ZAwK/quB55rBerKUTvIgEPPK2zAv6VbJzk64GAPNQwLGfwSUKtJF9fw4GaV9+SDd4FKarvpsHCulzVz31IStmIg1EqhgwGs8zaZaa2f8uw8/W3/GvBx3EZd0kGXNIBf+7f3i5BHvtA1DuEzlrA8YUYTIipGTj6SB2aEz3t0VS7hyOaddTF639+LQhjmqPjV46OTh8coDTIRWVu9hhhsnFbBYzYwlotLEdiF7+9EPGN9sv5O5OWqTbFgQ30UhXBp9m4NjdA02irYJhRRo9+k48bacrMgBjgu2HEXDw==;5:TjxNrV5Qh/IsSST8S7Gl3Q+HdB/c3yHNc+9AzFzSTiyd/c+H7psdrjwr9KMvbEamitWuNy0KpQ7DQXIaaP5YMwU5TwMukYI7RV51wRmhKCjkQUc3j4zH3FjbELy6sB71ZwD1yCr86ZdQO6ed59nSyoIfrpai0QWtp24JSad4Du8s3zHXj9bOlOA00z3mPn3MWnoRLWbmGsY2Zs23U5fpAQ==;7:uxcfoQGfCswwgLftjs7IJxHqBqCgL9SCey6HeHx/DidTpbZXBL2StXlsEQuWA5xLL4Lepv+6N7Ie4GzuPavDBWQ9CinoZjBFaggQZpxPCwbux3rXCS/9RbsoGjeLqBJ6J3VnH/8pAyEpB8RoGa/pCg==
x-ms-office365-filtering-correlation-id: 5e465942-8dd3-4bdc-e4a2-08d674a5e198
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0SPR01MB0047;
x-ms-traffictypediagnostic: AM0SPR01MB0047:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0SPR01MB0047887B85635DC2838632BEF0890@AM0SPR01MB0047.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0SPR01MB0047;BCL:0;PCL:0;RULEID:;SRVR:AM0SPR01MB0047;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(346002)(136003)(199004)(189003)(81156014)(8676002)(81166006)(4326008)(25786009)(97736004)(8936002)(6486002)(486006)(14444005)(1076003)(575784001)(44832011)(6116002)(86362001)(256004)(476003)(6862004)(6246003)(305945005)(6512007)(53936002)(9686003)(6436002)(3846002)(6636002)(386003)(6506007)(6346003)(54906003)(186003)(58126008)(2906002)(26005)(7736002)(316002)(102836004)(446003)(71200400001)(71190400001)(11346002)(52116002)(33896004)(76176011)(14454004)(105586002)(66066001)(5660300001)(229853002)(478600001)(106356001)(68736007)(72206003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0047;H:AM0PR08MB3025.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JqEs7gVVxZza1t1Ln/6OctQdHHiJf7J1eWRs6LD1GXyTeB4Wx5pxt1wcjee50yLm1OlCwhNeZ+Xr9ruj9gMJmMFsyUg03FU7pfFevQqsj/il8YzdOI1fcRa2G6MxRfJnJuE2v/JxSbJoOUTZ59bJEERDi93q2yTvbOXGBXhWRlxtvAzy4NWOb6H7xZRVEnoeQkpphabioo6aPYssh+sNl1rpjIdt1d1iFyf+JlboncnKQk3rrzoaCPPohIOqE/Bx9kmoyXrizplV8X+pmeVjtmaH5nY8mfruUc4muYjyonQkX3wukbMhyApZk4lRX6Ug
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <938754A54DA81E438E53CEA4BF92A3F9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e465942-8dd3-4bdc-e4a2-08d674a5e198
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 13:41:51.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

A few minor comments.

On Mon, Dec 24, 2018 at 08:58:46AM +0000, james qian wang (Arm Technology C=
hina) wrote:
> D71 consists of a number of Register Blocks, every Block controls a
> specific HW function, every block has a common block_header to represent
> its type and pipeline information.
>=20
> GCU (Global Control Unit) is the first Block which describe the global
> information of D71 HW, Like number of block contained and the number of
> pipeline supported.
>=20
> So the d71_enum_resources parsed GCU and create pipeline according
> the GCU configuration, and then iterate and detect the blocks that
> indicated by the GCU and block_header.
>=20
> And this change also added two struct d71_dev/d71_pipeline to extend
> komeda_dev/komeda_pipeline to add some d71 only members.
>=20
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> ---

-- snip --

> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> new file mode 100644
> index 000000000000..a43a2410159f
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#include "d71_dev.h"
> +#include "komeda_kms.h"
> +#include "malidp_io.h"
> +
> +static int d71_layer_init(struct d71_dev *d71,
> +			  struct block_header *blk, u32 __iomem *reg)
> +{
> +	DRM_INFO("Detect D71_Layer.\n");

I think all of these can be DRM_DEBUG.

-- snip --

> =20
>  static int d71_enum_resources(struct komeda_dev *mdev)
>  {
> -	/* TODO add enum resources */
> +	struct d71_dev *d71;
> +	struct komeda_pipeline *pipe;
> +	struct block_header blk;
> +	u32 __iomem *blk_base;
> +	u32 i, value, offset;
> +
> +	d71 =3D devm_kzalloc(mdev->dev, sizeof(*d71), GFP_KERNEL);
> +	if (!d71)
> +		return -ENOMEM;
> +
> +	mdev->chip_data =3D d71;
> +	d71->mdev =3D mdev;
> +	d71->gcu_addr =3D mdev->reg_base;
> +	d71->periph_addr =3D mdev->reg_base + (D71_BLOCK_OFFSET_PERIPH >> 2);
> +
> +	if (d71_reset(d71)) {
> +		DRM_ERROR("Fail to reset d71 device.\n");
> +		goto err_cleanup;
> +	}
> +
> +	/* probe GCU */
> +	value =3D malidp_read32(d71->gcu_addr, GLB_CORE_INFO);
> +	d71->num_blocks =3D value & 0xFF;
> +	d71->num_pipelines =3D (value >> 8) & 0x7;
> +
> +	if (d71->num_pipelines > D71_MAX_PIPELINE) {
> +		DRM_ERROR("d71 supports %d pipelines, but got: %d.\n",
> +			  D71_MAX_PIPELINE, d71->num_pipelines);
> +		goto err_cleanup;
> +	}
> +
> +	/* probe PERIPH */
> +	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
> +	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
> +		DRM_ERROR("access blk periph but got blk: %d.\n",
> +			  BLOCK_INFO_BLK_TYPE(value));
> +		goto err_cleanup;
> +	}
> +
> +	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
> +
> +	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
> +	d71->max_vsize		=3D 4096;
> +	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> +	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : false;
> +	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
> +
> +	for (i =3D 0; i < d71->num_pipelines; i++) {
> +		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline),
> +					   NULL);
> +		if (!pipe)
> +			goto err_cleanup;
> +
> +		d71->pipes[i] =3D to_d71_pipeline(pipe);
> +	}
> +
> +	/* loop the register blks and probe */
> +	i =3D 2; /* exclude GCU and PERIPH */
> +	offset =3D D71_BLOCK_SIZE; /* skip GCU */
> +	while (i < d71->num_blocks) {
> +		blk_base =3D mdev->reg_base + (offset >> 2);
> +
> +		d71_read_block_header(blk_base, &blk);
> +		if (BLOCK_INFO_BLK_TYPE(blk.block_info) !=3D D71_BLK_TYPE_RESERVED) {
> +			if (d71_probe_block(d71, &blk, blk_base))
> +				goto err_cleanup;
> +			i++;
> +		}
> +
> +		offset +=3D D71_BLOCK_SIZE;
> +	}
> +
> +	DRM_INFO("total %d (out of %d) blocks are found.\n",
> +		 i, d71->num_blocks);
> +
> +	return 0;
> +
> +err_cleanup:
> +	d71_cleanup(mdev);
>  	return -1;

-1 isn't a useful error code, and you return -ENOMEM if allocation
fails. It would probably be better to return proper codes everywhere
(e.g. you might get -EINVAL back from d71_probe_block, but you don't
propagate it).

-- snip --

> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/drivers/=
gpu/drm/arm/display/komeda/d71/d71_regs.h
> new file mode 100644
> index 000000000000..2d5e6d00b42c
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h

...

> +
> +/* Image process registers */
> +#define IPS_DEPTH		0x0D8
> +#define IPS_RGB_RGB_COEFF0	0x130
> +#define IPS_RGB_YUV_COEFF0	0x170
> +
> +#define IPS_DEPTH_MARK		0xF

s/MARK/MASK/

Cheers,
-Brian
