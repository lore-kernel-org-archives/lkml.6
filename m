Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C98C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F98520658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFm0NePi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F98520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeHaPOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeHaPOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:14:51 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A284020843;
        Fri, 31 Aug 2018 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535713672;
        bh=4oTLFcPNKbl/S/G6d3kfLwCATeCy+zf9TKHA4acKuLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AFm0NePiXg2VR9MrBDkcWswI82mYSvt2t8sDuxm8rZGgAo5dXlBVVkEllRWBvooel
         qcBpNkkxpL5akgBWLpPdwyizQhQ817s9rBnfhMuo553k39ZqfrG8Xte27CWQ0rij7v
         6OgmUqLvjmi50TDLn57VprT6990RvOmPT+1/95JU=
Received: by mail-wr1-f45.google.com with SMTP id v90-v6so10858072wrc.0;
        Fri, 31 Aug 2018 04:07:52 -0700 (PDT)
X-Gm-Message-State: APzg51BYEUBPXqisRxR/XKdk+c/XU4/NB7/F0A1FTzfV9IIx6rxGzhNq
        +hobsWeDkT8DsgXxz2ejIix3NOjnlgIxMdlfCrI=
X-Google-Smtp-Source: ANB0VdZyiGCO2OO/D03ip81QCclnQFFbO7aeswwJ6l3lEPX1gYVv3pBuKrWecHpp8KSI4UlR6TCvGuxVNCC94bK1IR4=
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr9961230wre.115.1535713671047;
 Fri, 31 Aug 2018 04:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180830171539.20008-1-krzk@kernel.org> <20180830171539.20008-7-krzk@kernel.org>
 <20180831073918.bcmonixmeehvr42h@pengutronix.de>
In-Reply-To: <20180831073918.bcmonixmeehvr42h@pengutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 Aug 2018 13:07:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcR-h0s7h01HnizV1xZeEmv4Mwgpmrm-LqMo9fD95v7RA@mail.gmail.com>
Message-ID: <CAJKOXPcR-h0s7h01HnizV1xZeEmv4Mwgpmrm-LqMo9fD95v7RA@mail.gmail.com>
Subject: Re: [PATCH 6/6] crypto: vf-crc - Add new driver for Freescale Vybrid CRC
To:     s.hauer@pengutronix.de
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        kernel@pengutronix.de, Stefan Agner <stefan@agner.ch>,
        fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 at 09:39, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> Hi Krzysztof,
>
> Some comments inline.
>
> On Thu, Aug 30, 2018 at 07:15:39PM +0200, Krzysztof Kozlowski wrote:
> > Add driver for using the Freescale/NXP Vybrid processor CRC block for
> > CRC16 and CRC32 offloading.  The driver implements shash_alg and was
> > tested using internal testmgr tests and libkcapi.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  MAINTAINERS               |   7 +
> >  drivers/crypto/Kconfig    |  10 ++
> >  drivers/crypto/Makefile   |   1 +
> >  drivers/crypto/vf-crc.c   | 387 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/crc32poly.h |   7 +
> >  5 files changed, 412 insertions(+)
> >  create mode 100644 drivers/crypto/vf-crc.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0a340f680230..e84fa829a4e4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15388,6 +15388,13 @@ S:   Maintained
> >  F:   Documentation/fb/uvesafb.txt
> >  F:   drivers/video/fbdev/uvesafb.*
> >
> > +VF500/VF610 HW CRC DRIVER
> > +M:   Krzysztof Kozlowski <krzk@kernel.org>
> > +L:   linux-crypto@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/crypto/vf-crc.c
> > +F:   Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt
> > +
> >  VF610 NAND DRIVER
> >  M:   Stefan Agner <stefan@agner.ch>
> >  L:   linux-mtd@lists.infradead.org
> > diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> > index 20314d7a7b58..0ade940ac79c 100644
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -418,6 +418,16 @@ config CRYPTO_DEV_MXS_DCP
> >         To compile this driver as a module, choose M here: the module
> >         will be called mxs-dcp.
> >
> > +config CRYPTO_DEV_VF_CRC
> > +     tristate "Support for Freescale/NXP Vybrid CRC HW accelerator"
> > +     select CRYPTO_HASH
> > +     help
> > +       This option enables support for the CRC16/32 hardware accelerator
> > +       on Freescale/NXP Vybrid VF500/VF610 SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called vf-crc.
> > +
> >  config CRYPTO_DEV_EXYNOS_RNG
> >       tristate "EXYNOS HW pseudo random number generator support"
> >       depends on ARCH_EXYNOS || COMPILE_TEST
> > diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> > index c23396f32c8a..418c08bdc19c 100644
> > --- a/drivers/crypto/Makefile
> > +++ b/drivers/crypto/Makefile
> > @@ -41,6 +41,7 @@ obj-$(CONFIG_ARCH_STM32) += stm32/
> >  obj-$(CONFIG_CRYPTO_DEV_SUN4I_SS) += sunxi-ss/
> >  obj-$(CONFIG_CRYPTO_DEV_TALITOS) += talitos.o
> >  obj-$(CONFIG_CRYPTO_DEV_UX500) += ux500/
> > +obj-$(CONFIG_CRYPTO_DEV_VF_CRC) += vf-crc.o
> >  obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio/
> >  obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
> >  obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
> > +static int vf_crc_update_prepare(struct vf_crc_tfm_ctx *mctx,
> > +                              struct vf_crc_desc_ctx *desc_ctx)
> > +{
> > +     struct vf_crc *crc = desc_ctx->crc;
> > +     int ret;
> > +
> > +     ret = clk_prepare_enable(crc->clk);
> > +     if (ret) {
> > +             dev_err(crc->dev, "Failed to enable clock\n");
> > +             return ret;
> > +     }
>
> Generally have you measured the performance of this driver? Is it faster
> than the software implementation?

I wanted to replace our in-house out-of-tree, hacky ioctl-based driver
with something more upstreamable. I run few simple user-space
performance tests and in fact SW implementation is faster. Around 5x
faster for this version of driver. However it depends highly on size
of message (buffer) because there is big overhead of libkcapi.

The typical SW implementation (with lookup tables) is just fetching of
data from memory and computing. Usage of libkcapi is at least three
library function calls on user-space side and a bunch of other code on
kernel side.

There are two benefits:
1. CPU could be offloaded and do something in parallel. However for
this I should probably implement asymmetric hash. Otherwise wastes
cycles on reading from CRC registers... and of course on clk prepare
and mutex handing.
2. Theoretically it could lower energy consumption... as CPU would not
be that busy. I found 3% lower power usage (0.18 A -> 0.175 A) but if
you multiply it per time then total energy spent would be higher.

Does this driver makes sense in such case? In fact I have doubts...

It was nice exercise for me though. :)

>
> Under certain circumstances a clk_prepare_enable might become expensive,
> so it could happen that all this clk enabling/disabling takes longer
> than the action you do in between. Using pm_runtime might help here.

I should convert them to just clk_enable/disable. The pm_runtime is
also a huge framework and adds its own overhead. Using it just to
toggle one clock is a lot.

> > +
> > +     mutex_lock(&crc->lock);
> > +
> > +     /*
> > +      * Check if we are continuing to process request already configured
> > +      * in HW. HW has to be re-initialized only on first update() for given
> > +      * request or if new request was processed after last call to update().
> > +      */
> > +     if (crc->processed_desc == desc_ctx)
> > +             return 0;
>
> You never set crc->processed_desc to anything, so this optimization
> never triggers.

Ah, damn, I missed setting it!

> Unless properly implementing this skip-to-reinitialize-hardware really
> brings a measurerable performance gain I would just drop this
> optimization. In the end you only save a few register writes, but it
> makes the driver more complicated.

I measured it now... and indeed - removal of this optimization allows
to remove also one mutex lock/unlock - so the total net is 0.8% faster
with the optimization.

> > +
> > +     vf_crc_initialize_regs(mctx, desc_ctx);
> > +
> > +     return 0;
> > +}
> > +
>
> > +static int vf_crc_finup(struct shash_desc *desc, const u8 *data,
> > +                     unsigned int len, u8 *out)
> > +{
> > +     return vf_crc_update(desc, data, len) ?:
> > +            vf_crc_final(desc, out);
> > +}
> > +
> > +static int vf_crc_digest(struct shash_desc *desc, const u8 *data,
> > +                      unsigned int leng, u8 *out)
> > +{
> > +     return vf_crc_init(desc) ?: vf_crc_finup(desc, data, leng, out);
> > +}
>
> These seem unnecessary. The crypto core will set these with similar
> wrappers if unspecified.

Sure.
>
> > +static int vf_crc_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct resource *res;
> > +     struct vf_crc *crc;
> > +     int ret;
> > +
> > +     if (vf_crc_data) {
> > +             dev_err(dev, "Device already registered (only one instance allowed)\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     crc = devm_kzalloc(dev, sizeof(*crc), GFP_KERNEL);
> > +     if (!crc)
> > +             return -ENOMEM;
> > +
> > +     crc->dev = dev;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     crc->iobase = devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(crc->iobase))
> > +             return PTR_ERR(crc->iobase);
> > +
> > +     crc->clk = devm_clk_get(dev, "crc");
> > +     if (IS_ERR(crc->clk)) {
> > +             dev_err(dev, "Could not get clock\n");
> > +             return PTR_ERR(crc->clk);
> > +     }
> > +
> > +     vf_crc_data = crc;
> > +
> > +     ret = crypto_register_shashes(algs, ARRAY_SIZE(algs));
> > +     if (ret) {
> > +             dev_err(dev, "Failed to register crypto algorithms\n");
> > +             goto err;
> > +     }
> > +
> > +     mutex_init(&crc->lock);
>
> Should be done before the shashes are registered.

Right.

Thanks for the review!
Krzysztof
