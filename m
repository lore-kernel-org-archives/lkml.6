Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeDFWKx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:10:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751442AbeDFWKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:10:51 -0400
Date: Fri, 6 Apr 2018 17:10:50 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] livepatch: Atomic replace feature
Message-ID: <20180406221050.y7avkxjt4e23jojc@treble>
References: <20180323120028.31451-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180323120028.31451-1-pmladek@suse.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 01:00:20PM +0100, Petr Mladek wrote:
> The atomic replace allows to create cumulative patches. They
> are useful when you maintain many livepatches and want to remove
> one that is lower on the stack. In addition it is very useful when
> more patches touch the same function and there are dependencies
> between them.
> 
> This version is heavily refactored and cleaned based on feedback from Josh.
> There are actually only three functional changes.
> 
> It still passes the first draft of the selfttest from Joe that can
> be found at https://lkml.kernel.org/r/1520881024-29386-1-git-send-email-joe.lawrence@redhat.com
> 
> 
> Changes against v10:
> 
>   + Bug fixes and functional changes:
>     + Handle Nops in klp_ftrace_handled() to avoid infinite loop [Mirek]
>     + Really add dynamically allocated klp_object into the list [Petr]
>     + Clear patch->replace when transition finishes [Josh]
> 
>   + Refactoring and clean up [Josh]:
>     + Replace enum types with bools
>     + Avoid using ERR_PTR
>     + Remove too paranoid warnings
>     + Distinguish registered patches by a flag instead of a list
>     + Squash some functions
>     + Update comments, documentation, and commit messages
>     + Squashed and split patches to do more controversial changes later

Thanks again for all the changes.  I think I like the general direction
of the patches now, even some of the later ones ;-)

Along with the minor comments from my other emails, I still have the
question about "does it make sense to enforce a stack anymore".

And of course I would really like to see the selftests in place first.

-- 
Josh
