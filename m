Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BC4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534E720658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ7sq/3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534E720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeH3TsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36105 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeH3TsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so2527754wmj.1;
        Thu, 30 Aug 2018 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Pw8jXa3quPSpYkMdowjBJQRc76LDW18F+2oJE8DWa4=;
        b=OQ7sq/3+G1iqgR6yw935vAHV2UF1OWx92TxgxgDj9hzKR9or+/2CQVv/LPMiLq5DZU
         bhvhU4xQahud7qv65QeJGpMhuCqQox2sEnspWiRQGaAemQ7aj94fIIRnHMT53FMUTcc5
         u2HSGRITXXGE93I/iwLRps/BYGjjMg7Eba0nZgi9NNDb6yxfac9UzhWL9CW8Tg1aWMfN
         jkbrNjDlyaSG7ydaG8gol0qvCIs5UIqJQ0uzNOQPEaqi0fpaCrYPnylY+2/vFlN+NPk3
         8A64zsnZmi+cBXh5hXLWwEKESojxnd4fA5OYHM+lmRLpQNz155Nenq87HQRRi+W86UVR
         59+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Pw8jXa3quPSpYkMdowjBJQRc76LDW18F+2oJE8DWa4=;
        b=FdL6PuBrMUDzmGNnk0sAjFTTCzccGud+qi66D/B8Oy6iKPPUQNyO56k5m7Q/GMthQm
         fXD6brqbOPiIhcnYbuUt018LcJ6gd4Q+FPABBFIjo4FjRy3GoG7gGekxfP9+Gwx7LtoX
         1NDVmtbwma1w43RrFwMxCb9pexE/ydMyV7Z7ZKAmsRNOCnStTLJQyFBNOZtYf/quC2/b
         e0bKSjYJOOsrwrPFFd/9x9lGjcRQVSu53lGGJLOMXUoTQJuNGfJ9wbEn3R1hkWsIHH7z
         jUD9ZrdraryYJu9HuF2RSghKV/DkT4xkL1JtzMPjU5bdSct0xkkag7kPoueo4HyTnmBK
         Y0Pw==
X-Gm-Message-State: APzg51CknIutHAdweCQdhNkh2OLmC3ty0z7YNPbsMhtdQWcHftA5oyRE
        Jz7v78q1aQyWXsFjs+rzdwE=
X-Google-Smtp-Source: ANB0VdZ8pL+6fOzN0Z8+hI9Bt081tglZ1SLx4eRwW6kGmF9SbDs/HkMLlB6R10Nh1AUi/xdX8LWJVw==
X-Received: by 2002:a1c:91cd:: with SMTP id t196-v6mr1460645wmd.100.1535643919839;
        Thu, 30 Aug 2018 08:45:19 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:19 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 00/30] IIO-based thermal sensor driver for Allwinner H3 and A83T SoC
Date:   Thu, 30 Aug 2018 17:44:48 +0200
Message-Id: <20180830154518.29507-1-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwiner H3 and A83T SoCs have a thermal sensor, which is a large refactored
version of the old Allwinner "GPADC" (although it have already only
thermal part left in A33).

This patch tried to add support for the sensor in H3 and A83T based on

This Patchtseries was in the beginning based on Icenowy Zengs v4 patchseries [1]. Since we decided to merge the mfd driver into the GPADC this changed. So only one patch could be reused.

Patches that adds support for H5, A64, A80 and H6 SoCs are allready prepared,
and will be upstreamed if this patchseries is applied and the testing is done.

Sorry for delaying this.

Regards,
Philipp 

changes since v2:
	* mfd driver is now merged into the gpadc driver
	* complete rework

changes since v1:
	* collecting all acks 
	* rewording commits/fix typos
	* move code in place where it is used
	* fix naming conventions of defines
	* clarify commits
	* update documentation to cover the new nvmem calibraion
	* change nvmem calibration



Icenowy Zheng (1):
  iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain
    A33

Philipp Rossak (29):
  mfd: Makefile: Remove build option for MFD:sun4i-gpadc
  mfd: Kconfig: Remove MFD_SUN4I_GPADC config option
  iio: adc: Remove ID table
  iio: adc: Kconfig: Update Kconfig to new build options
  iio: adc: move SUN4I_GPADC_CHANNEL define to header file
  iio: adc: remove ofnode options
  iio: adc: remove mfd_probe & sunwi_irq_init function
  iio: adc: remove hwmon structure
  iio: adc: Threat A33 as thermal sensor and remove non thermal sun4i
    channel
  iio: adc: rework irq and adc_channel handling
  iio: adc: add new compatibles
  mfd: Remove old mfd driver & Move sun4i-gpadc.h to iio/adc/
  arm: config: Enable SUN4I_GPADC in defconfig
  dt-bindings: update the Allwinner GPADC device tree binding for H3 &
    A83T
  iio: adc: sun4i-gpadc-iio: rework: readout temp_data
  iio: adc: sun4i-gpadc-iio: rework: support clocks and reset
  iio: adc: sun4i-gpadc-iio: rework: support multiple sensors
  iio: adc: sun4i-gpadc-iio: rework: support nvmem calibration data
  iio: adc: sun4i-gpadc-iio: rework: device specific suspend & resume
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  iio: adc: sun4i-gpadc-iio: add support for A83T thermal sensor
  ARM: dts: sunxi-h3-h5: add support for the thermal sensor in H3 and H5
  ARM: dts: sun8i: h3: add support for the thermal sensor in H3
  ARM: dts: sun8i: h3: add thermal zone to H3
  ARM: dts: sun8i: h3: enable H3 sid controller
  ARM: dts: sun8i: h3: use calibration for ths
  ARM: dts: sun8i: a83t: add support for the thermal sensor in A83T
  ARM: dts: sun8i: a83t: add thermal zone to A83T
  ARM: sun8i: a83t: full range OPP tables and CPUfreq

 .../devicetree/bindings/iio/adc/sun4i-gpadc.txt    |  41 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 143 +++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  52 ++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  10 +
 arch/arm/configs/sunxi_defconfig                   |   1 +
 drivers/iio/adc/Kconfig                            |  11 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 617 +++++++++++++--------
 drivers/mfd/Kconfig                                |  17 -
 drivers/mfd/Makefile                               |   1 -
 drivers/mfd/sun4i-gpadc.c                          | 181 ------
 include/linux/{mfd => iio/adc}/sun4i-gpadc.h       |  47 +-
 11 files changed, 681 insertions(+), 440 deletions(-)
 delete mode 100644 drivers/mfd/sun4i-gpadc.c
 rename include/linux/{mfd => iio/adc}/sun4i-gpadc.h (72%)

-- 
2.11.0

