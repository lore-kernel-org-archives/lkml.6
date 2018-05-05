Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeEEMcH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 08:32:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34473 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeEEMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 08:32:05 -0400
X-Google-Smtp-Source: AB8JxZpKes9Y/o3JGTfXns5ZnuUv1INWyjukk27Zkcjz033HvKW86OjVNF2vvu2HFrviFCOmuMD9Tg==
Date: Sat, 5 May 2018 15:32:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com
Subject: Re: [PATCH] elf: don't hash userspace addresses
Message-ID: <20180505123201.GA10847@avx2>
References: <20180504212308.GA7564@avx2>
 <201805050931.FEG18215.tFJOFLHOFVSOQM@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201805050931.FEG18215.tFJOFLHOFVSOQM@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 09:31:50AM +0900, Tetsuo Handa wrote:
> Alexey Dobriyan wrote:
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  fs/binfmt_elf.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -379,8 +379,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> >  
> >  	if ((type & MAP_FIXED_NOREPLACE) &&
> >  	    PTR_ERR((void *)map_addr) == -EEXIST)
> > -		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
> > -			task_pid_nr(current), current->comm, (void *)addr);
> > +		pr_info("%d (%s): Uhuuh, elf segment at %lx requested but the memory is mapped already\n",
> > +			task_pid_nr(current), current->comm, addr);
> 
> "%px" does not hash. For what reason you replace %px with %lx ?

Duh. There is no reason to use non-standard %px.
