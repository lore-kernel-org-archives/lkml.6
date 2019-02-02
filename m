Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B210C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3094D218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549100869;
	bh=ApyUGzTLaEyifk7h7OC9KloANyTWIir+g63u/cscFrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jWD+1VxQZGjdOjeqOHaXlXdBk9vDkm9lrPBEUtWxPQaCoFG0cmMUJDnTb7eEEus5u
	 I7TJmLj81Jo1Kfpo4j6PwB2p08R/xXOUBn6Xsp/73r7yrEw7Ap5Fprt3YyJgTkdGpS
	 wkH1Vit42/UG6qaN2rObBrLM7ZpzUUQaP+zwZJXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfBBJrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfBBJrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:47:47 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7284D218A6;
        Sat,  2 Feb 2019 09:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549100865;
        bh=ApyUGzTLaEyifk7h7OC9KloANyTWIir+g63u/cscFrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZDPzeZ2of8FzKmTrOX4xdzKyBFmDWILJRnoAfYZMpO79ckP+vPXmotN/E9qi6XHW
         M0PEnK2plPNNPTRKre6ilqJZIHwMgtklo54gQLkVLy5FS9T9pB0a32qSNv+a4G2TIe
         dlaGjN33lGezS/JJ0w/ePLf38SYY3XMYyw9lNZMs=
Date:   Sat, 2 Feb 2019 09:47:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: add NPCM ADC driver
Message-ID: <20190202094739.42ff0319@archlinux>
In-Reply-To: <CAP6Zq1g-Q7JvE1eEot0FEZuiNG-m-bsy3E+Jf2vO_ALjoaMCag@mail.gmail.com>
References: <20190116164855.200357-1-tmaimon77@gmail.com>
        <20190116164855.200357-3-tmaimon77@gmail.com>
        <20190119180843.78510580@archlinux>
        <CAP6Zq1j=wjkKYsP=aFSDCYKV3ESUibtV0oXTXG5P1LikVgdJdw@mail.gmail.com>
        <20190126173240.4f87423d@archlinux>
        <CAP6Zq1g-Q7JvE1eEot0FEZuiNG-m-bsy3E+Jf2vO_ALjoaMCag@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 12:53:18 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks for the clarification,
> 
>  I will like to to Modify the NPCM ADC dt-binding document (
> https://patchwork.ozlabs.org/patch/1022527/ - removing rst node).
> 
> To send a new commit to the iio.git testing branch or to send a new patch
> version?
New commit is good at this point.

Thanks,

Jonathan

> 
> Thanks,
> 
> Tomer
> 
> On Sat, 26 Jan 2019 at 19:32, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 20 Jan 2019 17:05:38 +0200
> > Tomer Maimon <tmaimon77@gmail.com> wrote:
> >  
> > > Hi Jonathan,
> > >
> > > Thanks a lot for reviewing our driver,
> > >
> > > On Sat, 19 Jan 2019 at 20:08, Jonathan Cameron <jic23@kernel.org> wrote:
> > >  
> > > > On Wed, 16 Jan 2019 18:48:55 +0200
> > > > Tomer Maimon <tmaimon77@gmail.com> wrote:
> > > >  
> > > > > Add Nuvoton NPCM BMC Analog-to-Digital Converter(ADC) driver.
> > > > >
> > > > > The NPCM ADC is a 10-bit converter for eight channel inputs.
> > > > >
> > > > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>  
> > > > One trivial ordering in remove oddity that I'll just fix up.
> > > > Also, I don't particularly like printing a message on success
> > > > as it's not providing any useful info.  Hmm. I don't care
> > > > strongly enough to remove it though.
> > > >  
> > >
> > > The Probe log is is important for us when customers doing bring-up or  
> > have  
> > > some issues,
> > > we ask the logs w/o asking to do all kinds of things to see if a device  
> > was  
> > > probed.  
> >
> > You should probably develop a proper info gathering script.  Chances of
> > this
> > randomly getting 'tidied up' in future (i.e. remove) is rather high and
> > I doubt I'll remember this if you miss the patch...
> >
> > I don't care all that much though and your problem if it goes away. Kernel
> > logs shouldn't be used as ABI.  Even error messages tend to change over
> > time!
> >
> > Jonathan
> >  
> > >
> > >  
> > > > Applied to the togreg branch of iio.git and pushed out as
> > > > testing for the autobuilders to play with it.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >  
> > > > > ---
> > > > >  drivers/iio/adc/Kconfig    |  10 ++
> > > > >  drivers/iio/adc/Makefile   |   1 +
> > > > >  drivers/iio/adc/npcm_adc.c | 335  
> > > > +++++++++++++++++++++++++++++++++++++++++++++  
> > > > >  3 files changed, 346 insertions(+)
> > > > >  create mode 100644 drivers/iio/adc/npcm_adc.c
> > > > >
> > > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > > index 7a3ca4ec0cb7..2d1e70a7d5c4 100644
> > > > > --- a/drivers/iio/adc/Kconfig
> > > > > +++ b/drivers/iio/adc/Kconfig
> > > > > @@ -576,6 +576,16 @@ config NAU7802
> > > > >         To compile this driver as a module, choose M here: the
> > > > >         module will be called nau7802.
> > > > >
> > > > > +config NPCM_ADC
> > > > > +     tristate "Nuvoton NPCM ADC driver"
> > > > > +     depends on ARCH_NPCM || COMPILE_TEST
> > > > > +     depends on HAS_IOMEM
> > > > > +     help
> > > > > +       Say yes here to build support for Nuvoton NPCM ADC.
> > > > > +
> > > > > +       This driver can also be built as a module. If so, the module
> > > > > +       will be called npcm_adc.
> > > > > +
> > > > >  config PALMAS_GPADC
> > > > >       tristate "TI Palmas General Purpose ADC"
> > > > >       depends on MFD_PALMAS
> > > > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > > > index 07df37f621bd..3337eb1f4c30 100644
> > > > > --- a/drivers/iio/adc/Makefile
> > > > > +++ b/drivers/iio/adc/Makefile
> > > > > @@ -55,6 +55,7 @@ obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
> > > > >  obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
> > > > >  obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
> > > > >  obj-$(CONFIG_NAU7802) += nau7802.o
> > > > > +obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
> > > > >  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
> > > > >  obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
> > > > >  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
> > > > > diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> > > > > new file mode 100644
> > > > > index 000000000000..1cc377cdf1f7
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/adc/npcm_adc.c
> > > > > @@ -0,0 +1,335 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +// Copyright (c) 2019 Nuvoton Technology corporation.
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/mfd/syscon.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/regmap.h>
> > > > > +#include <linux/regulator/consumer.h>
> > > > > +#include <linux/spinlock.h>
> > > > > +#include <linux/uaccess.h>
> > > > > +
> > > > > +struct npcm_adc {
> > > > > +     bool int_status;
> > > > > +     u32 adc_sample_hz;
> > > > > +     struct device *dev;
> > > > > +     void __iomem *regs;
> > > > > +     struct clk *adc_clk;
> > > > > +     wait_queue_head_t wq;
> > > > > +     struct regulator *vref;
> > > > > +     struct regmap *rst_regmap;
> > > > > +};
> > > > > +
> > > > > +/* NPCM7xx reset module */
> > > > > +#define NPCM7XX_IPSRST1_OFFSET               0x020
> > > > > +#define NPCM7XX_IPSRST1_ADC_RST              BIT(27)
> > > > > +
> > > > > +/* ADC registers */
> > > > > +#define NPCM_ADCCON   0x00
> > > > > +#define NPCM_ADCDATA  0x04
> > > > > +
> > > > > +/* ADCCON Register Bits */
> > > > > +#define NPCM_ADCCON_ADC_INT_EN               BIT(21)
> > > > > +#define NPCM_ADCCON_REFSEL           BIT(19)
> > > > > +#define NPCM_ADCCON_ADC_INT_ST               BIT(18)
> > > > > +#define NPCM_ADCCON_ADC_EN           BIT(17)
> > > > > +#define NPCM_ADCCON_ADC_RST          BIT(16)
> > > > > +#define NPCM_ADCCON_ADC_CONV         BIT(13)
> > > > > +
> > > > > +#define NPCM_ADCCON_CH_MASK          GENMASK(27, 24)
> > > > > +#define NPCM_ADCCON_CH(x)            ((x) << 24)
> > > > > +#define NPCM_ADCCON_DIV_SHIFT                1
> > > > > +#define NPCM_ADCCON_DIV_MASK         GENMASK(8, 1)
> > > > > +#define NPCM_ADC_DATA_MASK(x)                ((x) & GENMASK(9, 0))
> > > > > +
> > > > > +#define NPCM_ADC_ENABLE              (NPCM_ADCCON_ADC_EN |  
> > > > NPCM_ADCCON_ADC_INT_EN)  
> > > > > +
> > > > > +/* ADC General Definition */
> > > > > +#define NPCM_RESOLUTION_BITS         10
> > > > > +#define NPCM_INT_VREF_MV             2000
> > > > > +
> > > > > +#define NPCM_ADC_CHAN(ch) {                                  \
> > > > > +     .type = IIO_VOLTAGE,                                    \
> > > > > +     .indexed = 1,                                           \
> > > > > +     .channel = ch,                                          \
> > > > > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> > > > > +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |  \
> > > > > +                             BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
> > > > > +}
> > > > > +
> > > > > +static const struct iio_chan_spec npcm_adc_iio_channels[] = {
> > > > > +     NPCM_ADC_CHAN(0),
> > > > > +     NPCM_ADC_CHAN(1),
> > > > > +     NPCM_ADC_CHAN(2),
> > > > > +     NPCM_ADC_CHAN(3),
> > > > > +     NPCM_ADC_CHAN(4),
> > > > > +     NPCM_ADC_CHAN(5),
> > > > > +     NPCM_ADC_CHAN(6),
> > > > > +     NPCM_ADC_CHAN(7),
> > > > > +};
> > > > > +
> > > > > +static irqreturn_t npcm_adc_isr(int irq, void *data)
> > > > > +{
> > > > > +     u32 regtemp;
> > > > > +     struct iio_dev *indio_dev = data;
> > > > > +     struct npcm_adc *info = iio_priv(indio_dev);
> > > > > +
> > > > > +     regtemp = ioread32(info->regs + NPCM_ADCCON);
> > > > > +     if (regtemp & NPCM_ADCCON_ADC_INT_ST) {
> > > > > +             iowrite32(regtemp, info->regs + NPCM_ADCCON);
> > > > > +             wake_up_interruptible(&info->wq);
> > > > > +             info->int_status = true;
> > > > > +     }
> > > > > +
> > > > > +     return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +static int npcm_adc_read(struct npcm_adc *info, int *val, u8  
> > channel)  
> > > > > +{
> > > > > +     int ret;
> > > > > +     u32 regtemp;
> > > > > +
> > > > > +     /* Select ADC channel */
> > > > > +     regtemp = ioread32(info->regs + NPCM_ADCCON);
> > > > > +     regtemp &= ~NPCM_ADCCON_CH_MASK;
> > > > > +     info->int_status = false;
> > > > > +     iowrite32(regtemp | NPCM_ADCCON_CH(channel) |
> > > > > +               NPCM_ADCCON_ADC_CONV, info->regs + NPCM_ADCCON);
> > > > > +
> > > > > +     ret = wait_event_interruptible_timeout(info->wq,  
> > info->int_status,  
> > > > > +                                            msecs_to_jiffies(10));
> > > > > +     if (ret == 0) {
> > > > > +             regtemp = ioread32(info->regs + NPCM_ADCCON);
> > > > > +             if ((regtemp & NPCM_ADCCON_ADC_CONV) &&  
> > info->rst_regmap) {  
> > > > > +                     /* if conversion failed - reset ADC module */
> > > > > +                     regmap_write(info->rst_regmap,  
> > > > NPCM7XX_IPSRST1_OFFSET,  
> > > > > +                                  NPCM7XX_IPSRST1_ADC_RST);
> > > > > +                     msleep(100);
> > > > > +                     regmap_write(info->rst_regmap,  
> > > > NPCM7XX_IPSRST1_OFFSET,  
> > > > > +                                  0x0);
> > > > > +                     msleep(100);
> > > > > +
> > > > > +                     /* Enable ADC and start conversion module */
> > > > > +                     iowrite32(NPCM_ADC_ENABLE |  
> > NPCM_ADCCON_ADC_CONV,  
> > > > > +                               info->regs + NPCM_ADCCON);
> > > > > +                     dev_err(info->dev, "RESET ADC Complete\n");
> > > > > +             }
> > > > > +             return -ETIMEDOUT;
> > > > > +     }
> > > > > +     if (ret < 0)
> > > > > +             return ret;
> > > > > +
> > > > > +     *val = NPCM_ADC_DATA_MASK(ioread32(info->regs + NPCM_ADCDATA));
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int npcm_adc_read_raw(struct iio_dev *indio_dev,
> > > > > +                          struct iio_chan_spec const *chan, int  
> > *val,  
> > > > > +                          int *val2, long mask)
> > > > > +{
> > > > > +     int ret;
> > > > > +     int vref_uv;
> > > > > +     struct npcm_adc *info = iio_priv(indio_dev);
> > > > > +
> > > > > +     switch (mask) {
> > > > > +     case IIO_CHAN_INFO_RAW:
> > > > > +             mutex_lock(&indio_dev->mlock);
> > > > > +             ret = npcm_adc_read(info, val, chan->channel);
> > > > > +             mutex_unlock(&indio_dev->mlock);
> > > > > +             if (ret) {
> > > > > +                     dev_err(info->dev, "NPCM ADC read failed\n");
> > > > > +                     return ret;
> > > > > +             }
> > > > > +             return IIO_VAL_INT;
> > > > > +     case IIO_CHAN_INFO_SCALE:
> > > > > +             if (info->vref) {
> > > > > +                     vref_uv = regulator_get_voltage(info->vref);
> > > > > +                     *val = vref_uv / 1000;
> > > > > +             } else {
> > > > > +                     *val = NPCM_INT_VREF_MV;
> > > > > +             }
> > > > > +             *val2 = NPCM_RESOLUTION_BITS;
> > > > > +             return IIO_VAL_FRACTIONAL_LOG2;
> > > > > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > > > > +             *val = info->adc_sample_hz;
> > > > > +             return IIO_VAL_INT;
> > > > > +     default:
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct iio_info npcm_adc_iio_info = {
> > > > > +     .read_raw = &npcm_adc_read_raw,
> > > > > +};
> > > > > +
> > > > > +static const struct of_device_id npcm_adc_match[] = {
> > > > > +     { .compatible = "nuvoton,npcm750-adc", },
> > > > > +     { /* sentinel */ }
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, npcm_adc_match);
> > > > > +
> > > > > +static int npcm_adc_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +     int ret;
> > > > > +     int irq;
> > > > > +     u32 div;
> > > > > +     u32 reg_con;
> > > > > +     struct resource *res;
> > > > > +     struct npcm_adc *info;
> > > > > +     struct iio_dev *indio_dev;
> > > > > +     struct device *dev = &pdev->dev;
> > > > > +     struct device_node *np = pdev->dev.of_node;
> > > > > +
> > > > > +     indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> > > > > +     if (!indio_dev)
> > > > > +             return -ENOMEM;
> > > > > +     info = iio_priv(indio_dev);
> > > > > +
> > > > > +     info->dev = &pdev->dev;
> > > > > +
> > > > > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > +     info->regs = devm_ioremap_resource(&pdev->dev, res);
> > > > > +     if (IS_ERR(info->regs))
> > > > > +             return PTR_ERR(info->regs);
> > > > > +
> > > > > +     info->adc_clk = devm_clk_get(&pdev->dev, NULL);
> > > > > +     if (IS_ERR(info->adc_clk)) {
> > > > > +             dev_warn(&pdev->dev, "ADC clock failed: can't read  
> > clk\n");  
> > > > > +             return PTR_ERR(info->adc_clk);
> > > > > +     }
> > > > > +
> > > > > +     /* calculate ADC clock sample rate */
> > > > > +     reg_con = ioread32(info->regs + NPCM_ADCCON);
> > > > > +     div = reg_con & NPCM_ADCCON_DIV_MASK;
> > > > > +     div = div >> NPCM_ADCCON_DIV_SHIFT;
> > > > > +     info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1)  
> > *  
> > > > 2);  
> > > > > +
> > > > > +     if (of_device_is_compatible(np, "nuvoton,npcm750-adc")) {
> > > > > +             info->rst_regmap = syscon_regmap_lookup_by_compatible
> > > > > +                     ("nuvoton,npcm750-rst");
> > > > > +             if (IS_ERR(info->rst_regmap)) {
> > > > > +                     dev_err(&pdev->dev, "Failed to find  
> > > > nuvoton,npcm750-rst\n");  
> > > > > +                     ret = PTR_ERR(info->rst_regmap);
> > > > > +                     goto err_disable_clk;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     irq = platform_get_irq(pdev, 0);
> > > > > +     if (irq <= 0) {
> > > > > +             dev_err(dev, "failed getting interrupt resource\n");
> > > > > +             ret = -EINVAL;
> > > > > +             goto err_disable_clk;
> > > > > +     }
> > > > > +
> > > > > +     ret = devm_request_irq(&pdev->dev, irq, npcm_adc_isr, 0,
> > > > > +                            "NPCM_ADC", indio_dev);
> > > > > +     if (ret < 0) {
> > > > > +             dev_err(dev, "failed requesting interrupt\n");
> > > > > +             goto err_disable_clk;
> > > > > +     }
> > > > > +
> > > > > +     reg_con = ioread32(info->regs + NPCM_ADCCON);
> > > > > +     info->vref = devm_regulator_get_optional(&pdev->dev, "vref");
> > > > > +     if (!IS_ERR(info->vref)) {
> > > > > +             ret = regulator_enable(info->vref);
> > > > > +             if (ret) {
> > > > > +                     dev_err(&pdev->dev, "Can't enable ADC  
> > reference  
> > > > voltage\n");  
> > > > > +                     goto err_disable_clk;
> > > > > +             }
> > > > > +
> > > > > +             iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
> > > > > +                       info->regs + NPCM_ADCCON);
> > > > > +     } else {
> > > > > +             /*
> > > > > +              * Any error which is not ENODEV indicates the  
> > regulator  
> > > > > +              * has been specified and so is a failure case.
> > > > > +              */
> > > > > +             if (PTR_ERR(info->vref) != -ENODEV) {
> > > > > +                     ret = PTR_ERR(info->vref);
> > > > > +                     goto err_disable_clk;
> > > > > +             }
> > > > > +
> > > > > +             /* Use internal reference */
> > > > > +             iowrite32(reg_con | NPCM_ADCCON_REFSEL,
> > > > > +                       info->regs + NPCM_ADCCON);
> > > > > +     }
> > > > > +
> > > > > +     init_waitqueue_head(&info->wq);
> > > > > +
> > > > > +     reg_con = ioread32(info->regs + NPCM_ADCCON);
> > > > > +     reg_con |= NPCM_ADC_ENABLE;
> > > > > +
> > > > > +     /* Enable the ADC Module */
> > > > > +     iowrite32(reg_con, info->regs + NPCM_ADCCON);
> > > > > +
> > > > > +     /* Start ADC conversion */
> > > > > +     iowrite32(reg_con | NPCM_ADCCON_ADC_CONV, info->regs +  
> > > > NPCM_ADCCON);  
> > > > > +
> > > > > +     platform_set_drvdata(pdev, indio_dev);
> > > > > +     indio_dev->name = dev_name(&pdev->dev);
> > > > > +     indio_dev->dev.parent = &pdev->dev;
> > > > > +     indio_dev->info = &npcm_adc_iio_info;
> > > > > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > > > > +     indio_dev->channels = npcm_adc_iio_channels;
> > > > > +     indio_dev->num_channels = ARRAY_SIZE(npcm_adc_iio_channels);
> > > > > +
> > > > > +     ret = iio_device_register(indio_dev);
> > > > > +     if (ret) {
> > > > > +             dev_err(&pdev->dev, "Couldn't register the device.\n");
> > > > > +             goto err_iio_register;
> > > > > +     }
> > > > > +
> > > > > +     pr_info("NPCM ADC driver probed\n");  
> > > > Hmm. Not sure this tells us anything useful.  If we have succeeding
> > > > in probing there are lots of ways to find out that are better than
> > > > filling up the kernel log.
> > > >  
> > > > > +
> > > > > +     return 0;
> > > > > +
> > > > > +err_iio_register:
> > > > > +     iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs +  
> > NPCM_ADCCON);  
> > > > > +     if (!IS_ERR(info->vref))
> > > > > +             regulator_disable(info->vref);
> > > > > +err_disable_clk:
> > > > > +     clk_disable_unprepare(info->adc_clk);
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static int npcm_adc_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +     struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > > > > +     struct npcm_adc *info = iio_priv(indio_dev);
> > > > > +     u32 regtemp;
> > > > > +
> > > > > +     regtemp = ioread32(info->regs + NPCM_ADCCON);  
> > > >
> > > > The ordering is a bit odd here.  I would have done the unregister
> > > > first then read the value.  Doesn't have any real effect other than  
> > making  
> > > > reviewers wonder if there is something interesting going on!
> > > >  
> > > > > +
> > > > > +     iio_device_unregister(indio_dev);
> > > > > +     iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs +  
> > NPCM_ADCCON);  
> > > > > +     if (!IS_ERR(info->vref))
> > > > > +             regulator_disable(info->vref);
> > > > > +     clk_disable_unprepare(info->adc_clk);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static struct platform_driver npcm_adc_driver = {
> > > > > +     .probe          = npcm_adc_probe,
> > > > > +     .remove         = npcm_adc_remove,
> > > > > +     .driver         = {
> > > > > +             .name   = "npcm_adc",
> > > > > +             .of_match_table = npcm_adc_match,
> > > > > +     },
> > > > > +};
> > > > > +
> > > > > +module_platform_driver(npcm_adc_driver);
> > > > > +
> > > > > +MODULE_DESCRIPTION("Nuvoton NPCM ADC Driver");
> > > > > +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> > > > > +MODULE_LICENSE("GPL v2");  
> > > >
> > > >  
> > > Thanks,
> > >
> > > Tomer  
> >
> >  

