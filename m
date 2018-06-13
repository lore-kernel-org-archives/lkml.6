Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 771DBC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B3420891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymmm622R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B3420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935282AbeFMLCR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:02:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36954 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934968AbeFMLCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:02:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id l22-v6so1901842oib.4;
        Wed, 13 Jun 2018 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=lhY+hAby+JUX5FTtMADEb7N33Zz18zsnYtEktwjiatc=;
        b=Ymmm622RUvfL4rH+6mrS7ANTFxgjh3jPNcYnJSpDRmKGEd5QqhZZALp4nCL8I+2LE+
         +ZTEyFDrgmZp+Y7jyLgowf95Pshc7bhrVTAlhVsvrhcGp6wlz2yCfaWkboGk9u+y2IW0
         BhEyyQFoiNU4YsXP2PaH071RsTXW9eNe5CAIPFWPIP519mIcY9NGb82d91/31x+DGwB5
         Ed6LSqiR/NqsVH5N0eOsIkQUsztK6H0XbaoLUE+aHEPM18EGAeHa5ChoMSG02DBDCB1S
         2Gk/qOk8P8uaR3TiWAwRzE3VGDfAFRIVzskMC3BOF25qPcsDvGy0HxXsKTSR4stAlgSr
         6KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc:content-transfer-encoding;
        bh=lhY+hAby+JUX5FTtMADEb7N33Zz18zsnYtEktwjiatc=;
        b=hoHSKMgYW2i8mF5p75GZ8iBv27Wt58LggPBM80trkZ7LMNbMizYwFAeFz+WSpP8UVW
         maBVBXjV2pjiXV600igNKvhWVUDqO9of0pRVWjaxqmGV0twcH6StkjknlnYp6kLBrJfM
         RKDoxoby4+1ZUeoHovWKP+IVwpweCvouXl6zqYVdYNzX2UAbjdx/cvZYy1wO+eIC50T0
         bIfk6n6THvG/tx6Ni5Auq4lQB2hK8RZDB/u6pKXAQWHtl18Y8vqQ4QiGsoAB56aK8qCX
         rhylaBNpZSzFrnA0p5NmqXf+u2gnQwEzcw6ky+lvuaFNhdTI69p/wzfO8AVNEq7mhwKF
         XGkA==
X-Gm-Message-State: APt69E2nEeM0Ee9Bnpfe/4NFkqXgRH43szDIz6B37hjgHImUnBWDbTr8
        OoJOYj3m0cMezWe2I5JrrZM+e4990m/kHk+0BPpUPA==
X-Google-Smtp-Source: ADUXVKKoxY8rxIftMXTBTN+zOj7oWQZZuywp+SWdH+KqsMbZ3J4InqShrNH5wn15KJv4FUyCAh3nDoDGA8EO4lhZfaE=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr3913608oig.282.1528887734664;
 Wed, 13 Jun 2018 04:02:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 04:02:13
 -0700 (PDT)
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jun 2018 13:02:13 +0200
X-Google-Sender-Auth: k952ti1H1-gfxfJD_HcYSdmzdkM
Message-ID: <CAJZ5v0hvAcw+9uHA+uMOZvrg75iqTanh53p-8-8S-7RyhSrmRg@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v4.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.18-rc1-2

with top-most commit 6a900f884e3e864d13501e63357990bc472f940c

 Merge branches 'pm-domains' and 'pm-tools'

on top of commit 3c89adb0d11117f64d5b501730be7fb2bf53a479

 Merge tag 'pm-4.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 4.18-rc1.

These revert a recent PM core change that introduced a regression,
fix build when the recently added Kryo cpufreq driver is selected,
add support for devices attached to multiple power domains to the
generic power domains (genpd) framework, add support for iowait
boosting on systens with hardware-managed P-states (HWP) enabled
to the intel_pstate driver, modify the behavior of the wakeup_count
device attribute in sysfs, fix a few issues and clean up some
ugliness, mostly in cpufreq (core and drivers) and in the cpupower
utility.

Specifics:

 - Revert a recent PM core change that attempted to fix an issue
   related to device links, but introduced a regression (Rafael
   Wysocki).

 - Fix build when the recently added cpufreq driver for Kryo
   processors is selected by making it possible to build that
   driver as a module (Arnd Bergmann).

 - Fix the long idle detection mechanism in the out-of-band
   (ondemand and conservative) cpufreq governors (Chen Yu).

 - Add support for devices in multiple power domains to the
   generic power domains (genpd) framework (Ulf Hansson).

 - Add support for iowait boosting on systems with hardware-managed
   P-states (HWP) enabled to the intel_pstate driver and make it use
   that feature on systems with Skylake Xeon processors as it is
   reported to improve performance significantly on those systems
   (Srinivas Pandruvada).

 - Fix and update the acpi_cpufreq, ti-cpufreq and imx6q cpufreq
   drivers (Colin Ian King, Suman Anna, S=C3=A9bastien Szymanski).

 - Change the behavior of the wakeup_count device attribute in
   sysfs to expose the number of events when the device might have
   aborted system suspend in progress (Ravi Chandra Sadineni).

 - Fix two minor issues in the cpupower utility (Abhishek Goel,
   Colin Ian King).

Thanks!


---------------

Abhishek Goel (1):
      cpupower : Fix header name to read idle state name

Arnd Bergmann (1):
      cpufreq: kryo: allow building as a loadable module

Chen Yu (1):
      cpufreq: governors: Fix long idle detection logic in load calculation

Colin Ian King (2):
      cpupower: fix spelling mistake: "logilename" -> "logfilename"
      cpufreq: ACPI: make function acpi_cpufreq_fast_switch() static

Rafael J. Wysocki (1):
      Revert "PM / runtime: Fixup reference counting of device link
suppliers at probe"

Ravi Chandra Sadineni (1):
      PM / wakeup: Export wakeup_count instead of event_count via sysfs

Srinivas Pandruvada (4):
      cpufreq: intel_pstate: Add HWP boost utility and sched util hooks
      cpufreq: intel_pstate: HWP boost performance on IO wakeup
      cpufreq: intel_pstate: New sysfs entry to control HWP boost
      cpufreq: intel_pstate: enable boost for Skylake Xeon

Suman Anna (2):
      cpufreq: ti-cpufreq: Fix an incorrect error return value
      cpufreq: ti-cpufreq: Use devres managed API in probe()

S=C3=A9bastien Szymanski (1):
      cpufreq: imx6q: check speed grades for i.MX6ULL

Ulf Hansson (5):
      PM / Domains: dt: Allow power-domain property to be a list of specifi=
ers
      PM / Domains: Don't attach devices in genpd with multi PM domains
      PM / Domains: Split genpd_dev_pm_attach()
      PM / Domains: Add support for multi PM domains per device to genpd
      PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM dom=
ains

---------------

 .../devicetree/bindings/power/power_domain.txt     |  19 ++-
 drivers/base/dd.c                                  |   3 +-
 drivers/base/power/common.c                        |  43 ++++-
 drivers/base/power/domain.c                        | 134 ++++++++++++---
 drivers/base/power/runtime.c                       |  27 +++-
 drivers/base/power/sysfs.c                         |   2 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/acpi-cpufreq.c                     |   4 +-
 drivers/cpufreq/cpufreq_governor.c                 |  12 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |  29 +++-
 drivers/cpufreq/intel_pstate.c                     | 179 +++++++++++++++++=
+++-
 drivers/cpufreq/ti-cpufreq.c                       |   7 +-
 include/linux/pm_domain.h                          |  15 ++
 include/linux/pm_runtime.h                         |   6 +-
 tools/power/cpupower/bench/parse.c                 |   2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |  15 ++
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |  35 ++--
 .../cpupower/utils/idle_monitor/cpupower-monitor.h |   9 ++
 18 files changed, 468 insertions(+), 75 deletions(-)
