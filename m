Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B19C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8B02145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Um3uzXAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbeLQQNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:13:32 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44643 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbeLQQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:13:32 -0500
Received: by mail-ua1-f66.google.com with SMTP id d19so4593582uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXj/S8jn9EbQCTF9ZXQIFIcY5evPBx6YH9ZSkeNymvA=;
        b=Um3uzXAlufAqD3o2lWYfL3iE4hCRP/9B2XDx73CFT4/msEbQNL84W0rQm0V2fyCG5C
         ZdOz5aumG/1QalLPuDeluymOeg7PSnCwbtTkGKfaEn1n6el/t/zBj3EyhEwNpuv0iwao
         o7Yq4c1LHOkFMWGdtOPy6YvES4iod1TAN6bqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXj/S8jn9EbQCTF9ZXQIFIcY5evPBx6YH9ZSkeNymvA=;
        b=oTMpK7oVenvdrMIXaM4CpzJRDGJAN8bB2MRiAeL1woas09cJwCxuYSDYjF3waNTDBU
         aPCIssIz1n0vGgF8xF/zeiZZXP/pwmor6KndTEYo5QudqgOxZuIEE97hwl3j28Frn34o
         oBP8267EOc0G5CYhvLlA24wdxRhUIWIOoslvMnrSOL2KB5eukIZlsDGJLrCTv7sy8VeX
         SLyyEVLrcsCnTRYG8yOgY5DAL4gcpRZThINKHKvGWhX21oaZ6gyj8DBviyRBdPhtYS9Z
         E1WqNivVO4nrnCabN3DGlbYVcX2Lvq8tQD3vnGOe3l7+mHw55f/hQDLGxaXFcVsgmNlw
         zZ4Q==
X-Gm-Message-State: AA+aEWZA4vk1ItnOKa0VFS49Di731wqFIlcXCfP6NhjG0TpMufOq9Wtl
        BoYAAaVjGKin1m2kll7eIXn2msHcXbqI0T0C6fZ33A==
X-Google-Smtp-Source: AFSGD/VGIDeUoSBySNRVknwIydoPn2g7IFPkc2jHKMLJHKRGTgKcGUjUgYv7mEaz/vk6HhmwrC/rjLH8DaOKRO8UYWE=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr2106868uar.39.1545063210141;
 Mon, 17 Dec 2018 08:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Dec 2018 17:12:54 +0100
Message-ID: <CAPDyKFpV0uQhZnJhSg79RxmCq+0PFUeaXCgmBgRU5aNF8WNoDw@mail.gmail.com>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael, Sudeep, Lorenzo, Mark,

On Thu, 29 Nov 2018 at 18:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Over the years this series have been iterated and discussed at various Linux
> conferences and LKML. In this new v10, a quite significant amount of changes
> have been made to address comments from v8 and v9. A summary is available
> below, although let's start with a brand new clarification of the motivation
> behind this series.
>
> For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
> From a CPU idle state perspective, this means some states may be shared among a
> group of CPUs (aka CPU cluster).
>
> To deal with idle management of a group of CPUs, sometimes the kernel needs to
> be involved to manage the last-man standing algorithm, simply because it can't
> rely solely on power management FWs to deal with this. Depending on the
> platform, of course.
>
> There are a couple of typical scenarios for when the kernel needs to be in
> control, dealing with synchronization of when the last CPU in a cluster is about
> to enter a deep idle state.
>
> 1)
> The kernel needs to carry out so called last-man activities before the
> CPU cluster can enter a deep idle state. This may for example involve to
> configure external logics for wakeups, as the GIC may no longer be functional
> once a deep cluster idle state have been entered. Likewise, these operations
> may need to be restored, when the first CPU wakes up.
>
> 2)
> Other more generic I/O devices, such as an MMC controller for example, may be a
> part of the same power domain as the CPU cluster, due to a shared power-rail.
> For these scenarios, when the MMC controller is in use dealing with an MMC
> request, a deeper idle state of the CPU cluster may needs to be temporarily
> disabled. This is needed to retain the MMC controller in a functional state,
> else it may loose its register-context in the middle of serving a request.
>
> In this series, we are extending the generic PM domain (aka genpd) to be used
> for also CPU devices. Hence the goal is to re-use much of its current code to
> help us manage the last-man standing synchronization. Moreover, as we already
> use genpd to model power domains for generic I/O devices, both 1) and 2) can be
> address with its help.
>
> Moreover, to address these problems for ARM64 DT based platforms, we are
> deploying support for genpd and runtime PM to the PSCI FW driver - and finally
> we make some updates to two ARM64 DTBs, as to deploy the new PSCI CPU topology
> layout.
>
> The series has been tested on the QCOM 410c dragonboard and the Hisilicon Hikey
> board. You may also find the code at:
>
> git.linaro.org/people/ulf.hansson/linux-pm.git next

It's soon been three weeks since I posted this and I would really
appreciate some feedback.

Rafael, I need your feedback on patch 1->4.

Mark, Sudeep, Lorenzo, please have a look at the PSCI related changes.

When it comes to the the cpuidle related changes, I have pinged Daniel
offlist - and he is preparing some responses.

Kind regards
Uffe


>
> Kind regards
> Ulf Hansson
>
>
> Changes in v10:
>  - Quite significant changes have been to the PSCI driver deployment. According
>    to an agreement with Lorenzo, the hierarchical CPU layout for PSCI should be
>    orthogonal to whether the PSCI FW supports OSI or not. This has been taken
>    care of in this version.
>  - Drop the generic attach/detach helpers of CPUs to genpd, instead make that
>    related code internal to PSCI, for now.
>  - Fix "BUG: sleeping for invalid context" for hotplug, as reported by Raju.
>  - Addressed various comments from version 8 and 9.
>  - Clarified changelogs and re-wrote the cover-letter to better explain the
>    motivations behind these changes.
>
> Changes in v9:
>  - Collect only a subset from the changes in v8.
>  - Patch 3 is new, documenting existing genpd flags. Future wise, this means
> when a new genpd flag is invented, we must also properly document it.
>  - No changes have been made to the patches picked from v8.
>  - Dropped the text from v8 cover-letter[1], to avoid confusion. When posting v10
> (or whatever the next version containing the rest becomes), I am going re-write
> the cover-letter to clarify, more exactly, the problems this series intends to
> solve. The earlier text was simply too vague.
>
> [1]
> https://lwn.net/Articles/758091/
>
> Changes in v8:
>  - Added some tags for reviews and acks.
>  - Cleanup timer patch (patch6) according to comments from Rafael.
>  - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
>  - While adopting patch 5 to new genpd changes, I took the opportunity to
>    improve the new function description a bit.
>  - Corrected malformed SPDX-License-Identifier in patch20.
>
> Changes in v7:
>  - Addressed comments concerning the PSCI changes from Mark Rutland, which moves
>    the psci firmware driver to a new firmware subdir and change to force PSCI PC
>    mode during boot to cope with kexec'ed booted kernels.
>  - Added some maintainers in cc for the timer/nohz patches.
>  - Minor update to the new genpd governor, taking into account the state's
>    poweroff latency while validating the sleep duration time.
>  - Addressed a problem pointed out by Geert Uytterhoeven, around calling
>    pm_runtime_get|put() for CPUs that has not been attached to a CPU PM domain.
>  - Re-based on Linus' latest master.
>
>
> Lina Iyer (5):
>   timer: Export next wakeup time of a CPU
>   dt: psci: Update DT bindings to support hierarchical PSCI states
>   cpuidle: dt: Support hierarchical CPU idle states
>   drivers: firmware: psci: Support hierarchical CPU idle states
>   arm64: dts: Convert to the hierarchical CPU topology layout for
>     MSM8916
>
> Ulf Hansson (22):
>   PM / Domains: Add generic data pointer to genpd_power_state struct
>   PM / Domains: Add support for CPU devices to genpd
>   PM / Domains: Add genpd governor for CPUs
>   of: base: Add of_get_cpu_state_node() to get idle states for a CPU
>     node
>   ARM/ARM64: cpuidle: Let back-end init ops take the driver as input
>   drivers: firmware: psci: Move psci to separate directory
>   MAINTAINERS: Update files for PSCI
>   drivers: firmware: psci: Split psci_dt_cpu_init_idle()
>   drivers: firmware: psci: Simplify state node parsing
>   drivers: firmware: psci: Simplify error path of psci_dt_init()
>   drivers: firmware: psci: Announce support for OS initiated suspend
>     mode
>   drivers: firmware: psci: Prepare to use OS initiated suspend mode
>   drivers: firmware: psci: Prepare to support PM domains
>   drivers: firmware: psci: Add support for PM domains using genpd
>   drivers: firmware: psci: Add hierarchical domain idle states converter
>   drivers: firmware: psci: Introduce psci_dt_topology_init()
>   drivers: firmware: psci: Add a helper to attach a CPU to its PM domain
>   drivers: firmware: psci: Attach the CPU's device to its PM domain
>   drivers: firmware: psci: Manage runtime PM in the idle path for CPUs
>   drivers: firmware: psci: Support CPU hotplug for the hierarchical
>     model
>   arm64: kernel: Respect the hierarchical CPU topology in DT for PSCI
>   arm64: dts: hikey: Convert to the hierarchical CPU topology layout
>
>  .../devicetree/bindings/arm/psci.txt          | 166 ++++++++
>  MAINTAINERS                                   |   2 +-
>  arch/arm/include/asm/cpuidle.h                |   4 +-
>  arch/arm/kernel/cpuidle.c                     |   5 +-
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |  87 +++-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 ++-
>  arch/arm64/include/asm/cpu_ops.h              |   4 +-
>  arch/arm64/include/asm/cpuidle.h              |   6 +-
>  arch/arm64/kernel/cpuidle.c                   |   6 +-
>  arch/arm64/kernel/setup.c                     |   3 +
>  drivers/base/power/domain.c                   |  74 +++-
>  drivers/base/power/domain_governor.c          |  61 ++-
>  drivers/cpuidle/cpuidle-arm.c                 |   2 +-
>  drivers/cpuidle/dt_idle_states.c              |   5 +-
>  drivers/firmware/Kconfig                      |  15 +-
>  drivers/firmware/Makefile                     |   3 +-
>  drivers/firmware/psci/Kconfig                 |  13 +
>  drivers/firmware/psci/Makefile                |   4 +
>  drivers/firmware/{ => psci}/psci.c            | 240 ++++++++---
>  drivers/firmware/psci/psci.h                  |  23 ++
>  drivers/firmware/{ => psci}/psci_checker.c    |   0
>  drivers/firmware/psci/psci_pm_domain.c        | 389 ++++++++++++++++++
>  drivers/of/base.c                             |  35 ++
>  drivers/soc/qcom/spm.c                        |   3 +-
>  include/linux/of.h                            |   8 +
>  include/linux/pm_domain.h                     |  19 +-
>  include/linux/psci.h                          |   6 +-
>  include/linux/tick.h                          |   8 +
>  include/uapi/linux/psci.h                     |   5 +
>  kernel/time/tick-sched.c                      |  13 +
>  30 files changed, 1163 insertions(+), 103 deletions(-)
>  create mode 100644 drivers/firmware/psci/Kconfig
>  create mode 100644 drivers/firmware/psci/Makefile
>  rename drivers/firmware/{ => psci}/psci.c (76%)
>  create mode 100644 drivers/firmware/psci/psci.h
>  rename drivers/firmware/{ => psci}/psci_checker.c (100%)
>  create mode 100644 drivers/firmware/psci/psci_pm_domain.c
>
> --
> 2.17.1
>
