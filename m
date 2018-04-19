Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeDSMvX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:51:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33432 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeDSMut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:50:49 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shuah Khan <shuah@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/4] selftests: rework RTC tests
Date: Thu, 19 Apr 2018 14:50:26 +0200
Message-Id: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series separates tests using the RTC devices between the one
testing driver agnostic kernel facilities (timers) and the others that
are testing device drivers and hardware.

Then, rtctest is reworked to use the test harness and be much more
robust. Skipping tests is now easier and tests will not block
indefinitively.

I'm planning to send more improvements later this cycle.

Alexandre Belloni (4):
  selftests: timers: move PIE tests out of rtctest
  selftests: timers: rtcpie: restore previous PIE rate
  selftests: move RTC tests to rtc subfolder
  selftests: rtc: rework rtctest

 MAINTAINERS                                   |   2 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/rtc/.gitignore        |   2 +
 tools/testing/selftests/rtc/Makefile          |   9 +
 tools/testing/selftests/rtc/rtctest.c         | 238 +++++++++++
 .../rtctest_setdate.c => rtc/setdate.c}       |   0
 tools/testing/selftests/timers/.gitignore     |   3 +-
 tools/testing/selftests/timers/Makefile       |   4 +-
 tools/testing/selftests/timers/rtcpie.c       | 134 ++++++
 tools/testing/selftests/timers/rtctest.c      | 403 ------------------
 10 files changed, 388 insertions(+), 408 deletions(-)
 create mode 100644 tools/testing/selftests/rtc/.gitignore
 create mode 100644 tools/testing/selftests/rtc/Makefile
 create mode 100644 tools/testing/selftests/rtc/rtctest.c
 rename tools/testing/selftests/{timers/rtctest_setdate.c => rtc/setdate.c} (100%)
 create mode 100644 tools/testing/selftests/timers/rtcpie.c
 delete mode 100644 tools/testing/selftests/timers/rtctest.c

-- 
2.17.0
