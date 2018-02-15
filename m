Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756198AbeBOWQf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:16:35 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37502 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBOWQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:16:33 -0500
X-Google-Smtp-Source: AH8x227dgm3GT7XpGgSqzBujHt1ei67Bxb2BDgeGjWByfRVhbu08uH7eK9wNBbi28MdJ7j1nBeWJfIoZtxJEUEGQrE4=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2018 23:16:32 +0100
X-Google-Sender-Auth: 7mTs_jLkJ1XuOUnOjllZLwNrAEs
Message-ID: <CAJZ5v0gq6Z=Y_vvnn9bT9vQjD5GHrs=mQRh+RY3oH=esiRh47Q@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.16-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.16-rc2

with top-most commit 822ffaa58183e0b2dfdf4b51f04a387c9edd806d

 Merge branches 'pm-cpuidle' and 'pm-opp'

on top of commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2

 Linux 4.16-rc1

to receive power management updates for 4.16-rc2.

These fix a recently introduced build issue related to cpuidle
and two bugs in the PM core, update cpuidle documentation and
clean up memory allocations in the operating performance points
(OPP) framework.

Specifics:

 - Fix a recently introduced build issue related to cpuidle by
   covering all of the relevant combinations of Kconfig options
   in its header (Rafael Wysocki).

 - Add missing invocation of pm_runtime_drop_link() to the
   !CONFIG_SRCU variant of __device_link_del() (Lukas Wunner).

 - Fix unbalanced IRQ enable in the wakeup interrupts framework
   (Tony Lindgren).

 - Update cpuidle sysfs ABI documentation (Aishwarya Pant).

 - Use GFP_KERNEL instead of GFP_ATOMIC for allocating memory
   in dev_pm_opp_init_cpufreq_table() (Jia-Ju Bai).

Thanks!


---------------

Aishwarya Pant (1):
      Documentation/ABI: update cpuidle sysfs documentation

Jia-Ju Bai (1):
      opp: cpu: Replace GFP_ATOMIC with GFP_KERNEL in
dev_pm_opp_init_cpufreq_table

Lukas Wunner (1):
      PM / runtime: Update links_count also if !CONFIG_SRCU

Rafael J. Wysocki (1):
      PM: cpuidle: Fix cpuidle_poll_state_init() prototype

Tony Lindgren (1):
      PM / wakeirq: Fix unbalanced IRQ enable for wakeirq

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu | 77 +++++++++++++++++++++-
 drivers/base/core.c                                |  3 +
 drivers/base/power/wakeirq.c                       |  6 +-
 drivers/opp/cpu.c                                  |  2 +-
 include/linux/cpuidle.h                            |  2 +-
 5 files changed, 84 insertions(+), 6 deletions(-)
