Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167464AbeBOXpC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:45:02 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:52425 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164340AbeBOXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:44:59 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v3 00/11] watchdog/hpwdt: Update driver to use watchdog core.
Date: Thu, 15 Feb 2018 16:43:49 -0700
Message-Id: <20180215234400.5022-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

== v3 ==

Incorperating code review feedback. Following modifications were made:

1) Patch 0003: Use existing hex_byte_pack instead of creating new function.
2) Patch 0005: Redacted change in module_param permission.
3) Patch 0006: switch from pr_debug etc., to dev_dbg where possible.
4) Patch 0006: No longer updating soft_margin post module load.
5) Patch 0006: Initialize hpwdt_dev.parent before registering watchdog.
6) Patch 0006: Redacted change to dev_info message w.r.t. allow_kdump
7) Patch 0006 & 0007: Reorder patches to maintain bisectability.
8) Patch 0008: Change pr_debug to dev_dbg
9) Patch 0010: Change dev_info message w.r.t. allow_kdump where feature
		is removed.

Note, I am explicitly ignoring the checkpatch error on Patch 0008
for specifying permisson of "0" instead of "0000".


== v2 ==

1) Fix compiler error when CONFIG_HPWDT_NMI_DECODING is not defined.

2) Break out driver version change to its own patch (0011).


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
  watchdog/hpwdt: Select WATCHDOG_CORE
  watchdog/hpwdt: Modify to use watchdog core.
  watchdog/hpwdt: Programable Pretimeout NMI
  watchdog/hpwdt: condition early return of NMI handler on iLO5
  watchdog/hpwdt: remove allow_kdump module parameter.
  watchdog/hpwdt: Update driver version.

 drivers/watchdog/Kconfig |   1 +
 drivers/watchdog/hpwdt.c | 845 ++++++++---------------------------------------
 2 files changed, 134 insertions(+), 712 deletions(-)

-- 
2.13.6
