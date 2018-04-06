Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeDFQxk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:53:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751638AbeDFQxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:53:39 -0400
Date: Fri, 6 Apr 2018 11:53:38 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+9d1d9866b0b8ee6e0a8c@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: KASAN: alloca-out-of-bounds Read in unwind_next_frame
Message-ID: <20180406165338.oa5wmjtknauehafp@treble>
References: <94eb2c05611408a11a056922c4cb@google.com>
 <20180406153633.lex32dujz747ycm5@treble>
 <CACT4Y+Zi3cBfjao_VE6ugOXosuCXWoJ58PfuZdYbckfOLzN09A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zi3cBfjao_VE6ugOXosuCXWoJ58PfuZdYbckfOLzN09A@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 05:40:01PM +0200, Dmitry Vyukov wrote:
> > So at first glance it seemed like a race condition.  However, the
> > unwinder was only trying to dereference the frame pointer (RBP:
> > ffff8801b05e67f8), which should have never been poisoned in the first
> > place.
> >
> > So it looks like a bug in the KASAN alloca poisoning.
> 
> Hi Josh,
> 
> You seen my previous message, right? Or was it lost somehow?
> 
> https://groups.google.com/d/msg/syzkaller-bugs/IcKqxHzhmQc/KAL6o7tOCAAJ

Oops, you're right, I missed it.  Seems like we came to the same
conclusion anyway :-)

-- 
Josh
