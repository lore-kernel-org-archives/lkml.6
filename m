Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeDINLr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:11:47 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33464 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeDINLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:11:44 -0400
X-Google-Smtp-Source: AIpwx49sWTeDWWmfvso3REfy6W6tEeoQkQ0cf5rL5LDsPIipj6MNMNovqUbxn7ZQD1Gxfdqvd/M/UQ==
Subject: Re: WARNING in ip_rt_bug
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b09ac67a2af842b12eab@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>
References: <001a11408d9c43ff4a0569641a3f@google.com>
 <CACT4Y+YfM=SL3-cgeJ_7JCvAwX2KsyMWV=HHpGfLV=-RKo7TQQ@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7707b322-1313-d0db-485c-2821874d78c0@gmail.com>
Date: Mon, 9 Apr 2018 06:11:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YfM=SL3-cgeJ_7JCvAwX2KsyMWV=HHpGfLV=-RKo7TQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/08/2018 11:06 PM, Dmitry Vyukov wrote:
> On Mon, Apr 9, 2018 at 7:59 AM, syzbot
> <syzbot+b09ac67a2af842b12eab@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot hit the following crash on net-next commit
>> 8bde261e535257e81087d39ff808414e2f5aa39d (Sun Apr 1 02:31:43 2018 +0000)
>> Merge tag 'mlx5-updates-2018-03-30' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
>> syzbot dashboard link:
>> https://syzkaller.appspot.com/bug?extid=b09ac67a2af842b12eab
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>> Raw console output:
>> https://syzkaller.appspot.com/x/log.txt?id=5991727739437056
>> Kernel config:
>> https://syzkaller.appspot.com/x/.config?id=3327544840960562528
>> compiler: gcc (GCC) 7.1.1 20170620
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+b09ac67a2af842b12eab@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
> 
> 
> +Eric said that perhaps we just need to revert:
> 
> commit c378a9c019cf5e017d1ed24954b54fae7bebd2bc
> Date:   Sat May 21 07:16:42 2011 +0000
>     ipv4: Give backtrace in ip_rt_bug().
> 

And David replied :

<quote>
Let's not do the revert, I wouldn't have seen the backtrace which
points where this bug is if we had.

icmp_route_lookup(), in one branch, does an input route lookup and
uses the result of that to send the icmp message.

That can't be right, input routes should never be used for
transmitting traffice and that's how we end up at ip_rt_bug().

</quote>
