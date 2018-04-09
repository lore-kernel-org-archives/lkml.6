Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeDIRWk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:22:40 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35160 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeDIRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:22:38 -0400
X-Google-Smtp-Source: AIpwx495p9HKtjcf4hwhwvVH/nATcOUAFlqhPsWtgf5OvzsiSQ8zjIOvLBajFhdHpcdDmhI+7CKAug==
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v4.17
Date: Mon,  9 Apr 2018 10:22:35 -0700
Message-Id: <1523294555-29481-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v4.17 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.17

Thanks,
Guenter
------

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.17

for you to fetch changes up to e3a2d2be510ec8a35ecd2a17a42467d417962bb7:

  hwmon: (via-cputemp) support new centaur CPUs (2018-03-30 07:53:57 -0700)

----------------------------------------------------------------
hwmon updates for v4.17

- Added chip support: new centaur CPUs, ADM1272, NCT6796D
- ucd9000: added debugfs attributes, gpio support
- Cleanup and minor bug fixes

----------------------------------------------------------------
Alvaro G. M (2):
      hwmon: (lm92) Do not try to detect MAX6635
      hwmon: (lm92) Add max6635 to lm92_id[]

Christopher Bostic (2):
      hwmon: (ucd9000) Add gpio chip interface
      hwmon: (ucd9000) Add debugfs attributes to provide mfr_status

Danilo Bargen (2):
      hwmon: (sht21) Update data sheet URLs
      hwmon: (sht3x) Update data sheet URL

Guenter Roeck (8):
      hwmon: (pmbus/max8688) Accept negative page register values
      hwmon: (pmbus/adm1275) Accept negative page register values
      hwmon: (nct6775) Use NUM_FAN consistently
      hwmon: (nct6775) Improve fan6/pwm6 support
      hwmon: (nct6775) Initialize boolean variables with declaration
      hwmon: (nct6775) Add support for NCT6796D
      hwmon: (pmbus/adm1275) Add support for ADM1272
      hwmon: (nct6775) Fix writing pwmX_mode

Hao Peng (1):
      hwmon: (g762) handle cleanup with devm_add_action

davidwang (1):
      hwmon: (via-cputemp) support new centaur CPUs

 Documentation/hwmon/adm1275   |  20 ++-
 Documentation/hwmon/lm92      |   6 +-
 Documentation/hwmon/nct6775   |  56 ++++---
 Documentation/hwmon/sht21     |   6 +-
 Documentation/hwmon/sht3x     |   2 +-
 drivers/hwmon/Kconfig         |   5 +-
 drivers/hwmon/g762.c          |  53 ++-----
 drivers/hwmon/lm92.c          |  63 +-------
 drivers/hwmon/nct6775.c       | 231 ++++++++++++++++++----------
 drivers/hwmon/pmbus/Kconfig   |   4 +-
 drivers/hwmon/pmbus/adm1275.c |  71 ++++++++-
 drivers/hwmon/pmbus/max8688.c |   2 +-
 drivers/hwmon/pmbus/ucd9000.c | 350 +++++++++++++++++++++++++++++++++++++++++-
 drivers/hwmon/sht21.c         |   3 +-
 drivers/hwmon/via-cputemp.c   |  31 ++--
 15 files changed, 662 insertions(+), 241 deletions(-)
