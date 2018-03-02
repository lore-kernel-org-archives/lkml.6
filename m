Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427282AbeCBLgr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:36:47 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:44952 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423169AbeCBLgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:36:42 -0500
X-Google-Smtp-Source: AG47ELu0FtAD72KwrWhSy0B//fF8yHM2cZHvFQtaKrM0lGsKkPU5K/yrk1J/AovImC6idaJCGNwb70zQk1LLA0ueCp8=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Mar 2018 12:36:40 +0100
X-Google-Sender-Auth: oE7_dURwYp8LKvHwH9lRG5EI2FE
Message-ID: <CAJZ5v0hD3MDOzNNWu4XNOXWTX2PcP2+PgfKFk1TJ7_Yd+JHncw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.16-rc4

with top-most commit b61e0703053321d2cdf397c438ce8d21c7317f7a

 Merge branch 'cpufreq-scpi'

on top of commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb

 Linux 4.16-rc3

to receive power management fixes for 4.16-rc4.

These fix three issues in cpufreq drivers: one recent regression, one
leftover Kconfig dependency and one old but "stable" material.

Specifics:

 - Make the task scheduler load and utilization signals be
   frequency-invariant again after recent changes in the SCPI
   cpufreq driver (Dietmar Eggemann).

 - Drop an unnecessary leftover Kconfig dependency from the SCPI
   cpufreq driver (Sudeep Holla).

 - Fix the initialization of the s3c24xx cpufreq driver (Viresh
   Kumar).

Thanks!


---------------

Dietmar Eggemann (1):
      cpufreq: scpi: invoke frequency-invariance setter function

Sudeep Holla (1):
      cpufreq: scpi: Fix incorrect arm_big_little config dependency

Viresh Kumar (1):
      cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

---------------

 drivers/cpufreq/Kconfig.arm       |  6 +++---
 drivers/cpufreq/s3c24xx-cpufreq.c |  8 +++++++-
 drivers/cpufreq/scpi-cpufreq.c    | 16 ++++++++++++----
 3 files changed, 22 insertions(+), 8 deletions(-)
