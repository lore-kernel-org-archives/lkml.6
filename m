Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA854C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4EA2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4Fp1FVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4EA2175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeHMUQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:16:21 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42560 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMUQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:16:21 -0400
Received: by mail-qk0-f196.google.com with SMTP id 13-v6so11502886qkl.9;
        Mon, 13 Aug 2018 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=B7JMtjaVH0vmxABS4X5IBPYRi4eQBUYvN5WplUK4Mhw=;
        b=u4Fp1FVV0IipmZkv0WdgdkYMF6QWBZTtk1ygd0I2StgTPsVmhmAzY03Pq52iA1WxWr
         mTBcmz/RPUPKL+yten3cRIs/e5TWVcNPUxEGdBr2pz5mQ8aBjweULM5HDL3nCK0BWIiE
         oetjv8ZFfHka7kYU2+wiIv5GStSGJwOJ1Uxbh04TgfjPwltbjHUvsR7ugM3+aig1b3fv
         Y+2uZStjvDI0FfAm6c56/02QMC8A857Vgz3jXYsC/PEJCXBHCrRt4RabuEsxuGAApafi
         JK6x9YuWBGYxuxR7YP8wWkS6yyfQ9lhnVQocIW7UG47iV4MptI6ygcZcO3Eu3HyaIlsS
         MkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=B7JMtjaVH0vmxABS4X5IBPYRi4eQBUYvN5WplUK4Mhw=;
        b=VPEVkPrc0/YyvR4a0NVv5RU53/sgE+ubhonmTzJHSZJJA5ywj/AlpTTFL9uQdeGXH+
         6DXngDTdjf3cCJeN6PhcG5vc2Yb0G9Cp8lOOchrlBiaffJ2KPGdAGtTTYo4MzXlkM1EQ
         9jRVzQGxdglqoXinauJfWWESb2SpdTCGTb1PxT3EgzAraU/SBDMS/Kjbsx9AcRQCGhmw
         4GojfYdLAgaCbiczTdoQjTrBW9V6hmeCx3S6LMNktWPpsp9FQwgkIUGknCE2jwNuk4EX
         oSg1jg/23oNePwgWUVcaEOo9Zz7X4fjQONavjnh9zULbn5bBZqoqoVi8BFDuT1PEpljc
         a4Gw==
X-Gm-Message-State: AOUpUlGswLV+8LLyewUdmk7vflJ+XnAKRH3BYk0AdmZfeUmAsp4ZXbXM
        Oczkqj0fkdCJu9e3tBJUl59ZPrOwtdaBwdjJJw==
X-Google-Smtp-Source: AA+uWPwJv9tu+ly4b2YA/BvSKQrPwV4GfJFpewgcC4XP0C20WK8HrkBiBnqHEdyxbOLBkcGBtpTjgPW8fCMQFiokURM=
X-Received: by 2002:a37:ab14:: with SMTP id u20-v6mr16283960qke.120.1534181588549;
 Mon, 13 Aug 2018 10:33:08 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Mon, 13 Aug 2018 11:32:57 -0600
Message-ID: <CAL_JsqJ9YwiuE45aASCzK48WvoFuUPAP=8cjhoxuAMG=grK9cQ@mail.gmail.com>
Subject: [GIT PULL] Devicetree updates for 4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for 4.19. There's a few trivial context
conflicts with the pinctrl, net-next and staging trees due to the
interrupt-parent removal.

Rob

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063=
:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-for-4.19

for you to fetch changes up to f11b9abc9318d5506f08156b4950c24e3cba73e5:

  Documentation: remove dynamic-resolution-notes reference to
non-existent file (2018-08-13 08:20:10 -0600)

----------------------------------------------------------------
Devicetree updates for 4.19:

- Remove an obsolete hack for PPC32 longtrail systems

- Make of_io_request_and_map() "name" arg optional

- Add vendor prefixes for bitmain, Asus, and Y Soft

- Remove 'interrupt-parent' from bindings as it is implicit

- New properties for wm8994 audio codec

- Add 'clocks' property support to SRAM binding

- Add binding for ASPEED coprocessor interrupt controller

- Various binding spelling and link fixes

----------------------------------------------------------------
Anthony Brandon (2):
      dt-bindings: sound: wm8994: document wlf,spkmode-pu property
      dt-bindings: sound: wm8994: document wlf,csnaddr-pd property

Benjamin Herrenschmidt (2):
      drivers/of: Make of_io_request_and_map() "name" argument optional
      dt-bindings: misc: ASPEED coprocessor interrupt controller

Enric Balletbo i Serra (2):
      Documentation: devicetree: tilcdc: fix spelling mistake
"suppors" -> "supports"
      usb: dwc3: rockchip: Fix PHY documentation links.

Fabio Estevam (1):
      dt-bindings: sram: Add 'clocks' as an optional property

Geert Uytterhoeven (1):
      dt-bindings: gpio: pca953x: Document interrupts, update example

Harish Jenny K N (1):
      Documentation: remove dynamic-resolution-notes reference to
non-existent file

Luis Araneda (1):
      dt-bindings: Add vendor prefix for AsusTek Computer Inc.

Marcel Ziswiler (1):
      pinctrl: tegra: fix spelling in devicetree binding document

Michael Ellerman (1):
      of/fdt: Remove PPC32 longtrail hack in memory scan

Michal Simek (1):
      dt-bindings: Add bitmain vendor prefix

Michal Vok=C3=A1=C4=8D (1):
      dt-bindings: Add Y Soft Corporation vendor prefix

Rob Herring (1):
      dt-bindings: remove 'interrupt-parent' from bindings

 .../bindings/arm/freescale/fsl,vf610-mscm-ir.txt   |  3 --
 .../devicetree/bindings/arm/omap/crossbar.txt      |  1 -
 .../devicetree/bindings/arm/samsung/pmu.txt        |  3 --
 Documentation/devicetree/bindings/ata/fsl-sata.txt |  1 -
 .../devicetree/bindings/ata/pata-arasan.txt        |  2 --
 .../devicetree/bindings/board/fsl-board.txt        |  1 -
 .../devicetree/bindings/bus/brcm,gisb-arb.txt      |  2 --
 .../devicetree/bindings/clock/at91-clock.txt       |  7 -----
 .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     |  2 --
 .../devicetree/bindings/crypto/amd-ccp.txt         |  2 --
 .../devicetree/bindings/crypto/arm-cryptocell.txt  |  2 --
 .../devicetree/bindings/crypto/fsl-sec2.txt        |  5 ----
 .../devicetree/bindings/crypto/fsl-sec4.txt        | 21 -------------
 .../devicetree/bindings/crypto/picochip-spacc.txt  |  2 --
 .../bindings/display/bridge/analogix_dp.txt        |  2 --
 .../devicetree/bindings/display/bridge/anx7814.txt |  2 --
 .../bridge/megachips-stdpxxxx-ge-b850v3-fw.txt     |  2 --
 .../devicetree/bindings/display/bridge/sii902x.txt |  4 +--
 .../devicetree/bindings/display/bridge/sii9234.txt |  2 +-
 .../bindings/display/bridge/sil-sii8620.txt        |  2 +-
 .../bindings/display/exynos/exynos7-decon.txt      |  3 --
 .../bindings/display/exynos/exynos_dp.txt          |  2 --
 .../bindings/display/exynos/samsung-fimd.txt       |  3 --
 .../devicetree/bindings/display/ht16k33.txt        |  2 --
 .../devicetree/bindings/display/msm/dsi.txt        |  2 --
 .../devicetree/bindings/display/msm/edp.txt        |  4 ---
 .../devicetree/bindings/display/msm/mdp5.txt       |  2 --
 .../devicetree/bindings/display/renesas,du.txt     |  1 -
 .../devicetree/bindings/display/sm501fb.txt        |  2 --
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |  4 +--
 .../devicetree/bindings/dma/jz4780-dma.txt         |  1 -
 .../bindings/dma/nvidia,tegra210-adma.txt          |  1 -
 .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   |  2 --
 Documentation/devicetree/bindings/dma/snps-dma.txt |  2 --
 Documentation/devicetree/bindings/dma/ti-edma.txt  |  1 -
 .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  |  1 -
 .../devicetree/bindings/extcon/extcon-rt8973a.txt  |  2 --
 .../devicetree/bindings/extcon/extcon-sm5502.txt   |  2 --
 .../devicetree/bindings/gpio/8xxx_gpio.txt         |  2 --
 .../devicetree/bindings/gpio/abilis,tb10x-gpio.txt |  1 -
 .../devicetree/bindings/gpio/brcm,brcmstb-gpio.txt |  3 --
 .../devicetree/bindings/gpio/gpio-adnp.txt         |  1 -
 .../devicetree/bindings/gpio/gpio-aspeed.txt       |  1 -
 .../devicetree/bindings/gpio/gpio-ath79.txt        |  1 -
 .../devicetree/bindings/gpio/gpio-davinci.txt      |  2 --
 .../devicetree/bindings/gpio/gpio-max732x.txt      |  1 -
 .../devicetree/bindings/gpio/gpio-pca953x.txt      |  3 ++
 .../devicetree/bindings/gpio/gpio-pcf857x.txt      |  1 -
 .../devicetree/bindings/gpio/gpio-uniphier.txt     |  1 -
 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |  1 -
 .../devicetree/bindings/gpio/gpio-xilinx.txt       |  2 --
 .../devicetree/bindings/gpio/gpio-xlp.txt          |  1 -
 .../devicetree/bindings/gpio/gpio-zynq.txt         |  1 -
 .../bindings/gpio/nintendo,hollywood-gpio.txt      |  1 -
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |  1 -
 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |  1 -
 Documentation/devicetree/bindings/hsi/omap-ssi.txt |  1 -
 .../devicetree/bindings/i2c/i2c-aspeed.txt         |  3 --
 .../devicetree/bindings/i2c/i2c-brcmstb.txt        |  2 --
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt      |  1 -
 .../devicetree/bindings/i2c/i2c-jz4780.txt         |  4 ---
 Documentation/devicetree/bindings/i2c/i2c-mpc.txt  |  2 --
 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  2 --
 .../devicetree/bindings/i2c/i2c-pca-platform.txt   |  2 --
 Documentation/devicetree/bindings/i2c/i2c-pnx.txt  |  2 --
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt  |  3 --
 .../devicetree/bindings/iio/accel/adxl345.txt      |  2 --
 .../devicetree/bindings/iio/accel/bma180.txt       |  2 --
 .../devicetree/bindings/iio/accel/mma8452.txt      |  2 --
 .../devicetree/bindings/iio/adc/cpcap-adc.txt      |  1 -
 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  1 -
 .../devicetree/bindings/iio/adc/max1027-adc.txt    |  2 --
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  1 -
 .../devicetree/bindings/iio/adc/xilinx-xadc.txt    |  1 -
 .../bindings/iio/chemical/atlas,ec-sm.txt          |  1 -
 .../bindings/iio/chemical/atlas,orp-sm.txt         |  1 -
 .../bindings/iio/chemical/atlas,ph-sm.txt          |  1 -
 .../bindings/iio/gyroscope/invensense,mpu3050.txt  |  1 -
 .../devicetree/bindings/iio/health/afe4403.txt     |  1 -
 .../devicetree/bindings/iio/health/afe4404.txt     |  1 -
 .../devicetree/bindings/iio/health/max30100.txt    |  1 -
 .../devicetree/bindings/iio/health/max30102.txt    |  1 -
 .../devicetree/bindings/iio/humidity/hts221.txt    |  1 -
 .../devicetree/bindings/iio/imu/bmi160.txt         |  1 -
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  1 -
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |  1 -
 .../devicetree/bindings/iio/light/apds9300.txt     |  1 -
 .../devicetree/bindings/iio/light/apds9960.txt     |  1 -
 .../devicetree/bindings/iio/light/isl29018.txt     |  1 -
 .../devicetree/bindings/iio/light/opt3001.txt      |  1 -
 .../devicetree/bindings/iio/light/tsl2583.txt      |  1 -
 .../devicetree/bindings/iio/light/uvis25.txt       |  1 -
 .../bindings/iio/magnetometer/bmc150_magn.txt      |  1 -
 .../devicetree/bindings/iio/pressure/bmp085.txt    |  1 -
 .../devicetree/bindings/iio/pressure/zpa2326.txt   |  2 --
 .../devicetree/bindings/iio/proximity/as3935.txt   |  1 -
 .../devicetree/bindings/iio/proximity/sx9500.txt   |  1 -
 .../devicetree/bindings/iio/sensorhub.txt          |  1 -
 .../devicetree/bindings/iio/temperature/tmp007.txt |  2 --
 .../bindings/infiniband/hisilicon-hns-roce.txt     |  1 -
 .../devicetree/bindings/input/cypress,cyapa.txt    |  2 --
 .../bindings/input/cypress,tm2-touchkey.txt        |  2 --
 .../devicetree/bindings/input/e3x0-button.txt      |  2 --
 .../devicetree/bindings/input/elan_i2c.txt         |  2 --
 .../devicetree/bindings/input/elants_i2c.txt       |  2 --
 .../devicetree/bindings/input/hid-over-i2c.txt     |  1 -
 .../devicetree/bindings/input/raydium_i2c_ts.txt   |  1 -
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  1 -
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |  1 -
 .../bindings/input/ti,palmas-pwrbutton.txt         |  1 -
 .../bindings/input/touchscreen/ad7879.txt          |  1 -
 .../bindings/input/touchscreen/ads7846.txt         |  1 -
 .../bindings/input/touchscreen/ar1021.txt          |  1 -
 .../bindings/input/touchscreen/chipone_icn8318.txt |  2 --
 .../bindings/input/touchscreen/colibri-vf50-ts.txt |  1 -
 .../bindings/input/touchscreen/cyttsp.txt          |  2 --
 .../bindings/input/touchscreen/edt-ft5x06.txt      |  2 --
 .../bindings/input/touchscreen/egalax-ts.txt       |  1 -
 .../bindings/input/touchscreen/ektf2127.txt        |  2 --
 .../bindings/input/touchscreen/exc3000.txt         |  1 -
 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  1 -
 .../bindings/input/touchscreen/goodix.txt          |  1 -
 .../bindings/input/touchscreen/hideep.txt          |  1 -
 .../bindings/input/touchscreen/max11801-ts.txt     |  1 -
 .../bindings/input/touchscreen/melfas_mip4.txt     |  1 -
 .../bindings/input/touchscreen/samsung,s6sy761.txt |  2 --
 .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 --
 .../bindings/input/touchscreen/sis_i2c.txt         |  2 --
 .../bindings/input/touchscreen/st,stmfts.txt       |  2 --
 .../bindings/input/touchscreen/sx8654.txt          |  1 -
 .../bindings/input/touchscreen/tsc2007.txt         |  2 --
 .../bindings/input/touchscreen/zet6223.txt         |  2 --
 .../interrupt-controller/abilis,tb10x-ictl.txt     |  1 -
 .../interrupt-controller/al,alpine-msix.txt        |  1 -
 .../interrupt-controller/allwinner,sunxi-nmi.txt   |  1 -
 .../amlogic,meson-gpio-intc.txt                    |  3 --
 .../bindings/interrupt-controller/atmel,aic.txt    |  2 --
 .../brcm,bcm2835-armctrl-ic.txt                    |  2 --
 .../interrupt-controller/brcm,bcm3380-l2-intc.txt  |  2 --
 .../interrupt-controller/brcm,bcm6345-l1-intc.txt  |  2 --
 .../interrupt-controller/brcm,bcm7038-l1-intc.txt  |  2 --
 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  2 --
 .../bindings/interrupt-controller/brcm,l2-intc.txt |  2 --
 .../interrupt-controller/fsl,ls-scfg-msi.txt       |  3 --
 .../interrupt-controller/hisilicon,mbigen-v2.txt   |  2 --
 .../bindings/interrupt-controller/ingenic,intc.txt |  1 -
 .../marvell,odmi-controller.txt                    |  2 --
 .../interrupt-controller/mediatek,cirq.txt         |  2 --
 .../interrupt-controller/mediatek,sysirq.txt       |  2 --
 .../interrupt-controller/mscc,ocelot-icpu-intr.txt |  1 -
 .../interrupt-controller/nvidia,tegra20-ictlr.txt  |  2 --
 .../interrupt-controller/nxp,lpc3220-mic.txt       |  2 --
 .../interrupt-controller/qca,ath79-misc-intc.txt   |  1 -
 .../bindings/interrupt-controller/qcom,pdc.txt     |  6 ----
 .../samsung,exynos4210-combiner.txt                |  2 --
 .../interrupt-controller/sigma,smp8642-intc.txt    |  1 -
 .../interrupt-controller/snps,archs-idu-intc.txt   |  1 -
 .../interrupt-controller/snps,dw-apb-ictl.txt      |  1 -
 .../socionext,synquacer-exiu.txt                   |  1 -
 .../interrupt-controller/st,spear3xx-shirq.txt     |  4 ---
 .../interrupt-controller/technologic,ts4800.txt    |  2 --
 .../interrupt-controller/ti,c64x+megamod-pic.txt   |  1 -
 .../interrupt-controller/ti,omap4-wugen-mpu        |  2 --
 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  1 -
 .../devicetree/bindings/mailbox/altera-mailbox.txt |  1 -
 .../devicetree/bindings/media/i2c/tc358743.txt     |  2 +-
 .../devicetree/bindings/media/sh_mobile_ceu.txt    |  1 -
 Documentation/devicetree/bindings/mfd/ac100.txt    |  4 ---
 .../devicetree/bindings/mfd/altera-a10sr.txt       |  1 -
 Documentation/devicetree/bindings/mfd/arizona.txt  |  1 -
 Documentation/devicetree/bindings/mfd/axp20x.txt   |  1 -
 .../devicetree/bindings/mfd/bd9571mwv.txt          |  1 -
 Documentation/devicetree/bindings/mfd/bfticu.txt   |  1 -
 Documentation/devicetree/bindings/mfd/da9055.txt   |  2 --
 Documentation/devicetree/bindings/mfd/da9062.txt   |  2 --
 Documentation/devicetree/bindings/mfd/da9063.txt   |  2 --
 Documentation/devicetree/bindings/mfd/da9150.txt   |  2 --
 Documentation/devicetree/bindings/mfd/max14577.txt |  1 -
 Documentation/devicetree/bindings/mfd/max77686.txt |  1 -
 Documentation/devicetree/bindings/mfd/max77693.txt |  1 -
 Documentation/devicetree/bindings/mfd/max77802.txt |  1 -
 Documentation/devicetree/bindings/mfd/max8998.txt  |  2 --
 .../devicetree/bindings/mfd/motorola-cpcap.txt     |  1 -
 Documentation/devicetree/bindings/mfd/palmas.txt   |  1 -
 Documentation/devicetree/bindings/mfd/retu.txt     |  1 -
 Documentation/devicetree/bindings/mfd/rk808.txt    |  1 -
 .../devicetree/bindings/mfd/samsung,sec-core.txt   |  2 --
 Documentation/devicetree/bindings/mfd/stmpe.txt    |  1 -
 Documentation/devicetree/bindings/mfd/tc3589x.txt  |  1 -
 Documentation/devicetree/bindings/mfd/tps65086.txt |  1 -
 Documentation/devicetree/bindings/mfd/tps65912.txt |  1 -
 .../devicetree/bindings/mfd/twl-familly.txt        |  1 -
 Documentation/devicetree/bindings/mfd/twl6040.txt  |  1 -
 Documentation/devicetree/bindings/mfd/wm831x.txt   |  1 -
 .../devicetree/bindings/mips/cavium/cib.txt        |  2 --
 .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 ++++++++++++++++++=
++++
 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  2 --
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  1 -
 .../devicetree/bindings/mmc/mmc-spi-slot.txt       |  2 --
 .../devicetree/bindings/mtd/brcm,brcmnand.txt      |  1 -
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  1 -
 .../devicetree/bindings/mtd/spear_smi.txt          |  2 --
 Documentation/devicetree/bindings/net/amd-xgbe.txt |  2 --
 Documentation/devicetree/bindings/net/btusb.txt    |  1 -
 .../devicetree/bindings/net/can/holt_hi311x.txt    |  1 -
 .../bindings/net/can/microchip,mcp251x.txt         |  1 -
 .../devicetree/bindings/net/can/xilinx_can.txt     |  1 -
 Documentation/devicetree/bindings/net/cpsw.txt     |  1 -
 .../devicetree/bindings/net/davicom-dm9000.txt     |  1 -
 .../devicetree/bindings/net/dsa/marvell.txt        |  1 -
 .../devicetree/bindings/net/hisilicon-hns-dsaf.txt |  1 -
 Documentation/devicetree/bindings/net/ibm,emac.txt |  1 -
 .../devicetree/bindings/net/marvell-bt-8xxx.txt    |  1 -
 .../bindings/net/mediatek,mt7620-gsw.txt           |  2 --
 .../devicetree/bindings/net/mediatek-net.txt       |  3 --
 .../devicetree/bindings/net/microchip,enc28j60.txt |  3 --
 .../devicetree/bindings/net/nfc/nxp-nci.txt        |  1 -
 .../devicetree/bindings/net/nfc/pn533-i2c.txt      |  1 -
 .../devicetree/bindings/net/nfc/pn544.txt          |  1 -
 .../devicetree/bindings/net/nfc/s3fwrn5.txt        |  1 -
 .../devicetree/bindings/net/nfc/st-nci-i2c.txt     |  1 -
 .../devicetree/bindings/net/nfc/st-nci-spi.txt     |  1 -
 .../devicetree/bindings/net/nfc/st21nfca.txt       |  2 --
 .../devicetree/bindings/net/nfc/st95hf.txt         |  3 --
 .../devicetree/bindings/net/nfc/trf7970a.txt       |  1 -
 Documentation/devicetree/bindings/net/phy.txt      |  2 --
 .../devicetree/bindings/net/qca,qca7000.txt        |  1 -
 .../devicetree/bindings/net/ralink,rt2880-net.txt  |  2 --
 .../devicetree/bindings/net/ralink,rt3050-esw.txt  |  2 --
 .../devicetree/bindings/net/renesas,ravb.txt       |  2 --
 .../devicetree/bindings/net/samsung-sxgbe.txt      |  2 --
 Documentation/devicetree/bindings/net/sh_eth.txt   |  2 --
 .../bindings/net/snps,dwc-qos-ethernet.txt         |  2 --
 Documentation/devicetree/bindings/net/stmmac.txt   |  2 --
 .../bindings/net/wireless/brcm,bcm43xx-fmac.txt    |  2 --
 .../bindings/net/wireless/marvell-8xxx.txt         |  1 -
 .../devicetree/bindings/net/wireless/ti,wl1251.txt |  2 --
 .../bindings/net/wireless/ti,wlcore,spi.txt        |  4 +--
 .../devicetree/bindings/net/wireless/ti,wlcore.txt |  2 --
 .../devicetree/bindings/pci/altera-pcie-msi.txt    |  1 -
 .../devicetree/bindings/pci/altera-pcie.txt        |  1 -
 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  1 -
 .../devicetree/bindings/pci/faraday,ftpci100.txt   |  1 -
 .../devicetree/bindings/pci/mobiveil-pcie.txt      |  3 --
 .../devicetree/bindings/pci/pci-keystone.txt       |  3 --
 .../devicetree/bindings/pci/ralink,rt3883-pci.txt  |  3 --
 .../bindings/pinctrl/nvidia,tegra124-pinmux.txt    |  2 +-
 .../bindings/pinctrl/nvidia,tegra210-pinmux.txt    |  2 +-
 .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt |  2 --
 .../devicetree/bindings/pinctrl/pinctrl-sx150x.txt |  2 --
 .../bindings/pinctrl/samsung-pinctrl.txt           |  6 ----
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |  2 --
 .../bindings/power/supply/act8945a-charger.txt     |  2 --
 .../devicetree/bindings/power/supply/bq24257.txt   |  2 --
 .../bindings/power/supply/lp8727_charger.txt       |  1 -
 .../bindings/power/supply/maxim,max14656.txt       |  1 -
 .../bindings/power/supply/rt9455_charger.txt       |  2 --
 .../bindings/power/supply/sbs_sbs-charger.txt      |  2 --
 .../devicetree/bindings/powerpc/4xx/akebono.txt    |  2 --
 .../devicetree/bindings/powerpc/4xx/hsta.txt       |  1 -
 .../bindings/powerpc/4xx/ppc440spe-adma.txt        |  2 --
 .../devicetree/bindings/powerpc/fsl/dcsr.txt       |  7 -----
 .../devicetree/bindings/powerpc/fsl/diu.txt        |  2 --
 .../devicetree/bindings/powerpc/fsl/dma.txt        |  4 ---
 .../devicetree/bindings/powerpc/fsl/ecm.txt        |  4 ---
 .../devicetree/bindings/powerpc/fsl/mcm.txt        |  4 ---
 .../bindings/powerpc/fsl/mpc5121-psc.txt           |  4 ---
 .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |  5 ----
 .../devicetree/bindings/powerpc/fsl/pamu.txt       |  2 --
 .../devicetree/bindings/powerpc/nintendo/wii.txt   |  1 -
 .../bindings/regulator/max8997-regulator.txt       |  2 --
 .../devicetree/bindings/regulator/palmas-pmic.txt  |  1 -
 .../bindings/remoteproc/ti,davinci-rproc.txt       |  6 ----
 .../bindings/remoteproc/ti,keystone-rproc.txt      |  6 ----
 .../bindings/rtc/brcm,brcmstb-waketimer.txt        |  2 --
 .../devicetree/bindings/rtc/isil,isl12057.txt      |  3 --
 Documentation/devicetree/bindings/rtc/rtc-cmos.txt |  1 -
 .../devicetree/bindings/rtc/rtc-ds1307.txt         |  1 -
 .../devicetree/bindings/rtc/rtc-m41t80.txt         |  1 -
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  1 -
 .../devicetree/bindings/rtc/rtc-palmas.txt         |  1 -
 .../devicetree/bindings/rtc/spear-rtc.txt          |  2 --
 .../devicetree/bindings/rtc/sprd,sc27xx-rtc.txt    |  1 -
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  2 --
 .../bindings/rtc/stericsson,coh901331.txt          |  1 -
 .../bindings/security/tpm/st33zp24-i2c.txt         |  1 -
 .../bindings/security/tpm/st33zp24-spi.txt         |  1 -
 .../bindings/security/tpm/tpm_tis_mmio.txt         |  2 +-
 .../devicetree/bindings/serial/maxim,max310x.txt   |  2 --
 .../devicetree/bindings/serial/nxp,sc16is7xx.txt   |  4 ---
 .../devicetree/bindings/serial/qca,ar9330-uart.txt |  3 --
 .../devicetree/bindings/soc/fsl/cpm_qe/gpio.txt    |  1 -
 .../devicetree/bindings/soc/fsl/cpm_qe/qe/ucc.txt  |  2 --
 .../devicetree/bindings/soc/fsl/cpm_qe/qe/usb.txt  |  1 -
 .../devicetree/bindings/sound/cs35l33.txt          |  2 --
 .../devicetree/bindings/sound/cs35l34.txt          |  2 --
 .../devicetree/bindings/sound/cs35l35.txt          |  2 --
 .../devicetree/bindings/sound/cs42l42.txt          |  5 +---
 Documentation/devicetree/bindings/sound/da7218.txt |  2 --
 Documentation/devicetree/bindings/sound/da7219.txt |  2 --
 .../devicetree/bindings/sound/fsl,ssi.txt          |  2 --
 .../devicetree/bindings/sound/omap-dmic.txt        |  1 -
 .../devicetree/bindings/sound/omap-mcbsp.txt       |  1 -
 .../devicetree/bindings/sound/omap-mcpdm.txt       |  1 -
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  1 -
 Documentation/devicetree/bindings/sound/rt5514.txt |  1 -
 .../devicetree/bindings/sound/ts3a227e.txt         |  1 -
 .../devicetree/bindings/sound/ux500-msp.txt        |  1 -
 Documentation/devicetree/bindings/sound/wm8994.txt |  7 ++++-
 Documentation/devicetree/bindings/spi/fsl-spi.txt  |  2 --
 Documentation/devicetree/bindings/spi/sh-hspi.txt  |  2 --
 Documentation/devicetree/bindings/spi/sh-msiof.txt |  2 --
 .../devicetree/bindings/spi/spi-cadence.txt        |  1 -
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      |  1 -
 Documentation/devicetree/bindings/spi/spi-rspi.txt |  2 --
 .../devicetree/bindings/spi/spi-xilinx.txt         |  1 -
 Documentation/devicetree/bindings/spi/spi-xlp.txt  |  1 -
 .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    |  1 -
 Documentation/devicetree/bindings/sram/sram.txt    |  2 ++
 .../bindings/staging/iio/adc/spear-adc.txt         |  2 --
 .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  1 -
 .../devicetree/bindings/thermal/exynos-thermal.txt |  1 -
 .../devicetree/bindings/timer/altr,timer-1.0.txt   |  1 -
 .../devicetree/bindings/timer/fsl,gtm.txt          |  1 -
 .../bindings/timer/marvell,orion-timer.txt         |  1 -
 .../devicetree/bindings/timer/snps,arc-timer.txt   |  4 ---
 .../devicetree/bindings/timer/st,spear-timer.txt   |  2 --
 .../devicetree/bindings/timer/ti,c64x+timer64.txt  |  1 -
 Documentation/devicetree/bindings/usb/fsl-usb.txt  |  2 --
 .../devicetree/bindings/usb/maxim,max3421.txt      |  3 --
 .../devicetree/bindings/usb/richtek,rt1711h.txt    |  2 --
 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  3 +-
 .../devicetree/bindings/usb/samsung-hsotg.txt      |  2 --
 .../devicetree/bindings/usb/spear-usb.txt          |  4 ---
 .../devicetree/bindings/vendor-prefixes.txt        |  3 ++
 .../devicetree/bindings/watchdog/cadence-wdt.txt   |  1 -
 .../devicetree/bindings/watchdog/rt2880-wdt.txt    |  1 -
 Documentation/devicetree/bindings/xilinx.txt       |  2 +-
 .../devicetree/bindings/xillybus/xillybus.txt      |  2 --
 .../devicetree/dynamic-resolution-notes.txt        |  5 ++--
 drivers/of/address.c                               |  6 ++--
 drivers/of/fdt.c                                   |  9 +-----
 342 files changed, 70 insertions(+), 605 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed,cvic.txt
