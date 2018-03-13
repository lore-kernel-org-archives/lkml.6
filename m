Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932523AbeCMAh5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:37:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59758 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeCMAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:37:53 -0400
Date: Tue, 13 Mar 2018 00:37:51 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent()
 breakage when used from shrink_dentry_list())
Message-ID: <20180313003751.GT30522@ZenIV.linux.org.uk>
References: <20180223201317.GG30522@ZenIV.linux.org.uk>
 <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
 <20180224002248.GH30522@ZenIV.linux.org.uk>
 <20180225073950.GI30522@ZenIV.linux.org.uk>
 <87bmgbnhar.fsf_-_@linutronix.de>
 <20180312191351.GN30522@ZenIV.linux.org.uk>
 <877eqhcab3.fsf@xmission.com>
 <20180312203916.GQ30522@ZenIV.linux.org.uk>
 <87woygan6p.fsf@xmission.com>
 <87tvtk97i8.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvtk97i8.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 06:52:31PM -0500, Eric W. Biederman wrote:

> Ah.  I see now there is now the s_roots list that handles
> that bit of strangeness.
> 
> So one path is to simply remove the heuristic from
> path_connected.
> 
> Another path is to have nfsv2 and nfsv3 not set s_root at all.
> Leaving the heuristic working for the rest of the filesystems,
> and generally simplifying the code.
> 
> Something like the diff below I should think.

> +	/* Leave nfsv2 and nfsv3 s_root == NULL */

Now, grep fs/super.c for s_root.  Or try to boot it, for that
matter...
