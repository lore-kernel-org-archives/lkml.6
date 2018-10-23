Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD17C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694B920671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694B920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJWOBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:01:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38766 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJWOBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:01:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id k19-v6so119851oiw.5;
        Mon, 22 Oct 2018 22:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/OPeJDXiFw6fT5gV6Yn41KeRiyAFnfRe5fWOrGsNVyQ=;
        b=eqV8BSieWdDFFh0M4dPkfPchYSe4FJv/+WIw80ZAA4n0CXtzN1XFTHXpEXFY9biXMQ
         HUKVm1vm/1r8FmL+bN3G36LRySNJZ1KqeilDk5PPi7wY2DDXfsI1dH/aGxS0kgRZJLjd
         tG9apLViVhgvLDSFJqYZweNfWUqoBghmL6vSawCrSDyUzUfdI1qSF5Xk3JjYsYcne4Bv
         on15cmgGa4sfwXUc2DqPv0/Zwp/JvcEQfnnhiDbvCjhriWnETxuQZ45PCL3FLIEXZ54D
         tzfVv8SfGDfO3Qm4YYX1ulZ5VVP5YAzVefa/EmEkiQATd9LqdEh+KzHHp5YYv6kBRnQ3
         d9kA==
X-Gm-Message-State: ABuFfohK0BktSV0dqIc5uZVwVHIy64vmR6zfU/BQ4WJlxVf+SsYNS59P
        r4otihV/8B53YJMakGkHda9YlZ6WTOvLoB+yzCw=
X-Google-Smtp-Source: ACcGV62RQw9m668lte7MLQC6iBVrtXCeZP/i8RKAUT+BfpueTtwHyLixeNDOeiCRwOL3KSXf2eraW2LzvvfvU2g3ILA=
X-Received: by 2002:aca:b655:: with SMTP id g82-v6mr24184936oif.195.1540273160391;
 Mon, 22 Oct 2018 22:39:20 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Oct 2018 07:35:47 +0200
Message-ID: <CAJZ5v0gKMNurgsi9Et3JsBR6JVNAH8MRrQomF1QMtTa7OCR6bA@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc1

with top-most commit cc19b05e3883efbbfd525747a86d0567b12c4d12

 Merge branches 'pm-devfreq' and 'pm-tools'

on top of commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e

 Linux 4.19-rc8

to receive power management updates for 4.20-rc1.

These make hibernation on 32-bit x86 systems work in all of the
cases in which it works on 64-bit x86 ones, update the menu
cpuidle governor and the "polling" state to make them more
efficient, add more hardware support to cpufreq drivers and fix
issues with some of them, fix a bug in the conservative cpufreq
governor, fix the operating performance points (OPP) framework
and make it more stable, update the devfreq subsystem to take
changes in the APIs used by into account and clean up some
things all over.

Specifics:

 - Backport hibernation bug fixes from x86-64 to x86-32 and
   consolidate hibernation handling on x86 to allow 32-bit
   systems to work in all of the cases in which 64-bit ones
   work (Zhimin Gu, Chen Yu).

 - Fix hibernation documentation (Vladimir D. Seleznev).

 - Update the menu cpuidle governor to fix a couple of issues
   with it, make it more efficient in some cases and clean it
   up (Rafael Wysocki).

 - Rework the cpuidle polling state implementation to make it
   more efficient (Rafael Wysocki).

 - Clean up the cpuidle core somewhat (Fieah Lim).

 - Fix the cpufreq conservative governor to take policy limits
   into account properly in some cases (Rafael Wysocki).

 - Add support for retrieving guaranteed performance information
   to the ACPI CPPC library and make the intel_pstate driver use
   it to expose the CPU base frequency via sysfs on systems with
   the hardware-managed P-states (HWP) feature enabled (Srinivas
   Pandruvada).

 - Fix clang warning in the CPPC cpufreq driver (Nathan Chancellor).

 - Get rid of device_node.name printing from cpufreq (Rob Herring).

 - Remove unnecessary unlikely() from the cpufreq core (Igor Stoppa).

 - Add support for the r8a7744 SoC to the cpufreq-dt driver (Biju Das).

 - Update the dt-platdev cpufreq driver to allow RK3399 to have
   separate tunables per cluster (Dmitry Torokhov).

 - Fix the dma_alloc_coherent() usage in the tegra186 cpufreq driver
   (Christoph Hellwig).

 - Make the imx6q cpufreq driver read OCOTP through nvmem for
   imx6ul/imx6ull (Anson Huang).

 - Fix several bugs in the operating performance points (OPP)
   framework and make it more stable (Viresh Kumar, Dave Gerlach).

 - Update the devfreq subsystem to take changes in the APIs used
   by into account, fix some issues with it and make it stop
   print device_node.name directly (Bjorn Andersson, Enric Balletbo
   i Serra, Matthias Kaehlcke, Rob Herring, Vincent Donnefort, zhong
   jiang).

 - Prepare the generic power domains (genpd) framework for dealing
   with domains containing CPUs (Ulf Hansson).

 - Prevent sysfs attributes representing low-power S0 residency
   counters from being exposed if low-power S0 support is not
   indicated in ACPI FADT (Rajneesh Bhardwaj).

 - Get rid of custom CPU features macros for Intel CPUs from the
   intel_idle and RAPL drivers (Andy Shevchenko).

 - Update the tasks freezer to list tasks that refused to freeze
   and caused a system transition to a sleep state to be aborted
   (Todd Brandt).

 - Update the pm-graph set of tools to v5.2 (Todd Brandt).

 - Fix some issues in the cpupower utility (Anders Roxell, Prarit
   Bhargava).

Thanks!


---------------

Anders Roxell (1):
      cpupower: remove stringop-truncation waring

Andy Shevchenko (2):
      intel_idle: Get rid of custom ICPU() macro
      powercap: RAPL: Get rid of custom RAPL_CPU() macro

Anson Huang (1):
      cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull

Biju Das (1):
      cpufreq: dt: Add support for r8a7744

Bjorn Andersson (1):
      PM / devfreq: Drop custom MIN/MAX macros

Chen Yu (1):
      PM / hibernate: Check the success of generating md5 digest
before hibernation

Christoph Hellwig (1):
      cpufreq: tegra186: don't pass GFP_DMA32 to dma_alloc_coherent()

Dave Gerlach (1):
      PM / OPP: _of_add_opp_table_v2(): increment count only if OPP is added

Dmitry Torokhov (1):
      cpufreq: dt-platdev: allow RK3399 to have separate tunables per cluster

Enric Balletbo i Serra (1):
      PM / devfreq: Fix devfreq_add_device() when drivers are built as modules.

Fieah Lim (2):
      cpuidle: Remove unnecessary wrapper cpuidle_get_last_residency()
      cpuidle: enter_state: Don't needlessly calculate diff time

Igor Stoppa (1):
      cpufreq: remove unnecessary unlikely()

Matthias Kaehlcke (3):
      PM / devfreq: Fix handling of min/max_freq == 0
      PM / devfreq: Don't adjust to user limits in governors
      PM / devfreq: Make update_devfreq() public

Nathan Chancellor (1):
      cpufreq / CPPC: Mark acpi_ids as used

Prarit Bhargava (2):
      cpupower: Fix AMD Family 0x17 msr_pstate size
      cpupower: Fix coredump on VMWare

Rafael J. Wysocki (12):
      cpuidle: menu: Replace data->predicted_us with local variable
      cpuidle: menu: Fix wakeup statistics updates for polling state
      cpuidle: menu: Compute first_idx when latency_req is known
      cpuidle: menu: Get rid of first_idx from menu_select()
      cpuidle: menu: Do not update last_state_idx in menu_select()
      cpuidle: menu: Avoid computations for very close timers
      cpuidle: menu: Move the latency_req == 0 special case check
      cpuidle: poll_state: Revise loop termination condition
      cpuidle: menu: Simplify checks related to the polling state
      cpufreq: conservative: Take limits changes into account properly
      cpuidle: menu: Drop redundant comparison
      cpuidle: menu: Avoid computations when result will be discarded

Rajneesh Bhardwaj (1):
      ACPI / PM: LPIT: Register sysfs attributes based on FADT

Rob Herring (2):
      cpufreq: Convert to using %pOFn instead of device_node.name
      PM / devfreq: Convert to using %pOFn instead of device_node.name

Srinivas Pandruvada (3):
      ACPI / CPPC: Add support for guaranteed performance
      cpufreq: intel_pstate: Add base_frequency attribute
      Documentation: intel_pstate: Add base_frequency information

Todd Brandt (3):
      PM / sleep: Show freezing tasks that caused a suspend abort
      PM / tools: sleepgraph: first batch of v5.2 changes
      PM / tools: sleepgraph and bootgraph: upgrade to v5.2

Ulf Hansson (3):
      PM / Domains: Don't treat zero found compatible idle states as an error
      PM / Domains: Deal with multiple states but no governor in genpd
      PM / Domains: Document flags for genpd

Vincent Donnefort (1):
      PM / devfreq: stopping the governor before device_unregister()

Viresh Kumar (15):
      OPP: Free OPP table properly on performance state irregularities
      OPP: Don't try to remove all OPP tables on failure
      OPP: Protect dev_list with opp_table lock
      OPP: Pass index to _of_init_opp_table()
      OPP: Parse OPP table's DT properties from _of_init_opp_table()
      OPP: Don't take OPP table's kref for static OPPs
      OPP: Create separate kref for static OPPs list
      cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
      OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
      OPP: Use a single mechanism to free the OPP table
      OPP: Prevent creating multiple OPP tables for devices sharing OPP nodes
      OPP: Pass OPP table to _of_add_opp_table_v{1|2}()
      OPP: Improve error handling in dev_pm_opp_of_cpumask_add_table()
      OPP: Return error on error from dev_pm_opp_get_opp_count()
      cpufreq: dt: Try freeing static OPPs only if we have added them

Vladimir D. Seleznev (1):
      PM / hibernate: Documentation: fix image_size default value

Zhimin Gu (11):
      x86, hibernate: Fix nosave_regions setup for hibernation
      x86-32/asm/power: Create stack frames in hibernate_asm_32.S
      x86, hibernate: Extract the common code of 64/32 bit system
      x86-32, hibernate: Enable CONFIG_ARCH_HIBERNATION_HEADER on 32bit system
      x86, hibernate: Rename temp_level4_pgt to temp_pgt
      x86-32, hibernate: Use temp_pgt as the temporary page table
      x86-32, hibernate: Use the page size macro instead of constant value
      x86-32, hibernate: Switch to original page table after resumed
      x86-32, hibernate: Switch to relocated restore code during
resume on 32bit system
      x86-32, hibernate: Set up temporary text mapping for 32bit system
      x86-32, hibernate: Adjust in_suspend after resumed on 32bit system

zhong jiang (1):
      PM / devfreq: remove redundant null pointer check before kfree

---------------

 Documentation/ABI/testing/sysfs-power              |    2 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |    7 +
 Documentation/power/swsusp.txt                     |    2 +-
 arch/x86/Kconfig                                   |    2 +-
 arch/x86/include/asm/suspend.h                     |    8 +
 arch/x86/include/asm/suspend_32.h                  |    4 +
 arch/x86/kernel/setup.c                            |    2 +-
 arch/x86/power/Makefile                            |    2 +-
 arch/x86/power/hibernate.c                         |  248 +++
 arch/x86/power/hibernate_32.c                      |   52 +-
 arch/x86/power/hibernate_64.c                      |  224 +--
 arch/x86/power/hibernate_asm_32.S                  |   37 +-
 arch/x86/power/hibernate_asm_64.S                  |    2 +-
 drivers/acpi/acpi_lpit.c                           |    6 +
 drivers/acpi/cppc_acpi.c                           |    8 +-
 drivers/base/power/domain.c                        |   20 +-
 drivers/cpufreq/cppc_cpufreq.c                     |    2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |    6 +-
 drivers/cpufreq/cpufreq-dt.c                       |   34 +-
 drivers/cpufreq/cpufreq.c                          |    2 +-
 drivers/cpufreq/cpufreq_conservative.c             |    6 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   52 +-
 drivers/cpufreq/intel_pstate.c                     |   38 +
 drivers/cpufreq/mvebu-cpufreq.c                    |    9 +-
 drivers/cpufreq/s5pv210-cpufreq.c                  |    4 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |    2 +-
 drivers/cpuidle/cpuidle.c                          |   16 +-
 drivers/cpuidle/governors/ladder.c                 |    2 +-
 drivers/cpuidle/governors/menu.c                   |  114 +-
 drivers/cpuidle/poll_state.c                       |    8 +-
 drivers/devfreq/devfreq.c                          |  118 +-
 drivers/devfreq/event/exynos-ppmu.c                |    4 +-
 drivers/devfreq/governor.h                         |    6 +-
 drivers/devfreq/governor_performance.c             |    5 +-
 drivers/devfreq/governor_powersave.c               |    2 +-
 drivers/devfreq/governor_simpleondemand.c          |   12 +-
 drivers/devfreq/governor_userspace.c               |   16 +-
 drivers/idle/intel_idle.c                          |   75 +-
 drivers/opp/core.c                                 |  149 +-
 drivers/opp/cpu.c                                  |   15 +-
 drivers/opp/of.c                                   |  237 +--
 drivers/opp/opp.h                                  |   19 +-
 drivers/powercap/intel_rapl.c                      |   73 +-
 include/acpi/cppc_acpi.h                           |    1 +
 include/linux/cpuidle.h                            |   11 +-
 include/linux/devfreq.h                            |    8 +
 include/linux/pm_domain.h                          |   35 +-
 include/linux/pm_opp.h                             |    6 +
 kernel/power/process.c                             |    2 +-
 tools/power/cpupower/bench/parse.c                 |    2 +-
 tools/power/cpupower/utils/cpufreq-info.c          |    2 +
 tools/power/cpupower/utils/helpers/amd.c           |    7 +-
 tools/power/pm-graph/Makefile                      |    4 +-
 tools/power/pm-graph/bootgraph.py                  |  125 +-
 tools/power/pm-graph/config/cgskip.txt             |    1 +
 .../pm-graph/config/custom-timeline-functions.cfg  |    4 +-
 tools/power/pm-graph/sleepgraph.8                  |   13 +-
 tools/power/pm-graph/sleepgraph.py                 | 1836 +++++++++++---------
 58 files changed, 2123 insertions(+), 1586 deletions(-)
