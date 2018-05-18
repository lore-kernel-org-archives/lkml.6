Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeERNId (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:08:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33754 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeERNI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:08:27 -0400
X-Google-Smtp-Source: AB8JxZoQaQR0eAP8Nxny1xWnMZeht9UlYoNDSSw1B4ps+e8HVp5V8G0ss85bBMianuYa4aDtyLGoha7tDsX10W9Yzj8=
MIME-Version: 1.0
In-Reply-To: <20180518125439.d5ve654eez6vne45@pathway.suse.cz>
References: <20180511014515.GA895@jagdpanzerIV> <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV> <CACT4Y+ahAHZa7WGW41rY5TtApU7F9x2jo=iPv8GvjaGZbzMOCQ@mail.gmail.com>
 <20180511095004.GA6575@jagdpanzerIV> <201805112058.AAB05258.HJQFFOMFOVtOSL@I-love.SAKURA.ne.jp>
 <20180517112135.GB20796@jagdpanzerIV> <20180518121506.wilixxkznbtskw34@pathway.suse.cz>
 <CACT4Y+Zuiq3Ubmbq+ON9bLaxUy-tMdge1g=Tfvnjcru6oySvZg@mail.gmail.com> <20180518125439.d5ve654eez6vne45@pathway.suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 18 May 2018 15:08:06 +0200
Message-ID: <CACT4Y+aFO+yZ7ovkxJOJfz=JgsE3yr+ywLQ9kVUrOHYMBgfWdg@mail.gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of message
To: Petr Mladek <pmladek@suse.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 2:54 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2018-05-18 14:25:57, Dmitry Vyukov wrote:
>> > On Thu 2018-05-17 20:21:35, Sergey Senozhatsky wrote:
>> >> Dunno...
>> >> For instance, can we store context tracking info as a extended record
>> >> data? We have that dict/dict_len thing. So may we can store tracking
>> >> info there? Extended records will appear on the serial console /* if
>> >> console supports extended data */ or can be read in via devkmsg_read().
>>
>> What consoles do support it?
>> We are interested at least in qemu console, GCE console and Android
>> phone consoles. But it would be pity if this can't be used on various
>> development boards too.
>
> Only the netconsole is able to show the extended (dict)
> information at the moment. Search for CON_EXTENDED flag.

Then we won't be able to use it. And we can't pipe from devkmsg_read
in user-space, because we need this to work when kernel is broken in
various ways...
