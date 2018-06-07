Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IULMERybGFuXAgAAmS7hNA
	; Thu, 07 Jun 2018 02:40:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 26F32608C1; Thu,  7 Jun 2018 02:40:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiDjggGE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 44D3A6074D;
	Thu,  7 Jun 2018 02:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44D3A6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932254AbeFGCkZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 22:40:25 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45669 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753163AbeFGCkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 22:40:23 -0400
Received: by mail-io0-f196.google.com with SMTP id l25-v6so10014135ioh.12;
        Wed, 06 Jun 2018 19:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rAkzIy056bJNYIiFEMxgs4ieiYfVWfi/bvVp5p4S/q4=;
        b=SiDjggGEQnsVcxdj/i+A9mJhdkPzl+e5Mx5Sl0NTA2sKPwXs/UX0RQsF/AZ3cfspN7
         CI8uOqn4/d/5B9CFGQw43UtO9i9MX6BvFrfZSFBrQ5CEa/rh+thIkuHdbyKsZ0wr5PNR
         p0eEr7zlJbBY4SIL+H1FhPHxeRr3xVJFE2SLkmcq/v3HQ6HQpw81Xd6goK58GiA52ay1
         /VqetEe71VLueug5Q5V3zc+5g3DDITv/avZtMUv0mzNcHvh//dq/Q8D8kp1W7Z5rtbnl
         L4KIv4HOe5E+lnwESZ5q0jO6Whb3/xSzK0fc+RKcTESH3wj4A/oarJXWzofHueiPImUf
         Hd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=rAkzIy056bJNYIiFEMxgs4ieiYfVWfi/bvVp5p4S/q4=;
        b=KmfP0svj5NFuhr2aiHFyxPxcA6N8FVdWTvo+78bDf6xwuHvUGX/h1ANaYo7YYfezvc
         CLX6mYttrurNbYkqKzwndtwvorAeaGMt0OOtKA+5sp9Mad5d/Iwqh+iUUarLUr5vdY15
         FgxdTooBA673UaxyeF5oafZS1SAceKDYzf5x6JHyPrdyY4dEn8lgIECgjeBJWxEQKnYu
         jQFZ6ttAn6lJ/21u7MFm0fHkDVkNhQv3wGWZZ+4OsrEuW+ZQVjs7dfnTOmuK3cDAYR2O
         HGm2/w9t8iEcTjzHDX9vLMLkk/vfUfn2mpIYIJ2FtQx9Du0pMM6Y/4r5DGcXhoEmRN4r
         Mqhg==
X-Gm-Message-State: APt69E36yPTyxcY+x/+tJy20H7yFCAVK5it3WleoH6rJE2cWjlJtgCfU
        fCST2zYT3Ezmqb/BYRaYn6Y3FJGaEJOuNebsxdoA9xU=
X-Google-Smtp-Source: ADUXVKK7vMBNw9wwAbRJNgI1ucLpiXJlifmB2fQgpgChY+euytes9qoe417gtEus7SgAqeup/Qx3zAf2IX9ERGS9uVs=
X-Received: by 2002:a6b:452:: with SMTP id 79-v6mr30602ioe.50.1528339222419;
 Wed, 06 Jun 2018 19:40:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5505:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 19:40:01 -0700 (PDT)
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 6 Jun 2018 21:40:01 -0500
Message-ID: <CAL_JsqJqTQLMMO5cKp9C2hPQHfUfcRJMvEO3gg=uyLXcnWFF7g@mail.gmail.com>
Subject: [GIT PULL] DeviceTree updates for 4.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull DT updates for 4.18. Details below.

Rob

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338=
:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-for-4.18

for you to fetch changes up to 44acf10587907ff77c28fd97906220b2d8eb4f05:

  dt-bindings: submitting-patches: add guidance on patch content and
subject (2018-06-05 16:37:47 -0600)

----------------------------------------------------------------
DeviceTree updates for v4.18:

- Sync dtc with upstream version v1.4.6-21-g84e414b0b5bc. This adds new
  warnings which are either fixed or disabled by default (enabled with
  W=3D1).

- Validate an untrusted offset in DT overlay function
  update_usages_of_a_phandle_reference

- Fix a use after free error of_platform_device_destroy

- Fix an off by 1 string errors in unittest

- Avoid creating a struct device for OPP nodes

- Update DT specific submitting-patches.txt with patch content and
  subject requirements.

- Move some bindings to their proper subsystem locations

- Add vendor prefixes for Kaohsiung, SiFive, Avnet, Wi2Wi, Logic PD, and
  ArcherMind

- Add documentation for "no-gpio-delays" property in FSI bus GPIO master

- Add compatible for r8a77990 SoC ravb ethernet block

- More wack-a-mole removal of 'status' property in examples

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      dt-bindings: fsi-master-gpio: Document "no-gpio-delays" property

Frank Rowand (2):
      MAINTAINERS: add keyword for devicetree overlay notifiers
      of: overlay: validate offset from property fixups

Geert Uytterhoeven (3):
      dt-bindings: meson-uart: DT fix s/clocks-names/clock-names/
      dt-bindings: mvebu-uart: DT fix s/interrupts-names/interrupt-names/
      dt-bindings: panel: lvds: Fix path to display timing bindings

H. Nikolaus Schaller (1):
      dt-bindings: define vendor prefix for Wi2Wi, Inc.

Jacopo Mondi (3):
      dt-bindings: net: ravb: Add support for r8a77965 SoC
      dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
      dt-bindings: dmaengine: rcar-dmac: document R8A77965 support

Jan Kiszka (1):
      of: overlay: Stop leaking resources on overlay removal

Lukasz Majewski (2):
      doc: Add vendor prefix for Kieback & Peter GmbH
      doc: Add vendor prefix for Kaohsiung

Manivannan Sadhasivam (1):
      dt-bindings: Add vendor prefix for ArcherMind

Matheus Castello (1):
      dt-bindings: pinctrl: sunxi: Fix reference to driver

Michal Simek (1):
      dt-bindings: Add vendor prefix for Avnet, Inc.

Niklas S=C3=B6derlund (1):
      dt-bindings: thermal: rcar-gen3-thermal: update register size in exam=
ple

Rob Herring (12):
      of/numa: drop export of of_node_to_nid
      dt-bindings: more status property removal from examples
      dtc: checks: drop warning for missing PCI bridge bus-range
      dt-bindings: move various timer bindings to timer/ directory
      dt-bindings: move various RNG bindings to rng/ directory
      dt-bindings: powerpc/4xx: move 4xx NDFC and EMAC bindings to
subsystem directories
      dt-bindings: exynos: move ADC binding to iio/adc/ directory
      Merge tag 'devicetree-fixes-for-4.17' into dt/next to pick-up fixes
      scripts/dtc: Update to upstream version v1.4.6-21-g84e414b0b5bc
      kbuild: disable new dtc graph and unit-address warnings
      drm: rcar-du: disable dtc graph-endpoint warnings on DT overlays
      dt-bindings: submitting-patches: add guidance on patch content and su=
bject

Srinivas Kandagatla (1):
      of: platform: stop accessing invalid dev in of_platform_device_destro=
y

Stefan M Schaeckeler (1):
      of: unittest: for strings, account for trailing \0 in property
length field

Thierry Reding (1):
      dt-bindings: Relocate Tegra20 memory controller bindings

Viresh Kumar (1):
      of: Don't create device for OPP tables

Vladimir Zapolskiy (1):
      dt-bindings: Add vendor prefix for Logic PD

Wesley W. Terpstra (1):
      dt-bindings: Add "sifive" vendor prefix

Yoshihiro Shimoda (1):
      dt-bindings: net: ravb: Add support for r8a77990 SoC

 .../devicetree/bindings/arm/ux500/boards.txt       |   2 +-
 .../bindings/display/panel/panel-common.txt        |   2 +-
 Documentation/devicetree/bindings/dma/k3dma.txt    |   1 -
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 Documentation/devicetree/bindings/dma/ti-edma.txt  |   1 -
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    |   4 +
 .../adc/samsung,exynos-adc.txt}                    |   0
 .../nvidia,tegra20-mc.txt                          |   0
 .../devicetree/bindings/mips/lantiq/rcu.txt        |   2 -
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   4 -
 .../{powerpc/4xx/ndfc.txt =3D> mtd/ibm,ndfc.txt}     |   0
 Documentation/devicetree/bindings/mtd/mtk-nand.txt |   4 -
 .../{powerpc/4xx/emac.txt =3D> net/ibm,emac.txt}     |   0
 .../devicetree/bindings/net/renesas,ravb.txt       |   2 +
 .../devicetree/bindings/pci/xgene-pci.txt          |   7 -
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   6 +-
 Documentation/devicetree/bindings/pps/pps-gpio.txt |   1 -
 .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |   2 +-
 .../samsung,exynos4-rng.txt}                       |   0
 .../bindings/{ =3D> rng}/sparc_sun_oracle_rng.txt    |   0
 .../bindings/serial/amlogic,meson-uart.txt         |   2 +-
 .../devicetree/bindings/serial/mvebu-uart.txt      |   2 +-
 .../bindings/serial/renesas,sci-serial.txt         |   2 +
 .../devicetree/bindings/submitting-patches.txt     |   9 +-
 .../bindings/thermal/rcar-gen3-thermal.txt         |   6 +-
 .../{nios2/timer.txt =3D> timer/altr,timer-1.0.txt}  |   0
 .../arch_timer.txt =3D> timer/arm,arch_timer.txt}    |   0
 .../arm,armv7m-systick.txt}                        |   0
 .../arm,global_timer.txt}                          |   0
 .../bindings/{arm/twd.txt =3D> timer/arm,twd.txt}    |   0
 .../{powerpc/fsl/gtm.txt =3D> timer/fsl,gtm.txt}     |   0
 .../mrvl/timer.txt =3D> timer/mrvl,mmp-timer.txt}    |   0
 .../msm/timer.txt =3D> timer/qcom,msm-timer.txt}     |   0
 .../spear-timer.txt =3D> timer/st,spear-timer.txt}   |   0
 .../{c6x/timer64.txt =3D> timer/ti,c64x+timer64.txt} |   0
 .../{arm/omap/timer.txt =3D> timer/ti,timer.txt}     |   0
 .../{arm/vt8500 =3D> timer}/via,vt8500-timer.txt     |   0
 .../devicetree/bindings/vendor-prefixes.txt        |   7 +
 Documentation/devicetree/overlay-notes.txt         |   8 +
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/rcar-du/Makefile                   |   7 +
 drivers/of/of_numa.c                               |   1 -
 drivers/of/overlay.c                               |  30 ++-
 drivers/of/platform.c                              |  16 +-
 drivers/of/resolver.c                              |   5 +
 drivers/of/unittest.c                              |   8 +-
 scripts/Makefile.lib                               |   3 +
 scripts/dtc/checks.c                               | 204 +++++++++++++++++=
+++-
 scripts/dtc/dtc-lexer.l                            |   7 +
 scripts/dtc/dtc-parser.y                           |  39 ++--
 scripts/dtc/dtc.h                                  |   4 +
 scripts/dtc/livetree.c                             |  26 ++-
 scripts/dtc/version_gen.h                          |   2 +-
 53 files changed, 362 insertions(+), 67 deletions(-)
 rename Documentation/devicetree/bindings/{arm/samsung/exynos-adc.txt
=3D> iio/adc/samsung,exynos-adc.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/tegra =3D>
memory-controllers}/nvidia,tegra20-mc.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc/4xx/ndfc.txt =3D>
mtd/ibm,ndfc.txt} (100%)
 rename Documentation/devicetree/bindings/{powerpc/4xx/emac.txt =3D>
net/ibm,emac.txt} (100%)
 rename Documentation/devicetree/bindings/{crypto/samsung,exynos-rng4.txt
=3D> rng/samsung,exynos4-rng.txt} (100%)
 rename Documentation/devicetree/bindings/{ =3D>
rng}/sparc_sun_oracle_rng.txt (100%)
 rename Documentation/devicetree/bindings/{nios2/timer.txt =3D>
timer/altr,timer-1.0.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/arch_timer.txt =3D>
timer/arm,arch_timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/armv7m_systick.txt =3D>
timer/arm,armv7m-systick.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/global_timer.txt =3D>
timer/arm,global_timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/twd.txt =3D>
timer/arm,twd.txt} (100%)
 rename Documentation/devicetree/bindings/{powerpc/fsl/gtm.txt =3D>
timer/fsl,gtm.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/mrvl/timer.txt =3D>
timer/mrvl,mmp-timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/msm/timer.txt =3D>
timer/qcom,msm-timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/spear-timer.txt =3D>
timer/st,spear-timer.txt} (100%)
 rename Documentation/devicetree/bindings/{c6x/timer64.txt =3D>
timer/ti,c64x+timer64.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/omap/timer.txt =3D>
timer/ti,timer.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/vt8500 =3D>
timer}/via,vt8500-timer.txt (100%)
