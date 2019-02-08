Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35747C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E458F21920
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxZOoxok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfBHGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:50:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36660 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfBHGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:50:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id d22so1199224pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 22:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DXi7cmQpbkJm7Urt2XZW13CFin6Hl8J420rDWz1HC7I=;
        b=IxZOoxok2xFjLoO5q9EW6o0Vy5kwRtvhRNWph2fQ9VEjw9dLO7S7BM8wu9jBAJ1D+T
         dPwefY7eR+N/neeOdlNgK1OWgXr7O5PQ0wrVpoh8XwK1p7kTgVSRuNVCfZG29SwvniyF
         GKnw68X7oS9C8FWhk3ziIqMHGyI44lkIL2R5C+UFaYQZ4LYxNDn4WISUCz13rDi/mOZG
         AOrNNBJPtuEfvz8Q/nFOEr/EfB8/y1LUos5Nadj1sMP7H4CXFOUKu6PnOW8x/Lh+ZSgQ
         5KO8WLeQCN45jGWBnKeLVsQumUwIddrboH5NZADTRwR6Mcx3JxSHFXKOq3+S0ISX9wnS
         UlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXi7cmQpbkJm7Urt2XZW13CFin6Hl8J420rDWz1HC7I=;
        b=tM79lhJenPb5PtXevD9ek7oOQrBsbHR5GUCr/g/yYxvZa8f2bwLSTk/U8HtPE8KCOQ
         I27PbLUR9KEmualRStI3heHcSCXj0fzwnHLpK37KVSV+YpGRlDLahVEeH1gfTtiH4bP/
         ZQrisuLCBhH+Lq0NnX19HkA9DXT1Sj4Z+wvBduy1KN2J/70O+oGLwKqpEMrX30QR3o17
         HDdL44r1kZSzpRBMkak/27PhOq/p4xAa+MeHDTMIA6zZlC4A5HKY34j+TjRYng3TmFs7
         5EZMywxUxkmQB9I3wmL8U3n2QT4i2tpXnHTisJrTCqoB71SVjnR0ISk5M3g6YuCxxDEL
         WXKA==
X-Gm-Message-State: AHQUAuZB4v0ThV2jrcUgI64Sx2rjEljHW35RH00gedwn8YGGNi2rVRax
        TRKycoQ2fYJTyy8rkwLp3LhCNm3spXk=
X-Google-Smtp-Source: AHgI3IZpUnkSHgSHRbJlxclJyK2L9JOL5MUgJq1fCGUWs5d4mXcU/dcyQY9DnyVuRggxVjF/QIZKsg==
X-Received: by 2002:aa7:8042:: with SMTP id y2mr7539487pfm.39.1549608600969;
        Thu, 07 Feb 2019 22:50:00 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f13sm1091056pgq.82.2019.02.07.22.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 22:49:59 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:19:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207122227.19873-1-m.szyprowski@samsung.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-19, 13:22, Marek Szyprowski wrote:
> Dear All,
> 
> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
> i2c adapters") added a visible warning for an attempt to do i2c transfer
> over a suspended i2c bus. This revealed a long standing issue in the
> cpufreq-dt driver, which gives a following warning during system
> suspend/resume cycle:
> 
> --->8---
> Enabling non-boot CPUs ...
> CPU1 is up
> CPU2 is up
> CPU3 is up
> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 29 at drivers/i2c/i2c-core-base.c:1869 __i2c_transfer+0x6f8/0xa50
> Modules linked in:
> CPU: 4 PID: 29 Comm: cpuhp/4 Tainted: G        W         5.0.0-rc4-next-20190131-00024-g54b06b29cc65 #5324
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c01110e8>] (unwind_backtrace) from [<c010d11c>] (show_stack+0x10/0x14)
> [<c010d11c>] (show_stack) from [<c09a2584>] (dump_stack+0x90/0xc8)
> [<c09a2584>] (dump_stack) from [<c0120bd0>] (__warn+0xf8/0x124)
> [<c0120bd0>] (__warn) from [<c0120c3c>] (warn_slowpath_null+0x40/0x48)
> [<c0120c3c>] (warn_slowpath_null) from [<c065cda0>] (__i2c_transfer+0x6f8/0xa50)
> [<c065cda0>] (__i2c_transfer) from [<c065d168>] (i2c_transfer+0x70/0xe4)
> [<c065d168>] (i2c_transfer) from [<c053ce4c>] (regmap_i2c_read+0x48/0x64)
> [<c053ce4c>] (regmap_i2c_read) from [<c0536f1c>] (_regmap_raw_read+0xf8/0x450)
> [<c0536f1c>] (_regmap_raw_read) from [<c053772c>] (_regmap_bus_read+0x38/0x68)
> [<c053772c>] (_regmap_bus_read) from [<c05365a0>] (_regmap_read+0x60/0x250)
> [<c05365a0>] (_regmap_read) from [<c05367cc>] (regmap_read+0x3c/0x5c)
> [<c05367cc>] (regmap_read) from [<c047cfc0>] (regulator_is_enabled_regmap+0x20/0x90)
> [<c047cfc0>] (regulator_is_enabled_regmap) from [<c0477660>] (_regulator_is_enabled+0x34/0x40)
> [<c0477660>] (_regulator_is_enabled) from [<c0478674>] (create_regulator+0x1a4/0x25c)
> [<c0478674>] (create_regulator) from [<c047c818>] (_regulator_get+0xe4/0x278)
> [<c047c818>] (_regulator_get) from [<c068f1dc>] (dev_pm_opp_set_regulators+0xa0/0x1c0)
> [<c068f1dc>] (dev_pm_opp_set_regulators) from [<c0698cc8>] (cpufreq_init+0x98/0x2d0)
> [<c0698cc8>] (cpufreq_init) from [<c06959e4>] (cpufreq_online+0xc8/0x71c)
> [<c06959e4>] (cpufreq_online) from [<c06960fc>] (cpuhp_cpufreq_online+0x8/0x10)
> [<c06960fc>] (cpuhp_cpufreq_online) from [<c01213d4>] (cpuhp_invoke_callback+0xf4/0xebc)
> [<c01213d4>] (cpuhp_invoke_callback) from [<c0122e4c>] (cpuhp_thread_fun+0x1d8/0x320)
> [<c0122e4c>] (cpuhp_thread_fun) from [<c0149858>] (smpboot_thread_fn+0x194/0x340)
> [<c0149858>] (smpboot_thread_fn) from [<c014573c>] (kthread+0x124/0x160)
> [<c014573c>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> Exception stack(0xe897dfb0 to 0xe897dff8)
> dfa0:                                     00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> irq event stamp: 3865
> hardirqs last  enabled at (3873): [<c0186dec>] vprintk_emit+0x228/0x2a4
> hardirqs last disabled at (3880): [<c0186cf0>] vprintk_emit+0x12c/0x2a4
> softirqs last  enabled at (3052): [<c0102564>] __do_softirq+0x3a4/0x66c
> softirqs last disabled at (3043): [<c0128464>] irq_exit+0x140/0x168
> ---[ end trace db48b455d924fec2 ]---
> CPU4 is up
> CPU5 is up
> CPU6 is up
> CPU7 is up
> --->8---
> 
> This is a scenario that triggers the above issue:
> 
> 1. system disables non-boot cpu's at the end of system suspend procedure,
> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
> 3. early in the system resume procedure all cpus are got back to online
>    state,
> 4. this in turn causes cpufreq to be initialized for the newly onlined
>    cpus,
> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
>    ->init() callback,
> 6. getting regulator require to check its state, what in turn requires
>    i2c transfer,
> 7. during system early resume stage this is not really possible.
> 
> The issue is caused by cpufreq-dt driver not keeping its resources for
> the whole driver lifetime and relying that they can be always acquired
> at any system context. This problem has been observed on Samsung
> Exynos based Odroid XU3/XU4 boards, but it happens on all boards, which
> have separate regulators for different CPU clusters.

Why don't you get similar problem during suspend? I think you can get
it when the CPUs are offlined as I2C would have gone by then. The
cpufreq or OPP core can try and run some regulator or genpd or clk
calls to disable resources, etc. Even if doesn't happen, it certainly
can.

Also at resume the cpufreq core may try to change the frequency right
from ->init() on certain cases, though not everytime and so the
problem can come despite of this series.

We guarantee that the resources are available during probe but not
during resume, that's where the problem is.

@Rafael any suggestions on how to fix this ?

-- 
viresh
