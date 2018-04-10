Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeDJRrc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:47:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751505AbeDJRra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:47:30 -0400
Date: Tue, 10 Apr 2018 12:47:29 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Jiri Kosina <jikos@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180410174729.nsamiif73pynfla4@treble>
References: <20180319214324.riyp233trtfxbeto@treble>
 <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
 <20180320201502.2skkk3ld4zk2dxwg@treble>
 <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz>
 <20180323224410.vuq5cabfprqhd6ej@treble>
 <20180326101107.bbloeh5l276on7uz@pathway.suse.cz>
 <20180406195049.dtfebzfdkbvv6yex@treble>
 <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
 <alpine.LSU.2.21.1804101355050.8026@pobox.suse.cz>
 <127f954c-88c6-30cb-bf14-7ab2fad70158@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <127f954c-88c6-30cb-bf14-7ab2fad70158@virtuozzo.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I agree here. Practically we use only cumulative replacement patches at
> > SUSE. So with that in mind I don't care about the stacking much. But, it
> > may make sense for someone else. Evgenii mentioned they used it for
> > hotfixes. Therefore I'm reluctant to remove it completely.
> 
> Well, it was convenient in some cases to provide a hot fix for a given bug
> on top of our official cumulative patch. So far, such fixes were only used
> on a few of the customers' machines (where they were needed ASAP). It just
> made it easier to see where is the common set of fixes and where is the
> customer-specific addition.
> 
> I think, we can use cumulative patches in such cases too without much
> additional effort. For example, we can encode the distinction (base set of
> fixes + addition) in the module name or somewhere else.
> 
> So, I think, it is fine for us, if stacking support is removed. Especially
> if that makes the implementation of livepatch less complex and more
> reliable.

Just to clarify, I think we are just proposing the removal of the
enforcement of the stacking order.  We will still allow multiple
non-replace patches to be applied.  We just won't enforce which patches
can be disabled/removed at any given time.

So I think your old way of doing things (individual unrelated patches on
top of a cumulative patch) would still work.

-- 
Josh
