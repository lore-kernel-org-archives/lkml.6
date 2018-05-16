Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbeEPKVg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:21:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:11739 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752449AbeEPKVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:21:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="56353691"
Date: Wed, 16 May 2018 18:21:59 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v4 5/5] virtio_ring: enable packed ring
Message-ID: <20180516102159.GA11467@debian>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-6-tiwei.bie@intel.com>
 <27dfb4e8-6d63-bf7d-0f97-ac51559f8040@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27dfb4e8-6d63-bf7d-0f97-ac51559f8040@cogentembedded.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 01:15:48PM +0300, Sergei Shtylyov wrote:
> On 5/16/2018 11:37 AM, Tiwei Bie wrote:
> 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >   drivers/virtio/virtio_ring.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index de3839f3621a..b158692263b0 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1940,6 +1940,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >   			break;
> >   		case VIRTIO_F_IOMMU_PLATFORM:
> >   			break;
> > +		case VIRTIO_F_RING_PACKED:
> > +			break;
> 
>    Why not just add this *case* under the previous *case*?

Do you mean fallthrough? Something like:

		case VIRTIO_F_IOMMU_PLATFORM:
		case VIRTIO_F_RING_PACKED:
			break;

Best regards,
Tiwei Bie

> 
> >    		default:
> >   			/* We don't understand this bit. */
> >   			__virtio_clear_bit(vdev, i);
> 
> MBR, Sergei
