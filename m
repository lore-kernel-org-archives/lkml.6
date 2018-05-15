Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeEOOAu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:00:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeEOOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:00:49 -0400
Date: Tue, 15 May 2018 07:00:43 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v2 2/2] locking/percpu-rwsem: Mark rwsem as
 non-spinnable in percpu_rwsem_release()
Message-ID: <20180515140043.GH31599@bombadil.infradead.org>
References: <1526326267-22501-1-git-send-email-longman@redhat.com>
 <1526326267-22501-3-git-send-email-longman@redhat.com>
 <20180515085111.GW12217@hirez.programming.kicks-ass.net>
 <db033cf3-1931-1821-61ad-5a46f3af5b30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db033cf3-1931-1821-61ad-5a46f3af5b30@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:57:44AM -0400, Waiman Long wrote:
> > Afaict the whole .owner=NULL thing in release already stops the spinners
> > dead, and the above 'fixes' the debug splat. And this avoids exposing
> > that horrible interface and keeps the mucking private to
> > rwsem/percpu_rwsem.
> 
> Actually setting owner to NULL does not stop spinning. The code just
> assume that the lock is going to be freed and spin in the outer loop. We
> need some special value to indicate that spinning should be stopped. How
> about just exposing a special value for that in linux/rwsem.h? Any
> suggestion for a good name?

RWSEM_NO_OWNER
