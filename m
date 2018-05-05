Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEENTz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 09:19:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:45222 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeEENTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 09:19:54 -0400
To: adobriyan@gmail.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com
Subject: Re: [PATCH] elf: don't hash userspace addresses
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180504212308.GA7564@avx2>
        <201805050931.FEG18215.tFJOFLHOFVSOQM@I-love.SAKURA.ne.jp>
        <20180505123201.GA10847@avx2>
In-Reply-To: <20180505123201.GA10847@avx2>
Message-Id: <201805052219.AGC56242.LFVFQHOOOJFSMt@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sat, 5 May 2018 22:19:43 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Sat, May 05, 2018 at 09:31:50AM +0900, Tetsuo Handa wrote:
> > Alexey Dobriyan wrote:
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> > > 
> > >  fs/binfmt_elf.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -379,8 +379,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> > >  
> > >  	if ((type & MAP_FIXED_NOREPLACE) &&
> > >  	    PTR_ERR((void *)map_addr) == -EEXIST)
> > > -		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
> > > -			task_pid_nr(current), current->comm, (void *)addr);
> > > +		pr_info("%d (%s): Uhuuh, elf segment at %lx requested but the memory is mapped already\n",
> > > +			task_pid_nr(current), current->comm, addr);
> > 
> > "%px" does not hash. For what reason you replace %px with %lx ?
> 
> Duh. There is no reason to use non-standard %px.
> 

See the comment for pointer() function in lib/vsprintf.c .
In Linux kernel world, various extension for %p is supported.
