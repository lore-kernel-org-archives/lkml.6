Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeDDV3J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:29:09 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40671 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeDDV3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:29:08 -0400
X-Google-Smtp-Source: AIpwx49sKrS7e1Q3Fggzcf97An1ULezChW+qQ8zIqPpXW9Sq+lglKrj6UDcybbz76AOtrocOEKOFig==
Date: Thu, 5 Apr 2018 00:29:06 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180404212906.GJ15783@uranus.lan>
References: <20180404185523.GG15783@uranus.lan>
 <6c784c94-e7a3-7dad-20bc-179a8720e98c@infradead.org>
 <20180404200426.GH15783@uranus.lan>
 <467373a7-8b2b-971c-4e62-7fae043c96fe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467373a7-8b2b-971c-4e62-7fae043c96fe@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 01:53:08PM -0700, Randy Dunlap wrote:
> > 
> > At first this was plain warning without code removal but I've
> > been advised that dropping it completely may be a better idea
> > which I agree https://lkml.org/lkml/2018/4/4/31 Or you mean the
> > warning message itsef? We aready have similars, for example
> > in kernel/auditfilter.c
> 
> The traditional way (eons ago) to deprecate something was to add a
> printk() and then delete the feature a few years later.
> Still, I have no objection to dropping that prctl.
> 
> Sorry if I wasn't clear.  I was objecting to the "language", i.e., to the
> word "deprecated."  Deprecated means frowned on, advised against, etc.
> It does not mean "deleted."

True. I remember this rule of deprecation. But when I dropped the
code I though which message to put here (or should I put it at
all) and since "deprecated" was the first word came into mind
I decided to grep sources, the result you see by its own :)

> 
> > printk(KERN_ERR "AUDIT_POSSIBLE is deprecated\n");
> 
> Yeah, that one's wrong also.  :)

So, maybe just get rid of any warning message at all?
