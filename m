Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901102082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901102082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLCUbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:31:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:46785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeLCUbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:31:53 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MOwY7-1gXTe01chT-006M5J; Mon, 03 Dec 2018 21:31:07 +0100
Message-ID: <1543869063.12945.46.camel@gmx.us>
Subject: Re: [PATCH] clocksource/arm_arch_timer: fix a lockdep warning
From:   Qian Cai <cai@gmx.us>
To:     Waiman Long <longman@redhat.com>, mark.rutland@arm.com,
        marc.zyngier@arm.com
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2018 15:31:03 -0500
In-Reply-To: <11876b19-ec16-c7c5-4b21-c45c2b0f7244@redhat.com>
References: <1543865624-17301-1-git-send-email-cai@gmx.us>
         <11876b19-ec16-c7c5-4b21-c45c2b0f7244@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4N5VGSVCq4tq82hEqR1vijJDuvoyRunQg7ziYIgclxgvGscz3W5
 uh1lCYLYSfxFbv4KfSUcl2YNLLnBnnMUyZxOGli7RVAQ7dH4Nz6U/xRDyDiw9st/dsTYGMw
 6N5XIpB6oisRpsvVxNLpmZC218mt3YWXM6wREya5gOMQ81wKoeLyuqSEEUVO/i6YKAMGjiw
 afcuon/PLHCVDoCoKcZvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:njGd+fk9Eao=:DrkSTggsAEnLTC6IrZxusU
 319Xtqwvu1nnXboZbML63FaKveAvX3EIsZuDpbIhlW6PiwHvMsTaj9VvTRi5XvN0DEr10Oujr
 FM9qAS3sDG/hojbo6E9RDqHrIgeCjvj7kVXQT4iBb1l5Xj5u5gpXlPzrRaAjo0ng850y19oQo
 xzaZ29q1nQnD2Rab4uDtvQEOs69Q3JIgoZvR9lrrO4LHkbCMT2N95J/fSncibdGNCfwynZTgi
 /s6bXKOYwnCUodwISYQ777NFRVO1cf1mCG7OYSGxZMCtdICMjrd+OMM9HTbFgJ7RuqgTtHsXM
 doGCRsLvN1KVswgUgaEknvfCOnaiDNuBGOZH8htvVxaDFsYu5fc9tk4X6CpriAucFOcG1nfla
 zX7ZwfYw+Ky/rfvcpK8ui58USyC4up+0MDISrI26xFjH7BxCKc+VSCjqyEhFitqXWnrm1OvNK
 SGqL5Ha+ysuTeJup+yLjRXpqc9X2eOzhvxALmSr1x2CIfEsg00DOD6J1RtPnwPUsWdKU6XbJ2
 ZjwGpCbJ4y574qEMCelKMUKoZbME+UCbjqovysZGNCfW/2T66/ZYtqN+3VCe8XzyFin4Gez5o
 OZPta+iUMu6Om6EbvM6KExkQG22jgqy/AkrzGyUbQyE8iXBGCZAvGWg2BdGhN8rN96Gc4g0lS
 ZueSH+Wbq5cRy0E29ablrnv2Lkccb0GqNExJMvZEGw94cgBcWAxwhtj8nPSxLbVq3igIUm/MO
 wCRCwIqg5y45Ec2AQn1XVhY8vdKXbYiM+8Yo8LPaO9uoIoVfn/8lNpLaKXqVpDaUw/lkHqq3/
 IU9BrRK9nd/5ALL2FKbZ2Dg7vk6lnPffVDxdshPzEV5VvftrJ0IMaFSMVmmHkQq+zkjqSnXCN
 9oyUe1PcCZADHCwgh1fROfQIXAw3w8EzQx/pKlrLOKYeb4zbE5KlJ94kdnIo++
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 15:07 -0500, Waiman Long wrote:
> On 12/03/2018 02:33 PM, Qian Cai wrote:
> > Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
> > warning.
> > 
> > [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
> > [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
> > [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
> > [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
> > [    0.000000]  acpi_table_parse+0x1ac/0x218
> > [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
> > [    0.000000]  timer_probe+0x1bc/0x254
> > [    0.000000]  time_init+0x44/0x98
> > [    0.000000]  start_kernel+0x4ec/0x7d4
> > 
> > This is due to the commit cb538267ea1e ("jump_label/lockdep: Assert we hold
> > the hotplug lock for _cpuslocked() operations"). Therefore, it will check
> > if it is really in the CPU hotplug path or not, and work around this
> > problem by using cpus_read_trylock(). The chance of not getting the read
> > lock is very small. If that happens, it will report a lockdep warning at
> > most.
> > 
> > Signed-off-by: Qian Cai <cai@gmx.us>
> > ---
> >  drivers/clocksource/arm_arch_timer.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/clocksource/arm_arch_timer.c
> > b/drivers/clocksource/arm_arch_timer.c
> > index 9a7d4dc..5c9acbd 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -497,11 +497,20 @@ void arch_timer_enable_workaround(const struct
> > arch_timer_erratum_workaround *wa
> >  			per_cpu(timer_unstable_counter_workaround, i) = wa;
> >  	}
> >  
> > +#ifdef CONFIG_HOTPLUG_CPU
> 
> If HOTPLUG_CPU isn't defined, all the cpus_lock() and related functions
> are just no-op. You don't need to use conditional compilation directive
> here.

Make sense.

> 
> > +	i = 0;
> > +
> >  	/*
> >  	 * Use the locked version, as we're called from the CPU
> >  	 * hotplug framework. Otherwise, we end-up in deadlock-land.
> >  	 */
> 
> I think the main problem is the above comment may not be true anymore or
> is only occasionally true. We need to audit the code to find the root cause.

This was a commit introduced in Aug. 2017, 450f9689f294
(clocksource/arm_arch_timer: Use static_branch_enable_cpuslocked()) which
basically drop the cpus_read_lock(). May I ask what changes made you think the
above comment incorrect now?

> 
> > +	i = cpus_read_trylock();
> >  	static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
> > +	if (i)
> > +		cpus_read_unlock();
> 
> This is not the right way of fixing the lockdep splash.
> 

I should had said it is a workaround. I am all-ears for a proper way to fix
this. When the above commit 450f9689f294 was merged, there was no cb538267ea1e
so no lockdep warning.
