Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757254AbeEJML3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:11:29 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37229 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757212AbeEJML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:11:28 -0400
X-Google-Smtp-Source: AB8JxZpM3dFOlvgBYbDnlDJBxawzOWu+92NduEGRGyuahEudbAmWURj0go9gk3HSe5Z32O4D8vojhA==
Date: Thu, 10 May 2018 21:11:22 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: printk feature for syzbot?
Message-ID: <20180510121122.GA29136@jagdpanzerIV>
References: <201804232233.CIC65675.OJSOMFQOFFHVtL@I-love.SAKURA.ne.jp>
 <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
 <20180424013336.GA1376@jagdpanzerIV>
 <20180426100603.czif6sat75fjsazp@pathway.suse.cz>
 <20180510042206.GA3426@jagdpanzerIV>
 <20180510113058.q6d7apmih5sdmlba@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510113058.q6d7apmih5sdmlba@pathway.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/10/18 13:30), Petr Mladek wrote:
[..]
> I guess that you are talking about the patchset adding possibility
> to use different time-stamps[1]. It changed the semantic of the
> timestamp. All the tools needed an update to show the timestamp
> correctly.
> 
> The patchset was rejected by Linus because it would broke some
> userspace tool, e.g. systemd, that depend on the format and semantic
> provided by /dev/kmsg[2].

Right, but I think I was talking about this email
 https://lkml.kernel.org/r/20171123124648.s4oigunxjfzvhtqh@pathway.suse.cz

But yeah, it's not really related to the extension of struct printk_log,
so I think we should be fine.

> By other words, we must not change /dev/kmsg format. But it should
> be acceptable to change/extend the internal format and eventually
> extend the format used on consoles.

Sure.

> Anyway, we need to be careful and test makedumpfile and crash tools
> and eventually provide patches for them.

Agreed. I'd prefer it to be hidden somewhere under kernel hacking config,
so only syzkaller folks would enable it. I think Steven also mentioned
a config option.

> Reference:
> [0] https://lkml.kernel.org/r/20160419085613.GJ6862@pathway.suse.cz
> [1] https://lkml.kernel.org/r/CA+55aFzLH9crdMtUFkD-PtNGuxu_fsG5GH2ACni69ug9iM=09g@mail.gmail.com

Thanks.

	-ss
