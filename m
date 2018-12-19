Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC53C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E082A20672
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbeLSSbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:31:55 -0500
Received: from foss.arm.com ([217.140.101.70]:41458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbeLSSbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:31:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8017980D;
        Wed, 19 Dec 2018 10:31:54 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF9013F59C;
        Wed, 19 Dec 2018 10:31:51 -0800 (PST)
Subject: Re: [PATCH 1/2] cpu/hotplug: Mute hotplug lockdep during init
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     cai@gmx.us, daniel.lezcano@linaro.org,
        linux-arm-kernel@lists.infradead.org, longman@redhat.com,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, dietmar.eggemann@arm.com
References: <1545243796-23224-1-git-send-email-valentin.schneider@arm.com>
 <1545243796-23224-2-git-send-email-valentin.schneider@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <53826f59-ced7-7163-ab6a-533f64b98471@arm.com>
Date:   Wed, 19 Dec 2018 18:31:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1545243796-23224-2-git-send-email-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 18:23, Valentin Schneider wrote:
> Since we've had:
> 
>   commit cb538267ea1e ("jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations")
> 
> we've been getting some lockdep warnings during init, such as on HiKey960:
> 
> [    0.820495] WARNING: CPU: 4 PID: 0 at kernel/cpu.c:316 lockdep_assert_cpus_held+0x3c/0x48
> [    0.820498] Modules linked in:
> [    0.820509] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S                4.20.0-rc5-00051-g4cae42a #34
> [    0.820511] Hardware name: HiKey960 (DT)
> [    0.820516] pstate: 600001c5 (nZCv dAIF -PAN -UAO)
> [    0.820520] pc : lockdep_assert_cpus_held+0x3c/0x48
> [    0.820523] lr : lockdep_assert_cpus_held+0x38/0x48
> [    0.820526] sp : ffff00000a9cbe50
> [    0.820528] x29: ffff00000a9cbe50 x28: 0000000000000000
> [    0.820533] x27: 00008000b69e5000 x26: ffff8000bff4cfe0
> [    0.820537] x25: ffff000008ba69e0 x24: 0000000000000001
> [    0.820541] x23: ffff000008fce000 x22: ffff000008ba70c8
> [    0.820545] x21: 0000000000000001 x20: 0000000000000003
> [    0.820548] x19: ffff00000a35d628 x18: ffffffffffffffff
> [    0.820552] x17: 0000000000000000 x16: 0000000000000000
> [    0.820556] x15: ffff00000958f848 x14: 455f3052464d4d34
> [    0.820559] x13: 00000000769dde98 x12: ffff8000bf3f65a8
> [    0.820564] x11: 0000000000000000 x10: ffff00000958f848
> [    0.820567] x9 : ffff000009592000 x8 : ffff00000958f848
> [    0.820571] x7 : ffff00000818ffa0 x6 : 0000000000000000
> [    0.820574] x5 : 0000000000000000 x4 : 0000000000000001
> [    0.820578] x3 : 0000000000000000 x2 : 0000000000000001
> [    0.820582] x1 : 00000000ffffffff x0 : 0000000000000000
> [    0.820587] Call trace:
> [    0.820591]  lockdep_assert_cpus_held+0x3c/0x48
> [    0.820598]  static_key_enable_cpuslocked+0x28/0xd0
> [    0.820606]  arch_timer_check_ool_workaround+0xe8/0x228
> [    0.820610]  arch_timer_starting_cpu+0xe4/0x2d8
> [    0.820615]  cpuhp_invoke_callback+0xe8/0xd08
> [    0.820619]  notify_cpu_starting+0x80/0xb8
> [    0.820625]  secondary_start_kernel+0x118/0x1d0
> 
> We've also had a similar warning in sched_init_smp() for every
> asymmetric system that would enable the sched_asym_cpucapacity static
> key, although that was singled out in:
> 
>   commit 40fa3780bac2 ("sched/core: Take the hotplug lock in sched_init_smp()")
> 
> Those warnings are actually harmless, since we cannot have hotplug
> operations at the time they appear. Instead of starting to sprinkle
> useless hotplug lock operations in the init codepaths, mute the
> warnings until they start warning about real problems.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> FYI Thomas Gleixner suggested using SYSTEM_SCHEDULING instead of
> SYSTEM_RUNNING, but that seems to still be too early - sched_init_smp()
> (and kernel_init() actually) hasn't completed yet, so we'd still get
> those warnings.
> ---
>  kernel/cpu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 91d5c38..34e40ef 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -313,6 +313,15 @@ void cpus_write_unlock(void)
>  
>  void lockdep_assert_cpus_held(void)
>  {
> +	/*
> +	 * We can't have hotplug operations before userspace starts running,
> +	 * and some init codepaths will knowingly not take the hotplug lock.
> +	 * This is all valid, so mute lockdep until it makes sense to report
> +	 * unheld locks.
> +	 */
> +	if (system_state < SYSTEM_RUNNING)
> +		return;
> +
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
>  
> --
> 2.7.4
> 

FWIW: Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for having kept an eye on it!

	M.
-- 
Jazz is not dead. It just smells funny...
