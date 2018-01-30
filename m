Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeA3TYR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:24:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752621AbeA3TYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:24:15 -0500
Subject: Re: [PATCH v5 0/3] livepatch: introduce atomic replace
To: Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org, mbenes@suse.cz
References: <cover.1515786085.git.jbaron@akamai.com>
 <c9064c38-9f04-f6d3-c28b-593a0bb74488@virtuozzo.com>
 <86cac2eb-0de4-bae7-f633-5ad03297880d@akamai.com>
 <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
 <adf9b91f-e9e9-9d9a-8b28-5754c16c0782@virtuozzo.com>
 <20180130140303.6xmjgnbdemovzif5@pathway.suse.cz>
 <54c06e8c-2749-7c53-5a44-575c0ba69551@virtuozzo.com>
 <af3f596d-c3cc-1096-8670-352ab66fc87f@akamai.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <e8c0328a-b7c7-3e8d-0cd0-fe0c608026d8@redhat.com>
Date: Tue, 30 Jan 2018 14:24:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <af3f596d-c3cc-1096-8670-352ab66fc87f@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 01:19 PM, Jason Baron wrote:
> [ ... snip ... ]
>
> Our main interest in 'atomic replace' is simply to make sure that
> cumulative patches work as expected in that they 'replace' any prior
> patches. We have an interest primarily in being able to apply patches
> from the stable trees via livepatch. I think the current situation with
> respect to 'replace' and callbacks is fine for us as well, but could
> change based on more experience with livepatch.

Well the callback implementation was based somewhat on theoretical
usage..  it was inspired by the kpatch macros that you talk about below,
in which we had a few specific use-cases.  Converting (un)patch
notifiers to the livepatch model presented additional callback
locations, and as such we ended up with pre-patch, post-patch,
pre-unpatch and post-unpatch callbacks.  Hopefully we'll get a better
idea of their worth as we gain experience using them.  At this point in
time I would suggest keeping it as simple and safe as possible.  :)

> As an aside I was just wondering how you are making use of the callbacks
> using the tool you mentioned (that is based on kpatch)? I see in the
> upstream kpatch that there are hooks such as: 'KPATCH_LOAD_HOOK(fn)' and
> 'KPATCH_UNLOAD_HOOK(fn)'. However, these are specific to 'kpatch' (as
> opposed to livepatch), and I do not see these sort of macros for the
> recently introduced livepatch callbacks. It seems it would be easy
> enough to add similar hooks for the livepatch callbacks. I was thinking
> of writing such a patch, but was wondering if there was an existing
> solution?

I've got a work in progress PR for this very feature:
https://github.com/dynup/kpatch/pull/780

Evgenii has already provided some helpful feedback. Another set of
eyes/testing would be appreciated!

Regards,

-- Joe
