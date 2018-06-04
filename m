Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeFDBq3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:46:29 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:36450 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeFDBq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:46:27 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v4.18
Date: Sun,  3 Jun 2018 18:46:26 -0700
Message-Id: <1528076786-2472-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v4.18 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.18

Thanks,
Guenter
------

The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.18

for you to fetch changes up to c9bdf291542e14dbc5b9a71aa11f995de0e54f0d:

  hwmon: (asus_atk0110) Make use of device managed memory (2018-06-01 09:38:36 -0700)

----------------------------------------------------------------
hwmon updates for v4.18

- asus_atk0110 driver modified to use new API
- k10temp supports new CPUs and reports both Tctl and Tdie
- minor fixes in gpio-fan, ltc2990, fschmd, and mc13783 drivers

----------------------------------------------------------------
Andrey Gusakov (1):
      hwmon: MC13783: Add uid and die temperature sensor inputs

Bastian Germann (2):
      hwmon: (asus_atk0110) Replace deprecated device register call
      hwmon: (asus_atk0110) Make use of device managed memory

Colin Ian King (1):
      hwmon: (k10temp) Make function get_raw_temp static

Guenter Roeck (4):
      hwmon: (k10temp) Add support for Stoney Ridge and Bristol Ridge CPUs
      hwmon: (k10temp) Display both Tctl and Tdie
      Merge tag 'ib-mfd-hwmon-v4.18' into hwmon-next
      MAINTAINERS: hwmon: Add Documentation/devicetree/bindings/hwmon

Lucas Magasweran (1):
      hwmon: (core) check parent dev != NULL when chip != NULL

Tom Levens (3):
      hwmon: (ltc2990) Fix incorrect conversion of negative temperatures
      hwmon: (ltc2990) add devicetree binding
      hwmon: (ltc2990) support all measurement modes

Viresh Kumar (1):
      hwmon: (gpio-fan) Fix "#cooling-cells" property name in bindings

Wolfram Sang (1):
      hwmon: (fschmd) fix typo 'can by' to 'can be'

 .../devicetree/bindings/hwmon/gpio-fan.txt         |   2 +-
 .../devicetree/bindings/hwmon/ltc2990.txt          |  36 ++++
 Documentation/hwmon/hwmon-kernel-api.txt           |   3 +-
 Documentation/hwmon/ltc2990                        |  24 ++-
 MAINTAINERS                                        |   1 +
 drivers/hwmon/Kconfig                              |   7 +-
 drivers/hwmon/asus_atk0110.c                       | 117 ++++--------
 drivers/hwmon/fschmd.c                             |   2 +-
 drivers/hwmon/hwmon.c                              |   3 +
 drivers/hwmon/k10temp.c                            |  60 +++++-
 drivers/hwmon/ltc2990.c                            | 212 +++++++++++++++++----
 drivers/hwmon/mc13783-adc.c                        |  60 ++++++
 drivers/mfd/mc13xxx-core.c                         |  15 +-
 include/linux/mfd/mc13xxx.h                        |   2 +
 14 files changed, 393 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ltc2990.txt
