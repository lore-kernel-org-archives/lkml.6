Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbeEOSGE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:06:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbeEOSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:06:00 -0400
Date: Tue, 15 May 2018 20:05:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
Message-ID: <20180515180549.GP12217@hirez.programming.kicks-ass.net>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com>
 <20180515175805.GN12217@hirez.programming.kicks-ass.net>
 <1baa1a1a-a4a7-d706-8c01-5ff6a8757f97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1baa1a1a-a4a7-d706-8c01-5ff6a8757f97@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 02:02:00PM -0400, Waiman Long wrote:
> On 05/15/2018 01:58 PM, Peter Zijlstra wrote:
> > On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
> >> +/*
> >> + * Owner value to indicate the rwsem's owner is not currently known.
> >> + */
> >> +#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1)
> > It might be nice to comment that this works and relies on having that
> > ANON_OWNER bit set.
> 
> I am just trying not to expose internal working of rwsem, but I can
> document that one of the bits is the real deal without specifying which one.

Thing is, you don't want someone changing this without knowing about
that one magic bit. It doesn't hurt to be explicit here.

Also, do we want -1L instead of a -1 literal?
