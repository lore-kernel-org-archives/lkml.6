Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937520AbeBUOQ2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:16:28 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42826 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935340AbeBUOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:16:25 -0500
X-Google-Smtp-Source: AH8x2278pndCXC8A0qdc5CpoSEbiizgJHL9nzJEdkwipEBUETWX+rWagP6D9VgH4dQa8JCGN3hTF/g==
Subject: Re: metag build errors in mainline kernel
To: James Hogan <james.hogan@mips.com>
Cc: linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org
References: <20180220234443.GA27059@roeck-us.net>
 <20180221122719.GI29460@jhogan-linux.mipstec.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <95906b76-6ce1-3f84-eaba-c29b4ae952eb@roeck-us.net>
Date: Wed, 21 Feb 2018 06:16:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221122719.GI29460@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 04:27 AM, James Hogan wrote:
> On Tue, Feb 20, 2018 at 03:44:43PM -0800, Guenter Roeck wrote:
>> The following errors are seen when building the kernel with the latest
>> available metag toolchain (4.2.4 (IMG-1.4.0.700)). Kernel version tested
>> is (v4.16-rc2-64-gaf3e79d29555).
>>
>> metag:allmodconfig
>>
>> arch/metag/kernel/devtree.c:54: error: implicit declaration of function 'pr_info'
>>
>> arch/metag/kernel/perf/perf_event.c:831: error: label ‘out’ used but not defined
>> arch/metag/kernel/perf/perf_event.c:822: warning: unused variable ‘cpu’
> 
> Thanks, these are easy enough for me to fix up.
> 
>>
>> metag:meta2_smp_defconfig
>>
>> kernel/time/hrtimer.c: In function 'hrtimer_run_softirq':
>> time/hrtimer.c:1431: error: unable to find a register to spill in class 'Yr_REGS'
>> time/hrtimer.c:1431: error: this is the insn:
>> (insn:HI 41 40 99 2 kernel/time/hrtimer.c:576 (set (mem/s/j:DI (plus:SI (reg/f:SI 15 D1.7 [orig:84 D.45290 ] [84])
>>                  (const_int 368 [0x170])) [0 <variable>.offset+0 S8 A128])
>> 	(reg:DI 99 [ <variable>.offset ])) 211 {*sto_di_1_1_off12} (nil)
>>      (expr_list:REG_DEAD (reg:DI 99 [ <variable>.offset ])
>> 	(nil)))
>> kernel/time/hrtimer.c:1431: confused by earlier errors, bailing out
> 
> Hmm.. ancient shelved toolchain. Perhaps this is the excuse we need to
> say goodbye to arch/metag/...
> 

Might be worth a thought. The metag toolchain doesn't even build anymore
without tweaking. gcc 4.2.4 doesn't build with a modern gcc, the metag
buildroot on github points to a no longer existing daily snapshot of
uclibc, and ToT uclibc doesn't build with gcc 4.2.4.

Guenter
