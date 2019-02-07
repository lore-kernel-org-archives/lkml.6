Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C310C2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfBGGcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:32:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:35808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfBGGcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:32:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B289AED8;
        Thu,  7 Feb 2019 06:32:05 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] x86/xen: dont add memory above max allowed
 allocation
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-mm@kvack.org
Cc:     sstabellini@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
References: <20190130082233.23840-1-jgross@suse.com>
 <20190130082233.23840-3-jgross@suse.com>
 <8d4f7604-cc47-9cd7-2cca-b00b3667d2fa@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dc681ef2-8437-8614-87ef-72762eff81ce@suse.com>
Date:   Thu, 7 Feb 2019 07:32:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <8d4f7604-cc47-9cd7-2cca-b00b3667d2fa@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2019 19:46, Boris Ostrovsky wrote:
> On 1/30/19 3:22 AM, Juergen Gross wrote:
>> Don't allow memory to be added above the allowed maximum allocation
>> limit set by Xen.
>>
>> Trying to do so would result in cases like the following:
>>
>> [  584.559652] ------------[ cut here ]------------
>> [  584.564897] WARNING: CPU: 2 PID: 1 at ../arch/x86/xen/multicalls.c:129 xen_alloc_pte+0x1c7/0x390()
>> [  584.575151] Modules linked in:
>> [  584.578643] Supported: Yes
>> [  584.581750] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.4.120-92.70-default #1
>> [  584.590000] Hardware name: Cisco Systems Inc UCSC-C460-M4/UCSC-C460-M4, BIOS C460M4.4.0.1b.0.0629181419 06/29/2018
>> [  584.601862]  0000000000000000 ffffffff813175a0 0000000000000000 ffffffff8184777c
>> [  584.610200]  ffffffff8107f4e1 ffff880487eb7000 ffff8801862b79c0 ffff88048608d290
>> [  584.618537]  0000000000487eb7 ffffea0000000201 ffffffff81009de7 ffffffff81068561
>> [  584.626876] Call Trace:
>> [  584.629699]  [<ffffffff81019ad9>] dump_trace+0x59/0x340
>> [  584.635645]  [<ffffffff81019eaa>] show_stack_log_lvl+0xea/0x170
>> [  584.642391]  [<ffffffff8101ac51>] show_stack+0x21/0x40
>> [  584.648238]  [<ffffffff813175a0>] dump_stack+0x5c/0x7c
>> [  584.654085]  [<ffffffff8107f4e1>] warn_slowpath_common+0x81/0xb0
>> [  584.660932]  [<ffffffff81009de7>] xen_alloc_pte+0x1c7/0x390
>> [  584.667289]  [<ffffffff810647f0>] pmd_populate_kernel.constprop.6+0x40/0x80
>> [  584.675241]  [<ffffffff815ecfe8>] phys_pmd_init+0x210/0x255
>> [  584.681587]  [<ffffffff815ed207>] phys_pud_init+0x1da/0x247
>> [  584.687931]  [<ffffffff815edb3b>] kernel_physical_mapping_init+0xf5/0x1d4
>> [  584.695682]  [<ffffffff815e9bdd>] init_memory_mapping+0x18d/0x380
>> [  584.702631]  [<ffffffff81064699>] arch_add_memory+0x59/0xf0
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  arch/x86/xen/setup.c      | 10 ++++++++++
>>  drivers/xen/xen-balloon.c |  6 ++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
>> index d5f303c0e656..fdb184cadaf5 100644
>> --- a/arch/x86/xen/setup.c
>> +++ b/arch/x86/xen/setup.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpufreq.h>
>> +#include <linux/memory_hotplug.h>
>>  
>>  #include <asm/elf.h>
>>  #include <asm/vdso.h>
>> @@ -825,6 +826,15 @@ char * __init xen_memory_setup(void)
>>  				xen_max_p2m_pfn = pfn_s + n_pfns;
>>  			} else
>>  				discard = true;
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +			/*
>> +			 * Don't allow adding memory not in E820 map while
>> +			 * booting the system. Once the balloon driver is up
>> +			 * it will remove that restriction again.
>> +			 */
>> +			max_mem_size = xen_e820_table.entries[i].addr +
>> +				       xen_e820_table.entries[i].size;
>> +#endif
>>  		}
>>  
>>  		if (!discard)
>> diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
>> index 2acbfe104e46..2a960fcc812e 100644
>> --- a/drivers/xen/xen-balloon.c
>> +++ b/drivers/xen/xen-balloon.c
>> @@ -37,6 +37,7 @@
>>  #include <linux/mm_types.h>
>>  #include <linux/init.h>
>>  #include <linux/capability.h>
>> +#include <linux/memory_hotplug.h>
>>  
>>  #include <xen/xen.h>
>>  #include <xen/interface/xen.h>
>> @@ -63,6 +64,11 @@ static void watch_target(struct xenbus_watch *watch,
>>  	static bool watch_fired;
>>  	static long target_diff;
>>  
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +	/* The balloon driver will take care of adding memory now. */
>> +	max_mem_size = U64_MAX;
>> +#endif
> 
> 
> I don't think I understand this. Are you saying the guest should ignore
> 'mem' boot option?

No, I just managed to forget thinking about that possibility.

I need to save the old max_mem_size setting in setup.c and restore it here.


Juergen
