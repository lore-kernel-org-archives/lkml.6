Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935040AbeEINTF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:19:05 -0400
Received: from osg.samsung.com ([64.30.133.232]:60842 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934898AbeEINTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:19:03 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 00/11] Fix some doc build warnings/errors and broken links
Date: Wed,  9 May 2018 10:18:43 -0300
Message-Id: <cover.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Patches 1 to 5 on this series contain the patches that weren't yet
applied from the past patch series and touch only at Documentation.
There are two changes there:
  patch 2: fixed the description and added a c/c to cgroup maintainers;
  patch 4: rewritten according with Louis request, droping several hunks.

Patch 6 rewrites scripts/documentation-file-ref-check on Perl,
adding an auto-fix feature.

Before doing that, I made a shell script version, but there are
several false positives there that would require some regex
parsing to get rid. Also, performance was problematic: even
on an i7core with SSD M.2 disk, it was taking more than a minute
just to identify the errors. The perl version makes it in less
than a second and gives more reliable results.

It should be noticed that, as any other auto-fix tool, the
resuls of the fix should be validated.

The next 5 patches contain several fixes based on its results.

Patches 7 and 8 fix things that would cause troubles for the
automatic autocorrection tool.

Patch 9 touches a lot of random places (including MAINTAINERS)
that contain broken links and can be auto-fixed. It could be
broken into one patch per touched file, but I think that is
overkill. 

Patch 10 fixes the removal of nmi_watchdog.txt.

Patch 11 do some manual fixes on most of the places where
the automatic fix tool found multiple hints.

Ah, I noticed also several broken links on media. Those
were fixed on 3 separate patches, submitted to linux-media.
I intend to apply them via my own tree.

Regards,
Mauro


Mauro Carvalho Chehab (11):
  docs: can.rst: fix a footnote reference
  docs: admin-guide: add cgroup-v2 documentation
  docs: crypto_engine.rst: Fix two parse warnings
  docs: dell_rbu.txt: fix location of request_firmware
  docs: uio-howto.rst: use a code block to solve a warning
  scripts/documentation-file-ref-check: rewrite it in perl with auto-fix
    mode
  docs: ranoops.rst: fix location of ramoops.txt
  docs: refcount-vs-atomic.rst: prefix url with https
  docs: Fix some broken references
  arch/*: Kconfig: fix documentation for NMI watchdog
  docs: fix broken references with multiple hints

 Documentation/00-INDEX                        |   2 -
 Documentation/ABI/obsolete/sysfs-gpio         |   2 +-
 .../cgroup-v2.rst}                            |   0
 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/kernel-parameters.txt         |   4 +-
 Documentation/admin-guide/ramoops.rst         |   2 +-
 Documentation/core-api/refcount-vs-atomic.rst |   2 +-
 Documentation/crypto/crypto_engine.rst        |   8 +-
 Documentation/dell_rbu.txt                    |   4 +-
 .../bindings/display/bridge/tda998x.txt       |   2 +-
 .../bindings/input/rotary-encoder.txt         |   2 +-
 Documentation/driver-api/gpio/consumer.rst    |   2 +-
 Documentation/driver-api/uio-howto.rst        |   3 +-
 Documentation/kprobes.txt                     |   4 +-
 Documentation/networking/can.rst              |   4 +-
 Documentation/trace/coresight.txt             |   2 +-
 Documentation/trace/events.rst                |   4 +-
 Documentation/trace/ftrace-uses.rst           |   2 +-
 Documentation/trace/histogram.txt             |   2 +-
 Documentation/trace/intel_th.rst              |   2 +-
 Documentation/trace/tracepoint-analysis.rst   |   8 +-
 Documentation/translations/ja_JP/howto.rst    |   4 +-
 .../translations/zh_CN/SubmittingDrivers      |   2 +-
 Documentation/translations/zh_CN/gpio.txt     |   4 +-
 .../translations/zh_CN/magic-number.txt       |   4 +-
 .../zh_CN/video4linux/omap3isp.txt            |   4 +-
 MAINTAINERS                                   |  22 +--
 arch/Kconfig                                  |   2 +-
 arch/arm/Kconfig                              |   2 +-
 arch/arm/include/asm/cacheflush.h             |   2 +-
 arch/arm64/include/asm/cacheflush.h           |   2 +-
 arch/microblaze/include/asm/cacheflush.h      |   2 +-
 arch/parisc/Kconfig                           |   2 +-
 arch/sh/Kconfig                               |   2 +-
 arch/sparc/Kconfig                            |   2 +-
 arch/um/Kconfig.um                            |   2 +-
 arch/unicore32/include/asm/cacheflush.h       |   2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c         |   2 +-
 arch/xtensa/include/asm/cacheflush.h          |   4 +-
 block/Kconfig                                 |   2 +-
 certs/Kconfig                                 |   2 +-
 crypto/asymmetric_keys/asymmetric_type.c      |   2 +-
 crypto/asymmetric_keys/signature.c            |   2 +-
 drivers/char/Kconfig                          |   2 +-
 drivers/clk/clk.c                             |   4 +-
 drivers/clk/ingenic/cgu.h                     |   2 +-
 drivers/gpu/vga/Kconfig                       |   2 +-
 drivers/gpu/vga/vgaarb.c                      |   2 +-
 drivers/hid/usbhid/Kconfig                    |   2 +-
 drivers/input/Kconfig                         |   4 +-
 drivers/input/joystick/Kconfig                |  14 +-
 drivers/input/joystick/iforce/Kconfig         |   4 +-
 drivers/input/joystick/walkera0701.c          |   2 +-
 drivers/input/misc/Kconfig                    |   4 +-
 drivers/input/misc/rotary_encoder.c           |   2 +-
 drivers/input/mouse/Kconfig                   |   6 +-
 drivers/input/mouse/alps.c                    |   2 +-
 drivers/input/serio/Kconfig                   |   4 +-
 drivers/input/touchscreen/wm97xx-core.c       |   2 +-
 drivers/lightnvm/pblk-rb.c                    |   2 +-
 drivers/md/bcache/Kconfig                     |   2 +-
 drivers/md/bcache/btree.c                     |   2 +-
 drivers/md/bcache/extents.c                   |   2 +-
 drivers/media/dvb-core/dvb_ringbuffer.c       |   2 +-
 drivers/media/pci/meye/Kconfig                |   2 +-
 drivers/media/platform/pxa_camera.c           |   4 +-
 .../soc_camera/sh_mobile_ceu_camera.c         |   2 +-
 drivers/media/radio/Kconfig                   |   2 +-
 drivers/media/radio/si470x/Kconfig            |   2 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c        |   2 +-
 drivers/media/usb/zr364xx/Kconfig             |   2 +-
 drivers/parport/Kconfig                       |   6 +-
 .../staging/fsl-mc/bus/dpio/dpio-driver.txt   |   2 +-
 drivers/staging/media/bcm2048/TODO            |   2 +-
 drivers/video/fbdev/skeletonfb.c              |   8 +-
 include/keys/asymmetric-subtype.h             |   2 +-
 include/keys/asymmetric-type.h                |   2 +-
 include/linux/assoc_array.h                   |   2 +-
 include/linux/assoc_array_priv.h              |   2 +-
 include/linux/circ_buf.h                      |   2 +-
 include/linux/ftrace.h                        |   2 +-
 include/linux/rculist_nulls.h                 |   2 +-
 include/linux/tracepoint.h                    |   2 +-
 include/uapi/linux/prctl.h                    |   2 +-
 include/xen/interface/io/kbdif.h              |   2 +-
 kernel/cgroup/cpuset.c                        |   2 +-
 kernel/trace/Kconfig                          |  16 +--
 lib/Kconfig                                   |   2 +-
 scripts/documentation-file-ref-check          | 125 ++++++++++++++++--
 security/device_cgroup.c                      |   2 +-
 security/selinux/hooks.c                      |   2 +-
 sound/core/Kconfig                            |   4 +-
 sound/drivers/Kconfig                         |   4 +-
 sound/pci/Kconfig                             |  10 +-
 tools/include/uapi/linux/prctl.h              |   2 +-
 tools/lib/api/fs/fs.c                         |   2 +-
 tools/memory-model/README                     |  10 +-
 tools/perf/util/bpf-prologue.c                |   2 +-
 .../config/custom-timeline-functions.cfg      |   4 +-
 99 files changed, 274 insertions(+), 171 deletions(-)
 rename Documentation/{cgroup-v2.txt => admin-guide/cgroup-v2.rst} (100%)

-- 
2.17.0
