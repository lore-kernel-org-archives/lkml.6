Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5599C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C73A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dYhuPOCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfA3GYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:24:35 -0500
Received: from mail-eopbgr50040.outbound.protection.outlook.com ([40.107.5.40]:13952
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfA3GYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFNZDUqUPsYrB9Wu0vVAlg9SJRp+XmotYFjMHZg4FwM=;
 b=dYhuPOCm2S9eUGIjNVLGGa27k/cvLVnjRODeI8zEnCpLUdu7OVlFSlEHxU6Gav+DtPb7DnYljt/hi9lL8/sMeCG0h9kS7XuabaF1xVBx1FkowiSprjo8NoS/GLcEJCIL12ATy/LOoznRzYWZIZWxB5M5O1e91lcz1S4GkTcbPsA=
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com (20.177.196.210) by
 AM6PR05MB4407.eurprd05.prod.outlook.com (52.135.162.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 06:24:13 +0000
Received: from AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::b4a6:f55e:1f96:b696]) by AM6PR05MB5224.eurprd05.prod.outlook.com
 ([fe80::b4a6:f55e:1f96:b696%3]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 06:24:13 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Liming Sun <lsun@mellanox.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     Liming Sun <lsun@mellanox.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v8 1/2] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v8 1/2] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Index: AQHUty7mrvrpgQJVskiLrBsGAOA1sqXHSTJA
Date:   Wed, 30 Jan 2019 06:24:12 +0000
Message-ID: <AM6PR05MB522451244C4ECB0E63D69424A2900@AM6PR05MB5224.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1548696487-8840-2-git-send-email-lsun@mellanox.com>
In-Reply-To: <1548696487-8840-2-git-send-email-lsun@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB4407;6:D99oWBeXgJWNPh2+wFKBzBQWkZ2vjI0wRfngMwmhLX32Rd1BkbrJsEV7ifDCfN3ptFRXV8uLAPWXDscly090HY13FUJJW5ajJWbnUtlzSxRvaBmbQ2rMGxMxh1yZlJo6e+vraofH5lAjLhgIFKfsKcrQrHuwOW9a2X4tSjZOf1YGY1hEWrvT/XzwfNNq0FrK0bsjWN8zLte7KFzhvNZgwW8Ce7c2dywXXnLTm1UfXmGsNrkNOoKvGR5jHI7onrpkNs4XRBQTtwq7QNFqDBKyPGgnaK88QnC7av+UNJiBw0D7HXqF+yoR8b4g43fEf7SQrm6fcPzdrNdslYixzoJb4Qay0QWxqrEgrjODSDBm+gZgHDVldulPbRasQSzskI4CUR/uoLqjePZ2jxVBeVvnaiYuGaHSeHw6u3cCm68fX4SnBzk7CW1uw/zbAW5mVqhOFsIW0h+q9xxnWqpjqMmgKg==;5:D5W9k9/p2ZdTpLJIsFH/UzSruFHH5wzhgPUxA7UojpQV7hW9EErDK7jiuzYqyrGkvqPInytlvAcE8GExMmN78ZsLcG2lz0ap5essxZJsP01zRFuo/dhVb03LPvudMUfYazbHMjdESv46Aj/ZAjouFutXZWRBUoInOi1BzIRIcyRMn1jgyXFjcEsUyjGMUwkR67ENd7V09veUWd10P6H+2Q==;7:KsX7IFgpt/6fZgHO4dL8finwrqecO6w1mcI3HDJ2HiDzfsb8lSLKJ3e9hBsgVoRbmD1/EiPCY2aOBdUxr3YvL05EIjSVsvInsLLhQsA0Guvqjzm5pt6bvyf8C+hKgeM7gKjz+WsTrVrJ7R+EfaibJg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e5862cd1-fbe5-4fd9-9880-08d6867b8d6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4407;
x-ms-traffictypediagnostic: AM6PR05MB4407:
x-microsoft-antispam-prvs: <AM6PR05MB4407AC9F1E1958B4A1828E1CA2900@AM6PR05MB4407.eurprd05.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(13464003)(53546011)(53936002)(9686003)(71190400001)(486006)(71200400001)(55016002)(11346002)(446003)(110136005)(54906003)(74316002)(305945005)(7736002)(6506007)(99286004)(476003)(102836004)(86362001)(33656002)(68736007)(30864003)(7696005)(53946003)(76176011)(6246003)(2906002)(6116002)(6436002)(256004)(3846002)(8676002)(14444005)(229853002)(81156014)(97736004)(81166006)(4326008)(66066001)(105586002)(26005)(25786009)(14454004)(478600001)(186003)(106356001)(8936002)(316002)(21314003)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4407;H:AM6PR05MB5224.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8x/Kz419BMrnh84Sj/VYE6YgULRplFqLyZQv19bXx/BRxcfDudlSKEc7SuKysK9xLNaWwI0Ijjrks+Pdn51BdjIUTELqjeGGBl8gZ7LfLk0lYYEhN75qkvZPOOaMQaoPeoyMjqyMhbZeD3HQiu4fC05+/Go8OAfji+Ks/LgrzNsxbEE+hUAXJXNPMPyT5/qIRm3H0q8MrkdP16u++0pavWVIGcvELVgxFz6xQcZNImrn+RVjW23qq59WTZ3+JrSfukO0GFr10jncef1a67+s5C7t9sxvJYAsheP6paqEKNXrJcykpLHuqn/g8SqFbNL0ZdwRL3ToHuxhbL/EovIcv4/HOKV5OCzmByTuhLlu3kGUWSR2mFKt7eTCWRGgwEbM/zgMlMKfrmX9QsYRB+te9IBHY5knFggKsjH8a0Hyn0U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5862cd1-fbe5-4fd9-9880-08d6867b8d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 06:24:12.9716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Liming Sun <lsun@mellanox.com>
> Sent: Monday, January 28, 2019 7:28 PM
> To: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Arnd Bergmann <arnd@arndb.de>; David Woods
> <dwoods@mellanox.com>; Andy Shevchenko <andy@infradead.org>; Darren
> Hart <dvhart@infradead.org>; Vadim Pasternak <vadimp@mellanox.com>
> Cc: Liming Sun <lsun@mellanox.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
> Subject: [PATCH v8 1/2] platform/mellanox: Add TmFifo driver for Mellanox
> BlueField Soc
>=20
> This commit adds the TmFifo platform driver for Mellanox BlueField Soc. T=
mFifo
> is a shared FIFO which enables external host machine to exchange data wit=
h the
> SoC via USB or PCIe. The driver is based on virtio framework and has cons=
ole
> and network access enabled.
>=20
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> ---
>  drivers/platform/mellanox/Kconfig             |   13 +-
>  drivers/platform/mellanox/Makefile            |    1 +
>  drivers/platform/mellanox/mlxbf-tmfifo-regs.h |   67 ++
>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 1289
> +++++++++++++++++++++++++
>  4 files changed, 1369 insertions(+), 1 deletion(-)  create mode 100644
> drivers/platform/mellanox/mlxbf-tmfifo-regs.h
>  create mode 100644 drivers/platform/mellanox/mlxbf-tmfifo.c
>=20
> diff --git a/drivers/platform/mellanox/Kconfig
> b/drivers/platform/mellanox/Kconfig
> index cd8a908..a565070 100644
> --- a/drivers/platform/mellanox/Kconfig
> +++ b/drivers/platform/mellanox/Kconfig
> @@ -5,7 +5,7 @@
>=20
>  menuconfig MELLANOX_PLATFORM
>  	bool "Platform support for Mellanox hardware"
> -	depends on X86 || ARM || COMPILE_TEST
> +	depends on X86 || ARM || ARM64 || COMPILE_TEST
>  	---help---
>  	  Say Y here to get to see options for platform support for
>  	  Mellanox systems. This option alone does not add any kernel code.
> @@ -34,4 +34,15 @@ config MLXREG_IO
>  	  to system resets operation, system reset causes monitoring and some
>  	  kinds of mux selection.
>=20
> +config MLXBF_TMFIFO
> +	tristate "Mellanox BlueField SoC TmFifo platform driver"
> +	depends on ARM64

Why you make it dependent on ARM64?
Should not it work on any host, x86?

> +	default m

User who needs it should select this option.
No need default 'm'.

> +	select VIRTIO_CONSOLE
> +	select VIRTIO_NET
> +	help
> +	  Say y here to enable TmFifo support. The TmFifo driver provides
> +          platform driver support for the TmFifo which supports console
> +          and networking based on the virtio framework.
> +
>  endif # MELLANOX_PLATFORM
> diff --git a/drivers/platform/mellanox/Makefile
> b/drivers/platform/mellanox/Makefile
> index 57074d9c..f0c061d 100644
> --- a/drivers/platform/mellanox/Makefile
> +++ b/drivers/platform/mellanox/Makefile
> @@ -5,3 +5,4 @@
>  #
>  obj-$(CONFIG_MLXREG_HOTPLUG)	+=3D mlxreg-hotplug.o
>  obj-$(CONFIG_MLXREG_IO) +=3D mlxreg-io.o
> +obj-$(CONFIG_MLXBF_TMFIFO)	+=3D mlxbf-tmfifo.o
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
> b/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
> new file mode 100644
> index 0000000..90c9c2cf
> --- /dev/null
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
> + */
> +
> +#ifndef __MLXBF_TMFIFO_REGS_H__
> +#define __MLXBF_TMFIFO_REGS_H__
> +
> +#include <linux/types.h>
> +
> +#define MLXBF_TMFIFO_TX_DATA 0x0
> +
> +#define MLXBF_TMFIFO_TX_STS 0x8
> +#define MLXBF_TMFIFO_TX_STS__LENGTH 0x0001 #define
> +MLXBF_TMFIFO_TX_STS__COUNT_SHIFT 0 #define
> +MLXBF_TMFIFO_TX_STS__COUNT_WIDTH 9 #define
> +MLXBF_TMFIFO_TX_STS__COUNT_RESET_VAL 0 #define
> +MLXBF_TMFIFO_TX_STS__COUNT_RMASK 0x1ff #define
> +MLXBF_TMFIFO_TX_STS__COUNT_MASK  0x1ff
> +
> +#define MLXBF_TMFIFO_TX_CTL 0x10
> +#define MLXBF_TMFIFO_TX_CTL__LENGTH 0x0001 #define
> +MLXBF_TMFIFO_TX_CTL__LWM_SHIFT 0 #define
> MLXBF_TMFIFO_TX_CTL__LWM_WIDTH
> +8 #define MLXBF_TMFIFO_TX_CTL__LWM_RESET_VAL 128 #define
> +MLXBF_TMFIFO_TX_CTL__LWM_RMASK 0xff #define
> +MLXBF_TMFIFO_TX_CTL__LWM_MASK  0xff #define
> +MLXBF_TMFIFO_TX_CTL__HWM_SHIFT 8 #define
> MLXBF_TMFIFO_TX_CTL__HWM_WIDTH
> +8 #define MLXBF_TMFIFO_TX_CTL__HWM_RESET_VAL 128 #define
> +MLXBF_TMFIFO_TX_CTL__HWM_RMASK 0xff #define
> +MLXBF_TMFIFO_TX_CTL__HWM_MASK  0xff00 #define
> +MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_SHIFT 32 #define
> +MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_WIDTH 9 #define
> +MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_RESET_VAL 256 #define
> +MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_RMASK 0x1ff #define
> +MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_MASK  0x1ff00000000ULL
> +
> +#define MLXBF_TMFIFO_RX_DATA 0x0
> +
> +#define MLXBF_TMFIFO_RX_STS 0x8
> +#define MLXBF_TMFIFO_RX_STS__LENGTH 0x0001 #define
> +MLXBF_TMFIFO_RX_STS__COUNT_SHIFT 0 #define
> +MLXBF_TMFIFO_RX_STS__COUNT_WIDTH 9 #define
> +MLXBF_TMFIFO_RX_STS__COUNT_RESET_VAL 0 #define
> +MLXBF_TMFIFO_RX_STS__COUNT_RMASK 0x1ff #define
> +MLXBF_TMFIFO_RX_STS__COUNT_MASK  0x1ff
> +
> +#define MLXBF_TMFIFO_RX_CTL 0x10
> +#define MLXBF_TMFIFO_RX_CTL__LENGTH 0x0001 #define
> +MLXBF_TMFIFO_RX_CTL__LWM_SHIFT 0 #define
> MLXBF_TMFIFO_RX_CTL__LWM_WIDTH
> +8 #define MLXBF_TMFIFO_RX_CTL__LWM_RESET_VAL 128 #define
> +MLXBF_TMFIFO_RX_CTL__LWM_RMASK 0xff #define
> +MLXBF_TMFIFO_RX_CTL__LWM_MASK  0xff #define
> +MLXBF_TMFIFO_RX_CTL__HWM_SHIFT 8 #define
> MLXBF_TMFIFO_RX_CTL__HWM_WIDTH
> +8 #define MLXBF_TMFIFO_RX_CTL__HWM_RESET_VAL 128 #define
> +MLXBF_TMFIFO_RX_CTL__HWM_RMASK 0xff #define
> +MLXBF_TMFIFO_RX_CTL__HWM_MASK  0xff00 #define
> +MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_SHIFT 32 #define
> +MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_WIDTH 9 #define
> +MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RESET_VAL 256 #define
> +MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RMASK 0x1ff #define
> +MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK  0x1ff00000000ULL
> +
> +#endif /* !defined(__MLXBF_TMFIFO_REGS_H__) */
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c
> b/drivers/platform/mellanox/mlxbf-tmfifo.c
> new file mode 100644
> index 0000000..c1afe47
> --- /dev/null
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -0,0 +1,1289 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Mellanox BlueField SoC TmFifo driver
> + *
> + * Copyright (C) 2019 Mellanox Technologies  */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/cache.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/efi.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_console.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_net.h>
> +#include <linux/virtio_ring.h>
> +#include <asm/byteorder.h>

Is it must ti include from asm?
Could it be replaced with something like
#include <linux/byteorder/generic.h>

> +
> +#include "mlxbf-tmfifo-regs.h"
> +
> +/* Vring size. */
> +#define MLXBF_TMFIFO_VRING_SIZE			1024
> +
> +/* Console Tx buffer size. */
> +#define MLXBF_TMFIFO_CONS_TX_BUF_SIZE		(32 * 1024)
> +
> +/* House-keeping timer interval. */
> +static int mlxbf_tmfifo_timer_interval =3D HZ / 10;
> +
> +/* Global lock. */
> +static DEFINE_MUTEX(mlxbf_tmfifo_lock);
> +
> +/* Virtual devices sharing the TM FIFO. */
> +#define MLXBF_TMFIFO_VDEV_MAX		(VIRTIO_ID_CONSOLE + 1)
> +
> +/* Struct declaration. */
> +struct mlxbf_tmfifo;
> +
> +/* Structure to maintain the ring state. */ struct mlxbf_tmfifo_vring {
> +	void *va;			/* virtual address */
> +	dma_addr_t dma;			/* dma address */
> +	struct virtqueue *vq;		/* virtqueue pointer */
> +	struct vring_desc *desc;	/* current desc */
> +	struct vring_desc *desc_head;	/* current desc head */
> +	int cur_len;			/* processed len in current desc */
> +	int rem_len;			/* remaining length to be processed */
> +	int size;			/* vring size */
> +	int align;			/* vring alignment */
> +	int id;				/* vring id */
> +	int vdev_id;			/* TMFIFO_VDEV_xxx */
> +	u32 pkt_len;			/* packet total length */
> +	__virtio16 next_avail;		/* next avail desc id */
> +	struct mlxbf_tmfifo *fifo;	/* pointer back to the tmfifo */
> +};
> +
> +/* Interrupt types. */
> +enum {
> +	MLXBF_TM_RX_LWM_IRQ,		/* Rx low water mark irq */
> +	MLXBF_TM_RX_HWM_IRQ,		/* Rx high water mark irq */
> +	MLXBF_TM_TX_LWM_IRQ,		/* Tx low water mark irq */
> +	MLXBF_TM_TX_HWM_IRQ,		/* Tx high water mark irq */
> +	MLXBF_TM_IRQ_CNT
> +};
> +
> +/* Ring types (Rx & Tx). */
> +enum {
> +	MLXBF_TMFIFO_VRING_RX,		/* Rx ring */
> +	MLXBF_TMFIFO_VRING_TX,		/* Tx ring */
> +	MLXBF_TMFIFO_VRING_NUM
> +};
> +
> +struct mlxbf_tmfifo_vdev {
> +	struct virtio_device vdev;	/* virtual device */
> +	u8 status;
> +	u64 features;
> +	union {				/* virtio config space */
> +		struct virtio_console_config cons;
> +		struct virtio_net_config net;
> +	} config;
> +	struct mlxbf_tmfifo_vring vrings[MLXBF_TMFIFO_VRING_NUM];
> +	u8 *tx_buf;			/* tx buffer */
> +	u32 tx_head;			/* tx buffer head */
> +	u32 tx_tail;			/* tx buffer tail */
> +};
> +
> +struct mlxbf_tmfifo_irq_info {
> +	struct mlxbf_tmfifo *fifo;	/* tmfifo structure */
> +	int irq;			/* interrupt number */
> +	int index;			/* array index */
> +};
> +
> +/* TMFIFO device structure */
> +struct mlxbf_tmfifo {
> +	struct mlxbf_tmfifo_vdev *vdev[MLXBF_TMFIFO_VDEV_MAX]; /*
> devices */
> +	struct platform_device *pdev;	/* platform device */
> +	struct mutex lock;		/* fifo lock */
> +	void __iomem *rx_base;		/* mapped register base */
> +	void __iomem *tx_base;		/* mapped register base */
> +	int tx_fifo_size;		/* number of entries of the Tx FIFO */
> +	int rx_fifo_size;		/* number of entries of the Rx FIFO */
> +	unsigned long pend_events;	/* pending bits for deferred process */
> +	struct mlxbf_tmfifo_irq_info irq_info[MLXBF_TM_IRQ_CNT]; /* irq info
> */
> +	struct work_struct work;	/* work struct for deferred process */
> +	struct timer_list timer;	/* keepalive timer */
> +	struct mlxbf_tmfifo_vring *vring[2];	/* current Tx/Rx ring */
> +	bool is_ready;			/* ready flag */
> +	spinlock_t spin_lock;		/* spin lock */
> +};
> +
> +union mlxbf_tmfifo_msg_hdr {
> +	struct {
> +		u8 type;		/* message type */
> +		__be16 len;		/* payload length */
> +		u8 unused[5];		/* reserved, set to 0 */
> +	} __packed;
> +	u64 data;
> +};
> +
> +/*
> + * Default MAC.
> + * This MAC address will be read from EFI persistent variable if configu=
red.
> + * It can also be reconfigured with standard Linux tools.
> + */
> +static u8 mlxbf_tmfifo_net_default_mac[6] =3D {
> +	0x00, 0x1A, 0xCA, 0xFF, 0xFF, 0x01};
> +
> +/* MTU setting of the virtio-net interface. */
> +#define MLXBF_TMFIFO_NET_MTU		1500
> +
> +/* Maximum L2 header length. */
> +#define MLXBF_TMFIFO_NET_L2_OVERHEAD	36
> +
> +/* Supported virtio-net features. */
> +#define MLXBF_TMFIFO_NET_FEATURES	((1UL << VIRTIO_NET_F_MTU)
> | \
> +					 (1UL << VIRTIO_NET_F_STATUS) | \
> +					 (1UL << VIRTIO_NET_F_MAC))
> +
> +/* Return the consumed Tx buffer space. */ static int
> +mlxbf_tmfifo_vdev_tx_buf_len(struct mlxbf_tmfifo_vdev *vdev) {
> +	return ((vdev->tx_tail >=3D vdev->tx_head) ?
> +	       (vdev->tx_tail - vdev->tx_head) :
> +	       (MLXBF_TMFIFO_CONS_TX_BUF_SIZE - vdev->tx_head +
> +vdev->tx_tail)); }

I would suggest to split the above.=20

> +
> +/* Return the available Tx buffer space. */ static int
> +mlxbf_tmfifo_vdev_tx_buf_avail(struct mlxbf_tmfifo_vdev *vdev) {
> +	return (MLXBF_TMFIFO_CONS_TX_BUF_SIZE - 8 -

Thins about some extra define for
"MLXBF_TMFIFO_CONS_TX_BUF_SIZE - 8"

> +		mlxbf_tmfifo_vdev_tx_buf_len(vdev));
> +}
> +
> +/* Update Tx buffer pointer after pushing data. */ static void
> +mlxbf_tmfifo_vdev_tx_buf_push(struct mlxbf_tmfifo_vdev *vdev,
> +					  u32 len)
> +{
> +	vdev->tx_tail +=3D len;
> +	if (vdev->tx_tail >=3D MLXBF_TMFIFO_CONS_TX_BUF_SIZE)
> +		vdev->tx_tail -=3D MLXBF_TMFIFO_CONS_TX_BUF_SIZE; }
> +
> +/* Update Tx buffer pointer after popping data. */ static void
> +mlxbf_tmfifo_vdev_tx_buf_pop(struct mlxbf_tmfifo_vdev *vdev,
> +					 u32 len)
> +{
> +	vdev->tx_head +=3D len;
> +	if (vdev->tx_head >=3D MLXBF_TMFIFO_CONS_TX_BUF_SIZE)
> +		vdev->tx_head -=3D MLXBF_TMFIFO_CONS_TX_BUF_SIZE; }
> +
> +/* Allocate vrings for the fifo. */
> +static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
> +				     struct mlxbf_tmfifo_vdev *tm_vdev,
> +				     int vdev_id)
> +{
> +	struct mlxbf_tmfifo_vring *vring;
> +	dma_addr_t dma;
> +	int i, size;
> +	void *va;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
> +		vring =3D &tm_vdev->vrings[i];
> +		vring->fifo =3D fifo;
> +		vring->size =3D MLXBF_TMFIFO_VRING_SIZE;
> +		vring->align =3D SMP_CACHE_BYTES;
> +		vring->id =3D i;
> +		vring->vdev_id =3D vdev_id;
> +
> +		size =3D PAGE_ALIGN(vring_size(vring->size, vring->align));
> +		va =3D dma_alloc_coherent(tm_vdev->vdev.dev.parent, size,
> &dma,
> +					GFP_KERNEL);
> +		if (!va) {
> +			dev_err(tm_vdev->vdev.dev.parent,
> +				"vring allocation failed\n");
> +			return -EINVAL;
> +		}
> +
> +		vring->va =3D va;
> +		vring->dma =3D dma;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Free vrings of the fifo device. */
> +static void mlxbf_tmfifo_free_vrings(struct mlxbf_tmfifo *fifo, int
> +vdev_id) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev =3D fifo->vdev[vdev_id];
> +	struct mlxbf_tmfifo_vring *vring;
> +	int i, size;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
> +		vring =3D &tm_vdev->vrings[i];
> +
> +		size =3D PAGE_ALIGN(vring_size(vring->size, vring->align));
> +		if (vring->va) {
> +			dma_free_coherent(tm_vdev->vdev.dev.parent, size,
> +					  vring->va, vring->dma);
> +			vring->va =3D NULL;
> +			if (vring->vq) {
> +				vring_del_virtqueue(vring->vq);
> +				vring->vq =3D NULL;
> +			}
> +		}
> +	}
> +}
> +
> +/* Free interrupts of the fifo device. */ static void
> +mlxbf_tmfifo_free_irqs(struct mlxbf_tmfifo *fifo) {
> +	int i, irq;
> +
> +	for (i =3D 0; i < MLXBF_TM_IRQ_CNT; i++) {
> +		irq =3D fifo->irq_info[i].irq;
> +		if (irq) {
> +			fifo->irq_info[i].irq =3D 0;
> +			disable_irq(irq);
> +			free_irq(irq, (u8 *)fifo + i);
> +		}
> +	}
> +}
> +
> +/* Interrupt handler. */
> +static irqreturn_t mlxbf_tmfifo_irq_handler(int irq, void *arg) {
> +	struct mlxbf_tmfifo_irq_info *irq_info;
> +
> +	irq_info =3D (struct mlxbf_tmfifo_irq_info *)arg;
> +
> +	if (irq_info->index < MLXBF_TM_IRQ_CNT &&
> +	    !test_and_set_bit(irq_info->index, &irq_info->fifo->pend_events))
> +		schedule_work(&irq_info->fifo->work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Nothing to do for now. */
> +static void mlxbf_tmfifo_virtio_dev_release(struct device *dev) { }

If there is nothing to do - no reason to have it.

> +
> +/* Get the next packet descriptor from the vring. */ static inline
> +struct vring_desc * mlxbf_tmfifo_virtio_get_next_desc(struct virtqueue
> +*vq) {
> +	struct mlxbf_tmfifo_vring *vring;
> +	unsigned int idx, head;
> +	struct vring *vr;
> +
> +	vring =3D (struct mlxbf_tmfifo_vring *)vq->priv;
> +	vr =3D (struct vring *)virtqueue_get_vring(vq);
> +
> +	if (!vr || vring->next_avail =3D=3D vr->avail->idx)
> +		return NULL;
> +
> +	idx =3D vring->next_avail % vr->num;
> +	head =3D vr->avail->ring[idx];
> +	BUG_ON(head >=3D vr->num);
> +	vring->next_avail++;
> +	return &vr->desc[head];
> +}
> +
> +static inline void mlxbf_tmfifo_virtio_release_desc(
> +	struct virtio_device *vdev, struct vring *vr,
> +	struct vring_desc *desc, u32 len)
> +{
> +	unsigned int idx;
> +
> +	idx =3D vr->used->idx % vr->num;
> +	vr->used->ring[idx].id =3D desc - vr->desc;
> +	vr->used->ring[idx].len =3D cpu_to_virtio32(vdev, len);
> +
> +	/* Virtio could poll and check the 'idx' to decide
> +	 * whether the desc is done or not. Add a memory
> +	 * barrier here to make sure the update above completes
> +	 * before updating the idx.
> +	 */
> +	mb();
> +	vr->used->idx++;
> +}
> +
> +/* Get the total length of a descriptor chain. */ static inline u32
> +mlxbf_tmfifo_virtio_get_pkt_len(struct virtio_device *vdev,
> +						  struct vring_desc *desc,
> +						  struct vring *vr)
> +{
> +	u32 len =3D 0, idx;
> +
> +	while (desc) {
> +		len +=3D virtio32_to_cpu(vdev, desc->len);
> +		if (!(virtio16_to_cpu(vdev, desc->flags) &
> VRING_DESC_F_NEXT))
> +			break;
> +		idx =3D virtio16_to_cpu(vdev, desc->next);
> +		desc =3D &vr->desc[idx];
> +	}
> +
> +	return len;
> +}
> +
> +static void mlxbf_tmfifo_release_pkt(struct virtio_device *vdev,
> +				     struct mlxbf_tmfifo_vring *vring,
> +				     struct vring_desc **desc)
> +{
> +	struct vring *vr =3D (struct vring *)virtqueue_get_vring(vring->vq);
> +	struct vring_desc *desc_head;
> +	uint32_t pkt_len =3D 0;
> +
> +	if (!vr)
> +		return;
> +
> +	if (desc !=3D NULL && *desc !=3D NULL && vring->desc_head !=3D NULL) {
> +		desc_head =3D vring->desc_head;
> +		pkt_len =3D vring->pkt_len;
> +	} else {
> +		desc_head =3D mlxbf_tmfifo_virtio_get_next_desc(vring->vq);
> +		if (desc_head !=3D NULL) {
> +			pkt_len =3D mlxbf_tmfifo_virtio_get_pkt_len(
> +				vdev, desc_head, vr);
> +		}
> +	}
> +
> +	if (desc_head !=3D NULL)
> +		mlxbf_tmfifo_virtio_release_desc(vdev, vr, desc_head,
> pkt_len);
> +
> +	if (desc !=3D NULL)
> +		*desc =3D NULL;
> +	vring->pkt_len =3D 0;
> +}
> +
> +/* House-keeping timer. */
> +static void mlxbf_tmfifo_timer(struct timer_list *arg) {
> +	struct mlxbf_tmfifo *fifo;
> +
> +	fifo =3D container_of(arg, struct mlxbf_tmfifo, timer);
> +
> +	/*
> +	 * Wake up the work handler to poll the Rx FIFO in case interrupt
> +	 * missing or any leftover bytes stuck in the FIFO.
> +	 */
> +	test_and_set_bit(MLXBF_TM_RX_HWM_IRQ, &fifo->pend_events);
> +
> +	/*
> +	 * Wake up Tx handler in case virtio has queued too many packets
> +	 * and are waiting for buffer return.
> +	 */
> +	test_and_set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events);
> +
> +	schedule_work(&fifo->work);
> +
> +	mod_timer(&fifo->timer, jiffies + mlxbf_tmfifo_timer_interval); }
> +
> +/* Buffer the console output. */
> +static void mlxbf_tmfifo_console_output(struct mlxbf_tmfifo_vdev *cons,
> +					struct virtqueue *vq)
> +{
> +	struct vring *vr =3D (struct vring *)virtqueue_get_vring(vq);
> +	struct vring_desc *head_desc, *desc =3D NULL;
> +	struct virtio_device *vdev =3D &cons->vdev;
> +	u32 len, pkt_len, idx;
> +	void *addr;
> +
> +	for (;;) {

It's better to modify it as while(on some condition)

> +		head_desc =3D mlxbf_tmfifo_virtio_get_next_desc(vq);
> +		if (head_desc =3D=3D NULL)
> +			break;
> +
> +		/* Release the packet if no more space. */
> +		pkt_len =3D mlxbf_tmfifo_virtio_get_pkt_len(vdev, head_desc,
> vr);
> +		if (pkt_len > mlxbf_tmfifo_vdev_tx_buf_avail(cons)) {
> +			mlxbf_tmfifo_virtio_release_desc(vdev, vr, head_desc,
> +							 pkt_len);

Why do you break line here?

> +			break;
> +		}
> +
> +		desc =3D head_desc;
> +
> +		while (desc !=3D NULL) {
> +			addr =3D phys_to_virt(virtio64_to_cpu(vdev, desc->addr));
> +			len =3D virtio32_to_cpu(vdev, desc->len);
> +
> +			if (len <=3D MLXBF_TMFIFO_CONS_TX_BUF_SIZE -
> +			    cons->tx_tail) {

Why do you break line here? Also below I see few strange breaks.

> +				memcpy(cons->tx_buf + cons->tx_tail, addr,
> len);
> +			} else {
> +				u32 seg;
> +
> +				seg =3D MLXBF_TMFIFO_CONS_TX_BUF_SIZE -
> +					cons->tx_tail;
> +				memcpy(cons->tx_buf + cons->tx_tail, addr,
> seg);
> +				addr +=3D seg;
> +				memcpy(cons->tx_buf, addr, len - seg);
> +			}
> +			mlxbf_tmfifo_vdev_tx_buf_push(cons, len);
> +
> +			if (!(virtio16_to_cpu(vdev, desc->flags) &
> +			    VRING_DESC_F_NEXT))
> +				break;
> +			idx =3D virtio16_to_cpu(vdev, desc->next);
> +			desc =3D &vr->desc[idx];
> +		}
> +
> +		mlxbf_tmfifo_virtio_release_desc(vdev, vr, head_desc,
> pkt_len);
> +	}
> +}
> +
> +/* Rx & Tx processing of a virtual queue. */ static void
> +mlxbf_tmfifo_virtio_rxtx(struct virtqueue *vq, bool is_rx) {
> +	int num_avail =3D 0, hdr_len, tx_reserve;
> +	struct mlxbf_tmfifo_vring *vring;
> +	struct mlxbf_tmfifo_vdev *cons;
> +	struct virtio_device *vdev;
> +	struct mlxbf_tmfifo *fifo;
> +	struct vring_desc *desc;
> +	unsigned long flags;
> +	struct vring *vr;
> +	u64 sts, data;
> +	u32 len, idx;
> +	void *addr;
> +
> +	if (!vq)
> +		return;
> +
> +	vring =3D (struct mlxbf_tmfifo_vring *)vq->priv;
> +	fifo =3D vring->fifo;
> +	vr =3D (struct vring *)virtqueue_get_vring(vq);
> +
> +	if (!fifo->vdev[vring->vdev_id])
> +		return;
> +	vdev =3D &fifo->vdev[vring->vdev_id]->vdev;
> +	cons =3D fifo->vdev[VIRTIO_ID_CONSOLE];
> +
> +	/* Don't continue if another vring is running. */
> +	if (fifo->vring[is_rx] !=3D NULL && fifo->vring[is_rx] !=3D vring)
> +		return;
> +
> +	/* tx_reserve is used to reserved some room in FIFO for console. */
> +	if (vring->vdev_id =3D=3D VIRTIO_ID_NET) {
> +		hdr_len =3D sizeof(struct virtio_net_hdr);
> +		tx_reserve =3D fifo->tx_fifo_size / 16;

Use some define instead of 16/

> +	} else {
> +		BUG_ON(vring->vdev_id !=3D VIRTIO_ID_CONSOLE);
> +		hdr_len =3D 0;
> +		tx_reserve =3D 1;
> +	}
> +
> +	desc =3D vring->desc;
> +
> +	while (1) {

I see there are few drivers in platform which use while (1)
But it looks better to use while(some condition)
and instead of break change this condition to false.

> +		/* Get available FIFO space. */
> +		if (num_avail =3D=3D 0) {
> +			if (is_rx) {
> +				/* Get the number of available words in FIFO.
> */
> +				sts =3D readq(fifo->rx_base +
> +					    MLXBF_TMFIFO_RX_STS);
> +				num_avail =3D FIELD_GET(
> +
> 	MLXBF_TMFIFO_RX_STS__COUNT_MASK, sts);

				num_avail =3D FIELD_GET(TMFIFO_RX_STS__COUNT_MASK, sts);

> +
> +				/* Don't continue if nothing in FIFO. */
> +				if (num_avail <=3D 0)
> +					break;
> +			} else {
> +				/* Get available space in FIFO. */
> +				sts =3D readq(fifo->tx_base +
> +					    MLXBF_TMFIFO_TX_STS);
> +				num_avail =3D fifo->tx_fifo_size - tx_reserve -
> +					FIELD_GET(
> +
> 	MLXBF_TMFIFO_TX_STS__COUNT_MASK,
> +						sts);

Same as above.

> +
> +				if (num_avail <=3D 0)
> +					break;
> +			}
> +		}
> +
> +		/* Console output always comes from the Tx buffer. */
> +		if (!is_rx && vring->vdev_id =3D=3D VIRTIO_ID_CONSOLE &&
> +		    cons !=3D NULL && cons->tx_buf !=3D NULL) {
> +			union mlxbf_tmfifo_msg_hdr hdr;
> +			int size;
> +
> +			size =3D mlxbf_tmfifo_vdev_tx_buf_len(cons);
> +			if (num_avail < 2 || size =3D=3D 0)
> +				return;
> +			if (size + sizeof(hdr) > num_avail * sizeof(u64))
> +				size =3D num_avail * sizeof(u64) - sizeof(hdr);
> +			/* Write header. */
> +			hdr.data =3D 0;
> +			hdr.type =3D VIRTIO_ID_CONSOLE;
> +			hdr.len =3D htons(size);
> +			writeq(cpu_to_le64(hdr.data),
> +			       fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +
> +			spin_lock_irqsave(&fifo->spin_lock, flags);
> +			while (size > 0) {
> +				addr =3D cons->tx_buf + cons->tx_head;
> +
> +				if (cons->tx_head + sizeof(u64) <=3D
> +				    MLXBF_TMFIFO_CONS_TX_BUF_SIZE) {
> +					memcpy(&data, addr, sizeof(u64));
> +				} else {
> +					int partial;
> +
> +					partial =3D
> +
> 	MLXBF_TMFIFO_CONS_TX_BUF_SIZE -
> +						cons->tx_head;
> +
> +					memcpy(&data, addr, partial);
> +					memcpy((u8 *)&data + partial,
> +					       cons->tx_buf,
> +					       sizeof(u64) - partial);
> +				}
> +				writeq(data,
> +				       fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +
> +				if (size >=3D sizeof(u64)) {
> +					mlxbf_tmfifo_vdev_tx_buf_pop(
> +						cons, sizeof(u64));
> +					size -=3D sizeof(u64);
> +				} else {
> +					mlxbf_tmfifo_vdev_tx_buf_pop(
> +						cons, size);
> +					size =3D 0;
> +				}
> +			}
> +			spin_unlock_irqrestore(&fifo->spin_lock, flags);
> +			return;
> +		}
> +
> +		/* Get the desc of next packet. */
> +		if (!desc) {
> +			/* Save the head desc of the chain. */
> +			vring->desc_head =3D
> +				mlxbf_tmfifo_virtio_get_next_desc(vq);
> +			if (!vring->desc_head) {
> +				vring->desc =3D NULL;
> +				return;
> +			}
> +			desc =3D vring->desc_head;
> +			vring->desc =3D desc;
> +
> +			if (is_rx && vring->vdev_id =3D=3D VIRTIO_ID_NET) {
> +				struct virtio_net_hdr *net_hdr;
> +
> +				/* Initialize the packet header. */
> +				net_hdr =3D (struct virtio_net_hdr *)
> +					phys_to_virt(virtio64_to_cpu(
> +						vdev, desc->addr));
> +				memset(net_hdr, 0, sizeof(*net_hdr));
> +			}
> +		}
> +
> +		/* Beginning of each packet. */
> +		if (vring->pkt_len =3D=3D 0) {
> +			int vdev_id, vring_change =3D 0;
> +			union mlxbf_tmfifo_msg_hdr hdr;
> +
> +			num_avail--;
> +
> +			/* Read/Write packet length. */
> +			if (is_rx) {
> +				hdr.data =3D readq(fifo->rx_base +
> +						 MLXBF_TMFIFO_RX_DATA);
> +				hdr.data =3D le64_to_cpu(hdr.data);
> +
> +				/* Skip the length 0 packet (keepalive). */
> +				if (hdr.len =3D=3D 0)
> +					continue;
> +
> +				/* Check packet type. */
> +				if (hdr.type =3D=3D VIRTIO_ID_NET) {
> +					struct virtio_net_config *config;
> +
> +					vdev_id =3D VIRTIO_ID_NET;
> +					hdr_len =3D sizeof(struct virtio_net_hdr);
> +					config =3D
> +					    &fifo->vdev[vdev_id]->config.net;
> +					if (ntohs(hdr.len) > config->mtu +
> +
> 	MLXBF_TMFIFO_NET_L2_OVERHEAD)
> +						continue;
> +				} else if (hdr.type =3D=3D VIRTIO_ID_CONSOLE) {
> +					vdev_id =3D VIRTIO_ID_CONSOLE;
> +					hdr_len =3D 0;
> +				} else {
> +					continue;
> +				}
> +
> +				/*
> +				 * Check whether the new packet still belongs
> +				 * to this vring or not. If not, update the
> +				 * pkt_len of the new vring and return.
> +				 */
> +				if (vdev_id !=3D vring->vdev_id) {
> +					struct mlxbf_tmfifo_vdev *dev2 =3D
> +						fifo->vdev[vdev_id];
> +
> +					if (!dev2)
> +						break;
> +					vring->desc =3D desc;
> +					vring =3D
> +					  &dev2-
> >vrings[MLXBF_TMFIFO_VRING_RX];
> +					vring_change =3D 1;
> +				}
> +				vring->pkt_len =3D ntohs(hdr.len) + hdr_len;
> +			} else {
> +				vring->pkt_len =3D
> +					mlxbf_tmfifo_virtio_get_pkt_len(
> +						vdev, desc, vr);
> +
> +				hdr.data =3D 0;
> +				hdr.type =3D (vring->vdev_id =3D=3D VIRTIO_ID_NET) ?
> +					VIRTIO_ID_NET :
> +					VIRTIO_ID_CONSOLE;
> +				hdr.len =3D htons(vring->pkt_len - hdr_len);
> +				writeq(cpu_to_le64(hdr.data),
> +				       fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +			}
> +
> +			vring->cur_len =3D hdr_len;
> +			vring->rem_len =3D vring->pkt_len;
> +			fifo->vring[is_rx] =3D vring;
> +
> +			if (vring_change)
> +				return;
> +			continue;
> +		}
> +
> +		/* Check available space in this desc. */
> +		len =3D virtio32_to_cpu(vdev, desc->len);
> +		if (len > vring->rem_len)
> +			len =3D vring->rem_len;
> +
> +		/* Check if the current desc is already done. */
> +		if (vring->cur_len =3D=3D len)
> +			goto check_done;
> +
> +		addr =3D phys_to_virt(virtio64_to_cpu(vdev, desc->addr));
> +
> +		/* Read a word from FIFO for Rx. */
> +		if (is_rx) {
> +			data =3D readq(fifo->rx_base +
> MLXBF_TMFIFO_RX_DATA);
> +			data =3D le64_to_cpu(data);
> +		}
> +
> +		if (vring->cur_len + sizeof(u64) <=3D len) {
> +			/* The whole word. */
> +			if (is_rx) {
> +				memcpy(addr + vring->cur_len, &data,
> +				       sizeof(u64));
> +			} else {
> +				memcpy(&data, addr + vring->cur_len,
> +				       sizeof(u64));
> +			}

Why not just.
Also few places like this one below.

			if (is_rx)
				memcpy(addr + vring->cur_len, &data, sizeof(u64));
			else
				memcpy(&data, addr + vring->cur_len, sizeof(u64));

> +			vring->cur_len +=3D sizeof(u64);
> +		} else {
> +			/* Leftover bytes. */
> +			BUG_ON(vring->cur_len > len);
> +			if (is_rx) {
> +				memcpy(addr + vring->cur_len, &data,
> +				       len - vring->cur_len);
> +			} else {
> +				memcpy(&data, addr + vring->cur_len,
> +				       len - vring->cur_len);
> +			}
> +			vring->cur_len =3D len;
> +		}
> +
> +		/* Write the word into FIFO for Tx. */
> +		if (!is_rx) {
> +			writeq(cpu_to_le64(data),
> +			       fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
> +		}
> +
> +		num_avail--;
> +
> +check_done:
> +		/* Check whether this desc is full or completed. */
> +		if (vring->cur_len =3D=3D len) {
> +			vring->cur_len =3D 0;
> +			vring->rem_len -=3D len;
> +
> +			/* Get the next desc on the chain. */
> +			if (vring->rem_len > 0 &&
> +			    (virtio16_to_cpu(vdev, desc->flags) &
> +						VRING_DESC_F_NEXT)) {
> +				idx =3D virtio16_to_cpu(vdev, desc->next);
> +				desc =3D &vr->desc[idx];
> +				continue;
> +			}
> +
> +			/* Done and release the desc. */
> +			mlxbf_tmfifo_release_pkt(vdev, vring, &desc);
> +			fifo->vring[is_rx] =3D NULL;
> +
> +			/* Notify upper layer that packet is done. */
> +			spin_lock_irqsave(&fifo->spin_lock, flags);
> +			vring_interrupt(0, vq);
> +			spin_unlock_irqrestore(&fifo->spin_lock, flags);
> +			continue;
> +		}
> +	}
> +
> +	/* Save the current desc. */
> +	vring->desc =3D desc;
> +}

I suggest to split mlxbf_tmfifo_virtio_rxtx() into few small routines.


> +
> +/* The notify function is called when new buffers are posted. */ static
> +bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq) {
> +	struct mlxbf_tmfifo_vring *vring;
> +	struct mlxbf_tmfifo *fifo;
> +	unsigned long flags;
> +
> +	vring =3D (struct mlxbf_tmfifo_vring *)vq->priv;
> +	fifo =3D vring->fifo;
> +
> +	/*
> +	 * Virtio maintains vrings in pairs, even number ring for Rx
> +	 * and odd number ring for Tx.
> +	 */
> +	if (!(vring->id & 1)) {
> +		/* Set the RX HWM bit to start Rx. */
> +		if (!test_and_set_bit(MLXBF_TM_RX_HWM_IRQ, &fifo-
> >pend_events))
> +			schedule_work(&fifo->work);
> +	} else {
> +		/*
> +		 * Console could make blocking call with interrupts disabled.
> +		 * In such case, the vring needs to be served right away. For
> +		 * other cases, just set the TX LWM bit to start Tx in the
> +		 * worker handler.
> +		 */
> +		if (vring->vdev_id =3D=3D VIRTIO_ID_CONSOLE) {
> +			spin_lock_irqsave(&fifo->spin_lock, flags);
> +			mlxbf_tmfifo_console_output(
> +				fifo->vdev[VIRTIO_ID_CONSOLE], vq);

			mlxbf_tmfifo_console_output(fifo->vdev[VIRTIO_ID_CONSOLE], vq);

> +			spin_unlock_irqrestore(&fifo->spin_lock, flags);
> +			schedule_work(&fifo->work);
> +		} else if (!test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
> +					     &fifo->pend_events))
> +			schedule_work(&fifo->work);

		If {
		} else if {
		}

For consistency.

> +	}
> +
> +	return true;
> +}
> +
> +/* Work handler for Rx and Tx case. */
> +static void mlxbf_tmfifo_work_handler(struct work_struct *work) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +	struct mlxbf_tmfifo *fifo;
> +	int i;
> +
> +	fifo =3D container_of(work, struct mlxbf_tmfifo, work);
> +	if (!fifo->is_ready)
> +		return;
> +
> +	mutex_lock(&fifo->lock);
> +
> +	/* Tx (Send data to the TmFifo). */
> +	if (test_and_clear_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events)
> &&
> +		       fifo->irq_info[MLXBF_TM_TX_LWM_IRQ].irq) {
> +		for (i =3D 0; i < MLXBF_TMFIFO_VDEV_MAX; i++) {

I suggest to define local variable vq.
And have below:
				mlxbf_tmfifo_virtio_rxtx(vq, false);

> +			tm_vdev =3D fifo->vdev[i];
> +			if (tm_vdev !=3D NULL) {
> +				mlxbf_tmfifo_virtio_rxtx(
> +				    tm_vdev-
> >vrings[MLXBF_TMFIFO_VRING_TX].vq,
> +				    false);
> +			}
> +		}
> +	}
> +
> +	/* Rx (Receive data from the TmFifo). */
> +	if (test_and_clear_bit(MLXBF_TM_RX_HWM_IRQ, &fifo->pend_events)
> &&
> +		       fifo->irq_info[MLXBF_TM_RX_HWM_IRQ].irq) {
> +		for (i =3D 0; i < MLXBF_TMFIFO_VDEV_MAX; i++) {
> +			tm_vdev =3D fifo->vdev[i];

Same as above.

> +			if (tm_vdev !=3D NULL) {
> +				mlxbf_tmfifo_virtio_rxtx(
> +				    tm_vdev-
> >vrings[MLXBF_TMFIFO_VRING_RX].vq,
> +				    true);
> +			}
> +		}
> +	}
> +
> +	mutex_unlock(&fifo->lock);
> +}
> +
> +/* Get the array of feature bits for this device. */ static u64
> +mlxbf_tmfifo_virtio_get_features(struct virtio_device *vdev) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +	return tm_vdev->features;
> +}
> +
> +/* Confirm device features to use. */
> +static int mlxbf_tmfifo_virtio_finalize_features(struct virtio_device
> +*vdev) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +	tm_vdev->features =3D vdev->features;
> +
> +	return 0;
> +}
> +
> +/* Free virtqueues found by find_vqs(). */ static void
> +mlxbf_tmfifo_virtio_del_vqs(struct virtio_device *vdev) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +	struct mlxbf_tmfifo_vring *vring;
> +	struct virtqueue *vq;
> +	int i;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
> +		vring =3D &tm_vdev->vrings[i];
> +
> +		/* Release the pending packet. */
> +		if (vring->desc !=3D NULL) {
> +			mlxbf_tmfifo_release_pkt(&tm_vdev->vdev, vring,
> +						 &vring->desc);
> +		}
> +
> +		vq =3D vring->vq;
> +		if (vq) {
> +			vring->vq =3D NULL;
> +			vring_del_virtqueue(vq);
> +		}
> +	}
> +}
> +
> +/* Create and initialize the virtual queues. */ static int
> +mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
> +					unsigned int nvqs,
> +					struct virtqueue *vqs[],
> +					vq_callback_t *callbacks[],
> +					const char * const names[],
> +					const bool *ctx,
> +					struct irq_affinity *desc)
> +{
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +	struct mlxbf_tmfifo_vring *vring;
> +	int i, ret =3D -EINVAL, size;

Don't initialize ret with -EINVAL.

> +	struct virtqueue *vq;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +	if (nvqs > ARRAY_SIZE(tm_vdev->vrings))
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < nvqs; ++i) {
> +		if (!names[i])
> +			goto error;
> +		vring =3D &tm_vdev->vrings[i];
> +
> +		/* zero vring */
> +		size =3D vring_size(vring->size, vring->align);
> +		memset(vring->va, 0, size);
> +		vq =3D vring_new_virtqueue(i, vring->size, vring->align, vdev,
> +					 false, false, vring->va,
> +					 mlxbf_tmfifo_virtio_notify,
> +					 callbacks[i], names[i]);
> +		if (!vq) {
> +			dev_err(&vdev->dev, "vring_new_virtqueue failed\n");
> +			ret =3D -ENOMEM;
> +			goto error;
> +		}
> +
> +		vqs[i] =3D vq;
> +		vring->vq =3D vq;
> +		vq->priv =3D vring;
> +	}
> +
> +	return 0;
> +
> +error:
> +	mlxbf_tmfifo_virtio_del_vqs(vdev);
> +	return ret;
> +}
> +
> +/* Read the status byte. */
> +static u8 mlxbf_tmfifo_virtio_get_status(struct virtio_device *vdev) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +
> +	return tm_vdev->status;
> +}
> +
> +/* Write the status byte. */
> +static void mlxbf_tmfifo_virtio_set_status(struct virtio_device *vdev,
> +					   u8 status)
> +{
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +	tm_vdev->status =3D status;
> +}
> +
> +/* Reset the device. Not much here for now. */ static void
> +mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +	tm_vdev->status =3D 0;
> +}
> +
> +/* Read the value of a configuration field. */ static void
> +mlxbf_tmfifo_virtio_get(struct virtio_device *vdev,
> +			      unsigned int offset,
> +			      void *buf,
> +			      unsigned int len)
> +{
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +

	unsigned int pos =3D offset + len;

	if (pos > sizeof(tm_vdev->config) || pos < len)


> +	if (offset + len > sizeof(tm_vdev->config) || offset + len < len) {
> +		dev_err(vdev->dev.parent, "virtio_get access out of bounds\n");
> +		return;
> +	}
> +
> +	memcpy(buf, (u8 *)&tm_vdev->config + offset, len); }
> +
> +/* Write the value of a configuration field. */ static void
> +mlxbf_tmfifo_virtio_set(struct virtio_device *vdev,
> +				 unsigned int offset,
> +				 const void *buf,
> +				 unsigned int len)
> +{
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +	tm_vdev =3D container_of(vdev, struct mlxbf_tmfifo_vdev, vdev);
> +
> +	if (offset + len > sizeof(tm_vdev->config) || offset + len < len) {

Same as above.

> +		dev_err(vdev->dev.parent, "virtio_get access out of bounds\n");
> +		return;
> +	}
> +
> +	memcpy((u8 *)&tm_vdev->config + offset, buf, len); }
> +
> +/* Virtio config operations. */
> +static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops =3D=
 {
> +	.get_features =3D mlxbf_tmfifo_virtio_get_features,
> +	.finalize_features =3D mlxbf_tmfifo_virtio_finalize_features,
> +	.find_vqs =3D mlxbf_tmfifo_virtio_find_vqs,
> +	.del_vqs =3D mlxbf_tmfifo_virtio_del_vqs,
> +	.reset =3D mlxbf_tmfifo_virtio_reset,
> +	.set_status =3D mlxbf_tmfifo_virtio_set_status,
> +	.get_status =3D mlxbf_tmfifo_virtio_get_status,
> +	.get =3D mlxbf_tmfifo_virtio_get,
> +	.set =3D mlxbf_tmfifo_virtio_set,
> +};
> +
> +/* Create vdev type in a tmfifo. */
> +int mlxbf_tmfifo_create_vdev(struct mlxbf_tmfifo *fifo, int vdev_id,
> +			     u64 features, void *config, u32 size) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +	int ret =3D 0;
> +
> +	mutex_lock(&fifo->lock);
> +
> +	tm_vdev =3D fifo->vdev[vdev_id];
> +	if (tm_vdev !=3D NULL) {
> +		pr_err("vdev %d already exists\n", vdev_id);
> +		ret =3D -EEXIST;
> +		goto already_exist;
> +	}
> +
> +	tm_vdev =3D kzalloc(sizeof(*tm_vdev), GFP_KERNEL);
> +	if (!tm_vdev) {
> +		ret =3D -ENOMEM;
> +		goto already_exist;
> +	}
> +
> +	tm_vdev->vdev.id.device =3D vdev_id;
> +	tm_vdev->vdev.config =3D &mlxbf_tmfifo_virtio_config_ops;
> +	tm_vdev->vdev.dev.parent =3D &fifo->pdev->dev;
> +	tm_vdev->vdev.dev.release =3D mlxbf_tmfifo_virtio_dev_release;
> +	tm_vdev->features =3D features;
> +	if (config)
> +		memcpy(&tm_vdev->config, config, size);
> +	if (mlxbf_tmfifo_alloc_vrings(fifo, tm_vdev, vdev_id)) {
> +		pr_err("Unable to allocate vring\n");
> +		ret =3D -ENOMEM;
> +		goto alloc_vring_fail;
> +	}
> +	if (vdev_id =3D=3D VIRTIO_ID_CONSOLE) {
> +		tm_vdev->tx_buf =3D
> kmalloc(MLXBF_TMFIFO_CONS_TX_BUF_SIZE,
> +					  GFP_KERNEL);
> +	}
> +	fifo->vdev[vdev_id] =3D tm_vdev;
> +
> +	/* Register the virtio device. */
> +	ret =3D register_virtio_device(&tm_vdev->vdev);
> +	if (ret) {
> +		dev_err(&fifo->pdev->dev, "register_virtio_device() failed\n");
> +		goto register_fail;
> +	}
> +
> +	mutex_unlock(&fifo->lock);
> +	return 0;
> +
> +register_fail:
> +	mlxbf_tmfifo_free_vrings(fifo, vdev_id);
> +	fifo->vdev[vdev_id] =3D NULL;
> +alloc_vring_fail:
> +	kfree(tm_vdev);
> +already_exist:
> +	mutex_unlock(&fifo->lock);
> +	return ret;
> +}
> +
> +/* Delete vdev type from a tmfifo. */
> +int mlxbf_tmfifo_delete_vdev(struct mlxbf_tmfifo *fifo, int vdev_id) {
> +	struct mlxbf_tmfifo_vdev *tm_vdev;
> +
> +	mutex_lock(&fifo->lock);
> +
> +	/* Unregister vdev. */
> +	tm_vdev =3D fifo->vdev[vdev_id];
> +	if (tm_vdev) {
> +		unregister_virtio_device(&tm_vdev->vdev);
> +		mlxbf_tmfifo_free_vrings(fifo, vdev_id);
> +		kfree(tm_vdev->tx_buf);
> +		kfree(tm_vdev);
> +		fifo->vdev[vdev_id] =3D NULL;
> +	}
> +
> +	mutex_unlock(&fifo->lock);
> +
> +	return 0;
> +}
> +
> +/* Device remove function. */
> +static int mlxbf_tmfifo_remove(struct platform_device *pdev) {

Locate it after probe.
If you'll use all devm_, like Andy noted:
devm_ioremap
devm_ioremap_resource
devm_kzalloc
devm_request_mem_region
you can drop all kfree, release_mem_region, iounmap

And make the below as a separate routine, something like
mlxbf_tmfifo_cleanup(), if you still need it.

> +	struct mlxbf_tmfifo *fifo =3D platform_get_drvdata(pdev);
> +	struct resource *rx_res, *tx_res;
> +	int i;
> +
> +	if (fifo) {
> +		mutex_lock(&mlxbf_tmfifo_lock);
> +
> +		fifo->is_ready =3D false;
> +
> +		/* Stop the timer. */
> +		del_timer_sync(&fifo->timer);
> +
> +		/* Release interrupts. */
> +		mlxbf_tmfifo_free_irqs(fifo);
> +
> +		/* Cancel the pending work. */
> +		cancel_work_sync(&fifo->work);
> +
> +		for (i =3D 0; i < MLXBF_TMFIFO_VDEV_MAX; i++)
> +			mlxbf_tmfifo_delete_vdev(fifo, i);
> +
> +		/* Release IO resources. */
> +		if (fifo->rx_base)
> +			iounmap(fifo->rx_base);
> +		if (fifo->tx_base)
> +			iounmap(fifo->tx_base);
> +
> +		platform_set_drvdata(pdev, NULL);
> +		kfree(fifo);
> +
> +		mutex_unlock(&mlxbf_tmfifo_lock);
> +	}
> +
> +	rx_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (rx_res)
> +		release_mem_region(rx_res->start, resource_size(rx_res));
> +	tx_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (tx_res)
> +		release_mem_region(tx_res->start, resource_size(tx_res));
> +
> +	return 0;
> +}
> +
> +/* Read the configured network MAC address from efi variable. */ static
> +void mlxbf_tmfifo_get_cfg_mac(u8 *mac) {
> +	efi_char16_t name[] =3D {
> +		'R', 's', 'h', 'i', 'm', 'M', 'a', 'c', 'A', 'd', 'd', 'r', 0 };


Could it be moved out and set like:
static const efi_char16_t mlxbf_tmfifo_efi_name[] =3D "...";
Could you check if the are some examples in kernel, please?

> +	efi_guid_t guid =3D EFI_GLOBAL_VARIABLE_GUID;
> +	efi_status_t status;
> +	unsigned long size;
> +	u8 buf[6];
> +
> +	size =3D sizeof(buf);
> +	status =3D efi.get_variable(name, &guid, NULL, &size, buf);
> +	if (status =3D=3D EFI_SUCCESS && size =3D=3D sizeof(buf))
> +		memcpy(mac, buf, sizeof(buf));
> +}
> +
> +/* Probe the TMFIFO. */
> +static int mlxbf_tmfifo_probe(struct platform_device *pdev) {
> +	struct virtio_net_config net_config;
> +	struct resource *rx_res, *tx_res;
> +	struct mlxbf_tmfifo *fifo;
> +	int i, ret;
> +	u64 ctl;
> +
> +	/* Get the resource of the Rx & Tx FIFO. */
> +	rx_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tx_res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!rx_res || !tx_res) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> +	if (request_mem_region(rx_res->start,
> +			       resource_size(rx_res), "bf-tmfifo") =3D=3D NULL) {
> +		ret =3D -EBUSY;
> +		goto early_err;
> +	}
> +
> +	if (request_mem_region(tx_res->start,
> +			       resource_size(tx_res), "bf-tmfifo") =3D=3D NULL) {
> +		release_mem_region(rx_res->start, resource_size(rx_res));
> +		ret =3D -EBUSY;
> +		goto early_err;
> +	}
> +
> +	ret =3D -ENOMEM;
> +	fifo =3D kzalloc(sizeof(struct mlxbf_tmfifo), GFP_KERNEL);
> +	if (!fifo)
> +		goto err;
> +
> +	fifo->pdev =3D pdev;
> +	platform_set_drvdata(pdev, fifo);
> +
> +	spin_lock_init(&fifo->spin_lock);
> +	INIT_WORK(&fifo->work, mlxbf_tmfifo_work_handler);
> +
> +	timer_setup(&fifo->timer, mlxbf_tmfifo_timer, 0);
> +	fifo->timer.function =3D mlxbf_tmfifo_timer;
> +
> +	for (i =3D 0; i < MLXBF_TM_IRQ_CNT; i++) {
> +		fifo->irq_info[i].index =3D i;
> +		fifo->irq_info[i].fifo =3D fifo;
> +		fifo->irq_info[i].irq =3D platform_get_irq(pdev, i);
> +		ret =3D request_irq(fifo->irq_info[i].irq,
> +				  mlxbf_tmfifo_irq_handler, 0,
> +				  "tmfifo", &fifo->irq_info[i]);
> +		if (ret) {
> +			pr_err("Unable to request irq\n");
> +			fifo->irq_info[i].irq =3D 0;
> +			goto err;
> +		}
> +	}
> +
> +	fifo->rx_base =3D ioremap(rx_res->start, resource_size(rx_res));
> +	if (!fifo->rx_base)
> +		goto err;
> +
> +	fifo->tx_base =3D ioremap(tx_res->start, resource_size(tx_res));
> +	if (!fifo->tx_base)
> +		goto err;
> +
> +	/* Get Tx FIFO size and set the low/high watermark. */
> +	ctl =3D readq(fifo->tx_base + MLXBF_TMFIFO_TX_CTL);
> +	fifo->tx_fifo_size =3D
> +		FIELD_GET(MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_MASK,
> ctl);
> +	ctl =3D (ctl & ~MLXBF_TMFIFO_TX_CTL__LWM_MASK) |
> +		FIELD_PREP(MLXBF_TMFIFO_TX_CTL__LWM_MASK,
> +			   fifo->tx_fifo_size / 2);
> +	ctl =3D (ctl & ~MLXBF_TMFIFO_TX_CTL__HWM_MASK) |
> +		FIELD_PREP(MLXBF_TMFIFO_TX_CTL__HWM_MASK,
> +			   fifo->tx_fifo_size - 1);
> +	writeq(ctl, fifo->tx_base + MLXBF_TMFIFO_TX_CTL);
> +
> +	/* Get Rx FIFO size and set the low/high watermark. */
> +	ctl =3D readq(fifo->rx_base + MLXBF_TMFIFO_RX_CTL);
> +	fifo->rx_fifo_size =3D
> +		FIELD_GET(MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK,
> ctl);
> +	ctl =3D (ctl & ~MLXBF_TMFIFO_RX_CTL__LWM_MASK) |
> +		FIELD_PREP(MLXBF_TMFIFO_RX_CTL__LWM_MASK, 0);
> +	ctl =3D (ctl & ~MLXBF_TMFIFO_RX_CTL__HWM_MASK) |
> +		FIELD_PREP(MLXBF_TMFIFO_RX_CTL__HWM_MASK, 1);
> +	writeq(ctl, fifo->rx_base + MLXBF_TMFIFO_RX_CTL);
> +
> +	mutex_init(&fifo->lock);
> +
> +	/* Create the console vdev. */
> +	ret =3D mlxbf_tmfifo_create_vdev(fifo, VIRTIO_ID_CONSOLE, 0, NULL, 0);
> +	if (ret)
> +		goto err;
> +
> +	/* Create the network vdev. */
> +	memset(&net_config, 0, sizeof(net_config));
> +	net_config.mtu =3D MLXBF_TMFIFO_NET_MTU;
> +	net_config.status =3D VIRTIO_NET_S_LINK_UP;
> +	memcpy(net_config.mac, mlxbf_tmfifo_net_default_mac, 6);
> +	mlxbf_tmfifo_get_cfg_mac(net_config.mac);
> +	ret =3D mlxbf_tmfifo_create_vdev(fifo, VIRTIO_ID_NET,
> +		MLXBF_TMFIFO_NET_FEATURES, &net_config,
> sizeof(net_config));
> +	if (ret)
> +		goto err;
> +
> +	mod_timer(&fifo->timer, jiffies + mlxbf_tmfifo_timer_interval);
> +
> +	fifo->is_ready =3D true;
> +
> +	return 0;
> +
> +err:
> +	mlxbf_tmfifo_remove(pdev);
> +early_err:
> +	dev_err(&pdev->dev, "Probe Failed\n");
> +	return ret;
> +}
> +
> +static const struct of_device_id mlxbf_tmfifo_match[] =3D {
> +	{ .compatible =3D "mellanox,bf-tmfifo" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mlxbf_tmfifo_match);
> +
> +static const struct acpi_device_id mlxbf_tmfifo_acpi_match[] =3D {
> +	{ "MLNXBF01", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, mlxbf_tmfifo_acpi_match);
> +
> +static struct platform_driver mlxbf_tmfifo_driver =3D {
> +	.probe =3D mlxbf_tmfifo_probe,
> +	.remove =3D mlxbf_tmfifo_remove,
> +	.driver =3D {
> +		.name =3D "bf-tmfifo",
> +		.of_match_table =3D mlxbf_tmfifo_match,
> +		.acpi_match_table =3D ACPI_PTR(mlxbf_tmfifo_acpi_match),
> +	},
> +};
> +
> +module_platform_driver(mlxbf_tmfifo_driver);
> +
> +MODULE_DESCRIPTION("Mellanox BlueField SoC TmFifo Driver");
> +MODULE_LICENSE("GPL"); MODULE_AUTHOR("Mellanox Technologies");
> --
> 1.8.3.1

