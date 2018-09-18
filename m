Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87C2ECE568
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEB121471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="ma9xqeZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEB121471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeIRPyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:54:37 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.135]:13390 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeIRPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1537266154;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:Subject:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/S2cTsGLHgBD+NvlKbydk1shB3NW+NAOgZhnptohJXQ=;
        b=ma9xqeZcETktQKZiurBUMFzuPkbXB2RxNE5NNa2sHjVUaFgfUCfsLOiPlOQ1bUpl+8
        nln0m+vJ6p7/uSiZiFR6s+JHfMXEIlps0iy4sPzGzaSYW5rbBktB+rhnPiNpU6Po9+ht
        4ozmBYCJYogtjtmQaak1R/2rpNajkjsD3eIJCWrXUQ3ciWlZen3+RKUu03YxNwfLSqTD
        +MbvcW7elfUUpwNdSHdjwAtNrmj6me6qjclwD1xuf0Soo0NHy7SR7yWzqmbZAzsbl+e6
        pY9gNzWy6sCeQXVdlMCh+Br2+BjWuRC/pJTruYCFeTbpiKzvNcpBh4KbRIFW8mMcVPiu
        PMtg==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyMly7vtKoBCSu4zR9/f0shzjGSYbJY5KbsbrlTGd0CtJA="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2003:a:e7a:6200:246c:2a8b:f45a:a33d]
        by smtp.strato.de (RZmta 44.1 AUTH)
        with ESMTPSA id C0b243u8IALPEUC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 18 Sep 2018 12:21:25 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        linux-kernel@vger.kernel.org
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <9a80752f-2db3-bf76-fbf4-e5efaa3974d7@exceet.de>
Date:   Tue, 18 Sep 2018 12:21:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

I have some remarks about your general approach that came to me when 
looking at the FSPI driver with the things at the back of my mind, that 
I've learned from working at the FSL QSPI driver.

On 17.09.2018 11:48, Yogesh Gaur wrote:
> - Add a driver for NXP FlexSPI host controller
> 
> (0) What is the FlexSPI controller?
>   FlexSPI is a flexsible SPI host controller which supports two SPI
>   channels and up to 4 external devices. Each channel supports
>   Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional
>   data lines) i.e. FlexSPI acts as an interface to external devices,
>   maximum 4, each with up to 8 bidirectional data lines.
> 
>   It uses new SPI memory interface of SPI framework to issue flash memory
>   operations to up to four connected flash chips (2 buses with 2 CS each).
> 
> (1) Tested this driver with the mtd_debug and JFFS2 filesystem utility
>   on NXP LX2160ARDB and LX2160AQDS targets.
>   LX2160ARDB is having two NOR slave device connected on single bus A
>   i.e. A0 and A1 (CS0 and CS1).
>   LX2160AQDS is having two NOR slave device connected on separate buses
>   one flash on A0 and second on B1 i.e. (CS0 and CS3).
>   Verified this driver on following SPI NOR flashes:
>      Micron, mt35xu512ab, [Read - 1 bit mode]
>      Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v2:
> - Incorporated Boris review comments.
> - Remove dependency of driver over connected flash device size.
> - Modified the logic to select requested CS.
> - Remove SPI-Octal Macros.
> 
>   drivers/spi/Kconfig        |   10 +
>   drivers/spi/Makefile       |    1 +
>   drivers/spi/spi-nxp-fspi.c | 1246 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1257 insertions(+)
>   create mode 100644 drivers/spi/spi-nxp-fspi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ad5d68e..68da874 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -251,6 +251,16 @@ config SPI_FSL_LPSPI
>   	help
>   	  This enables Freescale i.MX LPSPI controllers in master mode.
>   
> +config SPI_NXP_FLEXSPI
> +	tristate "NXP Flex SPI controller"
> +	depends on ARCH_LAYERSCAPE || HAS_IOMEM
> +	help
> +	  This enables support for the Flex SPI controller in master mode.
> +	  Up to four slave devices can be connected on two buses with two
> +	  chipselects each.
> +	  This controller does not support generic SPI messages and only
> +	  supports the high-level SPI memory interface.
> +
>   config SPI_GPIO
>   	tristate "GPIO-based bitbanging SPI Master"
>   	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index cb1f437..52c9f18 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
>   obj-$(CONFIG_SPI_MT65XX)                += spi-mt65xx.o
>   obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
>   obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
> +obj-$(CONFIG_SPI_NXP_FLEXSPI)		+= spi-nxp-fspi.o
>   obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
>   spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
>   obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> new file mode 100644
> index 0000000..8106254
> --- /dev/null
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -0,0 +1,1246 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * NXP FlexSPI(FSPI) controller driver.
> + *
> + * Copyright 2018 NXP.
> + *
> + * FlexSPI is a flexsible SPI host controller which supports two SPI
> + * channels and up to 4 external devices. Each channel supports
> + * Single/Dual/Quad/Octal mode data transfer (1/2/4/8 bidirectional
> + * data lines).
> + *
> + * FlexSPI controller is driven by the LUT(Look-up Table) registers
> + * LUT registers are a look-up-table for sequences of instructions.
> + * A valid sequence consists of four LUT registers.
> + * Maximum 32 LUT sequences can be programmed simultaneously.
> + *
> + * LUTs are being created at run-time based on the commands passed
> + * from the spi-mem framework, using single LUT index.
> + *
> + * Software triggered Flash read/write access by IP Bus.
> + *
> + * Memory mapped read access by AHB Bus.
> + *
> + * Based on SPI MEM interface.
> + *
> + * Author:
> + *     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Although the QSPI driver is not merged yet, large parts of this driver 
are based on the code that Boris and I have written for the FSL QSPI 
controller. So I consider it appropriate to add a reference to the QSPI 
driver and its authors here.

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
> +#include <linux/sizes.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/*
> + * The driver only uses one single LUT entry, that is updated on
> + * each call of exec_op(). Index 0 is preset at boot with a basic
> + * read operation, so let's use the last entry (31).
> + */
> +#define	SEQID_LUT			31
> +
> +/* Registers used by the driver */
> +#define FSPI_MCR0			0x00
> +#define FSPI_MCR0_AHB_TIMEOUT_SHIFT	24
> +#define FSPI_MCR0_AHB_TIMEOUT_MASK	(0xFF << FSPI_MCR0_AHB_TIMEOUT_SHIFT)
> +#define FSPI_MCR0_IP_TIMEOUT_SHIFT	16
> +#define FSPI_MCR0_IP_TIMEOUT_MASK	(0xFF << FSPI_MCR0_IP_TIMEOUT_SHIFT)
> +#define FSPI_MCR0_LEARN_EN_SHIFT	15
> +#define FSPI_MCR0_LEARN_EN_MASK		(1 << FSPI_MCR0_LEARN_EN_SHIFT)
> +#define FSPI_MCR0_SCRFRUN_EN_SHIFT	14
> +#define FSPI_MCR0_SCRFRUN_EN_MASK	(1 << FSPI_MCR0_SCRFRUN_EN_SHIFT)
> +#define FSPI_MCR0_OCTCOMB_EN_SHIFT	13
> +#define FSPI_MCR0_OCTCOMB_EN_MASK	(1 << FSPI_MCR0_OCTCOMB_EN_SHIFT)
> +#define FSPI_MCR0_DOZE_EN_SHIFT		12
> +#define FSPI_MCR0_DOZE_EN_MASK		(1 << FSPI_MCR0_DOZE_EN_SHIFT)
> +#define FSPI_MCR0_HSEN_SHIFT		11
> +#define FSPI_MCR0_HSEN_MASK		(1 << FSPI_MCR0_HSEN_SHIFT)
> +#define FSPI_MCR0_SERCLKDIV_SHIFT	8
> +#define FSPI_MCR0_SERCLKDIV_MASK	(7 << FSPI_MCR0_SERCLKDIV_SHIFT)
> +#define FSPI_MCR0_ATDF_EN_SHIFT		7
> +#define FSPI_MCR0_ATDF_EN_MASK		(1 << FSPI_MCR0_ATDF_EN_SHIFT)
> +#define FSPI_MCR0_ARDF_EN_SHIFT		6
> +#define FSPI_MCR0_ARDF_EN_MASK		(1 << FSPI_MCR0_ARDF_EN_SHIFT)
> +#define FSPI_MCR0_RXCLKSRC_SHIFT	4
> +#define FSPI_MCR0_RXCLKSRC_MASK		(3 << FSPI_MCR0_RXCLKSRC_SHIFT)
> +#define FSPI_MCR0_END_CFG_SHIFT		2
> +#define FSPI_MCR0_END_CFG_MASK		(3 << FSPI_MCR0_END_CFG_SHIFT)
> +#define FSPI_MCR0_MDIS_SHIFT		1
> +#define FSPI_MCR0_MDIS_MASK		(1 << FSPI_MCR0_MDIS_SHIFT)
> +#define FSPI_MCR0_SWRST_SHIFT		0
> +#define FSPI_MCR0_SWRST_MASK		(1 << FSPI_MCR0_SWRST_SHIFT)
> +
> +#define FSPI_MCR1			0x04
> +#define FSPI_MCR1_SEQ_TIMEOUT_SHIFT	16
> +#define FSPI_MCR1_SEQ_TIMEOUT_MASK	(0xFFFF << FSPI_MCR1_SEQ_TIMEOUT_SHIFT)
> +#define FSPI_MCR1_AHB_TIMEOUT_SHIFT	0
> +#define FSPI_MCR1_AHB_TIMEOUT_MASK	(0xFFFF << FSPI_MCR1_AHB_TIMEOUT_SHIFT)
> +
> +#define FSPI_MCR2			0x08
> +#define FSPI_MCR2_IDLE_WAIT_SHIFT	24
> +#define FSPI_MCR2_IDLE_WAIT_MASK	(0xFF << FSPI_MCR2_IDLE_WAIT_SHIFT)
> +#define FSPI_MCR2_SAMEDEVICEEN_SHIFT	15
> +#define FSPI_MCR2_SAMEDEVICEEN_MASK	(1 << FSPI_MCR2_SAMEDEVICEEN_SHIFT)
> +#define FSPI_MCR2_CLRLRPHS_SHIFT	14
> +#define FSPI_MCR2_CLRLRPHS_MASK		(1 << FSPI_MCR2_CLRLRPHS_SHIFT)
> +#define FSPI_MCR2_ABRDATSZ_SHIFT	8
> +#define FSPI_MCR2_ABRDATSZ_MASK		(1 << FSPI_MCR2_ABRDATSZ_SHIFT)
> +#define FSPI_MCR2_ABRLEARN_SHIFT	7
> +#define FSPI_MCR2_ABRLEARN_MASK		(1 << FSPI_MCR2_ABRLEARN_SHIFT)
> +#define FSPI_MCR2_ABR_READ_SHIFT	6
> +#define FSPI_MCR2_ABR_READ_MASK		(1 << FSPI_MCR2_ABR_READ_SHIFT)
> +#define FSPI_MCR2_ABRWRITE_SHIFT	5
> +#define FSPI_MCR2_ABRWRITE_MASK		(1 << FSPI_MCR2_ABRWRITE_SHIFT)
> +#define FSPI_MCR2_ABRDUMMY_SHIFT	4
> +#define FSPI_MCR2_ABRDUMMY_MASK		(1 << FSPI_MCR2_ABRDUMMY_SHIFT)
> +#define FSPI_MCR2_ABR_MODE_SHIFT	3
> +#define FSPI_MCR2_ABR_MODE_MASK		(1 << FSPI_MCR2_ABR_MODE_SHIFT)
> +#define FSPI_MCR2_ABRCADDR_SHIFT	2
> +#define FSPI_MCR2_ABRCADDR_MASK		(1 << FSPI_MCR2_ABRCADDR_SHIFT)
> +#define FSPI_MCR2_ABRRADDR_SHIFT	1
> +#define FSPI_MCR2_ABRRADDR_MASK		(1 << FSPI_MCR2_ABRRADDR_SHIFT)
> +#define FSPI_MCR2_ABR_CMD_SHIFT		0
> +#define FSPI_MCR2_ABR_CMD_MASK		(1 << FSPI_MCR2_ABR_CMD_SHIFT)
> +
> +#define FSPI_AHBCR			0x0c
> +#define FSPI_AHBCR_RDADDROPT_SHIFT	6
> +#define FSPI_AHBCR_RDADDROPT_MASK	(1 << FSPI_AHBCR_RDADDROPT_SHIFT)
> +#define FSPI_AHBCR_PREF_EN_SHIFT	5
> +#define FSPI_AHBCR_PREF_EN_MASK		(1 << FSPI_AHBCR_PREF_EN_SHIFT)
> +#define FSPI_AHBCR_BUFF_EN_SHIFT	4
> +#define FSPI_AHBCR_BUFF_EN_MASK		(1 << FSPI_AHBCR_BUFF_EN_SHIFT)
> +#define FSPI_AHBCR_CACH_EN_SHIFT	3
> +#define FSPI_AHBCR_CACH_EN_MASK		(1 << FSPI_AHBCR_CACH_EN_SHIFT)
> +#define FSPI_AHBCR_CLRTXBUF_SHIFT	2
> +#define FSPI_AHBCR_CLRTXBUF_MASK	(1 << FSPI_AHBCR_CLRTXBUF_SHIFT)
> +#define FSPI_AHBCR_CLRRXBUF_SHIFT	1
> +#define FSPI_AHBCR_CLRRXBUF_MASK	(1 << FSPI_AHBCR_CLRRXBUF_SHIFT)
> +#define FSPI_AHBCR_PAR_EN_SHIFT		0
> +#define FSPI_AHBCR_PAR_EN_MASK		(1 << FSPI_AHBCR_PAR_EN_SHIFT)
> +
> +#define FSPI_INTEN			0x10
> +#define FSPI_INTEN_SCLKSBWR_SHIFT	9
> +#define FSPI_INTEN_SCLKSBWR_MASK	(1 << FSPI_INTEN_SCLKSBWR_SHIFT)
> +#define FSPI_INTEN_SCLKSBRD_SHIFT	8
> +#define FSPI_INTEN_SCLKSBRD_MASK	(1 << FSPI_INTEN_SCLKSBRD_SHIFT)
> +#define FSPI_INTEN_DATALRNFL_SHIFT	7
> +#define FSPI_INTEN_DATALRNFL_MASK	(1 << FSPI_INTEN_DATALRNFL_SHIFT)
> +#define FSPI_INTEN_IPTXWE_SHIFT		6
> +#define FSPI_INTEN_IPTXWE_MASK		(1 << FSPI_INTEN_IPTXWE_SHIFT)
> +#define FSPI_INTEN_IPRXWA_SHIFT		5
> +#define FSPI_INTEN_IPRXWA_MASK		(1 << FSPI_INTEN_IPRXWA_SHIFT)
> +#define FSPI_INTEN_AHBCMDERR_SHIFT	4
> +#define FSPI_INTEN_AHBCMDERR_MASK	(1 << FSPI_INTEN_AHBCMDERR_SHIFT)
> +#define FSPI_INTEN_IPCMDERR_SHIFT	3
> +#define FSPI_INTEN_IPCMDERR_MASK	(1 << FSPI_INTEN_IPCMDERR_SHIFT)
> +#define FSPI_INTEN_AHBCMDGE_SHIFT	2
> +#define FSPI_INTEN_AHBCMDGE_MASK	(1 << FSPI_INTEN_AHBCMDGE_SHIFT)
> +#define FSPI_INTEN_IPCMDGE_SHIFT	1
> +#define FSPI_INTEN_IPCMDGE_MASK		(1 << FSPI_INTEN_IPCMDGE_SHIFT)
> +#define FSPI_INTEN_IPCMDDONE_SHIFT	0
> +#define FSPI_INTEN_IPCMDDONE_MASK	(1 << FSPI_INTEN_IPCMDDONE_SHIFT)
> +
> +#define FSPI_INTR			0x14
> +#define FSPI_INTR_SCLKSBWR_SHIFT	9
> +#define FSPI_INTR_SCLKSBWR_MASK		(1 << FSPI_INTR_SCLKSBWR_SHIFT)
> +#define FSPI_INTR_SCLKSBRD_SHIFT	8
> +#define FSPI_INTR_SCLKSBRD_MASK		(1 << FSPI_INTR_SCLKSBRD_SHIFT)
> +#define FSPI_INTR_DATALRNFL_SHIFT	7
> +#define FSPI_INTR_DATALRNFL_MASK	(1 << FSPI_INTR_DATALRNFL_SHIFT)
> +#define FSPI_INTR_IPTXWE_SHIFT		6
> +#define FSPI_INTR_IPTXWE_MASK		(1 << FSPI_INTR_IPTXWE_SHIFT)
> +#define FSPI_INTR_IPRXWA_SHIFT		5
> +#define FSPI_INTR_IPRXWA_MASK		(1 << FSPI_INTR_IPRXWA_SHIFT)
> +#define FSPI_INTR_AHBCMDERR_SHIFT	4
> +#define FSPI_INTR_AHBCMDERR_MASK	(1 << FSPI_INTR_AHBCMDERR_SHIFT)
> +#define FSPI_INTR_IPCMDERR_SHIFT	3
> +#define FSPI_INTR_IPCMDERR_MASK		(1 << FSPI_INTR_IPCMDERR_SHIFT)
> +#define FSPI_INTR_AHBCMDGE_SHIFT	2
> +#define FSPI_INTR_AHBCMDGE_MASK		(1 << FSPI_INTR_AHBCMDGE_SHIFT)
> +#define FSPI_INTR_IPCMDGE_SHIFT		1
> +#define FSPI_INTR_IPCMDGE_MASK		(1 << FSPI_INTR_IPCMDGE_SHIFT)
> +#define FSPI_INTR_IPCMDDONE_SHIFT	0
> +#define FSPI_INTR_IPCMDDONE_MASK	(1 << FSPI_INTR_IPCMDDONE_SHIFT)
> +
> +#define FSPI_LUTKEY			0x18
> +#define FSPI_LUTKEY_VALUE		0x5AF05AF0
> +
> +#define FSPI_LCKCR			0x1C
> +
> +#define FSPI_LCKER_LOCK			0x1
> +#define FSPI_LCKER_UNLOCK		0x2
> +
> +#define FSPI_BUFXCR_INVALID_MSTRID	0xE
> +#define FSPI_AHBRX_BUF0CR0		0x20
> +#define FSPI_AHBRX_BUF1CR0		0x24
> +#define FSPI_AHBRX_BUF2CR0		0x28
> +#define FSPI_AHBRX_BUF3CR0		0x2C
> +#define FSPI_AHBRX_BUF4CR0		0x30
> +#define FSPI_AHBRX_BUF5CR0		0x34
> +#define FSPI_AHBRX_BUF6CR0		0x38
> +#define FSPI_AHBRX_BUF7CR0		0x3C
> +#define FSPI_AHBRXBUF0CR7_PREF_SHIFT	31
> +#define FSPI_AHBRXBUF0CR7_PREF_MASK	(1 << FSPI_AHBRXBUF0CR7_PREF_SHIFT)
> +
> +#define FSPI_AHBRX_BUF0CR1		0x40
> +#define FSPI_AHBRX_BUF1CR1		0x44
> +#define FSPI_AHBRX_BUF2CR1		0x48
> +#define FSPI_AHBRX_BUF3CR1		0x4C
> +#define FSPI_AHBRX_BUF4CR1		0x50
> +#define FSPI_AHBRX_BUF5CR1		0x54
> +#define FSPI_AHBRX_BUF6CR1		0x58
> +#define FSPI_AHBRX_BUF7CR1		0x5C
> +#define FSPI_BUFXCR1_MSID_SHIFT		0x0
> +#define FSPI_BUFXCR1_MSID_MASK		(0xF << FSPI_BUFXCR1_MSID_SHIFT)
> +#define FSPI_BUFXCR1_PRIO_SHIFT		0x8
> +#define FSPI_BUFXCR1_PRIO_MASK		(0x7 << FSPI_BUFXCR1_PRIO_SHIFT)
> +
> +#define FSPI_FLSHA1CR0			0x60
> +#define FSPI_FLSHA2CR0			0x64
> +#define FSPI_FLSHB1CR0			0x68
> +#define FSPI_FLSHB2CR0			0x6C
> +#define FSPI_FLSHXCR0_SZ_SHIFT		10
> +#define FSPI_FLSHXCR0_SZ_MASK		(0x3FFFFF << FSPI_FLSHXCR0_SZ_SHIFT)
> +
> +#define FSPI_FLSHA1CR1			0x70
> +#define FSPI_FLSHA2CR1			0x74
> +#define FSPI_FLSHB1CR1			0x78
> +#define FSPI_FLSHB2CR1			0x7C
> +#define FSPI_FLSHXCR1_CSINTR_SHIFT	16
> +#define FSPI_FLSHXCR1_CSINTR_MASK	\
> +	(0xFFFF << FSPI_FLSHXCR1_CSINTR_SHIFT)
> +#define FSPI_FLSHXCR1_CAS_SHIFT		11
> +#define FSPI_FLSHXCR1_CAS_MASK		(0xF << FSPI_FLSHXCR1_CAS_SHIFT)
> +#define FSPI_FLSHXCR1_WA_SHIFT		10
> +#define FSPI_FLSHXCR1_WA_MASK		(1 << FSPI_FLSHXCR1_WA_SHIFT)
> +#define FSPI_FLSHXCR1_TCSH_SHIFT	5
> +#define FSPI_FLSHXCR1_TCSH_MASK		(0x1F << FSPI_FLSHXCR1_TCSH_SHIFT)
> +#define FSPI_FLSHXCR1_TCSS_SHIFT	0
> +#define FSPI_FLSHXCR1_TCSS_MASK		(0x1F << FSPI_FLSHXCR1_TCSS_SHIFT)
> +
> +#define FSPI_FLSHA1CR2			0x80
> +#define FSPI_FLSHA2CR2			0x84
> +#define FSPI_FLSHB1CR2			0x88
> +#define FSPI_FLSHB2CR2			0x8C
> +#define FSPI_FLSHXCR2_CLRINSP_SHIFT	24
> +#define FSPI_FLSHXCR2_CLRINSP_MASK	(1 << FSPI_FLSHXCR2_CLRINSP_SHIFT)
> +#define FSPI_FLSHXCR2_AWRWAIT_SHIFT	16
> +#define FSPI_FLSHXCR2_AWRWAIT_MASK	(0xFF << FSPI_FLSHXCR2_AWRWAIT_SHIFT)
> +#define FSPI_FLSHXCR2_AWRSEQN_SHIFT	13
> +#define FSPI_FLSHXCR2_AWRSEQN_MASK	(0x7 << FSPI_FLSHXCR2_AWRSEQN_SHIFT)
> +#define FSPI_FLSHXCR2_AWRSEQI_SHIFT	8
> +#define FSPI_FLSHXCR2_AWRSEQI_MASK	(0xF << FSPI_FLSHXCR2_AWRSEQI_SHIFT)
> +#define FSPI_FLSHXCR2_ARDSEQN_SHIFT	5
> +#define FSPI_FLSHXCR2_ARDSEQN_MASK	(0x7 << FSPI_FLSHXCR2_ARDSEQN_SHIFT)
> +#define FSPI_FLSHXCR2_ARDSEQI_SHIFT	0
> +#define FSPI_FLSHXCR2_ARDSEQI_MASK	(0xF << FSPI_FLSHXCR2_ARDSEQI_SHIFT)
> +
> +#define FSPI_IPCR0			0xA0
> +
> +#define FSPI_IPCR1			0xA4
> +#define FSPI_IPCR1_IPAREN_SHIFT		31
> +#define FSPI_IPCR1_IPAREN_MASK		(1 << FSPI_IPCR1_IPAREN_SHIFT)
> +#define FSPI_IPCR1_SEQNUM_SHIFT		24
> +#define FSPI_IPCR1_SEQNUM_MASK		(0xF << FSPI_IPCR1_SEQNUM_SHIFT)
> +#define FSPI_IPCR1_SEQID_SHIFT		16
> +#define FSPI_IPCR1_SEQID_MASK		(0xF << FSPI_IPCR1_SEQID_SHIFT)
> +#define FSPI_IPCR1_IDATSZ_SHIFT		0
> +#define FSPI_IPCR1_IDATSZ_MASK		(0xFFFF << FSPI_IPCR1_IDATSZ_SHIFT)
> +
> +#define FSPI_IPCMD			0xB0
> +#define FSPI_IPCMD_TRG_SHIFT		0
> +#define FSPI_IPCMD_TRG_MASK		(1 << FSPI_IPCMD_TRG_SHIFT)
> +
> +#define FSPI_DLPR			0xB4
> +
> +#define FSPI_IPRXFCR			0xB8
> +#define FSPI_IPRXFCR_CLR_SHIFT		0
> +#define FSPI_IPRXFCR_CLR_MASK		(1 << FSPI_IPRXFCR_CLR_SHIFT)
> +#define FSPI_IPRXFCR_DMA_EN_SHIFT	1
> +#define FSPI_IPRXFCR_DMA_EN_MASK	(1 << FSPI_IPRXFCR_DMA_EN_SHIFT)
> +#define FSPI_IPRXFCR_WMRK_SHIFT		2
> +#define FSPI_IPRXFCR_WMRK_MASK		(0x1F << FSPI_IPRXFCR_WMRK_SHIFT)
> +
> +#define FSPI_IPTXFCR			0xBC
> +#define FSPI_IPTXFCR_CLR_SHIFT		0
> +#define FSPI_IPTXFCR_CLR_MASK		(1 << FSPI_IPTXFCR_CLR_SHIFT)
> +#define FSPI_IPTXFCR_DMA_EN_SHIFT	1
> +#define FSPI_IPTXFCR_DMA_EN_MASK	(1 << FSPI_IPTXFCR_DMA_EN_SHIFT)
> +#define FSPI_IPTXFCR_WMRK_SHIFT		2
> +#define FSPI_IPTXFCR_WMRK_MASK		(0x1F << FSPI_IPTXFCR_WMRK_SHIFT)
> +
> +#define FSPI_DLLACR			0xC0
> +#define FSPI_DLLACR_OVRDEN_SHIFT	8
> +#define FSPI_DLLACR_OVRDEN_MASK		(1 << FSPI_DLLACR_OVRDEN_SHIFT)
> +
> +#define FSPI_DLLBCR			0xC4
> +#define FSPI_DLLBCR_OVRDEN_SHIFT	8
> +#define FSPI_DLLBCR_OVRDEN_MASK		(1 << FSPI_DLLBCR_OVRDEN_SHIFT)
> +
> +#define FSPI_STS0			0xE0
> +#define FSPI_STS0_DLPHA_SHIFT		9
> +#define FSPI_STS0_DLPHA_MASK		(0x1F << FSPI_STS0_DLPHA_SHIFT)
> +#define FSPI_STS0_DLPHB_SHIFT		4
> +#define FSPI_STS0_DLPHB_MASK		(0x1F << FSPI_STS0_DLPHB_SHIFT)
> +#define FSPI_STS0_CMD_SRC_SHIFT		2
> +#define FSPI_STS0_CMD_SRC_MASK		(3 << FSPI_STS0_CMD_SRC_SHIFT)
> +#define FSPI_STS0_ARB_IDLE_SHIFT	1
> +#define FSPI_STS0_ARB_IDLE_MASK		(1 << FSPI_STS0_ARB_IDLE_SHIFT)
> +#define FSPI_STS0_SEQ_IDLE_SHIFT	0
> +#define FSPI_STS0_SEQ_IDLE_MASK		(1 << FSPI_STS0_SEQ_IDLE_SHIFT)
> +
> +#define FSPI_STS1			0xE4
> +#define FSPI_STS1_IP_ERRCD_SHIFT	24
> +#define FSPI_STS1_IP_ERRCD_MASK		(0xF << FSPI_STS1_IP_ERRCD_SHIFT)
> +#define FSPI_STS1_IP_ERRID_SHIFT	16
> +#define FSPI_STS1_IP_ERRID_MASK		(0xF << FSPI_STS1_IP_ERRID_SHIFT)
> +#define FSPI_STS1_AHB_ERRCD_SHIFT	8
> +#define FSPI_STS1_AHB_ERRCD_MASK	(0xF << FSPI_STS1_AHB_ERRCD_SHIFT)
> +#define FSPI_STS1_AHB_ERRID_SHIFT	0
> +#define FSPI_STS1_AHB_ERRID_MASK	(0xF << FSPI_STS1_AHB_ERRID_SHIFT)
> +
> +#define FSPI_AHBSPNST			0xEC
> +#define FSPI_AHBSPNST_DATLFT_SHIFT	16
> +#define FSPI_AHBSPNST_DATLFT_MASK	\
> +	(0xFFFF << FSPI_AHBSPNST_DATLFT_SHIFT)
> +#define FSPI_AHBSPNST_BUFID_SHIFT	1
> +#define FSPI_AHBSPNST_BUFID_MASK	(7 << FSPI_AHBSPNST_BUFID_SHIFT)
> +#define FSPI_AHBSPNST_ACTIVE_SHIFT	0
> +#define FSPI_AHBSPNST_ACTIVE_MASK	(1 << FSPI_AHBSPNST_ACTIVE_SHIFT)
> +
> +#define FSPI_IPRXFSTS			0xF0
> +#define FSPI_IPRXFSTS_RDCNTR_SHIFT	16
> +#define FSPI_IPRXFSTS_RDCNTR_MASK	\
> +	(0xFFFF << FSPI_IPRXFSTS_RDCNTR_SHIFT)
> +#define FSPI_IPRXFSTS_FILL_SHIFT	0
> +#define FSPI_IPRXFSTS_FILL_MASK		(0xFF << FSPI_IPRXFSTS_FILL_SHIFT)
> +
> +#define FSPI_IPTXFSTS			0xF4
> +#define FSPI_IPTXFSTS_WRCNTR_SHIFT	16
> +#define FSPI_IPTXFSTS_WRCNTR_MASK	\
> +	(0xFFFF << FSPI_IPTXFSTS_WRCNTR_SHIFT)
> +#define FSPI_IPTXFSTS_FILL_SHIFT	0
> +#define FSPI_IPTXFSTS_FILL_MASK		(0xFF << FSPI_IPTXFSTS_FILL_SHIFT)
> +
> +#define FSPI_RFDR			0x100
> +#define FSPI_TFDR			0x180
> +
> +#define FSPI_LUT_BASE			0x200
> +#define FSPI_LUT_OFFSET		(SEQID_LUT * 4 * 4)
> +#define FSPI_LUT_REG(idx) \
> +	(FSPI_LUT_BASE + FSPI_LUT_OFFSET + (idx) * 4)
> +
> +/* register map end */
> +
> +/* Instruction set for the LUT register. */
> +#define LUT_STOP			0x00
> +#define LUT_CMD				0x01
> +#define LUT_ADDR			0x02
> +#define LUT_CADDR_SDR			0x03
> +#define LUT_MODE			0x04
> +#define LUT_MODE2			0x05
> +#define LUT_MODE4			0x06
> +#define LUT_MODE8			0x07
> +#define LUT_NXP_WRITE			0x08
> +#define LUT_NXP_READ			0x09
> +#define LUT_LEARN_SDR			0x0A
> +#define LUT_DATSZ_SDR			0x0B
> +#define LUT_DUMMY			0x0C
> +#define LUT_DUMMY_RWDS_SDR		0x0D
> +#define LUT_JMP_ON_CS			0x1F
> +#define LUT_CMD_DDR			0x21
> +#define LUT_ADDR_DDR			0x22
> +#define LUT_CADDR_DDR			0x23
> +#define LUT_MODE_DDR			0x24
> +#define LUT_MODE2_DDR			0x25
> +#define LUT_MODE4_DDR			0x26
> +#define LUT_MODE8_DDR			0x27
> +#define LUT_WRITE_DDR			0x28
> +#define LUT_READ_DDR			0x29
> +#define LUT_LEARN_DDR			0x2A
> +#define LUT_DATSZ_DDR			0x2B
> +#define LUT_DUMMY_DDR			0x2C
> +#define LUT_DUMMY_RWDS_DDR		0x2D

Do we really need all those macros for registers and modes, that aren't 
even used in the driver? I don't know what the common practice is, but 
to me it seems like removing all the unused macros would make the driver 
much smaller and more readable.

> +
> +/*
> + * Calculate number of required PAD bits for LUT register.
> + *
> + * The pad stands for the number of IO lines [0:7].
> + * For example, the octal read needs eight IO lines,
> + * so you should use LUT_PAD(8). This macro
> + * returns 3 i.e. use eight (2^3) IP lines for read.
> + */
> +#define LUT_PAD(x) (fls(x) - 1)
> +
> +/*
> + * Macro for constructing the LUT entries with the following
> + * register layout:
> + *
> + *  ---------------------------------------------------
> + *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
> + *  ---------------------------------------------------
> + */
> +#define PAD_SHIFT		8
> +#define INSTR_SHIFT		10
> +#define OPRND_SHIFT		16
> +
> +/* Macros for constructing the LUT register. */
> +#define LUT_DEF(idx, ins, pad, opr)			  \
> +	((((ins) << INSTR_SHIFT) | ((pad) << PAD_SHIFT) | \
> +	(opr)) << (((idx) % 2) * OPRND_SHIFT))
> +
> +/* Oprands for the LUT register. */
> +#define ADDR24BIT		0x18
> +#define ADDR32BIT		0x20
> +
> +enum nxp_fspi_devtype {
> +	NXP_FSPI_LX2160A,
> +};
> +
> +struct nxp_fspi_devtype_data {
> +	enum nxp_fspi_devtype devtype;
> +	unsigned int rxfifo;
> +	unsigned int txfifo;
> +	unsigned int ahb_buf_size;
> +	unsigned int quirks;
> +};
> +
> +static const struct nxp_fspi_devtype_data lx2160a_data = {
> +	.devtype = NXP_FSPI_LX2160A,
> +	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
> +	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
> +	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
> +	.quirks = 0,
> +};
> +
> +#define NXP_FSPI_MAX_CHIPSELECT		4
> +
> +struct nxp_fspi {
> +	void __iomem *iobase;
> +	void __iomem *ahb_addr;
> +	u32 memmap_phy;
> +	u32 memmap_phy_size;
> +	u32 memmap_offs;
> +	u32 memmap_len;
> +	struct clk *clk, *clk_en;
> +	struct device *dev;
> +	struct completion c;
> +	const struct nxp_fspi_devtype_data *devtype_data;
> +	struct mutex lock;
> +	struct pm_qos_request pm_qos_req;
> +	int selected;
> +	void (*write)(u32 val, void __iomem *addr);
> +	u32 (*read)(void __iomem *addr);
> +};
> +
> +static void fspi_writel_be(u32 val, void __iomem *addr)
> +{
> +	iowrite32be(val, addr);
> +}
> +
> +static void fspi_writel(u32 val, void __iomem *addr)
> +{
> +	iowrite32(val, addr);
> +}
> +
> +static u32 fspi_readl_be(void __iomem *addr)
> +{
> +	return ioread32be(addr);
> +}
> +
> +static u32 fspi_readl(void __iomem *addr)
> +{
> +	return ioread32(addr);
> +}
> +
> +static irqreturn_t nxp_fspi_irq_handler(int irq, void *dev_id)
> +{
> +	struct nxp_fspi *f = dev_id;
> +	u32 reg;
> +
> +	/* clear interrupt */
> +	reg = f->read(f->iobase + FSPI_INTR);
> +	f->write(FSPI_INTR_IPCMDDONE_MASK, f->iobase + FSPI_INTR);
> +
> +	if (reg & FSPI_INTR_IPCMDDONE_MASK)
> +		complete(&f->c);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int nxp_fspi_check_buswidth(struct nxp_fspi *f, u8 width)
> +{
> +	switch (width) {
> +	case 1:
> +	case 2:
> +	case 4:
> +	case 8:
> +		return 0;
> +	}
> +
> +	return -ENOTSUPP;
> +}
> +
> +static bool nxp_fspi_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> +	int ret;
> +
> +	ret = nxp_fspi_check_buswidth(f, op->cmd.buswidth);
> +
> +	if (op->addr.nbytes)
> +		ret |= nxp_fspi_check_buswidth(f, op->addr.buswidth);
> +
> +	if (op->dummy.nbytes)
> +		ret |= nxp_fspi_check_buswidth(f, op->dummy.buswidth);
> +
> +	if (op->data.nbytes)
> +		ret |= nxp_fspi_check_buswidth(f, op->data.buswidth);
> +
> +	if (ret)
> +		return false;
> +
> +	/*
> +	 * The number of instructions needed for the op, needs
> +	 * to fit into a single LUT entry.
> +	 */
> +	if (op->addr.nbytes +
> +	   (op->dummy.nbytes ? 1:0) +
> +	   (op->data.nbytes ? 1:0) > 6)
> +		return false;
> +
> +	/* Max 64 dummy clock cycles supported */
> +	if (op->dummy.buswidth &&
> +	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
> +		return false;
> +
> +	/* Max data length, check controller limits and alignment */
> +	if (op->data.dir == SPI_MEM_DATA_IN &&
> +	    (op->data.nbytes > f->devtype_data->ahb_buf_size ||
> +	     (op->data.nbytes > f->devtype_data->rxfifo - 4 &&
> +	      !IS_ALIGNED(op->data.nbytes, 8))))
> +		return false;
> +
> +	if (op->data.dir == SPI_MEM_DATA_OUT &&
> +	    op->data.nbytes > f->devtype_data->txfifo)
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * If the slave device content being changed by Write/Erase, need to
> + * invalidate the AHB buffer. This can be achieved by doing reset of the
> + * controller using setting SWRESET bit for MCR0 register.
> + */
> +static inline void nxp_fspi_invalid(struct nxp_fspi *f)
> +{
> +	u32 reg;
> +
> +	reg = f->read(f->iobase + FSPI_MCR0);
> +	f->write(reg | FSPI_MCR0_SWRST_MASK, f->iobase + FSPI_MCR0);
> +
> +	while (f->read(f->iobase + FSPI_MCR0) & FSPI_MCR0_SWRST_MASK)
> +		;
> +}
> +
> +static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
> +				 const struct spi_mem_op *op)
> +{
> +	void __iomem *base = f->iobase;
> +	u32 lutval[4] = {};
> +	int lutidx = 1, i;
> +
> +	/* cmd */
> +	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
> +			     op->cmd.opcode);
> +
> +	/* addr bus width */
> +	if (op->addr.nbytes) {
> +		u32 addrlen = (op->addr.nbytes == 3) ? ADDR24BIT : ADDR32BIT;

You are only considering 3 and 4 byte long addresses, which is fine for 
NOR chips, but the SPI mem interface allows to connect other chips like 
SPI NAND which also use 1 byte addresses.

In the QSPI driver Boris worked around this restriction by using 
LUT_MODE instead of LUT_ADDRESS.

Does this restriction also exist for FSPI?

> +
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
> +					      LUT_PAD(op->addr.buswidth),
> +					      addrlen);
> +		lutidx++;
> +	}
> +
> +	/* dummy bytes, if needed */
> +	if (op->dummy.nbytes) {
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
> +					      LUT_PAD(op->dummy.buswidth),
> +					      op->dummy.nbytes * 8 /
> +					      op->dummy.buswidth);
> +		lutidx++;
> +	}
> +
> +	/* read/write data bytes */
> +	if (op->data.nbytes) {
> +		lutval[lutidx / 2] |= LUT_DEF(lutidx,
> +					      op->data.dir == SPI_MEM_DATA_IN ?
> +					      LUT_NXP_READ : LUT_NXP_WRITE,
> +					      LUT_PAD(op->data.buswidth),
> +					      0);
> +		lutidx++;
> +	}
> +
> +	/* stop condition. */
> +	lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_STOP, 0, 0);
> +
> +	/* unlock LUT */
> +	f->write(FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
> +	f->write(FSPI_LCKER_UNLOCK, f->iobase + FSPI_LCKCR);
> +
> +	/* fill LUT */
> +	for (i = 0; i < ARRAY_SIZE(lutval); i++)
> +		f->write(lutval[i], base + FSPI_LUT_REG(i));
> +
> +	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x]\n",
> +		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3]);
> +
> +	/* lock LUT */
> +	f->write(FSPI_LUTKEY_VALUE, f->iobase + FSPI_LUTKEY);
> +	f->write(FSPI_LCKER_LOCK, f->iobase + FSPI_LCKCR);
> +}
> +
> +static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(f->clk_en);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(f->clk);
> +	if (ret) {
> +		clk_disable_unprepare(f->clk_en);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
> +{
> +	clk_disable_unprepare(f->clk);
> +	clk_disable_unprepare(f->clk_en);
> +}
> +
> +/*
> + * In FlexSPI controller, flash access is based on value of FSPI_FLSHXXCR0
> + * register and start base address of the slave device.
> + *
> + *							    (Higher address)
> + *				--------    <-- FLSHB2CR0
> + *				|  B2  |
> + *				|      |
> + *	B2 start address -->	--------    <-- FLSHB1CR0
> + *				|  B1  |
> + *				|      |
> + *	B1 start address -->	--------    <-- FLSHA2CR0
> + *				|  A2  |
> + *				|      |
> + *	A2 start address -->	--------    <-- FLSHA1CR0
> + *				|  A1  |
> + *				|      |
> + *	A1 start address -->	--------		    (Lower address)
> + *
> + *
> + * Start base address defines the starting address range for given CS and
> + * FSPI_FLSHXXCR0 defines the size of the slave device connected at given CS.
> + *
> + * But, different targets are having different combinations of number of CS,
> + * some targets only have single CS or two CS covering controller's full
> + * memory mapped space area.
> + * Thus, implementation is being done as independent of the size and number
> + * of the connected slave device.
> + * Assign controller memory mapped space size as the size to the connected
> + * slave device.
> + * Mark FLSHxxCR0 as zero initially and then assign value only to the selected
> + * chip-select Flash configuration register.
> + *
> + * For e.g. to access CS2 (B1), FLSHB1CR0 register would be equal to the
> + * memory mapped size of the controller.
> + * Value for rest of the CS FLSHxxCR0 register would be zero.
> + *
> + */
> +static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi)
> +{
> +	unsigned long rate = spi->max_speed_hz;
> +	int ret;
> +	uint64_t size_kb;
> +
> +	/*
> +	 * Return, if previously selected slave device is same as current
> +	 * requested slave device.
> +	 */
> +	if (f->selected == spi->chip_select)
> +		return;
> +
> +	/* Reset FLSHxxCR0 registers */
> +	f->write(0, f->iobase + FSPI_FLSHA1CR0);
> +	f->write(0, f->iobase + FSPI_FLSHA2CR0);
> +	f->write(0, f->iobase + FSPI_FLSHB1CR0);
> +	f->write(0, f->iobase + FSPI_FLSHB1CR0);
> +
> +	/* Assign controller memory mapped space, as size of the flash. */
> +	size_kb = f->memmap_phy_size >> FSPI_FLSHXCR0_SZ_SHIFT;
> +
> +	switch (spi->chip_select) {
> +	case 0:
> +		f->write(size_kb, f->iobase + FSPI_FLSHA1CR0);
> +		break;
> +	case 1:
> +		f->write(size_kb, f->iobase + FSPI_FLSHA2CR0);
> +		break;
> +	case 2:
> +		f->write(size_kb, f->iobase + FSPI_FLSHB1CR0);
> +		break;
> +	case 3:
> +		f->write(size_kb, f->iobase + FSPI_FLSHB2CR0);
> +		break;
> +	default:
> +		dev_err(f->dev, "In-correct CS provided\n");
> +		return;
> +	}
> +
> +	dev_dbg(f->dev, "Slave device [CS:%x] selected\n", spi->chip_select);
> +
> +	nxp_fspi_clk_disable_unprep(f);
> +
> +	ret = clk_set_rate(f->clk, rate);
> +	if (ret)
> +		return;
> +
> +	ret = nxp_fspi_clk_prep_enable(f);
> +	if (ret)
> +		return;
> +	f->selected = spi->chip_select;
> +}
> +
> +#define FSPI_MIN_IOMAP SZ_4M
> +
> +static void nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
> +{
> +	u32 len = op->data.nbytes;
> +
> +	/* if necessary, ioremap buffer before AHB read. */
> +	if (!f->ahb_addr) {
> +		f->memmap_offs = op->addr.val;
> +		f->memmap_len = len > FSPI_MIN_IOMAP ? len : FSPI_MIN_IOMAP;
> +		f->ahb_addr = ioremap_nocache(f->memmap_phy + f->memmap_offs,
> +					      f->memmap_len);
> +		if (!f->ahb_addr) {
> +			dev_err(f->dev, "ioremap failed\n");
> +			return;
> +		}
> +	} else if ((op->addr.val < f->memmap_offs) ||
> +		   (op->addr.val + len > f->memmap_offs + f->memmap_len)) {
> +
> +		iounmap(f->ahb_addr);
> +
> +		f->memmap_offs = op->addr.val;
> +		f->memmap_len = len > FSPI_MIN_IOMAP ? len : FSPI_MIN_IOMAP;
> +		f->ahb_addr = ioremap_nocache(f->memmap_phy + f->memmap_offs,
> +					      f->memmap_len);
> +		if (!f->ahb_addr) {
> +			dev_err(f->dev, "ioremap failed\n");
> +			return;
> +		}
> +	}

You are using the remapping procedure as in the QSPI NOR driver. The 
original purpose was to start with a rather small mapping size and 
increase it when a larger memory device is used.

At the same time you use the logic from the QSPI SPI mem driver, that 
adjusts the data.nbytes of each read op to a maximum of ahb_buf_size in 
nxp_fspi_adjust_op_size().
This is the logic that Boris introduced for the QSPI driver until we 
replace it with something like dirmap.

Unless there is something I missed, this means the ramapping is useless 
and it's enough to reserve memory with the fixed size of ahb_buf_size.

Regards,
Frieder

> +
> +	/* Read out the data directly from the AHB buffer. */
> +	memcpy_fromio(op->data.buf.in, (f->ahb_addr +
> +		      op->addr.val - f->memmap_offs), len);
> +}
> +
> +static void nxp_fspi_fill_txfifo(struct nxp_fspi *f,
> +				 const struct spi_mem_op *op)
> +{
> +	void __iomem *base = f->iobase;
> +	int i, j;
> +	int size, tmp_size;
> +	u32 data = 0;
> +	u32 *txbuf = (u32 *) op->data.buf.out;
> +
> +	/* clear the TX FIFO. */
> +	f->write(FSPI_IPTXFCR_CLR_MASK, base + FSPI_IPTXFCR);
> +
> +	size = op->data.nbytes / 8;
> +	for (i = 0; i < size; i++) {
> +		/* Wait for TXFIFO empty */
> +		while (!(f->read(base + FSPI_INTR) & FSPI_INTR_IPTXWE_MASK))
> +			;
> +
> +		j = 0;
> +		tmp_size = 8;
> +		while (tmp_size > 0) {
> +			data = 0;
> +			memcpy(&data, txbuf, 4);
> +			f->write(data, base + FSPI_TFDR + j * 4);
> +			tmp_size -= 4;
> +			j++;
> +			txbuf += 1;
> +		}
> +		f->write(FSPI_INTR_IPTXWE_MASK, base + FSPI_INTR);
> +	}
> +
> +	size = op->data.nbytes % 8;
> +	if (size) {
> +		/* Wait for TXFIFO empty */
> +		while (!(f->read(base + FSPI_INTR) & FSPI_INTR_IPTXWE_MASK))
> +			;
> +		j = 0;
> +		tmp_size = 0;
> +		while (size > 0) {
> +			data = 0;
> +			tmp_size = (size < 4) ? size : 4;
> +			memcpy(&data, txbuf, tmp_size);
> +			f->write(data, base + FSPI_TFDR + j * 4);
> +			size -= tmp_size;
> +			j++;
> +			txbuf += 1;
> +		}
> +		f->write(FSPI_INTR_IPTXWE_MASK, base + FSPI_INTR);
> +	}
> +}
> +
> +static void nxp_fspi_read_rxfifo(struct nxp_fspi *f,
> +			  const struct spi_mem_op *op)
> +{
> +	void __iomem *base = f->iobase;
> +	int i, j;
> +	int size, tmp_size;
> +	u32 tmp = 0;
> +	u8 *buf = op->data.buf.in;
> +	u32 len = op->data.nbytes;
> +
> +	while (len > 0) {
> +		size = len / 8;
> +
> +		for (i = 0; i < size; i++) {
> +			/* Wait for RXFIFO available */
> +			while (!(f->read(base + FSPI_INTR)
> +					 & FSPI_INTR_IPRXWA_MASK))
> +				;
> +
> +			j = 0;
> +			tmp_size = 8;
> +			while (tmp_size > 0) {
> +				tmp = 0;
> +				tmp = f->read(base + FSPI_RFDR + j * 4);
> +				memcpy(buf, &tmp, 4);
> +				tmp_size -= 4;
> +				j++;
> +				buf += 4;
> +			}
> +			/* move the FIFO pointer */
> +			f->write(FSPI_INTR_IPRXWA_MASK, base + FSPI_INTR);
> +			len -= 8;
> +		}
> +
> +		size = len % 8;
> +
> +		j = 0;
> +		if (size) {
> +			/* Wait for RXFIFO available */
> +			while (!(f->read(base + FSPI_INTR)
> +					 & FSPI_INTR_IPRXWA_MASK))
> +				;
> +
> +			while (len > 0) {
> +				tmp = 0;
> +				size = (len < 4) ? len : 4;
> +				tmp = f->read(base + FSPI_RFDR + j * 4);
> +				memcpy(buf, &tmp, size);
> +				len -= size;
> +				j++;
> +				buf += size;
> +			}
> +		}
> +
> +		/* invalid the RXFIFO */
> +		f->write(FSPI_IPRXFCR_CLR_MASK, base + FSPI_IPRXFCR);
> +		/* move the FIFO pointer */
> +		f->write(FSPI_INTR_IPRXWA_MASK, base + FSPI_INTR);
> +	}
> +}
> +
> +static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
> +{
> +	void __iomem *base = f->iobase;
> +	int seqnum = 0;
> +	int err = 0;
> +	u32 reg;
> +
> +	reg = f->read(base + FSPI_IPRXFCR);
> +	/* invalid RXFIFO first */
> +	reg &= ~FSPI_IPRXFCR_DMA_EN_MASK;
> +	reg = reg | FSPI_IPRXFCR_CLR_MASK;
> +	f->write(reg, base + FSPI_IPRXFCR);
> +
> +	init_completion(&f->c);
> +
> +	f->write(op->addr.val, base + FSPI_IPCR0);
> +	/*
> +	 * Always start the sequence at the same index since we update
> +	 * the LUT at each exec_op() call. And also specify the DATA
> +	 * length, since it's has not been specified in the LUT.
> +	 */
> +	f->write(op->data.nbytes |
> +		 (SEQID_LUT << FSPI_IPCR1_SEQID_SHIFT) |
> +		 (seqnum << FSPI_IPCR1_SEQNUM_SHIFT),
> +		 base + FSPI_IPCR1);
> +
> +	/* trigger the LUT now */
> +	f->write(FSPI_IPCMD_TRG_MASK, base + FSPI_IPCMD);
> +
> +	/* Wait for the interrupt. */
> +	if (!wait_for_completion_timeout(&f->c, msecs_to_jiffies(1000)))
> +		err = -ETIMEDOUT;
> +
> +	if (!err && op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
> +		nxp_fspi_read_rxfifo(f, op);
> +
> +	return err;
> +}
> +
> +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> +	void __iomem *base = f->iobase;
> +	int err = 0;
> +	unsigned int timeout = 1000;
> +
> +	mutex_lock(&f->lock);
> +
> +	/* wait for the controller being ready */
> +	do {
> +		u32 status;
> +
> +		status = f->read(base + FSPI_STS0);
> +		if ((status & FSPI_STS0_ARB_IDLE_MASK) &&
> +		    (status & FSPI_STS0_SEQ_IDLE_MASK))
> +			break;
> +		udelay(1);
> +		dev_dbg(f->dev, "The controller is busy, 0x%x\n", status);
> +	} while (--timeout);
> +
> +	nxp_fspi_select_mem(f, mem->spi);
> +
> +	nxp_fspi_prepare_lut(f, op);
> +	/*
> +	 * If we have large chunks of data, we read them through the AHB bus
> +	 * by accessing the mapped memory. In all other cases we use
> +	 * IP commands to access the flash.
> +	 */
> +	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
> +	    op->data.dir == SPI_MEM_DATA_IN) {
> +		nxp_fspi_read_ahb(f, op);
> +	} else {
> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> +			nxp_fspi_fill_txfifo(f, op);
> +
> +		err = nxp_fspi_do_op(f, op);
> +
> +		/* Invalidate the data in the AHB buffer. */
> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> +			nxp_fspi_invalid(f);
> +	}
> +
> +	mutex_unlock(&f->lock);
> +
> +	return err;
> +}
> +
> +static int nxp_fspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> +
> +	if (op->data.dir == SPI_MEM_DATA_OUT) {
> +		if (op->data.nbytes > f->devtype_data->txfifo)
> +			op->data.nbytes = f->devtype_data->txfifo;
> +	} else {
> +		if (op->data.nbytes > f->devtype_data->ahb_buf_size)
> +			op->data.nbytes = f->devtype_data->ahb_buf_size;
> +		else if (op->data.nbytes > (f->devtype_data->rxfifo - 4))
> +			op->data.nbytes = ALIGN_DOWN(op->data.nbytes, 8);
> +	}
> +
> +	return 0;
> +}
> +
> +static int nxp_fspi_default_setup(struct nxp_fspi *f)
> +{
> +	void __iomem *base = f->iobase;
> +	int ret, i;
> +	u32 reg;
> +
> +	/* disable and unprepare clock to avoid glitch pass to controller */
> +	nxp_fspi_clk_disable_unprep(f);
> +
> +	/* the default frequency, we will change it later if necessary. */
> +	ret = clk_set_rate(f->clk, 20000000);
> +	if (ret)
> +		return ret;
> +
> +	ret = nxp_fspi_clk_prep_enable(f);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset the module */
> +	f->write(FSPI_MCR0_SWRST_MASK, base + FSPI_MCR0);
> +	do {
> +		udelay(1);
> +	} while (f->read(f->iobase + FSPI_MCR0) & FSPI_MCR0_SWRST_MASK);
> +
> +	/* Disable the module */
> +	f->write(FSPI_MCR0_MDIS_MASK, base + FSPI_MCR0);
> +
> +	/* Reset the DLL register to default value */
> +	f->write(FSPI_DLLACR_OVRDEN_MASK, base + FSPI_DLLACR);
> +	f->write(FSPI_DLLBCR_OVRDEN_MASK, base + FSPI_DLLBCR);
> +
> +	/* enable module */
> +	f->write(FSPI_MCR0_AHB_TIMEOUT_MASK | FSPI_MCR0_IP_TIMEOUT_MASK,
> +		 base + FSPI_MCR0);
> +
> +	/*
> +	 * Disable same device enable bit and configure all slave devices
> +	 * independently.
> +	 */
> +	reg = f->read(f->iobase + FSPI_MCR2);
> +	reg = reg & ~(1 << (FSPI_MCR2_SAMEDEVICEEN_SHIFT));
> +	f->write(reg, base + FSPI_MCR2);
> +
> +	/* AHB configuration for access buffer 0~7. */
> +	for (i = 0; i < 7; i++)
> +		f->write(0, base + FSPI_AHBRX_BUF0CR0 + 4 * i);
> +
> +	/*
> +	 * Set ADATSZ with the maximum AHB buffer size to improve the read
> +	 * performance.
> +	 */
> +	f->write((f->devtype_data->ahb_buf_size / 8 |
> +		  FSPI_AHBRXBUF0CR7_PREF_MASK), base + FSPI_AHBRX_BUF7CR0);
> +
> +	/* prefetch and no start address alignment limitation */
> +	f->write(FSPI_AHBCR_PREF_EN_MASK | FSPI_AHBCR_RDADDROPT_MASK,
> +		 base + FSPI_AHBCR);
> +
> +	/* Set lut sequence ID for AHB Read. */
> +	f->write(SEQID_LUT, base + FSPI_FLSHA1CR2);
> +
> +	f->selected = -1;
> +
> +	/* enable the interrupt */
> +	f->write(FSPI_INTEN_IPCMDDONE_MASK, base + FSPI_INTEN);
> +
> +	return 0;
> +}
> +
> +static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
> +	.adjust_op_size = nxp_fspi_adjust_op_size,
> +	.supports_op = nxp_fspi_supports_op,
> +	.exec_op = nxp_fspi_exec_op,
> +};
> +
> +static int nxp_fspi_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource *res;
> +	struct nxp_fspi *f;
> +	int ret;
> +
> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*f));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
> +			  SPI_TX_DUAL | SPI_TX_QUAD;
> +
> +	f = spi_controller_get_devdata(ctlr);
> +	f->dev = dev;
> +	f->devtype_data = of_device_get_match_data(dev);
> +	if (!f->devtype_data) {
> +		ret = -ENODEV;
> +		goto err_put_ctrl;
> +	}
> +
> +	platform_set_drvdata(pdev, f);
> +
> +	/* find the resources - configuration register address space */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
> +	f->iobase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(f->iobase)) {
> +		ret = PTR_ERR(f->iobase);
> +		goto err_put_ctrl;
> +	}
> +
> +	/*
> +	 * R/W functions for big- or little-endian registers:
> +	 * The FSPI controller's endianness is independent of
> +	 * the CPU core's endianness. So far, although the CPU
> +	 * core is little-endian the FSPI controller can use
> +	 * big-endian or little-endian.
> +	 */
> +	if (of_property_read_bool(np, "big-endian")) {
> +		f->write = fspi_writel_be;
> +		f->read = fspi_readl_be;
> +	} else {
> +		f->write = fspi_writel;
> +		f->read = fspi_readl;
> +	}
> +
> +	/* find the resources - controller memory mapped space */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
> +
> +	if (!devm_request_mem_region(dev, res->start, resource_size(res),
> +				     res->name)) {
> +		dev_err(dev, "can't request region for resource %pR\n", res);
> +		ret = -EBUSY;
> +		goto err_put_ctrl;
> +	}
> +
> +	/* assign memory mapped starting address and mapped size. */
> +	f->memmap_phy = res->start;
> +	f->memmap_phy_size = resource_size(res);
> +
> +	/* find the clocks */
> +	f->clk_en = devm_clk_get(dev, "fspi_en");
> +	if (IS_ERR(f->clk_en)) {
> +		ret = PTR_ERR(f->clk_en);
> +		goto err_put_ctrl;
> +	}
> +
> +	f->clk = devm_clk_get(dev, "fspi");
> +	if (IS_ERR(f->clk)) {
> +		ret = PTR_ERR(f->clk);
> +		goto err_put_ctrl;
> +	}
> +
> +	ret = nxp_fspi_clk_prep_enable(f);
> +	if (ret) {
> +		dev_err(dev, "can not enable the clock\n");
> +		goto err_put_ctrl;
> +	}
> +
> +	/* find the irq */
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get the irq: %d\n", ret);
> +		goto err_disable_clk;
> +	}
> +
> +	ret = devm_request_irq(dev, ret,
> +			nxp_fspi_irq_handler, 0, pdev->name, f);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq: %d\n", ret);
> +		goto err_disable_clk;
> +	}
> +
> +	mutex_init(&f->lock);
> +
> +	ctlr->bus_num = -1;
> +	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
> +	ctlr->mem_ops = &nxp_fspi_mem_ops;
> +
> +	nxp_fspi_default_setup(f);
> +
> +	ctlr->dev.of_node = np;
> +
> +	ret = spi_register_controller(ctlr);
> +	if (ret)
> +		goto err_destroy_mutex;
> +
> +	return 0;
> +
> +err_destroy_mutex:
> +	mutex_destroy(&f->lock);
> +
> +err_disable_clk:
> +	nxp_fspi_clk_disable_unprep(f);
> +
> +err_put_ctrl:
> +	spi_controller_put(ctlr);
> +
> +	dev_err(dev, "NXP FSPI probe failed\n");
> +	return ret;
> +}
> +
> +static int nxp_fspi_remove(struct platform_device *pdev)
> +{
> +	struct nxp_fspi *f = platform_get_drvdata(pdev);
> +
> +	/* disable the hardware */
> +	f->write(FSPI_MCR0_MDIS_MASK, f->iobase + FSPI_MCR0);
> +
> +	nxp_fspi_clk_disable_unprep(f);
> +
> +	mutex_destroy(&f->lock);
> +
> +	if (f->ahb_addr)
> +		iounmap(f->ahb_addr);
> +
> +	return 0;
> +}
> +
> +static int nxp_fspi_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int nxp_fspi_resume(struct device *dev)
> +{
> +	struct nxp_fspi *f = dev_get_drvdata(dev);
> +
> +	nxp_fspi_default_setup(f);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id nxp_fspi_dt_ids[] = {
> +	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
> +
> +static const struct dev_pm_ops nxp_fspi_pm_ops = {
> +	.suspend	= nxp_fspi_suspend,
> +	.resume		= nxp_fspi_resume,
> +};
> +
> +static struct platform_driver nxp_fspi_driver = {
> +	.driver = {
> +		.name	= "nxp-fspi",
> +		.of_match_table = nxp_fspi_dt_ids,
> +		.pm =   &nxp_fspi_pm_ops,
> +	},
> +	.probe          = nxp_fspi_probe,
> +	.remove		= nxp_fspi_remove,
> +};
> +module_platform_driver(nxp_fspi_driver);
> +
> +MODULE_DESCRIPTION("NXP FSPI Controller Driver");
> +MODULE_AUTHOR("NXP Semiconductors");
> +MODULE_LICENSE("GPL v2");
> 
