Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D52C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3907721473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/IpXCuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3907721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeK3TeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:34:23 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40196 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3TeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:34:23 -0500
Received: by mail-vk1-f196.google.com with SMTP id v70so1077994vkv.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3uxj9iZi/USQbkdTCWskiKtgALyD97A5fCmaqFF7Cg=;
        b=K/IpXCuKMHUyWTDf7tgS6qbX+XcAjcbts0O/E9SvYgICnoz89F+uzx7ZCPUCjcTUBS
         5sokWSZ1MAzC8LIrCYV+gX/aIVtcM/hB9pqcfEo8j7tuseZJhY28/VHx+twbV8B3NAT1
         /ZluJeee0LWGhQUq6TQGZ99qRV5M0KEFCnKVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3uxj9iZi/USQbkdTCWskiKtgALyD97A5fCmaqFF7Cg=;
        b=rNxj2eB6XTRJDBzICvOyQBPQ1yxOodNflI6BA6UkEZGM8m3gMaDgiSwdrnCYYg5lxc
         8fxFHW8bwieJ5VHeBhK5IHPYe8CnhdigWpPAahUEodB8RQYfOQ/4YOniFnUZAG00CGLx
         qwjrhe28/bcC8IlgoksQZysHtiZMm6feQw8bGFE9jQc/o5/Ey6W1l8MDlQrocU9oKwtg
         kX6TXKvEswWyMt4HR6zozO4nw+4cfMWW8/RbmG5uohsXWGhJSILhAaU0CewNLkkRWHHF
         GL75+YLLb/eMioRv5WmbeR8vSB4D6rbjq5e4boNHCXRL5VR9feNjF4aWDCSFpFyMilMD
         68BA==
X-Gm-Message-State: AA+aEWaVYz6PEXkDMepvhVmsHWGs7yACEuIuMgPl/0Ta/SyheSRMTMQD
        k88rKaq9LUSRVn79MDDq49AXK9bJuKzJauNUDVEGt2+er7k=
X-Google-Smtp-Source: AFSGD/UDnH4gRs0sAwcA86F9PGDME71OqD4aheXV8RtTgZOPj7wcbaBA30xYzSyeNm10a5zsCFogZDUPRMIIzXMDFu0=
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr2041600vkc.52.1543566350666;
 Fri, 30 Nov 2018 00:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-25-ulf.hansson@linaro.org> <20181129223130.GH18262@codeaurora.org>
In-Reply-To: <20181129223130.GH18262@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Nov 2018 09:25:14 +0100
Message-ID: <CAPDyKFqUoYXUrj9N7f0DKxeL-BikwqKRWAB9FCX2PznkgiumcA@mail.gmail.com>
Subject: Re: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug
 for the hierarchical model
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 23:31, Lina Iyer <ilina@codeaurora.org> wrote:
>
> Hi Ulf,
>
> On Thu, Nov 29 2018 at 10:50 -0700, Ulf Hansson wrote:
> >When the hierarchical CPU topology is used and when a CPU has been put
> >offline (hotplug), that same CPU prevents its PM domain and thus also
> >potential master PM domains, from being powered off. This is because genpd
> >observes the CPU's struct device to remain being active from a runtime PM
> >point of view.
> >
> >To deal with this, let's decrease the runtime PM usage count by calling
> >pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
> >offline. Consequentially, we must then increase the runtime PM usage for
> >the CPU, while putting it online again.
> >
> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >---
> >
> >Changes in v10:
> >       - Make it work when the hierarchical CPU topology is used, which may be
> >         used both for OSI and PC mode.
> >       - Rework the code to prevent "BUG: sleeping function called from
> >         invalid context".
> >---
> > drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
> > 1 file changed, 20 insertions(+)
> >
> >diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> >index b03bccce0a5d..f62c4963eb62 100644
> >--- a/drivers/firmware/psci/psci.c
> >+++ b/drivers/firmware/psci/psci.c
> >@@ -15,6 +15,7 @@
> >
> > #include <linux/acpi.h>
> > #include <linux/arm-smccc.h>
> >+#include <linux/cpu.h>
> > #include <linux/cpuidle.h>
> > #include <linux/errno.h>
> > #include <linux/linkage.h>
> >@@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
> >
> > static int psci_cpu_off(u32 state)
> > {
> >+      struct device *dev;
> >       int err;
> >       u32 fn;
> >
> >+      /*
> >+       * When the hierarchical CPU topology is used, decrease the runtime PM
> >+       * usage count for the current CPU, as to allow other parts in the
> >+       * topology to enter low power states.
> >+       */
> >+      if (psci_dt_topology) {
> >+              dev = get_cpu_device(smp_processor_id());
> >+              pm_runtime_put_sync_suspend(dev);
> >+      }
> >+
> >       fn = psci_function_id[PSCI_FN_CPU_OFF];
> >       err = invoke_psci_fn(fn, state, 0, 0);
> >       return psci_to_linux_errno(err);
> >@@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
> >
> > static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> > {
> >+      struct device *dev;
> >       int err;
> >       u32 fn;
> >
> >@@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> >       err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> >       /* Clear the domain state to start fresh. */
> >       psci_set_domain_state(0);
> >+
> >+      /* Increase runtime PM usage count if the hierarchical CPU toplogy. */
> >+      if (!err && psci_dt_topology) {
> >+              dev = get_cpu_device(cpuid);
> >+              pm_runtime_get_sync(dev);
>
> I booted with a single CPU on my SDM845 device and when I tried to
> online CPU1 and I see a crash.

Thanks for testing!

If I understand correctly, that means that you haven't registered CPU1
using register_cpu(), hence there are no struct device created for it.
It sound like a special case, but on the other hand we shouldn't
crash, or course.

I guess a simple check like this would help.

if (dev)
    pm_runtime_get_sync(dev);

...and then we need a similar check in psci_cpu_off() to deal with
putting the CPU offline.

Could you try this and see if it helps?

>
> # echo 1 > /sys/devices/system/cpu/cpu1/online
>
> [   86.339204] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000188
> [   86.340195] Detected VIPT I-cache on CPU1
> [   86.348075] Mem abort info:
> [   86.348092] GICv3: CPU1: found redistributor 100 region 0:0x0000000017a80000
> [   86.352125]   ESR = 0x96000006
> [   86.352194] CPU1: Booted secondary processor 0x0000000100 [0x517f803c]
> [   86.354956]   Exception class = DABT (current EL), IL = 32 bits
> [   86.377700]   SET = 0, FnV = 0
> [   86.380788]   EA = 0, S1PTW = 0
> [   86.383967] Data abort info:
> [   86.386882]   ISV = 0, ISS = 0x00000006
> [   86.390760]   CM = 0, WnR = 0
> [   86.393755] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> [   86.400430] [0000000000000188] pgd=00000001f5233003, pud=00000001f5234003, pmd=0000000000000000
> [   86.409203] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [   86.414824] Modules linked in:
> [   86.417915] CPU: 0 PID: 1533 Comm: sh Not tainted 4.20.0-rc3-30359-gff2e21952bd5 #782
> [   86.425807] Hardware name: Qualcomm Technologies, Inc. SDM845 MTP (DT)
> [   86.432387] pstate: 80400005 (Nzcv daif +PAN -UAO)
> [   86.437233] pc : __pm_runtime_resume+0x20/0x74
> [   86.441720] lr : psci_cpu_on+0x84/0x90
> [   86.445498] sp : ffff00000db43a10
> [   86.448842] x29: ffff00000db43a10 x28: ffff80017562b500
> [   86.454200] x27: ffff000009159000 x26: 0000000000000055
> [   86.459556] x25: 0000000000000000 x24: ffff0000092c4bc8
> [   86.464913] x23: ffff000008fb8000 x22: ffff00000916a000
> [   86.470269] x21: 0000000000000100 x20: ffff000009314190
> [   86.475625] x19: 0000000000000000 x18: 0000000000000000
> [   86.480979] x17: 0000000000000000 x16: 0000000000000000
> [   86.486334] x15: 0000000000000000 x14: ffff000009162600
> [   86.491690] x13: 0000000000000300 x12: 0000000000000010
> [   86.497047] x11: ffffffffffffffff x10: ffffffffffffffff
> [   86.502399] x9 : 0000000000000001 x8 : 0000000000000000
> [   86.507753] x7 : 0000000000000000 x6 : 0000000000000000
> [   86.513108] x5 : 0000000000000000 x4 : 0000000000000000
> [   86.518463] x3 : 0000000000000188 x2 : 0000800174385000
> [   86.523820] x1 : 0000000000000004 x0 : 0000000000000000
> [   86.529175] Process sh (pid: 1533, stack limit = 0x(____ptrval____))
> [   86.535585] Call trace:
> [   86.538063]  __pm_runtime_resume+0x20/0x74
> [   86.542197]  psci_cpu_on+0x84/0x90
> [   86.545639]  cpu_psci_cpu_boot+0x3c/0x6c
> [   86.549593]  __cpu_up+0x68/0x210
> [   86.552852]  bringup_cpu+0x30/0xe0
> [   86.556293]  cpuhp_invoke_callback+0x84/0x1e0
> [   86.560689]  _cpu_up+0xe0/0x1d0
> [   86.563862]  do_cpu_up+0x90/0xb0
> [   86.567118]  cpu_up+0x10/0x18
> [   86.570113]  cpu_subsys_online+0x44/0x98
> [   86.574079]  device_online+0x68/0xac
> [   86.577685]  online_store+0xa8/0xb4
> [   86.581202]  dev_attr_store+0x18/0x28
> [   86.584908]  sysfs_kf_write+0x40/0x48
> [   86.588606]  kernfs_fop_write+0xcc/0x1cc
> [   86.592563]  __vfs_write+0x40/0x16c
> [   86.596078]  vfs_write+0xa8/0x1a0
> [   86.599424]  ksys_write+0x58/0xbc
> [   86.602768]  __arm64_sys_write+0x18/0x20
> [   86.606733]  el0_svc_common+0x94/0xf0
> [   86.610433]  el0_svc_handler+0x24/0x80
> [   86.614215]  el0_svc+0x8/0x7c0
> [   86.617300] Code: aa0003f3 361000e1 91062263 f9800071 (885f7c60)
> [   86.623447] ---[ end trace 4573c3c0e0761290 ]---
>
> >+      }
> >+
> >       return psci_to_linux_errno(err);
> > }
> >
> >--
> >2.17.1
> >
>
> Thanks,
> Lina
