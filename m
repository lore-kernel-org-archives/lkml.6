Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40B5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682B920811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UFRNufSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682B920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLKHVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:21:33 -0500
Received: from mail-eopbgr800080.outbound.protection.outlook.com ([40.107.80.80]:2561
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbeLKHVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAHKTRol4DM2jNZE1r8opfhnjAguAYqJVc7fUFKN6K4=;
 b=UFRNufSiP6dIgF7AKjpCLokOOhJseHbzeicl7FR5vOnYtJC2RjYBUxThXIzNSUrSkcEBZSqBJfTE4LGPwRXzbynRqR6u9lOiHXcendUKcZ3oNdsZv89C9juckvlGdun7Z+VP14eDkZlzYnDevm8ng6cUZ5erVc0OEIgX+H2V+Cw=
Received: from DM5PR02MB2233.namprd02.prod.outlook.com (10.168.173.147) by
 DM5PR02MB3257.namprd02.prod.outlook.com (10.164.148.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Tue, 11 Dec 2018 07:21:25 +0000
Received: from DM5PR02MB2233.namprd02.prod.outlook.com
 ([fe80::7868:59ef:8f91:91e2]) by DM5PR02MB2233.namprd02.prod.outlook.com
 ([fe80::7868:59ef:8f91:91e2%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 07:21:24 +0000
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
Subject: RE: [PATCH v6 1/2] mailbox: ZynqMP IPI mailbox controller
Thread-Topic: [PATCH v6 1/2] mailbox: ZynqMP IPI mailbox controller
Thread-Index: AQHUgE6OyhFL3CVf+Uas1Ia5YlNMbqV5Qj5g
Date:   Tue, 11 Dec 2018 07:21:24 +0000
Message-ID: <DM5PR02MB2233BD770FB1E58B592356BBB0A60@DM5PR02MB2233.namprd02.prod.outlook.com>
References: <1542662761-31158-1-git-send-email-wendy.liang@xilinx.com>
 <1542662761-31158-2-git-send-email-wendy.liang@xilinx.com>
In-Reply-To: <1542662761-31158-2-git-send-email-wendy.liang@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jliang@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR02MB3257;6:/5VaLGvisseKkDhSlv/Kzc1EPgESI9KkjPV20lpDy+8kXtsZk9h0fgDHxZMNeCvGPUnyfknNJGt58f4Uq+KXLkZhrLEA3746DbTL4zvnY/+eCbWDstuk6fmmzSTkrAWSr5Yc7xlSNbUCfLBuGcF0AekGH2N2VawTHngP/1rQ1hh4WvyiZA9yoZHiX1KsNmn2TLfGJoVOJPn1Po+AmGm1KEIqbY19BX7nFQYxBf2GL7X8tq2sQtzhHFzJRNG7yZE+xjAPDnoVlxK3F0JNuqhDr3NDne6z1je8is24RkOnLq8/dJR1b0jGOJ4GIrgldsVfodhAesPZ1rwfU0u5R/uqHtx3Lz5wM1EZcByrf788/OJun4OJ3qP4pkDodyPXv9/ECs2+sDS2u1GGXx/Ufr7H+NVWtiBtQOgxeewZ9FsUmMn5+tqwY6gy+Combp604LO3vdW0nqw+RTJAMl1tiitTZg==;5:Ucv99ga7jXaEbPLgIFqTJd0N2086gJNF9MhnsLd/nU6A0tgyQk+r1u5vwcUGav1N5qC2CbQhgSO/5FuDkwzlo7rtF81Im71OSjUT/ND04N9DfAJKZYY9CyVNo6Edc0Zl4KIVl5IBGDN84hJshwinwb5qVBWqJqJjUDYIXPpxRls=;7:W5EPssHGRCj+pcPNoRh34IMuCQf0IsoYkyPI5Xqs/7zH6mi9Xn5dXIoP8OIc+Dy8qwb3ErF6755fT6axZvRVsoRq9GyuJmQKfw8hSiwPduTler99rHA/PE+U7ODdeTJ08/8sfGWr6I8zibxgNWyVUA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(13464003)(199004)(189003)(74316002)(86362001)(76176011)(186003)(55016002)(39060400002)(106356001)(575784001)(4744004)(102836004)(26005)(9686003)(53946003)(305945005)(14444005)(3846002)(53936002)(6436002)(478600001)(7696005)(14454004)(6116002)(256004)(2906002)(2501003)(71190400001)(53546011)(6506007)(71200400001)(8936002)(81166006)(81156014)(229853002)(33656002)(6246003)(68736007)(486006)(446003)(15650500001)(99286004)(66066001)(25786009)(316002)(476003)(11346002)(8676002)(105586002)(54906003)(110136005)(4326008)(97736004)(5660300001)(7736002)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3257;H:DM5PR02MB2233.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 9cf7001e-bfce-46ab-4fd7-08d65f39420e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB3257;
x-ms-traffictypediagnostic: DM5PR02MB3257:
x-microsoft-antispam-prvs: <DM5PR02MB3257D494AB07F499670A6032B0A60@DM5PR02MB3257.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR02MB3257;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB3257;
x-forefront-prvs: 08831F51DC
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tKV4Pbaya054Cv/HzT5QjzQJiWMF2uqh8YlYg5jUTS7uOg7hodwGnJyVcZcyOkJ/WU9J2WadFqQjXyqmpzjfXebpSCfbX4nskFc/lKClnAXN3SoBfxy4GICydXcmgPFwdio0lwDtT74gwxAMjol/QRICi77eReOasuIgnF6lVC2Q3mBLzDbnBjPGwS/3npR04YsO+pyUhUhAK7jO+jqlOpID15++JUzHL/vfADPk4TDvLdtqtucKGKX8sOdCut2Yi/nWfafDdrQAIfCHmmmQrRqlopCNfLFeiFPEy7YIu9MejdHehu+TF/g2BnZtXgum
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf7001e-bfce-46ab-4fd7-08d65f39420e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 07:21:24.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wendy Liang [mailto:wendy.liang@xilinx.com]
> Sent: Monday, November 19, 2018 1:26 PM
> To: jassisinghbrar@gmail.com; Michal Simek <michals@xilinx.com>;
> robh+dt@kernel.org; mark.rutland@arm.com
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Jiaying Liang <jliang@xilinx.com>
> Subject: [PATCH v6 1/2] mailbox: ZynqMP IPI mailbox controller
>=20
> This patch is to introduce ZynqMP IPI mailbox controller driver to use th=
e
> ZynqMP IPI block as mailboxes.
>=20
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> ---
>  drivers/mailbox/Kconfig                    |   9 +
>  drivers/mailbox/Makefile                   |   2 +
>  drivers/mailbox/zynqmp-ipi-mailbox.c       | 762
> +++++++++++++++++++++++++++++
>  include/linux/mailbox/zynqmp-ipi-message.h |  24 +
>  4 files changed, 797 insertions(+)
>  create mode 100644 drivers/mailbox/zynqmp-ipi-mailbox.c
>  create mode 100644 include/linux/mailbox/zynqmp-ipi-message.h
>=20
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig index
> 3eeb12e9..10bfe3f 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -205,4 +205,13 @@ config MTK_CMDQ_MBOX
>  	  mailbox driver. The CMDQ is used to help read/write registers with
>  	  critical time limitation, such as updating display configuration
>  	  during the vblank.
> +
> +config ZYNQMP_IPI_MBOX
> +	tristate "Xilinx ZynqMP IPI Mailbox"
> +	depends on ARCH_ZYNQMP && OF
> +	help
> +	  Mailbox implementation for Xilinx ZynqMP IPI controller. It is used
> +	  to send notification or short message between processors on Xilinx
> +	  UltraScale+ MPSoC platforms. Say Y here if you want to have this
> +	  support.
>  endif
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile index
> c818b5d..bb3d604 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -44,3 +44,5 @@ obj-$(CONFIG_TEGRA_HSP_MBOX)	+=3D tegra-
> hsp.o
>  obj-$(CONFIG_STM32_IPCC) 	+=3D stm32-ipcc.o
>=20
>  obj-$(CONFIG_MTK_CMDQ_MBOX)	+=3D mtk-cmdq-mailbox.o
> +
> +obj-$(CONFIG_ZYNQMP_IPI_MBOX)  +=3D zynqmp-ipi-mailbox.o
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqm=
p-
> ipi-mailbox.c
> new file mode 100644
> index 0000000..bc02864
> --- /dev/null
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -0,0 +1,762 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Inter Processor Interrupt(IPI) Mailbox Driver
> + *
> + * Copyright (C) 2018 Xilinx Inc.
> + *
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/zynqmp-ipi-message.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +
> +/* IPI agent ID any */
> +#define IPI_ID_ANY 0xFFUL
> +
> +/* indicate if ZynqMP IPI mailbox driver uses SMC calls or HVC calls */
> +#define USE_SMC 0 #define USE_HVC 1
> +
> +/* Default IPI SMC function IDs */
> +#define SMC_IPI_MAILBOX_OPEN            0x82001000U
> +#define SMC_IPI_MAILBOX_RELEASE         0x82001001U
> +#define SMC_IPI_MAILBOX_STATUS_ENQUIRY  0x82001002U
> +#define SMC_IPI_MAILBOX_NOTIFY          0x82001003U
> +#define SMC_IPI_MAILBOX_ACK             0x82001004U
> +#define SMC_IPI_MAILBOX_ENABLE_IRQ      0x82001005U
> +#define SMC_IPI_MAILBOX_DISABLE_IRQ     0x82001006U
> +
> +/* IPI SMC Macros */
> +#define IPI_SMC_OPEN_IRQ_MASK		0x00000001UL /* IRQ enable
> bit in IPI
> +						      * open SMC call
> +						      */
> +#define IPI_SMC_NOTIFY_BLOCK_MASK	0x00000001UL /* Flag to
> indicate if
> +						      * IPI notification needs
> +						      * to be blocking.
> +						      */
> +#define IPI_SMC_ENQUIRY_DIRQ_MASK       0x00000001UL /* Flag to
> indicate if
> +						      * notification interrupt
> +						      * to be disabled.
> +						      */
> +#define IPI_SMC_ACK_EIRQ_MASK           0x00000001UL /* Flag to indicate=
 if
> +						      * notification interrupt
> +						      * to be enabled.
> +						      */
> +
> +/* IPI mailbox status */
> +#define IPI_MB_STATUS_IDLE              0
> +#define IPI_MB_STATUS_SEND_PENDING      1
> +#define IPI_MB_STATUS_RECV_PENDING      2
> +
> +#define IPI_MB_CHNL_TX 0 /* IPI mailbox TX channel */ #define
> +IPI_MB_CHNL_RX 1 /* IPI mailbox RX channel */
> +
> +/**
> + * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox
> +channel
> + * @is_opened: indicate if the IPI channel is opened
> + * @req_buf: local to remote request buffer start address
> + * @resp_buf: local to remote response buffer start address
> + * @req_buf_size: request buffer size
> + * @resp_buf_size: response buffer size
> + * @rx_buf: receive buffer to pass received message to client
> + * @chan_type: channel type
> + */
> +struct zynqmp_ipi_mchan {
> +	int is_opened;
> +	void __iomem *req_buf;
> +	void __iomem *resp_buf;
> +	void *rx_buf;
> +	size_t req_buf_size;
> +	size_t resp_buf_size;
> +	unsigned int chan_type;
> +};
> +
> +/**
> + * struct zynqmp_ipi_mbox - Description of a ZynqMP IPI mailbox
> + *                          platform data.
> + * @pdata:		  pointer to the IPI private data
> + * @dev:                  device pointer corresponding to the Xilinx Zyn=
qMP
> + *                        IPI mailbox
> + * @remote_id:            remote IPI agent ID
> + * @mbox:                 mailbox Controller
> + * @mchans:               array for channels, tx channel and rx channel.
> + * @irq:                  IPI agent interrupt ID
> + */
> +struct zynqmp_ipi_mbox {
> +	struct zynqmp_ipi_pdata *pdata;
> +	struct device dev;
> +	u32 remote_id;
> +	struct mbox_controller mbox;
> +	struct zynqmp_ipi_mchan mchans[2];
> +};
> +
> +/**
> + * struct zynqmp_ipi_pdata - Description of z ZynqMP IPI agent platform
> data.
> + *
> + * @dev:                  device pointer corresponding to the Xilinx Zyn=
qMP
> + *                        IPI agent
> + * @irq:                  IPI agent interrupt ID
> + * @method:               IPI SMC or HVC is going to be used
> + * @local_id:             local IPI agent ID
> + * @ipi_mboxes:           IPI mailboxes of this IPI agent
> + */
> +struct zynqmp_ipi_pdata {
> +	struct device *dev;
> +	int irq;
> +	unsigned int method;
> +	u32 local_id;
> +	int num_mboxes;
> +	struct zynqmp_ipi_mbox *ipi_mboxes;
> +};
> +
> +static struct device_driver zynqmp_ipi_mbox_driver =3D {
> +	.owner =3D THIS_MODULE,
> +	.name =3D "zynqmp-ipi-mbox",
> +};
> +
> +static void zynqmp_ipi_fw_call(struct zynqmp_ipi_mbox *ipi_mbox,
> +			       unsigned long a0, unsigned long a3,
> +			       unsigned long a4, unsigned long a5,
> +			       unsigned long a6, unsigned long a7,
> +			       struct arm_smccc_res *res)
> +{
> +	struct zynqmp_ipi_pdata *pdata =3D ipi_mbox->pdata;
> +	unsigned long a1, a2;
> +
> +	a1 =3D pdata->local_id;
> +	a2 =3D ipi_mbox->remote_id;
> +	if (pdata->method =3D=3D USE_SMC)
> +		arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
> +	else
> +		arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res); }
> +
> +/**
> + * zynqmp_ipi_interrupt - Interrupt handler for IPI notification
> + *
> + * @irq:  Interrupt number
> + * @data: ZynqMP IPI mailbox platform data.
> + *
> + * Return: -EINVAL if there is no instance
> + * IRQ_NONE if the interrupt is not ours.
> + * IRQ_HANDLED if the rx interrupt was successfully handled.
> + */
> +static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data) {
> +	struct zynqmp_ipi_pdata *pdata =3D data;
> +	struct mbox_chan *chan;
> +	struct zynqmp_ipi_mbox *ipi_mbox;
> +	struct zynqmp_ipi_mchan *mchan;
> +	struct zynqmp_ipi_message *msg;
> +	u64 arg0, arg3;
> +	struct arm_smccc_res res;
> +	int ret, i;
> +
> +	arg0 =3D SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> +	arg3 =3D IPI_SMC_ENQUIRY_DIRQ_MASK;
> +	for (i =3D 0; i < pdata->num_mboxes; i++) {
> +		ipi_mbox =3D &pdata->ipi_mboxes[i];
> +		mchan =3D &ipi_mbox->mchans[IPI_MB_CHNL_RX];
> +		chan =3D &ipi_mbox->mbox.chans[IPI_MB_CHNL_RX];
> +		zynqmp_ipi_fw_call(ipi_mbox, arg0, arg3, 0, 0, 0, 0, &res);
> +		ret =3D (int)(res.a0 & 0xFFFFFFFF);
> +		if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
> +			if (mchan->is_opened) {
> +				msg =3D mchan->rx_buf;
> +				msg->len =3D mchan->req_buf_size;
> +				memcpy_fromio(msg->data, mchan->req_buf,
> +					      msg->len);
> +				mbox_chan_received_data(chan, (void
> *)msg);
> +				return IRQ_HANDLED;
> +			}
> +		}
> +	}
> +	return IRQ_NONE;
> +}
> +
> +/**
> + * zynqmp_ipi_peek_data - Peek to see if there are any rx messages.
> + *
> + * @chan: Channel Pointer
> + *
> + * Return: 'true' if there is pending rx data, 'false' if there is none.
> + */
> +static bool zynqmp_ipi_peek_data(struct mbox_chan *chan) {
> +	struct device *dev =3D chan->mbox->dev;
> +	struct zynqmp_ipi_mbox *ipi_mbox =3D dev_get_drvdata(dev);
> +	struct zynqmp_ipi_mchan *mchan =3D chan->con_priv;
> +	int ret;
> +	u64 arg0;
> +	struct arm_smccc_res res;
> +
> +	if (WARN_ON(!ipi_mbox)) {
> +		dev_err(dev, "no platform drv data??\n");
> +		return false;
> +	}
> +
> +	arg0 =3D SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> +	zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +	ret =3D (int)(res.a0 & 0xFFFFFFFF);
> +
> +	if (mchan->chan_type =3D=3D IPI_MB_CHNL_TX) {
> +		/* TX channel, check if the message has been acked
> +		 * by the remote, if yes, response is available.
> +		 */
> +		if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
> +			return false;
> +		else
> +			return true;
> +	} else if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
> +		/* RX channel, check if there is message arrived. */
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * zynqmp_ipi_last_tx_done - See if the last tx message is sent
> + *
> + * @chan: Channel pointer
> + *
> + * Return: 'true' is no pending tx data, 'false' if there are any.
> + */
> +static bool zynqmp_ipi_last_tx_done(struct mbox_chan *chan) {
> +	struct device *dev =3D chan->mbox->dev;
> +	struct zynqmp_ipi_mbox *ipi_mbox =3D dev_get_drvdata(dev);
> +	struct zynqmp_ipi_mchan *mchan =3D chan->con_priv;
> +	int ret;
> +	u64 arg0;
> +	struct arm_smccc_res res;
> +	struct zynqmp_ipi_message *msg;
> +
> +	if (WARN_ON(!ipi_mbox)) {
> +		dev_err(dev, "no platform drv data??\n");
> +		return false;
> +	}
> +
> +	if (mchan->chan_type =3D=3D IPI_MB_CHNL_TX) {
> +		/* We only need to check if the message been taken
> +		 * by the remote in the TX channel
> +		 */
> +		arg0 =3D SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> +		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +		/* Check the SMC call status, a0 of the result */
> +		ret =3D (int)(res.a0 & 0xFFFFFFFF);
> +		if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
> +			return false;
> +
> +		msg =3D mchan->rx_buf;
> +		msg->len =3D mchan->resp_buf_size;
> +		memcpy_fromio(msg->data, mchan->resp_buf, msg->len);
> +		mbox_chan_received_data(chan, (void *)msg);
> +		return true;
> +	}
> +	/* Always true for the response message in RX channel */
> +	return true;
> +}
> +
> +/**
> + * zynqmp_ipi_send_data - Send data
> + *
> + * @chan: Channel Pointer
> + * @data: Message Pointer
> + *
> + * Return: 0 if all goes good, else appropriate error messages.
> + */
> +static int zynqmp_ipi_send_data(struct mbox_chan *chan, void *data) {
> +	struct device *dev =3D chan->mbox->dev;
> +	struct zynqmp_ipi_mbox *ipi_mbox =3D dev_get_drvdata(dev);
> +	struct zynqmp_ipi_mchan *mchan =3D chan->con_priv;
> +	struct zynqmp_ipi_message *msg =3D data;
> +	u64 arg0;
> +	struct arm_smccc_res res;
> +	u32 timeout;
> +	int ret;
> +
> +	if (WARN_ON(!ipi_mbox)) {
> +		dev_err(dev, "no platform drv data??\n");
> +		return -EINVAL;
> +	}
> +
> +	if (mchan->chan_type =3D=3D IPI_MB_CHNL_TX) {
> +		/* Send request message */
> +		if (msg && msg->len > mchan->req_buf_size) {
> +			dev_err(dev, "channel %d message length %u >
> max %lu\n",
> +				mchan->chan_type, (unsigned int)msg->len,
> +				mchan->req_buf_size);
> +			return -EINVAL;
> +		}
> +		/* Enquire if the mailbox is free to send message */
> +		arg0 =3D SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> +		timeout =3D 10;
> +		if (msg && msg->len) {
> +			timeout =3D 10;
> +			do {
> +				zynqmp_ipi_fw_call(ipi_mbox, arg0,
> +						   0, 0, 0, 0, 0, &res);
> +				ret =3D res.a0 & 0xFFFFFFFF;
> +				if (ret >=3D 0 &&
> +				    !(ret & IPI_MB_STATUS_SEND_PENDING))
> +					break;
> +				usleep_range(1, 2);
> +				timeout--;
> +			} while (timeout);
> +			if (!timeout) {
> +				dev_warn(dev, "chan %d sending msg
> timeout.\n",
> +					 ipi_mbox->remote_id);
> +				return -ETIME;
> +			}
> +			memcpy_toio(mchan->req_buf, msg->data, msg->len);
> +		}
> +		/* Kick IPI mailbox to send message */
> +		arg0 =3D SMC_IPI_MAILBOX_NOTIFY;
> +		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +	} else {
> +		/* Send response message */
> +		if (msg && msg->len > mchan->resp_buf_size) {
> +			dev_err(dev, "channel %d message length %u >
> max %lu\n",
> +				mchan->chan_type, (unsigned int)msg->len,
> +				mchan->resp_buf_size);
> +			return -EINVAL;
> +		}
> +		if (msg && msg->len)
> +			memcpy(mchan->resp_buf, msg->data, msg->len);
> +		arg0 =3D SMC_IPI_MAILBOX_NOTIFY;
> +		arg0 =3D SMC_IPI_MAILBOX_ACK;
> +		zynqmp_ipi_fw_call(ipi_mbox, arg0,
> IPI_SMC_ACK_EIRQ_MASK,
> +				   0, 0, 0, 0, &res);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * zynqmp_ipi_startup - Startup the IPI channel
> + *
> + * @chan: Channel pointer
> + *
> + * Return: 0 if all goes good, else return corresponding error message
> +*/ static int zynqmp_ipi_startup(struct mbox_chan *chan) {
> +	struct device *dev =3D chan->mbox->dev;
> +	struct zynqmp_ipi_mbox *ipi_mbox =3D dev_get_drvdata(dev);
> +	struct zynqmp_ipi_mchan *mchan =3D chan->con_priv;
> +	u64 arg0;
> +	struct arm_smccc_res res;
> +	int ret =3D 0;
> +	unsigned int nchan_type;
> +
> +	if (mchan->is_opened)
> +		return 0;
> +
> +	/* If no channel has been opened, open the IPI mailbox */
> +	nchan_type =3D (mchan->chan_type + 1) % 2;
> +	if (!ipi_mbox->mchans[nchan_type].is_opened) {
> +		arg0 =3D SMC_IPI_MAILBOX_OPEN;
> +		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +		/* Check the SMC call status, a0 of the result */
> +		ret =3D (int)(res.a0 | 0xFFFFFFFF);
> +		if (res.a0 < 0) {
> +			dev_err(dev, "SMC to open the IPI channel failed.\n");
> +			ret =3D res.a0;
> +			return ret;
> +		}
> +		ret =3D 0;
> +	}
> +
> +	/* If it is RX channel, enable the IPI notification interrupt */
> +	if (mchan->chan_type =3D=3D IPI_MB_CHNL_RX) {
> +		arg0 =3D SMC_IPI_MAILBOX_ENABLE_IRQ;
> +		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +	}
> +	mchan->is_opened =3D 1;
> +
> +	return ret;
> +}
> +
> +/**
> + * zynqmp_ipi_shutdown - Shutdown the IPI channel
> + *
> + * @chan: Channel pointer
> + */
> +static void zynqmp_ipi_shutdown(struct mbox_chan *chan) {
> +	struct device *dev =3D chan->mbox->dev;
> +	struct zynqmp_ipi_mbox *ipi_mbox =3D dev_get_drvdata(dev);
> +	struct zynqmp_ipi_mchan *mchan =3D chan->con_priv;
> +	u64 arg0;
> +	struct arm_smccc_res res;
> +	unsigned int chan_type;
> +
> +	if (!mchan->is_opened)
> +		return;
> +
> +	/* If it is RX channel, disable notification interrupt */
> +	chan_type =3D mchan->chan_type;
> +	if (chan_type =3D=3D IPI_MB_CHNL_RX) {
> +		arg0 =3D SMC_IPI_MAILBOX_DISABLE_IRQ;
> +		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +	}
> +	/* Release IPI mailbox if no other channel is opened */
> +	chan_type =3D (chan_type + 1) % 2;
> +	if (!ipi_mbox->mchans[chan_type].is_opened) {
> +		arg0 =3D SMC_IPI_MAILBOX_RELEASE;
> +		zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, 0, 0, 0, 0, &res);
> +	}
> +
> +	mchan->is_opened =3D 0;
> +}
> +
> +/* ZynqMP IPI mailbox operations */
> +static const struct mbox_chan_ops zynqmp_ipi_chan_ops =3D {
> +	.startup =3D zynqmp_ipi_startup,
> +	.shutdown =3D zynqmp_ipi_shutdown,
> +	.peek_data =3D zynqmp_ipi_peek_data,
> +	.last_tx_done =3D zynqmp_ipi_last_tx_done,
> +	.send_data =3D zynqmp_ipi_send_data,
> +};
> +
> +/**
> + * zynqmp_ipi_of_xlate - Translate of phandle to IPI mailbox channel
> + *
> + * @mbox: mailbox controller pointer
> + * @p:    phandle pointer
> + *
> + * Return: Mailbox channel, else return error pointer.
> + */
> +static struct mbox_chan *zynqmp_ipi_of_xlate(struct mbox_controller
> *mbox,
> +					     const struct of_phandle_args *p) {
> +	struct mbox_chan *chan;
> +	struct device *dev =3D mbox->dev;
> +	unsigned int chan_type;
> +
> +	/* Only supports TX and RX channels */
> +	chan_type =3D p->args[0];
> +	if (chan_type !=3D IPI_MB_CHNL_TX && chan_type !=3D IPI_MB_CHNL_RX)
> {
> +		dev_err(dev, "req chnl failure: invalid chnl type %u.\n",
> +			chan_type);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	chan =3D &mbox->chans[chan_type];
> +	return chan;
> +}
> +
> +static const struct of_device_id zynqmp_ipi_of_match[] =3D {
> +	{.compatible =3D "xlnx,zynqmp-ipi-mailbox"}, };
[Wendy] should add missing sentinel to the end of of_device_id table

> MODULE_DEVICE_TABLE(of,
> +zynqmp_ipi_of_match);
> +
> +/**
> + * zynqmp_ipi_mbox_get_buf_res - Get buffer resource from the IPI dev
> +node
> + *
> + * @node: IPI mbox device child node
> + * @name: name of the IPI buffer
> + * @res: pointer to where the resource information will be stored.
> + *
> + * Return: 0 for success, negative value for failure  */ static int
> +zynqmp_ipi_mbox_get_buf_res(struct device_node *node,
> +				       const char *name,
> +				       struct resource *res)
> +{
> +	int ret, index;
> +
> +	index =3D of_property_match_string(node, "reg-names", name);
> +	if (index >=3D 0) {
> +		ret =3D of_address_to_resource(node, index, res);
> +		if (ret < 0)
> +			return -EINVAL;
> +		return 0;
> +	}
> +	return -ENODEV;
> +}
> +
> +/**
> + * zynqmp_ipi_mbox_dev_release() - release the existence of a ipi mbox
> +dev
> + *
> + * This is to avoid the no device release() function kernel warning.
> + *
> + * @dev: the ipi mailbox device
> + */
> +static void zynqmp_ipi_mbox_dev_release(struct device *dev) {
> +	(void)dev;
> +}
> +
> +/**
> + * zynqmp_ipi_mbox_probe - probe IPI mailbox resource from device node
> + *
> + * @ipi_mbox: pointer to IPI mailbox private data structure
> + * @node: IPI mailbox device node
> + *
> + * Return: 0 for success, negative value for failure  */ static int
> +zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
> +				 struct device_node *node)
> +{
> +	struct zynqmp_ipi_mchan *mchan;
> +	struct mbox_chan *chans;
> +	struct mbox_controller *mbox;
> +	struct resource res;
> +	struct device *dev, *mdev;
> +	const char *name;
> +	int ret;
> +
> +	dev =3D ipi_mbox->pdata->dev;
> +	/* Initialize dev for IPI mailbox */
> +	ipi_mbox->dev.parent =3D dev;
> +	ipi_mbox->dev.release =3D NULL;
> +	ipi_mbox->dev.of_node =3D node;
> +	dev_set_name(&ipi_mbox->dev, "%s", of_node_full_name(node));
> +	dev_set_drvdata(&ipi_mbox->dev, ipi_mbox);
> +	ipi_mbox->dev.release =3D zynqmp_ipi_mbox_dev_release;
> +	ipi_mbox->dev.driver =3D &zynqmp_ipi_mbox_driver;
> +	ret =3D device_register(&ipi_mbox->dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register ipi mbox dev.\n");
> +		return ret;
> +	}
> +	mdev =3D &ipi_mbox->dev;
> +
> +	mchan =3D &ipi_mbox->mchans[IPI_MB_CHNL_TX];
> +	name =3D "local_request_region";
> +	ret =3D zynqmp_ipi_mbox_get_buf_res(node, name, &res);
> +	if (!ret) {
> +		mchan->req_buf_size =3D resource_size(&res);
> +		mchan->req_buf =3D devm_ioremap(mdev, res.start,
> +					      mchan->req_buf_size);
> +		if (IS_ERR(mchan->req_buf)) {
> +			dev_err(mdev, "Unable to map IPI buffer I/O
> memory\n");
> +			ret =3D PTR_ERR(mchan->req_buf);
> +			return ret;
> +		}
> +	} else if (ret !=3D -ENODEV) {
> +		dev_err(mdev, "Unmatched resource %s, %d.\n", name, ret);
> +		return ret;
> +	}
> +
> +	name =3D "remote_response_region";
> +	ret =3D zynqmp_ipi_mbox_get_buf_res(node, name, &res);
> +	if (!ret) {
> +		mchan->resp_buf_size =3D resource_size(&res);
> +		mchan->resp_buf =3D devm_ioremap(mdev, res.start,
> +					       mchan->resp_buf_size);
> +		if (IS_ERR(mchan->resp_buf)) {
> +			dev_err(mdev, "Unable to map IPI buffer I/O
> memory\n");
> +			ret =3D PTR_ERR(mchan->resp_buf);
> +			return ret;
> +		}
> +	} else if (ret !=3D -ENODEV) {
> +		dev_err(mdev, "Unmatched resource %s.\n", name);
> +		return ret;
> +	}
> +	mchan->rx_buf =3D devm_kzalloc(mdev,
> +				     mchan->resp_buf_size +
> +				     sizeof(struct zynqmp_ipi_message),
> +				     GFP_KERNEL);
> +	if (!mchan->rx_buf)
> +		return -ENOMEM;
> +
> +	mchan =3D &ipi_mbox->mchans[IPI_MB_CHNL_RX];
> +	name =3D "remote_request_region";
> +	ret =3D zynqmp_ipi_mbox_get_buf_res(node, name, &res);
> +	if (!ret) {
> +		mchan->req_buf_size =3D resource_size(&res);
> +		mchan->req_buf =3D devm_ioremap(mdev, res.start,
> +					      mchan->req_buf_size);
> +		if (IS_ERR(mchan->req_buf)) {
> +			dev_err(mdev, "Unable to map IPI buffer I/O
> memory\n");
> +			ret =3D PTR_ERR(mchan->req_buf);
> +			return ret;
> +		}
> +	} else if (ret !=3D -ENODEV) {
> +		dev_err(mdev, "Unmatched resource %s.\n", name);
> +		return ret;
> +	}
> +
> +	name =3D "local_response_region";
> +	ret =3D zynqmp_ipi_mbox_get_buf_res(node, name, &res);
> +	if (!ret) {
> +		mchan->resp_buf_size =3D resource_size(&res);
> +		mchan->resp_buf =3D devm_ioremap(mdev, res.start,
> +					       mchan->resp_buf_size);
> +		if (IS_ERR(mchan->resp_buf)) {
> +			dev_err(mdev, "Unable to map IPI buffer I/O
> memory\n");
> +			ret =3D PTR_ERR(mchan->resp_buf);
> +			return ret;
> +		}
> +	} else if (ret !=3D -ENODEV) {
> +		dev_err(mdev, "Unmatched resource %s.\n", name);
> +		return ret;
> +	}
> +	mchan->rx_buf =3D devm_kzalloc(mdev,
> +				     mchan->resp_buf_size +
> +				     sizeof(struct zynqmp_ipi_message),
> +				     GFP_KERNEL);
> +	if (!mchan->rx_buf)
> +		return -ENOMEM;
> +
> +	/* Get the IPI remote agent ID */
> +	ret =3D of_property_read_u32(node, "xlnx,ipi-id", &ipi_mbox-
> >remote_id);
> +	if (ret < 0) {
> +		dev_err(dev, "No IPI remote ID is specified.\n");
> +		return ret;
> +	}
> +
> +	mbox =3D &ipi_mbox->mbox;
> +	mbox->dev =3D mdev;
> +	mbox->ops =3D &zynqmp_ipi_chan_ops;
> +	mbox->num_chans =3D 2;
> +	mbox->txdone_irq =3D false;
> +	mbox->txdone_poll =3D true;
> +	mbox->txpoll_period =3D 5;
> +	mbox->of_xlate =3D zynqmp_ipi_of_xlate;
> +	chans =3D devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
> +	if (!chans)
> +		return -ENOMEM;
> +	mbox->chans =3D chans;
> +	chans[IPI_MB_CHNL_TX].con_priv =3D &ipi_mbox-
> >mchans[IPI_MB_CHNL_TX];
> +	chans[IPI_MB_CHNL_RX].con_priv =3D &ipi_mbox-
> >mchans[IPI_MB_CHNL_RX];
> +	ipi_mbox->mchans[IPI_MB_CHNL_TX].chan_type =3D IPI_MB_CHNL_TX;
> +	ipi_mbox->mchans[IPI_MB_CHNL_RX].chan_type =3D IPI_MB_CHNL_RX;
> +	ret =3D mbox_controller_register(mbox);
> +	if (ret)
> +		dev_err(mdev,
> +			"Failed to register mbox_controller(%d)\n", ret);
> +	else
> +		dev_info(mdev, "Probed ZynqMP IPI Mailbox driver.\n");
> +	return ret;
> +}
> +
> +/**
> + * zynqmp_ipi_free_mboxes - Free IPI mailboxes devices
> + *
> + * @pdata: IPI private data
> + */
> +static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata) {
> +	struct zynqmp_ipi_mbox *ipi_mbox;
> +	int i;
> +
> +	i =3D pdata->num_mboxes;
> +	for (; i >=3D 0; i--) {
> +		ipi_mbox =3D &pdata->ipi_mboxes[i];
> +		if (ipi_mbox->dev.parent) {
> +			mbox_controller_unregister(&ipi_mbox->mbox);
> +			device_unregister(&ipi_mbox->dev);
> +		}
> +	}
> +}
> +
> +static int zynqmp_ipi_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *nc, *np =3D pdev->dev.of_node;
> +	struct zynqmp_ipi_pdata *pdata;
> +	struct zynqmp_ipi_mbox *mbox;
> +	int i, ret =3D -EINVAL;
> +
> +	i =3D 0;
> +	for_each_available_child_of_node(np, nc)
> +		i++;
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata) + (i * sizeof(*mbox)),
> +			     GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +	pdata->dev =3D dev;
> +
> +	/* Get the IPI local agents ID */
> +	ret =3D of_property_read_u32(np, "xlnx,ipi-id", &pdata->local_id);
> +	if (ret < 0) {
> +		dev_err(dev, "No IPI local ID is specified.\n");
> +		return ret;
> +	}
> +
> +	pdata->num_mboxes =3D i;
> +	pdata->ipi_mboxes =3D (struct zynqmp_ipi_mbox *)
> +			    ((char *)pdata + sizeof(*pdata));
> +
> +	mbox =3D pdata->ipi_mboxes;
> +	for_each_available_child_of_node(np, nc) {
> +		mbox->pdata =3D pdata;
> +		ret =3D zynqmp_ipi_mbox_probe(mbox, nc);
> +		if (ret) {
> +			dev_err(dev, "failed to probe subdev.\n");
> +			ret =3D -EINVAL;
> +			goto free_mbox_dev;
> +		}
> +		mbox++;
> +	}
> +
> +	/* IPI IRQ */
> +	ret =3D platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to find IPI IRQ.\n");
> +		goto free_mbox_dev;
> +	}
> +	pdata->irq =3D ret;
> +	ret =3D devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
> +			       IRQF_SHARED, dev_name(dev), pdata);
> +	if (ret) {
> +		dev_err(dev, "IRQ %d is not requested successfully.\n",
> +			pdata->irq);
> +		goto free_mbox_dev;
> +	}
> +
> +	platform_set_drvdata(pdev, pdata);
> +	return ret;
> +
> +free_mbox_dev:
> +	zynqmp_ipi_free_mboxes(pdata);
> +	return ret;
> +}
> +
> +static int zynqmp_ipi_remove(struct platform_device *pdev) {
> +	struct zynqmp_ipi_pdata *pdata;
> +
> +	pdata =3D platform_get_drvdata(pdev);
> +	zynqmp_ipi_free_mboxes(pdata);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver zynqmp_ipi_driver =3D {
> +	.probe =3D zynqmp_ipi_probe,
> +	.remove =3D zynqmp_ipi_remove,
> +	.driver =3D {
> +		   .name =3D "zynqmp-ipi",
> +		   .of_match_table =3D of_match_ptr(zynqmp_ipi_of_match),
> +	},
> +};
> +
> +static int __init zynqmp_ipi_init(void) {
> +	return platform_driver_register(&zynqmp_ipi_driver);
> +}
> +subsys_initcall(zynqmp_ipi_init);
> +
> +static void __exit zynqmp_ipi_exit(void) {
> +	platform_driver_unregister(&zynqmp_ipi_driver);
> +}
> +module_exit(zynqmp_ipi_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Xilinx ZynqMP IPI Mailbox driver");
> +MODULE_AUTHOR("Xilinx Inc.");
> diff --git a/include/linux/mailbox/zynqmp-ipi-message.h
> b/include/linux/mailbox/zynqmp-ipi-message.h
> new file mode 100644
> index 0000000..72a9d9d
> --- /dev/null
> +++ b/include/linux/mailbox/zynqmp-ipi-message.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2017 Xilinx Inc.
> + *
> + */
> +
> +#ifndef _LINUX_ZYNQMP_IPI_MESSAGE_H_
> +#define _LINUX_ZYNQMP_IPI_MESSAGE_H_
> +
> +/**
> + * struct zynqmp_ipi_message - ZynqMP IPI message structure
> + * @len:  Length of the request message
> + * @data: Request message
> + *
> + * This is the structure for data used in mbox_send_message
> + * the maximum length of data buffer is fixed to 12 bytes.
> + * Client is supposed to be aware of this.
> + */
> +struct zynqmp_ipi_message {
> +	size_t len;
> +	u8 data[0];
> +};
> +
> +#endif /* _LINUX_ZYNQMP_IPI_MESSAGE_H_ */
> --
> 2.7.4

