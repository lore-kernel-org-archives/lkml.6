Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeERKWb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:22:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47348 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbeERKWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:22:30 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 0/6] arm64: perf: Support for chaining event counters
Date: Fri, 18 May 2018 11:22:17 +0100
Message-Id: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds support for counting PMU events using chained counters.
The Arm v8 PMUv3 supports combining two adjacent 32bit counters
(even and odd) to count a given "event" in 64bit mode. This series adds
the support for this mode in the core arm_pmu driver infrastructure and
also adds the support for armv8 64bit kernel PMU. This also removes the
restriction of using CPU Cycles counter (naturally 64bit) in 32bit mode.

Tested on Juno, Fast models. Applies on 4.17-rc4

Suzuki K Poulose (6):
  arm_pmu: Refactor maximum period handling
  arm_pmu: Change API to support 64bit counter values
  arm_pmu: Add support for long event counters
  arm64: perf: Make the cycle counter 64bit by default
  armpmu: Tidy up clear_event_idx call backs
  arm64: perf: Add support for chaining counters

 arch/arm/kernel/perf_event_v6.c     |   8 +-
 arch/arm/kernel/perf_event_v7.c     |   8 +-
 arch/arm/kernel/perf_event_xscale.c |   8 +-
 arch/arm64/kernel/perf_event.c      | 258 ++++++++++++++++++++++++++++++------
 drivers/perf/arm_pmu.c              |  52 ++++++--
 include/linux/perf/arm_pmu.h        |  12 +-
 6 files changed, 281 insertions(+), 65 deletions(-)

-- 
2.7.4
