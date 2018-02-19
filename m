Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeBSLUr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:20:47 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:37312 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752267AbeBSLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:20:46 -0500
X-Google-Smtp-Source: AH8x227qsHmJsk0lypWRlSe31LgBCsNBDDWgPBR2j3DhuZA0zY1Axi5eWI4XCCnQjHuFoUGtmhmIbb4ISQAQ2lOhJmQ=
MIME-Version: 1.0
From: Con Kolivas <kernel@kolivas.org>
Date: Mon, 19 Feb 2018 22:20:44 +1100
X-Google-Sender-Auth: JmY7JmZz5ut63aggEhVE-E7ZCog
Message-ID: <CABqErrFkV-JY3Rg0Xn5tC8CMEUTAxvVfPetiYtnmVsySC4r=jw@mail.gmail.com>
Subject: [ANNOUNCE] linux-4.15-ck1, Multiple Queue Skiplist Scheduler version
 0.170 with variable runqueue sharing.
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1JBKqrt000582

Announcing a new -ck release, 4.15-ck1  with the latest version of the
Multiple Queue Skiplist Scheduler, version 0.170. These are patches
designed to improve system responsiveness and interactivity with
specific emphasis on the desktop, but configurable for any workload.


linux-4.15-ck1:
http://ck.kolivas.org/patches/4.0/4.15/4.15-ck1/

Git tree:
https://github.com/ckolivas/linux/tree/4.15-ck

MuQSS only:

Download:
http://ck.kolivas.org/patches/muqss/4.0/4.15/0001-MultiQueue-Skiplist-Scheduler-version-0.170.patch

Git tree:
https://github.com/ckolivas/linux/tree/4.15-muqss


Web: http://kernel.kolivas.org


Alas Google has falsely flagged my site as having malware, even the
kernel patch pages and they're such a monstrosity there is no place to
meaningfully appeal this so I've given up trying so you'll have to
wade through moronic warnings to get to the patches, or just use git.


The major change in this release is the addition of a much more mature
version of the experimental runqueue sharing code I posted on my blog
earlier. After further experimenting and with lots of feedback from
users, I decided to make multicore based sharing default instead of
multithread. The numbers support better throughput and it should
definitely provide more consistent low latency compared to previous
versions of MuQSS. For those that found that interactivity on MuQSS
never quite matched that of BFS before it, you should find this
version now equals it.


In addition, the runqueue sharing code in this release also allows you
to share runqueues for SMP as well so you can share runqueues with all
physical CPUs if latency is your primary concern, even though it will
likely lead to worse throughput. I have not made it possible to share
between NUMA nodes because the cost of shifting tasks across nodes is
usually substantial and it may even have worse latency, and will
definitely have worse throughput.


I've also made the runqueue sharing possible to be configured at boot
time with the boot parameter rqshare. Setting it to one of none, smt,
mc, smp is done by appending the following to your kernel command
line:

 rqshare=mc


Documentation has been added for the runqueue sharing code above to
the MuQSS patch.


A number of minor bugs were discovered and have been fixed, which has
also made booting more robust.


The -ck tree is mostly just a resync of previous patches, but with the
addition of a patch to disable a -Werror CFLAG setting in the build
tools which has suddenly made it impossible to build the kernel with
newer GCCs on some distros.

Patchlist:

0001-MultiQueue-Skiplist-Scheduler-version-0.170.patch
0002-Make-preemptible-kernel-default.patch
0003-Expose-vmsplit-for-our-poor-32-bit-users.patch
0004-Create-highres-timeout-variants-of-schedule_timeout-.patch
0005-Special-case-calls-of-schedule_timeout-1-to-use-the-.patch
0006-Convert-msleep-to-use-hrtimers-when-active.patch
0007-Replace-all-schedule-timeout-1-with-schedule_min_hrt.patch
0008-Replace-all-calls-to-schedule_timeout_interruptible-.patch
0009-Replace-all-calls-to-schedule_timeout_uninterruptibl.patch
0010-Don-t-use-hrtimer-overlay-when-pm_freezing-since-som.patch
0011-Make-hrtimer-granularity-and-minimum-hrtimeout-confi.patch
0012-Reinstate-default-Hz-of-100-in-combination-with-MuQS.patch
0013-Make-threaded-IRQs-optionally-the-default-which-can-.patch
0014-Swap-sucks.patch
0015-Enable-BFQ-io-scheduler-by-default.patch
0016-Fix-Werror-build-failure-in-tools.patch
0017-Add-ck1-version.patch


Enjoy!

お楽しみ下さい

-ck
