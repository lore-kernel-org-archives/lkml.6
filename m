Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeBSNca (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:32:30 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35299 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbeBSNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:32:28 -0500
X-Google-Smtp-Source: AH8x227DIj4mmdV+ULrFn7k6PV5UnlI6WS9cA9pXcsqfkvM4opdgkIbyVpOMAR6q9CGbO80SY2W3pP9jJJNguZVRdJQ=
MIME-Version: 1.0
In-Reply-To: <BN6PR15MB155309E2A35F66298DAD8E2E9AC80@BN6PR15MB1553.namprd15.prod.outlook.com>
References: <001a1143e44e58485f05655fa8ae@google.com> <CACT4Y+bxubQ0yqi777mgQdT6paPS+wWQo79T+jPqztPJ=gTYhw@mail.gmail.com>
 <b6b1e370-d3ba-4db7-228f-a3ccaf502992@virtuozzo.com> <BN6PR15MB155309E2A35F66298DAD8E2E9AC80@BN6PR15MB1553.namprd15.prod.outlook.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 19 Feb 2018 14:32:06 +0100
Message-ID: <CACT4Y+ZKxgzKHw5AG=SRp8n3R5SxH10d-T8WFvV2ayJNy79bjA@mail.gmail.com>
Subject: Re: BUG: sleeping function called from invalid context at
 net/core/sock.c:LINE (3)
To: Jon Maloy <jon.maloy@ericsson.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
        syzbot <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com>,
        Ying Xue <ying.xue@windriver.com>, Andrei Vagin <avagin@virtuozzo.com>,
        David Miller <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Westphal <fw@strlen.de>, LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "roman.kapl@sysgo.com" <roman.kapl@sysgo.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 2:23 PM, Jon Maloy <jon.maloy@ericsson.com> wrote:
> I don't understand this one. tipc_topsrv_stop() can only be trigged from a user doing rmmod(), and I double checked that this is running in user mode.
> How does the call chain you are reporting occur?

Hi Jon,

Please see the original syzbot report, it includes all known
information about the bug (including a reproducer program):
https://groups.google.com/forum/#!topic/syzkaller-bugs/jWAs6YWMp9g




>> -----Original Message-----
>> From: Kirill Tkhai [mailto:ktkhai@virtuozzo.com]
>> Sent: Saturday, February 17, 2018 23:23
>> To: Dmitry Vyukov <dvyukov@google.com>; syzbot
>> <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com>; Jon Maloy
>> <jon.maloy@ericsson.com>; Ying Xue <ying.xue@windriver.com>
>> Cc: Andrei Vagin <avagin@virtuozzo.com>; David Miller
>> <davem@davemloft.net>; Eric W. Biederman <ebiederm@xmission.com>;
>> Florian Westphal <fw@strlen.de>; LKML <linux-kernel@vger.kernel.org>;
>> netdev <netdev@vger.kernel.org>; Nicolas Dichtel
>> <nicolas.dichtel@6wind.com>; roman.kapl@sysgo.com; syzkaller-
>> bugs@googlegroups.com; tipc-discussion@lists.sourceforge.net
>> Subject: Re: BUG: sleeping function called from invalid context at
>> net/core/sock.c:LINE (3)
>>
>> On 17.02.2018 11:15, Dmitry Vyukov wrote:
>> > On Sat, Feb 17, 2018 at 4:00 AM, syzbot
>> > <syzbot+749d9d87c294c00ca856@syzkaller.appspotmail.com> wrote:
>> >> Hello,
>> >>
>> >> syzbot hit the following crash on net-next commit
>> >> 65bd449c32c2745df61913ab54087e77f9d9b70d (Fri Feb 16 20:26:35 2018
>> >> +0000) Merge branch 'tipc-de-generealize-topology-server'
>> >
>> > +tipc maintainers
>>
>> This looks to be caused by commit 0ef897be12b8
>> "tipc: separate topology server listener socket from subcsriber sockets"
>>
>> Thanks,
>> Kirill
