Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeBTWAY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:00:24 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:40517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeBTWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/7] ARM: hacks for link-time optimization
Date: Tue, 20 Feb 2018 22:59:47 +0100
Message-Id: <20180220215954.4092811-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:o7f1Gn6TLGoH5jFDw7L/c2+UGbV0/dLfe6G4NgixkWqOp0+3WlH
 NwrKZ4Vam26XzvCcpkMj+mPLeiIslJYMEyqLpyfh+zldg0yNMDYEt1k6P2wUREClYOnFLf1
 x9YyxlnAvcql4IuqJv2oS/yBbMEUFL4YS5ONXZ2d00rpVKXxL2zYTfmJp83PIfu1t7F1wvr
 yjsAKEBNFWJujgCDxDI4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mjh2PvRB9Ms=:ik2PVyf6UHj+AoTsD7ASQT
 LdtmSj+2lEeZU1oiYQYempbFNMbbB1AUbOM0rAbmd51R5sEpcvhORpVmef7HEgJzCCfPt2zfr
 /kehXVDARRHZKTZiRRHmDC7DG4jruuCzbikdmHfA7dL9h+6HN90gp7yek0rMEg/1T4rrZ158C
 BYQsGKe8m9TKPC6oTJ0Ognl7he+wGw8yyXKNPpDoOuS1YO3/HYC/TG5WA6YAepSaf8kpX6sI5
 XbOXBPamiVX06puNIylA+72zvz52+X/eVNr2fdbA9z63KzAXbFCAROlkuOUb7IHHSzjRM3enz
 8GU/sOn7Sy+hiBESWOar2jlZEzdF02a08GtVCdBIsU0ewzvzfsEaIx6vp+t4xSMFwFdFqW9FW
 NiMeMCk9CDYSBwb7jNpLR6CNzmIzzlRn3JA7lap2PZTfCtj42CV1bvqx/faiByeMzuInQR9du
 sNQrIZqWJZM3TqU0kYko0u/XuVgg53eRK6WQ8wnawnrK40a/742oUgXt+Q81sm/L1CxXL15u3
 +X7TBCgar7HROKurU9xXxtOV1LX6cdhxyUf6IZc1PzyF2PsS3ndmB5rBdSgCRnb55KIIbXexs
 j1UAvtHGynfc+dQT452vSBcfEdhwsWhoOcWEbrtdV6rOFfkMmZ2Pon7xloE0o8yXKGKAdbttP
 OuncO9ocM1r64hjUKjj6om96slzRgLu9MDq+32SXQcCUuZuDdQn6JdXc4SBNPt8wkLtoze6Eu
 94PTbYJXg0OtTq06M8Di1Tm62W2dXrvRlEIvuQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico, all,

I was playing with ARM link-time optimization handling earlier this
month, and eventually got it to build cleanly with randconfig kernels,
but ended up with a lot of ugly hacks to actually pull it off.

Here are the ones that I don't think we actually want to merge,
but it may be helpful to have these for reference for the next
person that tries to make it work.

      Arnd

Arnd Bergmann (7):
  ARM: disallow combining XIP and LTO
  ARM: LTO: avoid THUMB2_KERNEL+LTO
  [HACK] pass endianess flag to LTO linker
  ARM: io-acorn: fix LTO linking without CONFIG_PRINTK
  ARM: fix __inflate_kernel_data stack warning for LTO
  ARM: mark assembler-referenced symbols as __visible
  efi: disable LTO for EFI stub

 arch/arm/Kconfig                      |  4 +++-
 arch/arm/Makefile                     |  2 ++
 arch/arm/kernel/Makefile              |  3 ---
 arch/arm/kernel/head-inflate-data.c   |  3 ++-
 arch/arm/kernel/process.c             |  2 +-
 arch/arm/kernel/suspend.c             |  2 ++
 arch/arm/kernel/unwind.c              |  1 +
 arch/arm/lib/io-acorn.S               |  4 ++++
 arch/arm/probes/kprobes/core.c        |  2 +-
 arch/arm/probes/kprobes/test-core.c   | 11 ++++++-----
 arch/arm/vdso/vgettimeofday.c         |  2 ++
 drivers/bus/arm-cci.c                 |  6 +++---
 drivers/firmware/efi/libstub/Makefile |  4 +++-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c   |  2 +-
 lib/clz_ctz.c                         | 20 ++++++++++----------
 15 files changed, 41 insertions(+), 27 deletions(-)

-- 
2.9.0
