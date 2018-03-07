Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965155AbeCGUUj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:20:39 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:42818 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934991AbeCGUUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:20:36 -0500
X-Google-Smtp-Source: AG47ELueqdgY7KM8/7hLCYDS1mHC47ZBbQj0llWO+JNqjxFqKn65RiLBeL8Sh2O1gUVkuQpeAHlEiUptCGRYURJDNp8=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180307.124500.1863183408172828694.davem@davemloft.net>
References: <CAHC9VhST6LhUj6H28Ws96EaRzkp4FN91h46iGKpd2Yk44H7Jpw@mail.gmail.com>
 <20180307.114139.680250568317481879.davem@davemloft.net> <CAHC9VhTUORhy1dADEza8tr4DW6gTjqxXyg0wb0cwFCRy+WRkMQ@mail.gmail.com>
 <20180307.124500.1863183408172828694.davem@davemloft.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Mar 2018 15:20:33 -0500
Message-ID: <CAHC9VhRQb50EYD6BVTxNv2x=S_tTLq57OZBsWbXFdfJEunNUiA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the net-next tree
To: David Miller <davem@davemloft.net>
Cc: lucien.xin@gmail.com, sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        richard_c_haines@btinternet.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 12:45 PM, David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Wed, 7 Mar 2018 12:27:52 -0500
>
>> I'm not sure we could have cleanly separated the core network stack
>> changes from the rest of the SELinux/SCTP enablement, regardless it's
>> a bit late at this point.  The only other thought would have been to
>> simply push Xin Long's cleanup patches until after the next merge
>> window, but that would only be worth considering if they truly were
>> just cleanup patches, and even then it doesn't seem very fair to Xin
>> Long to have to wait.
>
> I think you wanted to have more integration, rather than less.

I'm not quite sure where you are going here, I think we *all* want
integration - subtrees merge patches/trees, Linus merges subtrees,
etc. - and I don't believe I've said anything to the contrary.

> What others have done in the past, is they simply pull my networking
> tree into their's.

I only base the SELinux and audit trees on Linus' tree.  Perhaps I'm
wrong, but a quick look at net-next makes me believe you do the same.

I think it is also worth mentioning that the SELinux/SCTP patches have
been in the selinux/next branch for several days now; from what I can
tell they predate these net-next cleanup patches.  Not that it
matters, I just don't believe that pulling net-next would have solved
this problem; I suppose the right thing would have been for net-next
to pull selinux/next, yes?

> I never rebase, ever.

I've learned that saying "never" (or "never X, ever" in this case) is
a recipe for disaster, but if it works for you, go for it.

FWIW, I try to avoid rebases as much as possible; it's the nuclear
option as far as I'm concerned and the only time I regularly rebase
the SELinux and audit trees is after the merge window (e.g. we need
something in -rc1, or we are simply too far out of date).

Looking quickly at net-next, it looks like net-next/master is
refreshed/rebased on a regular basis too (it contains the
selinux-pr-20180130 tag)... and perhaps rebase is a term you don't
want to use, but I think we are on the same page here.

> My tree often goes in reasonable early in the merge window.

Generally speaking I send my pull request to Linus early in the merge
window too.  It obviously tends to vary on when he does the pull, but
we generally haven't had any major problems.

> So you would only have to wait until my tree went in before
> sending your pull request.

So you would want me to rebase selinux/next on top of Linus' tree in
the middle of the merge window?  I'm sure that isn't what you meant,
but that's how I keep reading the above ... which can't be right,
because in my experience that's one way to piss off Linus.  Help me
understand what you are saying.

> That's really the way to handle something like this.

-- 
paul moore
www.paul-moore.com
