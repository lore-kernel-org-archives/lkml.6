Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDDVhE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:37:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeDDVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:37:03 -0400
Subject: Re: [PATCH] prctl: Deprecate non PR_SET_MM_MAP operations
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20180404185523.GG15783@uranus.lan>
 <6c784c94-e7a3-7dad-20bc-179a8720e98c@infradead.org>
 <20180404200426.GH15783@uranus.lan>
 <467373a7-8b2b-971c-4e62-7fae043c96fe@infradead.org>
 <20180404212906.GJ15783@uranus.lan>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f8669ffd-c176-3dd5-0731-e49494ae7b6f@infradead.org>
Date: Wed, 4 Apr 2018 14:36:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404212906.GJ15783@uranus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 02:29 PM, Cyrill Gorcunov wrote:
> On Wed, Apr 04, 2018 at 01:53:08PM -0700, Randy Dunlap wrote:
>>>
>>> At first this was plain warning without code removal but I've
>>> been advised that dropping it completely may be a better idea
>>> which I agree https://lkml.org/lkml/2018/4/4/31 Or you mean the
>>> warning message itsef? We aready have similars, for example
>>> in kernel/auditfilter.c
>>
>> The traditional way (eons ago) to deprecate something was to add a
>> printk() and then delete the feature a few years later.
>> Still, I have no objection to dropping that prctl.
>>
>> Sorry if I wasn't clear.  I was objecting to the "language", i.e., to the
>> word "deprecated."  Deprecated means frowned on, advised against, etc.
>> It does not mean "deleted."
> 
> True. I remember this rule of deprecation. But when I dropped the
> code I though which message to put here (or should I put it at
> all) and since "deprecated" was the first word came into mind
> I decided to grep sources, the result you see by its own :)
> 
>>
>>> printk(KERN_ERR "AUDIT_POSSIBLE is deprecated\n");
>>
>> Yeah, that one's wrong also.  :)
> 
> So, maybe just get rid of any warning message at all?

That would be OK since -EINVAL or something similar is being returned.

-- 
~Randy
