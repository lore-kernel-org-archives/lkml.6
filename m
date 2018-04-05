Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDETwA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:52:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50884 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbeDETv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:51:59 -0400
X-Google-Smtp-Source: AIpwx4/SF6r/rIsm8LLjETvHa5AAVUCqx/NwGK2tLiSO65E8NhNxU7qD7IDPbsjy4HpSDp1TyL7zEA==
Date: Thu, 5 Apr 2018 22:51:56 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH v2] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180405195156.GN15783@uranus.lan>
References: <20180405182651.GM15783@uranus.lan>
 <20180405185650.GR6312@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405185650.GR6312@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 08:56:50PM +0200, Michal Hocko wrote:
> On Thu 05-04-18 21:26:51, Cyrill Gorcunov wrote:
> > An ability to manipulate mm_struct fields was introduced in
> > sake of CRIU in first place. Later we provide more suitable
> > and safe operation PR_SET_MM_MAP where all fields to be modifed
> > are passed in one structure which allows us to make more detailed
> > verification.
> 
> I hope this will serve as a memento for future single-user APIs
> proposals. The whole thing was a bad idea since the beginning.

It wasn't a bad idea at all, kernel evolves with time and the
first version of the api served as it should (actually a number
of things get involved like user-namespaces, mm reworks and
such things). So no, it wasn't bad. Rather to make it more
suitable we provided a second version of the api.

> > Still old interface remains present for compatibility reason
> > though CRIU itself already switched to PR_SET_MM_MAP on its
> > own long ago.
> > 
> > Googling didn't reveal some other users of this operation
> > so I think it should be safe to remove this interface.
> > 
> > v2:
> >  - Improve warning message
> >  - Drop redundant args check
> > 
> > CC: Andrey Vagin <avagin@openvz.org>
> > CC: Andrew Morton <akpm@linuxfoundation.org>
> > CC: Pavel Emelyanov <xemul@virtuozzo.com>
> > CC: Michael Kerrisk <mtk.manpages@gmail.com>
> > CC: Yang Shi <yang.shi@linux.alibaba.com>
> > CC: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> and fingers crossed that we haven't grown other users outside of CRIU
> which is quite bound to specific kernels AFAIK.

Surely.
