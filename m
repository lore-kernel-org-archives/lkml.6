Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753722AbeEJEWO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:22:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38692 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753519AbeEJEWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:22:12 -0400
X-Google-Smtp-Source: AB8JxZooyQ8AI35kiFUHp3FFu6RWHeam7aiIaskWMhNhuraWxFzIBby1CsZbFri/UQijJIYWmeR8jQ==
Date: Thu, 10 May 2018 13:22:06 +0900
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
Message-ID: <20180510042206.GA3426@jagdpanzerIV>
References: <201804232233.CIC65675.OJSOMFQOFFHVtL@I-love.SAKURA.ne.jp>
 <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
 <20180424013336.GA1376@jagdpanzerIV>
 <20180426100603.czif6sat75fjsazp@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426100603.czif6sat75fjsazp@pathway.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/26/18 12:06), Petr Mladek wrote:
> 
> > Petr, Steven, Fengguang, what do you think? Do you have any objections?
> > Ideas?
> 
> I wonder if we could create some mechanism that would help to extend
> struct printk_log easier in the future.

Hm, interesting idea.

> I know only about crash tool implementation. It uses information provided
> by log_buf_vmcoreinfo_setup(). The size of the structure is already
> public. Therefore crash should be able to find all existing information
> even if we increase the size of the structure.
> 
> log_buf_vmcoreinfo_setup() even allows to inform about newly added
> structure items. We could probably extend it to inform also about
> the offset of the new optional elements.

I vaguely remember that the last time Thomas Gleixner modified
printk_log you managed to find a case that broke crash tool.
... Or may be I'm mistaken.

> I am not sure about other tools. But I think that it should be
> doable.

Good. So there are no objections, so far.

Tetsuo, Dmitry, care to send a patch?

	-ss
