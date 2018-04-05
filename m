Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDEVKA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:10:00 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33496 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeDEVJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:09:58 -0400
X-Google-Smtp-Source: AIpwx48RErEmgtitFAs/0bVgwnsOsRydMnWfi7VtAJGbm/lUFfl8reXoLOsOBdfY0foHLimUpjHOKiKxcfFBjeOb3EU=
MIME-Version: 1.0
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 5 Apr 2018 16:09:37 -0500
Message-ID: <CAL_JsqKY9PKUbU3ehbuxy4Ly-8E5U-KgUo+HASB=LgML=3euAg@mail.gmail.com>
Subject: [GIT PULL] DeviceTree updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull DT updates for 4.17.

Rob

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-for-4.17

for you to fetch changes up to 827473268ee492b30b576ef156ab524a2b9f3520:

  of: unittest: fix an error code in of_unittest_apply_overlay()
(2018-03-19 22:52:40 -0500)

----------------------------------------------------------------
DeviceTree updates for 4.17:

- Sync dtc to upstream version v1.4.6-9-gaadd0b65c987. This adds a bunch
  more warnings (hidden behind W=1).

- Build dtc lexer and parser files instead of using shipped versions.

- Rework overlay apply API to take an FDT as input and apply overlays in
  a single step.

- Add a phandle lookup cache. This improves boot time by hundreds of
  msec on systems with large DT.

- Add trivial mcp4017/18/19 potentiometers bindings.

- Remove VLA stack usage in DT code.

----------------------------------------------------------------
Arnd Bergmann (1):
      of: unittest: move misplaced function declaration

Dan Carpenter (2):
      of: unittest: fix an error test in of_unittest_overlay_8()
      of: unittest: fix an error code in of_unittest_apply_overlay()

Frank Rowand (10):
      x86: devicetree: fix config option around x86_flattree_get_config()
      of: change overlay apply input data from unflattened to FDT
      of: Documentation: of_overlay_apply() replaced by of_overlay_fdt_apply()
      of: convert unittest overlay devicetree source to sugar syntax
      of: improve reporting invalid overlay target path
      of: unittest: clean up changeset test
      of: overlay: do not include path in full_name of added nodes
      of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
      of: unittest: remove unneeded local return value variables
      of: unittest: local return value variable related cleanups

Geert Uytterhoeven (2):
      of: Documentation: Fix forgotten reference to of_overlay_apply()
      of: overlay: Fix forgotten reference to of_overlay_apply()

John Keeping (1):
      dt-bindings: rockchip-dw-mshc: use consistent clock names

Peter Rosin (1):
      dt-bindings: trivial: add various mcp4017/18/19 potentiometers

Rob Herring (12):
      kbuild: remove remaining use of undefined YACC_PREFIX
      kbuild: add dtc as dependency on .dtb files
      scripts: re-enable some now fixed dtc warnings
      ARM: boot: add strrchr function
      Merge tag 'overlay_apply_fdt_v7-for-4.17' of
git://git.kernel.org/.../frowand/linux into dt/next
      arm64/efi: Make strrchr() available to the EFI namespace
      powerpc: boot: add strrchr function
      scripts/dtc: generate lexer and parser during build instead of shipping
      scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987
      scripts: turn off some new dtc warnings by default
      MAINTAINERS: Add linux/of_*.h headers to appropriate subsystems
      Merge branch 'dtc-update' into dt/next

Stephen Boyd (3):
      of: Support parsing phandle argument lists through a nexus node
      of: unittest: Add phandle remapping test
      gpio: Support gpio nexus dt bindings

Tobin C. Harding (1):
      of: unittest: Remove VLA stack usage

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |    4 +-
 .../devicetree/bindings/trivial-devices.txt        |   12 +
 Documentation/devicetree/overlay-notes.txt         |    8 +-
 MAINTAINERS                                        |    4 +
 arch/arm/boot/compressed/string.c                  |   10 +
 arch/arm64/kernel/image.h                          |    1 +
 arch/arm64/lib/strrchr.S                           |    2 +-
 arch/powerpc/boot/stdio.c                          |   10 +
 arch/powerpc/boot/string.h                         |    1 +
 arch/x86/kernel/devicetree.c                       |    2 +-
 drivers/gpio/gpiolib-of.c                          |    4 +-
 drivers/of/Kconfig                                 |    1 +
 drivers/of/base.c                                  |  270 ++-
 drivers/of/dynamic.c                               |   21 +-
 drivers/of/of_private.h                            |    6 +-
 drivers/of/overlay.c                               |  154 +-
 drivers/of/resolver.c                              |    9 -
 drivers/of/unittest-data/Makefile                  |   28 +-
 drivers/of/unittest-data/overlay.dts               |  101 +-
 drivers/of/unittest-data/overlay_0.dts             |   14 +
 drivers/of/unittest-data/overlay_1.dts             |   14 +
 drivers/of/unittest-data/overlay_10.dts            |   27 +
 drivers/of/unittest-data/overlay_11.dts            |   28 +
 drivers/of/unittest-data/overlay_12.dts            |   14 +
 drivers/of/unittest-data/overlay_13.dts            |   14 +
 drivers/of/unittest-data/overlay_15.dts            |   30 +
 drivers/of/unittest-data/overlay_2.dts             |    9 +
 drivers/of/unittest-data/overlay_3.dts             |    9 +
 drivers/of/unittest-data/overlay_4.dts             |   18 +
 drivers/of/unittest-data/overlay_5.dts             |    9 +
 drivers/of/unittest-data/overlay_6.dts             |   10 +
 drivers/of/unittest-data/overlay_7.dts             |   10 +
 drivers/of/unittest-data/overlay_8.dts             |   10 +
 drivers/of/unittest-data/overlay_9.dts             |   10 +
 drivers/of/unittest-data/overlay_bad_phandle.dts   |   23 +-
 drivers/of/unittest-data/overlay_bad_symbol.dts    |   25 +-
 drivers/of/unittest-data/tests-overlay.dtsi        |  217 +-
 drivers/of/unittest-data/tests-phandle.dtsi        |   25 +
 drivers/of/unittest.c                              |  578 +++--
 include/linux/libfdt_env.h                         |    6 +-
 include/linux/of.h                                 |   18 +-
 scripts/Makefile.lib                               |    9 +-
 scripts/dtc/Makefile                               |    6 +-
 scripts/dtc/checks.c                               |  439 ++--
 scripts/dtc/dtc-lexer.lex.c_shipped                | 2259 -------------------
 scripts/dtc/dtc-parser.tab.c_shipped               | 2321 --------------------
 scripts/dtc/dtc-parser.tab.h_shipped               |  125 --
 scripts/dtc/dtc-parser.y                           |   17 +-
 scripts/dtc/dtc.c                                  |    7 +-
 scripts/dtc/dtc.h                                  |   11 +-
 scripts/dtc/flattree.c                             |    2 +-
 scripts/dtc/libfdt/fdt.c                           |   13 +-
 scripts/dtc/libfdt/fdt.h                           |    6 +-
 scripts/dtc/libfdt/fdt_overlay.c                   |   51 +
 scripts/dtc/libfdt/fdt_ro.c                        |  132 +-
 scripts/dtc/libfdt/fdt_rw.c                        |   90 +-
 scripts/dtc/libfdt/fdt_sw.c                        |   24 +-
 scripts/dtc/libfdt/fdt_wip.c                       |   10 +-
 scripts/dtc/libfdt/libfdt.h                        |   37 +-
 scripts/dtc/libfdt/libfdt_env.h                    |   33 +-
 scripts/dtc/libfdt/libfdt_internal.h               |   32 +-
 scripts/dtc/livetree.c                             |   10 +-
 scripts/dtc/srcpos.c                               |    5 -
 scripts/dtc/srcpos.h                               |    6 +-
 scripts/dtc/update-dtc-source.sh                   |    7 +-
 scripts/dtc/util.h                                 |    9 +-
 scripts/dtc/version_gen.h                          |    2 +-
 67 files changed, 1786 insertions(+), 5643 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_0.dts
 create mode 100644 drivers/of/unittest-data/overlay_1.dts
 create mode 100644 drivers/of/unittest-data/overlay_10.dts
 create mode 100644 drivers/of/unittest-data/overlay_11.dts
 create mode 100644 drivers/of/unittest-data/overlay_12.dts
 create mode 100644 drivers/of/unittest-data/overlay_13.dts
 create mode 100644 drivers/of/unittest-data/overlay_15.dts
 create mode 100644 drivers/of/unittest-data/overlay_2.dts
 create mode 100644 drivers/of/unittest-data/overlay_3.dts
 create mode 100644 drivers/of/unittest-data/overlay_4.dts
 create mode 100644 drivers/of/unittest-data/overlay_5.dts
 create mode 100644 drivers/of/unittest-data/overlay_6.dts
 create mode 100644 drivers/of/unittest-data/overlay_7.dts
 create mode 100644 drivers/of/unittest-data/overlay_8.dts
 create mode 100644 drivers/of/unittest-data/overlay_9.dts
 delete mode 100644 scripts/dtc/dtc-lexer.lex.c_shipped
 delete mode 100644 scripts/dtc/dtc-parser.tab.c_shipped
 delete mode 100644 scripts/dtc/dtc-parser.tab.h_shipped
