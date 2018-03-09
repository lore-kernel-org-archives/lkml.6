Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeCIW4M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:56:12 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:34576 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeCIW4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:56:10 -0500
X-Google-Smtp-Source: AG47ELuZz6YSpUd/pOdPl6kesuuTHwimEF13HjR0v2A/Bnis+5rb6GcywM+LzjL1pooeyc3C7S/W3w==
Subject: Re: WARNING in __proc_create
To: Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com>
Cc: coreteam@netfilter.org, David Miller <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzkaller-bugs@googlegroups.com
References: <001a113f2be668a1e9056701e617@google.com>
 <CAM_iQpV+PnGUXEKcSrF7u19NOeLLp0PhDW-DOkEfS+8pLnTgYw@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <a559bbb6-0db4-2b71-b363-792d88d7eef7@gmail.com>
Date: Fri, 9 Mar 2018 14:56:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpV+PnGUXEKcSrF7u19NOeLLp0PhDW-DOkEfS+8pLnTgYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2018 02:48 PM, Cong Wang wrote:
> On Fri, Mar 9, 2018 at 1:59 PM, syzbot
> <syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot hit the following crash on net-next commit
>> 617aebe6a97efa539cc4b8a52adccd89596e6be0 (Sun Feb 4 00:25:42 2018 +0000)
>> Merge tag 'usercopy-v4.16-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
>>
>> So far this crash happened 12 times on net-next, upstream.
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+0502b00edac2a0680b61@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> audit: type=1400 audit(1518223777.419:7): avc:  denied  { map } for
>> pid=4159 comm="syzkaller598581" path="/root/syzkaller598581546" dev="sda1"
>> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
>> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
>> ------------[ cut here ]------------
>> name len 0
>> WARNING: CPU: 0 PID: 4159 at fs/proc/generic.c:354 __proc_create+0x696/0x880
>> fs/proc/generic.c:354
> 
> We need to reject empty names.
> 

I sent a patch a while back, but Pablo/Florian wanted more than that 
simple fix.

We also need to filter special characters like '/'

Or maybe I am mixing with something else.
