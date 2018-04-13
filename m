Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754056AbeDMLQ0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:16:26 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:44012 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeDMLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:16:25 -0400
X-Google-Smtp-Source: AIpwx4/ej01tAr+PfvK39ARfoJ3qmkLgj82gFW9IPKPjCkYBpcDlvnMAyKOX6CjR9bawi5q1JmPgihrpY/NkF3it08g=
MIME-Version: 1.0
In-Reply-To: <20180406165338.oa5wmjtknauehafp@treble>
References: <94eb2c05611408a11a056922c4cb@google.com> <20180406153633.lex32dujz747ycm5@treble>
 <CACT4Y+Zi3cBfjao_VE6ugOXosuCXWoJ58PfuZdYbckfOLzN09A@mail.gmail.com> <20180406165338.oa5wmjtknauehafp@treble>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 13 Apr 2018 13:16:03 +0200
Message-ID: <CACT4Y+aohBGiVvp-6XwJCuXyQca-EX-C2GL-nFcosryhEycXew@mail.gmail.com>
Subject: Re: KASAN: alloca-out-of-bounds Read in unwind_next_frame
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: syzbot <syzbot+9d1d9866b0b8ee6e0a8c@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 6:53 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Fri, Apr 06, 2018 at 05:40:01PM +0200, Dmitry Vyukov wrote:
>> > So at first glance it seemed like a race condition.  However, the
>> > unwinder was only trying to dereference the frame pointer (RBP:
>> > ffff8801b05e67f8), which should have never been poisoned in the first
>> > place.
>> >
>> > So it looks like a bug in the KASAN alloca poisoning.
>>
>> Hi Josh,
>>
>> You seen my previous message, right? Or was it lost somehow?
>>
>> https://groups.google.com/d/msg/syzkaller-bugs/IcKqxHzhmQc/KAL6o7tOCAAJ
>
> Oops, you're right, I missed it.  Seems like we came to the same
> conclusion anyway :-)


The gcc bug is now fixed

#syz invalid
