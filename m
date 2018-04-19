Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeDSSKu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:10:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753176AbeDSSKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:10:48 -0400
Date: Thu, 19 Apr 2018 21:10:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_ring: switch to dma_XX barriers for rpmsg
Message-ID: <20180419210843-mutt-send-email-mst@kernel.org>
References: <1524159181-351878-1-git-send-email-mst@redhat.com>
 <5047d08c-9f9e-2902-d425-1fac849ce5b4@redhat.com>
 <20180419204017-mutt-send-email-mst@kernel.org>
 <524fb400-2325-f60b-7e03-15be01888afc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524fb400-2325-f60b-7e03-15be01888afc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 07:48:24PM +0200, Paolo Bonzini wrote:
> On 19/04/2018 19:46, Michael S. Tsirkin wrote:
> >> This should be okay, but I wonder if there should be a virtio_wmb(...)
> >> or an "if (weak_barriers) wmb()" before the "writel" in vm_notify
> >> (drivers/virtio/virtio_mmio.c).
> >>
> >> Thanks,
> >>
> >> Paolo
> > That one uses weak barriers AFAIK.
> > 
> > IIUC you mean rproc_virtio_notify.
> > 
> > I suspect it works because specific kick callbacks have a barrier internally.
> 
> Yes, that one.  At least keystone_rproc_kick doesn't seem to have a barrier.
> 
> Paolo

Maybe it's wrong or not used with virtio then.
This patch won't change anything with respect to that though.

-- 
MST
