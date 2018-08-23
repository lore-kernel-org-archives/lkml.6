Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABE72098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RYcop6Bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABE72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeHWP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:28:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40394 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbeHWP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:28:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180823115856euoutp018570dc40936a795d12689314ed69f7f8~NgZeqz4M82442924429euoutp01i;
        Thu, 23 Aug 2018 11:58:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180823115856euoutp018570dc40936a795d12689314ed69f7f8~NgZeqz4M82442924429euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535025536;
        bh=3xNEA/+LyHWX9jWqfLraroo07pTEtJYcgnnbDiaWPr0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=RYcop6BzoO+bTMg59dBrxyypWiYG8TYeEFjHjQrUsYMvt2v1CAJJKNVVo9SwHcBqu
         GPDHJ71NCRK4EGqQKTcMCYwcAL9NBYXijpATSKmqtz2A46otiEHWTE5Pvi0xUoUmq8
         dktMy/CVBF8Epe+bi6GOQbVpBT1pjl2q9trbP7Q8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180823115855eucas1p24f01abc933c404388a45229f2d1b7127~NgZd7-a0L1586515865eucas1p2G;
        Thu, 23 Aug 2018 11:58:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EC.52.04294.F71AE7B5; Thu, 23
        Aug 2018 12:58:55 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180823115854eucas1p19532b92296003cb4fed2e7ed70015072~NgZdQ7tW00148001480eucas1p1f;
        Thu, 23 Aug 2018 11:58:54 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-3e-5b7ea17f7dca
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.DC.04128.E71AE7B5; Thu, 23
        Aug 2018 12:58:54 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PDW00I9PXA5O960@eusync4.samsung.com>; Thu, 23 Aug
        2018 12:58:54 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev changes for v4.19
Date:   Thu, 23 Aug 2018 13:58:52 +0200
Message-id: <3194400.CnyYvb8CBI@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7djPc7r1C+uiDVa1CFlc+fqezeJE3wdW
        i8u75rBZPOp7y+7A4nFixm8Wj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4Mp4Of0pc8EJ94rm
        b4cZGxhbTbsYOTkkBEwk+t6uYOti5OIQEljBKDFjz20mCOczo8SVb0uYYKqO73/DCpFYxiix
        7NZ2FgjnN6PE+q5/jCBVbAJWEhPbV4HZIgJGEp9fXGEFsZkFEiT+n98JNklYQFti5dXpYHEW
        AVWJtzcXA+3m4OAV0JRYd94LJCwq4CWxZV87WDmvgKDEj8n3WCDGyEvs2z8VaqSOxNlj6xhB
        bpAQ+MsqcWp6BzPEpS4Srz4chrKFJV4d38IOYctIXJ7czQLRMJ1R4s2vpVDOekaJNWeOQf1p
        LXH4+EWoFXwSk7ZNZwa5TkKAV6KjTQiixEPixcN2sAVCArESa+7eZJnAKD0LybGzkBw7C8mx
        CxiZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl5+duYgTG8el/x7/sYNz1J+kQowAHoxIPr0Bh
        bbQQa2JZcWXuIUYJDmYlEd7nm2uihXhTEiurUovy44tKc1KLDzFKc7AoifPyaaVFCwmkJ5ak
        ZqemFqQWwWSZODilGhj7u9aaaLUztYkfidMsz9pvu9bXV23VvDLXzPUKMT+Lb6pvMGj3n9ux
        a6nJN+Zpn9ommjfyTF7duTVeZ3n/u6MzZuzdsvBdxzv1TbN4mRleRFe6ncuz2r7KZ/NGockq
        TVKvUqfPYkqTXCPy/7+GrOujdToR81u9n7MJnrPSS0h6PlOrZ7OBL58SS3FGoqEWc1FxIgBF
        m8qI3wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsVy+t/xa7p1C+uiDa42G1lc+fqezeJE3wdW
        i8u75rBZPOp7y+7A4nFixm8Wj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4Mp4Of0pc8EJ94rm
        b4cZGxhbTbsYOTkkBEwkju9/w9rFyMUhJLCEUaJ7YzMjhPOXUWLbw1PsIFVsAlYSE9tXMYLY
        IgJGEp9fXGEFsZkFEiQ2r2xkBrGFBbQlVl6dDhZnEVCVeHtzMVsXIwcHr4CmxLrzXiBhUQEv
        iS372plAbF4BQYkfk++xQIyRl9i3fyrUSC2J9TuPM01g5J2FpGwWkrJZSMoWMDKvYhRJLS3O
        Tc8tNtIrTswtLs1L10vOz93ECAy0bcd+btnB2PUu+BCjAAejEg9vRnFttBBrYllxZe4hRgkO
        ZiUR3ueba6KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1
        MPLbflKa2rey+UOLtbfXpDU/mPzt6n7/3O3xc4ObZO+BiOsnRR0vXBM4+Wf9nKTwGCuZ6fef
        bP12rim/3Gy64MpLq2+fvxV+SptlQc/zctv5dY4GR899n/nW+8rSB7+dJNbd6N9yZs4bW7lf
        CXH8vha1D+dohRtUR3PtLPzVI7ChgDfx6triSxxKLMUZiYZazEXFiQBQd9HBMAIAAA==
X-CMS-MailID: 20180823115854eucas1p19532b92296003cb4fed2e7ed70015072
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180823115854eucas1p19532b92296003cb4fed2e7ed70015072
References: <CGME20180823115854eucas1p19532b92296003cb4fed2e7ed70015072@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v4.19. There are mostly small fixes and
cleanups for fb drivers (the biggest updates are for udlfb and pxafb
drivers). This PR also adds deferred console takeover support to the
console code and efifb driver. Please see the signed tag description
for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 334bb8972a131e604a741e9b284d8867190c723e:

  console: dummycon: export dummycon_[un]register_output_notifier (2018-06-29 11:46:19 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.19

for you to fetch changes up to f39684524b391c5a7ed0ac44db4fec3357af1c5d:

  Documentation/fb: corrections for fbcon.txt (2018-08-10 17:23:02 +0200)

----------------------------------------------------------------
fbdev changes for v4.19:

- add support for deferred console takeover, when enabled defers
  fbcon taking over the console from the dummy console until the
  first text is displayed on the console - together with the "quiet"
  kernel commandline option this allows fbcon to still be used
  together with a smooth graphical bootup (Hans de Goede)

- improve console locking debugging code (Thomas Zimmermann)

- copy the ACPI BGRT boot graphics to the framebuffer when deferred
  console takeover support is used in efifb driver (Hans de Goede)

- update udlfb driver - fix lost console when the user unplugs a USB
  adapter, fix the screen corruption issue, fix locking and add some
  performance optimizations (Mikulas Patocka)

- update pxafb driver - fix using uninitialized memory, switch to
  devm_* API, handle initialization errors and add support for
  lcd-supply regulator (Daniel Mack)

- add support for boards booted with a DeviceTree in pxa3xx_gcu
  driver (Daniel Mack)

- rename omap2 module to omap2fb.ko to avoid conflicts with omap1
  driver (Arnd Bergmann)

- enable ACPI-based enumeration for goldfishfb driver (Yu Ning)

- fix goldfishfb driver to make user space Android code use 60 fps
  (Christoffer Dall)

- print big fat warning when nomodeset kernel parameter is used in
  vgacon driver (Lyude Paul)

- remove VLA usage from fsl-diu-fb driver (Kees Cook)

- misc fixes (Julia Lawall, Geert Uytterhoeven, Fredrik Noring,
  Yisheng Xie, Dan Carpenter, Daniel Vetter, Anton Vasilyev, Randy
  Dunlap, Gustavo A. R. Silva, Colin Ian King, Fengguang Wu)

- misc cleanups (Roman Kiryanov, Yisheng Xie, Colin Ian King)

----------------------------------------------------------------
Anton Vasilyev (1):
      video: goldfishfb: fix memory leak on driver remove

Arnd Bergmann (1):
      omapfb: rename omap2 module to omap2fb.ko

Bartlomiej Zolnierkiewicz (3):
      Merge tag 'v4.18-rc2' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next
      Merge tag 'ib-fbdev-drm-v4.19-deferred-console-takeover' of https://github.com/bzolnier/linux into fbdev-for-next
      Merge tag 'ib-fbdev-drm-v4.19-deferred-console-takeover-fixup' of https://github.com/bzolnier/linux into fbdev-for-next

Christoffer Dall (1):
      video: fbdev: Set pixclock = 0 in goldfishfb

Colin Ian King (2):
      video: fbdev: tridentfb: remove deadcode on unreachable case statement
      omapfb: encoder-tpd12s015: remove redundant pointer 'in'

Dan Carpenter (2):
      video: fbdev: metronomefb: fix some off by one bugs
      fbdev: omapfb: off by one in omapfb_register_client()

Daniel Mack (6):
      dt-bindings: display: add devicetree bindings for pxa300-gcu
      video: fbdev: pxa3xx_gcu: add devicetree bindings
      video: fbdev: pxafb: clear allocated memory for video modes
      video: fbdev: pxafb: switch to devm_* API
      video: fbdev: pxafb: handle errors from pxafb_init_fbinfo() correctly
      video: fbdev: pxafb: Add support for lcd-supply regulator

Daniel Vetter (1):
      fbdev: fix modedb docs in fb_find_mode

Fredrik Noring (1):
      fbdev: Distinguish between interlaced and progressive modes

Geert Uytterhoeven (1):
      video: fbdev: simplefb: Stop including <linux/clk-provider.h>

Gustavo A. R. Silva (3):
      fbdev: fbmem: mark expected switch fall-through
      omapfb: Mark expected switch fall-throughs
      video: fbdev: mark expected switch fall-throughs

Hans de Goede (7):
      efi/bgrt: Drop __initdata from bgrt_image_size
      efifb: Copy the ACPI BGRT boot graphics to the framebuffer
      efifb: BGRT: Do not copy the boot graphics for non native resolutions
      fbcon: Only allow FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER if fbdev is builtin
      fbcon: Only defer console takeover if the current console driver is the dummycon
      dummycon: Stop exporting dummycon_[un]register_output_notifier
      fbcon: Do not takeover the console from atomic context

Julia Lawall (1):
      omapfb: encoder-tpd12s015: fix error return code

Kees Cook (1):
      video: fbdev: fsl-diu-fb: Remove VLA usage

Lyude Paul (1):
      video/console/vgacon: Print big fat warning with nomodeset

Mikulas Patocka (12):
      fb: fix lost console when the user unplugs a USB adapter
      udlfb: fix semaphore value leak
      udlfb: fix display corruption of the last line
      udlfb: don't switch if we are switching to the same videomode
      udlfb: make a local copy of fb_ops
      udlfb: set optimal write delay
      udlfb: handle allocation failure
      udlfb: set line_length in dlfb_ops_set_par
      udlfb: allow reallocating the framebuffer
      udlfb: optimization - test the backing buffer
      udlfb: avoid prefetch
      udlfb: use spin_lock_irq instead of spin_lock_irqsave

Randy Dunlap (4):
      fbdev/via: fix defined but not used warning
      fbdev: fix omap2/omapfb/dss/ indentation warning
      fb: amifb: fix build warnings when not builtin
      Documentation/fb: corrections for fbcon.txt

Roman Kiryanov (1):
      video: fbdev: Fix checkpatch warnings in goldfishfb.c

Thomas Zimmermann (2):
      console: Replace #if 0 with atomic var 'ignore_console_lock_warning'
      fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set

Yisheng Xie (2):
      fbcon: introduce for_each_registered_fb() helper
      fbdev: fix typo in comment

Yu Ning (1):
      video: fbdev: Enable ACPI-based enumeration for goldfishfb

kbuild test robot (3):
      fbdev: omap2: omapfb: fix boolreturn.cocci warnings
      fbdev: omap2: omapfb: fix bugon.cocci warnings
      fbdev: omap2: omapfb: fix ifnullfree.cocci warnings

 .../bindings/display/marvell,pxa2xx-lcdc.txt       |   3 +
 .../bindings/display/marvell,pxa300-gcu.txt        |  17 ++
 Documentation/fb/fbcon.txt                         |  29 +--
 drivers/firmware/efi/efi-bgrt.c                    |   2 +-
 drivers/video/console/Kconfig                      |   2 +-
 drivers/video/console/dummycon.c                   |   2 -
 drivers/video/console/vgacon.c                     |   5 +
 drivers/video/fbdev/amifb.c                        |   4 +-
 drivers/video/fbdev/core/fbcon.c                   |  70 +++----
 drivers/video/fbdev/core/fbmem.c                   |  56 +++--
 drivers/video/fbdev/core/modedb.c                  |  93 +++++----
 drivers/video/fbdev/efifb.c                        | 183 ++++++++++++++++
 drivers/video/fbdev/fsl-diu-fb.c                   |  23 ++-
 drivers/video/fbdev/goldfishfb.c                   |  15 +-
 drivers/video/fbdev/i740fb.c                       |   1 +
 drivers/video/fbdev/metronomefb.c                  |  10 +-
 drivers/video/fbdev/omap/omapfb_main.c             |   2 +-
 drivers/video/fbdev/omap2/omapfb/Makefile          |   4 +-
 .../omap2/omapfb/displays/encoder-tpd12s015.c      |  17 +-
 drivers/video/fbdev/omap2/omapfb/dss/core.c        |   3 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c       |   4 +-
 .../video/fbdev/omap2/omapfb/dss/dss_features.c    |   3 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |   3 +-
 drivers/video/fbdev/pm2fb.c                        |   2 +
 drivers/video/fbdev/pxa3xx-gcu.c                   |  10 +
 drivers/video/fbdev/pxafb.c                        |  97 ++++-----
 drivers/video/fbdev/pxafb.h                        |   3 +
 drivers/video/fbdev/simplefb.c                     |   2 +-
 drivers/video/fbdev/tdfxfb.c                       |   1 +
 drivers/video/fbdev/tridentfb.c                    |   3 -
 drivers/video/fbdev/udlfb.c                        | 230 +++++++++++++--------
 drivers/video/fbdev/via/lcd.c                      |   1 +
 drivers/video/fbdev/via/viafbdev.c                 |   3 +-
 include/linux/console.h                            |  14 +-
 include/linux/fb.h                                 |  10 +-
 include/video/udlfb.h                              |   6 +-
 kernel/printk/printk.c                             |   3 +
 37 files changed, 640 insertions(+), 296 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/marvell,pxa300-gcu.txt

