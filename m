Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C3C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6B720846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6B720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeGZLFw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:05:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:14713 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbeGZLFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:05:52 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Jul 2018 18:49:45 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 07B6260034;
        Thu, 26 Jul 2018 18:49:46 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 26 Jul 2018 18:49:46 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id C54884048F;
        Thu, 26 Jul 2018 18:49:45 +0900 (JST)
Received: from DESKTOP0FARE34 (unknown [10.213.134.218])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 8EF0D120424;
        Thu, 26 Jul 2018 18:49:45 +0900 (JST)
From:   "Keiji Hayashibara" <hayashibara.keiji@socionext.com>
To:     "'Masahiro Yamada'" <yamada.masahiro@socionext.com>
Cc:     "Mark Brown" <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, <linux-spi@vger.kernel.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "DTML" <devicetree@vger.kernel.org>,
        "Masami Hiramatsu" <masami.hiramatsu@linaro.org>,
        "Jassi Brar" <jaswinder.singh@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Hayashi=2C_Kunihiko/=E6=9E=97_=E9=82=A6=E5=BD=A6?= 
        <hayashi.kunihiko@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com> <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com> <CAK7LNAS+T17JPb72b2aaE_g0D8kTqUZngcn-0yxyHcP8NusGYg@mail.gmail.com>
In-Reply-To: <CAK7LNAS+T17JPb72b2aaE_g0D8kTqUZngcn-0yxyHcP8NusGYg@mail.gmail.com>
Subject: RE: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
Date:   Thu, 26 Jul 2018 18:49:42 +0900
Message-ID: <001c01d424c5$fa4a7d50$eedf77f0$@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUJK+Lb4PtBS+ckEWxak8O5zFtw6SgoWuAgACeCjA=
Content-Language: ja
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yamada-san,


> From: Masahiro Yamada [mailto:yamada.masahiro@socionext.com]
> Sent: Thursday, July 26, 2018 6:13 PM
> To: Hayashibara, Keiji/林原 啓二 <hayashibara.keiji@socionext.com>
> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
> 
> Hi.
> 
> 
> 2018-07-26 16:09 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> > Add SPI controller driver implemented in Socionext UniPhier SoCs.
> >
> > UniPhier SoCs have two types SPI controllers; SCSSI supports a single
> > channel, and MCSSI supports multiple channels.
> > This driver supports SCSSI only.
> >
> > This controller has 32bit TX/RX FIFO with depth of eight entry, and
> > supports the SPI master mode only.
> >
> > This commit is implemented in PIO transfer mode, not DMA transfer.
> >
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> > ---
> >  drivers/spi/Kconfig        |  13 ++
> >  drivers/spi/Makefile       |   1 +
> >  drivers/spi/spi-uniphier.c | 539
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 553 insertions(+)
> >  create mode 100644 drivers/spi/spi-uniphier.c
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index
> > ad5d68e..671d078 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -688,6 +688,19 @@ config SPI_TXX9
> >         help
> >           SPI driver for Toshiba TXx9 MIPS SoCs
> >
> > +config SPI_UNIPHIER
> > +       tristate "Socionext UniPhier SPI Controller"
> > +       depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
> > +       help
> > +         This enables a driver for the Socionext UniPhier SoC SCSSI SPI controller.
> > +
> > +         UniPhier SoCs have SCSSI and MCSSI SPI controllers.
> > +         Every UniPhier SoC has SCSSI which supports single channel.
> > +         Older UniPhier Pro4/Pro5 also has MCSSI which support multiple channels.
> > +         This driver supports SCSSI only.
> > +
> > +         If your SoC supports SCSSI, say Y here.
> > +
> >  config SPI_XCOMM
> >         tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
> >         depends on I2C
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile index
> > cb1f437..a90d559 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -101,6 +101,7 @@ spi-thunderx-objs                   := spi-cavium.o spi-cavium-thunderx.o
> >  obj-$(CONFIG_SPI_THUNDERX)             += spi-thunderx.o
> >  obj-$(CONFIG_SPI_TOPCLIFF_PCH)         += spi-topcliff-pch.o
> >  obj-$(CONFIG_SPI_TXX9)                 += spi-txx9.o
> > +obj-$(CONFIG_SPI_UNIPHIER)             += spi-uniphier.o
> >  obj-$(CONFIG_SPI_XCOMM)                += spi-xcomm.o
> >  obj-$(CONFIG_SPI_XILINX)               += spi-xilinx.o
> >  obj-$(CONFIG_SPI_XLP)                  += spi-xlp.o
> > diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
> > new file mode 100644 index 0000000..2e80bb0
> > --- /dev/null
> > +++ b/drivers/spi/spi-uniphier.c
> > @@ -0,0 +1,539 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// spi-uniphier.c - Socionext UniPhier SPI controller driver
> > +// Copyright 2012      Panasonic Corporation
> > +// Copyright 2016-2018 Socionext Inc.
> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/kernel.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define SSI_TIMEOUT            2000    /* ms */
> > +#define SSI_MAX_CLK_DIVIDER    254
> > +#define SSI_MIN_CLK_DIVIDER    4
> > +
> > +struct uniphier_spi_priv {
> > +       void __iomem *base;
> > +       int irq;
> 
> 
> irq is unnecessary because it is only used in probe().
> 
> Use a stack variable.

I see. I will modify it.

> 
> 
> > +       struct clk *clk;
> > +       struct spi_master *master;
> > +       struct completion xfer_done;
> > +
> > +       int error;
> > +       unsigned int tx_bytes;
> > +       unsigned int rx_bytes;
> > +       const u8 *tx_buf;
> > +       u8 *rx_buf;
> > +
> > +       bool is_save_param;
> > +       u8 bits_per_word;
> > +       u16 mode;
> > +       u32 speed_hz;
> > +};
> > +
> > +#define SSI_CTL                        0x0
> > +#define   SSI_CTL_EN           BIT(0)
> > +
> > +#define SSI_CKS                        0x4
> > +#define   SSI_CKS_CKRAT_MASK   GENMASK(7, 0)
> > +#define   SSI_CKS_CKPHS                BIT(14)
> > +#define   SSI_CKS_CKINIT       BIT(13)
> > +#define   SSI_CKS_CKDLY                BIT(12)
> > +
> > +#define SSI_TXWDS              0x8
> > +#define   SSI_TXWDS_WDLEN_MASK GENMASK(13, 8)
> > +#define   SSI_TXWDS_TDTF_MASK  GENMASK(7, 6)
> > +#define   SSI_TXWDS_DTLEN_MASK GENMASK(5, 0)
> > +
> > +#define SSI_RXWDS              0xc
> > +#define   SSI_RXWDS_DTLEN_MASK GENMASK(5, 0)
> > +
> > +#define SSI_FPS                        0x10
> > +#define   SSI_FPS_FSPOL                BIT(15)
> > +#define   SSI_FPS_FSTRT                BIT(14)
> > +
> > +#define SSI_SR                 0x14
> > +#define   SSI_SR_RNE           BIT(0)
> > +
> > +#define SSI_IE                 0x18
> > +#define   SSI_IE_RCIE          BIT(3)
> > +#define   SSI_IE_RORIE         BIT(0)
> > +
> > +#define SSI_IS                 0x1c
> > +#define   SSI_IS_RXRS          BIT(9)
> > +#define   SSI_IS_RCID          BIT(3)
> > +#define   SSI_IS_RORID         BIT(0)
> > +
> > +#define SSI_IC                 0x1c
> > +#define   SSI_IC_TCIC          BIT(4)
> > +#define   SSI_IC_RCIC          BIT(3)
> > +#define   SSI_IC_RORIC         BIT(0)
> > +
> > +#define SSI_FC                 0x20
> > +#define   SSI_FC_TXFFL         BIT(12)
> > +#define   SSI_FC_TXFTH_MASK    GENMASK(11, 8)
> > +#define   SSI_FC_RXFFL         BIT(4)
> > +#define   SSI_FC_RXFTH_MASK    GENMASK(3, 0)
> > +
> > +#define SSI_TXDR               0x24
> > +#define SSI_RXDR               0x24
> > +
> > +#define SSI_FIFO_DEPTH         8U
> > +
> > +static inline unsigned int bytes_per_word(unsigned int bits) {
> > +       return bits <= 8 ? 1 : (bits <= 16 ? 2 : 4); }
> > +
> > +static inline void uniphier_spi_irq_enable(struct spi_device *spi,
> > +u32 mask) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val;
> > +
> > +       val = readl(priv->base + SSI_IE);
> > +       val |= mask;
> > +       writel(val, priv->base + SSI_IE); }
> > +
> > +static inline void uniphier_spi_irq_disable(struct spi_device *spi,
> > +u32 mask) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val;
> > +
> > +       val = readl(priv->base + SSI_IE);
> > +       val &= ~mask;
> > +       writel(val, priv->base + SSI_IE); }
> > +
> > +static void uniphier_spi_set_mode(struct spi_device *spi) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val1, val2;
> > +
> > +       /*
> > +        * clock setting
> > +        * CKPHS    capture timing. 0:rising edge, 1:falling edge
> > +        * CKINIT   clock initial level. 0:low, 1:high
> > +        * CKDLY    clock delay. 0:no delay, 1:delay depending on FSTRT
> > +        *          (FSTRT=0: 1 clock, FSTRT=1: 0.5 clock)
> > +        *
> > +        * frame setting
> > +        * FSPOL    frame signal porarity. 0: low, 1: high
> > +        * FSTRT    start frame timing
> > +        *          0: rising edge of clock, 1: falling edge of clock
> > +        */
> > +       switch (spi->mode & (SPI_CPOL | SPI_CPHA)) {
> > +       case SPI_MODE_0:
> > +               /* CKPHS=1, CKINIT=0, CKDLY=1, FSTRT=0 */
> > +               val1 = SSI_CKS_CKPHS | SSI_CKS_CKDLY;
> > +               val2 = 0;
> > +               break;
> > +       case SPI_MODE_1:
> > +               /* CKPHS=0, CKINIT=0, CKDLY=0, FSTRT=1 */
> > +               val1 = 0;
> > +               val2 = SSI_FPS_FSTRT;
> > +               break;
> > +       case SPI_MODE_2:
> > +               /* CKPHS=0, CKINIT=1, CKDLY=1, FSTRT=1 */
> > +               val1 = SSI_CKS_CKINIT | SSI_CKS_CKDLY;
> > +               val2 = SSI_FPS_FSTRT;
> > +               break;
> > +       case SPI_MODE_3:
> > +               /* CKPHS=1, CKINIT=1, CKDLY=0, FSTRT=0 */
> > +               val1 = SSI_CKS_CKPHS | SSI_CKS_CKINIT;
> > +               val2 = 0;
> > +               break;
> > +       }
> > +
> > +       if (!(spi->mode & SPI_CS_HIGH))
> > +               val2 |= SSI_FPS_FSPOL;
> > +
> > +       writel(val1, priv->base + SSI_CKS);
> > +       writel(val2, priv->base + SSI_FPS);
> > +
> > +       val1 = 0;
> > +       if (spi->mode & SPI_LSB_FIRST)
> > +               val1 |= FIELD_PREP(SSI_TXWDS_TDTF_MASK, 1);
> > +       writel(val1, priv->base + SSI_TXWDS);
> > +       writel(val1, priv->base + SSI_RXWDS); }
> > +
> > +static void uniphier_spi_set_transfer_size(struct spi_device *spi,
> > +int size) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val;
> > +
> > +       val = readl(priv->base + SSI_TXWDS);
> > +       val &= ~(SSI_TXWDS_WDLEN_MASK | SSI_TXWDS_DTLEN_MASK);
> > +       val |= FIELD_PREP(SSI_TXWDS_WDLEN_MASK, size);
> > +       val |= FIELD_PREP(SSI_TXWDS_DTLEN_MASK, size);
> > +       writel(val, priv->base + SSI_TXWDS);
> > +
> > +       val = readl(priv->base + SSI_RXWDS);
> > +       val &= ~SSI_RXWDS_DTLEN_MASK;
> > +       val |= FIELD_PREP(SSI_RXWDS_DTLEN_MASK, size);
> > +       writel(val, priv->base + SSI_RXWDS); }
> > +
> > +static int uniphier_spi_set_baudrate(struct spi_device *spi, unsigned
> > +int speed) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val, ckrat;
> > +
> > +       /*
> > +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> > +        * round up as we look for equal or less speed
> > +        */
> > +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
> > +       ckrat = roundup(ckrat, 2);
> > +
> > +       /* check if requested speed is too small */
> > +       if (ckrat > SSI_MAX_CLK_DIVIDER)
> > +               return -EINVAL;
> > +
> > +       if (ckrat < SSI_MIN_CLK_DIVIDER)
> > +               ckrat = SSI_MIN_CLK_DIVIDER;
> > +
> > +       val = readl(priv->base + SSI_CKS);
> > +       val &= ~SSI_CKS_CKRAT_MASK;
> > +       val |= ckrat & SSI_CKS_CKRAT_MASK;
> > +       writel(val, priv->base + SSI_CKS);
> > +
> > +       return 0;
> > +}
> > +
> > +static int uniphier_spi_setup_transfer(struct spi_device *spi,
> > +                                      struct spi_transfer *t) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val;
> > +       int ret;
> > +
> > +       priv->error = 0;
> > +       priv->tx_buf = t->tx_buf;
> > +       priv->rx_buf = t->rx_buf;
> > +       priv->tx_bytes = priv->rx_bytes = t->len;
> > +
> > +       if (!priv->is_save_param || priv->mode != spi->mode) {
> > +               uniphier_spi_set_mode(spi);
> > +               priv->mode = spi->mode;
> > +       }
> > +
> > +       if (!priv->is_save_param || priv->bits_per_word != t->bits_per_word) {
> > +               uniphier_spi_set_transfer_size(spi, t->bits_per_word);
> > +               priv->bits_per_word = t->bits_per_word;
> > +       }
> > +
> > +       if (!priv->is_save_param || priv->speed_hz != t->speed_hz) {
> > +               ret = uniphier_spi_set_baudrate(spi, t->speed_hz);
> > +               if (ret)
> > +                       return ret;
> > +               priv->speed_hz = t->speed_hz;
> > +       }
> > +
> > +       if (!priv->is_save_param)
> > +               priv->is_save_param = true;
> > +
> > +       /* reset FIFOs */
> > +       val = SSI_FC_TXFFL | SSI_FC_RXFFL;
> > +       writel(val, priv->base + SSI_FC);
> > +
> > +       return 0;
> > +}
> > +
> > +static void uniphier_spi_send(struct uniphier_spi_priv *priv) {
> > +       int wsize;
> > +       u32 val = 0;
> > +
> > +       wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
> > +       priv->tx_bytes -= wsize;
> > +
> > +       if (priv->tx_buf) {
> > +               switch (wsize) {
> > +               case 1:
> > +                       val = *priv->tx_buf;
> > +                       break;
> > +               case 2:
> > +                       val = get_unaligned_le16(priv->tx_buf);
> > +                       break;
> > +               case 4:
> > +                       val = get_unaligned_le32(priv->tx_buf);
> > +                       break;
> > +               }
> > +
> > +               priv->tx_buf += wsize;
> > +       }
> > +
> > +       writel(val, priv->base + SSI_TXDR); }
> > +
> > +static void uniphier_spi_recv(struct uniphier_spi_priv *priv) {
> > +       int rsize;
> > +       u32 val;
> > +
> > +       rsize = min(bytes_per_word(priv->bits_per_word), priv->rx_bytes);
> > +       priv->rx_bytes -= rsize;
> > +
> > +       val = readl(priv->base + SSI_RXDR);
> > +
> > +       if (priv->rx_buf) {
> > +               switch (rsize) {
> > +               case 1:
> > +                       *priv->rx_buf = (u8)val;
> 
> Is this cast necessary?

I added it explicitly, but I will modify it.


> 
> > +                       break;
> > +               case 2:
> > +                       put_unaligned_le16(val, priv->rx_buf);
> > +                       break;
> > +               case 4:
> > +                       put_unaligned_le32(val, priv->rx_buf);
> > +                       break;
> > +               }
> > +
> > +               priv->rx_buf += rsize;
> > +       }
> > +}
> > +
> > +static void uniphier_spi_fill_tx_fifo(struct uniphier_spi_priv *priv)
> > +{
> > +       unsigned int tx_count;
> > +       u32 val;
> > +
> > +       tx_count = DIV_ROUND_UP(priv->tx_bytes,
> > +                               bytes_per_word(priv->bits_per_word));
> > +       tx_count = min(tx_count, SSI_FIFO_DEPTH);
> > +
> > +       /* set fifo threthold */
> 
> 
> Typo.  threshold

I will modify it.

> 
> 
> > +       val = readl(priv->base + SSI_FC);
> > +       val &= ~(SSI_FC_TXFTH_MASK | SSI_FC_RXFTH_MASK);
> > +       val |= FIELD_PREP(SSI_FC_TXFTH_MASK, tx_count);
> > +       val |= FIELD_PREP(SSI_FC_RXFTH_MASK, tx_count);
> > +       writel(val, priv->base + SSI_FC);
> > +
> > +       while (tx_count--)
> > +               uniphier_spi_send(priv); }
> > +
> > +static void uniphier_spi_set_cs(struct spi_device *spi, bool enable)
> > +{
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val;
> > +
> > +       val = readl(priv->base + SSI_FPS);
> > +
> > +       if (enable)
> > +               val |= SSI_FPS_FSPOL;
> > +       else
> > +               val &= ~SSI_FPS_FSPOL;
> > +
> > +       writel(val, priv->base + SSI_FPS); }
> > +
> > +static int uniphier_spi_transfer_one(struct spi_master *master,
> > +                                    struct spi_device *spi,
> > +                                    struct spi_transfer *t) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
> > +       int status;
> > +
> > +       status = uniphier_spi_setup_transfer(spi, t);
> > +       if (status < 0)
> > +               return status;
> > +
> > +       reinit_completion(&priv->xfer_done);
> > +
> > +       uniphier_spi_fill_tx_fifo(priv);
> > +
> > +       uniphier_spi_irq_enable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
> > +
> > +       status = wait_for_completion_timeout(&priv->xfer_done,
> > +
> > + msecs_to_jiffies(SSI_TIMEOUT));
> > +
> > +       uniphier_spi_irq_disable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
> > +
> > +       if (status < 0)
> > +               return status;
> > +
> > +       return priv->error;
> > +}
> > +
> > +static int uniphier_spi_prepare_transfer_hardware(struct spi_master
> > +*master) {
> > +       struct uniphier_spi_priv *priv =
> > +spi_master_get_devdata(master);
> > +
> > +       writel(SSI_CTL_EN, priv->base + SSI_CTL);
> > +
> > +       return 0;
> > +}
> > +
> > +static int uniphier_spi_unprepare_transfer_hardware(struct spi_master
> > +*master) {
> > +       struct uniphier_spi_priv *priv =
> > +spi_master_get_devdata(master);
> > +
> > +       writel(0, priv->base + SSI_CTL);
> > +
> > +       return 0;
> > +}
> > +
> > +static irqreturn_t uniphier_spi_handler(int irq, void *dev_id) {
> > +       struct uniphier_spi_priv *priv = dev_id;
> > +       u32 val, stat;
> > +
> > +       stat = readl(priv->base + SSI_IS);
> > +       val = SSI_IC_TCIC | SSI_IC_RCIC | SSI_IC_RORIC;
> > +       writel(val, priv->base + SSI_IC);
> > +
> > +       /* rx fifo overrun */
> > +       if (stat & SSI_IS_RORID) {
> > +               priv->error = -EIO;
> > +               goto done;
> > +       }
> > +
> > +       /* rx complete */
> > +       if ((stat & SSI_IS_RCID) && (stat & SSI_IS_RXRS)) {
> > +               while ((readl(priv->base + SSI_SR) & SSI_SR_RNE) &&
> > +                               (priv->rx_bytes - priv->tx_bytes) > 0)
> > +                       uniphier_spi_recv(priv);
> > +
> > +               if ((readl(priv->base + SSI_SR) & SSI_SR_RNE) ||
> > +                               (priv->rx_bytes != priv->tx_bytes)) {
> > +                       priv->error = -EIO;
> > +                       goto done;
> > +               } else if (priv->rx_bytes == 0)
> > +                       goto done;
> > +
> > +               /* next tx transfer */
> > +               uniphier_spi_fill_tx_fifo(priv);
> > +
> > +               return IRQ_HANDLED;
> > +       }
> > +
> > +       return IRQ_NONE;
> > +
> > +done:
> > +       complete(&priv->xfer_done);
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static int uniphier_spi_probe(struct platform_device *pdev) {
> > +       struct uniphier_spi_priv *priv;
> > +       struct spi_master *master;
> > +       struct resource *res;
> > +       unsigned long clksrc;
> > +       int ret;
> > +
> > +       master = spi_alloc_master(&pdev->dev, sizeof(*priv));
> > +       if (!master)
> > +               return -ENOMEM;
> > +
> > +       platform_set_drvdata(pdev, master);
> > +
> > +       priv = spi_master_get_devdata(master);
> > +       priv->master = master;
> > +       priv->is_save_param = false;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       priv->base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(priv->base)) {
> > +               ret = PTR_ERR(priv->base);
> > +               goto out_master_put;
> > +       }
> > +
> > +       priv->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(priv->clk)) {
> > +               dev_err(&pdev->dev, "failed to get clock\n");
> > +               ret = PTR_ERR(priv->clk);
> > +               goto out_master_put;
> > +       }
> > +
> > +       ret = clk_prepare_enable(priv->clk);
> > +       if (ret)
> > +               goto out_master_put;
> > +
> > +       priv->irq = platform_get_irq(pdev, 0);
> > +       if (priv->irq < 0) {
> > +               dev_err(&pdev->dev, "failed to get IRQ\n");
> > +               ret = -ENXIO;
> > +               goto out_disable_clk;
> > +       }
> > +
> > +       ret = devm_request_irq(&pdev->dev, priv->irq, uniphier_spi_handler,
> > +                              0, "uniphier-spi", priv);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to request IRQ\n");
> > +               goto out_disable_clk;
> > +       }
> > +
> > +       init_completion(&priv->xfer_done);
> > +
> > +       clksrc = clk_get_rate(priv->clk);
> 
> 
> How about 'clk_rate' ?

OK. I will replace clksrc to clk_rate.

> 
> 
> > +       master->max_speed_hz = DIV_ROUND_UP(clksrc, SSI_MIN_CLK_DIVIDER);
> > +       master->min_speed_hz = DIV_ROUND_UP(clksrc, SSI_MAX_CLK_DIVIDER);
> > +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> > +       master->dev.of_node = pdev->dev.of_node;
> > +       master->bus_num = pdev->id;
> > +       master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
> > +
> > +       master->set_cs = uniphier_spi_set_cs;
> > +       master->transfer_one = uniphier_spi_transfer_one;
> > +       master->prepare_transfer_hardware
> > +                               = uniphier_spi_prepare_transfer_hardware;
> > +       master->unprepare_transfer_hardware
> > +                               = uniphier_spi_unprepare_transfer_hardware;
> > +       master->num_chipselect = 1;
> > +
> > +       ret = devm_spi_register_master(&pdev->dev, master);
> > +       if (ret)
> > +               goto out_disable_clk;
> > +
> > +       return ret;
> 
> 
> I think
> 
>           return 0;
> 
> will be clearer.

I think so. I will modify it.

Thank you.

-----------------
Best Regards,
Keiji Hayashibara



