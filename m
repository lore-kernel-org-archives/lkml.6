Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754429AbeDBLLt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 07:11:49 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:35424 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754393AbeDBLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 07:11:46 -0400
X-Google-Smtp-Source: AIpwx4+d8i3ZaT8NdXlmI05scl3gmGYsggOAn3XIfQapXcKyLWJzdPVzPgerI4Hk90HFVWzz4lC3ia6C4Vyflt3cWA0=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Apr 2018 13:11:45 +0200
X-Google-Sender-Auth: vAcpkeWoz3fJEWjSTpAgKsbyJBI
Message-ID: <CAJZ5v0go-04sgZSZ+-c_f86n6rFPvGWyjeug146758axSu8UKQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.17-rc1

with top-most commit 103cf0e5799ce024fd28dfab716d7111afe4b117

 Merge branches 'pm-cpuidle' and 'pm-tools'

on top of commit 0c8efd610b58cb23cefdfa12015799079aef94ae

 Linux 4.16-rc5

to receive power management updates for 4.17-rc1.

These update the cpuidle poll state definition to redice excessive
energy usage related to it, add new CPU ID to the RAPL power capping
driver, update the ACPI system suspend code to handle some special
cases better, extend the PM core's device links code slightly, add
new sysfs attribute for better suspend-to-idle diagnostics and easier
hibernation handling, update power management tools and clean up
cpufreq quite a bit.

Specifics:

 - Modify the cpuidle poll state implementation to prevent CPUs from
   staying in the loop in there for excessive times (Rafael Wysocki).

 - Add Intel Cannon Lake chips support to the RAPL power capping
   driver (Joe Konno).

 - Add reference counting to the device links handling code in the
   PM core (Lukas Wunner).

 - Avoid reconfiguring GPEs on suspend-to-idle in the ACPI system
   suspend code (Rafael Wysocki).

 - Allow devices to be put into deeper low-power states via ACPI
   if both _SxD and _SxW are missing (Daniel Drake).

 - Reorganize the core ACPI suspend-to-idle wakeup code to avoid a
   keyboard wakeup issue on Asus UX331UA (Chris Chiu).

 - Prevent the PCMCIA library code from aborting suspend-to-idle due
   to noirq suspend failures resulting from incorrect assumptions
   (Rafael Wysocki).

 - Add coupled cpuidle supprt to the Exynos3250 platform (Marek
   Szyprowski).

 - Add new sysfs file to make it easier to specify the image storage
   location during hibernation (Mario Limonciello).

 - Add sysfs files for collecting suspend-to-idle usage and time
   statistics for CPU idle states (Rafael Wysocki).

 - Update the pm-graph utilities (Todd Brandt).

 - Reduce the kernel log noise related to reporting Low-power Idle
   constraings by the ACPI system suspend code (Rafael Wysocki).

 - Make it easier to distinguish dedicated wakeup IRQs in the
   /proc/interrupts output (Tony Lindgren).

 - Add the frequency table validation in cpufreq to the core and
   drop it from a number of cpufreq drivers (Viresh Kumar).

 - Drop "cooling-{min|max}-level" for CPU nodes from a couple of
   DT bindings (Viresh Kumar).

 - Clean up the CPU online error code path in the cpufreq core
   (Viresh Kumar).

 - Fix assorted issues in the SCPI, CPPC, mediatek and tegra186
   cpufreq drivers (Arnd Bergmann, Chunyu Hu, George Cherian,
   Viresh Kumar).

 - Drop memory allocation error messages from a few places in
   cpufreq and cpuildle drivers (Markus Elfring).

Thanks!

---------------

Arnd Bergmann (1):
      cpufreq: scpi: Add thermal dependency

Chris Chiu (1):
      ACPI / PM: Fix keyboard wakeup from suspend-to-idle on ASUS UX331UA

Chunyu Hu (1):
      cpufreq: cppc_cpufreq: Fix cppc_cpufreq_init() failure path

Daniel Drake (1):
      ACPI / PM: Allow deeper wakeup power states with no _SxD nor _SxW

George Cherian (1):
      cpufreq: CPPC: Use transition_delay_us depending transition_latency

Joe Konno (1):
      powercap: RAPL: Add support for Cannon Lake

Lukas Wunner (1):
      driver core: Introduce device links reference counting

Marek Szyprowski (1):
      cpuidle: Enable coupled cpuidle support on Exynos3250 platform

Mario Limonciello (2):
      PM / hibernate: Make passing hibernate offsets more friendly
      PM / hibernate: Change message when writing to /sys/power/resume

Markus Elfring (5):
      cpufreq: s3c24xx: Drop memory allocation error messages from two functions
      cpufreq: qoriq: Drop memory allocation error messages from
qoriq_cpufreq_cpu_init()
      cpufreq: powernow-k8: Drop memory allocation error messages from
three functions
      cpufreq: powernow-k8: Drop unnecessary return statements from
two functions
      ARM: cpuidle: Drop memory allocation error message from
arm_idle_init_cpu()

Rafael J. Wysocki (6):
      ACPI / PM: Do not reconfigure GPEs for suspend-to-idle
      PCMCIA / PM: Avoid noirq suspend aborts during suspend-to-idle
      ACPI / PM: Reduce LPI constraints logging noise
      cpuidle: poll_state: Add time limit to poll_idle()
      PM: cpuidle/suspend: Add s2idle usage and time state attributes
      cpuidle: poll_state: Avoid invoking local_clock() too often

Todd E Brandt (3):
      pm-graph: config files and installer
      pm-graph: AnalyzeBoot v2.2
      pm-graph: AnalyzeSuspend v5.0

Tony Lindgren (1):
      PM / wakeirq: Add wakeup name to dedicated wake irqs

Viresh Kumar (31):
      ARM: dts: mt7623: Remove "cooling-{min|max}-level" for CPU nodes
      dt-bindings: cpufreq-dt: Remove "cooling-{min|max}-level" properties
      cpufreq: mediatek: Convert pr_warn() to pr_debug()
      cpufreq: Reorder cpufreq_online() error code path
      cpufreq: Validate frequency table in the core
      cpufreq: tegra186: Break after initialization is done for policy->cpu
      cpufreq: powernv: Don't validate the frequency table twice
      cpufreq: imx6q: Find max freq from frequency table itself
      cpufreq: Don't validate cpufreq table from cpufreq_generic_init()
      cpufreq: ACPI: Don't validate the frequency table twice
      cpufreq: arm_big_little: Don't validate the frequency table twice
      cpufreq: brcmstb: Don't validate the frequency table twice
      cpufreq: cpufreq-dt: Don't validate the frequency table twice
      cpufreq: e_powersaver: Don't validate the frequency table twice
      cpufreq: elanfreq: Don't validate the frequency table twice
      cpufreq: ia64-acpi: Don't validate the frequency table twice
      cpufreq: longhaul: Don't validate the frequency table twice
      cpufreq: mediatek: Don't validate the frequency table twice
      cpufreq: p4-clockmod: Don't validate the frequency table twice
      cpufreq: powernow: Don't validate the frequency table twice
      cpufreq: ppc_cbe: Don't validate the frequency table twice
      cpufreq: pxa: Don't validate the frequency table twice
      cpufreq: qoirq: Don't validate the frequency table twice
      cpufreq: s3c24xx: Don't validate the frequency table twice
      cpufreq: sc520: Don't validate the frequency table twice
      cpufreq: scpi: Don't validate the frequency table twice
      cpufreq: sfi: Don't validate the frequency table twice
      cpufreq: sh: Don't validate the frequency table twice
      cpufreq: sparc: Don't validate the frequency table twice
      cpufreq: speedstep: Don't validate the frequency table twice
      cpufreq: tegra186: Don't validate the frequency table twice

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |   25 +
 Documentation/ABI/testing/sysfs-power              |   14 +
 .../devicetree/bindings/cpufreq/cpufreq-dt.txt     |    4 -
 .../bindings/cpufreq/cpufreq-mediatek.txt          |    4 -
 Documentation/power/swsusp.txt                     |   10 +-
 arch/arm/boot/dts/mt7623.dtsi                      |    2 -
 drivers/acpi/device_pm.c                           |   11 +-
 drivers/acpi/sleep.c                               |   24 +-
 drivers/base/core.c                                |   25 +-
 drivers/base/power/power.h                         |    1 +
 drivers/base/power/wakeirq.c                       |   13 +-
 drivers/cpufreq/Kconfig.arm                        |    1 +
 drivers/cpufreq/acpi-cpufreq.c                     |   20 +-
 drivers/cpufreq/arm_big_little.c                   |    9 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |    6 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   12 +-
 drivers/cpufreq/cpufreq-dt.c                       |    8 +-
 drivers/cpufreq/cpufreq.c                          |   28 +-
 drivers/cpufreq/e_powersaver.c                     |    8 +-
 drivers/cpufreq/elanfreq.c                         |    3 +-
 drivers/cpufreq/freq_table.c                       |   16 +-
 drivers/cpufreq/ia64-acpi-cpufreq.c                |    7 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |    7 +-
 drivers/cpufreq/longhaul.c                         |    3 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |   13 +-
 drivers/cpufreq/p4-clockmod.c                      |    3 +-
 drivers/cpufreq/powernow-k6.c                      |    3 +-
 drivers/cpufreq/powernow-k7.c                      |    3 +-
 drivers/cpufreq/powernow-k8.c                      |   24 +-
 drivers/cpufreq/powernv-cpufreq.c                  |   11 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c                  |    5 +-
 drivers/cpufreq/pxa2xx-cpufreq.c                   |    4 +-
 drivers/cpufreq/pxa3xx-cpufreq.c                   |    4 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   21 +-
 drivers/cpufreq/s3c24xx-cpufreq.c                  |   13 +-
 drivers/cpufreq/sc520_freq.c                       |    3 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   10 +-
 drivers/cpufreq/sfi-cpufreq.c                      |    3 +-
 drivers/cpufreq/sh-cpufreq.c                       |   22 +-
 drivers/cpufreq/sparc-us2e-cpufreq.c               |    3 +-
 drivers/cpufreq/sparc-us3-cpufreq.c                |    3 +-
 drivers/cpufreq/speedstep-centrino.c               |    4 +-
 drivers/cpufreq/speedstep-ich.c                    |    4 +-
 drivers/cpufreq/speedstep-smi.c                    |    4 +-
 drivers/cpufreq/tegra186-cpufreq.c                 |    3 +-
 drivers/cpuidle/cpuidle-arm.c                      |    1 -
 drivers/cpuidle/cpuidle-exynos.c                   |    3 +-
 drivers/cpuidle/cpuidle.c                          |    9 +
 drivers/cpuidle/poll_state.c                       |   17 +-
 drivers/cpuidle/sysfs.c                            |   54 +
 drivers/pcmcia/cs.c                                |   10 +-
 drivers/pcmcia/cs_internal.h                       |    1 +
 drivers/powercap/intel_rapl.c                      |    1 +
 include/linux/cpufreq.h                            |    1 +
 include/linux/cpuidle.h                            |    4 +
 include/linux/device.h                             |    2 +
 kernel/power/hibernate.c                           |   26 +-
 tools/power/pm-graph/Makefile                      |   29 +-
 tools/power/pm-graph/bootgraph.8                   |   18 +-
 .../pm-graph/{analyze_boot.py => bootgraph.py}     |  219 ++-
 tools/power/pm-graph/config/cgskip.txt             |   65 +
 .../pm-graph/config/custom-timeline-functions.cfg  |  205 +++
 tools/power/pm-graph/config/example.cfg            |  133 ++
 tools/power/pm-graph/config/freeze-callgraph.cfg   |   94 ++
 tools/power/pm-graph/config/freeze-dev.cfg         |   93 ++
 tools/power/pm-graph/config/freeze.cfg             |   93 ++
 tools/power/pm-graph/config/standby-callgraph.cfg  |   94 ++
 tools/power/pm-graph/config/standby-dev.cfg        |   93 ++
 tools/power/pm-graph/config/standby.cfg            |   93 ++
 tools/power/pm-graph/config/suspend-callgraph.cfg  |   98 ++
 tools/power/pm-graph/config/suspend-dev.cfg        |   93 ++
 tools/power/pm-graph/config/suspend-x2-proc.cfg    |   93 ++
 tools/power/pm-graph/config/suspend.cfg            |   93 ++
 tools/power/pm-graph/sleepgraph.8                  |   47 +-
 .../pm-graph/{analyze_suspend.py => sleepgraph.py} | 1625 ++++++++++++--------
 75 files changed, 2916 insertions(+), 915 deletions(-)
