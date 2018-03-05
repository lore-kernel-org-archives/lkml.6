Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932912AbeCEHNB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:13:01 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37341 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932853AbeCEHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:12:57 -0500
X-Google-Smtp-Source: AG47ELtY0iiSbZHhQEm5qPMx3m1DoXYXwt8ulgNCs29/0bTh9cXSCzXPnLJMNZEftNJoT9bcLtnFbg==
Date: Mon, 5 Mar 2018 08:12:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:WIP.sched/core 19/22] kernel/sched/core.c:2836:18: error:
 passing argument 1 of 'mips_install_watch_registers' from incompatible
 pointer type
Message-ID: <20180305071253.xgmpj6a5orleb6pa@gmail.com>
References: <201803041803.gY4ddHfJ%fengguang.wu@intel.com>
 <b8be96d0-8a53-104e-c90d-72a3ea158f8d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8be96d0-8a53-104e-c90d-72a3ea158f8d@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> >    kernel//sched/core.c:2836:2: note: in expansion of macro 'switch_to'
> >      switch_to(prev, next, prev);
> >      ^~~~~~~~~
> >    arch/mips/include/asm/watch.h:15:6: note: expected 'struct task_struct *' but argument is of type 'struct task_struct *'
> >     void mips_install_watch_registers(struct task_struct *t);
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> 
> I don't have a tip git repo, but it looks like this would fix it (based on most
> recent -next):
> 
> --- linux-next-20180302.orig/arch/mips/include/asm/watch.h
> +++ linux-next-20180302/arch/mips/include/asm/watch.h
> @@ -12,6 +12,8 @@
>  
>  #include <asm/mipsregs.h>
>  
> +struct task_struct;
> +
>  void mips_install_watch_registers(struct task_struct *t);
>  void mips_read_watch_registers(void);
>  void mips_clear_watch_registers(void);

Yeah, so MIPS wasn't the only arch affected - so I fixed it by restoring the 
original header order.

Thanks,

	Ingo
