Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2700264-1524130554-2-11022533203270181494
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524130553; b=kv9SXBGhdD2qIQ42DTiv81CU9oIWnk8lkkfP2K626jwH2dBK4X
    cWWh+6txxfX4A0LYYqqHJYK+X8hw5h8M46APbm4v2pmzeYRbSOw4vayeUxvHh+14
    IzE6q+vZYKShANFczJLDf08AFUmemXLvol++jHJyZG0ukY51JRQQj4IuY9Kx8B+S
    Ia9n345wNdyoQo0/k9go3U2+MabKS82jT85mTurfeF/dGl9hyrTFGDmZow9gdX2p
    yo7+7a9euawVsOKk9kIhor2qQuZGxAObs2NGVuT/yQPA3Td/kT8JdVyAHGx1LsFa
    gFFLfyXYJfhJRruzHjshDk/55xyAIhyubqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1524130553; bh=tb4w
    Y/qfuR3U+dyC6Z3NmKoSZ582ACrc32juI/8yK+4=; b=EkENBMz9LiF2qy2eFqmO
    PiqvHG44Ezp5KD1HIktWKbIb2ke/4mKskBPWdAmo/frA+6SuZE2MUdaBHYZYoTyx
    iTU1A9rMZXjPuD6Abg66JUM8QGAJnapoGNm4jc1EILdIPQjcaicEWEwoITBd3hxo
    UMgfKy1hQKIiEPHHFQN/HK/6jCLUU88UD4Zv3WXUivFRX7GcZoT0RbWSirV6FRu/
    jStwni2cxv+j7vUoDDTrjIEh9LPVHYfClBJgMMH4hKVSzHXReLuo4Af3wZWGl75U
    rHM5ynSKlzbpnIdzscsAdrEdraoOXHQGL93mm2eSjf1wRN5k5Ve8SlBodzkyLk8v
    qg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VjlOG9kN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J7UI5S6H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VjlOG9kN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J7UI5S6H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGn2IGn6dCvFHyuecIz1Hz+zUGDx5puFjsbTvtdvdTHR/8mdvcQj8ZwpIoaNBFhLvEg06EwlYaib896saCsMQiCh5xYiNHJRH9qpCcLBHqw1XM6rqv7l
    mJRrgmjL/U9DIOZ9n2CHJA79OYzFLwCciKLdVGWmALdEhci1Y/ZLiYNTy3WdWPO6Q1jp7jaYYGAN/WQhYAcsroqtSAfLN7ONHInbnXjbK4RSB0I8U/kfSCvk
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=07d9gI8wAAAA:8 a=nmuF-vKtuHuwG_LSgzQA:9 a=QEXdDO2ut3YA:10
    a=l1He_3m2cmAA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=e2CUPOnPG4QKp8I52DXD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeDSJfh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 05:35:37 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39325 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeDSJfe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 05:35:34 -0400
X-Google-Smtp-Source: AB8JxZrbpfl+01GZpjl0VQ6kn7RFnhWRd52KvlCmoy8l6EXWYEnOUANc1B3EdV2RHGkBy3BiogwTKdUAZF1XhTN6MZY=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 11:35:33 +0200
X-Google-Sender-Auth: bcw-StXelNpsDQdtGc-ZwKMrt8M
Message-ID: <CAK8P3a2CEK=4Os4gbnXbR7VJJgaXVQ7NLjihr7rvMSK6g3_tNA@mail.gmail.com>
Subject: [tip GIT PULL] y2038: timekeeping syscall changes
To: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git+ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-timekeeping

for you to fetch changes up to 2e294d2c97d6683fcdf1134d87be1c461dff8ffd:

  nanosleep: change time types to safe __kernel_* types (2018-04-19
10:07:58 +0200)

----------------------------------------------------------------
y2038: timekeeping syscall changes

This is the first set of system call entry point changes to enable 32-bit
architectures to have variants on both 32-bit and 64-bit time_t. Typically
these system calls take a 'struct timespec' argument, but that structure
is defined in user space by the C library and its layout will change.

The kernel already supports handling the 32-bit time_t on 64-bit
architectures through the CONFIG_COMPAT mechanism. As there are a total
of 51 system calls suffering from this problem, reusing that mechanism
on 32-bit architectures.

We already have patches for most of the remaining system calls, but this
set contains most of the complexity and is best tested.  There was one
last-minute regression that prevented it from going into 4.17, but that
is fixed now.

More details from Deepa's patch series description:

   Big picture is as per the lwn article:
   https://lwn.net/Articles/643234/ [2]

   The series is directed at converting posix clock syscalls:
   clock_gettime, clock_settime, clock_getres and clock_nanosleep
   to use a new data structure __kernel_timespec at syscall boundaries.
   __kernel_timespec maintains 64 bit time_t across all execution modes.

   vdso will be handled as part of each architecture when they enable
   support for 64 bit time_t.

   The compat syscalls are repurposed to provide backward compatibility
   by using them as native syscalls as well for 32 bit architectures.
   They will continue to use timespec at syscall boundaries.

   CONFIG_64_BIT_TIME controls whether the syscalls use __kernel_timespec
   or timespec at syscall boundaries.

   The series does the following:
   1. Enable compat syscalls on 32 bit architectures.
   2. Add a new __kernel_timespec type to be used as the data structure
      for all the new syscalls.
   3. Add new config CONFIG_64BIT_TIME(intead of the CONFIG_COMPAT_TIME in
      [1] and [2] to switch to new definition of __kernel_timespec. It is
      the same as struct timespec otherwise.
   4. Add new CONFIG_32BIT_TIME to conditionally compile compat syscalls.

----------------------------------------------------------------
Arnd Bergmann (2):
      compat: add an asm-generic/compat.h file
      sparc: compat: allow including asm/compat.h for 32-bit

Deepa Dinamani (10):
      compat: Make compat helpers independent of CONFIG_COMPAT
      include: Move compat_timespec/ timeval to compat_time.h
      compat: enable compat_get/put_timespec64 always
      arch: introduce CONFIG_64BIT_TIME
      arch: Introduce CONFIG_COMPAT_32BIT_TIME
      posix-clocks: Make compat syscalls depend on CONFIG_COMPAT_32BIT_TIME
      include: Add new y2038 safe __kernel_timespec
      fix get_timespec64() for y2038 safe compat interfaces
      change time types to new y2038 safe __kernel_* types
      nanosleep: change time types to safe __kernel_* types

 arch/Kconfig                           | 15 +++++++++
 arch/alpha/include/asm/Kbuild          |  1 +
 arch/arc/include/asm/Kbuild            |  1 +
 arch/arm/include/asm/Kbuild            |  1 +
 arch/arm64/include/asm/compat.h        | 11 -------
 arch/arm64/include/asm/stat.h          |  1 +
 arch/arm64/kernel/hw_breakpoint.c      |  1 -
 arch/arm64/kernel/perf_regs.c          |  2 +-
 arch/c6x/include/asm/Kbuild            |  1 +
 arch/h8300/include/asm/Kbuild          |  1 +
 arch/hexagon/include/asm/Kbuild        |  1 +
 arch/ia64/include/asm/Kbuild           |  1 +
 arch/m68k/include/asm/Kbuild           |  1 +
 arch/microblaze/include/asm/Kbuild     |  1 +
 arch/mips/include/asm/compat.h         | 11 -------
 arch/mips/kernel/signal32.c            |  2 +-
 arch/nds32/include/asm/Kbuild          |  1 +
 arch/nios2/include/asm/Kbuild          |  1 +
 arch/openrisc/include/asm/Kbuild       |  1 +
 arch/parisc/include/asm/compat.h       | 11 -------
 arch/powerpc/include/asm/compat.h      | 11 -------
 arch/powerpc/kernel/asm-offsets.c      |  2 +-
 arch/powerpc/oprofile/backtrace.c      |  1 +
 arch/s390/hypfs/hypfs_sprp.c           |  1 -
 arch/s390/include/asm/compat.h         | 11 -------
 arch/s390/include/asm/elf.h            |  4 +--
 arch/s390/kvm/priv.c                   |  1 -
 arch/s390/pci/pci_clp.c                |  1 -
 arch/sh/include/asm/Kbuild             |  1 +
 arch/sparc/include/asm/compat.h        | 15 +++------
 arch/um/include/asm/Kbuild             |  1 +
 arch/unicore32/include/asm/Kbuild      |  1 +
 arch/x86/events/core.c                 |  2 +-
 arch/x86/include/asm/compat.h          | 11 -------
 arch/x86/include/asm/ftrace.h          |  2 +-
 arch/x86/kernel/sys_x86_64.c           |  2 +-
 arch/xtensa/include/asm/Kbuild         |  1 +
 drivers/s390/block/dasd_ioctl.c        |  1 -
 drivers/s390/char/fs3270.c             |  1 -
 drivers/s390/char/sclp_ctl.c           |  1 -
 drivers/s390/char/vmcp.c               |  1 -
 drivers/s390/cio/chsc_sch.c            |  1 -
 drivers/s390/net/qeth_core_main.c      |  2 +-
 include/asm-generic/compat.h           |  3 ++
 include/linux/compat.h                 | 12 ++++---
 include/linux/compat_time.h            | 23 ++++++++++++++
 include/linux/restart_block.h          |  7 ++--
 include/linux/syscalls.h               | 13 ++++----
 include/linux/time.h                   |  4 +--
 include/linux/time64.h                 | 10 +++++-
 include/uapi/asm-generic/posix_types.h |  1 +
 include/uapi/linux/time.h              |  7 ++++
 kernel/compat.c                        | 52 +++++-------------------------
 kernel/time/hrtimer.c                  | 10 ++++--
 kernel/time/posix-stubs.c              | 12 ++++---
 kernel/time/posix-timers.c             | 24 ++++++++++----
 kernel/time/time.c                     | 58 +++++++++++++++++++++++++++++++---
 57 files changed, 201 insertions(+), 176 deletions(-)
 create mode 100644 include/asm-generic/compat.h
 create mode 100644 include/linux/compat_time.h
