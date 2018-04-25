Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-74658-1524635428-2-17913423324095642746
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524635428; b=goP2xe6XqZ+FyE/xz+vNOQTNN5hhuPByELB7yd0OSYzEl7/5H5
    yud71iFeEiz9CI5mXWZUAmeS4Q/tZehrEmg8do6qh0fciMfcvWIZkoEgkhR+VbhJ
    wVeOqLJLYqAZII9gkBAp2jMlx8JUqSNaSQeaES5bQmy2Qj6SvhkyjtDQFsqnO5rN
    jHoYIBmPEfkk/u0TRt8uIMzAoBwWbepJHwIqu1BMCsiAumMzJN2UqeofFtB3lo1x
    xK9FMtp2aTr6TjSl1QRWmqusgM3YJAdXmE2BZev5Nd1vbgxf8VEi0cHMAOXzUQQ/
    V48XQf0sxpdogcEVbGMQgU1g+GqinoYFbiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524635428; bh=/d/eY22gOOVsSJgnyfKk8D4nazH0bu
    09jMKmhBZqTNk=; b=KR9ZQOtGB9N8J9JZoWR+RtEqI3+WOrJrcr580rJKFsh9ky
    3XeiQgX8oZc43qdSJ6D+3OlGHUZFbL94lV2ijksbHw2ZuVFA1PMc6T5fhVf7/1VI
    CicwIoHefBt7v2+1F7Os+RLuvjWjgJEYpVQdm25bpP9MlriIytEDlakya07PWPie
    cGAPW352kDXdE5uC3EQvjHed3jqAPXANrqqwtNW+YRWyT6AAAdRaU4WikO0D7V8X
    jFD9oJjT5l4v/4RKErdToNEbAF5ryEVnPrdiQFipp0W2dfqfkjOlMGDwn/3Nofoz
    apZAbGsebEQcSItDIKcIfr/7XL8taJq2fSS39OVA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC+HRSdNLaT0YLTFyXUIUc3NtpLRCPiTTgmJnxG65qsZa8GcjTCXOX3g0L0WRqSR8F9gkgqIb4dPhoU0ScvpKwgu87V/4Z+Eq2sjPTxe3w4BvcysWoEp
    hfwnkCVBzimGqzzVUCECnc8cc/GC3BtoliuZVdaSY/eQ5yOh0XZKWnliO2PRH6O+ox6WhwY1v1p6rPYJDMYglXwCdnW2Kft0UAEiJmzabD4n3E3fvypyh/tN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=FhJzGMl4X9cYfT0W5ksA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbeDYFuZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 01:50:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDYFuY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 01:50:24 -0400
Date: Wed, 25 Apr 2018 07:50:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/6] virtio_console: don't tie bufs to a vq
Message-ID: <20180425055016.GD30843@kroah.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <1524248223-393618-2-git-send-email-mst@redhat.com>
 <20180421073005.GA3744@kroah.com>
 <20180424215318-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424215318-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 09:56:33PM +0300, Michael S. Tsirkin wrote:
> On Sat, Apr 21, 2018 at 09:30:05AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 20, 2018 at 09:18:01PM +0300, Michael S. Tsirkin wrote:
> > > an allocated buffer doesn't need to be tied to a vq -
> > > only vq->vdev is ever used. Pass the function the
> > > just what it needs - the vdev.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/char/virtio_console.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index 468f061..3e56f32 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -422,7 +422,7 @@ static void reclaim_dma_bufs(void)
> > >  	}
> > >  }
> > >  
> > > -static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
> > > +static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
> > >  				     int pages)
> > >  {
> > >  	struct port_buffer *buf;
> > > @@ -445,16 +445,16 @@ static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
> > >  		return buf;
> > >  	}
> > >  
> > > -	if (is_rproc_serial(vq->vdev)) {
> > > +	if (is_rproc_serial(vdev)) {
> > >  		/*
> > >  		 * Allocate DMA memory from ancestor. When a virtio
> > >  		 * device is created by remoteproc, the DMA memory is
> > >  		 * associated with the grandparent device:
> > >  		 * vdev => rproc => platform-dev.
> > >  		 */
> > > -		if (!vq->vdev->dev.parent || !vq->vdev->dev.parent->parent)
> > > +		if (!vdev->dev.parent || !vdev->dev.parent->parent)
> > >  			goto free_buf;
> > > -		buf->dev = vq->vdev->dev.parent->parent;
> > > +		buf->dev = vdev->dev.parent->parent;
> > >  
> > >  		/* Increase device refcnt to avoid freeing it */
> > >  		get_device(buf->dev);
> > > @@ -838,7 +838,7 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
> > >  
> > >  	count = min((size_t)(32 * 1024), count);
> > >  
> > > -	buf = alloc_buf(port->out_vq, count, 0);
> > > +	buf = alloc_buf(port->portdev->vdev, count, 0);
> > >  	if (!buf)
> > >  		return -ENOMEM;
> > >  
> > > @@ -957,7 +957,7 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
> > >  	if (ret < 0)
> > >  		goto error_out;
> > >  
> > > -	buf = alloc_buf(port->out_vq, 0, pipe->nrbufs);
> > > +	buf = alloc_buf(port->portdev->vdev, 0, pipe->nrbufs);
> > >  	if (!buf) {
> > >  		ret = -ENOMEM;
> > >  		goto error_out;
> > > @@ -1374,7 +1374,7 @@ static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
> > >  
> > >  	nr_added_bufs = 0;
> > >  	do {
> > > -		buf = alloc_buf(vq, PAGE_SIZE, 0);
> > > +		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
> > >  		if (!buf)
> > >  			break;
> > >  
> > > -- 
> > > MST
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> 
> Thanks!
> I have some questions about this one:
> 
> Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
> Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
> Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
> Cc: <stable@vger.kernel.org> # 3.3.x
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> 1. what does the kernel version mean? can I omit it?

Did you read the document?, it explains that the version can be used to
say "this kernel version and newer"

> 2. so when I rebase to add the tag, this changes commit IDs for
>    following tags in the same tree, breaking their tags
>    in the process. Pretty annoying. Any idea how to do it better?

You only put tags there if you want me to pick up pre-requisite patches
that are already in Linus's tree.  If you have a patch series that all
needs to go into stable, just add the "cc: stable@" to the tags on all
of them and I'll pick them up in the correct order then.

hope this helps,

greg k-h
