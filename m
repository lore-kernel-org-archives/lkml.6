Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF5C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61EA2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61EA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeK3NNn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:13:43 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:33538 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbeK3NNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:13:43 -0500
X-ASG-Debug-ID: 1543543512-093b7e197b40dc0001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id JWexhe6Z75Qv3iup (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 30 Nov 2018 10:05:12 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Nov 2018 10:04:26 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Fri, 30 Nov 2018 10:04:26 +0800
From:   "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To:     Kees Cook <keescook@chromium.org>
CC:     David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched/headers: fix thread_info.<first> is overwritten
 by STACK_END_MAGIC
Thread-Topic: [PATCH 1/1] sched/headers: fix thread_info.<first> is
 overwritten by STACK_END_MAGIC
X-ASG-Orig-Subj: Re: [PATCH 1/1] sched/headers: fix thread_info.<first> is overwritten
 by STACK_END_MAGIC
Thread-Index: AQHUgwHXQvH51CSg9UWtTixRCjaq8A==
Date:   Fri, 30 Nov 2018 02:04:26 +0000
Message-ID: <810b0ad91d5547c5bbbec1b61c119bdc@HXTBJIDCEMVIW02.hxtcorp.net>
References: <e7952089a66db4e5d59d2af230a324155bb018a0.1542955914.git.dongsheng.wang@hxt-semitech.com>
 <CAGXu5jKTQK2BGYefNXkW=-=svzhnqP4Pho3jK+mORAjDxgnsRA@mail.gmail.com>
 <19391812db6444f3bd260546acded9b7@HXTBJIDCEMVIW02.hxtcorp.net>
 <CAGXu5jJg+rfDi1VuiaevPSkaZidjmEC2au9yJR6n6rWJR-qcsg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.159]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1543543512
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.62724
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/30 5:22, Kees Cook wrote:
> On Tue, Nov 27, 2018 at 8:38 PM Wang, Dongsheng
> <dongsheng.wang@hxt-semitech.com> wrote:
>> Hello Kees,
>>
>> On 2018/11/28 6:38, Kees Cook wrote:
>>> On Thu, Nov 22, 2018 at 11:54 PM, Wang Dongsheng
>>> <dongsheng.wang@hxt-semitech.com> wrote:
>>>> When select ARCH_TASK_STRUCT_ON_STACK the first of thread_info variable
>>>> is overwritten by STACK_END_MAGIC. In fact, the ARCH_TASK_STRUCT_ON_STACK
>>>> is not a real task on stack, it's only init_task on init_stack.
>>>>
>>>> Commit 0500871f21b2 ("Construct init thread stack in the linker script
>>>> rather than by union") added this macro and put task_strcut into
>>>> thread_union. This brings us the following possibilities:
>>>>     TASK_ON_STACK    THREAD_INFO_IN_TASK    STACK
>>>>                                             ----- <-- thread_info & stack
>>>>         N                    N             |     |     --- <-- task
>>>>                                            |     |    |   |
>>>>                                             -----      ---
>>>>
>>>>                                             ----- <-- stack
>>>>         N                    Y             |     |     --- <-- task(Including thread_info)
>>>>                                            |     |    |   |
>>>>                                             -----      ---
>>>>
>>>>                                             ----- <-- stack & task & thread_info
>>>>         Y                    N             |     |
>>>>                                            |     |
>>>>                                             -----
>>>>
>>>>                                             ----- <-- stack & task(Including thread_info)
>>>>         Y                    Y             |     |
>>>>                                            |     |
>>>>                                             -----
>>>> The kernel has handled the first two cases correctly.
>>>>
>>>> For the third case:
>>>> TASK_ON_STACK: Y. THREAD_INFO_IN_TASK: N. this case
>>>> should never happen, because the task and thread_info will overlap. So
>>>> when TASK_ON_STACK is selected, THREAD_INFO_IN_TASK must be selected too.
>>>>
>>>> For the fourth case:
>>>> When task on stack, the end of stack should add a sizeof(task_struct) offset.
>>>>
>>>> This patch handled with the third and fourth case.
>>>>
>>>> Fixes: 0500871f21b2 ("Construct init thread stack in the linker ...")
>>>>
>>>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>>>> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
>>>> ---
>>>>  arch/Kconfig                     | 1 +
>>>>  include/linux/sched/task_stack.h | 5 ++++-
>>>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>> index e1e540ffa979..0a2c73e73195 100644
>>>> --- a/arch/Kconfig
>>>> +++ b/arch/Kconfig
>>>> @@ -251,6 +251,7 @@ config ARCH_HAS_SET_MEMORY
>>>>  # Select if arch init_task must go in the __init_task_data section
>>>>  config ARCH_TASK_STRUCT_ON_STACK
>>>>         bool
>>>> +       depends on THREAD_INFO_IN_TASK || IA64
>>> The "IA64" part shouldn't be needed since IA64 already selects it.
>>>
>>> Since it's selected, it also can't have a depends, IIUC.
>> Since the IA64 thread_info including task_struct, it doesn't need to
>> select THREAD_INFO_IN_TASK.
>> So we need to allow IA64 select ARCH_TASK_STRUCT_ON_STACK without
>> THREAD_INFO.
> Okay.
>
>>>>  # Select if arch has its private alloc_task_struct() function
>>>>  config ARCH_TASK_STRUCT_ALLOCATOR
>>>> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
>>>> index 6a841929073f..624c48defb9e 100644
>>>> --- a/include/linux/sched/task_stack.h
>>>> +++ b/include/linux/sched/task_stack.h
>>>> @@ -7,6 +7,7 @@
>>>>   */
>>>>
>>>>  #include <linux/sched.h>
>>>> +#include <linux/sched/task.h>
>>>>  #include <linux/magic.h>
>>>>
>>>>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>>>> @@ -25,7 +26,9 @@ static inline void *task_stack_page(const struct task_struct *task)
>>>>
>>>>  static inline unsigned long *end_of_stack(const struct task_struct *task)
>>>>  {
>>>> -       return task->stack;
>>>> +       if (!IS_ENABLED(CONFIG_ARCH_TASK_STRUCT_ON_STACK) || task != &init_task)
>>>> +               return task->stack;
>>>> +       return (unsigned long *)(task + 1);
>>>>  }
>>> This seems like a strange place for the change. It feels more like
>>> init_task has been defined incorrectly.
>> The init_task will put into init_stack when ARCH_TASK_STRUCT_ON_STACK is
>> selected.
>> include/asm-generic/vmlinux.lds.h:
>> #define INIT_TASK_DATA(align)                        \
>>     . = ALIGN(align);                        \
>>     __start_init_task = .;                        \
>>     init_thread_union = .;                        \
>>     init_stack = .;                            \
>>     KEEP(*(.data..init_task))                    \
>>     KEEP(*(.data..init_thread_info))                \
>>     . = __start_init_task + THREAD_SIZE;                \
>>     __end_init_task = .;
>>
>> So we need end_of_stack to offset sizeof(task_struct).
> Well, I guess I mean I'd rather the end_of_stack() code not be
> special-cased in the if. The default should be how it was. Perhaps:
>
> if (IS_ENABLED(CONFIG_ARCH_TASK_STRUCT_ON_STACK) && task == &init_task)
>     return (unsigned long *)(task + 1);
> return task->stack;
>
> But it still feels strange: why can't task->stack point to the correct
> place in this special case?

Normally, task->stack is the bottom of the stack, the end_of_stack just
need to return task->stack.
The task->stack always represents the bottom of the stack, and it cannot
be changed, so what
happens here is we have some data(task or thread info)that we want to
put at the bottom of the
stack. The end_of_stack just refers to the size of the stack available
to us.
In ARCH_TASK_STRUCT_ON_STACK case, the init_task has been placed in a
fixed location, the task
is placed at the bottom of the stack. Current end_of_stack doesn't
handle this situation, so we need
add a if condition to handle it. And this is just like
!THREAD_INFO_IN_TASK(the thead_info on stack),
the thread_info is placed at the bottom of the stack, the end_of_stack =
the bottom of stack + sizeof(*thread_info).


Cheers,
Dongsheng

