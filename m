Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBAPIT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:08:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:50679 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeBAPIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:08:16 -0500
Date: Thu, 1 Feb 2018 16:08:14 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Joe Lawrence <joe.lawrence@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, jpoimboe@redhat.com, jikos@kernel.org,
        Jason Baron <jbaron@akamai.com>, jeyu@kernel.org,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: PATCH v6 0/6] livepatch: Atomic replace feature
In-Reply-To: <1dd714ce-8d11-78b9-51f0-2b71734949e1@redhat.com>
Message-ID: <alpine.LSU.2.21.1802011605450.29533@pobox.suse.cz>
References: <20180125160203.28959-1-pmladek@suse.com> <alpine.LSU.2.21.1802011350200.26656@pobox.suse.cz> <1dd714ce-8d11-78b9-51f0-2b71734949e1@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2018, Joe Lawrence wrote:

> On 02/01/2018 08:49 AM, Miroslav Benes wrote:
> > 
> > Well, one more thing. I think there is a problem with shadow variables. 
> > Similar to callbacks situation. Shadow variables cannot be destroyed the 
> > way it is shown in our samples. Cumulative patches want to preserve 
> > everything as much as possible. If I'm right, it should be mentioned in 
> > the documentation.
> 
> Are you talking about using klp_shadow_free_all() call in a module_exit
> routine?  Yeah, I think in this case, that responsibility would be
> passed to the newly loaded cumulative patch, right?

Yes, but we haven't got an option not to call it here (as with callbacks, 
where we can omit callbacks completely with atomic replace patches). A 
live patch author must be aware of this and use shadow variables 
appropriately.

Miroslav
