Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965584AbeEIQkW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:40:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35437 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934647AbeEIQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:40:21 -0400
X-Google-Smtp-Source: AB8JxZrGKe2nu+uzWDZRx2Fv4jacu41a/nbhT7k67oWapSgl7G2WBb4kLTR33/DkqUmcD8RWDpO6Uw==
Date: Wed, 9 May 2018 19:40:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com
Subject: Re: [PATCH] elf: don't hash userspace addresses
Message-ID: <20180509164017.GB16034@avx2>
References: <20180504212308.GA7564@avx2>
 <201805050931.FEG18215.tFJOFLHOFVSOQM@I-love.SAKURA.ne.jp>
 <20180505123201.GA10847@avx2>
 <201805052219.AGC56242.LFVFQHOOOJFSMt@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201805052219.AGC56242.LFVFQHOOOJFSMt@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 10:19:43PM +0900, Tetsuo Handa wrote:
> Alexey Dobriyan wrote:
> > On Sat, May 05, 2018 at 09:31:50AM +0900, Tetsuo Handa wrote:
> > > Alexey Dobriyan wrote:
> > > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > > ---
> > > > 
> > > >  fs/binfmt_elf.c |    4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > --- a/fs/binfmt_elf.c
> > > > +++ b/fs/binfmt_elf.c
> > > > @@ -379,8 +379,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> > > >  
> > > >  	if ((type & MAP_FIXED_NOREPLACE) &&
> > > >  	    PTR_ERR((void *)map_addr) == -EEXIST)
> > > > -		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
> > > > -			task_pid_nr(current), current->comm, (void *)addr);
> > > > +		pr_info("%d (%s): Uhuuh, elf segment at %lx requested but the memory is mapped already\n",
> > > > +			task_pid_nr(current), current->comm, addr);
> > > 
> > > "%px" does not hash. For what reason you replace %px with %lx ?
> > 
> > Duh. There is no reason to use non-standard %px.
> > 
> 
> See the comment for pointer() function in lib/vsprintf.c .
> In Linux kernel world, various extension for %p is supported.

%p has this funny property: scanf(printf("%p", ptr)) does not equal %p
because small pointer will become (null) or (errptr) or whatever is
decided in recent vsnprintf thread, therefore the less %p is used
the better.
