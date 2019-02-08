Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34499C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ECC2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549621336;
	bh=qJ4PHY/7CVgOXoZdtmCv/SmIjH/qESkjY41m9N8CIS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dhOfOFo2hgtoI5V9FU4HURTM66AnoVBO0SeQd6SXt3T9RZ3IqjvLyrpQbz/PlCn+j
	 uk1X22g5RGK2jFdGBfSm2ugJiThedXDDdai4ZmwsOHXeIGT6v6u0dIP3eD4T6S9B4n
	 DBTl58efObbVBk5GZbk87rRm9Yjr26LMw7nznj9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfBHKWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:22:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33918 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:22:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so5056955otk.1;
        Fri, 08 Feb 2019 02:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mguDmn6uck6DJfJs5vmLhsyZ/GNIgSL9ISKG2EY/jLo=;
        b=gDpJ1QusNMMzY7BwETlhd4dl4DVRySVr1j8DR6tI5EV6VXBdctP5TMYW6dYcIThrtr
         DrmgCMkqOFjaBqRaXGP4N0eVjfJP1/Vd3w5q1p5SoEqe6z+ScqlZxCQ2ghKatIRFN70F
         G2VENgiXC40BcoC2cimLvx9qoem+5jECg8f5VwxnyjaUI1Z24tVxuhpJI3oMztqynK+D
         Y8YlmKq8qOsWlwZwQ/162RMhHBuzHyPbkX7XjHKdGAtXVjRPZLZLAMy0Fm/si+qvQhNh
         Hq90LxL84vmORaNH3DecA6Bq/9ODfnDfuOfvu/6TE9yxZv8kNDsXWBRmHduzqb4Sehf4
         tgEA==
X-Gm-Message-State: AHQUAuYce23Ctc353wlEtWRZ/SKrpAcbE9Hy07mciH8aJI3dn+/AHsJ+
        10cfFK8gCmOSfXu8ZozjSSA9Aje+bMJ8qP8d3gs=
X-Google-Smtp-Source: AHgI3IYsArn6kVeqh4Lwhp+PVxrhTNZ+82NCdvB5A8WbYYHRYDC5CdjGQkg6ivUUQYWZWPIAJJTjVxbVPNHjEyHXo58=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr11412179otf.124.1549621332965;
 Fri, 08 Feb 2019 02:22:12 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
In-Reply-To: <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 11:22:02 +0100
Message-ID: <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 7:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-02-19, 13:22, Marek Szyprowski wrote:
> > Dear All,
> >
> > Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
> > i2c adapters") added a visible warning for an attempt to do i2c transfer
> > over a suspended i2c bus. This revealed a long standing issue in the
> > cpufreq-dt driver, which gives a following warning during system
> > suspend/resume cycle:
> >
> > --->8---
> > Enabling non-boot CPUs ...
> > CPU1 is up
> > CPU2 is up
> > CPU3 is up
> > ------------[ cut here ]------------
> > WARNING: CPU: 4 PID: 29 at drivers/i2c/i2c-core-base.c:1869 __i2c_transfer+0x6f8/0xa50
> > Modules linked in:
> > CPU: 4 PID: 29 Comm: cpuhp/4 Tainted: G        W         5.0.0-rc4-next-20190131-00024-g54b06b29cc65 #5324
> > Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > [<c01110e8>] (unwind_backtrace) from [<c010d11c>] (show_stack+0x10/0x14)
> > [<c010d11c>] (show_stack) from [<c09a2584>] (dump_stack+0x90/0xc8)
> > [<c09a2584>] (dump_stack) from [<c0120bd0>] (__warn+0xf8/0x124)
> > [<c0120bd0>] (__warn) from [<c0120c3c>] (warn_slowpath_null+0x40/0x48)
> > [<c0120c3c>] (warn_slowpath_null) from [<c065cda0>] (__i2c_transfer+0x6f8/0xa50)
> > [<c065cda0>] (__i2c_transfer) from [<c065d168>] (i2c_transfer+0x70/0xe4)
> > [<c065d168>] (i2c_transfer) from [<c053ce4c>] (regmap_i2c_read+0x48/0x64)
> > [<c053ce4c>] (regmap_i2c_read) from [<c0536f1c>] (_regmap_raw_read+0xf8/0x450)
> > [<c0536f1c>] (_regmap_raw_read) from [<c053772c>] (_regmap_bus_read+0x38/0x68)
> > [<c053772c>] (_regmap_bus_read) from [<c05365a0>] (_regmap_read+0x60/0x250)
> > [<c05365a0>] (_regmap_read) from [<c05367cc>] (regmap_read+0x3c/0x5c)
> > [<c05367cc>] (regmap_read) from [<c047cfc0>] (regulator_is_enabled_regmap+0x20/0x90)
> > [<c047cfc0>] (regulator_is_enabled_regmap) from [<c0477660>] (_regulator_is_enabled+0x34/0x40)
> > [<c0477660>] (_regulator_is_enabled) from [<c0478674>] (create_regulator+0x1a4/0x25c)
> > [<c0478674>] (create_regulator) from [<c047c818>] (_regulator_get+0xe4/0x278)
> > [<c047c818>] (_regulator_get) from [<c068f1dc>] (dev_pm_opp_set_regulators+0xa0/0x1c0)
> > [<c068f1dc>] (dev_pm_opp_set_regulators) from [<c0698cc8>] (cpufreq_init+0x98/0x2d0)
> > [<c0698cc8>] (cpufreq_init) from [<c06959e4>] (cpufreq_online+0xc8/0x71c)
> > [<c06959e4>] (cpufreq_online) from [<c06960fc>] (cpuhp_cpufreq_online+0x8/0x10)
> > [<c06960fc>] (cpuhp_cpufreq_online) from [<c01213d4>] (cpuhp_invoke_callback+0xf4/0xebc)
> > [<c01213d4>] (cpuhp_invoke_callback) from [<c0122e4c>] (cpuhp_thread_fun+0x1d8/0x320)
> > [<c0122e4c>] (cpuhp_thread_fun) from [<c0149858>] (smpboot_thread_fn+0x194/0x340)
> > [<c0149858>] (smpboot_thread_fn) from [<c014573c>] (kthread+0x124/0x160)
> > [<c014573c>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> > Exception stack(0xe897dfb0 to 0xe897dff8)
> > dfa0:                                     00000000 00000000 00000000 00000000
> > dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > irq event stamp: 3865
> > hardirqs last  enabled at (3873): [<c0186dec>] vprintk_emit+0x228/0x2a4
> > hardirqs last disabled at (3880): [<c0186cf0>] vprintk_emit+0x12c/0x2a4
> > softirqs last  enabled at (3052): [<c0102564>] __do_softirq+0x3a4/0x66c
> > softirqs last disabled at (3043): [<c0128464>] irq_exit+0x140/0x168
> > ---[ end trace db48b455d924fec2 ]---
> > CPU4 is up
> > CPU5 is up
> > CPU6 is up
> > CPU7 is up
> > --->8---
> >
> > This is a scenario that triggers the above issue:
> >
> > 1. system disables non-boot cpu's at the end of system suspend procedure,
> > 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
> > 3. early in the system resume procedure all cpus are got back to online
> >    state,
> > 4. this in turn causes cpufreq to be initialized for the newly onlined
> >    cpus,
> > 5. cpufreq-dt acquires all its resources (clocks, regulators) during
> >    ->init() callback,
> > 6. getting regulator require to check its state, what in turn requires
> >    i2c transfer,
> > 7. during system early resume stage this is not really possible.
> >
> > The issue is caused by cpufreq-dt driver not keeping its resources for
> > the whole driver lifetime and relying that they can be always acquired
> > at any system context. This problem has been observed on Samsung
> > Exynos based Odroid XU3/XU4 boards, but it happens on all boards, which
> > have separate regulators for different CPU clusters.
>
> Why don't you get similar problem during suspend? I think you can get
> it when the CPUs are offlined as I2C would have gone by then. The
> cpufreq or OPP core can try and run some regulator or genpd or clk
> calls to disable resources, etc. Even if doesn't happen, it certainly
> can.
>
> Also at resume the cpufreq core may try to change the frequency right
> from ->init() on certain cases, though not everytime and so the
> problem can come despite of this series.
>
> We guarantee that the resources are available during probe but not
> during resume, that's where the problem is.
>
> @Rafael any suggestions on how to fix this ?

There are cpufreq driver suspend and resume callbacks, maybe use them?

The driver could do the I2C transactions in its suspend/resume
callbacks and do nothing in online/offline if those are part of
system-wide suspend/resume.
