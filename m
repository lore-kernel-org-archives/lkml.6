Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754804AbeDWLgI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754624AbeDWLgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:36:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4CE21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 23 Apr 2018 07:36:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180423073603.6b3294ba@gandalf.local.home>
In-Reply-To: <20180423103232.k23yulv2e7fah42r@pathway.suse.cz>
References: <20180416014729.GB1034@jagdpanzerIV>
        <20180416042553.GA555@jagdpanzerIV>
        <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
        <20180420021511.GB6397@jagdpanzerIV>
        <20180420091224.cotxcfycmtt2hm4m@pathway.suse.cz>
        <20180420080428.622a8e7f@gandalf.local.home>
        <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
        <20180420101751.6c1c70e8@gandalf.local.home>
        <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
        <20180420111307.44008fc7@gandalf.local.home>
        <20180423103232.k23yulv2e7fah42r@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 12:32:32 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > Really?
> > 
> > 
> >   console_trylock_spinning(); /* console_owner now equals current */  
> 
> No, console_trylock_spinning() does not modify console_owner. The
> handshake is done using console_waiter variable.

Ug, you're right. Somehow when I looked at where console_owner was set
"console_lock_spinning_enabled" I saw it as "console_trylock_spinning".

This is what I get when I'm trying to follow three threads at the same
time :-/

> 
> console_owner is really set only between:
> 
>     console_lock_spinning_enable()
>     console_lock_spinning_disable_and_check()
> 
> and this entire section is called with interrupts disabled.

OK, I agree with you now. Although, one hour may still be too long.

-- Steve
