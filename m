Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeDKH4L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:56:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbeDKH4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:56:09 -0400
Date: Wed, 11 Apr 2018 09:56:05 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
In-Reply-To: <20180410174729.nsamiif73pynfla4@treble>
Message-ID: <alpine.LSU.2.21.1804110949310.28885@pobox.suse.cz>
References: <20180319214324.riyp233trtfxbeto@treble> <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz> <20180320201502.2skkk3ld4zk2dxwg@treble> <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz> <20180323224410.vuq5cabfprqhd6ej@treble>
 <20180326101107.bbloeh5l276on7uz@pathway.suse.cz> <20180406195049.dtfebzfdkbvv6yex@treble> <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz> <alpine.LSU.2.21.1804101355050.8026@pobox.suse.cz> <127f954c-88c6-30cb-bf14-7ab2fad70158@virtuozzo.com>
 <20180410174729.nsamiif73pynfla4@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018, Josh Poimboeuf wrote:

> > > I agree here. Practically we use only cumulative replacement patches at
> > > SUSE. So with that in mind I don't care about the stacking much. But, it
> > > may make sense for someone else. Evgenii mentioned they used it for
> > > hotfixes. Therefore I'm reluctant to remove it completely.
> > 
> > Well, it was convenient in some cases to provide a hot fix for a given bug
> > on top of our official cumulative patch. So far, such fixes were only used
> > on a few of the customers' machines (where they were needed ASAP). It just
> > made it easier to see where is the common set of fixes and where is the
> > customer-specific addition.
> > 
> > I think, we can use cumulative patches in such cases too without much
> > additional effort. For example, we can encode the distinction (base set of
> > fixes + addition) in the module name or somewhere else.
> > 
> > So, I think, it is fine for us, if stacking support is removed. Especially
> > if that makes the implementation of livepatch less complex and more
> > reliable.
> 
> Just to clarify, I think we are just proposing the removal of the
> enforcement of the stacking order.  We will still allow multiple
> non-replace patches to be applied.  We just won't enforce which patches
> can be disabled/removed at any given time.

Heh, so I misunderstood. I thought you were talking about the removal of 
the stacking. Now it makes more sense.
 
> So I think your old way of doing things (individual unrelated patches on
> top of a cumulative patch) would still work.

Yes. On the other hand the user needs to be even more careful, so I'd 
expect an update of documentation with the removal :).

Miroslav
