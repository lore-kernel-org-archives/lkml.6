Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757080AbeEJKjL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:39:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:28913 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756780AbeEJKjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:39:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="227341512"
Date: Thu, 10 May 2018 18:39:41 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [PATCH v1] virtio: support VIRTIO_F_IO_BARRIER
Message-ID: <20180510103941.znxka65iluybktuq@debian>
References: <20180504045915.17693-1-tiwei.bie@intel.com>
 <20180510095317.GO1296@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510095317.GO1296@stefanha-x1.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 10:53:17AM +0100, Stefan Hajnoczi wrote:
> On Fri, May 04, 2018 at 12:59:15PM +0800, Tiwei Bie wrote:
> > diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> > index 308e2096291f..9fb519a9df28 100644
> > --- a/include/uapi/linux/virtio_config.h
> > +++ b/include/uapi/linux/virtio_config.h
> > @@ -49,7 +49,7 @@
> >   * transport being used (eg. virtio_ring), the rest are per-device feature
> >   * bits. */
> >  #define VIRTIO_TRANSPORT_F_START	28
> > -#define VIRTIO_TRANSPORT_F_END		34
> > +#define VIRTIO_TRANSPORT_F_END		37
> 
> Have you updated "2.2 Feature Bits" in the VIRTIO spec?
> 
> In 1.0 it says:
> 
>  24 to 32
>     Feature bits reserved for extensions to the queue and feature negotiation mechanisms
> 
> This information is out-of-date.
> 

No. In the latest spec draft, it's 24 to 33. And it
becomes out-of-date since VIRTIO_F_RING_PACKED(34)
and VIRTIO_F_IN_ORDER(35) were introduced. Do you
want me to update it in the IO_BARRIER patch or do
you want me to update it in a new patch?

Best regards,
Tiwei Bie
