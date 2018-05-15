Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeEOSHe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:07:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeEOSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:07:29 -0400
Date: Tue, 15 May 2018 20:07:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
Message-ID: <20180515180710.GQ12217@hirez.programming.kicks-ass.net>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com>
 <20180515175805.GN12217@hirez.programming.kicks-ass.net>
 <20180515180219.GA6612@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515180219.GA6612@bombadil.infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 11:02:19AM -0700, Matthew Wilcox wrote:
> On Tue, May 15, 2018 at 07:58:05PM +0200, Peter Zijlstra wrote:
> > On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
> > > +/*
> > > + * Owner value to indicate the rwsem's owner is not currently known.
> > > + */
> > > +#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1)
> > 
> > It might be nice to comment that this works and relies on having that
> > ANON_OWNER bit set.
> 
> I'd rather change the definition to be ((struct task_struct *)2)
> otherwise this is both reader-owned and anonymously-owned which doesn't
> make much sense.

Works for me.
