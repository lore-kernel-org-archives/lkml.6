Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-945756-1524672702-5-7169063224917167144
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672701; b=nvuinjMzGB5vfR16pky7HqHjxMVLK4pKywjlH/GUxWwqdjI3d0
    xVv5+FOz+38L7SYgXkFNnhQemZs3JZfACjG/E9xmPGX/3eX46x/xdgZNo1PlmaNL
    MwI7pYD1cNEJzrX0fXUvw3uuLNqbDuA5xIYuBTQgOJfz8RDlhZZSaq8RwszYXt9u
    zBvFkQlmxqISEwNG/PKrWeCFIYp6L7fwFOYut/8ZwWL9gA/73x7uuEONk0mI5/Tm
    trMmhTG4M2ELe56n+7BNEKUUmRqd7RT3BG6tNAK9Dexso0jg++ZMkTTCtVju8Tg1
    DjW0Cy7iM1FPrvK1UwFA5J8NpMtK682FO+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524672701; bh=BvbMLe3pLmn3fqYrvSdPvVOSw+UgXB
    tLlwEs3rghu3M=; b=SxFPSvriEbRZs97QrQqXkRI8F/jNhl4+smmRMkCT8dGdGt
    Y/cl0pMy+mBzjiyE9kgXWXc4yTdrnhZnPbKJKaOYeyxfuYRnCwia41lEcoXfhCQV
    boYk03OnrWcZPpCVNIQ1Qwdp8BIPnxc1m1Jyzs8p0SrVIjJkY0gqTny885gAWX5+
    WUg8s/lDAd939xb1GgNKhcTQnCiZtUfH8g1fCW9x/QotyDCzfUlsCj6kel9zL4Yv
    n0pWOn4OG5xXszyw+kb6PmkjGlB0sEe6X9nw91yihF48F0rQDyDdotY3b7/6SuOe
    JJH09ehpVcFLvIRP2HV27333h+6JY328MyzVwsiA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
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
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF7TLVi6wVjJ1V3IGpRvgqk0C3PjmK3L3Js0jP1DjXwc9IJsqZvXpNVEiJnXjJNucq6UVajk7n05+bmU7Jnyn+eFuTMbbhZ770oSNyEXlR1CRL9Z/RC7
    bQMse7s2z4EHecdio1gP7xTntjwTNX/wiPI4cNBUlVzOqrpKRdbEUVJ6DL7ZhNujD/SGKVpS47EASDDCLflD3AfGk8s/00RxVkNyq6k0yNSC5pMPhfHJQEzZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=B6KMzFptAAAA:20
    a=VwQbUJbxAAAA:8 a=CCpqsmhAAAAA:8 a=pGLkceISAAAA:8 a=drOt6m5kAAAA:8
    a=JfrnYn6hAAAA:8 a=PtDNVHqPAAAA:8 a=b3QJYkDzAAAA:8 a=H_8JJHEJw1dobImgaj8A:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ul9cdbp4aOFLsgKbc677:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=1CNFftbPRP8L7MoqJWF3:22 a=BpimnaHY1jUKGyF_4-AF:22
    a=ZYrClHXAzI6hOjfCDBRe:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755110AbeDYQEO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:04:14 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbeDYQEL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 00/17] y2038: system calls, part 3
Date: Wed, 25 Apr 2018 18:02:54 +0200
Message-Id: <20180425160311.2718314-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:FAn6MoZNyNO2uV53xB+/0nzCoQzS4uZMsbpp/3fRw7ephq9ih/9
 iQcf0duq4EY7iHV50rPN853absiaGmgoNQIxgCsijptzjdKisRFYXTBeGsvftVAVza3wEl2
 4S8Dsvy1zSkLxf69n6ncgcKML42qlY9XO1A0V9eoJOh9/SZIgIyuTL4jSng8li4AtD+yxQY
 bCmAsA8CVVyvxrfYVehLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:noi8chGZ/38=:rHMh3g1K1IkDH1pq07W3R8
 Q2vzbf1xLuewzTdXHBiXOwQeR5c6TzX/LSw3fIgK+uwr94udYNvERIOWL6+yBVr4JTzCDDflY
 OqJVK0jaF9UcLOvcTi2C5K1QTqCrfM9UxJf9FXHcyf/RBTGOZHZcgmGRPagjrh23Cr/1qrA1t
 MSJFPq5IJAhkCbUvBYOQyPh/clhNv2i5ZIq7lrX64iGgRgiKtr3xf+AzZXJiOIqaJLHNd0CdE
 U6dzefd8gp9JLGRpkt9XL0O64eWmd4v5VR1uoAfZXECOH/JJDu7GwqvAWOcik6yh5OexuiXQy
 mtcR6ugeo1YlyBYJiAi10FoTC2Cj2qSqvW7eejqkDMf8vdDJP/rCMyl+ZJq/4gmJ7zxHuiLcf
 +qHnspDjHeH/3+XhSgk6osghAfgiO/lWc0MDtYgjxLeRFzi3bad0sWn/+j4v/hRywVGeCUDa7
 KMHUmFU0x/AW/vmdMG2z5NlvnFXETZRfGdZWh46RbNR6qGcFNUUmzOrm1dHgVC9tZLku3M4NZ
 Rw2y5U1TE+VaoRYJR7PS52AEk1zeQZmrTf8IxyKbO1uilcazHy0wwihcIT9XxqwaqCvHyRlxp
 99G0rNxXjhR6vqWVlPwtBFVS+phUgJ1ZMVlMZww6skhjeckWDhaAq+9R2+xOOqzrsWFmNp1/d
 s6gdltqjBE2DIZNxQTPjd4vuLSxtZjzlKFWxAUP8kp80kMxp6LNYfY89eZbC3Yra8I8A=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After the first timekeeping series from Deepa (merged into -tip now)
and my follow-up for IPC system calls, this is a third set of system
call conversions following the same principle.

Most of the changes are straightforward, so I'm grouping them into a
larger series even though the system calls are mostly unrelated to one
another. After this series, the remaining calls that need to be changed
are getrusage()/waitid(), pselect6/ppoll(), timer{,fd}_{get,set}time()
and getitimer()/setitimer(). Those will be sent separately, once they
are matured enough.

To put the changes into perspective, a list of all system calls that
require changes is available in a spreadsheet[1] and I have made
another experimental patch that changes over x86[2] and arm[3] to
actually use them.

Please review!

      Arnd

[1] https://docs.google.com/spreadsheets/d/1HCYwHXxs48TsTb6IGUduNjQnmfRvMPzCN6T_0YiQwis
[2] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=y2038-next&id=2174e03cd47384f30dc522f173f36c0d72cfedd7
[3] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=y2038-next&id=ba9a341eff2b13a8e25b5d42b3035b1c1dbfeacf

Arnd Bergmann (17):
  y2038: compat: Move common compat types to asm-generic/compat.h
  y2038: Remove newstat family from default syscall set
  y2038: Remove stat64 family from default syscall set
  asm-generic: Remove unneeded __ARCH_WANT_SYS_LLSEEK macro
  asm-generic: Remove empty asm/unistd.h
  y2038: Change sys_utimensat() to use __kernel_timespec
  y2038: Compile utimes()/futimesat() conditionally
  y2038: utimes: Rework #ifdef guards for compat syscalls
  y2038: futex: Move compat implementation into futex.c
  y2038: futex: Add support for __kernel_timespec
  y2038: Prepare sched_rr_get_interval for __kernel_timespec
  y2038: aio: Prepare sys_io_getevents for __kernel_timespec
  y2038: socket: Convert recvmmsg to __kernel_timespec
  y2038: socket: Add compat_sys_recvmmsg_time64
  y2038: signal: Change rt_sigtimedwait to use __kernel_timespec
  y2038: Make compat_sys_rt_sigtimedwait usable on 32-bit
  y2038: signal: Add compat_sys_rt_sigtimedwait_time64

Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: libc-alpha@sourceware.org
Cc: tglx@linutronix.de
Cc: netdev@vger.kernel.org
Cc: deepa.kernel@gmail.com
Cc: viro@zeniv.linux.org.uk
Cc: albert.aribaud@3adev.fr
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>

 arch/alpha/include/asm/unistd.h          |   2 +
 arch/arc/include/uapi/asm/unistd.h       |   1 +
 arch/arm/include/asm/unistd.h            |   4 +-
 arch/arm64/include/asm/compat.h          |  20 +--
 arch/arm64/include/asm/unistd.h          |   2 +-
 arch/arm64/include/uapi/asm/unistd.h     |   1 +
 arch/c6x/include/uapi/asm/unistd.h       |   1 +
 arch/h8300/include/uapi/asm/unistd.h     |   1 +
 arch/hexagon/include/uapi/asm/unistd.h   |   1 +
 arch/ia64/include/asm/unistd.h           |   3 +
 arch/m68k/include/asm/unistd.h           |   2 +-
 arch/microblaze/include/asm/unistd.h     |   2 +-
 arch/mips/include/asm/compat.h           |  22 +---
 arch/mips/include/asm/unistd.h           |   3 +-
 arch/nds32/include/uapi/asm/unistd.h     |   1 +
 arch/nios2/include/uapi/asm/unistd.h     |   1 +
 arch/openrisc/include/uapi/asm/unistd.h  |   1 +
 arch/parisc/include/asm/compat.h         |  18 +--
 arch/parisc/include/asm/unistd.h         |   3 +-
 arch/powerpc/include/asm/compat.h        |  18 +--
 arch/powerpc/include/asm/unistd.h        |   3 +-
 arch/s390/include/asm/compat.h           |  18 +--
 arch/s390/include/asm/unistd.h           |   3 +-
 arch/sh/include/asm/unistd.h             |   2 +-
 arch/sparc/include/asm/compat.h          |  19 +--
 arch/sparc/include/asm/unistd.h          |   3 +-
 arch/unicore32/include/uapi/asm/unistd.h |   1 +
 arch/x86/include/asm/compat.h            |  19 +--
 arch/x86/include/asm/unistd.h            |   3 +-
 arch/xtensa/include/asm/unistd.h         |   2 +-
 fs/aio.c                                 |   4 +-
 fs/read_write.c                          |   2 +-
 fs/stat.c                                |   3 +
 fs/utimes.c                              |  59 +++++----
 include/asm-generic/compat.h             |  24 +++-
 include/asm-generic/unistd.h             |  13 --
 include/linux/compat.h                   |  12 +-
 include/linux/compat_time.h              |   5 +
 include/linux/futex.h                    |   8 --
 include/linux/socket.h                   |  19 ++-
 include/linux/syscalls.h                 |  23 ++--
 include/uapi/asm-generic/unistd.h        |   2 +
 kernel/Makefile                          |   3 -
 kernel/futex.c                           | 207 +++++++++++++++++++++++++++++--
 kernel/futex_compat.c                    | 202 ------------------------------
 kernel/sched/core.c                      |   4 +-
 kernel/signal.c                          |  68 ++++++++--
 kernel/sys_ni.c                          |   1 +
 net/compat.c                             |  16 +--
 net/socket.c                             |  55 ++++++--
 50 files changed, 456 insertions(+), 454 deletions(-)
 delete mode 100644 include/asm-generic/unistd.h
 delete mode 100644 kernel/futex_compat.c

-- 
2.9.0

