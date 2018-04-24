Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3526914-1524596198-2-18356172331366828291
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524596197; b=OQ/3kSu3xP9rgZbrdEG9QUx2Eh0CqIVllCkNxa3QsNb70edgyv
    QFH+aOZso8V253DNnUqbEdO088igigSbIZJ8Gj+1YKurBv4Om64VRD7CrF6AH1cF
    dw9xT4KPnZfB9/4dIhTxkXnp5oD5ODCa1OEdSiMY7J6YSYiHRSK2QsF/EhcJJpJE
    hCFjO31rTufzm0lBQK6l2/xz6O/uK2AyNLOoYM+nOcS+0c0NmXaQ6PLLj1oj7dXS
    qNl9eS6+aeiDdNfTR1Qc9Tp010bve2sEzqqdCl8tg5ResweFncHflr7z0xuS+1bd
    0mwuUUBMUXhupS/diokznHs+H6n5P3CFwxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524596197; bh=ay7xTKjgljNZbLfINukKzzOfOoCux4
    rt9O7HcIgdovo=; b=mZhci0OD5witddexjHOyrE+UPO1Fs5Ke7UILtwtCuCAGl8
    WhEBo2KTGQmsqhT7r6n//2biG53pSwPnlccCaovN7panA/EqQRWOqUD9L3tovWvo
    fhbJcL6uSRYRESRZH6o2rswwNAngKa1wxvV4j+Pw5X2SjvmvssUcapLZUCQP7PnQ
    3l+1iN3ZJBhG1Lh5OFsVto6hOHteM+RJjTa47SMvNVKJcxXvb9iCp1iHsLEfUxht
    46V081553VKCy7W690KhyNw+tZTI/e0SOMoNVzDd/pwfVAx4sd39oJDrNQMiaAUz
    6zw5VQW/54VcFumsWjLN9MpDnh/fbr6Jv8YjlyGA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM/QmajxztcNH/o6RpqRdr8rzzJtPeT/+pGzpWj9pYqreK1D4l4Km4jIP0z3CjFP9yqjo98r3IbyMAiLnmhfR27WtdL3PwEuh1dtJ51CzLIUFQHz1zJ4
    5G48vnOsZm+oy/NSaazheNdU7vAHW4WhhIjzrcXs34aHbE9CiPop8KXIjEOsrJUVuzOIC8nqLE6CkQZBiGvw7J6XnBee0U49zmwpQSDy3QJfXBetayPvB1s4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=rnL2N6uKv6O_ozl2i_4A:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeDXS4f (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 14:56:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752049AbeDXS4f (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 14:56:35 -0400
Date: Tue, 24 Apr 2018 21:56:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/6] virtio_console: don't tie bufs to a vq
Message-ID: <20180424215318-mutt-send-email-mst@kernel.org>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <1524248223-393618-2-git-send-email-mst@redhat.com>
 <20180421073005.GA3744@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421073005.GA3744@kroah.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 09:30:05AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 20, 2018 at 09:18:01PM +0300, Michael S. Tsirkin wrote:
> > an allocated buffer doesn't need to be tied to a vq -
> > only vq->vdev is ever used. Pass the function the
> > just what it needs - the vdev.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/char/virtio_console.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 468f061..3e56f32 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -422,7 +422,7 @@ static void reclaim_dma_bufs(void)
> >  	}
> >  }
> >  
> > -static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
> > +static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
> >  				     int pages)
> >  {
> >  	struct port_buffer *buf;
> > @@ -445,16 +445,16 @@ static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
> >  		return buf;
> >  	}
> >  
> > -	if (is_rproc_serial(vq->vdev)) {
> > +	if (is_rproc_serial(vdev)) {
> >  		/*
> >  		 * Allocate DMA memory from ancestor. When a virtio
> >  		 * device is created by remoteproc, the DMA memory is
> >  		 * associated with the grandparent device:
> >  		 * vdev => rproc => platform-dev.
> >  		 */
> > -		if (!vq->vdev->dev.parent || !vq->vdev->dev.parent->parent)
> > +		if (!vdev->dev.parent || !vdev->dev.parent->parent)
> >  			goto free_buf;
> > -		buf->dev = vq->vdev->dev.parent->parent;
> > +		buf->dev = vdev->dev.parent->parent;
> >  
> >  		/* Increase device refcnt to avoid freeing it */
> >  		get_device(buf->dev);
> > @@ -838,7 +838,7 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
> >  
> >  	count = min((size_t)(32 * 1024), count);
> >  
> > -	buf = alloc_buf(port->out_vq, count, 0);
> > +	buf = alloc_buf(port->portdev->vdev, count, 0);
> >  	if (!buf)
> >  		return -ENOMEM;
> >  
> > @@ -957,7 +957,7 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
> >  	if (ret < 0)
> >  		goto error_out;
> >  
> > -	buf = alloc_buf(port->out_vq, 0, pipe->nrbufs);
> > +	buf = alloc_buf(port->portdev->vdev, 0, pipe->nrbufs);
> >  	if (!buf) {
> >  		ret = -ENOMEM;
> >  		goto error_out;
> > @@ -1374,7 +1374,7 @@ static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
> >  
> >  	nr_added_bufs = 0;
> >  	do {
> > -		buf = alloc_buf(vq, PAGE_SIZE, 0);
> > +		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
> >  		if (!buf)
> >  			break;
> >  
> > -- 
> > MST
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>


Thanks!
I have some questions about this one:

Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
Cc: <stable@vger.kernel.org> # 3.3.x
Signed-off-by: Ingo Molnar <mingo@elte.hu>

1. what does the kernel version mean? can I omit it?
2. so when I rebase to add the tag, this changes commit IDs for
   following tags in the same tree, breaking their tags
   in the process. Pretty annoying. Any idea how to do it better?

Thanks!

-- 
MST
