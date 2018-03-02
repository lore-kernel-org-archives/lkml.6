Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425261AbeCBJFe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:05:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53392 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425209AbeCBJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:05:19 -0500
Date: Fri, 2 Mar 2018 10:04:54 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [BUG] lock_parent() breakage when used from shrink_dentry_list()
 (was Re: [PATCH v2 6/6] fs/dcache: Avoid remaining try_lock loop in
 shrink_dentry_list())
Message-ID: <20180302090453.ial6getrlauragft@linutronix.de>
References: <20180222235025.28662-7-john.ogness@linutronix.de>
 <20180223035814.GZ30522@ZenIV.linux.org.uk>
 <20180223040814.GA30522@ZenIV.linux.org.uk>
 <87h8q7erlo.fsf@linutronix.de>
 <20180223150928.GC30522@ZenIV.linux.org.uk>
 <20180223174216.GD30522@ZenIV.linux.org.uk>
 <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
 <20180225073950.GI30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180225073950.GI30522@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-25 07:40:05 [+0000], Al Viro wrote:
> FWIW, a variant of that series is in #work.dcache; it's
> almost certainly not the final (I want to clean the things up
> and probably reorder them as well) and it needs one hell of
> profiling and review.  It seems to work, and I don't see any
> obvious performance regressions (everything seems to be within
> normal noise), but I'd like it beaten up a lot more.

If you have something in mind, I could fire up something.

> I'll play with cleaning up and reordering tomorrow after I get
> some sleep.  In the meanwhile, the current state of that set is at
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache

I've put it in -RT, let it do some upgrades and other things and nothing
bad happened so far.

Sebastian
