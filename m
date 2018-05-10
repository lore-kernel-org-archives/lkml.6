Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965905AbeEJOWH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965379AbeEJOWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:22:06 -0400
Date: Thu, 10 May 2018 10:22:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: printk feature for syzbot?
Message-ID: <20180510102203.520e303d@gandalf.local.home>
In-Reply-To: <20180510121122.GA29136@jagdpanzerIV>
References: <201804232233.CIC65675.OJSOMFQOFFHVtL@I-love.SAKURA.ne.jp>
        <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
        <20180424013336.GA1376@jagdpanzerIV>
        <20180426100603.czif6sat75fjsazp@pathway.suse.cz>
        <20180510042206.GA3426@jagdpanzerIV>
        <20180510113058.q6d7apmih5sdmlba@pathway.suse.cz>
        <20180510121122.GA29136@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 21:11:22 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> > The patchset was rejected by Linus because it would broke some
> > userspace tool, e.g. systemd, that depend on the format and semantic
> > provided by /dev/kmsg[2].  
> 
> Right, but I think I was talking about this email
>  https://lkml.kernel.org/r/20171123124648.s4oigunxjfzvhtqh@pathway.suse.cz
> 
> But yeah, it's not really related to the extension of struct printk_log,
> so I think we should be fine.

Note, crash is "special". It depends on internals of the kernel to keep
working as its purpose is to debug kernel crashes. I'm constantly
breaking it with ftrace. Which reminds me, I need to see if it works
with the latest kernel, and send patches if it isn't.

-- Steve
