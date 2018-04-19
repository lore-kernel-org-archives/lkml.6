Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3309672-1524149075-2-18063860106330739436
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
    1524149075; b=qJVbeVr9pH2sTEJTyJAhni+k3lHgoN6Kpr82qm5tjOQs7sAHNz
    /qBOyJn4vtOd1E2tSgYUKfvagYspIM42hXJKn/eM+K5aXka1wzalq8ZdKTd0luNM
    IIG+ASXUXiESwtjRdPCK2kf1bws0HeO2C90y3gUsM4balmTVRCtHm+9R/9kwOnGF
    jWCHspbDghzf22UbF1z4zIf0VXGRbcM66V4OHw8deZ+qWUZYSlNqYQYiiKMXvXO8
    GnBdMfzH5zqg1Y/+SztL2BF2r+RO+3HvzmxndBZDVm+U7FkpZvVxTg7RBXbn9qUY
    Bqkk3eFpts6tEYdv9sKPLwnjpvt2r/HxPtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524149075; bh=EI+n4sVhe6ZzQSKV8xIsGM9qW7FV8y
    Z2sHnFTY/Q1Q0=; b=bBocX3S4JWPyF12yxomAPcTU0eEVnCYpWaxJW8HyU/9OZC
    TbPLvJQbhxYTxDmfwQcEeFvjlsiCFUqtT6pCHjAy76RFku9h6CYIrw7Yzj5+bgaC
    wtIW3d8Shuyf3qu9NNppggnWXGjHyTr2Sw/H2dqnUTPognzsTwK9EVS/X1/FPL3r
    3+262hQ5ow1Ocw/SPZPgcrWxFuV4f9kSEXIvjkRre17t93tfdXhTiXlAAMs2ejTh
    9WYsqjJzI0j6rRWW2Du0v/IoTqRBhgHcXDivDQluZl+Kv+6aF3oRyAjQIGG+hKm3
    dtVMtcfMrRuAdKBPM9ZmhBELwVvwaq9PKA4OJrtA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKMZ1Wo6mX2QVogXMtv26BfEXitARzkjzPIRWbyRQtBRpwCIlJHMDwSLCxWdrSrsGEmb6kgh+vbgi2SND10Fs1ggzYGnHjo8TPLW8qTeosOXH+juCxun
    LF0SVMMpofdozsfXkWPJiBe5EM0ODA1dta/bZSxuONZec94MLo4vYyK5KXZVeCX9y4cHBAaBnaOlGpcIOgBKj+sSnHQG0NmF1y1an3W25126aZLqMo8bMLcB
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=D19gQVrFAAAA:8
    a=07d9gI8wAAAA:8 a=VwQbUJbxAAAA:8 a=CCpqsmhAAAAA:8 a=pGLkceISAAAA:8
    a=drOt6m5kAAAA:8 a=PtDNVHqPAAAA:8 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
    a=WPyIoOwQAAAA:8 a=voM4FWlXAAAA:8 a=xGX7gT0K8vKGhRngJ-gA:9 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=e2CUPOnPG4QKp8I52DXD:22 a=AjGcO6oz07-iQ99wixmX:22
    a=ul9cdbp4aOFLsgKbc677:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=BpimnaHY1jUKGyF_4-AF:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=IC2XNlieTeVoXbcui8wp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeDSOib (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:38:31 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeDSOi2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:38:28 -0400
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
        sparclinux@vger.kernel.org
Subject: [PATCH v3 00/17] y2038: Convert IPC syscalls
Date: Thu, 19 Apr 2018 16:37:20 +0200
Message-Id: <20180419143737.606138-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:rs1qbSBVCDG+OXLdYXDxnZukGIrzB48yerCYS2q3MNUtRxXUtP1
 obt2GxWTLqh2+w62mJLWdMuqCymG+mntgLheAtWlGtB63f5p97SCBf3v/S/l2rWzosy1GJz
 1RPnx2OdRGJDBgjaEfcF+zVuxW9nIsypQ+wHeLjbU/6kBN9v6UqYYwOcPNM4irXFxDzbUrQ
 2TRDHTq5re14dP0A51yiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dTipqaO1LU4=:hDGNO9tv+ung1cnRln1nwb
 9CvFfU1yjufa14sOG2V1g2kSTjGjo3jLWD9nc0oO/RURv8oreMGemLvDGfdRG5k+9VUxzM8Zw
 4jf6bLOjs827pbaN7O6aD08HyyiP7nU5dsS00Fkd+0wjpZNRUz7szWdmBdbISHBbYDeYy3nSB
 jTjxCJyE+3zA6juYPZFKKDZkjnAx4VYrL1Bblfuh1Jv6ZPhJaSZTu2qiGhdvtNwZ+TUBKBQRO
 8yxXkyvvnB6EjVWgx3JDf/iQnBAbcq8Tv8uy32HxK02UAEGwqbQOlufJPMNmxAVfEMRtfu937
 E7OtpZ/7vObRbD7+O84sPVi8r9O1jLWQ7rlOKELTeu2O3nqzQKfUFo+RKvgFWcHpzjkRrGjgo
 SQwcfjRU3h3fb/rGOaFihcTXe6A9tkGSy9S/s+4hVirh2z/QkAx88Fa+XCRXT1rDYscbSsm13
 CMWs60+bVe2YZihmGP/9N8F3brh2rZKYPedTASxLsNqu9vq98jUt+0frtD9ona1cb1pb7Nvhv
 IS/CIvGdRcNF6YyxTF20PBx5UJz3uDsE/hbuE0A6p2f3SQjKa/gOJaLP7ALQpDj/jHw2ZX+47
 BZlpHUpdUuZbcZnGarmMWspITpeoYim9Y79jpAjE45Qe8ZgYCpJzBHDPZRIE0VnAHJnXD2Pvh
 5T292yCfUb+qs71r9HkLR6n8PacrJ4Xzs5Tr2nnyjFPCrD4h9UQONz9RVB88l2SYvVj4tJVNP
 BLexAJHCpaTbUhBNw3/zElpSu2b9k0ogatFiJg==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an update of a series I posted a long time ago [1], updating
the IPC subsystem to pass down 64-bit time stamps to user space.

In particular, for sys_msgctl, sys_semctl and sys_shmctl, I do not
introduce a completely new set of replacement system calls, but instead
extend the existing ones to return data in the reserved fields of the
normal data structure.

This should be completely transparent to any existing user space, and
only after the 32-bit time_t wraps, it will make a difference in the
returned data.

libc implementations will consequently have to provide their own data
structures when they move to 64-bit time_t, and convert the structures
in user space from the ones returned by the kernel.

In contrast, mq_timedsend, mq_timedreceive and and semtimedop all do
need to change because having a libc redefine the timespec type
breaks the ABI, so with this series, there will be two separate entry
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

Changes to v2 [2]:
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

I haven't seen any objections to v1 and will send a pull request
to Thomas Gleixner after Deepa's first patches are all merged there.
There are a few more patches in my tree [3] now, I'm still testing
those and should be able to send the next batch next week.

    Arnd

[1] https://lkml.org/lkml/2015/5/20/605
[2] https://lwn.net/Articles/751676/
[3] git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-next

Arnd Bergmann (17):
  y2038: asm-generic: Extend sysvipc data structures
  y2038: alpha: Remove unneeded ipc uapi header files
  y2038: ia64: Remove unneeded ipc uapi header files
  y2038: s390: Remove unneeded ipc uapi header files
  y2038: arm64: Extend sysvipc compat data structures
  y2038: mips: Extend sysvipc data structures
  y2038: x86: Extend sysvipc data structures
  y2038: parisc: Extend sysvipc data structures
  y2038: sparc: Extend sysvipc data structures
  y2038: powerpc: Extend sysvipc data structures
  y2038: xtensa: Extend sysvipc data structures
  y2038: ipc: Use ktime_get_real_seconds consistently
  y2038: ipc: Report long times to user space
  y2038: ipc: Use __kernel_timespec
  y2038: ipc: Enable COMPAT_32BIT_TIME
  y2038: ipc: Redirect ipc(SEMTIMEDOP, ...) to compat_ksys_semtimedop
  y2038: compat: Move common compat types to asm-generic/compat.h

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

 arch/alpha/include/uapi/asm/Kbuild     |  4 ++
 arch/alpha/include/uapi/asm/ipcbuf.h   |  2 -
 arch/alpha/include/uapi/asm/msgbuf.h   | 28 -----------
 arch/alpha/include/uapi/asm/sembuf.h   | 23 ---------
 arch/alpha/include/uapi/asm/shmbuf.h   | 39 ---------------
 arch/arm64/include/asm/compat.h        | 52 +++++++-------------
 arch/ia64/include/uapi/asm/Kbuild      |  4 ++
 arch/ia64/include/uapi/asm/ipcbuf.h    |  2 -
 arch/ia64/include/uapi/asm/msgbuf.h    | 28 -----------
 arch/ia64/include/uapi/asm/sembuf.h    | 23 ---------
 arch/ia64/include/uapi/asm/shmbuf.h    | 39 ---------------
 arch/mips/include/asm/compat.h         | 58 +++++++++--------------
 arch/mips/include/uapi/asm/msgbuf.h    | 57 ++++++++++++++--------
 arch/mips/include/uapi/asm/sembuf.h    | 15 +++++-
 arch/mips/include/uapi/asm/shmbuf.h    | 23 ++++++++-
 arch/parisc/include/asm/compat.h       | 50 +++++++-------------
 arch/parisc/include/uapi/asm/msgbuf.h  | 33 +++++++------
 arch/parisc/include/uapi/asm/sembuf.h  | 16 +++----
 arch/parisc/include/uapi/asm/shmbuf.h  | 19 ++++----
 arch/powerpc/include/asm/compat.h      | 50 +++++++-------------
 arch/powerpc/include/uapi/asm/msgbuf.h | 18 +++----
 arch/powerpc/include/uapi/asm/sembuf.h | 14 +++---
 arch/powerpc/include/uapi/asm/shmbuf.h | 19 ++++----
 arch/s390/include/asm/compat.h         | 50 +++++++-------------
 arch/s390/include/uapi/asm/Kbuild      |  3 ++
 arch/s390/include/uapi/asm/msgbuf.h    | 38 ---------------
 arch/s390/include/uapi/asm/sembuf.h    | 30 ------------
 arch/s390/include/uapi/asm/shmbuf.h    | 49 -------------------
 arch/sparc/include/asm/compat.h        | 51 +++++++-------------
 arch/sparc/include/uapi/asm/msgbuf.h   | 22 ++++-----
 arch/sparc/include/uapi/asm/sembuf.h   | 16 +++----
 arch/sparc/include/uapi/asm/shmbuf.h   | 21 ++++-----
 arch/x86/include/asm/compat.h          | 51 +++++++-------------
 arch/x86/include/uapi/asm/Kbuild       |  5 +-
 arch/x86/include/uapi/asm/msgbuf.h     |  1 -
 arch/x86/include/uapi/asm/sembuf.h     | 11 ++++-
 arch/x86/include/uapi/asm/shmbuf.h     |  1 -
 arch/xtensa/include/uapi/asm/msgbuf.h  | 25 +++++-----
 arch/xtensa/include/uapi/asm/sembuf.h  | 17 ++++---
 arch/xtensa/include/uapi/asm/shmbuf.h  | 37 ++++-----------
 include/asm-generic/compat.h           | 24 +++++++++-
 include/linux/compat.h                 |  2 -
 include/linux/syscalls.h               |  6 +--
 include/uapi/asm-generic/msgbuf.h      | 17 ++++---
 include/uapi/asm-generic/sembuf.h      | 26 ++++++----
 include/uapi/asm-generic/shmbuf.h      | 17 ++++---
 ipc/mqueue.c                           | 86 +++++++++++++++++-----------------
 ipc/msg.c                              | 20 +++++---
 ipc/sem.c                              | 27 +++++++----
 ipc/shm.c                              | 14 ++++--
 ipc/syscall.c                          | 13 +++--
 ipc/util.h                             |  4 +-
 52 files changed, 493 insertions(+), 807 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/ipcbuf.h
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
 delete mode 100644 arch/x86/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/x86/include/uapi/asm/shmbuf.h

-- 
2.9.0

