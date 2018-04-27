Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934782AbeD0Ole (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934597AbeD0Olc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:41:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD836218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 16:41:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core fixes for 4.17-rc3
Message-ID: <20180427144122.GA9293@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/ tags/driver-core-4.17-rc3

for you to fetch changes up to b93815d0f37e7c4a056a143e6d782abc084ea56b:

  firmware: some documentation fixes (2018-04-25 18:37:20 +0200)

----------------------------------------------------------------
Driver core fixes for 4.17-rc3

Here are some small driver core and firmware fixes for 4.17-rc3

There's a kobject WARN() removal to make syzkaller a lot happier about
some "normal" error paths that it keeps hitting, which should reduce the
number of false-positives we have been getting recently.

There's also some fimware test and documentation fixes, and the
coredump() function signature change that needed to happen after -rc1
before drivers started to take advantage of it.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andres Rodriguez (1):
      firmware: some documentation fixes

Arend van Spriel (1):
      drivers: change struct device_driver::coredump() return type to void

Ben Hutchings (2):
      test_firmware: Install all scripts
      test_firmware: fix setting old custom fw path back on exit, second try

Dmitry Vyukov (1):
      kobject: don't use WARN for registration failures

Hans de Goede (1):
      firmware: Fix firmware documentation for recent file renames

Jeffrin Jose T (1):
      selftests:firmware: fixes a call to a wrong function name

 Documentation/driver-api/firmware/request_firmware.rst | 16 ++++++++--------
 Documentation/driver-api/infrastructure.rst            |  2 +-
 Documentation/power/suspend-and-cpuhotplug.txt         |  2 +-
 drivers/base/firmware_loader/fallback.c                |  4 ++--
 drivers/base/firmware_loader/fallback.h                |  2 +-
 include/linux/device.h                                 |  6 ++++--
 lib/kobject.c                                          | 11 +++++------
 tools/testing/selftests/firmware/Makefile              |  1 +
 tools/testing/selftests/firmware/fw_lib.sh             | 10 ++++++----
 tools/testing/selftests/firmware/fw_run_tests.sh       |  2 +-
 10 files changed, 30 insertions(+), 26 deletions(-)
