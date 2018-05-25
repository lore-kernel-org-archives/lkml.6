Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935954AbeEYH6s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:58:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45086 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935866AbeEYH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:58:46 -0400
X-Google-Smtp-Source: ADUXVKKoTJOdJXupNlQq3L8eLSOZ4qn31OMwYSZ1LOTJM90v41HuBa0bHgmewNLB4O8NAGsQ9ArP18AQoaeok5gPY7g=
MIME-Version: 1.0
In-Reply-To: <006a01d3f3c8$88c24c40$9a46e4c0$@toshiba.co.jp>
References: <20180524093159.286472249@linuxfoundation.org> <20180524180652.7bqyquqfe2nqdxfg@xps>
 <20180524190806.GE31019@kroah.com> <CADtBP2B=Yb22dUjW-X-1OEGUvMX81gfpQ2FqFAaQUnExduwq7Q@mail.gmail.com>
 <006a01d3f3c8$88c24c40$9a46e4c0$@toshiba.co.jp>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 25 May 2018 13:28:43 +0530
Message-ID: <CA+G9fYtof6XB1+zcNZBy+jhejHJQkVrG8jdLBusUG=a07F8ShQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Cc: Rafael Tinoco <rafael.tinoco@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 25 May 2018 at 07:04, Daniel Sangorrin
<daniel.sangorrin@toshiba.co.jp> wrote:
> Hello Rafael,
>
> The tests fcntl35 and fcntl35_64 should have go from FAIL to PASS.
> https://www.spinics.net/lists/stable/msg239475.html

Thanks for the patch.

Now i have manually tested LTP syscalls and confirms,
fcntl35 and fcntl35_64 pass on qemu_x86_64, (arm64) Hikey, Juno and (arm32) x15.

Linux version 4.4.133-rc1 (buildslave@x86-64-07) (gcc version 6.2.1 20161016
(Linaro GCC 6.2-2016.11) ) #1 SMP Thu May 24 10:24:11 UTC 2018

[  131.873912] LTP: starting fcntl35
tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
fcntl35.c:101: PASS: an unprivileged user init the capacity of a pipe
to 4096 successfully
fcntl35.c:101: PASS: a privileged user init the capacity of a pipe to
65536 successfully
Summary:
passed   2
failed   0
skipped  0

[  132.090096] LTP: starting fcntl35_64
incrementing stop
tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
fcntl35.c:101: PASS: an unprivileged user init the capacity of a pipe
to 4096 successfully
fcntl35.c:101: PASS: a privileged user init the capacity of a pipe to
65536 successfully
Summary:
passed   2
failed   0
skipped  0
warnings 0

>
> Looking at
> https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a3d7cdea9/testrun/228569/suite/ltp-syscalls-tests/tests/
> I see that these two tests (and other important tests as well) are being SKIPPED.

fcntl35 and fcntl35_64 will be unskipped from now on.

>
> By the way, I see that select04 FAILS in your case. But in my setup, select04 was working fine (x86_64) in 4.4.132. I will confirm that it still works in 4.4.133

select04 failed on (slow) qemu_arm only and PASS on real hardware of
arm32 x15, arm64 Juno and x86_64.
Test case verdict comparison across all boards and qemu,
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/tests/ltp-syscalls-tests/select04

LTP select04 failed log on slow qemu_arm32,
tst_test.c:980: INFO: Timeout per run is 0h 15m 00s
tst_timer_test.c:356: INFO: CLOCK_MONOTONIC resolution 1ns
tst_timer_test.c:368: INFO: prctl(PR_GET_TIMERSLACK) = 50us
tst_timer_test.c:275: INFO: select() sleeping for 1000us 500
iterations, threshold 450.01us
tst_timer_test.c:318: INFO: min 1336us, max 2282us, median 1522us,
trunc mean 1542.82us (discarded 25)
tst_timer_test.c:321: FAIL: select() slept for too long

Full log: https://lkft.validation.linaro.org/scheduler/job/228569#L8792

Best regards
Naresh Kamboju
