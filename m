Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752C2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF28F21523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cIdHcmQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF28F21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbeITCaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45033 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbeITCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so6008348edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkVlsiNEy23+OxYjKPjFquVP3V+xEhkwwb6yhw9kDiE=;
        b=cIdHcmQgn6cll6ebL6MHgJlhAyf5qH6/TQ/LYgqAAIvy8xr/YIMOVG36e2gB0wZ0g1
         por7vCzSb8nGYwkapYavtOk7SQzaVDnpwkUg6YaxNtV6Sf/KLYFCOvWrWiHhs5WRyrxT
         ookmw8MVcpFvmNpHcS4406hB3fxe2seUa/QQ06ATQw1YWoRGm9XZSsT4ChssNWVGczno
         Om7hePJ5mtgkqo1S1XwE9ZC6EnsbB0g8PKIfGC7r79dG4Lb9+maztRZMYBKSltKMw7bZ
         vZwbggUn9PyeD31hXgG299CUVaLX5SMD8V/bjD+bQFOICm8arAPgN/hcl7lvkmqQdlMs
         lq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkVlsiNEy23+OxYjKPjFquVP3V+xEhkwwb6yhw9kDiE=;
        b=R7OlFC98pDY/zLhv6xwxCA0UBzJEqfTmeGGlIB3kiAZfEx3/rYjQUh0wm8qldcdPgg
         X+UInYG1zwTGbbDpnckc5e/69CkEyYsTX7ar1NeviISZbZ73XicA0bPgY6kx7O8C0uXX
         uQs1KVMEB8iaPKtRje9fdgGsZB2t3FLsorgSHjCzaTMge+LEc/sH9/4FL8vt1JAO6iNw
         6LDZudhygMYLWUC+Y34Xj64fRXEWG4SlQ5Nn3OljNkKee7pfBzU9x3dKFIZHk60kZOFv
         xQ8pCvPdB1EO7XsjmrWeCzVB0Cr8o9ebB7XMIkegTybPe9AjJ3RN2r92Ut0+i8FdLoQs
         3Khg==
X-Gm-Message-State: APzg51CDJLkPaChw82/EMymqYdIxTSCiY3OGVzsr2OaClRTtQajhZouX
        DQ0zFgeAch9HN9/9FZQ5sMJmhAIUJIE=
X-Google-Smtp-Source: ANB0VdYd7abd/4d1tlOPP7Ik6KqxW0y77wahiRlGg5XSjGySwqsDfXp8PJIPqk5lnZVgWmPMKg2qqw==
X-Received: by 2002:a50:a2a6:: with SMTP id 35-v6mr59495779edm.276.1537390239506;
        Wed, 19 Sep 2018 13:50:39 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:38 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: [RFC 00/20] ns: Introduce Time Namespace
Date:   Wed, 19 Sep 2018 21:50:17 +0100
Message-Id: <20180919205037.9574-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discussions around time virtualization are there for a long time.
The first attempt to implement time namespace was in 2006 by Jeff Dike.
From that time, the topic appears on and off in various discussions.

There are two main use cases for time namespaces:
1. change date and time inside a container;
2. adjust clocks for a container restored from a checkpoint.

“It seems like this might be one of the last major obstacles keeping
migration from being used in production systems, given that not all
containers and connections can be migrated as long as a time dependency
is capable of messing it up.” (by github.com/dav-ell)

The kernel provides access to several clocks: CLOCK_REALTIME,
CLOCK_MONOTONIC, CLOCK_BOOTTIME. Last two clocks are monotonous, but the
start points for them are not defined and are different for each running
system. When a container is migrated from one node to another, all
clocks have to be restored into consistent states; in other words, they
have to continue running from the same points where they have been
dumped.

The main idea behind this patch set is adding per-namespace offsets for
system clocks. When a process in a non-root time namespace requests
time of a clock, a namespace offset is added to the current value of
this clock on a host and the sum is returned.

All offsets are placed on a separate page, this allows up to map it as 
part of vvar into user processes and use offsets from vdso calls.

Now offsets are implemented for CLOCK_MONOTONIC and CLOCK_BOOTTIME
clocks.

Questions to discuss:

* Clone flags exhaustion. Currently there is only one unused clone flag
bit left, and it may be worth to use it to extend arguments of the clone
system call.

* Realtime clock implementation details:
  Is having a simple offset enough?
  What to do when date and time is changed on the host?
  Is there a need to adjust vfs modification and creation times? 
  Implementation for adjtime() syscall.

Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Adrian Reber <adrian@lisas.de>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com> 
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: containers@lists.linux-foundation.org
Cc: criu@openvz.org
Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org

Andrei Vagin (12):
  ns: Introduce Time Namespace
  timens: Add timens_offsets
  timens: Introduce CLOCK_MONOTONIC offsets
  timens: Introduce CLOCK_BOOTTIME offset
  timerfd/timens: Take into account ns clock offsets
  kernel: Take into account timens clock offsets in clock_nanosleep
  x86/vdso/timens: Add offsets page in vvar
  x86/vdso: Use set_normalized_timespec() to avoid 32 bit overflow
  posix-timers/timens: Take into account clock offsets
  selftest/timens: Add test for timerfd
  selftest/timens: Add test for clock_nanosleep
  timens/selftest: Add timer offsets test

Dmitry Safonov (8):
  timens: Shift /proc/uptime
  x86/vdso: Restrict splitting vvar vma
  x86/vdso: Purge timens page on setns()/unshare()/clone()
  x86/vdso: Look for vvar vma to purge timens page
  timens: Add align for timens_offsets
  timens: Optimize zero-offsets
  selftest: Add Time Namespace test for supported clocks
  timens/selftest: Add procfs selftest

 arch/Kconfig                                     |   5 +
 arch/x86/Kconfig                                 |   1 +
 arch/x86/entry/vdso/vclock_gettime.c             |  52 +++++
 arch/x86/entry/vdso/vdso-layout.lds.S            |   9 +-
 arch/x86/entry/vdso/vdso2c.c                     |   3 +
 arch/x86/entry/vdso/vma.c                        |  67 +++++++
 arch/x86/include/asm/vdso.h                      |   2 +
 fs/proc/namespaces.c                             |   3 +
 fs/proc/uptime.c                                 |   3 +
 fs/timerfd.c                                     |  16 +-
 include/linux/nsproxy.h                          |   1 +
 include/linux/proc_ns.h                          |   1 +
 include/linux/time_namespace.h                   |  72 +++++++
 include/linux/timens_offsets.h                   |  25 +++
 include/linux/user_namespace.h                   |   1 +
 include/uapi/linux/sched.h                       |   1 +
 init/Kconfig                                     |   8 +
 kernel/Makefile                                  |   1 +
 kernel/fork.c                                    |   3 +-
 kernel/nsproxy.c                                 |  19 +-
 kernel/time/hrtimer.c                            |   8 +
 kernel/time/posix-timers.c                       |  89 ++++++++-
 kernel/time/posix-timers.h                       |   2 +
 kernel/time_namespace.c                          | 230 +++++++++++++++++++++++
 tools/testing/selftests/timens/.gitignore        |   5 +
 tools/testing/selftests/timens/Makefile          |   6 +
 tools/testing/selftests/timens/clock_nanosleep.c |  98 ++++++++++
 tools/testing/selftests/timens/config            |   1 +
 tools/testing/selftests/timens/log.h             |  21 +++
 tools/testing/selftests/timens/procfs.c          | 145 ++++++++++++++
 tools/testing/selftests/timens/timens.c          | 196 +++++++++++++++++++
 tools/testing/selftests/timens/timer.c           |  95 ++++++++++
 tools/testing/selftests/timens/timerfd.c         |  96 ++++++++++
 33 files changed, 1272 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/time_namespace.h
 create mode 100644 include/linux/timens_offsets.h
 create mode 100644 kernel/time_namespace.c
 create mode 100644 tools/testing/selftests/timens/.gitignore
 create mode 100644 tools/testing/selftests/timens/Makefile
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c
 create mode 100644 tools/testing/selftests/timens/config
 create mode 100644 tools/testing/selftests/timens/log.h
 create mode 100644 tools/testing/selftests/timens/procfs.c
 create mode 100644 tools/testing/selftests/timens/timens.c
 create mode 100644 tools/testing/selftests/timens/timer.c
 create mode 100644 tools/testing/selftests/timens/timerfd.c

-- 
2.13.6

