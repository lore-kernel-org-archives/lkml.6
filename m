Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeDDUx0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:53:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52326 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeDDUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:53:24 -0400
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
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <467373a7-8b2b-971c-4e62-7fae043c96fe@infradead.org>
Date: Wed, 4 Apr 2018 13:53:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404200426.GH15783@uranus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 01:04 PM, Cyrill Gorcunov wrote:
> On Wed, Apr 04, 2018 at 12:24:33PM -0700, Randy Dunlap wrote:
>>
>>> +	pr_warn_once("Non PR_SET_MM_MAP operations are deprecated\n");
>>> +	return -EINVAL;
>>>  }
>>
>> I'm not against removing such functionality, but I think that it's more than
>> "deprecated."  It's gone.
> 
> At first this was plain warning without code removal but I've
> been advised that dropping it completely may be a better idea
> which I agree https://lkml.org/lkml/2018/4/4/31 Or you mean the
> warning message itsef? We aready have similars, for example
> in kernel/auditfilter.c

The traditional way (eons ago) to deprecate something was to add a
printk() and then delete the feature a few years later.
Still, I have no objection to dropping that prctl.

Sorry if I wasn't clear.  I was objecting to the "language", i.e., to the
word "deprecated."  Deprecated means frowned on, advised against, etc.
It does not mean "deleted."

> printk(KERN_ERR "AUDIT_POSSIBLE is deprecated\n");

Yeah, that one's wrong also.  :)


-- 
~Randy
