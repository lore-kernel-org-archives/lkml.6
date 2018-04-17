Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeDQVm3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:42:29 -0400
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:56454 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752606AbeDQVm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:42:27 -0400
Date: Tue, 17 Apr 2018 16:42:24 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Vlastimil Babka <vbabka@suse.cz>, Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: slab: introduce the flag SLAB_MINIMIZE_WASTE
In-Reply-To: <alpine.LRH.2.02.1804171453190.26973@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.DEB.2.20.1804171641390.20702@nuc-kabylake>
References: <alpine.LRH.2.02.1803201740280.21066@file01.intranet.prod.int.rdu2.redhat.com> <20c58a03-90a8-7e75-5fc7-856facfb6c8a@suse.cz> <20180413151019.GA5660@redhat.com> <ee8807ff-d650-0064-70bf-e1d77fa61f5c@suse.cz> <20180416142703.GA22422@redhat.com>
 <alpine.LRH.2.02.1804161031300.24222@file01.intranet.prod.int.rdu2.redhat.com> <20180416144638.GA22484@redhat.com> <alpine.LRH.2.02.1804161054410.17807@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804161018030.9397@nuc-kabylake>
 <alpine.LRH.2.02.1804161123400.17807@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804161043430.9622@nuc-kabylake> <alpine.LRH.2.02.1804161532480.19492@file01.intranet.prod.int.rdu2.redhat.com> <b0e6ccf6-06ce-e50b-840e-c8d3072382fd@suse.cz>
 <alpine.LRH.2.02.1804161650170.7237@file01.intranet.prod.int.rdu2.redhat.com> <alpine.DEB.2.20.1804170939420.17557@nuc-kabylake> <alpine.LRH.2.02.1804171453190.26973@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfG/fpMw6Cw8ILmhCUDJYYkNMkvXlq6fiFv51mJUUpMvpOTQN0hErqggbJJnnzWwqii8btbLqiKJ71Jh/TQbitLnEZyMhmN2+GLQRopJQPc5CoKWimw6m
 RNiogn3LM9YKVbFL7TEoGILHGdM9AyDBJooQpW1bdQEoZ4+SIR5EuOGAyX5lfIil1Y3SsFBmM2M5/f6kgRhucy/L6REwGRRx/SvAkKzRQ4dX6t3OcucyUhZT
 iQTBdhX2Kz0HYE0+uYSHjUIurZu8FQWEo+YhrqyJxFsKDf2oBjtjTFaRWgV+LAg2vVeS8LHnPl3pQ/IHfVAi84+RFbEgr25cnFu4e9f0xaMTC1DPLBoVpMTP
 VYpzMW5RVWEv/g+SCdtx9QORJOj3bLGokuGlg/yvzLnuUjWOd5pFq8Z+QZ/9Gjet3YpSZSEeqAReYxpfeOvv71vrnUB7M/NvxQjxysYB8qMJAbFKSKGIEh83
 yObConGvn3Y4YUkv
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018, Mikulas Patocka wrote:

> > > The slub subsystem does actual fallback to low-order when the allocation
> > > fails (it allows different order for each slab in the same cache), but
> > > slab doesn't fallback and you get NULL if higher-order allocation fails.
> > > So, SLAB_MINIMIZE_WASTE is needed for slab because it will just randomly
> > > fail with higher order.
> >
> > Fix Slab instead of adding a flag that is only useful for one allocator?
>
> Slab assumes that all slabs have the same order, so it's not so easy to
> fix it.

Well since SLAB uses compound pages one could easily determine the order
of the page and thus also support multiple page orders there.
