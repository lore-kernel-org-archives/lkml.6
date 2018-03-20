Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeCTNcR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:32:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753344AbeCTNaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:30:16 -0400
Date: Tue, 20 Mar 2018 14:30:10 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
In-Reply-To: <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1803201425090.1312@pobox.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com> <20180307082039.10196-6-pmladek@suse.com> <20180313224613.sdkdkcvhpqv54s6c@treble> <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz> <20180319214324.riyp233trtfxbeto@treble>
 <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > I don't know, does anybody really care about this case (patching on top
> > of a disabled patch)?  It just adds to the crazy matrix of possible
> > scenarios we have to keep in our heads, which means more bugs, for very
> > little (hypothetical) gain.
> 
> It depends if the we remove the replaced patches or not. If they are
> removed then replacing disabled patches is rather trivial from both
> coding and understanding side.

I agree. Since we already have the code, there is no point not to have the 
feature. It is not that complicated after all.
 
> I am going to add this as a separate patch as well. Let's discuss
> it with the code.
> 
> 
> > > White the atomic replace could make things easier for both developers
> > > and users.
> > 
> > I agree that atomic replace is a useful feature and I'm not arguing
> > against it, so maybe I missed your point?
> 
> Your suggestion allows easier code but it reduces the advantages of
> the atomic replace feature. We would achieve almost the same results
> with a normal livepatch where the functions behave like in
> the original code.
> 
> Also removing replaced patches can be seen as a clean up after
> each patch. It might be more code but the target system might be
> easier to debug. Also we do not need to mind about various
> disable scenarios.

I agree with this as well.

Yes, it was a bit painful to review, but I was quite content with the 
result. I don't want to go halfway and be stuck with NOPs when it is 
not complicated to remove them completely after the transition. It'd be 
odd in my opinion.

Regards,
Miroslav
