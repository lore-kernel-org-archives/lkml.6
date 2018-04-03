Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDCTXK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:23:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:55931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752132AbeDCTXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:23:08 -0400
Date: Tue, 3 Apr 2018 21:22:56 +0200
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for 4.17
Message-ID: <20180403192256.GA4750@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K0:nij4qkNydkRMI/gyHA6NOhyFshTpJN8QW7QN+qkvC2JSDRFfUMJ
 TBRw3pp+y9E1Be7Bk/v+Y7jxjLgO72kiUlDQwNWzmTC04BKhv+iMeRT1qv23qgwt4f8/eh2
 i8bM5KdJw3VUjWBhLJMVGKLKQdHQWQ28Z+fJfdHhp6lIpgGq6K8+27a4gaDXLUoO/jZyWK4
 vlvPRiMi6gQIDex7GvqnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ydqu2f4WXvw=:5SvFHbs0FnHoyAJRMS1f/B
 fEULugcjjdqWGzufx4vecfq6wpzSmxO9xDvdzUk8coZSfz6bL1R1IRtgZDPJielDdJaXMjHEy
 Pm6dz6MgvIu08PQkjPa7QMD9aiCDbdsNOwj3qFv0sqNY7nb1M7VeK4YGl6j4I32OO3k3oN2Bj
 kzhysHpC7ES5LXNeCS98OZUi2YkF9pCuCYLqXOKpCEY8iLDkJfqddJISUoDrhg5pPQEo1Zlo6
 Hot0DPpDUN/av36pj/V+jAkH2R8/QhM0y5yIQ0olzv6TaMlAH+qi9c+haFL4Qu0QWTyvfWuvi
 Ez1mkoclHOmzSV/+r/H7ldRbblqjsCS7iXLOxWyqN5SpPYQVLjmhsyHvrnAt3pf6r9dvBB1Mw
 nw6OSaXLvB8wPARRRWl0QNPmKowu25RebNZDqNsQPV43Kk10jEtO/A4bHb/F/mOALTOgk1Sru
 UXVzpjeRT2ec+5np70aQ0L2zAWGBUVw+xaloNBzJ4HYGO8oMltr26bMWfAMuZ2Foz7C0nXihu
 FnBHrW/FbA0ed1aU+7FXImiQvl6kRD9aM82lwSdg6z9yaVyE/MGgUN52Y25z42/3QIDlz5xSs
 WmlMK5ersZZwV4u184cR1zCIxAiqu0WSU143gnRhgDMO6uJHLy3EO6EL5px2kfve9u6L5qI/g
 UV45d0hd5J2Lwn72bHiIkPQa7c6/pzFip2VdFDZkqMit+PKtYeWwgRTsMmLNIMpP98/h1rfPy
 BHWRVjeEGdVLFA05lb5zs/aVVQYxvhwED2Prr6KrBOI3WcJPaG/oEJlSzXhTYDi/8lDZUeejZ
 md+4CvMPN2Xg/BLV6eP+/X5tfnQrj5Y4UJo/MCL4uq/rB4EV9o=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the updates regarding the parisc architecture for kernel 4.17 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.17-1

Lots of small enhancements and fixes in this patchset:
- improved the x86-64 compatibility for PCI cards by returning -1UL for timed
  out MMIO transactions (instead of crashing)
- fixed HPMC handler for PAT machines: size needs to be mulitple of 16 
- prepare machine_power_off() to be able to turn rp3410 and c8000 machines off
  via IMPI
- added code to extract machine info for usage with qemu
- some init sections fixes 
- lots of fixes for sparse-, ubsan- and uninitalized variables warnings. 

Thanks,
Helge

----------------------------------------------------------------
Dan Carpenter (1):
      parisc: Silence uninitialized variable warning in dbl_to_sgl_fcnvff()

Helge Deller (14):
      parisc/stifb: Use fb_memset() to avoid sparse warning
      parisc/parport_gsc: Use NULL to avoid sparse warning
      parisc/led: Fix sparse warnings
      parisc/gscps2: Fix sparse warnings
      parisc: Force to various endian types for sparse
      parisc: Convert MAP_TYPE to cover 4 bits on parisc
      parisc: Move various functions and strings to init section
      parisc/Kconfig: SMP kernels boot on all machines
      parisc: machine_power_off() should call pm_power_off()
      parisc: Directly call machine_power_off() in power button driver
      parisc: Fix HPMC handler by increasing size to multiple of 16 bytes
      parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode
      parisc: Add code generator for Qemu/SeaBIOS machine info
      parisc: Fix out of array access in match_pci_device()

 arch/parisc/Kconfig                 |   6 +-
 arch/parisc/include/asm/io.h        |  12 +--
 arch/parisc/include/uapi/asm/mman.h |   2 +-
 arch/parisc/kernel/drivers.c        | 197 ++++++++++++++++++++++++++++++++++--
 arch/parisc/kernel/hardware.c       |  12 +--
 arch/parisc/kernel/hpmc.S           |   6 +-
 arch/parisc/kernel/process.c        |   6 +-
 arch/parisc/math-emu/fcnvff.c       |   2 +-
 drivers/input/serio/gscps2.c        |  11 +-
 drivers/parisc/lba_pci.c            |  20 +++-
 drivers/parisc/led.c                |   4 +-
 drivers/parisc/power.c              |   3 +-
 drivers/parport/parport_gsc.c       |   2 +-
 drivers/video/fbdev/stifb.c         |   2 +-
 14 files changed, 241 insertions(+), 44 deletions(-)
