Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DC9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530AA21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 19:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHC0cawg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfB0T6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 14:58:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44929 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfB0T6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 14:58:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id q128so14968906ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 11:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=E+SW/FzCToYtA2IYYZgzpn69wj9GD9/vb8yka3Fu1rA=;
        b=LHC0cawgZgGXdf0YwSx8zusmDieSvGvjJwI0LerpUVk2TeKuKHJTcjUKtj1ZU+5Ipo
         6wR4tj0qNZjDUCWLWBz3YuJdEtRJId1t7BdanHHP4nCrhs3DzaNFaHDIrERH2plbsJua
         UUbnZLpz0W/2lwkOsZe9OmNqtwtH42Exqse/6vtQWMp8EmiF0h3Sk60mhNTdb8/2ttKZ
         P5EoJ/DeNTxAvMukjoPiQmeZ+sTeHBjW4kSwJmrGX1Inuoy9ix30bHfvT6Dpl9ne/xBO
         wbDfpVSq2uQxzjlP0a3u403cf75UwjzbOvmQZ3k8ZZfw/jJbQYdq8jE5Syw3H4MXwYUk
         7OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E+SW/FzCToYtA2IYYZgzpn69wj9GD9/vb8yka3Fu1rA=;
        b=aLquJixoj/n90/F8Q9xZmfOpLoj5jHbW/ag5mCfX6bErc9iDBWrhI7OjLYPB5fi6GZ
         tkxDPVi/+DUAcFdUGTR58Z/R/uuddVaXbPQbRsxw2uglF0LGcD50HSN5ipWV9zClnN6u
         x9NM5hprJDtYBIbiNdOYHI/+iLbfKiwZUxMWlCZsG1vGxPZokT5qt15DwmgES9//N0d8
         wl99pWW5hbIq6XXt1JwsSIMjGQHF7z9X92BQaPHiXHJJWHHsAmWY0u4IznDoOR27fhDd
         7vvtwP1C4ZPi/BFkogG0qC29LNteIL8Yd3LLprJ0ZcvfoplEE0wAEiSQ65Uwk01XuZE1
         thhA==
X-Gm-Message-State: AHQUAub2Caxi/C9i02cO4z6/IHIa+7QG0IdLdwt9E8dL6RQFjvMXTnqJ
        eYutNILDSanONgGs0T83SYp+yg==
X-Google-Smtp-Source: APXvYqw53mdCCWDHLmI+zZBzRlW+bF8UGhtaXLrep4fwgKErZhI4r8naM3JxZjlYs+G1aEny6inl7g==
X-Received: by 2002:a2e:21d1:: with SMTP id h78mr2213515lji.49.1551297520660;
        Wed, 27 Feb 2019 11:58:40 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z128sm723802lfa.60.2019.02.27.11.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 11:58:39 -0800 (PST)
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
Subject: [PATCH v12 0/4] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
Date:   Wed, 27 Feb 2019 20:58:32 +0100
Message-Id: <20190227195836.24739-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v12:
 - Drop the patches for restructuring tick_nohz_get_sleep_length(). Instead
replace them all with a new timer/cpuidle patch, according to suggestions by
Rafael.
 - The entire v12 series, including the PSCI/ARM changes are available in a
git branch [2].

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
[2]
git.linaro.org/people/ulf.hansson/linux-pm.git next_v12

Ulf Hansson (4):
  PM / Domains: Add a generic data pointer to the genpd_power_state
    struct
  PM / Domains: Add support for CPU devices to genpd
  cpuidle: Export the next timer/tick expiration for a CPU
  PM / Domains: Add genpd governor for CPUs

 drivers/base/power/domain.c          | 78 ++++++++++++++++++++++++++--
 drivers/base/power/domain_governor.c | 62 +++++++++++++++++++++-
 drivers/cpuidle/cpuidle.c            |  8 +++
 include/linux/cpuidle.h              |  1 +
 include/linux/pm_domain.h            | 20 ++++++-
 include/linux/tick.h                 |  7 ++-
 kernel/time/tick-sched.c             | 12 +++++
 7 files changed, 182 insertions(+), 6 deletions(-)

-- 
2.17.1

