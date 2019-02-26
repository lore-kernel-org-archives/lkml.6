Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DB0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A682184E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEhuYlCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfBZOyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:54:35 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38236 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfBZOye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:54:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id j19so11023943ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bAWEQtmf+fggjn633EQ0gBHasaIotZNQ6JNtd1TnYlY=;
        b=yEhuYlCnoHOeoTTeypOCSSGycNr6eghlJAYY/0Qk/w47J4Xm7zDOZWXf3VzOryDoFH
         JUK9D/277P9gzy0yI1MPay9RVdBQBSrIIqwFVv/mnGXNTCWa3O84uGSBtMAt5Rbp8/sU
         QhhjCK7dXpC+PmeW5EF7+3YKj7RZyPEHoZEtKbuHv0dA8+Zk6uaoqmEnUu9XdBrRd657
         Qp6OrgrPjz4PBgXbIowa4MZAZIYLGSiRyKtuL9sXs+yMInHRPT+XHbXSJXLLn44zr/n2
         HppDP59Xbtzej/fU50ecScZMDnuAVHKTTjw79ZYu9ACC36wh7VFAtudJ4Dq8a2eivgkc
         uidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bAWEQtmf+fggjn633EQ0gBHasaIotZNQ6JNtd1TnYlY=;
        b=Je5L2TD/J/PdROAN0mLnBAS00/fBRVHtLICOOCr1H21xBXeCoWTQ2o7ob8bFKa36Dm
         /srOxKlhGoWiCo1FI1yUwcK2LltQfMVpNsfr/DNngJnA0vq04/+Ke6OVj3K6tLfw+KD5
         UNkzPaqtj6O2vp0wMZmao93OZaqB/ZHZ5Y3/RQdvYr+zdfBepcEGlQQxp5xhThbe7V3i
         dFuQglzJp+RQooEn4Yhy8JoF+7wKpyWaOkmaW2tz9C1dmRHHbke7n1CHV6sqhYFwZ3pB
         3/ksR+33oNjthxmvHtCL1iSBbNM4nWg5eMF4b3FXJTgiq/X6sUpQAlE8vOOOahIzKZCS
         AmOw==
X-Gm-Message-State: AHQUAubzl5FbQ+gnNtvSPXccpNDrpjEv1JJ4FQ/GZA8JQc/nIUNW8bWm
        US7NuthMcrEYZe081eCK1n2cdQ==
X-Google-Smtp-Source: AHgI3IY7Fh/iJB1rM3CbMbsCZao4labBAhvTuxuXpfkMpQyUIWovpYBREFulbYA+w07Ewxce5yxHLA==
X-Received: by 2002:a2e:964b:: with SMTP id z11mr12327938ljh.138.1551192871604;
        Tue, 26 Feb 2019 06:54:31 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:54:30 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
Date:   Tue, 26 Feb 2019 15:54:07 +0100
Message-Id: <20190226145415.19411-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v11:
 - This version contains only the infrastructure changes that is needed for
deployment. The PSCI/ARM changes have also been updated and tested, but I will
post them separately. Still, to provide completeness, I have published a branch
containing everything to a git tree [1], feel free to have a look and test.
 - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
which has been replaced by a couple of new patches, whom reworks the existing
tick_nohz_get_sleep_length() function, to provide the next timer expiration
instead of the duration.
 - More changelogs are available per patch.

Changes in v10:
 - Quite significant changes have been to the PSCI driver deployment. According
   to an agreement with Lorenzo, the hierarchical CPU layout for PSCI should be
   orthogonal to whether the PSCI FW supports OSI or not. This has been taken
   care of in this version.
 - Drop the generic attach/detach helpers of CPUs to genpd, instead make that
   related code internal to PSCI, for now.
 - Fix "BUG: sleeping for invalid context" for hotplug, as reported by Raju.
 - Addressed various comments from version 8 and 9.
 - Clarified changelogs and re-wrote the cover-letter to better explain the
   motivations behind these changes.

Background:

For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
From a CPU idle state perspective, this means some states may be shared among a
group of CPUs (aka CPU cluster).

To deal with idle management of a group of CPUs, sometimes the kernel needs to
be involved to manage the last-man standing algorithm, simply because it can't
rely solely on power management FWs to deal with this. Depending on the
platform, of course.

There are a couple of typical scenarios for when the kernel needs to be in
control, dealing with synchronization of when the last CPU in a cluster is about
to enter a deep idle state.

1)
The kernel needs to carry out so called last-man activities before the
CPU cluster can enter a deep idle state. This may for example involve to
configure external logics for wakeups, as the GIC may no longer be functional
once a deep cluster idle state have been entered. Likewise, these operations
may need to be restored, when the first CPU wakes up.

2)
Other more generic I/O devices, such as an MMC controller for example, may be a
part of the same power domain as the CPU cluster, due to a shared power-rail.
For these scenarios, when the MMC controller is in use dealing with an MMC
request, a deeper idle state of the CPU cluster may needs to be temporarily
disabled. This is needed to retain the MMC controller in a functional state,
else it may loose its register-context in the middle of serving a request.

In this series, we are extending the generic PM domain (aka genpd) to be used
for also CPU devices. Hence the goal is to re-use much of its current code to
help us manage the last-man standing synchronization. Moreover, as we already
use genpd to model power domains for generic I/O devices, both 1) and 2) can be
address with its help.

Moreover, to address these problems for ARM64 DT based platforms, we are
deploying support for genpd and runtime PM to the PSCI FW driver - and finally
we make some updates to two ARM64 DTBs, as to deploy the new PSCI CPU topology
layout.

The series has been tested on a Qcom 410c dragonboard and on a Hisilicon Hikey
board. The first one uses PSCI OS-initiated mode, while the second uses the PSCI
Platform-Coordinated mode.

Kind regards
Ulf Hansson

[1]
git.linaro.org/people/ulf.hansson/linux-pm.git next_v11

Daniel Lezcano (4):
  time: tick-sched: Provide helpers to get the next timer expiration
  cpuidle: menu: Convert to tick_nohz_get_next_timer|hrtimer()
  cpuidle: teo: Convert to tick_nohz_get_next_timer()
  time: tick-sched: Remove tick_nohz_get_sleep_length()

Ulf Hansson (4):
  PM / Domains: Add a generic data pointer to the genpd_power_state
    struct
  PM / Domains: Add support for CPU devices to genpd
  cpuidle: Pre-store next timer/tick before selecting an idle state
  PM / Domains: Add genpd governor for CPUs

 drivers/base/power/domain.c          | 78 ++++++++++++++++++++++++++--
 drivers/base/power/domain_governor.c | 62 +++++++++++++++++++++-
 drivers/cpuidle/cpuidle.c            |  2 +
 drivers/cpuidle/governors/menu.c     | 14 ++++-
 drivers/cpuidle/governors/teo.c      |  4 +-
 include/linux/cpuidle.h              |  2 +
 include/linux/pm_domain.h            | 20 ++++++-
 include/linux/tick.h                 | 11 ++--
 kernel/time/tick-sched.c             | 71 +++++++++++++++++--------
 9 files changed, 229 insertions(+), 35 deletions(-)

-- 
2.17.1

