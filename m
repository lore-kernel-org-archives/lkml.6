Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbeCISm7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:42:59 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38272 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932424AbeCISm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:42:56 -0500
X-Google-Smtp-Source: AG47ELszab1IYGRYnU18ifNp7+FublF0F6/rXAHSknHFOCS9ruVKQZr2u12PR6A7/puNbF3l5phTCg==
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [GIT PULL][PATCH 0/4] Timekeeping queue for 4.17
Date: Fri,  9 Mar 2018 10:42:46 -0800
Message-Id: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,
  Just wanted to send along my timekeeping queue for 4.17.
Its a bit short, and I want to apologize as I've not had much
time for maintanance and review work. I worry if my current
workload levels persist, I might need to downgrade my status
in the maintainers file, as I'm not particularly effective
these days. :/

Please let me know if you have any objections.

Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org


The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  https://git.linaro.org/people/john.stultz/linux.git fortglx/4.17/time

for you to fetch changes up to 54f2dcda2ac66a83588acbd6ef2dc98c01d8d3fb:

  x86: rtc: Stop using rtc deprecated functions (2018-03-09 10:35:13 -0800)

----------------------------------------------------------------

Arnd Bergmann (1):
  y2038: time: Introduce struct __kernel_old_timeval

Benjamin Gaignard (1):
  x86: rtc: Stop using rtc deprecated functions

Miroslav Lichvar (2):
  timekeeping: Don't align frequency adjustments to ticks
  timekeeping: Determine multiplier directly from NTP tick length

 arch/x86/kernel/rtc.c               |   6 +-
 include/linux/time32.h              |   1 +
 include/linux/timekeeper_internal.h |   2 +
 include/uapi/linux/time.h           |  12 +++
 kernel/time/time.c                  |  12 +++
 kernel/time/timekeeping.c           | 141 ++++++++++++------------------------
 6 files changed, 77 insertions(+), 97 deletions(-)

-- 
2.7.4
