Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756655AbeBPPlo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:41:44 -0500
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:37364 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756579AbeBPPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:41:39 -0500
Date: Fri, 16 Feb 2018 09:41:36 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore
 for percent
In-Reply-To: <20180215201405.GA22948@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1802160940370.9660@nuc-kabylake>
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com> <20180214095911.GB28460@dhcp22.suse.cz> <alpine.DEB.2.10.1802140225290.261065@chino.kir.corp.google.com> <20180215144525.GG7275@dhcp22.suse.cz> <20180215151129.GB12360@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150947240.1902@nuc-kabylake> <20180215201405.GA22948@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfAy/Eh8ag4ief/aTMBH6+mIIvcP9bCzu1jFc+6ou/wPwAmiLCuA/vIfxv9pPGXSlAWB3o4MvCvsPiK6aVBW7+T4Pe2JYSc6srsLv2hn5iiOk2CTW3KSs
 XJCDXi6/BddpwhGOi3jSJlnM1x01eJyX7zsNWlWYDoNdGnwaqCtaffhtmlIhtT55DNz2GnLiHCYPHaGJkEbJVmcq7RfJAHn96BmVnS9HBtglpj5NwWR02xhg
 ZiYDPMlTtevZhkP6i1TJngP5+nRroIWIZgWMhTi+6swKjYoKZBEw7aV0bIWi+3ZgGH0/uCzNuCGgSfiis1hw1hgV2Sj/LOOjWJMK7WVXc2/Komy2tf+FxACC
 jok24xo5mHusMJD37lbhrpPpKDVQPGUlOLRGFD52wMWi3Sau0lCxJlSy6VSyuDI3vAoGG04kAV5VFw/epo2bV7/ZBxAzxg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Matthew Wilcox wrote:

> On Thu, Feb 15, 2018 at 09:49:00AM -0600, Christopher Lameter wrote:
> > On Thu, 15 Feb 2018, Matthew Wilcox wrote:
> >
> > > What if ... on startup, slab allocated a MAX_ORDER page for itself.
> > > It would then satisfy its own page allocation requests from this giant
> > > page.  If we start to run low on memory in the rest of the system, slab
> > > can be induced to return some of it via its shrinker.  If slab runs low
> > > on memory, it tries to allocate another MAX_ORDER page for itself.
> >
> > The inducing of releasing memory back is not there but you can run SLUB
> > with MAX_ORDER allocations by passing "slab_min_order=9" or so on bootup.
>
> Maybe we should try this patch in order to automatically scale the slub
> page size with the amount of memory in the machine?

Well setting slub_min_order may cause allocation failures. You would leave
that at 0 for a prod configuration. Setting slub_max_order higher would
work.
