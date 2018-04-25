Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-721450-1524662715-2-15199231746376537999
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524662714; b=SW6VgPv6MWbfpHuCv5f/or4c+gQwajV4FhCwj+I4vxj2EB9Pj1
    XN58a4E+DyVwsUFrYWwZMID8/UmtVDA8vXON8HQdyWtPLPfuDEmljyPUromPh81K
    xPoR5+h+sPA/LZ9mrdA2Ots1tCu9ZqRf2ExeRNFqECUVo3Ev4YBVioZqMBAKTmRp
    /yhmgq6gPWkUOn4WzSlRJHSrIatDKeIuFVlVLL17eCI2Q9nNPR9yNI5bOcdk0DHm
    1pVY0bk/gBM4CaebRqwetu1dJGgu99fqNNLr3PR8pQt/BYpv5JQIXM9C8tNlOPxz
    ZedF1s65A+kCf7I3IWMdlEph7AST4mneeCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524662714; bh=hdCMpyrPyxkSO/oOoE5ts7/gn2Z96/
    syOSvJ9E2xvhY=; b=FPPejggEfjvlVJDQHml9uOft63OUKtj2WnYQbZvlyJh8gW
    avK/7FVMpHC1AvrIz2G5E9GFFsaFAndVuvalv/dl6Rz3Xy5mG/hwfPaaADp4TU0h
    VtIpG48B2/NibM0NA8mvFnLvOwDjHJJP4nCT9b5F2v5SR0no9Av3CahBTpdn+7XG
    RG1ZXINk1cA8Kgm+fJsFIhI9ozgrAD4ULLUj7W2YTp6eI7YezxLk7TyHFUYvTsBH
    AqC0IJutFZo+QcMpyqsg/C8LLGKkX8KKlgZqeyt2bV3k/VZACUUFIGL2LGUig53m
    bK4hZNkGKFiRGNGKmfnxlBWp3dEZRxWY4gdXjudQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO2yDjK8eOuEEgWoSrou5Fc+dCd4F9igSVornXxxiIm/Bv/jQmA0q9jKvtzP3nthcGvX5u/yNWkQM4m7Zo1QVy6tH9RdPeVm+SbkAXk2Vly4CgTjs5YR
    Tm85pcZK26cQp7R2dC92dwHnCQ+r96d9o6Lz5VmNX8B1mN8RfRcaDKkQJW0Nn0pmmJ8BdNxMT1N3NL2HIjk9+HMaPNlvlTmWCP3GzB1SJylQ4kVvmVFLJ9K4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=D19gQVrFAAAA:8 a=07d9gI8wAAAA:8 a=CCpqsmhAAAAA:8 a=pGLkceISAAAA:8
    a=drOt6m5kAAAA:8 a=PtDNVHqPAAAA:8 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
    a=WPyIoOwQAAAA:8 a=voM4FWlXAAAA:8 a=VUfPOBp7AAAA:8 a=zRKSN_ymZh5WFrUDXNAA:9
    a=BQRS6hk8D5IxXqjW:21 a=BYnAbo6rVxRYw5Bm:21 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22 a=e2CUPOnPG4QKp8I52DXD:22
    a=ul9cdbp4aOFLsgKbc677:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=BpimnaHY1jUKGyF_4-AF:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=IC2XNlieTeVoXbcui8wp:22
    a=h9p_k6br8ecoN9AbG9pA:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbeDYNY5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 09:24:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:40393 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753858AbeDYNYx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 09:24:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, Zack Weinberg <zackw@panix.com>,
        Jeffrey Walton <noloader@gmail.com>
Subject: [GIT PULL, PATCH v4 00/16] y2038: IPC system call conversion
Date: Wed, 25 Apr 2018 15:22:26 +0200
Message-Id: <20180425132242.1500539-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Pxx1C6G4nzTiInwNHSMQFjxsQOwbj79wdFMRP+JGKzLN3Yodhn6
 VLxQr9XrXi3HI9db/cKpueEPblfnyaS/Jj55XdtT/Fvc6hIeEyPBjiv6tLf+4DHqjrVIWT2
 XFGUmwHUsRE+IwQdVcAxYxfjyZlQzUU6RjynM1mQ5DhqVUOugSniO3YFRGQJ0uVx8lKUiRM
 En+JxsJRyzbkgxfDLctgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kgI/HKx9hdQ=:KM+DWDYgPd5zB8ovDbOV5A
 IjmrmuTvjjYNwBw0mh7KqrxGPC3Ce7KHXt0EOZL9/h0P6ATHPsAVb/Kh0sKRCxyKtlDzAJizh
 PK9nvVOfyl2AQv2ukv548xRbkwqZHaA3pqXX/z2lkm0mH8I3FXooEQLG6jK6SqEv+u/tU3CEo
 6xGHHsnWaL7r3grsDSJZ0EfZokd3Nn5DHsDtq0KnA3f3riGipKLCr3SpiFDGIZ8ZHWfDjrybL
 95IVP21HQy7ZMGCYET5VpoCo1UjB71a3OLpM3eiuGrWlXXSd3rxa+OutIlN5DDl5DymdBL/zo
 zwVoeysLELSAtnjuH4QWNnE5TZj/kxXklzL7TKlk/QrLf7G4p4u4q3LEzN0PvrEIiKyRjTD14
 cwJ4doe5Ren4qMBm9+0oRNoEEVDLkTP5fqpOU+AkeranH+yh3+uSD0snqbV7cR7jO6BeYHeLb
 o2j/MXU8/ZT+OacEnqp1IOdMyzrRSkiSyw41HGFUq7WWXGZv7LdOOCnwjprejoEiCmUTEmrdH
 iHbSBIhix8zWkqxPY6dJD+uQXWSbAt4/u2gpRm4isVkxsP6QL5cJkuOGQxelpC3E3U+tls7PN
 jcw36IHJyswRz59ecAkpSt4IoxEIjtz1E/tj48zkX+HvMucQujDEAuAumNaapph3Mbn7dN1e2
 tk7KiAjtRlB0zjg6pPs4XF5BgugEkRjW1+RkBSdyjR6BiTMd3tlOjVD9V2PClRAM/tf6Hd6nc
 rxDh0WLvXMwjYA7Ohum/cXOWCY5E+y/pZEWtnw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Thomas,

This is a small update to last week's patch series, I hope I
have worked out all the remaining issues now. If nothing else
comes up, please pull into tip for 4.18. The commits are
based on top of what you already pulled into timers/core, so
you can either add these to the same branch or to a different
one.

I'll be away for three weeks starting on Sunday, so if new
issues get found, I won't be able to address them until I get
back home. I'll post another set of simpler syscall patches for
review after this, and there is at last a fourth set of those
that are not ready yet, but is available for preview at [3],
which also contains unrelated y2038 patches for random
subsystems.

      Arnd

----------------------------------------------------------------
The following changes since commit 01909974b41036a6a8d3907c66cc7b41c9a73da9:

  time: Change nanosleep to safe __kernel_* types (2018-04-19 13:32:03 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-ipc

for you to fetch changes up to 5dc0b1529d21b54aad4098874e334a52027fd16d:

  y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop (2018-04-20 16:20:30 +0200)

----------------------------------------------------------------
y2038: IPC system call conversion

This is a follow-up to Deepa's work on the timekeeping system calls,
providing a y2038-safe syscall API for SYSVIPC. It uses a combination
of two strategies:

For sys_msgctl, sys_semctl and sys_shmctl, I do not introduce a completely
new set of replacement system calls, but instead extend the existing
ones to return data in the reserved fields of the normal data structure.

This should be completely transparent to any existing user space, and
only after the 32-bit time_t wraps, it will make a difference in the
returned data.

libc implementations will consequently have to provide their own data
structures when they move to 64-bit time_t, and convert the structures
in user space from the ones returned by the kernel.

In contrast, mq_timedsend, mq_timedreceive and and semtimedop all do
need to change because having a libc redefine the timespec type
breaks the ABI, so with this series there will be two separate entry
points for 32-bit architectures.

There are three cases here:

- little-endian architectures (except powerpc and mips) can use
  the normal layout and just cast the data structure to the user space
  type that contains 64-bit numbers.

- parisc and sparc can do the same thing with big-endian user space

- little-endian powerpc and most big-endian architectures have
  to flip the upper and lower 32-bit halves of the time_t value in memory,
  but can otherwise keep using the normal layout

- mips and big-endian xtensa need to be more careful because
  they are not consistent in their definitions, and they have to provide
  custom libc implementations for the system calls to use 64-bit time_t.

----------------------------------------------------------------
Changes to v3:
- reworked x86 portion after discovering an old bug, submitted
  a fix for that separately.
- use consistent types in asm-generic based on feedback from
  Jeffrey Walton

Changes to v2:
- added patches for mq_timedsend, mq_timedreceive and and semtimedop
  system calls
- add asm-generic/compat.h changes to prepare for actually using those
  on 32-bit.
- fix 'make headers_install' as reported by Heiko Carstens
- fix MIPS build as reported by build bot
- Cc everyone on all patches as originally intended, not just on the
  cover letter.

Changes to v1 [1]:
- Rebased to the latest kernel (4.17-rc)
- Dropped changes for removed architectures
- Simplified the IPC code changes, based on prior work from
  both Deepa and Eric
- Fixed a few bugs that I found during rebasing, in parcular the
  sparc version was incorrect.


[1] https://lkml.org/lkml/2015/5/20/605
[2] https://lwn.net/Articles/751676/
[3] git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-next

----------------------------------------------------------------

Arnd Bergmann (16):
  y2038: asm-generic: Extend sysvipc data structures
  y2038: x86: Extend sysvipc data structures
  y2038: alpha: Remove unneeded ipc uapi header files
  y2038: ia64: Remove unneeded ipc uapi header files
  y2038: s390: Remove unneeded ipc uapi header files
  y2038: arm64: Extend sysvipc compat data structures
  y2038: mips: Extend sysvipc data structures
  y2038: parisc: Extend sysvipc data structures
  y2038: sparc: Extend sysvipc data structures
  y2038: powerpc: Extend sysvipc data structures
  y2038: xtensa: Extend sysvipc data structures
  y2038: ipc: Use ktime_get_real_seconds consistently
  y2038: ipc: Report long times to user space
  y2038: ipc: Use __kernel_timespec
  y2038: ipc: Enable COMPAT_32BIT_TIME
  y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop

Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: libc-alpha@sourceware.org
Cc: tglx@linutronix.de
Cc: deepa.kernel@gmail.com
Cc: viro@zeniv.linux.org.uk
Cc: ebiederm@xmission.com
Cc: albert.aribaud@3adev.fr
Cc: linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com
Cc: x86@kernel.org
Cc: catalin.marinas@arm.com
Cc: will.deacon@arm.com
Cc: linux-mips@linux-mips.org
Cc: jhogan@kernel.org
Cc: ralf@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: Zack Weinberg <zackw@panix.com>
Cc: Jeffrey Walton <noloader@gmail.com>

 arch/alpha/include/uapi/asm/Kbuild     |  4 ++
 arch/alpha/include/uapi/asm/ipcbuf.h   |  2 -
 arch/alpha/include/uapi/asm/msgbuf.h   | 28 -----------
 arch/alpha/include/uapi/asm/sembuf.h   | 23 ---------
 arch/alpha/include/uapi/asm/shmbuf.h   | 39 ---------------
 arch/arm64/include/asm/compat.h        | 32 ++++++-------
 arch/ia64/include/uapi/asm/Kbuild      |  4 ++
 arch/ia64/include/uapi/asm/ipcbuf.h    |  2 -
 arch/ia64/include/uapi/asm/msgbuf.h    | 28 -----------
 arch/ia64/include/uapi/asm/sembuf.h    | 23 ---------
 arch/ia64/include/uapi/asm/shmbuf.h    | 39 ---------------
 arch/mips/include/asm/compat.h         | 40 +++++++++-------
 arch/mips/include/uapi/asm/msgbuf.h    | 57 ++++++++++++++--------
 arch/mips/include/uapi/asm/sembuf.h    | 15 +++++-
 arch/mips/include/uapi/asm/shmbuf.h    | 23 ++++++++-
 arch/parisc/include/asm/compat.h       | 32 ++++++-------
 arch/parisc/include/uapi/asm/msgbuf.h  | 33 +++++++------
 arch/parisc/include/uapi/asm/sembuf.h  | 16 +++----
 arch/parisc/include/uapi/asm/shmbuf.h  | 19 ++++----
 arch/powerpc/include/asm/compat.h      | 32 ++++++-------
 arch/powerpc/include/uapi/asm/msgbuf.h | 18 +++----
 arch/powerpc/include/uapi/asm/sembuf.h | 14 +++---
 arch/powerpc/include/uapi/asm/shmbuf.h | 19 ++++----
 arch/s390/include/asm/compat.h         | 32 ++++++-------
 arch/s390/include/uapi/asm/Kbuild      |  3 ++
 arch/s390/include/uapi/asm/msgbuf.h    | 38 ---------------
 arch/s390/include/uapi/asm/sembuf.h    | 30 ------------
 arch/s390/include/uapi/asm/shmbuf.h    | 49 -------------------
 arch/sparc/include/asm/compat.h        | 32 ++++++-------
 arch/sparc/include/uapi/asm/msgbuf.h   | 22 ++++-----
 arch/sparc/include/uapi/asm/sembuf.h   | 16 +++----
 arch/sparc/include/uapi/asm/shmbuf.h   | 21 ++++-----
 arch/x86/include/asm/compat.h          | 32 ++++++-------
 arch/x86/include/uapi/asm/sembuf.h     | 11 ++++-
 arch/xtensa/include/uapi/asm/msgbuf.h  | 25 +++++-----
 arch/xtensa/include/uapi/asm/sembuf.h  | 17 ++++---
 arch/xtensa/include/uapi/asm/shmbuf.h  | 37 ++++-----------
 include/linux/syscalls.h               |  6 +--
 include/uapi/asm-generic/msgbuf.h      | 27 +++++------
 include/uapi/asm-generic/sembuf.h      | 26 ++++++----
 include/uapi/asm-generic/shmbuf.h      | 41 ++++++++--------
 ipc/mqueue.c                           | 86 +++++++++++++++++-----------------
 ipc/msg.c                              | 20 +++++---
 ipc/sem.c                              | 27 +++++++----
 ipc/shm.c                              | 14 ++++--
 ipc/syscall.c                          | 13 +++--
 ipc/util.h                             |  4 +-
 47 files changed, 471 insertions(+), 700 deletions(-)
 elete mode 100644 arch/alpha/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/sembuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/shmbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/sembuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/shmbuf.h
 delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
 delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h

-- 
2.9.0

