Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeCBWIH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:08:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751605AbeCBWIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:08:06 -0500
Subject: Re: [PATCH v0 2/3] livepatch: update documentation/samples for
 callbacks
To: Petr Mladek <pmladek@suse.com>
Cc: Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
 <1519421630-12025-3-git-send-email-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1802271324370.19255@pobox.suse.cz>
 <f87dbd4e-7262-5c90-0a5f-a54e4d0af20d@redhat.com>
 <20180302111111.f6tt2rnwa4nnbswh@pathway.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <069122bb-15e6-61f6-e98c-07b356a12942@redhat.com>
Date: Fri, 2 Mar 2018 17:08:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180302111111.f6tt2rnwa4nnbswh@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 06:11 AM, Petr Mladek wrote:
> On Tue 2018-02-27 09:58:40, Joe Lawrence wrote:
>> In my mind, atomic replace is the mechanism that forces patching to be
>> cumulative.  Perhaps this is too strict?  Are there other use-cases for
>> atomic-replace?
> 
> Jason talked about using the atomic replace to get rid of any
> existing livepatches and adding another changes instead. The changes
> in the old and the new patch might be unrelated. They simply do
> not want to mind what was there before. The term "atomic replace"
> fits perfectly for this usecase.
> 
> My understanding is that cumulative patches do similar thing.
> But the old and new patches should be related. In particular,
> any new patch should include most changes from the older one.
> The only exception is when an old change was wrong and we do
> not want it anymore.

Yes, I can see the semantic difference between these cases.  In my mind,
I am tainted by an understanding of the implementation... so I lazily
optimized both cases under a common terminology.

That said, you're right about potential confusion, so I'll update the
example and docs to remove references to "cumulative" and just call it
"atomic-replace" :)

> PS: I did not added these patches to v9 of the atomic replace
> patchset. It was already big enough. And I hope that v9 might
> be final. In addition, there are no conflicts on the touched
> files side.

I can continue to update as a separate patchset if that helps the the
other patchset reach a quicker conclusion.

As far as licensing, I don't mind modifying for SPDX tags if that's the
way we want to go.

Thanks,

-- Joe
