Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbeBMJbZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:31:25 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52659 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934318AbeBMJbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:31:22 -0500
X-Google-Smtp-Source: AH8x225Cho0/Av0gG+rkwoUsz5Pxd7vIX1c4sWLer6q3VJoYTvgqzhMrY9octKQgbtjGOpIcgcSKiw==
Date: Tue, 13 Feb 2018 10:31:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: typo: remove space in #ifdef
Message-ID: <20180213093118.ec3cwjlufpqr7jrd@gmail.com>
References: <1518512382-29426-1-git-send-email-vincent.guittot@linaro.org>
 <20180213090544.GE25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213090544.GE25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Feb 13, 2018 at 09:59:42AM +0100, Vincent Guittot wrote:
> > Remove a useless space in # ifdef and align it with others
> > 
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1070803..cad1932 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -2823,7 +2823,7 @@ void reweight_task(struct task_struct *p, int prio)
> >  }
> >  
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> > -# ifdef CONFIG_SMP
> > +#ifdef CONFIG_SMP
> 
> Heh, so this is one where Ingo and me disagree ;-)

In this particular case I agree with you.

> He likes that indented preprocessor nonsense, whereas I just find it really 
> bothersome.

Here it's bothersome, because the #ifdef block is long.

It's actually a big improvement in other places:

#ifdef CONFIG_EFI_STUB
# ifdef CONFIG_EFI_MIXED
#  define XLF23 (XLF_EFI_HANDOVER_32|XLF_EFI_HANDOVER_64)
# else
#  ifdef CONFIG_X86_64
#   define XLF23 XLF_EFI_HANDOVER_64            /* 64-bit EFI handover ok */
#  else
#   define XLF23 XLF_EFI_HANDOVER_32            /* 32-bit EFI handover ok */
#  endif
# endif
#else
# define XLF23 0
#endif

Which is a _LOT_ more structured and easier to read than:

#ifdef CONFIG_EFI_STUB
#ifdef CONFIG_EFI_MIXED
#define XLF23 (XLF_EFI_HANDOVER_32|XLF_EFI_HANDOVER_64)
#else
#ifdef CONFIG_X86_64
#define XLF23 XLF_EFI_HANDOVER_64            /* 64-bit EFI handover ok */
#else
#define XLF23 XLF_EFI_HANDOVER_32            /* 32-bit EFI handover ok */
#endif
#endif
#else
#define XLF23 0
#endif

Thanks,

	Ingo
