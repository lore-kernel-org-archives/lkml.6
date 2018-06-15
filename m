Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B83C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7061D20864
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZDTMLeWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7061D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756533AbeFOV3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:29:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756266AbeFOV3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oyoiFiW+SvPDYZtqitDeC8ZCu7qpUI0OhBwnJ1EVyMY=; b=ZDTMLeWaiIGalgyVEdWdnaQnD
        Bv/LV70Dy3P2sCOoHGgH8C81y+l+bO7Yu/qToKJo69r5Zx5QwJ+Q+/Umi7KEqrmP8RyfAi6+lhNTN
        er3x1yvSwegxsBkCW4+DqyGUzCqSr/S3udAf+VtDC2guP9N84ewFcH0o9qIlEJsHBWFsKDOsLkbQf
        5gGzvgxCgNBGRHzaGMpK8pTr80gZz1mLM7SEJ0rCPMNM7anecWHEnXxSs1jC75kppsW+rqTXaku3/
        CQy4jk0j1+A7CZVbRnCSvY7j81yV9j4mb+cv0u1tjSio+E5RwfMZm2zntUymCOo3JeGZS0ZQVtUiH
        4xaQ+XLNw==;
Received: from 177.41.114.220.dynamic.adsl.gvt.net.br ([177.41.114.220] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTwHw-0002XH-7z; Fri, 15 Jun 2018 21:29:44 +0000
Date:   Fri, 15 Jun 2018 18:29:40 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [GIT PULL for v4.18-rc1] fix broken links for Documentation/* files
Message-ID: <20180615182940.70113609@coco.lan>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Exceptionally, I'm sending you a pull request mainly related to
documentation. Jonathan requested me to send those directly to you 
as he's "fighting a few real-world complications at the moment, 
and barely have time to breathe...".

So, please pull from:

  git://linuxtv.org/mchehab/experimental.git tags/docs-broken-links

It solves a series of broken links for files under Documentation,
and improves a script meant to detect such broken links
(scripts/documentation-file-ref-check).

The changes on this series are:

- can.rst: fix a footnote reference;
- crypto_engine.rst: Fix two parsing warnings;
- Fix a lot of broken references to Documentation/*;
- Improves the scripts/documentation-file-ref-check script,
  in order to help detecting/fixing broken references,
  preventing false-positives.

(I might have created a new branch or tree at kernel.org, but I'm
preparing to go to Japan next week, so, it sounded easier to just
point to the tree where I store my development stuff).

Thanks,
Mauro

The following changes since commit 4c5e8fc62d6a63065eeae80808c498d1dcfea4f4:

  Merge tag 'linux-kselftest-4.18-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2018-06-15 17:26:29 +0900)

are available in the Git repository at:

  git://linuxtv.org/mchehab/experimental.git tags/docs-broken-links

for you to fetch changes up to 44348e8ac145d78171c5a6f4a8bdb01b70969fc2:

  fix a series of Documentation/ broken file name references (2018-06-15 18:10:01 -0300)

----------------------------------------------------------------
Solve a series of broken links for files under Documentation:

- can.rst: fix a footnote reference;
- crypto_engine.rst: Fix two parsing warnings;
- Fix a lot of broken references to Documentation/*;
- Improves the scripts/documentation-file-ref-check script,
  in order to help detecting/fixing broken references,
  preventing false-positives.

After this patch series, only 33 broken references to doc files are
detected by scripts/documentation-file-ref-check.

----------------------------------------------------------------
Mauro Carvalho Chehab (26):
      docs: can.rst: fix a footnote reference
      docs: crypto_engine.rst: Fix two parse warnings
      arch/*: Kconfig: fix documentation for NMI watchdog
      docs: fix broken references with multiple hints
      docs: Fix some broken references
      media: dvb: fix location of get_dvb_firmware script
      media: dvb: point to the location of the old README.dvb-usb file
      media: v4l: fix broken video4linux docs locations
      media: max2175: fix location of driver's companion documentation
      scripts/documentation-file-ref-check: fix help message
      scripts/documentation-file-ref-check: accept more wildcards at filenames
      scripts/documentation-file-ref-check: add a fix logic for DT
      scripts/documentation-file-ref-check: hint: dash or underline
      scripts/documentation-file-ref-check: get rid of false-positives
      scripts/documentation-file-ref-check: check tools/*/Documentation
      docs: Fix more broken references
      bindings: nvmem/zii: Fix location of nvmem.txt
      kernel-parameters.txt: fix pointers to sound parameters
      MAINTAINERS: fix location of some display DT bindings
      MAINTAINERS: fix location of DT npcm files
      devicetree: fix some bindings file names
      devicetree: fix name of pinctrl-bindings.txt
      devicetree: fix a series of wrong file references
      ABI: sysfs-devices-system-cpu: remove a broken reference
      Documentation: rstFlatTable.py: fix a broken reference
      fix a series of Documentation/ broken file name references

 Documentation/ABI/obsolete/sysfs-gpio              |  2 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |  3 --
 Documentation/admin-guide/kernel-parameters.txt    |  9 ++--
 Documentation/crypto/crypto_engine.rst             |  8 +--
 .../devicetree/bindings/clock/st/st,clkgen.txt     |  8 +--
 .../devicetree/bindings/clock/ti/gate.txt          |  2 +-
 .../devicetree/bindings/clock/ti/interface.txt     |  2 +-
 .../bindings/cpufreq/cpufreq-mediatek.txt          |  2 +-
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     |  2 +-
 .../devicetree/bindings/display/bridge/tda998x.txt |  2 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   |  2 +-
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  2 +-
 .../bindings/input/rmi4/rmi_2d_sensor.txt          |  2 +-
 .../devicetree/bindings/input/rotary-encoder.txt   |  2 +-
 .../bindings/media/stih407-c8sectpfe.txt           |  2 +-
 Documentation/devicetree/bindings/mfd/as3722.txt   |  2 +-
 Documentation/devicetree/bindings/mfd/mt6397.txt   |  2 +-
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |  4 +-
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |  2 +-
 .../bindings/mmc/microchip,sdhci-pic32.txt         |  2 +-
 Documentation/devicetree/bindings/mmc/sdhci-st.txt |  2 +-
 Documentation/devicetree/bindings/net/dsa/ksz.txt  |  2 +-
 .../devicetree/bindings/net/dsa/mt7530.txt         |  2 +-
 .../bindings/nvmem/zii,rave-sp-eeprom.txt          |  2 +-
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  2 +-
 .../devicetree/bindings/pci/kirin-pcie.txt         |  2 +-
 .../devicetree/bindings/pci/pci-keystone.txt       |  4 +-
 .../bindings/pinctrl/pinctrl-max77620.txt          |  4 +-
 .../bindings/pinctrl/pinctrl-mcp23s08.txt          |  4 +-
 .../devicetree/bindings/pinctrl/pinctrl-rk805.txt  |  4 +-
 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  2 +-
 .../bindings/power/supply/ab8500/btemp.txt         |  2 +-
 .../bindings/power/supply/ab8500/chargalg.txt      |  2 +-
 .../bindings/power/supply/ab8500/charger.txt       |  2 +-
 .../devicetree/bindings/power/wakeup-source.txt    |  2 +-
 .../bindings/serial/microchip,pic32-uart.txt       |  2 +-
 .../devicetree/bindings/sound/st,stm32-i2s.txt     |  2 +-
 .../devicetree/bindings/sound/st,stm32-sai.txt     |  2 +-
 .../devicetree/bindings/spi/spi-st-ssc.txt         |  2 +-
 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  2 +-
 Documentation/driver-api/gpio/consumer.rst         |  2 +-
 Documentation/hwmon/ina2xx                         |  2 +-
 Documentation/kprobes.txt                          |  4 +-
 Documentation/maintainer/pull-requests.rst         |  2 +-
 Documentation/networking/can.rst                   |  4 +-
 Documentation/sphinx/rstFlatTable.py               |  2 -
 Documentation/trace/coresight.txt                  |  2 +-
 Documentation/trace/events.rst                     |  2 +-
 Documentation/trace/ftrace-uses.rst                |  2 +-
 Documentation/trace/histogram.txt                  |  2 +-
 Documentation/trace/intel_th.rst                   |  2 +-
 Documentation/trace/tracepoint-analysis.rst        |  8 +--
 Documentation/translations/ja_JP/howto.rst         |  4 +-
 Documentation/translations/ko_KR/howto.rst         |  2 +-
 Documentation/translations/zh_CN/SubmittingDrivers |  2 +-
 Documentation/translations/zh_CN/gpio.txt          |  4 +-
 Documentation/translations/zh_CN/io_ordering.txt   |  2 +-
 Documentation/translations/zh_CN/magic-number.txt  |  4 +-
 .../translations/zh_CN/video4linux/omap3isp.txt    |  4 +-
 .../zh_CN/video4linux/v4l2-framework.txt           |  6 +--
 MAINTAINERS                                        | 62 +++++++++++-----------
 arch/Kconfig                                       |  2 +-
 arch/arm/Kconfig                                   |  2 +-
 arch/arm/include/asm/cacheflush.h                  |  2 +-
 arch/arm64/include/asm/cacheflush.h                |  2 +-
 arch/microblaze/include/asm/cacheflush.h           |  2 +-
 arch/parisc/Kconfig                                |  2 +-
 arch/sh/Kconfig                                    |  2 +-
 arch/sparc/Kconfig                                 |  2 +-
 arch/um/Kconfig.um                                 |  2 +-
 arch/unicore32/include/asm/cacheflush.h            |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c              |  2 +-
 arch/xtensa/include/asm/cacheflush.h               |  4 +-
 block/Kconfig                                      |  2 +-
 certs/Kconfig                                      |  2 +-
 crypto/asymmetric_keys/asymmetric_type.c           |  2 +-
 crypto/asymmetric_keys/signature.c                 |  2 +-
 drivers/char/Kconfig                               |  2 +-
 drivers/clk/clk.c                                  |  4 +-
 drivers/clk/ingenic/cgu.h                          |  2 +-
 drivers/dma/dmaengine.c                            |  2 +-
 drivers/gpu/vga/Kconfig                            |  2 +-
 drivers/gpu/vga/vgaarb.c                           |  2 +-
 drivers/hid/usbhid/Kconfig                         |  2 +-
 drivers/input/Kconfig                              |  4 +-
 drivers/input/joystick/Kconfig                     | 14 ++---
 drivers/input/joystick/iforce/Kconfig              |  4 +-
 drivers/input/joystick/walkera0701.c               |  2 +-
 drivers/input/misc/Kconfig                         |  4 +-
 drivers/input/misc/rotary_encoder.c                |  2 +-
 drivers/input/mouse/Kconfig                        |  6 +--
 drivers/input/mouse/alps.c                         |  2 +-
 drivers/input/serio/Kconfig                        |  4 +-
 drivers/input/touchscreen/wm97xx-core.c            |  2 +-
 drivers/lightnvm/pblk-rb.c                         |  2 +-
 drivers/md/bcache/Kconfig                          |  2 +-
 drivers/md/bcache/btree.c                          |  2 +-
 drivers/md/bcache/extents.c                        |  2 +-
 drivers/media/dvb-core/dvb_ringbuffer.c            |  2 +-
 drivers/media/dvb-frontends/Kconfig                | 18 +++----
 drivers/media/dvb-frontends/dib3000.h              |  2 +-
 drivers/media/dvb-frontends/dib3000mb.c            |  2 +-
 drivers/media/dvb-frontends/eds1547.h              |  2 +-
 drivers/media/dvb-frontends/nxt200x.c              |  4 +-
 drivers/media/dvb-frontends/or51211.c              |  2 +-
 drivers/media/dvb-frontends/sp8870.c               |  2 +-
 drivers/media/dvb-frontends/sp887x.c               |  2 +-
 drivers/media/dvb-frontends/tda1004x.c             |  4 +-
 drivers/media/dvb-frontends/tda10071.c             |  2 +-
 drivers/media/dvb-frontends/z0194a.h               |  2 +-
 drivers/media/i2c/max2175.c                        |  6 +--
 drivers/media/pci/bt8xx/Kconfig                    |  2 +-
 drivers/media/pci/cx18/cx18-dvb.c                  |  2 +-
 drivers/media/pci/cx18/cx18-streams.c              |  4 +-
 drivers/media/pci/cx23885/cx23885-cards.c          |  2 +-
 drivers/media/pci/meye/Kconfig                     |  2 +-
 drivers/media/pci/ttpci/Kconfig                    |  2 +-
 drivers/media/platform/pxa_camera.c                |  4 +-
 .../platform/soc_camera/sh_mobile_ceu_camera.c     |  2 +-
 drivers/media/radio/Kconfig                        | 12 ++---
 drivers/media/radio/si470x/Kconfig                 |  2 +-
 drivers/media/radio/wl128x/Kconfig                 |  2 +-
 drivers/media/usb/dvb-usb-v2/Kconfig               |  2 +-
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c        |  2 +-
 drivers/media/usb/dvb-usb-v2/gl861.c               |  2 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |  4 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.h             |  2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.c            |  2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.h            |  2 +-
 drivers/media/usb/dvb-usb/Kconfig                  |  2 +-
 drivers/media/usb/dvb-usb/a800.c                   |  2 +-
 drivers/media/usb/dvb-usb/af9005-fe.c              |  2 +-
 drivers/media/usb/dvb-usb/af9005-remote.c          |  2 +-
 drivers/media/usb/dvb-usb/af9005.c                 |  2 +-
 drivers/media/usb/dvb-usb/af9005.h                 |  2 +-
 drivers/media/usb/dvb-usb/az6027.c                 |  2 +-
 drivers/media/usb/dvb-usb/cxusb.c                  |  2 +-
 drivers/media/usb/dvb-usb/dibusb-common.c          |  2 +-
 drivers/media/usb/dvb-usb/dibusb-mb.c              |  2 +-
 drivers/media/usb/dvb-usb/dibusb-mc-common.c       |  2 +-
 drivers/media/usb/dvb-usb/dibusb-mc.c              |  2 +-
 drivers/media/usb/dvb-usb/dibusb.h                 |  2 +-
 drivers/media/usb/dvb-usb/digitv.c                 |  2 +-
 drivers/media/usb/dvb-usb/dtt200u-fe.c             |  2 +-
 drivers/media/usb/dvb-usb/dtt200u.c                |  2 +-
 drivers/media/usb/dvb-usb/dtt200u.h                |  2 +-
 drivers/media/usb/dvb-usb/dvb-usb-firmware.c       |  2 +-
 drivers/media/usb/dvb-usb/dvb-usb-init.c           |  2 +-
 drivers/media/usb/dvb-usb/dw2102.c                 |  6 +--
 drivers/media/usb/dvb-usb/friio-fe.c               |  2 +-
 drivers/media/usb/dvb-usb/friio.c                  |  2 +-
 drivers/media/usb/dvb-usb/friio.h                  |  2 +-
 drivers/media/usb/dvb-usb/gp8psk.c                 |  4 +-
 drivers/media/usb/dvb-usb/gp8psk.h                 |  2 +-
 drivers/media/usb/dvb-usb/m920x.c                  |  2 +-
 drivers/media/usb/dvb-usb/nova-t-usb2.c            |  2 +-
 drivers/media/usb/dvb-usb/opera1.c                 |  4 +-
 drivers/media/usb/dvb-usb/ttusb2.c                 |  2 +-
 drivers/media/usb/dvb-usb/ttusb2.h                 |  2 +-
 drivers/media/usb/dvb-usb/umt-010.c                |  2 +-
 drivers/media/usb/dvb-usb/vp702x-fe.c              |  2 +-
 drivers/media/usb/dvb-usb/vp702x.c                 |  2 +-
 drivers/media/usb/dvb-usb/vp7045-fe.c              |  2 +-
 drivers/media/usb/dvb-usb/vp7045.c                 |  2 +-
 drivers/media/usb/dvb-usb/vp7045.h                 |  2 +-
 drivers/media/usb/gspca/m5602/Kconfig              |  2 -
 drivers/media/usb/ttusb-dec/Kconfig                |  6 +--
 drivers/media/usb/zr364xx/Kconfig                  |  2 +-
 drivers/net/ethernet/intel/Kconfig                 |  8 +--
 drivers/parport/Kconfig                            |  6 +--
 drivers/platform/x86/Kconfig                       |  2 +-
 drivers/sbus/char/oradax.c                         |  2 +-
 drivers/soundwire/stream.c                         |  8 +--
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt    |  2 +-
 drivers/staging/media/bcm2048/TODO                 |  2 +-
 drivers/staging/media/zoran/Kconfig                |  2 +-
 drivers/video/fbdev/skeletonfb.c                   |  8 +--
 fs/Kconfig.binfmt                                  |  2 +-
 fs/befs/ChangeLog                                  |  2 +-
 fs/binfmt_misc.c                                   |  2 +-
 fs/orangefs/orangefs-sysfs.c                       |  2 +-
 include/keys/asymmetric-subtype.h                  |  2 +-
 include/keys/asymmetric-type.h                     |  2 +-
 include/linux/assoc_array.h                        |  2 +-
 include/linux/assoc_array_priv.h                   |  2 +-
 include/linux/circ_buf.h                           |  2 +-
 include/linux/ftrace.h                             |  2 +-
 include/linux/platform_data/sc18is602.h            |  2 +-
 include/linux/rculist_nulls.h                      |  2 +-
 include/linux/tracepoint.h                         |  2 +-
 include/uapi/linux/prctl.h                         |  2 +-
 include/xen/interface/io/kbdif.h                   |  2 +-
 kernel/cgroup/cpuset.c                             |  2 +-
 kernel/power/main.c                                |  5 +-
 kernel/trace/Kconfig                               | 16 +++---
 lib/Kconfig                                        |  2 +-
 scripts/documentation-file-ref-check               | 56 ++++++++++++++++---
 security/device_cgroup.c                           |  2 +-
 security/selinux/hooks.c                           |  2 +-
 sound/core/Kconfig                                 |  4 +-
 sound/drivers/Kconfig                              |  4 +-
 sound/pci/Kconfig                                  | 10 ++--
 tools/include/uapi/linux/prctl.h                   |  2 +-
 tools/lib/api/fs/fs.c                              |  2 +-
 tools/perf/util/bpf-prologue.c                     |  2 +-
 .../pm-graph/config/custom-timeline-functions.cfg  |  4 +-
 206 files changed, 372 insertions(+), 339 deletions(-)
