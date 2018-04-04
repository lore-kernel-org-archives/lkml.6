Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeDDUE3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:04:29 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33140 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeDDUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:04:28 -0400
X-Google-Smtp-Source: AIpwx4+jyuubJKvf+VfBTztRtrSR8QiLkVjVygI9ovrnF+cHqUXxzbBW0gcDIkOZVXCIQEVWePd79A==
Date: Wed, 4 Apr 2018 23:04:26 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180404200426.GH15783@uranus.lan>
References: <20180404185523.GG15783@uranus.lan>
 <6c784c94-e7a3-7dad-20bc-179a8720e98c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c784c94-e7a3-7dad-20bc-179a8720e98c@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 12:24:33PM -0700, Randy Dunlap wrote:
> 
> > +	pr_warn_once("Non PR_SET_MM_MAP operations are deprecated\n");
> > +	return -EINVAL;
> >  }
> 
> I'm not against removing such functionality, but I think that it's more than
> "deprecated."  It's gone.

At first this was plain warning without code removal but I've
been advised that dropping it completely may be a better idea
which I agree https://lkml.org/lkml/2018/4/4/31 Or you mean the
warning message itsef? We aready have similars, for example
in kernel/auditfilter.c

printk(KERN_ERR "AUDIT_POSSIBLE is deprecated\n");
