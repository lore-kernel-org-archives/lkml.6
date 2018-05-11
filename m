Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeEKL1Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:27:24 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39149 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752394AbeEKL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:27:22 -0400
X-Google-Smtp-Source: AB8JxZp63aPEq/0ngQL/JRcWFrqYz3ElI8bzdOK+oGxRDJ6/GAMKZAuTa6PtaF7ye9NKsoDKP9ftuA==
Date: Fri, 11 May 2018 20:27:18 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        dvyukov@google.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] printk: fix possible reuse of va_list variable
Message-ID: <20180511112718.GA17477@jagdpanzerIV>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
 <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
 <20180511062151.GA18160@jagdpanzerIV>
 <201805112002.GIF21216.OFVHFOMLJtQFSO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805112002.GIF21216.OFVHFOMLJtQFSO@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/11/18 20:02), Tetsuo Handa wrote:
> I noticed that there is a possibility that printk_safe_log_store() causes
> kernel oops because "args" parameter is passed to vsnprintf() again when
> atomic_cmpxchg() detected that we raced. Fix this by using va_copy().
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 42a0bb3f71383b45 ("printk/nmi: generic solution for safe printk in NMI")
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
