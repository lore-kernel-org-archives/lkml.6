Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeBBIy4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:54:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53321 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeBBIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:54:37 -0500
X-Google-Smtp-Source: AH8x224hWhy18b1vIE/HfLj9br2wlFwJNoGEfCVliKNd7QUgQqOmF7g9CeO8J17uqefs80XUbYjjlw==
Date: Fri, 2 Feb 2018 09:54:27 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/2] tools/memory-model: clarify the origin/scope of the
 tool name
Message-ID: <20180202085427.GA5456@andrea>
References: <1517486609-10951-1-git-send-email-parri.andrea@gmail.com>
 <Pine.LNX.4.44L0.1802011026250.1677-100000@iolanthe.rowland.org>
 <20180201230941.GT3741@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201230941.GT3741@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 03:09:41PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 01, 2018 at 10:26:50AM -0500, Alan Stern wrote:
> > On Thu, 1 Feb 2018, Andrea Parri wrote:
> > 
> > > Ingo pointed out that:
> > > 
> > >   "The "memory model" name is overly generic, ambiguous and somewhat
> > >    misleading, as we usually mean the virtual memory layout/model
> > >    when we say "memory model". GCC too uses it in that sense [...]"
> > > 
> > > Make it clearer that, in the context of tools/memory-model/, the term
> > > "memory-model" is used as shorthand for "memory consistency model" by
> > > calling out this convention in tools/memory-model/README.
> > > 
> > > Stick to the full name in sources' headers and for the subsystem name.
> > > 
> > > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > 
> > For both patches:
> > 
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Thank you all -- I have queued this and pushed it to my RCU tree on
> branch lkmm.  I did reword the commit log a bit, please see below and
> please let me know if any of my rewordings need halp.
> 
> Andrea, when you resend your second patch, could you please add Alan's
> Acked-by?

You mean in order to integrate Will's suggestion? I was planning to send
that as a separate patch, as suggested by Will: the patch is on its way,
IAC, please let me know if you'd prefer a V2 merging the two changes.

  Andrea


> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit de175b697f71b8e3e6d980b7186b909fee0c4378
> Author: Andrea Parri <parri.andrea@gmail.com>
> Date:   Thu Feb 1 13:03:29 2018 +0100
> 
>     tools/memory-model: Clarify the origin/scope of the tool name
>     
>     Ingo pointed out that:
>     
>       "The "memory model" name is overly generic, ambiguous and somewhat
>        misleading, as we usually mean the virtual memory layout/model
>        when we say "memory model". GCC too uses it in that sense [...]"
>     
>     Make it clearer that tools/memory-model/ uses the term "memory model"
>     is used as shorthand for "memory consistency model" by calling out this
>     convention in tools/memory-model/README.
>     
>     Stick to the original "memory model" term in sources' headers and for
>     the subsystem name.
>     
>     Suggested-by: Ingo Molnar <mingo@kernel.org>
>     Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>     Acked-by: Will Deacon <will.deacon@arm.com>
>     Acked-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
> index 711cbe72d606..db3bd3fc0435 100644
> --- a/tools/memory-model/MAINTAINERS
> +++ b/tools/memory-model/MAINTAINERS
> @@ -1,4 +1,4 @@
> -LINUX KERNEL MEMORY MODEL
> +LINUX KERNEL MEMORY CONSISTENCY MODEL
>  M:	Alan Stern <stern@rowland.harvard.edu>
>  M:	Andrea Parri <parri.andrea@gmail.com>
>  M:	Will Deacon <will.deacon@arm.com>
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index 43ba49492111..91414a49fac5 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -1,15 +1,15 @@
> -			=========================
> -			LINUX KERNEL MEMORY MODEL
> -			=========================
> +		=====================================
> +		LINUX KERNEL MEMORY CONSISTENCY MODEL
> +		=====================================
>  
>  ============
>  INTRODUCTION
>  ============
>  
> -This directory contains the memory model of the Linux kernel, written
> -in the "cat" language and executable by the (externally provided)
> -"herd7" simulator, which exhaustively explores the state space of
> -small litmus tests.
> +This directory contains the memory consistency model (memory model, for
> +short) of the Linux kernel, written in the "cat" language and executable
> +by the externally provided "herd7" simulator, which exhaustively explores
> +the state space of small litmus tests.
>  
>  In addition, the "klitmus7" tool (also externally provided) may be used
>  to convert a litmus test to a Linux kernel module, which in turn allows
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 57112505f5e0..b984bbda01a5 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -11,7 +11,7 @@
>   * which is to appear in ASPLOS 2018.
>   *)
>  
> -"Linux kernel memory model"
> +"Linux-kernel memory consistency model"
>  
>  enum Accesses = 'once (*READ_ONCE,WRITE_ONCE,ACCESS_ONCE*) ||
>  		'release (*smp_store_release*) ||
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 15b7a5dd8a9a..babe2b3b0bb3 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -11,7 +11,7 @@
>   * which is to appear in ASPLOS 2018.
>   *)
>  
> -"Linux kernel memory model"
> +"Linux-kernel memory consistency model"
>  
>  (*
>   * File "lock.cat" handles locks and is experimental.
> 
