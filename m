Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBPSak (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:30:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeBPSai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:30:38 -0500
Date: Fri, 16 Feb 2018 10:30:32 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, mhocko@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, david@redhat.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cornelia.huck@de.ibm.com, mgorman@techsingularity.net,
        aarcange@redhat.com, amit.shah@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com
Subject: Re: [PATCH v21 1/5] xbitmap: Introduce xbitmap
Message-ID: <20180216183032.GA7439@bombadil.infradead.org>
References: <1515496262-7533-1-git-send-email-wei.w.wang@intel.com>
 <1515496262-7533-2-git-send-email-wei.w.wang@intel.com>
 <CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve-1-TOVJUZ4anhwkkeq-RhpSg3EmN3N0r09rj6sFrQZQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 07:44:50PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 9, 2018 at 1:10 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> >
> > The eXtensible Bitmap is a sparse bitmap representation which is
> > efficient for set bits which tend to cluster. It supports up to
> > 'unsigned long' worth of bits.
> 
> >  lib/xbitmap.c                            | 444 +++++++++++++++++++++++++++++++
> 
> Please, split tests to a separate module.

Hah, I just did this two days ago!  I didn't publish it yet, but I also made
it compile both in userspace and as a kernel module.  

It's the top two commits here:

http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-2018-02-12

Note this is a complete rewrite compared to the version presented here; it
sits on top of the XArray and no longer has a preload interface.  It has a
superset of the IDA functionality.
