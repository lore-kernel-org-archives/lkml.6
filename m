Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3D121741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFmfPBIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbeL0Tog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:44:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39709 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeL0Tog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:44:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id u47so16632147qtj.6;
        Thu, 27 Dec 2018 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Phdl2ZHqhUnqb3qr4h/7+wKaLxGuN9yhsofrjPEhcUs=;
        b=CFmfPBIocQLD3+/PYTmubIPWMBSYXVpzwoSdqXrx2g6N+Db0Rfh6N3EqWTuA/oau1/
         WzziBKgVlUgr7psrWQKMY52Rtkj2svSq5O9fSQfhXeZ+XQ9tCUFI8uNo2jVHsuSnspQH
         e1k644kFIWqVb9kIKJ1OWCbZj+48EERQsPaxZIpfEgq6b8e0hcPospY74WC5LVrYK3tr
         vXHpkAItIZntb3g/u/V8k6uS10PmJwWa/wuweDhvK1EVL75INYZQTpqlSn3vuoW0qxFD
         YTYI74BZmYz/EImqWPWgVGNJtUjuRGexYI/25MK+u0kFcVCWt3ZfgTeY85nnOhMxpQ/Y
         SPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Phdl2ZHqhUnqb3qr4h/7+wKaLxGuN9yhsofrjPEhcUs=;
        b=VdHbhya4vSZL0xB60sich2VLs3vVEuuGU6wQJ/xCbMHKAO1BwmVTqVfJl5247jTDyK
         KMhbBQ64VXEyomKZ01fW5DPLkcfjHYATuHYkdkqtV41vhy4rttyGKMI+YI7IclMkLDg2
         OCbFf52cyA6NNzppBzFE161kMV62KRsExAgWyvVvEs3AL+tSloLiwPB6j4DQLcWNcLI8
         nL//87cOPKeZcP9a6BICUFpl6wq2li/9ujB2QNmxi6VD42b0JcOh21VD6qgWDCI2/RdK
         ZVf6GTmykfX6ZhRu+hGgRtTEHke2ny8DIgSNg7k05MPMtGHSudrtISYSi4Ia8JJo0MQB
         n/Og==
X-Gm-Message-State: AJcUukd5ux5Hu1Oddi4YPEWCiUnUTrk039mclGEVxRN/mAp+sTDzjg/M
        m3mFUabZQu5GhRvHCPEp40Y1eCBxcn+6in+2cQ==
X-Google-Smtp-Source: AFSGD/XxDRkVWpv5uZe/uxnqnAsmLqRiI1rCMVbyWDntovcalLCTl4JuUl9QFMwyw/XTbpuqfy+giG7K5MNUfBWmFeY=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr22785630qtd.257.1545939873550;
 Thu, 27 Dec 2018 11:44:33 -0800 (PST)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Thu, 27 Dec 2018 13:44:21 -0600
Message-ID: <CAL_JsqLeKebs8yL1y0XUjBKYQiqVtkgZ4+1Sfwxx1_rPtDwdUQ@mail.gmail.com>
Subject: [GIT PULL] DeviceTree updates for v4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for v4.21. The biggest highlight here is the
start of using json-schema for DT bindings. Being able to validate
bindings has been discussed for years with little progress.

You'll notice my tag is not signed. I couldn't sign it because I'm
traveling and grabbed the wrong yubikey by mistake.

Rob

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
devicetree-for-4.21

for you to fetch changes up to 5801169a2ed20003f771acecf3ac00574cf10a38:

  of: __of_detach_node() - remove node from phandle cache (2018-12-21
12:42:36 -0600)

----------------------------------------------------------------
Devicetree updates for v4.21:

- Initial support for DT bindings using json-schema language. This is
  the start of converting DT bindings from free-form text to a
  structured format.

- Reworking of initrd address initialization. This moves to using the
  phys address instead of virt addr in the DT parsing code. This rework
  was motivated by CONFIG_DEV_BLK_INITRD causing unnecessary rebuilding
  of lots of files.

- Fix stale phandle entries in phandle cache

- DT overlay validation improvements. This exposed several memory leak
  bugs which have been fixed.

- Use node name and device_type helper functions in DT code

- Last remaining conversions to using %pOFn printk specifier instead of
  device_node.name directly

- Create new common RTC binding doc and move all trivial RTC devices out
  of trivial-devices.txt.

- New bindings for Freescale MAG3110 magnetometer, Cadence Sierra PHY,
  and Xen shared memory

- Update dtc to upstream version v1.4.7-57-gf267e674d145

----------------------------------------------------------------
Alan Douglas (1):
      dt-bindings: phy: Document cadence Sierra PHY bindings

Alexandre Belloni (2):
      dt-bindings: rtc: add generic bindings
      dt-bindings: rtc: Move trivial RTCs to rtc.txt

Andreas Klinger (1):
      gpio-omap.txt: add reg and interrupts properties

Anson Huang (1):
      dt-bindings: iio: magnetometer: add dt-bindings for freescale mag3110

Florian Fainelli (6):
      nds32: Remove phys_initrd_start and phys_initrd_size
      arch: Make phys_initrd_start and phys_initrd_size global variables
      of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
      arm64: Utilize phys_initrd_start/phys_initrd_size
      of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
      arch: Move initrd= parsing into do_mounts_initrd.c

Frank Rowand (20):
      of: Documentation: remove unmaintained todo file
      of: overlay: add tests to validate kfrees from overlay removal
      of: overlay: add missing of_node_put() after add new node to changeset
      of: overlay: add missing of_node_get() in __of_attach_node_sysfs
      powerpc/pseries: add of_node_put() in dlpar_detach_node()
      of: overlay: use prop add changeset entry for property in new nodes
      of: overlay: do not duplicate properties from overlay for new nodes
      of: overlay: reorder fields in struct fragment
      of: overlay: validate overlay properties #address-cells and #size-cells
      of: overlay: make all pr_debug() and pr_err() messages unique
      of: overlay: test case of two fragments adding same node
      of: overlay: check prevents multiple fragments add or delete same node
      of: overlay: check prevents multiple fragments touching same property
      of: unittest: remove unused of_unittest_apply_overlay() argument
      of: overlay: set node fields from properties when add new overlay node
      of: unittest: allow base devicetree to have symbol metadata
      of: unittest: find overlays[] entry by name instead of index
      of: unittest: initialize args before calling of_*parse_*()
      of: of_node_get()/of_node_put() nodes held in phandle cache
      of: __of_detach_node() - remove node from phandle cache

Lubomir Rintel (2):
      dt-bindings: arm: mrvl: amend Browstone compatible string
      dt-bindings: mrvl,intc: fix a trivial typo

Michal Simek (1):
      dt-bindings: arm: Add missing Xilinx boards

Nick Kossifidis (1):
      OF: Add a warning in case chosen node is not present

Rob Herring (33):
      of/pdt: Remove unused of_pdt_build_more function ptr
      Merge tag 'kfree_validate_v7-for-4.20' of
git://git.kernel.org/.../frowand/linux into dt/next
      irqchip: Convert to using %pOFn instead of device_node.name
      memory: Convert to using %pOFn instead of device_node.name
      backlight: pm8941: Convert to using %pOFn instead of device_node.name
      mtd: Convert to using %pOFn instead of device_node.name
      power: reset: Convert to using %pOFn instead of device_node.name
      of: Use device_type helpers to access the node type
      scripts/dtc: Update to upstream version v1.4.7-57-gf267e674d145
      kbuild: disable dtc simple_bus_reg warnings by default
      kbuild: Enable dtc graph_port warning by default
      of: Use of_node_name_eq for node name comparisons
      kbuild: Add support for DT binding schema checks
      dt-bindings: Add a writing DT schemas how-to and annotated example
      dt-bindings: altera: Convert clkmgr binding to json-schema
      dt-bindings: i2c: Convert i2c-gpio binding to json-schema
      dt-bindings: timer: Convert ARM timer bindings to json-schema
      dt-bindings: arm: Convert cpu binding to json-schema
      dt-bindings: arm: Convert primecell binding to json-schema
      dt-bindings: arm: Convert Altera board/soc bindings to json-schema
      dt-bindings: arm: Convert Calxeda board/soc bindings to json-schema
      dt-bindings: arm: Convert TI davinci board/soc bindings to json-schema
      dt-bindings: arm: Convert TI nspire board/soc bindings to json-schema
      dt-bindings: arm: Convert QCom board/soc bindings to json-schema
      dt-bindings: arm: Convert CSR SiRF board/soc bindings to json-schema
      dt-bindings: arm: Convert SPEAr board/soc bindings to json-schema
      dt-bindings: arm: Convert ST STi board/soc bindings to json-schema
      dt-bindings: arm: Convert VIA board/soc bindings to json-schema
      dt-bindings: arm: Convert Xilinx board/soc bindings to json-schema
      dt-bindings: arm: Convert ZTE board/soc bindings to json-schema
      dt-bindings: arm: Convert Tegra board/soc bindings to json-schema
      dt-bindings: Convert trivial-devices.txt to json-schema
      Merge branch 'yaml-bindings-for-v4.21' into dt/next

Ryder Lee (1):
      dt-bindings: rng: update bindings for MT7629 SoC

Stefano Stabellini (1):
      devicetree,xen: add xen,shared-memory binding

 .gitignore                                         |   1 +
 Documentation/Makefile                             |   2 +-
 Documentation/devicetree/bindings/.gitignore       |   2 +
 Documentation/devicetree/bindings/Makefile         |  27 ++
 Documentation/devicetree/bindings/arm/altera.txt   |  14 -
 Documentation/devicetree/bindings/arm/altera.yaml  |  20 +
 .../bindings/arm/altera/socfpga-clk-manager.txt    |  11 -
 .../bindings/arm/altera/socfpga-clk-manager.yaml   |  31 ++
 Documentation/devicetree/bindings/arm/calxeda.txt  |  15 -
 Documentation/devicetree/bindings/arm/calxeda.yaml |  22 +
 Documentation/devicetree/bindings/arm/cpus.txt     | 490 --------------------
 Documentation/devicetree/bindings/arm/cpus.yaml    | 507 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/davinci.txt  |  25 -
 .../devicetree/bindings/arm/mrvl/mrvl.txt          |   2 +-
 Documentation/devicetree/bindings/arm/nspire.txt   |  14 -
 .../devicetree/bindings/arm/primecell.txt          |  46 --
 .../devicetree/bindings/arm/primecell.yaml         |  36 ++
 Documentation/devicetree/bindings/arm/qcom.txt     |  57 ---
 Documentation/devicetree/bindings/arm/qcom.yaml    | 125 +++++
 Documentation/devicetree/bindings/arm/sirf.txt     |  11 -
 Documentation/devicetree/bindings/arm/sirf.yaml    |  27 ++
 Documentation/devicetree/bindings/arm/spear.txt    |  26 --
 Documentation/devicetree/bindings/arm/spear.yaml   |  25 +
 Documentation/devicetree/bindings/arm/sti.txt      |  23 -
 Documentation/devicetree/bindings/arm/sti.yaml     |  23 +
 Documentation/devicetree/bindings/arm/tegra.txt    |  65 ---
 Documentation/devicetree/bindings/arm/tegra.yaml   | 101 ++++
 .../devicetree/bindings/arm/ti/nspire.yaml         |  24 +
 .../devicetree/bindings/arm/ti/ti,davinci.yaml     |  26 ++
 Documentation/devicetree/bindings/arm/vt8500.txt   |  22 -
 Documentation/devicetree/bindings/arm/vt8500.yaml  |  23 +
 Documentation/devicetree/bindings/arm/xilinx.txt   |  83 ----
 Documentation/devicetree/bindings/arm/xilinx.yaml  | 114 +++++
 Documentation/devicetree/bindings/arm/zte.txt      |  14 -
 Documentation/devicetree/bindings/arm/zte.yaml     |  26 ++
 .../devicetree/bindings/example-schema.yaml        | 170 +++++++
 .../devicetree/bindings/gpio/gpio-omap.txt         |  10 +-
 Documentation/devicetree/bindings/i2c/i2c-gpio.txt |  46 --
 .../devicetree/bindings/i2c/i2c-gpio.yaml          |  73 +++
 .../bindings/iio/magnetometer/mag3110.txt          |  27 ++
 .../bindings/interrupt-controller/mrvl,intc.txt    |   2 +-
 .../devicetree/bindings/phy/phy-cadence-sierra.txt |  67 +++
 .../bindings/reserved-memory/xen,shared-memory.txt |  24 +
 Documentation/devicetree/bindings/rng/mtk-rng.txt  |   3 +-
 Documentation/devicetree/bindings/rtc/rtc.txt      |  64 +++
 .../devicetree/bindings/timer/arm,arch_timer.txt   | 112 -----
 .../devicetree/bindings/timer/arm,arch_timer.yaml  | 103 +++++
 .../bindings/timer/arm,arch_timer_mmio.yaml        | 120 +++++
 .../devicetree/bindings/timer/arm,global_timer.txt |  27 --
 .../bindings/timer/arm,global_timer.yaml           |  46 ++
 .../devicetree/bindings/trivial-devices.txt        | 190 --------
 .../devicetree/bindings/trivial-devices.yaml       | 342 ++++++++++++++
 Documentation/devicetree/todo.txt                  |  10 -
 Documentation/devicetree/writing-schema.md         | 130 ++++++
 MAINTAINERS                                        |   2 +-
 Makefile                                           |  13 +-
 arch/arc/mm/init.c                                 |  25 +-
 arch/arm/mm/init.c                                 |  28 +-
 arch/arm64/include/asm/memory.h                    |   8 -
 arch/arm64/mm/init.c                               |  34 +-
 arch/nds32/mm/init.c                               |   2 -
 arch/powerpc/platforms/pseries/dlpar.c             |   2 +
 arch/unicore32/mm/init.c                           |  24 +-
 drivers/irqchip/irq-gic-v3.c                       |   4 +-
 drivers/irqchip/irq-mscc-ocelot.c                  |   6 +-
 drivers/irqchip/irq-orion.c                        |  22 +-
 drivers/irqchip/irq-stm32-exti.c                   |   6 +-
 drivers/irqchip/irq-tango.c                        |  10 +-
 drivers/irqchip/irq-tb10x.c                        |  18 +-
 drivers/memory/omap-gpmc.c                         |  18 +-
 drivers/memory/samsung/exynos-srom.c               |   4 +-
 drivers/memory/tegra/mc.c                          |   6 +-
 drivers/memory/tegra/tegra124-emc.c                |  12 +-
 drivers/mtd/devices/powernv_flash.c                |   2 +-
 drivers/of/address.c                               |   6 +-
 drivers/of/base.c                                  | 126 +++--
 drivers/of/device.c                                |   9 +-
 drivers/of/dynamic.c                               |  62 ++-
 drivers/of/fdt.c                                   |  23 +-
 drivers/of/kobj.c                                  |   4 +-
 drivers/of/of_private.h                            |   4 +
 drivers/of/overlay.c                               | 292 +++++++++---
 drivers/of/pdt.c                                   |   5 -
 drivers/of/property.c                              |  10 +-
 drivers/of/resolver.c                              |   4 +-
 drivers/of/unittest-data/Makefile                  |   2 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 +
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              | 100 +++-
 drivers/power/reset/axxia-reset.c                  |   2 +-
 drivers/video/backlight/pm8941-wled.c              |   2 +-
 include/linux/initrd.h                             |   3 +
 include/linux/of.h                                 |  21 +-
 include/linux/of_pdt.h                             |   2 -
 init/do_mounts_initrd.c                            |  20 +
 scripts/Makefile.lib                               |  26 +-
 scripts/dtc/Makefile                               |   4 +
 scripts/dtc/checks.c                               |  73 ++-
 scripts/dtc/dtc-lexer.l                            |   4 +-
 scripts/dtc/dtc-parser.y                           |  52 ++-
 scripts/dtc/dtc.c                                  |  11 +-
 scripts/dtc/dtc.h                                  |  11 +-
 scripts/dtc/flattree.c                             |   4 +-
 scripts/dtc/fstree.c                               |   5 +-
 scripts/dtc/libfdt/Makefile.libfdt                 |   4 +
 scripts/dtc/libfdt/fdt_addresses.c                 |  16 +-
 scripts/dtc/libfdt/libfdt.h                        |  24 +-
 scripts/dtc/livetree.c                             |  33 +-
 scripts/dtc/srcpos.c                               | 153 ++++++-
 scripts/dtc/srcpos.h                               |  14 +-
 scripts/dtc/treesource.c                           | 115 +++--
 scripts/dtc/util.c                                 |  60 ++-
 scripts/dtc/util.h                                 |   2 +
 scripts/dtc/version_gen.h                          |   2 +-
 115 files changed, 3472 insertions(+), 1783 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/.gitignore
 create mode 100644 Documentation/devicetree/bindings/Makefile
 delete mode 100644 Documentation/devicetree/bindings/arm/altera.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera.yaml
 delete mode 100644
Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.txt
 create mode 100644
Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/davinci.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/nspire.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/primecell.txt
 create mode 100644 Documentation/devicetree/bindings/arm/primecell.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/qcom.txt
 create mode 100644 Documentation/devicetree/bindings/arm/qcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
 create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/sti.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sti.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/tegra.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/ti/nspire.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/vt8500.txt
 create mode 100644 Documentation/devicetree/bindings/arm/vt8500.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/arm/xilinx.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/arm/zte.yaml
 create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
 create mode 100644
Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
 create mode 100644
Documentation/devicetree/bindings/reserved-memory/xen,shared-memory.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
 create mode 100644
Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,global_timer.txt
 create mode 100644
Documentation/devicetree/bindings/timer/arm,global_timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/trivial-devices.txt
 create mode 100644 Documentation/devicetree/bindings/trivial-devices.yaml
 delete mode 100644 Documentation/devicetree/todo.txt
 create mode 100644 Documentation/devicetree/writing-schema.md
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
