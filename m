Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F728C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D1A21916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545390385;
	bh=OHu9i6d9Fb6bWOPuP0YjcQbyykOZQzX8JCuQHT4I0ew=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=dn5OdhKtDq3huL9dCdzvlHaGiYC9Nggx8jTpqxgwW0vsQFGKG38rsHnUdOxm0KEKP
	 VndUin2VvGUvfnjTvQUR9OGvfsPxxYr+7k4JTdfR0rHFm4WoqzBkrTMm/XGH0rPhEd
	 KSF47wh8vnx/dTOda9Xr8LfVWNdVzTxUnMPR8aBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeLULGY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:06:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34971 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLULGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:06:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so4778703otj.2;
        Fri, 21 Dec 2018 03:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=egtZ9I0Z1h25kUyU5OtmWfBk2Ceu63pshoQkFBZqrcY=;
        b=kU/ZVoYpvC4/BUZDxW+3NxGaHuU6saxyU19Ij5dcIpMeLIrrt2Ll49/rVjf2HPgiEk
         1imwfc/J9TysYAJrUfuDG+nYSEMrMZGDV6+kPcCBEeGn8+1fgjfqoM3IWsdpEUi+mL/W
         OzvSeLSWLGtabdpH+WILf9o/uw2jG19WSbqMHRd//tzuwdAE06CwP0VSbJAW+8vCx2++
         LlTyqhDCrj4MmyOsi5ZxqPdCckUVGYn03/u3S1e8gIx/TaDUu8rz6AJkkPTPreXlz7qc
         as2Pixut9NGy9TJDp+Yv7yU0P+rwJWeth/D22jACzARbmcA1qk4muMAl4dTJMnltrSQB
         t3Qw==
X-Gm-Message-State: AJcUukdTGc5p3bk6nAiXIh0dTCFkMrYZSudepe4hB5ZHSUwwRm4DMla3
        KEAgq1jkvYhCMT0nPlDwh/zfQwDjKK34Amn0QpQ=
X-Google-Smtp-Source: ALg8bN4R9CpeACt+mSWO7cGYTumSHaq7WuY9Yexu7hUEc7p0pSzKQmOJ5ciFEEnakq2rR9ap5Q2k1roAZ+nAyx4gxhg=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr1209841ota.244.1545390383092;
 Fri, 21 Dec 2018 03:06:23 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Dec 2018 12:06:11 +0100
Message-ID: <CAJZ5v0hYQDnPiS=QJ=O2ZjuAJO5RhzS6QPjUa4J92bY6Q++1Hw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v4.21-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This goes early due to the upcoming holidays period.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.21-rc1

with top-most commit a465d38fa3dce6a0dc2d5814cb3aa7b0d2982c6b

 Merge branches 'pm-devfreq', 'pm-avs' and 'pm-tools'

on top of commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd

 Linux 4.20-rc7

to receive power management updates for 4.21-rc1.

These add sysadmin documentation for cpuidle, extend the cpuidle
subsystem somewhat, improve the handling of performance states in
the generic power domains (genpd) and operating performance points
(OPP) frameworks, add a new cpufreq driver for Qualcomm SoCs, update
some other cpufreq drivers, switch over the runtime PM framework to
using high-res timers for device autosuspend, fix a problem with
suspend-to-idle on ACPI-based platforms, add system-wide suspend
and resume handling to the devfreq framework, do some janitorial
cleanups all over and update some utilities.

Specifics:

 - Add sysadmin documentation for cpuidle (Rafael Wysocki).

 - Make it possible to specify a cpuidle governor from kernel
   command line, add new cpuidle state sysfs attributes for
   governor evaluation, and improve the "polling" idle state
   handling (Rafael Wysocki).

 - Fix the handling of the "required-opps" DT property in the
   operating performance points (OPP) framework, improve the
   integration of it with the generic power domains (genpd)
   framework, improve the handling of performance states in
   them and clean up the idle states vs performance states
   separation in genpd (Viresh Kumar, Ulf Hansson).

 - Add a cpufreq driver called "qcom-hw" for Qualcomm SoCs using
   a hardware engine to control CPU frequency transitions along
   with DT bindings for it (Taniya Das).

 - Fix an intel_pstate driver issue related to CPU offline and
   update the documentation of it (Srinivas Pandruvada).

 - Clean up the imx6q cpufreq driver (Anson Huang).

 - Add SPDX license IDs to cpufreq schedutil governor files (Daniel
   Lezcano).

 - Switch over the runtime PM framework to using high-res timers
   for device autosuspend to allow the control of it to be more
   precise (Vincent Guittot).

 - Disable non-wakeup ACPI GPEs during suspend-to-idle so that they
   don't prevent the system from reaching the target low-power state
   and simplify the suspend-to-idle handling on ACPI platforms
   without full Low-Power S0 Idle (LPS0) support (Rafael Wysocki).

 - Add system-wide suspend and resume support to the devfreq
   framework (Lukasz Luba).

 - Clean up the SmartReflex adaptive voltage scaling (AVS) driver and
   add an SPDX license ID to it (Nishanth Menon, Uwe Kleine-König,
   Thomas Meyer).

 - Get rid of code duplication by using the DEFINE_SHOW_ATTRIBUTE
   macro in some places, fix some DT node refcount leaks, and do
   some other janitorial cleanups (Yangtao Li).

 - Update the cpupower, intel_pstate_tracer and turbosat utilities
   (Abhishek Goel, Doug Smythies, Len Brown).

Thanks!


---------------

Abhishek Goel (1):
      cpupower : Auto-completion for cpupower tool

Anson Huang (2):
      cpufreq: imx6q: remove unused code
      cpufreq: imx6q: save one condition block for normal case of nvmem read

Daniel Lezcano (1):
      sched/cpufreq: Add the SPDX tags

Doug Smythies (1):
      tools/power/x86/intel_pstate_tracer: Fix non root execution for
post processing a trace file

Len Brown (4):
      tools/power turbosat: fix AMD APIC-id output
      tools/power turbostat: reduce debug output
      tools/power turbostat: fix goldmont C-state limit decoding
      tools/power turbostat: consolidate duplicate model numbers

Lukasz Luba (3):
      PM / devfreq: refactor set_target frequency function
      PM / devfreq: add support for suspend/resume of a devfreq device
      PM / devfreq: add devfreq_suspend/resume() functions

Nishanth Menon (1):
      PM / AVS: SmartReflex: Switch to SPDX Licence ID

Rafael J. Wysocki (6):
      Documentation: admin-guide: PM: Add cpuidle document
      cpuidle: poll_state: Disregard disable idle states
      cpuidle: Add cpuidle.governor= command line parameter
      cpuidle: Add 'above' and 'below' idle state metrics
      ACPI: EC / PM: Disable non-wakeup GPEs for suspend-to-idle
      ACPI: PM: Loop in full LPS0 mode only

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Force HWP min perf before offline
      Documentation: intel_pstate: Clarify coordination of P-State limits

Taniya Das (2):
      dt-bindings: cpufreq: Introduce QCOM cpufreq firmware bindings
      cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver

Thomas Meyer (1):
      PM / AVS: SmartReflex: NULL check before some freeing functions
is not needed

Ulf Hansson (1):
      PM / Domains: Make genpd performance states orthogonal to the idlestates

Uwe Kleine-König (1):
      PM / AVS: SmartReflex: remove unused function

Vincent Guittot (1):
      PM-runtime: Switch autosuspend over to using hrtimers

Viresh Kumar (18):
      PM / Domains: Rename genpd virtual devices as virt_dev
      OPP: Identify and mark genpd OPP tables
      OPP: Separate out custom OPP handler specific code
      OPP: Populate required opp tables from "required-opps" property
      OPP: Populate OPPs from "required-opps" property
      PM / Domains: Add genpd_opp_to_performance_state()
      OPP: Add dev_pm_opp_{set|put}_genpd_virt_dev() helper
      OPP: Configure all required OPPs
      OPP: Rename and relocate of_genpd_opp_to_performance_state()
      OPP: Remove of_dev_pm_opp_find_required_opp()
      OPP: Use opp_table->regulators to verify no regulator case
      OPP: Fix missing debugfs supply directory for OPPs
      OPP: Improve _find_table_of_opp_np()
      OPP: Add dev_pm_opp_xlate_performance_state() helper
      OPP: Don't return 0 on error from of_get_required_opp_performance_state()
      PM / Domains: Save OPP table pointer in genpd
      PM / Domains: Factorize dev_pm_genpd_set_performance_state()
      PM / Domains: Propagate performance state updates

Yangtao Li (9):
      PM / QoS: Change to use DEFINE_SHOW_ATTRIBUTE macro
      cpufreq: s3c24xx: Change to use DEFINE_SHOW_ATTRIBUTE macro
      cpufreq: powernv: add of_node_put()
      cpufreq: pmac64: add of_node_put()
      cpuidle: big.LITTLE: fix refcount leak
      cpufreq: ia64: Remove unused header files
      cpufreq: nforce2: Remove meaningless return
      PM / sleep: convert to DEFINE_SHOW_ATTRIBUTE
      PM / Domains: remove define_genpd_open_function() and
define_genpd_debugfs_fops()

---------------

 Documentation/ABI/testing/sysfs-devices-system-cpu |   7 +
 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/admin-guide/pm/cpuidle.rst           | 631 +++++++++++++++++++++
 Documentation/admin-guide/pm/intel_pstate.rst      |  10 +-
 Documentation/admin-guide/pm/working-state.rst     |   1 +
 Documentation/cpuidle/core.txt                     |  23 -
 Documentation/cpuidle/sysfs.txt                    |  98 ----
 .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 ++++++
 drivers/acpi/ec.c                                  |  12 +
 drivers/acpi/internal.h                            |   2 +
 drivers/acpi/sleep.c                               |  16 +-
 drivers/base/power/domain.c                        | 343 ++++++-----
 drivers/base/power/runtime.c                       |  63 +-
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-nforce2.c                  |   3 -
 drivers/cpufreq/ia64-acpi-cpufreq.c                |   5 -
 drivers/cpufreq/imx6q-cpufreq.c                    |  17 +-
 drivers/cpufreq/intel_pstate.c                     |  28 +-
 drivers/cpufreq/pmac64-cpufreq.c                   |   1 +
 drivers/cpufreq/powernv-cpufreq.c                  |  17 +-
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 308 ++++++++++
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c          |  46 +-
 drivers/cpuidle/cpuidle-big_little.c               |   7 +-
 drivers/cpuidle/cpuidle.c                          |  32 +-
 drivers/cpuidle/cpuidle.h                          |   1 +
 drivers/cpuidle/governor.c                         |   9 +-
 drivers/cpuidle/poll_state.c                       |  11 +-
 drivers/cpuidle/sysfs.c                            |   6 +
 drivers/devfreq/devfreq.c                          | 153 +++--
 drivers/opp/core.c                                 | 347 ++++++++---
 drivers/opp/of.c                                   | 339 +++++++++--
 drivers/opp/opp.h                                  |  26 +-
 drivers/power/avs/smartreflex.c                    |  39 +-
 include/linux/cpuidle.h                            |   2 +
 include/linux/devfreq.h                            |  13 +
 include/linux/pm.h                                 |   5 +-
 include/linux/pm_domain.h                          |  14 +-
 include/linux/pm_opp.h                             |  23 +-
 include/linux/pm_runtime.h                         |   6 +-
 include/linux/power/smartreflex.h                  |  10 +-
 kernel/power/main.c                                |  15 +-
 kernel/power/qos.c                                 |  15 +-
 kernel/sched/cpufreq.c                             |   5 +-
 kernel/sched/cpufreq_schedutil.c                   |   5 +-
 tools/power/cpupower/Makefile                      |   6 +-
 tools/power/cpupower/cpupower-completion.sh        | 128 +++++
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |   4 +-
 tools/power/x86/turbostat/turbostat.c              | 189 +++---
 49 files changed, 2524 insertions(+), 704 deletions(-)
