Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeERMyn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:54:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:35977 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbeERMym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:54:42 -0400
Date: Fri, 18 May 2018 14:54:39 +0200
From: Petr Mladek <pmladek@suse.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
Message-ID: <20180518125439.d5ve654eez6vne45@pathway.suse.cz>
References: <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV>
 <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV>
 <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <CACT4Y+Zuiq3Ubmbq+ON9bLaxUy-tMdge1g=Tfvnjcru6oySvZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zuiq3Ubmbq+ON9bLaxUy-tMdge1g=Tfvnjcru6oySvZg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-05-18 14:25:57, Dmitry Vyukov wrote:
> > On Thu 2018-05-17 20:21:35, Sergey Senozhatsky wrote:
> >> Dunno...
> >> For instance, can we store context tracking info as a extended record
> >> data? We have that dict/dict_len thing. So may we can store tracking
> >> info there? Extended records will appear on the serial console /* if
> >> console supports extended data */ or can be read in via devkmsg_read().
> 
> What consoles do support it?
> We are interested at least in qemu console, GCE console and Android
> phone consoles. But it would be pity if this can't be used on various
> development boards too.

Only the netconsole is able to show the extended (dict)
information at the moment. Search for CON_EXTENDED flag.

Best Regards,
Petr
