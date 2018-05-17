Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeEQL5z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:57:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:56441 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeEQL5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:57:54 -0400
Date: Thu, 17 May 2018 13:57:52 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: sergey.senozhatsky.work@gmail.com, dvyukov@google.com,
        sergey.senozhatsky@gmail.com, syzkaller@googlegroups.com,
        rostedt@goodmis.org, fengguang.wu@intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH] printk: fix possible reuse of va_list variable
Message-ID: <20180517115752.iiatw77riws2vozb@pathway.suse.cz>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
 <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <201805112002.GIF21216.OFVHFOMLJtQFSO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805112002.GIF21216.OFVHFOMLJtQFSO@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-05-11 20:02:31, Tetsuo Handa wrote:
> >From 766cf72b5fdc00d1cf5a8ca2c6b23ebb75e2b4d4 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Fri, 11 May 2018 19:54:19 +0900
> Subject: [PATCH] printk: fix possible reuse of va_list variable
> 
> I noticed that there is a possibility that printk_safe_log_store() causes
> kernel oops because "args" parameter is passed to vsnprintf() again when
> atomic_cmpxchg() detected that we raced. Fix this by using va_copy().

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have tagged it for stable and pushed into printk.git,
branch for-4.18, see
https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.18&id=988a35f8da1dec5a8cd2788054d1e717be61bf25

Best Regards,
Petr
