Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeDRSdn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:33:43 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:42657 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:33:41 -0400
X-Google-Smtp-Source: AIpwx49qXownBU8vYJBrvirbUDXhVOv3mabWcMumHNLpiRQc/kUKYDFEf8NjNwMKD0X8EM6Wkk1PsRT2fQKOof2aRL4=
MIME-Version: 1.0
In-Reply-To: <93351718-7314-70c4-61a7-2c7b3582b5a0@infradead.org>
References: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
 <CA+55aFzxDYGLUPY802rJN=wgJ1aEZHLRE+W8J82eFz2nzKOMBg@mail.gmail.com>
 <CACT4Y+YDqJMb4mC6c--Ku=ZL9MpELmUKMXe4uQJ6H0av2FJC9w@mail.gmail.com>
 <20180323201634.GA16350@gmail.com> <CA+55aFwZpMB=VUTCNUgc4dcCEy9_T4iE0R0pAfDets=zDFJunQ@mail.gmail.com>
 <CACT4Y+YjD68zBdN7zCViB5ab9-R2JgBEf5OBiDauxMsyuEkLRw@mail.gmail.com>
 <CA+55aFwJ=fiuV+QF+-b+H58tquCzek6CNpssZn40r0z4E0Q6kA@mail.gmail.com>
 <CACT4Y+YUFbbQgE9C1awsVVBFOjLbTXANRQwPK+R58FLjhTb-Vg@mail.gmail.com> <93351718-7314-70c4-61a7-2c7b3582b5a0@infradead.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 18 Apr 2018 20:33:20 +0200
Message-ID: <CACT4Y+be+HpPtgFhrJP8ANE4_0nQBQctqPSs8QGF09Y4_tRYOQ@mail.gmail.com>
Subject: Re: syzbot dashboard
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers3@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 5:55 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/16/2018 04:15 AM, Dmitry Vyukov wrote:
>> On Sat, Apr 14, 2018 at 8:25 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>> Coming back to this now that the merge window is almost over ]
>>>
>>> On Mon, Mar 26, 2018 at 1:46 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>
>>>> I've switched emails to links instead of attachments, here are few
>>>> recent examples:
>>>> https://lkml.org/lkml/2018/3/25/31
>>>> https://lkml.org/lkml/2018/3/25/256
>>>> https://lkml.org/lkml/2018/3/25/257
>>>
>>> Looks good to me. I notice that only the last one got any replies, though.
>>>
>>> I wonder if some people auto-ignore the new reports because of having
>>> been burned by the previous "huge illegible emails" issue.
>>>
>>> I do see syzbot fixes in rdma, though, just not for that
>>> cma_listen_on_all issue. So maybe that bug is nastier.
>>
>> "possible deadlock in handle_rx" is now marked as fixed with
>> "vhost_net: add missing lock nesting notation".
>> "KASAN: use-after-free Read in pppol2tp_connect (3)" is marked as
>> fixed with "l2tp: fix races in tunnel creation".
>> "KASAN: use-after-free Read in __list_add_valid (5)" is still open.
>>
>> Though, there are still 182 open bugs on dashboard:
>> https://syzkaller.appspot.com/
>>
>> 80+ have reproducers and happened last time recently enough. Few
>> dozens without reproducers, but as history shows ~2/3 of them are
>> fixable. Part of the remaining ones is probably fixed, but nobody told
>> syzbot about the fixes. Part is probably still unfixed but happen
>> episodically.
>>
>
> https://syzkaller.appspot.com/bug?id=0627d4551fdc39bf1ef5d82cd9eef587047f7718
> is fixed by 9ad553abe66f ("fs/reiserfs/journal.c: add missing resierfs_warning() arg"),
>
> which does contain the string:
> Reported-by: <syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com>
>
> Is one of those hex strings incorrect?

Hi Randy,

They are correct and no action is needed. It's just that the commit
did not reach any of the trees that syzbot polls, so it did not know
about them yet. You can see that now syzbot has picked the commit.
