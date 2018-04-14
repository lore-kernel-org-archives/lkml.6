Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbeDNCfW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 22:35:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33684 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbeDNCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 22:35:21 -0400
X-Google-Smtp-Source: AIpwx49ec85pGPAoGZsIS35Fl7cJ6ttt2gCfPmrtYliIxmCaY7VuTbvl+OiU5yy5IUPRSqryDQM6nQ==
Date: Sat, 14 Apr 2018 11:35:16 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180414023516.GA17806@tigerII.localdomain>
References: <20180413124704.19335-1-pmladek@suse.com>
 <20180413101233.0792ebf0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413101233.0792ebf0@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/13/18 10:12), Steven Rostedt wrote:
> 
> > The interval is set to one hour. It is rather arbitrary selected time.
> > It is supposed to be a compromise between never print these messages,
> > do not lockup the machine, do not fill the entire buffer too quickly,
> > and get information if something changes over time.
> 
> 
> I think an hour is incredibly long. We only allow 100 lines per hour for
> printks happening inside another printk?
> 
> I think 5 minutes (at most) would probably be plenty. One minute may be
> good enough.

Besides 100 lines is absolutely not enough for any real lockdep splat.
My call would be - up to 1000 lines in a 1 minute interval.

	-ss
