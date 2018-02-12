Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeBLFW1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:22:27 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:30141 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeBLFWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:22:23 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 00/11] watchdog/hpwdt: Update driver to use watchdog core.
Date: Sun, 11 Feb 2018 22:21:00 -0700
Message-Id: <20180212052111.12010-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

== v2 ==

1) Fix compiler error when CONFIG_HPWDT_NMI_DECODING is not defined.
Small non-white space changes to patches: 0001, 0006, 0008, 0009.

2) Break out driver version change to its own patch.
Small non-white space changes to patch 0008 and added 0011.


== v1 ==

The primary purposes of this patch set are to

1) Update the hpwdt driver to use the watchdog core.
2) Reduce complexity by removing unnecessary features.
3) Add customer requested features like optional pretimeout.
4) Enhance readability/maintainability of the driver.

The size of the resultant driver is reduced from over 900
lines to 350 lines.

Patch 1& 2 remove legacy NMI sourcing.
Patch 3	adds useful indication of NMI cause to panic message
Patch 4 & 5 are general cleanup
Patch 6 & 7 updates the driver to user the watchdog core.
Patch 8 makes the pretimeout NMI programmable.
Patch 9 modifies whether the NMI handler claims the NMI.
Patch 10 retracts the allow_kdump module parameter.


Jerry Hoemann (11):
  watchdog/hpwdt: Remove legacy NMI sourcing.
  watchdog/hpwdt: remove include files no longer needed.
  watchdog/hpwdt: Update nmi_panic message.
  watchdog/hpwdt: white space changes
  watchdog/hpwdt: Update Module info.
  watchdog/hpwdt: Modify to use watchdog core.
  watchdog/hpwdt: Select WATCHDOG_CORE
  watchdog/hpwdt: Programable Pretimeout NMI
  watchdog/hpwdt: condition early return of NMI handler on iLO5
  watchdog/hpwdt: remove allow_kdump module parameter.
  watchdog/hpwdt: Update driver version.

 drivers/watchdog/Kconfig |   1 +
 drivers/watchdog/hpwdt.c | 847 ++++++++---------------------------------------
 2 files changed, 139 insertions(+), 709 deletions(-)

-- 
2.13.6
