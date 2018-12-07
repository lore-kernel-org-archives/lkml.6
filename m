Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B26DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD7C20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD7C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeLGNtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:49:33 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35439 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeLGNt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:49:27 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8yU2-1gaCS41JaQ-0068my; Fri, 07 Dec 2018 14:48:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/8] timekeeping: cleanups
Date:   Fri,  7 Dec 2018 14:48:16 +0100
Message-Id: <20181207134824.300024-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:1UrHuyDKSqP4sWxNYVU9KewlEriNQJ8CQ6EaHowT8usc2ZXwyx8
 m8wZGZVXHnxHILBCs9+Yt9xqedUV8UUnLLCzOi4yzQ+TJYcgdac2o55+96m85LId00J6ItK
 sonLl7YqrPTNoK9oun5Ju56DEWJOTrjVYMVzn5ud8JVxuySp2dxpwSX/Ynk87oFmvStCgdP
 vffO9hImFBHwwiMxrH9CA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0a9NYqyMbfU=:WDXVONAIkLfEsMNJrFC+t1
 53XHioEpUHaSDEmc9cujf4OPwIZZDYSsUk4/e2i/G6ecLLgYTpnQ0sxA4VxQDPQMlACFU6Y/f
 vDOXvv374dbuHgMyCalnN1B3ZDiGDmv2iH674IbalzLxqhL5o1Oncb3zhh0i0Itxg3icmN+H/
 5PGW/CXMZXjcqrv1w+HTjFb/o81dj8DQC4Bd8UILf3Kg4qy28geGE0C3pJKVEW2Xxcq+Hs80O
 yFQbNNtgmdgz9hpIQgLa6GL4UOjCxltjNJ4BwVMfBLWvFsVbRJzANWFlPbl9WexJHMi0gC7D1
 Kc0RE+sO39AmjRDGnd+97TaBGUws/eGGbiLO4Y4oT4SiP91SjCWC8MyQVuLoDkXCblbzWFkMP
 +gA/TagsuSQUCx+HTaF5ZdEzlf5ozG8osBUKMof27nA1Pm6ZLjSyfSK66Iw7tdJVP7ADecWUi
 X+sTznOh7m7rEZwW0aCwsDSQTcuGfS/N5sqafmCqSTBSf4tnTfcNvBlnk4CNAl0mR1+Xst377
 E1tPIgG9i3ug+WBAwWfsqsMMeMVrh695DQXa1hKoz5tN4Ptb0KuS8jmxfSJsuL/PBzqCik7M6
 tk3Lj1kzX/A7wRSFh4L30m6fDG14eaFWKZQ1IatE0ciSTlEbELtyYikYUUAmhlxd36Fk6fZ7o
 CFqUmtlTaPkbtZ0P21hA1SQTIshVlgUyptsneg7OkyUTgntyXT7o8rPsYsZC5819BMWmes9s+
 TzYU6QpD11CXuhn7xUmYP3gXs4QBKb1wQd7ccw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some older cleanups that for one reason or another never made
it into the mainline kernel so far:

- the arch/sh series was posted a couple of times by both
  Baolin and me, with no reply from the sh maintainers

- the vfs patch initially got some opposition when the new
  interfaces were not documented right, but that is done now.

- The remaining three patches simply remove functions that
  have been obsoleted a while ago and have lost their last
  callers now.

I'm adding these into my y2038 tree now, so they make it into
linux-next, planning to send a pull request to Thomas for the
tip tree afterwards.

       Arnd

Arnd Bergmann (8):
  sh: dreamcast: rtc: push down rtc class ops into driver
  sh: sh03: rtc: push down rtc class ops into driver
  sh: remove unused rtc_sh_get/set_time infrastructure
  sh: remove board_time_init() callback
  timekeeping: remove unused {read,update}_persistent_clock
  timekeeping: remove timespec_add/timespec_del
  vfs: replace current_kernel_time64 with ktime equivalent
  timekeeping: remove obsolete time accessors

 Documentation/sh/new-machine.txt              |  8 --
 arch/sh/boards/mach-dreamcast/Makefile        |  4 +-
 arch/sh/boards/mach-dreamcast/rtc.c           | 39 +++++++---
 arch/sh/boards/mach-dreamcast/setup.c         |  1 -
 arch/sh/boards/mach-sh03/Makefile             |  3 +-
 arch/sh/boards/mach-sh03/rtc.c                | 51 ++++++++-----
 arch/sh/boards/mach-sh03/setup.c              |  9 ---
 arch/sh/boards/of-generic.c                   |  8 --
 arch/sh/configs/dreamcast_defconfig           |  2 +
 arch/sh/configs/sh03_defconfig                |  2 +
 arch/sh/include/asm/rtc.h                     |  3 -
 arch/sh/include/mach-dreamcast/mach/sysasic.h |  1 -
 arch/sh/kernel/time.c                         | 74 +------------------
 fs/inode.c                                    |  4 +-
 include/linux/time32.h                        | 25 -------
 include/linux/timekeeping.h                   | 14 ----
 include/linux/timekeeping32.h                 | 15 ----
 kernel/time/ntp.c                             | 10 +--
 kernel/time/time.c                            | 36 ---------
 kernel/time/timekeeping.c                     | 12 +--
 20 files changed, 73 insertions(+), 248 deletions(-)

-- 
2.18.0

