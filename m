Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeDMWHu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 18:07:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751953AbeDMWHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 18:07:49 -0400
Date: Sat, 14 Apr 2018 01:07:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Helman <jonathan.helman@oracle.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_balloon: add array of stat names
Message-ID: <20180414010537-mutt-send-email-mst@kernel.org>
References: <1523627031-370966-1-git-send-email-mst@redhat.com>
 <8ac55da5-3c2b-a546-7597-ec6c82ff9590@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ac55da5-3c2b-a546-7597-ec6c82ff9590@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 11:53:31AM -0700, Jonathan Helman wrote:
> 
> 
> On 04/13/2018 06:44 AM, Michael S. Tsirkin wrote:
> > Jason Wang points out that it's vary hard for users to build an array of
> 
> s/vary/very
> 
> > stat names. The naive thing is to use VIRTIO_BALLOON_S_NR but that
> > breaks if we add more stats.
> > 
> > Let's add an array of reasonably readable names.
> 
> Thanks for doing this, this is goodness. Clients of this interface will now
> only require a modification to their internal copy of the header file (if
> they have one), rather than updating their string array as well.
> 
> > 
> > Fixes: 6c64fe7f2 ("virtio_balloon: export hugetlb page allocation counts")
> 
> I think this is a tad bit confusing since the only way you'd know why this
> patch "fixes" 6c64fe7f2 is by reading the LKML archives and finding Jason's
> comment.

So

... add more stats as recently by commit 6c64fe7f2 ("virtio_balloon: export hugetlb page allocation counts")




> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Jonathan Helman <jonathan.helman@oracle.com>, > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Reviewed-by: Jonathan Helman <jonathan.helman@oracle.com>
> 
> > ---
> >   include/uapi/linux/virtio_balloon.h | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> > 
> > diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> > index 9e02137..1477c17 100644
> > --- a/include/uapi/linux/virtio_balloon.h
> > +++ b/include/uapi/linux/virtio_balloon.h
> > @@ -64,6 +64,21 @@ struct virtio_balloon_config {
> >   #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
> >   #define VIRTIO_BALLOON_S_NR       10
> > +#define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "swap-out", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "major-faults", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "minor-faults", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "free-memory", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "total-memory", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
> > +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \ > +}
> > +
> > +#define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
> > +
> >   /*
> >    * Memory statistics structure.
> >    * Driver fills an array of these structures and passes to device.
> > 
