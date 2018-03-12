Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932289AbeCLWOm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:14:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47558 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:14:40 -0400
Date: Mon, 12 Mar 2018 15:14:16 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage
 when used from shrink_dentry_list())
In-Reply-To: <20180312191351.GN30522@ZenIV.linux.org.uk>
Message-ID: <alpine.DEB.2.21.1803121511090.2041@nanos.tec.linutronix.de>
References: <20180223035814.GZ30522@ZenIV.linux.org.uk> <20180223040814.GA30522@ZenIV.linux.org.uk> <87h8q7erlo.fsf@linutronix.de> <20180223150928.GC30522@ZenIV.linux.org.uk> <20180223174216.GD30522@ZenIV.linux.org.uk> <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com> <20180224002248.GH30522@ZenIV.linux.org.uk> <20180225073950.GI30522@ZenIV.linux.org.uk> <87bmgbnhar.fsf_-_@linutronix.de> <20180312191351.GN30522@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018, Al Viro wrote:
> On Tue, Feb 27, 2018 at 06:16:28AM +0100, John Ogness wrote:
> What we get out of that is
> 	a) much saner semantics for d_move() et.al.
> 	b) saner behaviour of d_path() (see above)
> 	c) dentry can be IS_ROOT only if it has been
> such all along; that simplifies the hell out of analysis.

Nice.

> FWIW, there's another trylock loop on dentries - one in
> autofs get_next_positive_dentry().  Any plans re dealing
> with that one?

It's on our list and we wanted to wait for the final resolution of dcache
before tackling it. Do you have any immediate ide about that?

> I'd spent the last couple of weeks (when not being too sick
> for any work) going through dcache.c and related code; hopefully
> this time I will get the documentation into postable shape ;-/

Documentation is surely welcome. Paging that code back in is a mindboggling
exercise.

Thanks,

	tglx
