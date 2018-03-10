Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeCJXgp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 18:36:45 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35697 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeCJXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 18:36:44 -0500
X-Google-Smtp-Source: AG47ELu8mbyS5N6vIH9k7WFIonHRcRtY4rQUUBB3XNrKeceB0wUMKLvb7Z5fLNYhV5esHAv2W++STg==
Date: Sun, 11 Mar 2018 00:36:36 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: Simplifying our RCU models
Message-ID: <20180310233636.GA3602@andrea>
References: <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
 <20180306203906.GA3918@linux.vnet.ibm.com>
 <20180307155444.GA10367@linux.vnet.ibm.com>
 <20180308211950.GA3202@andrea>
 <20180309005145.GZ3918@linux.vnet.ibm.com>
 <20180309095520.GA5079@andrea>
 <20180310160409.GF3918@linux.vnet.ibm.com>
 <20180310162946.GA7548@andrea>
 <20180310224726.GI3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310224726.GI3918@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2018 at 02:47:26PM -0800, Paul E. McKenney wrote:
> On Sat, Mar 10, 2018 at 05:29:46PM +0100, Andrea Parri wrote:
> > On Sat, Mar 10, 2018 at 08:04:09AM -0800, Paul E. McKenney wrote:
> > > On Fri, Mar 09, 2018 at 10:55:20AM +0100, Andrea Parri wrote:
> > > > On Thu, Mar 08, 2018 at 04:51:45PM -0800, Paul E. McKenney wrote:
> > > > > [ Dropping CC ]
> > > > 
> > > > [...]
> > > > 
> > > > > > > Ah, and any thoughts on how best to get feedback from the various people
> > > > > > > who would need to reprogram their fingers?  Or is everyone already on
> > > > > > > board with changing these various names?
> > > > > > 
> > > > > > Experienced should get there in a week (gcc help); newbies would (have to)
> > > > > > rely on either on _properly updated_ documentation or weeks/months of code
> > > > > > paging; scripts do the renaming.  What am I missing?
> > > > > 
> > > > > Linus's reply to my email?  ;-)
> > > > > 
> > > > > More seriously, people who use RCU only occasionally would likely
> > > > > have more difficulty adjusting.  "What the heck is the new name of
> > > > > synchronize_rcu()???  Oh forget it, I will just use a lock.  My system
> > > > > isn't all that large anyway!!!"
> > > > 
> > > > I did miss this group of people.  Thanks,
> > > 
> > > I should hasten to add that we have changed the names of RCU-related APIs
> > > before, including synchronize_kernel() -> synchronize_sched() back in
> > > the day and SLAB_DESTROY_BY_RCU -> SLAB_TYPESAFE_BY_RCU more recently.
> > > There was some discussion around this last change, and one of the things
> > > we did to help was to add big comments relating the old and new names.
> > > That way, someone grepping for the old name can easily find the new name.
> > > 
> > > But it does cause some churn.  So name changes can be a good thing,
> > > but we don't undertake them lightly.  That said, it has been more than
> > > a decades since the last name change in the core RCU API, so it is not
> > > too early to consider it.  As Linus says, however, we won't be changing
> > > just for change's sake.  ;-)
> > 
> > Absolutely!
> > 
> > And thank you for these remarks (you know, certainly, I was not properly
> > "watching" RCU commits a decade ago or so... ;).  But maybe other people
> > can find these remarks interesting: please feel free to forward to LKML.
> 
> I should probasbly also add that the name change from SLAB_DESTROY_BY_RCU to
> SLAB_TYPESAFE_BY_RCU was motivated by several groups misinterpreting the
> old name, and thus spending months each chasing weird race conditions...

[ Bringing back CC ]

Thanks,
  Andrea


> 
> 							Thanx, Paul
> 
