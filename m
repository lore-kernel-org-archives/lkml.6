Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeB1NU0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:20:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:38680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752267AbeB1NUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:20:25 -0500
Date: Wed, 28 Feb 2018 14:20:22 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Subject: Re: [PATCH v0 2/3] livepatch: update documentation/samples for
 callbacks
In-Reply-To: <f87dbd4e-7262-5c90-0a5f-a54e4d0af20d@redhat.com>
Message-ID: <alpine.LSU.2.21.1802271600520.19255@pobox.suse.cz>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com> <1519421630-12025-3-git-send-email-joe.lawrence@redhat.com> <alpine.LSU.2.21.1802271324370.19255@pobox.suse.cz> <f87dbd4e-7262-5c90-0a5f-a54e4d0af20d@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018, Joe Lawrence wrote:

> On 02/27/2018 07:36 AM, Miroslav Benes wrote:
> > On Fri, 23 Feb 2018, Joe Lawrence wrote:
> > 
> >> [ ... snip ... ]
> >>  
> >> +If a livepatch is replaced by a cumulative patch, then only the
> >> +callbacks belonging to the cumulative patch will be executed.  This
> >> +simplifies the livepatching core for it is the responsibility of the
> >> +cumulative patch to safely revert whatever needs to be reverted.  See
> >> +Documentation/livepatch/cumulative.txt for more information on such
> >> +patches.
> > 
> > s/cumulative/atomic replace/ almost everywhere?
> > 
> > 'Documentation/livepatch/cumulative.txt' should be 
> > 'Documentation/livepatch/cumulative-patches.txt' and we may rename it 
> > atomic-replace-patches.txt. I don't know. Cumulative patches forms a 
> > subset of atomic replace patches in my understanding. The feature itself 
> > is more general. Even if practically used for cumulative patches only. But 
> > it is for you and Petr to decide.
> 
> Hi Miroslav,
> 
> Thanks for reviewing!
> 
> I guess I'm a little confused about the distinction here.
> 
> I understood a "cumulative-patch" to mean that it would contain the sum
> of all changes.  So instead of this:
> 
>   patch 1 = A
> + patch 2 =     B
> + patch 3 =         C
> -----------------------
>   net     = A + B + C
> 
> We can group all of the changes together into a single cumulative-patch
> for the same net effect:
> 
>   patch 1 = A               -replaced by-
>   patch 2 = A + B             -replaced by-
>   patch 3 = A + B + C

Yes.
 
> I assumed this would also mean to include any reverted changes as well.
> So in the example above, if change C needed to be reverted, then:
> 
>   patch 4 = A + B
> 
> and that would still be considered a "cumulative-patch".

Ah, ok. This is where we differ. I didn't consider this to be a cumulative 
patch. But I understand your reasoning. 

Miroslav
