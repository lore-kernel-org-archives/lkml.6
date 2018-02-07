Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeBGKLr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:11:47 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45319 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbeBGKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:11:45 -0500
X-Google-Smtp-Source: AH8x225vkoNxW7gO2wzGazigTyk9FJIbg53lleoL/OpR6s1FAbHrZ8k6XAvhj5Dc9zJzTXvA9GcFKpaWZC6MnRcdNE0=
MIME-Version: 1.0
In-Reply-To: <1517994487.3996.7.camel@redhat.com>
References: <94eb2c07fd4c75cd8705648eeb87@google.com> <CACT4Y+ahGbrH9BGFeAfRW08jJEWfWf7ovzP9vsHZVQ4-KM5hTw@mail.gmail.com>
 <1517994487.3996.7.camel@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 7 Feb 2018 11:11:24 +0100
Message-ID: <CACT4Y+ZA1TsyGbY+eB_6YArx4LWtCw-9A5L8S_XMGAtaZ-Qf+A@mail.gmail.com>
Subject: Re: possible deadlock in rtnl_lock (3)
To: Paolo Abeni <pabeni@redhat.com>
Cc: syzbot <syzbot+63682ce11532e0da2b9d@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Benc <jbenc@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 10:08 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2018-02-06 at 19:00 +0100, Dmitry Vyukov wrote:
>> On Tue, Feb 6, 2018 at 6:58 PM, syzbot
>> <syzbot+63682ce11532e0da2b9d@syzkaller.appspotmail.com> wrote:
>> > Hello,
>> >
>> > syzbot hit the following crash on net-next commit
>> > 617aebe6a97efa539cc4b8a52adccd89596e6be0 (Sun Feb 4 00:25:42 2018 +0000)
>> > Merge tag 'usercopy-v4.16-rc1' of
>> > git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
>> >
>> > So far this crash happened 2510 times on net-next, upstream.
>> > C reproducer is attached.
>> > syzkaller reproducer is attached.
>> > Raw console output is attached.
>> > compiler: gcc (GCC) 7.1.1 20170620
>> > .config is attached.
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+63682ce11532e0da2b9d@syzkaller.appspotmail.com
>> > It will help syzbot understand when the bug is fixed. See footer for
>> > details.
>> > If you forward the report, please keep this part and the footer.
>>
>>
>> Paolo, was this also fixed by "netfilter: on sockopt() acquire sock
>> lock only in the required scope"?
>
> I *think* this is fixed by the above commit, anyway I'll probably be
> unable to verify such statement soon.

Thanks, Paolo. This is good enough for now. If this is wrong, syzbot
will hit it again later, but at that point we will know that the patch
is present in the tested tree.

#syz fix: netfilter: on sockopt() acquire sock lock only in the required scope
