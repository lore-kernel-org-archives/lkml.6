Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935479AbeEXCVv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 22:21:51 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45947 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935331AbeEXCVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 22:21:48 -0400
X-Google-Smtp-Source: AB8JxZqLA9xGkC5Ezu72dlpz9/zOMCnLqhYTaPWzz/cfAIBGH8zq7GoFh6tsZvo+YPlUrrnlWxlk0g==
Date: Thu, 24 May 2018 11:21:43 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180524022143.GB23443@jagdpanzerIV>
References: <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV>
 <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <CACT4Y+Zuiq3Ubmbq+ON9bLaxUy-tMdge1g=Tfvnjcru6oySvZg@mail.gmail.com>
 <20180518125439.d5ve654eez6vne45@pathway.suse.cz>
 <CACT4Y+aFO+yZ7ovkxJOJfz=JgsE3yr+ywLQ9kVUrOHYMBgfWdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aFO+yZ7ovkxJOJfz=JgsE3yr+ywLQ9kVUrOHYMBgfWdg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/18/18 15:08), Dmitry Vyukov wrote:
[..]
> >> What consoles do support it?
> >> We are interested at least in qemu console, GCE console and Android
> >> phone consoles. But it would be pity if this can't be used on various
> >> development boards too.
> >
> > Only the netconsole is able to show the extended (dict)
> > information at the moment. Search for CON_EXTENDED flag.
> 
> Then we won't be able to use it. And we can't pipe from devkmsg_read
> in user-space, because we need this to work when kernel is broken in
> various ways...

Hmm. Well, basically, any console that has CON_EXTENDED bit set; which
is, probably, only netconsole at this point. Do you use slow serial
consoles?

OK, seems like extended printk records won't make you happy after all :)

	-ss
