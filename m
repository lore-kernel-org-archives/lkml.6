Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDRWmz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 18:42:55 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40882 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRWmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 18:42:54 -0400
X-Google-Smtp-Source: AIpwx4+1Y4GOcA0PhsvfOpHVUukIZq8Se+c6EC4FDLdfGJdX+4PfcFHPoAyxCHwLSb6Sg+Rg3GJIvA==
Date: Thu, 19 Apr 2018 01:42:51 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH v2] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180418224251.GI19578@uranus.lan>
References: <20180405182651.GM15783@uranus.lan>
 <20180418152820.e8f317534c01696d4835a40f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418152820.e8f317534c01696d4835a40f@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 03:28:20PM -0700, Andrew Morton wrote:
> On Thu, 5 Apr 2018 21:26:51 +0300 Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> 
> > Subject: [PATCH v2] prctl: Deprecate non PR_SET_MM_MAP operations
> 
> s/Deprecate/remove/ !

Thanks!

> > 
> > Googling didn't reveal some other users of this operation
> > so I think it should be safe to remove this interface.
> 
> It does seem a bit sudden.  We could just add a "this interface is
> scheduled for removal" warning, then delete the code for real later in
> the year. To give people time to migrate or to complain to us.

Yes, I remember this rule of deprecation but taking into account
how special this code is (and I spent significant amount of time
trying to find a real example of its usage outside of criu)
I think it should be safe to simply remove it. Surely I won't
ever do this with some common syscall.
